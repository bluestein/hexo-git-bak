title: 'Cpp:赋值操作和自增自减'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-26 16:50:15
---

本次内容是：复合表达式的求值。尤其是 **优先级** 和 **结合性** 部分可以作为字典查看。

### 1、优先级 ###

在表达式求解过程中，优先级关系到表示如何分组，会影响整个表达式的值。其次是结合性，当优先级相同时，结合性决定求解次序。算术操作符具有左结合性，即从左至右结合

<!-- more -->

```C++
3 + 2 * 3 / 2 - 1
```

等价于

```C++
int tmp = 2 * 3;
int tmp2 = tmp / 2;
int tmp3 = tmp2 + 3;
int result = tmp3 - 1;
```

> 括号可以改变优先级，括号内的表达式先行计算。

### 2、结合性 ###

结合性规定了具有相同优先级的操作符如何分组。如 **赋值操作符** `=` 具有右结合性，所以允许将多个赋值操作串连起来：

```C++
val1 = val2 = val3;
(val1 = (val2 = val3));	//与上式等价
```

而 **算术操作符** 具有右结合性：

```C++
val1 * val2 / val3;
((val1 * val2) / val3);	//与上式等价
```

下表是按照优先级顺序给出操作符，并用空行分成不同的段，每段内的优先级相同，且都高于后面各段的优先级。

|操作符|结合性|功能|用法|
|--|--|--|--|
|::|L|全局作用域|::name|
|::|L|类作用域|class::name|
|::|L|名字空间作用域|namespace::name|
|&nbsp;|-|-|-|
|.|L|成员选择|object.member|
|->|L|成员选择|pointer->member|
|[]|L|下标|variable[expr]|
|()|L|函数调用|name(expr_list)|
|()|L|函数构造|type(expr_list)|
|&nbsp;|-|-|-|
|++|R|后自增|lvalue++|
|--|R|后自减|lvalue--|
|typeid|R|类型ID|typeid(type)|
|typeid|R|运行时ID|typeid(expr)|
|显式强制类型转换|R|类型转换|cast_name<type>(expr)|
|&nbsp;|-|-|-|
|sizeof|R|对象大小|sizeof expr|
|sizeof|R|类型大小|sizeof(type)|
|++|R|前自增|++lvalue|
|--|R|前自减|--lvalue|
|~|R|位求反|~expr|
|!|R|逻辑非|!expr|
|-|R|一元负号|-expr|
|+|R|一元正号|+expr|
|*|R|解引用|*expr|
|&|R|取地址|&expr|
|()|R|类型转换|(type)expr|
|new|R|创建对象|new type|
|delete|R|释放对象|delete expr|
|delete[]|R|释放数组|delete[] expr|
|&nbsp;|-|-|-|
|->\*|L|指向成员操作的指针|ptr->\*ptr_to_member|
|.*|L|指向成员操作的指针|obj.*ptr_to_member|
|&nbsp;|-|-|-|
|\*|L|乘法|expr \* expr|
|/|L|除法|expr / expr|
|%|L|求模（求余）|expr % expr|
|&nbsp;|-|-|-|
|+|L|加法|expr + expr|
|-|L|减法|expr - expr|
|&nbsp;|-|-|-|
|<<|L|位左移|expr << expr|
|>>|L|为右移|expr >> expr|
|&nbsp;|-|-|-|
|<|L|小于|expr < expr|
|<=|L|小等于|expr <= expr|
|>|L|大于|expr > expr|
|>=|L|大等于|expr >= expr|
|&nbsp;|-|-|-|
|==|L|等于|expr == expr|
|!=|L|不等于|expr != expr|
|&nbsp;|-|-|-|
|&|L|位与|expr & expr|
|&nbsp;|-|-|-|
|^|L|位异或|expr ^ expr|
|&nbsp;|-|-|-|
|&#124;|L|位或|expr &#124; expr|
|&nbsp;|-|-|-|
|&&|L|逻辑与|expr && expr|
|&nbsp;|-|-|-|
|&#124;&#124;|L|逻辑或|expr &#124;&#124; expr|
|&nbsp;|-|-|-|
|?:|R|条件操作|expr|
|&nbsp;|-|-|-|
|=|R|赋值操作|lvalue = expr|
|\*=, /=, %=|R|复合赋值操作|expr \*= expr等|
|+=, -=|R|复合赋值操作|expr += expr等|
|<<=, >>=|R|复合赋值操作|expr <<= expr等|
|&=, &#124;=, ^=|R|复合赋值操作|expr &= expr等|
|&nbsp;|-|-|-|
|throw|R|抛出异常|throw expr|
|&nbsp;|-|-|-|
|,|R|逗号|expr, expr|

**举例**

考虑：如果字符串不是以's'结尾则加上's'，分析下列语句

```C++
string s = s + s[s.size() - 1] == 's' ? "" : "s";
```

分析：

根据上表知道优先级为：`.` = `()` = `[]` > `-` = `+` > `==` > `?:` > `=`；可知上述语句的结合顺序是

```C++
(string s = (((s + (s[(s.size()) - 1])) == 's') ? "" : "s"));
```

很明显不能得到想要的结果，改成如下形式即可

```C++
string s = s + (s[s.size() - 1] == 's' ? "" : "s");
```

END.