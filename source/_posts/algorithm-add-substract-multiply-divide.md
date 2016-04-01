title: '用位操作符实现四则运算'
tags:
  - algorithm
  - bit-manipulate
  - 4-Arithmetic-Operations
categories:
  - Dev
  - Algorithm
date: 2016-03-21 18:10:32
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 描述 ##

如何使用位操作分别实现整数的加减乘除四种运算呢？

常用到的位操作：

1, 等式： **-n = ~(n - 1) = ~n + 1**

2, 获取整数n的二进制中最后一个1： **n & (-n) 或者 n & ~(n - 1)**

> 如 n = 010100，则 -n = 101100，n & (-n) = 000100

3, 去掉整数n的二进制中最后一个1： **n & (n-1)**

> 如：n = 010100，n-1 = 010011，n & (n-1) = 010000

<!-- more --> 

## 加法 ##

可以利用“异或”操作实现整数加法运算：
对应位数的“异或操作”可得到该位的数值，对应位的“与操作”可得到该位产生的高位进位，如：a =  010010，b = 100111，计算步骤如下：

第一轮：a ^ b= 110101，(a & b) << 1 = 000100， 由于进位（000100）大于0，则进入下一轮计算，a = 110101，b = 000100，a ^ b = 110001，(a & b) << 1= 001000，由于进位大于0，则进入下一轮计算：a = 110001，b = 001000，a ^ b = 111001，(a & b) << 1 = 0，进位为0，终止。计算结果为：111001。

```
// C++

int Maths::add(int a, int b)
{
	if (!b) return a;  // 没有进位
	int sum = a ^ b;  // 不计进位的和
	int carry = a & b;  // 进位
	carry <<= 1;
	return add(sum, carry);
}
```

**非递归**

```
int add(int a, int b)
{
	int sum;
	while (b)
	{
		sum = a ^ b;  // 不带进位
		b = ((a & b) << 1);  // 进位
		a = sum;
	}
	return sum;
}
```

## 减法 ##

减法可很容易地转化为加法：a - b = a + (-b) = a + (~b + 1 )

即，取减数的补码再相加 1

1. 负数的补码：原码取反加1
2. 正数的补码：原码

```
// C++
int substract(int a, int b)
{
	int complement = add(~b, 1); 
	return add(a, complement);
}
```

## 乘法 ##

```
	111		(7)
  * 101		(5)
---------------
	111		(00111) 7 向左移动 0 位：111
   000		(00000) 7 向左移动 1 位：1110
  111		(11100) 7 向左移动 2 位：11100
---------------
  100011	(35)
```

1. b 的第0 位，为1，则结果加上 111，因为 1 * （111） = 111
2. b 的第2 位，为0，则结果加上 0000，因为 0 * (1110) = 0000
3. b 的第3 位，为1，则结果加上 11100，因为 1 * (11100) = 11100

可以看到，**b 每向右移一位，a 就要向左移动一位。**

```
//C++
int multiply(int a, int b)
{
	bool isNegtive = (a < 0) ^ (b < 0);  // 决定结果的正负
	int ans = 0;
	if (b < 0) b = -b;  // 负数转化为正数计算
	if (a < 0) a = -a;
	while (b)
	{
		if (b & 1) ans = add(ans, a); // 从右至左取 b 的二进制中的 1 （即右移）
		a <<= 1;
		b >>= 1;
	}
	return isNegtive ? -ans : ans;
}
```

## 除法 ##

除法就是由乘法的过程逆推，依次减掉（如果a 够减）b^(2^31), b^(2^30), ..., b^8, b^4, b^2, b^1。

**b 减掉相应数量，则结果需加上相应的数量。**

```
// C++
int divide(int a, int b)
{
	if (b == 0) return 0;
	bool isNegtive = (a < 0) ^ (b < 0);
	if (b < 0) b = -b;
	if (a < 0) a = -a;
	int ans = 0;
	for (int i = 31; i > 0; --i)
	{
		if ((a >> i) >= b)
		{
			a = substract(a, (b << i));
			ans = add(ans, (1 << i));
		}
	}
	return isNegtive ? -ans : ans;
}
```

END.

[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/