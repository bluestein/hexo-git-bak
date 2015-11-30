title: '9:bitset类型'
tags:
- C++
- C++ primer
categories: 
- Dev
- C++
date: 2015-11-19 16:49:39
---

有些程序需要处理二进制位的有序集，每位个能包含 0 或 1。 **bitset** 类型简化了位集的处理，使用时必须包含头文件

<!-- more -->

```C++
#include <bitset>
using std::bitset;
```

### 1、bitset对象的初始化 ###
---

类似于 vector，bitset也是一种类模板。bitset 类型之间的区别在于其长度而不是类型，在定义 bitset 类型时，要明确其含有多少位，`<>` 内指定它的长度：

```C++
bitset<32> b;
```

给出的长度也可以是 **常量表达式**，长度必须定义为整型字面值常量或已用常量值初始化的整型const对象。

上面的对象 `b` 含有32个位，每位都是 0。跟 vector 类似，`b` 中的位也没有命名，可以按位置来访问。位置： 0 ~ 31，以 0 开始的位串是 **低阶位（low-order bit）**，以 31 位结尾的位串是 **高阶位（high-order bit）**。

所有方法如下表

|初始化方法|-|
|-|-|
|bitset<n> b;|b 有 n 位，每位为 0|
|bitset<n> b(u);|b 是 unsigned long 型 u 的一个副本|
|bitset<n> b(s);|b 是 string 对象 s 中含有的位串的副本|
|bitset<n> b(s, pos, n);|b 是 s 中从位置 pos 开始的 n 个位的副本|

#### 1.1、用unsigned值初始化bitset对象 ####

用unsigned long值初始化bitset对象时，该值会转化为二进制位模式。bitset 作为这种位模式的副本，如果bitset类型的长度大于unsigned long值的二进制位数，则其余的高阶位将置为0；如果bitset类型的长度小于二进制位数，则只使用unsigned值中的低阶位，超过bitset类型长度的高阶位将被丢弃。

在32位unsigned long的机器上，十六进制 `0xffff` 表示为二进制位就是16个1和16个0（每个 `0xf` 可以表示 `1111`）

```C++
bitset<16> b1(0xffff);	//0~15位为1
bitset<32> b2(0xffff);	//0~15位为1；16~31位为0
bitset<128> b3(0xffff);	//0~15位为1；16~31位为0；32~127位为0
```

`b1` 位数少于unsigned long的位数，所以高阶位被丢弃；`b2` 与unsigned long长度相同，所有位正好放初始值；`b3` 长度大于 32，31 位以上的高阶位就被置为 0.

#### 1.2、用string对象初始化 ####

当用string对象初始化bitset对象时，string对象直接使用位模式。从string对象读入位集的顺序是 **从右至左**

```C++
string str1("1100");
bitset<32> b4(str1);
```

`b4` 的位模式中 2~3 位为 1，其余位置为 0。

> 要注意，用 string 对象初始化 bitset 对象时，它们是反转的

也可以使用 string 的子串初始 化bitset 对象

```C++
string str2("11000001111100001011");
bitset<16> b5(str2, 5, 4);				//从下标为5开始长度为4的子串 "0011"
bitset<16> b6(str2, str2.size() - 4);	//使用最后4个位 "1011"
```

详细的为

```C++
b5: 0000 0000 0000 0011
b6: 0000 0000 0000 1011
```

### 2、bitset对象的操作 ###

|操作|-|
|-|-|
|b.any()|b 中是存在为1的二进制位|
|b.none()|b 中二进制位是否全为0|
|b.count()|b 中为1的二进制位的个数|
|b.size()|b 中二进制位的个数|
|b[pos]|访问 b 中位置为 pos 的二进制位|
|b.test(pos)|b 中位置为 pos 的二进制位是否为 1|
|b.set()|把 b 中所有二进制位置为 1|
|b.set(pos)|b 中位置为 pos 的二进制位是设为 1|
|b.reset()|把 b 中所有二进制位置为 0|
|b.reset(pos)|b 中位置为 pos 的二进制位是设为 0|
|b.flip()|把 b 中所有二进制位逐位反转|
|b.flip(pos)|把 b 中位置为 pos 的二进制位反转|
|b.to_ulong()|用 b 中同样的二进制位返回一个 unsigned long 值|
|os << b|把 b 中的位输出到os流|

举例

- 测试：
```C++
bitset<32> b;	//32位，全0
bool is_set = b.any();		//false
bool is_none = b.none();	//true
```
- count & size：
```C++
size_t cnt = b.count();
size_t siz = b.size();
```
	返回的类型 **size_t** 定义在 **cstddef.h** 中，对应于c语言的 **stddef.h**。

- 下标访问：
```C++
for (int index = 0; index != 32; index += 2) {
	b[index] = 1;
	//下面是等价方式
	//b.set(index);	
}
```
把 `b` 中的偶数位置为 1。

- 操作整个bitset对象
```C++
b.reset();	//set all bits to 0.
b.set();	//set all bits to 1.
b.flip();	//reverse all bits
b.flip(0);	//reverse the first bit
b[0].flip();//as above
```
- to_ulong & cout
```C++
bitset<16> b(0xffff);
unsigned long ulong = b.to_ulong();
cout << "b: " << b << ", ulong: " << ulong << endl;
```
	**仅当bitset类型的长度小于或等于 unsigned long 的长度时**，才可以使用 to_ulong 操作。上例结果

	```C++
	b: 1111111111111111, ulong: 65535
	```

- 位操作符
```C++
bitset 也支持内置的位操作符 `<<` 和 `>>`，后续介绍。
```

END.