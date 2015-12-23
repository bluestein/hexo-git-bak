title: 'Cpp:赋值操作和自增自减'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-25 16:50:10
---

**1、赋值操作**

赋值的左操作数必须是非const左值：

```C++
int i, j, val;
const int ci = i;	//ok
1024 = val;		//error: 字面值是右值
i + j = val;	//error: 算术运算结果是右值
ci = val;		//error: 不能赋值
```

<!-- more -->

**右结合性**

```C++
int val1, val2;
val1 = val2 = 0;
```

上述语句将 val2 赋给 val1.但下面是错误的

```C++
int val, *p;
val = p = 0;	//error
```

上面: `p=0` 成立，但 `val = p` 出错。

**复合赋值操作符**

|说明|操作符|
|--|--|
|算术操作符|+= -= *= /= %=|
|位操作符|<<= >>= &= ^= &#124;=|

使用方法

```C++
a op= b;	//op表示操作符
```

等价于

```C++
a = a op b;
```

**2、自增自减**

```C++
int i = 0, j;
j = ++i;	//j = 1, i = 1; ++i返回自增后的结果
j = i++;	//j = 1, i = 2; i++返回未自增的结果
```

**组合使用解引用和自增**

```C++
vector<int>::iterator iter = ivec.begin();
while(iter != ivec.end()){
	cout << *iter++　<< endl;
}
```

自增的优先级高于解引用，即相当于 `*(iter++)`。

**箭头操作符**

C++为包含 **点操作** 和 **解引用** 的表达式提供 **箭头操作符**。

```C++
Item *p = &item1;
(*p).func();	//1
p->func();		//2
```

1,2 等价。

**举例**

编写程序：定义vector对象，其每个元素指向string类型的指针；输出每个元素的内容及长度。

```C++
string s;
vector<string *> v;
while (cin >> s)
{
	string *sp = new string(s);
	v.push_back(sp);
}
vector<string *>::iterator iter = v.begin();
while (iter != v.end()) {
	string *tmp = *iter;
	cout << tmp->size() << ", " << *tmp << endl;
	delete tmp;
	iter++;
}
```

测试结果

```C++
hello↙
world!↙
^Z↙
5, hello
6, world!
```

**条件操作符**

```C++
cond ? expr1 : expr2;
```

先计算 `cond` 的值，如果为true，则计算 `expr1`，否则计算 `expr2`。可以嵌套使用，如：求三个数的最大值

```C++
int max = i > j
	? i > k ? i : k
	: j > k ? j : k;
```

但并不推荐这样做，可以换成下列代码：

```C++
int max = i;
if (j > max)
	max = j;
if (k > max)
	max = k;
```

输出表达式中使用条件操作符

```C++
cout << (i<j?i:j) <<endl;	//ok
cout << (i<j)?i:j;	//打印1或0
cout << i<j?i:j <<endl;		//error: 将cout与int比较
```

第二句相当于

```C++
cout << (i<j);	//打印1或0，然后返回cout对象
cout ? i : j;	//检测cout，然后计算i或j
```

**sizeof操作符**

返回一个对象或类型名的长度

```C++
sizeof(type_name);
sizeof(expr);
sizeof expr;
```

- 对char类型或char类型值做sizeof结果为1；
- 对指针，返回存放该指针所需的内存；若需要获得指针所指内容，需要解引用操作；
- 对数组，等价于对数组元素做sizeof再乘以元素的个数；

**逗号操作符**

是一组由逗号分隔的表达式，这些表达式从左至右计算，结果是其最右边的表达式值

```C++
int cnt = vec.size();
for(vector<int>::size_type ix = 0; ix != vec.size(); ++ix, --cnt)
	vec[ix] = cnt;
```

每次循环，ix自增1，cnt自减1.

END.