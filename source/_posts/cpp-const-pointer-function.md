title: 'const与指针、函数'
tags:
  - Cpp
  - const
  - 指针
categories:
  - Dev
  - Cpp
date: 2016-03-05 09:23:05
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## const与指针 ##
---
两种类型：

- 指向const对象的指针；
- const指针；

**1. 指向const对象的指针**

如果指针指向的是const对象，则不再能够使用指针来修改对象的内容。为了保证这个特性，C++语言强制要求指向const对象的指针也必须具有const特性：

```C++
const double *cdp;
```

`cdp` 是指向一个double类型const对象的指针，const限定了 `cdp` 指针所指向的对象，而并非 `cdp` 本身。即 `cdp` 不是const类型，在定义时不一定需要给它初始化；如果有需要的话，允许给 `cdp` 重新赋值，使其指向另一个const对象，但不能通过 `cdp` 修改所指对象的值：

```C++
*cdp = 2;	//error: *cdp might be const
```
<!-- more -->

把一个const对象的地址赋给一个普通的、非const对象的指针也会导致编译错误：

```C++
const double pi = 3.14;
double *dp = &pi;			//error: dp is a plain pointer
const double *cdp = &pi;	//ok: cdp is a pointer to const
```

**不能使用 void\* 指针保存const对象的地址**，而必须使用const void*指针保存：

```C++
const int val = 2;
const void *cvp = &val;		//ok: cvp is const
void *vp = &val;			//error: val is const
```

允许将非const对象赋给指向const对象的指针，例如：

```C++
double dval = 3.14;
const double *cdp = &dval;	//ok: 但是不能通过指针 cdp 改变 dval 的值
```

尽管 dval 不是 const 对象，但任何企图通过指针 `cdp` 修改其值得行为都会导致错误。

事实上，也有办法通过指向const对象指针改变所指的非const对象的值：

```C++
double dval = 3.14;
const double *cdp = &dval;	//ok: 但是不能通过指针 cdp 改变 dval 的值
*cdp = 3.14159;				//error: 不能通过 cdp 改变所指对象的值
double *dp = &dval;			//ok：dp 可以指向非const对象
*dp = 3.14159;				//ok
cout << *cdp << endl;		//此时会输出：3.14159
```

> 可以这样理解指向const对象的指针：自以为指向const对象的指针。但并不能保证所指向的对象一定是const对象。

**2. const指针**

这种指针本身不能修改：

```C++
int ival = 0;
int *const icp = &ival;	//icp 是const指针
```

这样理解：`icp` 是指向int对象的const的指针。跟其他const对象类似，const指针的值不能修改，意思就是不能使 `icp` 指向其他对象。任何企图给const指针赋值的行为都会出错（即使是赋它本身的值也一样）：

```C++
icp = icp;	//error: icp is const
```

并且 **const指针在定义时必须初始化**。

const指针所指对象的值能否被该指针修改完全取决于该对象的类型，例如 `icp` 指向一个普通的非 const int 型的对象，则可以使用 `icp` 修改该对象的值：

```C++
*icp = 1;
```

**3. 指向const对象的const指针**

```C++
const double pi = 3.14159;
const double *const cdcp = &pi;
```

上面的意思是既不能修改 `pi` 的值，也不能修改 `cdcp` 所指的对象。



关于指针的其他内容，请参考本站文章[指针][primer-11]。

## const与函数 ##
---

**1. 用const修饰函数的参数**

如果参数作输出用，不论它是什么数据类型，也不论它采用“指针传递”还是“引用传递”，都不能加const 修饰，否则该参数将失去输出功能。const 只能修饰输入参数：

**如果输入参数采用“指针传递”，那么加 const 修饰可以防止意外地改动该指针，起到保护作用。**

例如 StringCopy 函数：

```c++
void StringCopy(char *destination, const char *source);
```

`source` 是输入参数，`destination` 是输出参数。给 `destination` 加上 const 修饰后，**如果函数体内的语句试图改动 source 的内容，编译器将指出错误。**

如果输入参数采用“值传递”，由于函数将自动产生临时变量用于复制该参数，则输入参数无需保护，所以不要加 const 修饰。

例如， void func(int x) 而不是 void func(const int x) 。同理，同理不要将函数 void fun2(A a) 写成 void func2(const A a)。其中 A 为用户自定义的数据类型。

对于非内部数据类型的参数而言，象 void func(A a) 这样声明的函数注定效率比较底。因为函数体内将产生A 类型的临时对象用于复制参数a，而临时对象的构造、复制、析构过程都将消耗时间。

**为了提高效率，可以将函数声明改为 void func(A &a)，因为“引用传递”仅借用一下参数的别名而已，不需要产生临时对象。但是函数 void func(A &a) 存在一个缺点:**

“引用传递”有可能改变参数a，这是我们不期望的。解决这个问题很容易，加const修饰即可，因此函数最终成为 void func(const A &a)。

以此类推，是否应将 void func(int x) 改写为 void func(const int &x)，以便提高效率？完全没有必要，因为内部数据类型的参数不存在构造、析构的过程，而复制也非常快，“值传递”和“引用传递”的效率几乎相当。

总结一下：

1. 对于非内部数据类型的输入参数，应该将“值传递”的方式改为“const 引用传递”，目的是提高效率。例如将 void func(A a) 改为 void func(const A &a)。
2. 对于内部数据类型的输入参数，不要将“值传递”的方式改为“const 引用传递”。否则既达不到提高效率的目的，又降低了函数的可理解性。例如 void func(int x) 不应该改为void func(const int &x)。

**2. 用const 修饰函数的返回值**

如果给以“指针传递”方式的函数返回值加 const 修饰，那么函数返回值（即指针）的内容不能被修改，**该返回值只能被赋给加const 修饰的同类型指针**。

如下语句将出现编译错误：

```
char *str = getString();
```

正确的用法是

```
const char *str = getString();
```

如果函数返回值采用“值传递方式”，由于函数会把返回值复制到外部临时的存储单元中，加const 修饰没有任何价值。

例如，不要把函数 int getInt(void) 写成 const int getInt(void)。同理不要把函数 A getA(void) 写成 const A getA(void)，其中 A 为用户自定义的数据类型。

如果返回值不是内部数据类型，将函数 A getA(void) 改写为 const A & getA(void) 的确能提高效率。但此时千万千万要小心，一定要搞清楚函数究竟是想返回一个对象的“拷贝”还是仅返回“别名”就可以了，否则程序会出错。

函数返回值采用“引用传递”的场合并不多，这种方式一般只出现在类的赋值函数中，目的是为了实现链式表达。

```
class A
{
public:
	A & operate = (const A &other); // 赋值函数
};

A a, b, c; // a, b, c 为 A 的对象
a = b = c; // 正常的链式赋值
(a = b) = c; // 不正常的链式赋值，但合法
```

如果将赋值函数的返回值加const 修饰，那么该返回值的内容不允许被改动。上例中，语句 a = b = c 仍然正确，但是语句 (a = b) = c 则是非法的。

**3. const 成员函数**

任何不会修改数据成员的函数都应该声明为 const 类型。如果在编写 const 成员函数时，不慎修改了数据成员，或者调用了其它非 const 成员函数，编译器将指出错误，这无疑会提高程序的健壮性。

以下程序中，类 Stack 的成员函数 GetCount 仅用于计数，从逻辑上讲 GetCount 应当为 const 函数。编译器将指出 GetCount 函数中的错误。

```
class Stack
{
public:
	void Push(int elem);
	int Pop(void);
	int GetCount(void) const; // const 成员函数
private:
	int m_num;
	int m_data[100];
};

int Stack::GetCount(void) const
{
	++m_num; // 编译错误，企图修改数据成员 m_num
	Pop(); // 编译错误，企图调用非 const 函数
	return m_num;
}
```
const 成员函数的声明看起来怪怪的：const 关键字只能放在函数声明的尾部，大概是因为其它地方都已经被占用了。

关于 const 函数的几点规则：

1. const 对象只能访问 const 成员函数,而非 const 对象可以访问任意的成员函数,包括 const 成员函数.
2. const 对象的成员是不可修改的,然而 const 对象通过指针维护的对象却是可以修改的.
3. const 成员函数不可以修改对象的数据,不管对象是否具有 const 性质.它在编译时,以是否修改成员数据为依据,进行检查.
4. 然而加上 mutable 修饰符的数据成员,对于任何情况下通过任何手段都可修改,自然此时的 const 成员函数是可以修改它的

该部分,参考[原文][const-function]

END.

[primer-11]: http://bluestein.github.io/2015/11/cpp-primer4-11/
[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[const-function]: http://www.cnblogs.com/Fancyboy2004/archive/2008/12/23/1360810.html