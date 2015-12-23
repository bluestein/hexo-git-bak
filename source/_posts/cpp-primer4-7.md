title: 'Cpp:vector类型'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-17 16:31:51
---

vector 是一种类型对象的容器，每个对象都有一个对应的整数索引值。我们还把它称之为 **容器**，是因为它可以包含其他对象。一个容器中必须包含的是同一种类型的对象，地9章会详细介绍容器。首先是声明：

<!-- more -->

```C++
#include <vector>
using std::vector;
```

vector 是一个类模板（class template），所以 vector 可以包含不同类型的对象，如 int 型，string 型。vector 的声明

```C++
vector<int> intv;
vector<Sales_item> salesv;
```

> vector 不是一种数据类型，只是一个模板，可用来定义任意多种数据类型。但 vector<int> 或 vector<string> 可以看成是一种类型。

### 1、vector 对象的定义和初始化 ###
---

|初始化方式|-|
|-|-|
|vector<T> v1;|默认构造，v1 为空|
|vector<T> v2(v1);|v2 是 v1 的副本|
|vector<T> v3(n, i);|v3 包含 n 个 i 的元素|
|vector<T> v4(n);|v4 初始化为含有 n 个 T 类型默认值的对象|

例如：

```C++
vector<int> intv1;
vector<int> intv2(intv1);	//ok
vector<string> strv(intv1);	//error：strv 保存的是 string 类型，不是 int 类型
```

也可以用元素个数和元素之进行初始化

```C++
vector<int> intv(10, -1);	//10 个int元素，每个初始化为 -1
vector<int> strv(10, "hi");	//10 个string元素，每个初始化为 hi
```

> vector重要的属性在于可以在运行时高效的添加元素，在元素已知的情况下，最好是动态的添加元素。

下面说明这种初始化情况

```C++
vector<int> intv(10);
vector<string> strv(10);
```

此时

- `intv` 会被初始化成包含 10 个 **0** 的 vector 对象；
- `strv` 会被初始化成包含 10 个 **空字符串** 的 vector 对象；

这种初始化方式叫做 **值初始化**。

### 2、vector对象的操作 ###
---

|vector操作|-|
|-|-|
|v.empty()|v 为空，返回true|
|v.size()|返回 v 中的个数|
|v.push_back(t)|在 v 的末尾添加一个 t 元素|
|v[n]|返回 v 中位置为 n 的元素|
|v1 = v2|v1 的值替换成 v2|
|v1 == v2|若 v1 和 v2 相等，返回true|
|!=, <, <=, >, >=|保持惯有操作|

#### 2.1、empty和size ####

empty和size的操作类似于string，成员函数返回的vector类型定义的size_type的值。

> 使用size_type时，必须指出该类型是在哪里定义的，如
```C++ 
vector<int>::size_type	//ok
vector::size_type		//error
```

#### 2.2、向vector添加元素 ####

push_back()接受一个元素值，并将它作为一个新的元素添加到vector对象的末尾

```C++
string word;
vector<string> text;
while (cin >> word){
	text.push_back(word);
}
```

上面程序的意思是从标准输入读取一系列string对象，并逐一添加到vector对象的末尾。

#### 2.3、vector的下标操作 ####

vector对象的元素是没有命名的，但可以按vector对象中的位置来访问它们，跟string类似，位置从0开始计数，下例是将vector中的每个元素置为0：

```C++
vector<int> intv(10);	//含有10各元素的vector
for(vector<int>::size_type i = 0; i != intv.size(); ++i){
	intv[i] = 0;
}
```

> 习惯于Java和C的程序员可能会觉得难以理解
```
1、for循环用 `!=` 来作为判断条件；
2、不用变量保存 `intv.size()`；
```
> 到学习过泛型编程后就会明白 `1` 的合理性，至于 `2`，上述循环不需要增加元素，但循环很容易增加元素，所以如果增加了元素的话，那保存就不合理了。

#### 2.4、下标操作不能添加元素 ####

下标操作不能添加元素，但能对已有的元素进行操作，如上例中的将所有元素重置为0。所以下面的例子是错误的

```C++
vector<int> intv;	//这是空vector，没有元素
for (vector<int>::size_type i = 0; i != 10; ++i){
	intv[i] = i;	//error：intv是空
}
```

但下面的例子是正确的

```C++
vector<int> intv;	//这是空vector，没有元素
for (vector<int>::size_type i = 0; i != 10; ++i){
	intv.push_back(i);	//ok:动态增加
}
```

END.