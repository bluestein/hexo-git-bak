title: '顺序容器'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2016-01-02 18:46:49
---

前面介绍过 vector 容器类型，这里会深入探讨 vector 和其他顺序容器（sequential container）类型，还有 string 类型提供的更多操作，甚至可以将 string 看成是仅包含字符串的特殊容器。

标准库定义了三种顺序容器类型：vector，list 和 deque（double-ended queue，发音同 deck）。差别在于访问元素的方式，以及添加或删除元素的运行代价。标准库还提供了三种容器的适配器（adapter），适配器是根据原始的容器类型所提供的的操作，顺序容器适配器包括：stack，queue 和 priority_queue。

<!-- more -->

|名称|说明|
|--|--|
|**顺序容器**|-|
|vector|支持快速随机访问|
|list|支持快速插入删除|
|deque|双端队列|
|**顺序容器适配器**|-|
|stack|后进先出（LIFO）|
|queue|先进先出（FIFO）|
|priority_queue|有优先级管理的队列|

### 顺序容器的定义 ###

首先必须包含头文件

```cpp
#include <vector>
#include <list>
#include <deque>
```

**所有顺序容器都是类模板**。要定义某种特殊的容器，必须在容器名后添加一对尖括号，尖括号内提供容器将要存放元素的类型

```cpp
vector<string> svec;
list<int> ilist;
deque<Sales_item> item;
```

> 所有容器都有默认构造函数，该构造函数不带任何参数

#### 初始化 ####

除了默认构造函数，容器类型还提供了其他的构造函数，可以指定其元素的初值

|操作|说明|
|--|--|
|C<T> c;|创建名为 c 的容器。<br/>C 为容器名，如 vector。<br/>T为元素类型，如string，int。<br/>**适用于任何容器**|
|C c2(c1)|创建容器 c1 的副本。<br/>c2 和 c1 必须是相同类型的容器，并存放相同类型的元素。<br/>**适用于任何容器**|
|C c(begin, end)|使用迭代器 begin 和 end 范围内的元素创建 c。<br/>**适用于任何容器**|
|C c(n, t)|用 n 个值为 t 的元素创建容器。<br/>t 必须与容器存放的类型匹配，或者可以转化为该类型的值。<br/>**只适用于顺序容器**|
|C c(n)|创建 n 个默认初始值的容器。<br/>**只适用于顺序容器**|

**初始化为另一个容器的副本**

```cpp
vector<int> ivec1;
vector<int> ivec2(ivec1); // ok
list<int> ilist(ivec1); // error: ivec is not list<int>
vector<double> dvec(ivec); // error: ivec holds int not double
```

**初始化为另一容器的部分元素**

允许通过传递一对迭代器来初始化容器。使用迭代器时，不需要容器类型相同，容器内的元素类型可以不同，只要相容即可

```cpp
list<string> slist(svec.begin(), svec.end());
vector<string>::iterator mid = svec.begin() + svec.size() / 2;
deque<string> front(svec.begin(), mid);
```

因为指针就是迭代器，所以可以用数组中的值对容器进行初始化

```cpp
char *words1[] = {"hi", "hey", "hello"};
size_t sz = sizeof(words1) / sizeof(char *);
list<string> words2(words1, words1 + sz);
```

**初始化指定数目的元素**

```cpp
list<string> slist(10, "hi");
list<int> ilist(10);
```

都是 10 个元素的 list，`slist` 的每个值初始化为 **hi**， `ilist` 每个值初始化为 **0**。

> 只有当元素类型有默认构造函数时才可以使用 `C c(n)` 的方式初始化。例如上面的 int 默认初始化为 0。

**容器的容器**

支持容器的容器，不过要注意使用空格

```cpp
vector< vector<string> > lines; // ok
vector< vector<string>> lines; // error
```

否则被认为是右移操作。

### 迭代器和迭代器的范围 ###

标准库为所有容器类提供的操作

|操作|说明|
|--|--|
|*iter|解引用|
|iter->member|解引用，获取指定名为 member 的成员，等价于 (*iter).member|
|++iter<br/>iter++|使iter指向后一个元素|
|--iter<br/>iter--|使iter指向前一个元素|
|iter1 == iter2<br/>iter1 != iter2|比较是否相等|

#### vector, deque额外的操作 ####

|操作|说明|
|--|--|
|iter + n<br/>iter - n|使iter指向后（前） n 个元素|
|iter1 += iter2<br/>iter1 -= iter2<br/>iter1 - iter2|迭代器运算|
|>, >=, <, <=|关系操作|

> 只适用于 vector 和 deque

### 顺序容器的操作 ###

每种顺序容器都有以下操作

1. 向容器添加元素
2. 删除元素
3. 设置容器大小
4. 获取容器第一个或最后一个元素（如果有的话）

#### 为容器定义的类型别名 ####

|别名|说明|
|--|--|
|size_type|无符号整型，足以存储此容器类型的最大可能长度|
|iterator|此容器类型的迭代器|
|const_iterator|只读类型迭代器|
|reverse_iterator|逆序寻址的迭代器|
|const_reverse_iterator|只读逆序寻址的迭代器|
|difference_type|足够存储两迭代器差值的有符号整型，可为负值|
|value_type|元素类型|
|reference|元素的左值类型，是 value_type& 的同义词|
|const_reference|元素的常量左值类型，等价于 const value_type&|

#### begin 和 end 成员 ####

|操作|说明|
|--|--|
|c.begin()|返回一个迭代器，指向容器的第一个元素|
|c.end()|返回一个迭代器，指向容器最后一个元素的后面一个位置|
|c.rbegin()|逆序迭代器，指向容器的最后一个元素|
|c.rend()|返回一个逆序迭代器，指向容器第一个元素前面的位置|

#### 添加元素 ####

|操作|说明|
|--|--|
|c.push_back(t)|在容器尾部添加值为 t 的元素，返回 void 类型|
|c.push_front(t)|在容器前端添加值为 t 的元素，返回 void 类型|
|c.insert(p, t)|在迭代器p所指元素的前面插入一个值为 t 的元素，返回指向新添加元素的迭代器|
|c.insert(p, n, t)|在迭代器p所指元素的前面插入 n 个值为 t 的元素，返回 void 类型|
|c.insert(p, begin, end)|在迭代器p所指元素的前面插入迭代器 begin 和 end 范围内的元素，返回 void 类型|

> 迭代器可能会失效。指向新加入元素后面的那个元素的迭代器会失效

#### 关系操作符 ####

要使用类型相同的进行比较

1. 如果两容器有相同长度并且所有元素相等，则两个容器相等；
2. 如果两容器有不同长度，但较短容器的元素等于较长容器的子序列，则短容器小于长容器；
3. 如果不存在子序列，则比较第一个不同的元素；

#### 容器大小 ####

|操作|说明|
|--|--|
|c.size()|返回容器 c 中的元素个数，类型为 c::size_type|
|c.max_size()|最多可容纳个数|
|c.empty()|返回是否为空|
|c.resize(n)|调整 c 的大小，容量为 n|
|c.resize(n, t|调整 c 的大小，容量为 n，所有新添加的元素值为 t|

#### 访问元素 ####

|操作|说明|
|--|--|
|c.back()|返回 c 的最后一个元素的引用，如果 c 为空，则该操作未定义|
|c.front()|返回 c 的第一个元素的引用，如果 c 为空，则该操作未定义|
|c[n]|返回 c 的第 n 个元素的引用，如果 n < 0 或 n >= c.size()，则该操作未定义<br/>**只适用于 vector 和 deque**|
|c.at(n)|返回 c 的第 n 个元素的引用，如果 n < 0 或 n >= c.size()，则该操作未定义<br/>**只适用于 vector 和 deque**|

back 和 front 同样可以用 end 和 begin 迭代器的解引用完成。

#### 删除元素 ####

|操作|说明|
|--|--|
|c.erase(p)|删除迭代器 p 所指元素。<br/>返回被删除元素的后一个位置，或最后一个元素的下一个位置|
|c.erase(begin, end)|不越界的情况下，删除 begin 和 end 范围内的元素|
|c.clear()|删除 c 内所有元素，返回 void|
|c.pop_back()|删除最后一个元素，返回 void|
|c.pop_front()|删除第一个元素，返回 void<br/>**只适用于 list 和 deque 类型**|

#### 赋值和交换 ####

|操作|说明|
|--|--|
|c1 = c2|将 c2 的内容赋值给 c1。会删除 c1 的内容|
|c1.swap(c2)|交换 c1 和 c2 的内容|
|c.assign(begin, end)|重设 c，把 begin 和 end 范围内的元素赋给 c|
|c.assign(n, t)|重设 c 为 n 个值为 t 的元素|

assign 会删除原容器中的元素，然后将所指定的新元素插入到该容器中。如果两个容器类型相同，就可以使用赋值操作符将一个容器赋值给另一个容器。如果在不同容器中，元素类型不同但相互兼容，那么必须使用 assign 函数。

### vector容器的自增长 ###

vector 以连续的方式存储每一个元素，一个挨着一个。所以当在超过预申请内存时再插入元素时，必须重新申请空间，然后将旧元素赋值到新空间中。此时就要用到 capacity 和 reserve，capacity 表示在必须重新非配空间之前可以存储元素的个数，一般由标准库定义，至少等于容器的大小，但一般来说会更大一些；而 reserve 表示人工预留存储空间（类似于数组大小的声明），当使用过程中超过人工预留空间后，vector会自己重新分配空间。

```cpp
vector<string> svec(10, "hi");
cout << svec.capacity() << endl;
svec.push_back("hi");
cout << svec.capacity() << endl;
svec.reserve(50);
cout << svec.capacity() << endl;
// prints:
// 10
// 15
// 50
```

### 容器的选择 ###

元素是否连续存储会显著的影响：

1. 在容器内部位置添加或删除元素；
2. 执行元素的随机访问的代价；

#### 插入操作影响容器的选择 ####

1. list 存储在不连续的空间，允许向前向后逐个遍历，**在任何位置可以高效的 insert 和 erase**。不过它不支持随机访问，必须遍历涉及到的元素。
2. vector 存储在连续区域，除了在尾部插入（删除），其他任何位置插入（删除）时都必须移动其后面的元素。
3. deque 更加复杂，在两段插入和删除都非常快，但在内部差入或删除时代价会更高。它还同时提供了 list 和 vector 的性质：
	1. 与 vector 一样，在容器内部 insert 和 erase 效率较低；
	2. 不同于 vector，deque 可以高效的实现首尾的 insert 和 erase；
	3. deque 支持所有元素的随机访问；
	4. deque 首尾插入不会使任何迭代器失效，而在首尾删除元素时，会使指向被删除元素的迭代器失效。在其他位置插入或删除都会使所有迭代器失效；

#### 访问影响 ####

vector 和 deque 都支持高效的随机访问，而 list 只能顺序的跟随指针，一直遍历。

#### 建议 ####

1. 要求随机访问，使用 vector 或 deque；
2. 要求内部插入（删除）元素，选择 list；
3. 如果在首部或尾部插入（删除），则选择 deque；
4. 如果只需在输入时在容器中间插入元素，然后需要随机访问。可以考虑输入时存放到 list 中，接着对其排序，然后将其复制到 vector 中；
5. 如果既需要中间插入元素又要随机访问，则选择容器时，考虑下面两种操作的相对代价：
	1. 随机访问 list 的代价；
	2. 在 vector 或 deque 内部插入（删除）元素的代价；

### 深入string类型 ###

除了前面用过的操作外，string 类型还支持大多数顺序容器操作。在某些方面可将 string 类型视为字符容器，操作也与 vector 类似，不过 string 不支持以栈方式操作容器：即 string 不能使用 front, back, pop_back等操作。下表扼要的介绍了一些 string 的操作

|操作|说明|
|--|--|
|string s;|定义一个空对象|
|string s(cp);|定义一个对象，并用 cp 指向的 c 风格的字符串初始化|
|string s2(s1);|初始化为s1的副本|
|is >> s;|从输入流 is 中读取一个以空白符分隔的字符串，存入 s|
|os << s;|将 s 写到输出流 os|
|getline(is, s)|从输入流 is 中读取一行字符，写入 s|
|s1 + s2|将 s1 和 s2 串接起来，产生一个新的 string 对象|
|s1 += s2|将 s2 拼接到 s1 后面|
|关系操作符|相等运算（== 和 !=）及关系运算（<, <=, >, >=）都可用于 string 对象的比较。等效于（区分大小写）字典次序的比较|

string 支持的容器操作有：

1. 迭代器类型；
2. 容器的构造函数（参考[前面](#初始化)），但是不包含只需一个长度参数的构造函数；
3. 跟 vector 一样的添加元素的操作。无论是 vector 还是 string 都不支持 push_front；
4. 支持长度操作。resize, size, reserve 等；
5. 支持下标和 at 操作；
6. 支持 begin 和 end 操作；
7. 支持 erase 和 clear 操作。但是不支持 pop_back 或 pop_front 操作；
8. 支持[前面](#赋值和交换)表中的赋值操作；
9. 与vector容器一样，string也是连续存储的，因此也支持 capacity 和 reserve 操作；

例如：

```cpp
string s("hey!");
string::iterator iter = s.begin();
while (iter != s.end()) {
	cout << *iter++ << endl;
}
```

#### 构造 string 对象 ####

string 几乎支持[前面](#初始化)所有的构造函数

```cpp
string s1;
string s2(5, 'a'); // s2 == "aaaaa"
string s3(s2); // s3 是 s2 的副本
string s4(s3.begin(),
		s3.begin() + s3.size() / 2); // s4 == "aa"

char *cp = "hey!";
char carr[] = "Hello!";
char no_null[] = {'H', 'i'};
string ss1(cp); // ss1 == "hey!"
string ss2(carr,5); // ss2 == "Hello"
string ss3(carr + 2, 3); // ss3 == "llo"
string ss4(no_null); // runtime_error: 没有 null 结束符
string ss5(no_null, 2); // ok
```

构造 string 对象的其他方法

|操作|说明|
|--|--|
|string s(cp, n)|创建用 cp 所指数组的前 n 个字符的副本|
|string s2(s1, pos)|创建从 s1 的 pos 位置开始的字符的副本|
|string s2(s1, pos, len)|创建 s1 的 pos 位置开始长为 len 的字符的副本|

> n, len, pos 都是 unsigned 值。

#### 修改string对象 ####

**与容器共有的操作**

|操作|说明|
|--|--|
|s.insert(pos, t)|在迭代器 pos 前插入一个值为 t 的元素|
|s.insert(pos, n, t)|在迭代器 pos 前插入 n 个值为 t 的元素|
|s.insert(pos, begin, end)|在迭代器 pos 前插入迭代器 begin 到 end 之间的值|
|s.assign(begin, end)|用迭代器 begin 到 end 之间的值重新初始化 s|
|s.assign(n, t)|用 n 个 t 值重新初始化 s|
|s.erase(pos)|删除迭代器 pos 所指元素|
|s.erase(begin, end)|删除迭代器 begin 到 end 之间的值|

**string 特有的操作**

|操作|说明|
|--|--|
|s.insert(pos, n, c)|在下标 pos 前插入 n 个值为 c 的字符|
|s.insert(pos, s1)|在下标 pos 前插入一个 s1 的副本|
|s.insert(pos, s1, pos1, len)|在下标 pos 前插入 s1 中从 pos1 开始长为 len 的子字符串|
|s.insert(pos, cp, len)|在下标 pos 前插入 cp 所指的数组前 n 个字符|
|s.insert(pos, cp)|在下标 pos 前插入 cp 所指以 null 结束的字符数组|
|s.assign(s1)|用 s1 重新初始化 s|
|s.assign(s1, pos1, len)|用 s1 中下标 pos1 开始长为 len 的子串重新初始化 s|
|s.assign(cp, len)|用 cp 所指的数组前 len 个元素重新初始化 s|
|s.assign(cp)|用 cp 所指以 null 结束的字符数组重新初始化 s|
|s.erase(pos, len)|删除从下标 pos 开始 len 个字符|

### 只适用于 string 的操作 ###

1. substr 函数；
2. append 和 replace
3. find

#### substr ####

|操作|说明|
|--|--|
|s.substr(pos, n)|返回从 pos 开始的 n 个字符|
|s.substr(pos)|返回从位置 pos 开始到结尾的字符|
|s.substr()|返回 s 的副本|

#### append 和 replace ####

|操作|说明|
|--|--|
|s.append(args)|将 args 拼接在 s 后。**返回 s 的引用**|
|s.replace(pos, len, args)|删除 pos 开始的 len 个字符，用 args 替换。**返回 s 的引用**|
|s.replace(begin, end, args)|删除 begin 到 end 之间的字符，用 args 替换。**返回 s 的引用**|

**上表中的args**

|操作|说明|
|--|--|
|s1|字符串 s1|
|s1, pos1, len1|s1 子串|
|cp|cp 所指以 null 结束的字符数组|
|cp, len1|cp 所指以 null 结束的字符数组前 len1 个元素|
|n, c|n 个 字符 c|
|begin1, end1|迭代器 begin1 和 end1 间的字符|

#### find ####

|操作|说明|
|--|--|
|s.find(args)|查找 s 中 args 第一次出现|
|s.rfind(args)|查找 s 中 args 最后一次出现|
|s.find_first_of(args)|查找 s 中 args 的任意字符第一次出现|
|s.find_last_of(args)|查找 s 中 args 的任意字符最后一次出现|
|s.find_first_not_of(args)|查找 s 中第一个不属于 args 的字符|
|s.find_last_not_of(args)|查找 s 中最后一个不属于 args 的字符|

**上表中的args**

|操作|说明|
|--|--|
|c, pos|在 s 中从 pos 开始查找字符 c|
|s1, pos|在 s 中从 pos 开始查找 string 对象 s1|
|cp, pos|在 s 中从 pos 开始查找 cp 所指以 null 结束的字符数组|
|cp, pos, n|在 s 中从 pos 开始查找 cp 所指以 null 结束的字符数组前 n 个字符|

#### string 对象的比较 ####

|操作|说明|
|--|--|
|s.compare(s1)|s 与 s1比较|
|s.compare(pos, n, s1)|s 从 pos 开始长为 n 的子串与 s1 比较|
|s.compare(pos, n, s1, pos1, n1)|s 从 pos 开始长为 n 的子串与 s1 从 pos1 开始长为 n1 的子串比较|
|s.compare(cp)|s 与 cp 所指数组比较|
|s.compare(pos, n, cp)|s 从 pos 开始长为 n 的子串与 cp 所指数组比较|
|s.compare(pos, n, cp, n1)|s  从 pos 开始长为 n 的子串与 cp 所指数组前 n1 的子串比较|

### 容器适配器 ###

标准库提供三种顺序容器适配器：queue, priority_queue, stack。

**初始化**

肯定需要包含头文件

```cpp
#include <stack>
#include <queue>

// deq 是 deque<int> 类型
stack<int> stk(deq);
```

**覆盖适配器的基础容器类型**

默认情况下，stack 和 queue 都基于 deque 实现，priority_queue 则基于 vector 实现。通过将一个顺序容器指定为适配器的第二个实参，可以覆盖基础容器类型

```cpp
// empty stack implemented on vector
stack< string, vector<string> > str_stk;
```

> 两个相同类型的适配器可以做关系运算，第一个不对等的元素决定大于或小于关系。

#### 栈适配器 ####

栈的操作

|操作|说明|
|--|--|
|stk.empty()|为空，返回 true|
|stk.size()|返回栈中元素个数|
|stk.pop()|删除栈顶元素，但不返回其值|
|stk.top()|返回栈顶元素，但不删除其值|
|stk.push(item)|将 item 压入栈|

例如：

```cpp
#include <iostream>
#include <stack>

using namespace std;

int main()
{
	const stack<int>::size_type sz = 10;
	stack<int> istk;
	int ix = 0;
	while (istk.size() != sz)
	{
		istk.push(ix++);
	}
	int error_cnt = 0;
	while (istk.empty() == false)
	{
		int value = istk.top();
		if (value != --ix)
		{
			cerr << "expected " << ix << "recieved " << value << endl;
			++error_cnt;
		}
		cout << value << endl;
		istk.pop();
	}
	cout << "errors: " << error_cnt << endl;
    return 0;
}

// prints:
9
8
7
6
5
4
3
2
1
0
errors: 0
```

#### queue 和 priority_queue ####

操作

|操作|说明|
|--|--|
|q.empty()|为空，返回 true|
|q.size()|返回队列中元素个数|
|q.pop()|删除队首元素，但不返回其值|
|q.front()|返回队首元素，但不删除其值。**只适用于queue**|
|q.back()|返回队尾元素，但不删除其值。**只适用于queue**|
|q.top()|返回优先级最高的元素，但不删除其值。**只适用于priority_queue**|
|q.push(item)|queue： 将 item 压入队尾<br/>priority_queue：基于优先级压入队列|

END.