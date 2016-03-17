title: '函数的声明'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-12-31 15:11:49
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

跟变量一样，函数也需要先声明再使用。同样的，函数的定义和函数的声明也可以分离：一个函数只能定义一次，但可以声明多次。

函数声明必须包含：**返回类型、函数名和形参列表**。形参列表必须包含形参类型，但没强调要包含形参名。比如

```C++
void func(int, string);
```

<!-- more -->

### 默认实参 ###

调用函数时，可以省略有默认值的实参。如果一个参数有默认值，那么它后面的实参都必须有默认值。如：

```C++
string screenInit(string::size_type height = 24,
				string::size_type width = 80,
				char background = ' ');
// 下面调用均正确
string screen;
screen = screenInit();
screen = screenInit(66);
screen = screenInit(66, 256);
screen = screenInit(66, 256, '#');
```

设置默认形参时，最少使用的默认值放在最前，最多使用的放在最后。

> 函数在声明时可以指定默认实参，但是在一个文件中，只能为形参指定一次默认参数。所以可以将声明放在头文件中。

### 静态局部对象 ###

上面的形参都会在定义它们的快语句结束时被撤销，如果需要跨越多个作用域，定义为 **static**，它能保证在程序结束前不被撤销：

```C++
size_t count() {
	static size_t cnt = 0;
	return ++cnt;
}
int main() {
	for (size_t i = 0; i!= 5; ++i) {
		cout << count() << endl;
	}
	return 0;
}
// prints:
// 1
// 2
// 3
// 4
// 5
```

### 内联函数 ###

一般的函数调用要比求解表达式慢得多，**内联函数可以避免函数调用的开销**。使用 **inline** 关键字定义，如：

```C++
inline const string &shorterString(const string &s1, const string &s2)
{
	return s1.size() > s2.size() ? s1 : s2;
}
```

则在调用 `cout << shorterString(s1, s2) << endl;` 时， 编译时展开为 `cout << (s1.size() > s2.size() ? s1 : s2) << endl;`。

内联机制适用于优化小的、几行的且经常调用的函数。

### 类的成员函数 ###

和任何函数一样，包含下面四个部分：

1. 返回类型
2. 函数名
3. 逗号分隔的形参列表（可为空）
4. 花括号内的函数体

1,2,3 组成的是函数原型，**函数的原型必须在类中定义**，函数体则可以在类外。假设 Sales_item 类有两个成员函数 avgPrice() 和 sameIsbn(const Sales_item &):

```C++
class Sales_item {
public:
	double avgPrice() const;
	bool sameIsbn(const Sales_item &rhs) const {
		return isbn == rhs.isbn;
	}
private:
	std::string isbn;
	unsigned units_sold;
	double revenue;
};
```

可以发现形参的后面有 `const`，在解释之前，说明成员函数如何定义：

#### 成员函数的函数体 ####

类的所有成员必须在**定义类的花括号中声明**，并且**编译器隐式地将类内定义的成员函数当作是内联函数**。

> 类的成员函数可以访问 private 成员，如 isbn。

**this 指针的引入**

每个成员函数都有一个额外的、隐式的形参 **this**，在调用成员函数时，形参 this 初始化为调用函数的对象的地址。可以这样理解：

```C++
item.sameIsbn(otherItem);
```

编译器会重写这个函数调用：

```C++
Sales_item::sameIsbn(&item, otherItem);
```

**const 成员函数的引入**

也就是上面提到的形参后面 **const**，**它改变了隐式形参 this 的类型**。

```C++
bool sameIsbn(const Sales_item *const this,
			const Sales_item &rhs) const {
		return (this->isbn == rhs.isbn);
	}
```

这种使用 const 的函数称为**常量成员函数**（const member function）。由于 this 指向 const 对象，const 成员函数不能修改调用该函数的对象。

#### 类外定义成员函数 ####

```C++
double Sales_item::avgPrice() const {
	if (units_sold){
		return revenue / units_sold;
	} else {
		return 0;
	}
}
```

使用了域操作符 `::` 及类名 `Sales_item`。

#### Sale_item 的构造函数 ####

构造函数是特殊的成员函数，**构造函数名与类名相同，而且无返回类型**。可以有多个构造函数，相互之间的具有不同数目或类型的形参。

跟普通成员函数一样，必须在类内声明，类内或类外定义。

```C++
class Sales_item {
public:
	double avgPrice() const;
	bool sameIsbn(const Sales_item &rhs) const {
		return isbn == rhs.isbn;
	}
	Sales_item(): units_sold(0), revenue(0.0) {}
private:
	std::string isbn;
	unsigned units_sold;
	double revenue;
};
```

**构造函数的初始化列表**

**在冒号与花括号之间的代码称为构造函数的初始化列表**，即 `units_sold(0), revenue(0.0)` 为成员指定初值，括号内是初值。**构造函数的形参表为空说明此为默认调用的**

**类代码的组织**

通常将类的声明放置在头文件中，在类外定义的成员函数则置于源文件中。

### 重载函数 ###

在相同作用域中，出现相同名字而形参表不同的函数，称为重载函数。如电话本的查找：基于姓名、基于号码

```C++
Record lookup(const Name&);
Record lookup(const Phone&);
```

**重载与重复声明的区别**

如果两个函数声明的返回类型和参数表完全匹配，叫重复声明；**如果形参表完全相同，返回类型不同，则第二个错误**。

在函数中局部声明的名字会屏蔽全局名，即使是变量名对函数名也同样成立：

```C++
string init();
void func() {
	int init = 0;
	string s = init(); // error: global init is hidden
}
```

### 指向函数的指针 ###

函数指针是指指向函数而非对象的指针，像其他指针一样，函数指针指向的是函数类型，**函数类型由其返回类型和形参表确定，与函数名无关**。

```C++
bool (*pf)(const string &, const string &);
```

#### 用typedef简化定义 ####

```C++
typedef bool (*cmpFcn)(const string &, const string &);
```

则 `cmpFcn` 表示**指向返回类型为 bool 类型并带有两个 const string 引用形参的函数的指针**。若要定义此类型的函数指针，则直接使用 `cmpFcn` 即可。

#### 初始化和赋值 ####

在引用函数名又没调用该函数，函数名将被自动解释为指向函数的指针。假设有函数：

```C++
bool lengthCpmpare(const string &, const string &);
```

会被解释为如下类型的指针：

```C++
bool (*)(const string &, const string &);
```

可以做如下初始化：

```C++
cmpFcn pf1 = 0;				// ok：不指向任何函数
cmpFcn pf2 = lengthCompare;	// ok：指向类型匹配的函数
pf1 = lengthCompare;		// ok：同上
pf2 = pf1;					// ok：同上
```

此时，直接饮用函数名等效于在函数名上应用取地址操作符：

```C++
cmpFcn pf1 = lengthCompare;
cmpFcn pf2 = &lengthCompare;
```

> 函数指针只能通过同类型的函数或函数指针或 0 值常量表达式进行初始化或赋值

#### 通过指针调用函数 ####

不需要解引用操作符，直接通过指针调用函数：

```C++
cmpFcn pf = lengthcompare;
lengthCompare("hi", "bye");	// 直接调用
pf("hi", "bye");			// 等价调用：pf隐式解引用
(*pf)("hi", "bye");			// 等价调用：pf显式解引用
```

#### 函数指针形参 ####

函数的形参可以是指向函数的指针，这种形参可以用以下两种形式编写：

```C++
void useBigger(const string &, const string &,
			bool (const string &, const string &));
void useBigger(const string &, const string &,
			bool (*)(const string &, const string &));
```

#### 返回指向函数的指针 ####

函数可以返回指向函数的指针，但是，这并不简单：

```C++
// ff is a function taking an int and returing a function pointer
// the function pointed to returns an int and takes an int* and an int
int (*ff(int)) (int*, int);
```

这样理解： `ff(int)` 表明 ff 为一个函数，它带有一个 int 型形参，该参数返回 `int (*)(int*, int)`，它是指向一个函数的指针。用 typedef 可以更加明白：

```C++
// PF is a pointer to a function returing an int, taking an int* and an int
typedef int (*PF)(int*, int);
PF ff(int);
```

END.