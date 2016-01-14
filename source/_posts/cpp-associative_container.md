title: '关联容器'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2016-01-14 14:49:02
---

关联容器（associative container）支持通过键（key）来高效地查找和读取元素。它与顺序容器的主要区别在于：**关联容器通过键存储和读取元素，而顺序容器则通过元素在容器中的位置顺序类存储和访问元素**。

两个基本的关联容器是 map 和 set。

1. map 以 key-value（键-值） 的形式组织：键作为元素在 map 中的索引，而值则表示所要存储和读取的元素。
2. set 仅包含键，可以看成含有很多键值得集合。

|关联容器|说明|
|--|--|
|map|关联数组|
|set|集合|
|multimap|一个键可出现多次的 map 类型|
|multiset|一个键可出现多次的 set 类型|

<!-- more -->

一般来说，**如果想有效的存储不同值得集合**，使用 set 比较合适；而 map 容器则更适合用于存储键关联值得情况。
比如在文本处理时，可以使用 set 来存储要忽略的词，而 map 可以使用作字典：单词本身是键，其解释是值。

> set 和 map 的键是唯一的，每个键只能出现一次。如果想使用一个键对应多个值得情况，那么使用 multiset 和 multimap 类型。

### pair 类型 ###

在介绍关联容器之前，必须先了解一种与之相关的简单的标准库类型——pair 类型，在 `utility` 头文件中定义

|pair 类型所提供的操作|说明|
|--|--|
|pair<T1, T2> p1|创建一个空的 pair 对象，它的两个元素分别是 T1 和 T2 类型，采用**值初始化**|
|pair<T1, T2> p1(v1,v2)|创建一个 pair 对象，它的两个元素类型分别是 T1 和 T2。其中 first 成员初始化为 v1，second 成员初始化为 v2|
|make_pair(v1, v2)|用 v1 和 v2 创建一个 pair 对象，其元素的类型分别是 v1 和 v2 的类型。|
|p1 < p2|两个 pair 对象的小于运算，其定义遵循字典次序：如果 `p1.first < p2.first` 或 `!(p2.first < p1.first) && p1.second < p2.second` 则返回 true|
|p1 == p2|等于操作|
|p.first|返回 p 中的 first（第一个） 成员|
|p.second|返回 p 中的 second（第二个） 成员|

#### pair 的创建和初始化 ####

在创建 pair 对象时，必须提供两个类型名，这两个类型名不必相同：

```cpp
pair<string, string> anon;
pair<string, int> word_count;
pair<string, vector<int> > line;
```

**创建 pair 时，如果不提供初始化式，则调用默认构造函数进行值初始化。**所以，`anon` 是包含两个空 string 成员的 pair 对象； `word_count` 中的 int 型成员获得 0 值； `line` 则是存储一个空 string 和一个空 vector 类型的对象。

也可以提供初始化式：

```cpp
pair<string, string> author("James", "Joyce");
```

pair 类型使用起来较繁琐，可以使用 typedef 简化声明：

```cpp
typedef pair<string, string> Author;
Author proust("Marcel", "Proust");
Author joyce("James", "Joyce");
```

#### pair 对象操作 ####

与其他标准库类型不同，对于 pair 类型，**可以直接访问其数据成员，它的成员都是公有的**。分别命名为 first 和 second。

```cpp
string firstBook;
if (author.first == "James" && author == "Joyce")
	firstBook = "Stephen Hero";
```

除了构造函数之外，标准库还提供一个 make_pair 函数

```cpp
pair<string, string> next_auth;
string first, last;
while (cin >> first >> last) {
	next_auth = make_pair(first, last);
	// process next_auth...
}
```

因为成员是公有的，所以可以直接输入

```cpp
pair<string, string> next_auth;
while (cin >> next_auth.first >> next_auth.second) {
	// process next_auth...
}
```

### 关联容器 ###

关联容器与顺序容器共享大部分的操作，但并不是全部。关联容器不支持 **front, push_front, pop_front, back, push_back, pop_back** 等操作。共享的包括：

1. 三种构造函数：
```cpp
C<T> c;
C<T> c1(c2);
C<T> c(begin, end);
```
2. 关系运算
3. begin，end，rbegin，rend
4. typedef。注意：对于 map 类型，**value_type 的类型是 pair 类型。**
5. swap 和 赋值操作。**但不提供 assign 函数**。
6. clear，erase。**关联容器 erase 操作返回 void 类型**。
7. 容器大小的操作。**不支持 resize 操作**。

对于与顺序容器相同的操作，关联容器重新定义了这些操作的含义或返回类型，主要区别在于关联容器中使用了键。

> 元素在关联容器中根据键的顺序排列。

### map 类型 ###

map 可以理解为 **关联数组**，但是通过键获取元素值，而不是位置。

#### map 的定义 ####

要使用 map 需包含 map 头文件

|map 的构造函数|说明|
|--|--|
|map<k, v> m;|空 map 对象，键和值得类型分别为 k 和 v|
|map<k, v> m(m1)|创建 m1 的副本|
|map<k, v> m(begin, end);|创建 begin 至 end 范围内所有元素的副本|

**键类型的约束**

在使用关联容器时，**它的键类型必须要有一个比较函数**。所使用的比较函数必须在键类型上**严格弱排序**。所谓严格弱排序，可以理解为键类型数据上的“小于”关系，不能出现相互“小于”的情况。

> 在实际应用中，键类型必须定义 < 操作符，而且该操作符能正确的工作。

#### map 定义的类型 ####

map 对象是键-值对，每个元素分为两个部分：键和其关联的值。map 的 value_type 可以很清楚的表示这种情况，该类型是 pair 类型。

|map 定义的类型|说明|
|--|--|
|map<K, V>::key_type|键的类型|
|map<K, V>::mapped_type|值的类型|
|map<K, V>::value_type|键-值的类型：pair类型。有 first 和 second 两个公有成员|

对 map 的迭代器解引用会产生一个 pair 类型值：

```cpp
map<string, int>::iterator map_it = word_count.begin();
cout << map_it->first;
cout << map_it->second;
map_it->first = "new key"; // error: key is const
++map_it->second; // ok
```

#### 向 map 添加元素 ####

**下标**

```cpp
map<string, int> word_count;
word_count["Anna"] = 1;
```

上面程序会发生：

1. 在 `word_count` 中查找键为 Anna 的元素，没有找到；
2. 将一个键为 Anna 的 pair 插入到 `word_count`，该 pair 的值为 ("Anna", 0)。
3. 读取新插入的元素，并将它赋值为 1.

> 故使用下标访问 map 中没有的元素会导致向该容器中添加一个新元素。

**insert**

|insert 操作|说明|
|--|--|
|m.insert(p);|p 是 value_type 类型的值，如果 p.first 不存在，则插入 p 到 m，否则 m 保持不变。该函数返回一个 pair 对象，包含一个指向 p 的 map 的迭代器，和一个 bool 值。|
|m.insert(begin, end);|插入 begin 和 end 范围内的值。返回 void 类型|
|m.insert(iter, p)|如果 p.first 不在 m 中，则以 iter 为起点搜索 p 的存储位置。返回一个迭代器，指向新插入的 p。|

```cpp
word_count.insert(map<string, int>::value_type("Anna", 1));
word_count.insert(make_pair("Anna", 1)); // equivalent way
```

**insert 的返回值类型**

```cpp
pair<map<string, int>::iterator, bool> ret = word_count.insert(make_pair("Anna", 1));
// use typedef
typedef pair<map<string, int>::iterator, bool> ret_type;
ret_type ret = word_count.insert(make_pair("Anna", 1)); // equivalent way
```

#### 查找 map 中的元素 ####

读取 map 中一个元素最简单的方法是下标：

```cpp
map<string, int> word_count;
int occurs = word_count["Anna"];
```

但是有个弊端：如果该键不在 map 中，则会插入之。

对于查找或读取元素，map 提供了两个操作： count 和 find。

1. find： `m.find(key)`, 如果存在 key 索引的元素，返回指向该元素的迭代器，否则返回末端迭代器，即 end()；
2. count：`m.count(key)`,  返回 m 中 k 出现的次数；

```cpp
int occurs = 0;
if (word_count.count("Anna"))
	occurs = word_count["Anna"];
```

这里对元素做了两次查询，在优化性能时可以考虑。find 则更适合查询元素：

```cpp
int occurs = 0;
map<string, int>::iterator it = word_count.find("Anna");
if (it != word_count.end())
	occurs = it->second;
```

#### 从 map 删除元素 ####

|删除元素|说明|
|--|--|
|m.erase(key)|删除键为 k 的元素。返回 size_type 类型的值，表示删除元素的个数|
|m.erase(iter)|删除迭代器 iter 指向的元素。iter 必须指向存在的元素，且不能等于 m.end()。返回 void 类型。|
|m.erase(begin, end)|删除范围内的元素。返回 void 类型。|

### set 类型 ###

set 跟 map 不同，它只是单纯的键的集合。支持：

1. insert
2. count，find
3. erase

另外：

1. 不支持下标操作；
2. 没有 mapped_type 类型；

#### set 类型的定义和使用 ####

set 存放的是一系列唯一值的集合。例如：

```cpp
vector<int> ivec;
for (vector<int>::size_type i = 0; i != 10; ++i) {
	ivec.push_back(i);
	ivec.push_back(i);
}
set<int> iset(ivec.begin(), ivec.end());
cout << ivec.size() << endl; // prints 20
cout << iset.size() << endl; // prints 10
}
```

**向 set 添加元素**

```cpp
set<string> sset;
sset.insert("C.X.Q");
sset.insert("I L U");
set<int> iset;
iset.insert(ivec.begin(), ivec.end());
```

**从 set 中获取元素**

set 不提供下标操作，只能使用 find 和 count 函数，count 函数的返回值只能是 1 或 0，因为里面的元素都是唯一的。正如不能修改 map 的键一样，set 中的键也是 const 类型。在获得指向 set 中某元素的迭代器后，只能对其做读操作，不能做写操作。


### multiset 和 multimap ###

map 和 set 中键都是唯一的，而 multimap 和 multiset 类型则允许同一个键多次出现。也就是说每次调用 insert 都会添加一个元素，而 erase 则会删除跟该键有关的所有元素。

#### multiset 和 multimap 中查找元素 ####

在 multimap 中，同一个键的所有元素都相邻存放。

**使用 find 和 count 函数**

count 返回某个键的出现的次数，find 返回的是一个迭代器，指向第一个正在查找的键的实例。

```cpp
string search_item("C.X.Q.");
typedef multimap<string, string>::size_type sz_type;
sz_type entrise = authors.count(search_item);
multimap<string,string>::iterator iter = authors.find(search_item);
for (sz_type cnt = 0; cnt != entrise; ++cnt, ++iter)
	cout << iter->second << endl;
```

**另一种解决办法**

|返回迭代器的关联操作|说明|
|--|--|
|m.lower_cound(key)|返回一个迭代器，指向第一个不小于 key 的元素|
|m.upper_bound(key)|返回一个迭代器，指向第一个大于 key 的元素|
|m.equal_range(key)|返回一个迭代器的 pair 对象<br/>first 成员等价于 m.lower_bound(key),second 成员等价于 m.upper_bound(key)|

END.