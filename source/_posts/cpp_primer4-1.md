title: '1: 快速入门'
tags:
- C++
- C++ primer
categories: 
- Dev
- C++
date: 2015-11-8 10:33:12
---

### 一、iostream（输入输出流） ###
---

**i**, **o**分别表示 `istream` （输入流） 和 `ostream`（输出流）；**stream**表示 `流`：随着时间顺序生成或消耗；合起来就是**iostream**（输入输出流）。

<!-- more -->

#### 1.1、4个IO对象 ####

- **cin**：标准输入；
- **cout**：标准输出；
- **cerr**：标准错误，通常用来输出警告和错误信息给程序使用者；
- **clog**：常用于输出程序执行时的一般信息；

（后两个第一次知道，逃


#### 1.2、例子 ####

```C++
#include <iostream>
	
int main()
{
	std::cout << "Enter two Numbers:" << std::endl;
	int val1, val2;
	std::cin>> val1 >> val2;
	std::cout << "The sum of " << val1 << " and " << val2
			<< " is " << val1+val2 << std::endl;
	return 0;
}
```

- 第一行告诉编译器要使用**iostream**库；
- 输出流（写入到流）：
	- 输出操作符 `<<` 将值写入到 `流`，即 `输出`。该操作符每次接受两个操作数：左操作数必须是ostream对象；右操作数是要输出的值；
	- C++中的每个表达式都会产生一个结果，就是说 `std::cout<<a;` 也会产生返回值，但输出操作符 `<<` 返回的是输出流本身，所以可以将多个输出连接在一起，形如 `std::cout<<a<<b;`；
- 输入流（读入到流）：跟输出流类似；
- `std` 表示使用*命名空间* **std**中定义的的名字；
- `endl` 称为操纵符(manipulator)，将它写入 `流` 时，具有换行的效果，并同时会刷新相关联的缓冲区(buffer)。通过刷新缓冲区，用户可以立即看到写入 `流` 中的输出；

### 二、控制结构 ###
---

#### 2.1、while语句和for语句 ####

问题：求1到10（包括10）的和？

**while语句：**

```C++
#include <iostream>
	
int main()
{
	int sum = 0, val = 1;
	while (val <= 10){
		sum += val;
		++val;
	}
	std::cout << "The sum of 1 to 10 inclusive is " << sum << std::endl;
	return 0;
}
```

- while语句的结构形式：`while (condition) while_body_statement;`。表示，通过测试 `condition` 为真时执行 `while_body_statement`，重复这一过程直到 `condition` 为假
	- `condition` 是一个可求值得表达式。如果结果非零，那么为**真**；如果结果为为零，则为**假**；
	- `<=` 表示**小于等于**操作符；
	- `sum += val;` 等价于 `sum = sum + val;`。类似的，`++val;` 等价于 `val = val + 1;`；

还有另一种情形：只对输入的值进行求和

```C++
#include <iostream>

   int main()
{
	int sum = 0, val;
	while (std::cin >> val){	//windows系统下输入 ctrl+z 可以作为文件结束符(end-of-file)
		sum += val;
	}
	std::cout << "The sum is " << sum << std::endl;
	return 0;
}
```

**for语句：**

```C++
#include <iostream>

int main()
{
	int sum = 0;
	for (int val = 1; val <= 10; ++val){
		sum += val;
	}
	std::cout << "The sum of 1 to 10 inclusive is " << sum << std::endl;
	return 0;
}
```

- for语句可以简化管理循环变量.不像在while语句中，需要 `val` 这样的值来控制循环。其执行流程为：
	- 1，创建 `val` 并初始化为1
	- 2，测试 `val` 是否小于或等于10
	- 3，如果 `val` 小于或等于10，执行for循环体：把 `val` 值加到 `sum` 变量中；否则，执行for语句体之后的语句
	- 4，`val` 加1
	- 5，重复第2~4步

#### 2.2、if语句 ####

假设这样一种情况：将用户输入的两个数作为上、下界，然后用上面的循环求和。这个时候我们就需要判定那个数值更大而作为上界，另一个作为下界。

```C++
#include <iostream>
	
int main()
{
	std::cout << "Enter two Numbers:" << std::endl;
	int val1, val2;
	std::cin>> val1 >> val2;
	int lower, upper;
	if (val1 <= val2) {
		lower = val1;
		upper = val2;
	} else {
		lower = val2;
		upper = val1;
	}
	int sum = 0;
	for (int val = lower; val <= upper; ++val){
		sum += val;
	}
	std::cout << "The sum of "<< lower << " to "<< upper <<" inclusive is " << sum << std::endl;
	return 0;
}
```

- 代码就不用多说了，一眼就能看出来

### 三、类的简介 ###
---

假设有书店问题：某书店以文件形式保存每一笔交易。每笔交易形式如：<br/>0-201-70353-x&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;&nbsp;&nbsp;&nbsp;24.99<br/>第一个元素是ISBN，第二个为销售册数，第三个为单价。店主定期查看这个文件，统计每本书的销售册数、总销售额以及平均售价。

#### 3.1、Sales_item类 ####

1. Sales_item对象上的操作
	- 加法 `+` ：将两个对象相加；
	- 输入 `>>` ： 读取一个对象；
	- 输出 `<<` ：输出一个对象；
	- 赋值 `=` ：将一个对象赋给另一个对象；
	- 对比 `?` ：对比两个对象是否属于同一本书（函数same_isbn）；

1. 初探成员函数

	成员函数是由类定义的函数，也称为**类方法**。如 `item1.same_isbn(item2)` 调用类Sales_item的成员函数same_isbn来对比 `item1` 和 `item2`。

> 注：标准库的头文件用尖括号 `<>` 括起来，非标准库用双引号 `""`。

END.