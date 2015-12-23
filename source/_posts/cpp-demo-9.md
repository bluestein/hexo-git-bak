title: 'Cpp Code: ex7.3 - 7.6'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-12-23 19:03:42
---

### Exercise 7.3 ###

产生第一个参数的第二个参数次幂的值

```C++
int pow(int base, int power) 
{
	int i = 0, result = 1;
	while (i < power) 
	{
		result *= base;
		++i;
	}
	return result;
}
```

<!-- more -->

### Exercise 7.4 ###

返回一个数的绝对值

```C++
int abs(int v) 
{
	if (v < 0)
	{
		return -v;
	}
	return v;
}
```

### Exercise 7.5 ###

两个形参，一个int型，另一个int型指针，返回值较大的数值。

```C++
int biggerOne(int v, const int *ip)
{
	int biggerOne = v > *ip ? v : *ip;
	ip = 0;
	return biggerOne;
}
```

### Exercise 7.6 ###

交换两个int指针所指对象的值

```C++
void pSwap(int *p1, int *p2)
{
	int temp = *p1;
	*p1 = *p2;
	*p2 = temp;
}
```

### Bonus ###

利用引用交换两个数的值（跟ex 7.6一样的效果）

```C++
void rSwap(int &v1, int &v2)
{
	int temp = v1;
	v1 = v2;
	v2 = temp;
}
```

> 利用引用型的形参，可以解决函数只能返回一个值得情况

### Bonus ###

交换指向数值的指针

```C++
void prSwap(int *&v1, int *&v2)
{
	int *temp = v1;
	v1 = v2;
	v2 = temp;
}
```