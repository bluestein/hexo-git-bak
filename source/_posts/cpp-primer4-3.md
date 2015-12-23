title: 'Cpp:变量'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-10 16:31:28
---

### 首先 ###
---

考虑问题：`求2的3次方？`

最直接的想到的可能是：

<!-- more -->

```C++
#include <iostream>

int main()
{
	std::cout << "2 raised to the power of 3 is " << 2*2*2  << std::endl;
	return 0;
}
```

固然，此方法可以求出2的3次方；但是如果要求2的20次方的话不太可能去连续乘20次，此时的替代方法：

```C++
#include <iostream>

int main()
{
	int val = 2;//2为底
    int pow = 20;//20次方
    int result = 1;
    for(int i = 0; i != pow; ++i){
    	result *= val;
    }
    std::cout << "2 raised to the power of " << pow << " is " << result  << std::endl;
    return 0;
}
```

上面的 `val, pow, result 和 i` 都是变量。可以对数值进行存储、修改和查询。

### 1、什么是变量 ###
---

变量就是 **提供了程序可以操作的有名字的存储区**。

C++中每个变量都有特定的类型，类型确定了变量的 **内存大小**、**该内存能储存的值的取值范围** 及 **可应用于该变量的操作**。

- **左值（lvalue）**：左值可以出现在赋值语句的左或右边。如
    - `i = i + 1;`
- **右值（rvalue）**：右值只能出现在赋值语句的右边。如
    - 正确：`i = 1;`
    - 错误：`0 = 1;`

### 2、变量名 ###
---

变量名，即 **标识符(identifier)**。可以由 **字母、数字和下划线** 组成。

必须以 **字母或划线开头**，并且 **区分大小写**。

> C++语言本身没有限制变量名的长度，但考虑阅读和维护，变量名不应太长。

#### 2.1、C++关键字 ####

C++的关键字不能作为变量名，下面是C++的所有关键字

|C++关键字|-|-|-|-|
|-|-|-|-|-|
|asm |do |if |returen |try |
|auto |double |inline |short |typedef |
|bool |dynamic_cast |int |signed | typeid |
|break |else |long |sizeof |typename |
|case |enum |mutable |static |union |
|catch |explicit |namespace |static_cast |unsigned |
|char |export |new |struct |using |
|class |extern |operator |switch |virtual |
|const |false |private |template |void |
|continue |for |public |throw |wchar_t |
|default |friend |register |true |while |
|delete |goto |reinterpret_cast |- |- |

> 为了发个表格也真是拼了，再次呼吁简书 @简叔 支持嵌入 html code（渴望脸

除了上面的关键字，C++还保留了一些操作符的替代名

|C++操作符的替代名|-|-|-|-|-|-|-|-|-|-|
|--|
|and |and_eq |bitand |bitor |compl |not |not_eq |or |or_eq |xor |xor_eq|

> 除了关键字，C++标准也保留了一组标识符用于标准库。
> 标识符 **不能包含两个连续的下划线**、**下划线开头后面紧跟一个大写字母**。

#### 2.2、变量的命名习惯 ####

- 变量名一般用小写字母；如 `salary`，而不是 `Salary` 或 `SALARY`；
- 变量名一般用帮助记忆的名字。如 `salary` 而不是 `s`；
- 包含多个单词时，单词间添加一下划线，或内嵌单词的第一个字母大写。如 `my_salary` 或 `mySalary`；

> 不管你使用哪种命名习惯,但请保持一致!

### 3、定义对象 ###
---

```C++
int books_sold;//内置类型
double sales_price, avg_price;//内置类型
std::string title;//标准库定义的类型
Sales_item book;//类对象
```

int，double，std::string和Sales_item都是类型名。

#### 3.1、初始化 ####

两种初始化变量的形式：

```C++
int val(1024);//直接初始化
int val = 1024;//复制初始化
```

> 复制初始化和直接初始化有微妙的差别，后续详细讲解。现在只要知道，**直接初始化** 语法更灵活且效率更高

使用 `=` 初始化变量会很迷惑，因为会把 **初始化** 当成是 **赋值**。

> “初始化不是赋值”。
> 初始化是指创建变量并给它赋初始值，而赋值则是擦除对象当前的值并用新的值替代。

#### 3.2、使用多种方法初始化 ####

```C++
std::string title1 = "C++ Primer";
std::string title2("C++ Primer");
```

则title就有两种初始化的方式。但下面用计数器和一个字符初始化一个变量 `nines` 就只能使用 **直接初始化**：

```C++
std::string nines(5, '9'); //nines = "99999"
```

#### 3.3、初始化多个变量 ####

- 定义两个变量以上时，每个变量都可能有各自的初始化式。
- 可以用前面已定义的变量来初始化后面的变量。
- 已初始化变量与未初始化变量可以同时同意

如下

```C++
double salary = 9999.99, my_salary = salary*2 ;
int day, month(11), year = 2015;
day = 3;
```

#### 3.4、初始化变量的规则 ####

当定义变量而未初始化时，系统有时会帮我们

**内置类型变量的初始化**

内置类型变量是否自动初始化取决于 **变量定义的位置**。在函数体外定义的变量都初始化成0，函数体内的内置类型不自动进行初始化。

> 使用未初始化的变量是常见的程序错误，通常也难以发现。如果够幸运的话，程序不能正确运行；但有时程序在一部机器上能够正确的运行，而另一部却不行。所以要尽量避免变量未初始化。

**类类型的变量初始化**

每个类都定义了该类型的对象应该如何初始化。如前面提到的 `std::string` 就至少提供了两个构造函数（可以理解为初始化的方法）。

如果某个类未定义初始化函数，那它可以通过一个特殊的构造函数即 **默认构造函数** 来实现。如

```C++
std::string empty_str; //empty_str = "";
```
#### 3.5、声明和定义 ####

- 定义（definition）：用于变量分配存储空间，还可以为变量指定初始值。在一个程序中，变量仅有一个定义。
- 声明（declaration）：用于向程序表明变量的类型和名字。 **定义也是声明**：因为定义时也声明了它的类型和名字。也可以通过 `extern` 关键字声明变量而不定义。不定义变量的声明包括对象名、对象类型和对象前的关键字 `extern`:

	```C++
	extern int i;        //声明 i 而不是定义 i
    int i;                //声明和定义 i
    extern int j = 1;    //定义 j
	```
`extern` 声明不是定义，不分配存储空间，但如果有初始化操作则会认为是定义，所以下面会出错。变量在程序中可以 **声明多次，但只能定义一次**。

    extern int i = 1;    //definition
    int i;                //error: redefinition

另一种情况：

```C++
extern int i = 1;        //definition
extern int i;            //ok:声明不是定义
extern int i = 2;        //error: redefinition
```

> 变量仅能定义一次，而且在使用变量之前必须定义或声明变量。

#### 3.6、名字的作用域 ####

C++程序中，每个名字都与唯一一个实体（如 **变量、函数或类型的等**）相关联。但在程序中还是可以多次使用同一个名字，只要上下文能够区分不同的意义，**上下文** 就称为 **作用域（scope）**，一个名字在不同的作用域中可以跟不同实体关联。

大多数作用域使用 **花括号** 来界定，如下程序说明了各种 **作用域**

```C++
#include <iostream>

int global_int = 0;    //global_int: 全局作用域（global scope）。全局能访问

int main()
{
	int global_int = 1;    //global_int: 局部作用域（local scope）。隐藏全局作用域，使用局部作用域
    int sum = 0;        //sum：局部作用域（local scope）。main函数不能访问
    for (int val = 1; val <= 10; ++val){    //val：语句作用域（statement scope）。for语句外不能访问
	    sum += val;
	}
    std::cout << "The global_int is " << global_int << std::endl;        //输出：The global_int is 1
    std::cout << "The sum of 1 to 10 inclusive is " << sum << std::endl;//输出：The sum of 1 to 10 inclusive is 55
    return 0;
}
```

> 在函数内定义的局部变量名最好不同于要使用到的全局变量

C++还有另外两种不同级别的作用域：**类作用域（class scope）** 和 **命名空间作用域（namespace scope）**，后续详细介绍。

#### 3.7、在变量使用处定义变量 ####

一般来说，变量的定义或声明可以放在程序中变量未使用之前的任何位置。

> 通常把变量定义放在首次使用的地方是一个好的方法

END.