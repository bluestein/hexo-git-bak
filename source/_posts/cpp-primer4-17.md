title: 'Cpp:new & delete'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-27 16:50:24
---

### 动态创建对象的初始化 ###

```C++
int i(1024);
int *ip = new int (1024);	//*ip = 1024
string s(10, '9');	//s = "9999999999"
string *sp = new string(10, '9');	//*sp = "9999999999"
```

<!-- more -->

### 动态创建对象的默认初始化 ###

```C++
string *sp = new string;	//空string
int *ip = new int;	//未初始化
```

可以利用下列方式进行默认初始化

```C++
string *sp = new string();	//空string
int *ip = new int();	//0
```
	
### 撤销动态创建对象 ###

```C++
int i;
int *ip = &i;
string s("str");
double *dp = new double(3.14);
int *ip0 = 0;

delete s;	//error: s是非动态对象
delete ip;	//error: ip指向本地对象
delete dp;	//ok
delete ip0;	//ok: 但没什么意义
```

C++未明确定义如何释放非new分配的内存地址。

### delete后重设指针的值 ###

执行delete语句后，尽管指针变成未定义，但仍存放了之前所指对象的地址，称为 **悬挂指针（dangling pointer）** 。这种指针往往容易出错。

> 一旦delete指针，立即将其置为0，就可以避免悬挂指针。

### const对象的动态分配和回收 ###

```C++
const int *cip = new const int(1024);	//必须初始化，且不能再修改
```

如果有默认构造函数，则可以隐式初始化，如

```C++
const string *csp = new const string;
```

尽管不能改变const对象的值，但可撤销对象本身

```C++
delete cip;	//ok
cip = 0;
```

END.