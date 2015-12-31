title: '语句'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-12-17 16:13:33
---

开始学习第六章《语句》

### 1、简单语句 ###

**空语句**

```C++
;
```
只有一个分号。在某些条件下使用，如从输入流读入数据，而不需操作：
```C++
while （cin >> s && s != "abc")
	;	// null statement
```
> 使用空语句时最好加上注释

<!-- more -->

```C++
a = b + 1;;
```
看似非法的分号，其实是一个空语句。但并不意味着就能随便使用，如

```C++
while (iter != vec.end()) ;	// while循环体为空
	++iter;	// 不是循环体的一部分
```
会无限循环。

**复合语句（块）**

用花括号括起来的语句序列（也可能为空）。如 for 和 while

```C++
while (cin >> trans)
	if (total.same_isbn(trans))
		total = total + trans;
	else {
		cout << total << endl;
		total = trans;
	}
```
`else` 分支需要用块语句。

> 块语句并不是以分号结束

也可以是 **空块**

```C++
while (cin >> s && s != "abc")
{}	// 空块
```

**语句作用域**

```C++
while (int i = get_num())
	cout << i << endl;
i = 0;	// error
```
`i` 超出了作用域。

**控制结构中引入的变量是局部变量**，仅在块语句结束前有效。

```C++
for (vector<int>::size_type index = 0;
		index != vec.size(); ++index)
{
	int square = 0;
	if (index % 2)
		square = index * index;
	vec[index] = square;
}
if (index != vec.size())	// error
```
如果要在控制语句外访问，则需定义在控制语句外
```C++
vector<int>::size_type index = 0
for (; index != vec.size(); ++index)
{
	int square = 0;
	if (index % 2)
		square = index * index;
	vec[index] = square;
}
if (index != vec.size())	// ok
```

### 2、if语句 ###

**if语句**
```C++
if (condition1)
{
	statement1
}
else if (condition2)
{
	staement2
}
else
{
	staement3
}
```
目前为止，除了 vector 和 string 类型一般不可作为条件外，均可作为if语句的条件，包括 IO 类型。

> 各分支语句用 `{}` 括起来是一个好的习惯

**if语句可以嵌套**

例如，
```C++
if (condition1)
{
	if (condition2)
	{
		statement1
	}
	else
	{
		staement2
	}
}
else
{
	// use if statement here also valid
	staement3
}
```

END.

---

Github Pages同步更新: [Humooo's Blog][1]

[1]: http://bluestein.github.io/