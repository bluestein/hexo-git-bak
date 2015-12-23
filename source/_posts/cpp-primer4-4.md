title: 'Cpp:const、引用和typedef'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-12 16:31:33
---

### 一、const ###
---

考虑问题：下面程序中数字 `0` 的含义？

```C++
for (int i = 0; i != 10; ++i){
	//...
}
```

<!-- more -->

- 显然从程序来看，我们并不知道 `10` 是怎样一个存在，因此它也被称为 **魔数（magic number）**，意思是这个数的意义不能从上下文体现出来，就像魔术一样凭空出现了。

- 或者如果这个程序多次使用数字 `10` 的话，当需要要把 `10` 改为 `20` 的话就麻烦了。

一种简单的解决办法是

```C++
int max = 10;
for (int i = 0; i != max; ++i){
	//...
}
```

这样不仅可读性好很多，而且修改起来也相当方便。

> `max` 是可以被修改的

#### 1.1、定义const对象 ####

上面到，`max` 可能会被有意或无意的修改，在某些情况下这很严重。**const** 提供一种解决办法

```C++
const int max = 10；
```

此时定义 `max` 为 **常量** 并初始化为 10，但此时的 `max` 不可被修改。

> C++中的 const 跟 **Java 中的 final** 或 **PHP 中的 define** 类似。
> const 定义的常量不可修改，所以定义时必须初始化如下

```C++ 
const std:string hi = "Hello";//正确
const int i;	//错误
```

#### 1.2、const对象默认为文件的局部变量 ####

跟普通的变量不一样，const定义的变量需要特别的说明才可以在其他文件中访问。例如

- 普通变量
```C++
//file1.cpp
int max = 10;		//定义变量
//file2.cpp
extern int max;	//声明外部变量
//下面可以使用变量 max
```
- const变量
```C++
//file1.cpp
extern const int max = 10;	//定义变量
//file2.cpp
extern const int max;		//声明外部变量
//下面可以使用const变量 max
```

> 定义非 `const` 变量时默认问 `extern`。而 `cost` 变量必须显式的指定它为 `extern` 才可以被其他文件访问。

### 二、引用 ###
---

引用（reference）就是对象的另一个名字。在实际程序中，引用主要作为函数的形参，形参的内容将在后续介绍。

引用是一种 **复合类型（compound type）**，在变量名前加 `&` 符号来定义。复合类型是指用其他类型定义的类型。每个引用都关联到其他某一类型，**不能定义引用的引用，但可以定义任意类型的引用，并且可以有多个引用**。下面用例子说明

```C++
int val = 1;
int &reVal1 = val;	//正确
int &reVal2 = val;	//正确：val的第二个别名

int &reVal3;		//错误：引用必须初始化
int &reVal4 = 1;	//错误：引用必须使用对象初始化
```

#### 2.1、引用是别名 ####

引用只是它所绑定对象的另一个名字，在引用上做的所有操作实际上都作用在原对象上：

```C++
reVal1 = 5；			//相当于：val = 5；
reVal1 += 1;		//相当于：val += 1;
int val2 = reVal1;	//相当于：int val2 = val;
```

下面程序的结果更能直观的说明这个问题

```C++
int main()
{
	int val = 0;
	int &reVal1 = val;
	int &reVal2 = val;
	std::cout << "val = " << val << ", reVal1 = "<< reVal1 << ", reVal2 = " << reVal2 << std::endl;
	reVal1 = 1;	//对 reVal1 操作
	std::cout << "val = " << val << ", reVal1 = "<< reVal1 << ", reVal2 = " << reVal2 << std::endl;
	reVal2 = 2;	//对 reVal2 操作
	std::cout << "val = " << val << ", reVal1 = "<< reVal1 << ", reVal2 = " << reVal2 << std::endl;
	return 0;
}
```

运行结果是： 

```C++
val = 0, reVal1 = 0, reVal2 = 0
val = 1, reVal1 = 1, reVal2 = 1
val = 2, reVal1 = 2, reVal2 = 2
```

#### 2.2、const引用 ####

非 const 不能引用 const，只有 const 能够引用 const，且 const 引用不能修改：

```C++
int i = 0;
const int val = 0;			//正确：0是右值
const int &reVal1 = val;	//正确：val是左值
const int &reVal2 = i;		//正确

reVal1 = 1;					//错误：const 引用是只读的
int &reVal3 = val;			//错误：非 const 不能引用 const
```

跟非 const 不同之处还有：

```C++
int i = 0;
const int &re1 = 1;			//正确
const int &re2 = re1 + i;	//正确
```

对于下面这种绑定到同一类型的情况：

```C++
int i =  0;
const int &re1 = i;	//此时 re1 = 0；
i = 1;				//此时 re1 = 1；
```

当改变 `i` 时，`re1` 也会被改变。

还有另一种情况：绑定到不同类型的值

```C++
double i =  1.1;
const int &re1 = i;	//此时 re1 = 1；
i = 2.1;			//此时 re1 = 1；
```

因为对于这种情况，编译器会解释为：

```C++
int temp =  i;
const int &re1 = temp;
```

所以，改变 `i` 实际上改变的是 `temp`， `re1` 不受影响。

> const 引用可以绑定左值或右值，非 const 引用只能绑定左值。

### 三、typedef ###
---

typedef 跟引用有点类似，不过 typedef 是定义类型的别名：

```C++
typedef double wages;	//wages 是 double 的别名
typedef int score;		//score 是 int 的别名
typedef wages salary;	//salary 是 double 的别名
```

其作用是：

- 为了隐藏特定的类型，强调使用类型的目的；
- 简化复杂的类型定义，易于理解；
- 允许一个类型用于多个目的，并且每次使用时目的明确；

### 四、枚举 ###
---

如果要为某属定义一组可选择的值，每个只对应一种状态，比如文件的打开状态：输出，输入和追加分别对应 0,1,2。则有可能会这样定义：

```C++
const int input = 0；
const int output = 1；
const int append = 2；
```

属性选择很多时这样定义就不方便，**枚举（enumeration）** 是一种替代方法。

#### 4.1、定义和初始化枚举 ####

枚举的关键字是 `enum`，定义如下

```C++
enum open_modes {input, output, append};
```

默认地，第一个枚举成员赋值为 0，后面的依次加 1。

#### 4.2、枚举成员是常量 ####

可以为一个或多个成员提供初值，初始化枚举成员的值必须是一个 **常量表达式（constant expression）**，整型字面值也是常量表达式。

```C++
// sphere = 2, polygon = 2
enum forms {shape = 1, sphere, cylinder = 1, polygon}
```

#### 4.3、每个enum都定义了一种唯一的类型 ####

```C++
forms f1 = shape;	//正确：shape 是 forms 类型的枚举成员
forms f2 = square;	//错误：square 不是 forms 类型；
forms f3 = 1；		//错误：1 是 int类型，不是forms类型
```

> 即使 1 与 shape 相关联，但是 1 赋值给 f3 还是非法的

### 五、类类型 ###
---

在C++中可以通过定义 **类（class）** 来自定义数据类型。类定义了该类型的对象包含的数据和该类型对象可以执行的操作。标准库类型 **string、istream、ostream**都定义成类，关于类后续详细介绍。

本节继续使用在 [读《C++primer》day1：快速入门](http://www.jianshu.com/p/67a45978af28) 的第三部分提到的 **Sales_item** 类举例。

#### 5.1、从操作开始设计类 ####

每个类都定义了一个 **接口（interface）** 和一个 **实现（implementation）**。接口由使用该类的代码需要执行组成，实现一般包括该类所需的数据及操作。

定义类时，通常先定义接口，即该类所提供的操作。以 Sales_item 举例：

- 加法 `+` ：将两个对象相加；
- 输入 `>>` ： 读取一个对象；
- 输出 `<<` ：输出一个对象；
- 赋值 `=` ：将一个对象赋给另一个对象；
- 对比 `?` ：对比两个对象是否属于同一本书（函数same_isbn）；

虽然现在我们并不能实现这些操作（需要更多的知识），但可以考虑实现这些操作需要什么样的数据：

- 记录各书本的销售册数；
- 该书的总销售收入；
- 计算该书的平均售价；

大概就可以知道需要一个 `unsigned` 类型对象来记录数的销售册数，一个 `double` 类型对象计入总收入，`string` 类型对象记录书本的ISBN。

#### 5.2、定义Sales_item类 ####

按上一节提到的操作和数据，可以这样定义：

```C++
class Sales_item {
public:
	//各种操作在此定义
private:
	std:string isbn;
	unsigned units_sold;
	double revenue;
};
```

类定义以关键字 **class** 开始，后面是该类的类名，类体位于花括号内部，花括号后面必须要跟一个分号。

> 新手经常会忘记类定义后面的分号！

类体可以为空，类体定义了该类型的数据和操作。这些数据和操作也称为 **成员（member）**，数据称为 **数据成员（data member）**，操作称为 **成员函数**。

类定义可以包含多个 private 和 public **访问标号（access label）**，给定的访问标号作用域到下一个访问标号出现时为止。类中 **public** 部分定义的成员在程序的任何部分都可以访问，不是类的组成部分的代码不能方便问 **private** 成员，这样可以保证Sales_item对象不能直接操纵数据成员。

#### 5.3、使用struct关键字 ####

struct 关键字也可以定义类类型，它是从 C 语言继承而来。区别

- 用关键字 `class` 定义类：定义在第一个标号之前的所有成员都默认为private；
- 用关键字 `struct` 定义类：定义在第一个标号之前的所有成员都默认为public；

用 `struct` 重新定义前面的Sales_item类：

```C++
class Sales_item {
//不需要 public 访问标号
private:
	std:string isbn;
	unsigned units_sold;
	double revenue;
};
```

> 用 class 和 struct 关键字定义类的唯一区别就在于 **默认访问级别**。默认情况下，struct 的成员为 public，而 class 的成员的是 private。 

END.