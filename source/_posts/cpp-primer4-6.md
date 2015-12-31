title: 'using声明和string类型'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-15 16:31:46
---

从这篇博客开始学习《C++ primer》的第三章“标准库类型”。首先介绍命名空间的using声明和第一种库类型string。

### 一、using声明 ###
---

在本章之前所用到的标准库类型都使用了 `::` 操作符，该操作符是作用域操作符，如 `std::cin`。但每次使用标准库类型就需要添加 `std::` 显得非常麻烦，本节介绍一种安全的机制：**using声明**。

<!-- more -->

使用using声明可以不再需要添加 `namespace_name::`，如下

```C++
using namespace::name
```

一旦使用了 using 声明，后面就不要再次引用命名空间了：

```C++
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int main()
{
	cout << "Enter two Numbers:" << endl;
	int val1, val2;
	cin>> val1 >> val2;
	cout << "The sum of " << val1 << " and " << val2
			<< " is " << val1+val2 << endl;
	return 0;
}
```

可以对比之前我们写的程序，发现明显可以简洁很多。在接下来的例子中，我们均假设已经提供了using声明。

### 二、标准库string类型 ###
---

string 类型支持可变长度的字符串，我们不需要知道它的具体实现，只需要知道它提供的操作。跟其他标准库类型一样，要使用也需要添加头文件：

```C++
#include <string>
using std::string;
```

#### 2.1、string对象的定义和初始化 ####

string 标准库支持几个构造函数，构造函数是一个特殊成员函数，定义如何初始化该类型的对象。下表列出了几个构造函数

|string构造函数|-|
|-|-|
|string s1;|默认构造函数，s1为空字符串|
|string s2(s1);|将s2初始化为s1的副本|
|string s3("value")|将s3初始化为 "value" 的副本|
|string s4(n,'c')|将s4初始化为含n个 'c' 的字符串|

> 字符串的字面值与标准库string类型不是同一种类型，需要注意！

#### 2.2、string对象的读写 ####

跟前面的 iostream 标准库的内置类型 int，double相似：

```C++
//假设using声明已经提供
int main()
{
	string s;
	cin >> s;
	cout << s << endl;
	return 0;
}
```

string的输入操作：

- 读取时忽略开头所有的空白符（如空格，换行符，制表符）；
- 读取字符直至再次遇到空白符；

因此如果输入的是 "  hello world "（开头和结尾都有空格），上述程序输出是 "hello"，下面程序输出为 "helloworld"。

而且与前面类似，可以把多个操作放在一起

```C++
string s1,s2;
cin >> s1 >> s2;
cout << s1 << s2 << endl;
```

另一个例子：读取未知数目的string对象

```C++
string word;
while(cin >> word){	//输入“ctrl+z”可以结束
	cout << word << endl;
}
```

跟上述程序相似的还有 string IO 操作：getline()。该函数接受两个参数：

- 输入流对象；
- string对象；

该函数是读入输入流的下一行，并保存在string对象中。但行中不包含 **换行符**，getline只要遇到换行符，即便是输入的第一个字符，getline也会停止读入并返回。如果第一个字符是换行符，则string对象为空。

```C++
string word;
while(getline(cin,word)){	//输入“ctrl+z”可以结束
	cout << word << endl;
}
```

#### 2.3、string对象的操作 ####

|string的操作|-|
|-|-|
|s.empty()|s为空返回true，否则返回false|
|s.size()|返回s中的字符个数|
|s[n]|范围s中位置为n的字符，位置从0开始计数|
|s1 + s2|连接s1，s2成一个新的字符串|
|s1 = s2|把s1的内容替换成s2的内容|
|s1 == s2|比较s1，s2的内容，相等返回true，否则false|
|!=, <, <=, >, >=|就是这些符号表达的意思|

**1、size()和empty()**

```C++
string s("ni hao\n");
if(!s.empty()){
	cout << "The size of" << s << "is" << s.size() << endl;
} else {
	cout << "empty!" << endl;
}
```

可以像上述程序一样使用size(),empty()。

**2、string::size_type类型**

从前面来看，size()返回的值似乎是int型，但实际上返回的是 `string::size_type` 类型。因为int类型所能表示的范围实在有限，所以string类型定义了新的配套类型。

```C++
string s("hello world");
for(string::size_type i=0; i!=s.size(); ++i){
	cout << s[i] << endl;
}
```

一般来说使用 int 类型也能够达到要求，但最安全的方法是使用 string::size_type 类型。

**3、string关系操作符**

- `==, !=`：相等、不等
- `<, <=, >, >=`：小于、小于或等于、大于、大于或等于

比较两个字符串时采用了和字典排序相同的策略（大小写敏感）：

- 如果string对象长度不同，且短的string对象与长的对象前面部分相同，则短的小于长的；
- 如果两个string对象字符不同，则比较第一个不匹配的字符；
```C++
string s1("hello");
string s2("hello world");
string s3("hey");
cout << (s1 < s2) << ", " << (s1 < s3) << endl;
```

输出结果

```C++
1, 1
```

表示 s1 小于 s2，s1 小于 s3。

**4、相加**

```C++
string s1("hello");
string s2("hey");

string s3 = s1 + s2;	//生成新字符串
s1 += s2;				//追加至s1末尾
```

**5、与字符串字面值的连接**

`+` 操作符的左右操作数必须有一个是 string 类型“

```C++
string s1 = "hello";
string s2 = "world";
string s3 = s1 + s2;			//ok
string s4 = s1 + "world" + "!";	//ok
string s5 = "hello" + s2 + "!";	//ok
string s6 = "hello" + "world";	//error:两个字面值不能相加
string s7 = "hello" + "," + s2;	//error
```

**6、下标操作**

通过 `[]` 来取得string对象中的字符。且下标操作可以做左值：

```C++
for(string::size_type i=0; i!=s.size(); ++i){
	s[i] = '*';	//注意是 '*'，不是 "*"
}
```

任意可以产生整数值的表达式都可以作为下标：

```C++
cout << s[2*2] << endl；
```

#### 2.4、string对象中的字符处理 ####

经常需要对string对象中的单个字符处理，这些处理的函数在头文件 cctype 中定义
 
|cctype定义的函数|-|
|-|-|
|isalnum(c)|c 是字母或数字，返回true|
|isalpha(c)|c 是字母，返回true|
|iscntrl(c)|c 是控制字符，返回true|
|isdigit(c)|c 是数字，返回true|
|isgraph(c)|c 不是空格，但可打印，返回true|
|isprint(c)|c 是可打印字符，返回true|
|ispunct(c)|c 是标点符号，返回true|
|isspace(c)|c 是空白字符，返回true|
|isxdigit(c)|c 是十六进制数，返回true|
|islower(c)|c 是小写字母，返回true|
|isupper(c)|c 是大写字母，返回true|
|tolower(c)|若 c 是大写字母，返回 c 的小写形式；否则直接返回 c|
|toupper(c)|若 c 是小写字母，返回 c 的大写形式；否则直接返回 c|

举例：

```C++
string s("hello world");
for(string::size_type i = 0; i != s.size(); ++i){
	s[i] = toupper(s[i]);
}
cout << s << endl;
```

输出：

```C++
HELLO WORLD
```

END.