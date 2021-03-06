title: '算术操作符'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-10-11 16:50:00
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

这里开始第五章《表达式》的内容。下面是 **算术操作符** 的内容

C++有丰富的操作符，并定义了当操作数是内置类型时操作符的含义。而且C++还支持操作符重载，标准库正是使用该功能定义。

<!-- more -->

表达式是由一个或多个 **操作数（operand）** 通过 **操作符（operator）** 组合而成。每个表达式会产生一个结果，如果表达式中无操作符，则表达式的结果就是操作数本身。如

```C++
int val = 0;
if(val)
	//...
```

将 `val` 看作是if语句的条件表达式。

|操作符|功能|用法|
|--|--|--|
|+|一元正号|+ expr|
|-|一元负号|- expr|
|\*|乘法|expr \* expr|
|/|除法|expr / expr|
|%|求余（操作数只能为整型）|expr % expr|
|+|加法|expr + expr|
|-|减法|expr - expr|

> 注： expre 为表达式

求模 `%` 符号：

- 当两个操作数都是正数（或0）时，结果为正；
- 当两个操作数都是负数，结果为负（或0）
- 一正一负时，求模结果的符号取决于机器；

在我的机器上有

```C++
cout << 10 % 3 << endl;
cout << -10 % -3 << endl;
cout << -10 % 3 << endl;
cout << 10 % -3 << endl;
```

结果

```C++
1
-1
-1
1
```

可以看出：我的机器上，求模结果的符号随分子确定（除出来的值向负无穷一侧取整）。

```C++
cout << -30/3*21%4 << endl;
cout << 30/3*21%5 << endl;
```

结果

```C++
-2
0
```

### 关系操作符和逻辑运算符 ###

|操作符|功能|用法|
|--|--|--|
|!|逻辑非|! expr|
|<|小于|expr < expr|
|<=|小等于|expr <= expr|
|>|大于|expr > expr|
|>=|大等于|expr >= expr|
|==|相等|expr == expr|
|!=|不等于|expr != expr|
|&&|逻辑与|expr && expr|
|(两个竖线)|逻辑或|expr (两个竖线) expr|

> 注： 由于简书markdown格式问题，不能在表格中打出逻辑或 `||` 符号。

上述操作符产生的结果均是bool值。

- `!`: expr为真时， !expr为假；
- `&&`: expr1和expr2都为真时， expr1 && expr2 结果为真，否则为假；
- `||`: expr1和expr2都为假时， expr1 && expr2 结果为假，否则为真；

其中，`&&` 与 `||` 操作符只有当 expr1的值不能确定整个表达式的值时，才会解第二个expr2的值，称为 **短路求值（short-circuit evaluation）**。

> 不能串接使用关系操作符（逻辑操作符可以）： `if(i < j < k)` 是错误的。

下面有一个很有趣的程序

```C++
char *cp = "hello";
while (cp && *cp)
{
	cout << cp << endl;
	cout << *cp << endl;
	++cp;
}
```

输出

```C++
hello
h
ello
e
llo
l
lo
l
o
o
```

### 举例 ###

编写程序：判断四个值a、b、c、d是否满足 a>b、b>c且c>d。

```C++
int main()
{
	int a = 3, b = 2, c = 1, d = 0;
	cout << (a > b && b > c && c > d) << endl;
	return 0;
}
```

结果

```C++
1
```

上述 `&&` 表达式也会采用 **短路求值** 法求解

END.