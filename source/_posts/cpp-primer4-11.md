title: '指针'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-21 16:49:49
---

指针跟迭代器类似，也可以对指针进行 **解引用**（`*`） 和 **自增**（`++`） 操作，其含义和迭代器类似。

指针用于指向对象，与迭代器类似，指针提供对其所指对象的间接访问。不同在于：指针指向单个对象，而迭代器只能访问容器内的元素。具体来说，指针保存的是另一个对象的地址：

<!-- more -->

```C++
string s("hello");
string *p = &s;		//指针 p 保存 s 的地址
```

`&` 是取地址符号，该符号只能用于左值。只有变量作为左值时，才能取其地址。

### 1、指针的定义和初始化 ###
---

```C++
vector<int> *vp;	//指向 vector<int> 对象的指针
int *ip;			//指向 int 对象的指针
string *sp; 		//指向 string 对象的指针
```

**另一种风格的指针**

```C++
int* ip;
```

但容易引起误解，会认为 `int*` 是一种类型。但下例只有 `ip1` 是指针，`ip2` 是普通的整型变量

```C++
int* ip1, ip2;
```

**指针的取值**

```C++
int val = 1024;
int *ip1 = 0;		//ip1 不指向任何对象
int *ip2 = &val;	//ip2 指向val
int *ip3;			//ip3 未初始化
ip1 = ip2;			//ip1 指向 val
ip2 = 0;			//ip2 不指向任何对象
```

> 避免使用未初始化的指针

**初始化的约束**

对指针初始化或赋值只能使用下列四种类型的值：

- 0常量表达式(编译时能获得0值得const对象或字面值常量0)；
- 类型匹配的对象的地址；
- 另一对象之后的下一地址；
- 同一类型的另一有效指针；

举例：

```C++
int ival = 1;
double dval = 1.5;
int zero = 0;
const int czero = 0;
int *ip;
double *dp;

ip = ival;		//error
ip = zero;		//error
ip = czero;		//ok：编译时可以获得 0
ip = 0；			//ok：字面值常量 0
ip = &ival;		//ok

dp = ip;		//error：类型不匹配
```	

当然 0 值还可以使用从C语言继承下来的预处理器变量 `NULL`，它在 cstdlib 头文件中定义，其值为 0。

```C++
int *ip = NULL;	//相当于 int *ip = 0;
```
> `NULL` 不是标准库中定义的，所以不需要 `std::`。

**void\*指针**

void* 指针可以保存任何类型对象的地址：

```C++
double dval = 3.14;
double *dp = &dval;
void *vp = &dval;	//ok
vp = dp;			//ok
```

但 void* 指针只允许有限的操作：

- 与另一指针比较；
- 向函数传递 void* 指针，或函数返回 void* 指针；
- 给另一个 void* 指针赋值。

> 不允许 void* 指针操作所指向的对象。

### 3、指针的操作 ###
---

**\*操作符**

```C++
string s1("hello");
string s2("world")；
string *sp = &s1;
cout << *sp << endl;	//解引用
sp = &s2;				//改变指针所指对象
cout << *sp << endl;	//解引用
*sp = "hello world";	//改变所指的内容
cout << *sp << endl;	//解引用
```

输出结果：

```C++
hello
world
hello world
```

对 `sp` 的解引用可以获得 `s` 的值，因为 `sp` 指向 `s`，所以给 `*sp` 赋值可以改变 `s` 的值。

**指针和引用的比较**

虽然引用（reference）和指针都可以间接访问另一个值，但有区别：

- 定义引用时没有初始化时错误的；
- 赋值行为的差异：给引用赋值修改的是该引用所关联的对象的值，并不是与另一个对象关联；
- 引用一经初始化，就始终指向同一个特定的对象

指针的例子

```C++
int ival1 = 1024, ival2 = 2048;
int *ip1 = &ival1, *ip2 = &ival2;
ip1 = ip2;		//ip1 此时指向 ival2
```

而引用的例子

```C++
int &r1 = ival1; int &r2 = ival2;
r1 = r2;		//将 ival2 赋给 ival1
```

上面的修改只会修改引用所关联的对象，并不会改变改变引用本身。并且修改后，两个引用还是指向原来关联的对象。

**指向指针的指针**

指针本身也是需要占内存的对象，所以指针也可以被指针访问。

```C++
int ival = 1024;
int *ip = &ival;
int **ipp = &ip;
cout << ival << endl;
cout << *ip << endl;
cout << **ipp << endl;
```

结果

```C++
1024
1024
1024
```

可以用三种方式输出ival的值。

最后举一个例子

```C++
int i = 10, j =10;
int *p1 = &i, *p2 = &j;
cout << *p1 << endl;
cout << *p2 << endl;
*p2 = *p1 * *p2;			//改变 p2 所指的内容
cout << *p1 << endl;
cout << *p2 << endl;
*p1 *= *p1;				//改变 p1 所指的内容
cout << *p1 << endl;
cout << *p2 << endl;
```

结果

```C++
10
10
10
100
100
100
```

### 4、使用指针访问数组 ###
---

指针与数组密切相关。特别是在表达式中使用数组名时，改名字会自动转换为指向数组第一个元素的指针：

```C++
int val[] = {0, 1, 2, 3};
int *p = val;	//p 指向 val[0]
p = &val[3];	//p 指向 val[3]
```

**指针的算术运算**

上面的 `p = &val[3];` 使用下标操作，也可以通过 **指针的算术操作（pointer arithmetic）** 来获取指定的地址：

```C++
p = val;			//p 指向 val[0]
int *p2 = p + 3;	//p2 指向 val[3]
```

> 指针的算术操作只有在计算过后的新指针还是指向同一数组的元素才算合法，且不能越界，比如上面 `int *p2 = p + 3;` 改成 `int *p2 = p + 4;` 就会出错，因为数组 `val` 的大小为 4，最大的下标为 3。

两个指针之间还可以做减法

```C++
ptrdiff_t n = p2 - p1;	//n = 3
```

`p1` 和 `p2` 之间相差3个对象，所以 `n = 3`。 `n` 是标准库类型（library type） **ptrdiff_t** 类型。与 size_t 类型一样，ptrdiff_t 也是一种与机器相关类型，在cstddef头文件中定义。

允许在指针上加减 0，使指针保持不变。

**解引用和指针算术操作之间的相互作用**

在指针上加上一个整数值，其结果仍是指针。允许在这个结果上直接进行解引用操作，而不必先把它赋给一个新的指针：

```C++
int last = *(val + 3);	//相当于 val[3]
```

需要写括号，如果写成 `int last = *val + 3;` 则相当于 `val[0] + 3`。

**下标和指针**

使用下标访问数组时，它实际上是使用下标访问指针：

```C++
int val[] = {0,1,2,3,4};
int i = val[0]	//val 指向数组 val[] 的第一个元素
```

另一个例子

```C++
int *p = &val[2];	//ok: p 指向第二个元素
int j = p[1];		//ok: p[1] 相当于 *(p + 1), j = val[3]
int k = p[-2];		//ok: p[-2] 相当于 val[0]
```

**计算数组的超出末端指针**

vector 类型提供的end操作将返回指向超出 vector 末端位置的一个迭代器。类似的，可以计算数组的超出末端指针的值：

```C++
const size_t arr_size = 5;
int arr[arr_size] = {1,2,3,4,5};
int *p = arr;
int *p2 = p + arr_size;	//ok:超出末端的指针
```

> C++允许计算数组或对象的超出末端的地址，但不允许对此地址进行解引用操作。而计算数组超出末端之后或数组首地址之前的地址都是不合法的。

`p2` 不能解引用操作，但能与其他指针比较，或者用作指针算术表达式的操作数。

**输出数组元素**

```C++
const size_t arr_size = 5;
int arr[arr_size] = {1,2,3,4,5};
for (int *begin = arr, *end = arr + arr_size; begin != end; ++begin){
	cout << *begin << "," << endl;
}
```

> 指针是数组的迭代器。上面的程序与迭代器程序非常相似，事实上，内置类型具有标准库容器的许多性质，指针就是数组的迭代器。

### 5、指针与const限定符 ###
---

两种类型：

- 指向const对象的指针；
- const指针；

**指向const对象的指针**

如果指针指向的是const对象，则不再能够使用指针来修改对象的内容。为了保证这个特性，C++语言强制要求指向const对象的指针也必须具有const特性：

```C++
const double *cdp;
```

`cdp` 是指向一个double类型const对象的指针，const限定了 `cdp` 指针所指向的对象，而并非 `cdp` 本身。即 `cdp` 不是const类型，在定义时不一定需要给它初始化；如果有需要的话，允许给 `cdp` 重新赋值，使其指向另一个const对象，但不能通过 `cdp` 修改所指对象的值：

```C++
*cdp = 2;	//error: *cdp might be const
```

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

**const指针**

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

**指向const对象的const指针**

```C++
const double pi = 3.14159;
const double *const cdcp = &pi;
```

上面的意思是既不能修改 `pi` 的值，也不能修改 `cdcp` 所指的对象。

**指针和typedef**

在typedef中使用指针往往会带来意外的结果，下面是一个几乎所有初学者都会搞错的问题：请问 `cstr` 变量是什么类型？

```C++
typedef string *sp;
const sp cstr;
```

简单的回答是：const sp 类型的指针。进一步：const sp 所表示的真实类型是什么？可能会认为是

```C++
const string *cstr;	//error
```

但这是错误的，原因是：声明const sp时，const修饰的是 sp 类型，而 sp 是一个指针。所以等价于

```C++
string *const cstr;
```

> 理解const声明：

```C++
//s1 和 s2 都是const
string const s1;
const string s2;
```

用typedef写const类型定义时，const限定符加在类型前面容易引起误解

```C++
string s;
typedef string *sp;
//下面三种定义时等价的
const sp cstr1 = &s;	//容易误解
sp const cstr2 = &s;
string *const cstr3 = &s;
```

---

举例

```C++
int i = -1;
const int ic = i;				//ok
const int *pic = &ic; 			//ok
int *const cpi = &ic;			//error
const int *const cpic = &ic;	//ok
```

END.