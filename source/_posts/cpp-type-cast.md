title: '类型转换'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-10-25 16:50:29
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

如：

```C++
	int val;
	val = 3.14 + 3;	//val = 6
```

上面称为 **隐式类型转换**。

<!-- more -->

### 发生隐式转换 ###

- 混合表达式中，操作数被转化为相同类型

	```C++
	int iv;
	double dv;
	iv += dv;	//iv会被转换为double
	```

- 作为条件表达式转换为bool

	```C++
	int val;
	if(val)	//int to bool
	while(cin)	//cin to bool
	```

- 用表达式初始化某变量，该表达式结果被转换为该变量的类型

	```C++
	int iv = 3.14;	//3.14 to int
	```

### 算术转换 ###

**signed 与 unsigned 类型间的转换**

- 如果包含 short 和 int 类型的表达式，short 转换为int。如果 int 足够表示所有 unsigned short ，则将 unsigned short 转换为 int。

- long 和 unsigned int 转换也一样，如果 long 足够表示所有 unsigned int ，则将 unsigned int 转换为 long。

> 在32机器中，long和int通常使用一个字长表示，因此包含 unsigned int 和 long 类型的表达式，都应该转换为 unsigned long

- signed 和 unsigned int，signed转换成 unsigned int。

**举例**

```C++
bool bv;
char cv;
short siv;
unsigned short usiv;
int iv;
unsigned int uiv;
long lv;
unsigned long ulv;
float fv;
double dv;
3.14L + 'a';	//'a' 先转换成 int，再转换成double
dv + iv;	//iv to double
dv + fv;	//fv to double
iv = dv;	//dv to(截断) int
bv = dv;	//if dv=0, bv = false, else bv = true
cv + fv;	//cv to int, then, int to float
siv + cv;	//siv and cv to int
cv + lv;	//cv to long
iv + ulv;	//iv to unsigned long
usiv + iv;	//依赖于 unsigned short 和 int 的大小
uiv + lv;	//依赖于 unsigned int 和 long 的大小
```

### 其他隐式转换 ###

**指针转换**

使用数组时，大多数情况下数组都会自动转化为指向第一个元素的指针

```C++
int ia[10];	//数组
int *ip = ia;	//转化成指向第一个元素的指针
```

还有另外两种指针转换：

- 指向任意数据类型的指针都能够转化成 void*类型；
- 整型字面常量值 0 可以转换为任意指针类型；

**转换为bool类型**

算术值和指针纸都可以转为bool类型。如果指针或算术值为0，则其bool值为false，其他则为true：

```C++
if (cp)	/*...*/ //true if not zero
while(*cp)	/*...*/ //convert char to bool
```

while 语句对 `cp` 解引用，如果结果为 null ，则转化成false，否则转化成true

**算术类型与bool类型的转换**

可将算术类型转换成bool型，也可将bool型转换成int型。算术类型转bool时，0转换成false，其他转换成true；bool转int时，true转成1，false转成0。

```C++
bool b = true;
int ival = b;	//ival == 1
double pi = 3.14;
bool b2 = pi;	//b2 is true
pi = false; //pi == 0
```

**转化与枚举**

```C++
//p3 = 3; p4 = 4
enum points {p1 = 2, p3, p3 = 3, p4};
```

**转化为const类型**

使用非const对象初始化const对象的引用时，系统将非const对象转化成const对象。

```C++
int i;
const int ci = 0;
const int &j = i;	//ok: 将非const对象转化成const对象
const int *p = &ci;	//ok: 将非const对象的地址转化为指向const类型的指针
```

**由标准库类型定义的转换**

典型的例子就是

```C++
string s;
while(cin >> s)
```

该表达式 `cin>>s` 的结果 `cin` 对象，为istream对象，所以此时会将其转化成bool类型。

### 显式转换 ###

显式转换也称为**强制类型转换（cast）**，有以下操作符：static_cast, dynamic_cast, const_cast, reinterpret_cast。

**何时需要强制转换**

例如

```C++
double dval;
int ival;
ival *= dval;
```

上述程序首先会将 ival 转换为 double 型，乘法操作后又将double型的结果转成int型。为了避免不必要的转换，可以如下操作

```C++
ival *= static_cast<int>(dval);
```

**命名的强制类型转换**

形式如下

```C++
cast-name<type>(expression);
```

cast-name的选择有

- static_cast: 编译器隐式执行的任何类型转换都可以通过 static_cast 显式完成
```C++
double d = 1.5;
char ch = static_cast<char>(d);
void *p = &d;
double *dp = static_cast<double*>(p);	//可以找回存在void*中的值
```
- dynamic_cast: 支持运行时识别指针或引用所指的对象。
- const_cast: 去掉表达式的const性质
```C++
const char *ccp;
char *cp = string_copy(const_cast<char*>(ccp));
//使string_copy接受const char*类型的参数
```
- reinterpret_cast: 通常为操作数的位模式提供较低层次的重新解释
```C++
int *ip;
char *cp = reinterpret_cast<char*>(ip);
```
cp 所指的真实对象时 int 类型，所以不能用来初始化 string 对象。

type表示目标类型，expression表示被转换的表达式。

> 避免使用强制类型转换

**旧式的强制转换**

```C++
char *cp = (char*) ip;
```

这种方式不容易错误跟踪，可视性差。

> C++仍旧支持旧式强制转换，但不推荐这样做。除非在C语言下，或旧式编译器上才使用。

END.

---

Github Pages同步更新
Github Pages: [Humooo's Blog][1]

[1]: http://bluestein.github.io/