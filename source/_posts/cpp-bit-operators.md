title: '位操作符'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-10-11 16:50:05
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

位操作符：位操作符操作的整数可以是有符号或无符号数。

|操作符|功能|用法|
|--|--|--|
|~|求位反|~expr|
|<<|左移|expr1 << expr2|
|>>|右移|expr1 >> expr2|
|&|位与|expr1 & expr2|
|^|位异或|expr1 ^ expr2|
|&#124;|位或|expr1 &#124; expr2|

<!-- more -->

下面的例子，假设unsigned char有8位：

- `~`: 类似于bitset的flip操作，即将操作数的每一个二进制位取反，将0置为1,1置为0
```C++
unsigned char bits = 0227;	//八进制数，二进制形式：10010111
bits = ~bits;	//二进制形式：01101000
```

- `>>` 和 `<<`: 向右或向左移动若干位，并丢弃移出去的位，一般来说空位补零
```C++
unsigned char bits = 1;	//二进制形式：00000001
bits = bits << 6;	//二进制形式：01000000；对应十进制：64
cout << bits <<endl;	//64对应的字符为 bits = '@'
int n = bits;
cout << n << endl;	//n = 64
```
- `&`: 两操作数都为1时，结果为1，否则为0
```C++
unsigned char c1 = 0145;	//八进制数，二进制形式：01100101
unsigned char c2 = 0257;	//八进制数，二进制形式：10101111
unsigned char bits = c1 & c2;	//二进制形式：00100101
cout << bits << endl;	//对应的十进制为37，字符为 '÷'
```

- `^`: 两个操作数中只有一个位1时（不能同时两个为1），结果为1，否则为0
```C++
unsigned char bits = c1 ^ c2;	//二进制形式：11001010
cout << bits << endl;	//对应的十进制为202
```

- `|`: 两个操作数都为0时，结果为0，否则为1
```C++
unsigned char bits = c1 | c2;	//二进制形式：11101011
cout << bits << endl;	//对应的十进制为239
```

### bitset对象或整型值的使用 ###

unsigned long 有 32 位

```C++
bitset<30> bset;	//大小为30的bitset，每一位默认值0
unsigned long val = 0;
```

如果要将第27位设为1，有如下两种方式

```C++
bset.set(27);		//法1
val |= 1UL << 27;	//法2
```

- 法1简单明了；
- 法2：将val与另一个整数坐位或 `|` 比较。即需要一个只有第27位为1其他位为0的无符号长整型（unsigned long）整数，可以用下面方法生成
```C++
1UL << 27;
```

如果要将第27位重新设为0

```C++
val &= ~(1UL << 27);
```

而要测试第27位是否为1，则可以

```C++
bool is_1 = val & (1UL << 27);
```

**举例**

```C++
unsigned long val1 = 3, val2 = 8;
cout << (val1 & val2) << endl;
cout << (val1 | val2) << endl;
```

输出

```C++
0
11
```

因为unsigned long有32位，所以 3 对应二进制位为：`0(30个0)11`； 8 的二进制：`0(28个0)1000`

- `val1 & val2`: 0(28个0)0000; 对应的十进制为 0
- `val1 | val2`: 0(28个0)1011; 对应的十进制为 11

> 通常来说，bitset更易阅读和理解。

### 将移位操作符用于IO ###

一直再用的 `cout<<` 和 `cin>>` 就用到了移位操作符，IO操作符是左结合的

```C++
cout << "he" << "llo" << endl;
```

等价于

```C++
((cout << "he") << "llo") << endl;
```

举例

```C++
cout << 10+10;	//ok
cout << (10>2);	//ok
cout << 10 > 2;	//error: 试图将 cout 与 2 比较
```

上例因为 `+` 优先级高于`>>`， 而  `>` 低于 `>>`。 


END.