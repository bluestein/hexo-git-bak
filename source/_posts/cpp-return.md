title: 'return'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-12-30 14:11:49
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

return 语句用于结束当前正在执行的函数，并将控制权返回给调用此函数的函数。有两种形式：


```C++
return;
return expression;
```

<!-- more -->

### 没有返回值的函数 ###

不带返回值的return语句用于 void 类型的函数。在 void 类型的函数中，return 语句不是必须的，它会在函数的最后一个语句隐式的完成。

**隐式的return**

```C++
void doSwap(int &v1, int &v2)
{
	int tmp = v2;
	v2 = v1;
	v1 = tmp;
	// 隐式的return
}
```

**return**

```C++
void doSwap(int &v1, int &v2)
{
	if (v1 == v2)
	{
		return; // 不带返回值的return
	}
	int tmp = v2;
	v2 = v1;
	v1 = tmp;
	// 隐式的return
}
```

### 有返回值的函数 ###

使用第二种形式，即 `return expression;` 返回值给非 void 函数。

#### 主函数 main 的返回值 ####

可将 main 函数的返回值作为状态指示器，0 表示运行成功，其他返回值则因机器的不同而不同，因此 cstdlib 头文件定义了两个预定于变量 `EXIT_FAILURE` `EXIT_SUCCESS`。

```C++
#include <sctdlib>
int main()
{
	if (some_failure)
	{
		return EXIT_FAILURE;
	} else {
		return EXIT_SUCCESS;
	}
}
```

#### 返回非引用类型 ####

此时可以返回局部对象，或表达式的结果

```C++
string makePlural(size_t ctr, const string &word, const string &ending)
{
	return (ctr == 1) ? word : word + ending;
}
```

#### 返回引用 ####

返回的是对象本身

```C++
const string &shorterString(const string &s1, const string &s2)
{
	return s1.size() > s2.size() ? s1 : s2;
}
```

#### 不能返回局部变量的引用 ####

因为程序执行完毕时，将释放该对象的存储空间

```C++
const string &mainp(const string &s)
{
	string ret = s;
	return ret; // wrong: local object
}
```

> 同样不要返回局部变量的指针

#### 引用返回左值 ####

可以使用在要求使用左值的地方

```C++
char &getVal(string &str, string::size_type ix)
{
	return str[ix];
}
int main()
{
	string s("a string");
	getVal(s, 0) = 'A';
	cout << s << endl;
	return 0;
}
// prints: 
// A string
```

如果不想引用返回值被修改，则返回值应声明为const： `const char &getVal(...`。

### 递归 ###

间接或直接调用子集的函数称为递归函数（recursion function）。例如阶乘运算

```C++
int fact(int val)
{
	if (val > 1) {
		return fact(val - 1) * val;
	}
	return 1;
}
```

或最大公约数

```C++
int rgcd(int v1, int v2) {
	if (v2 != 0) {
		return rgcd(v2, v1 % v2);
	}
	return v1;
}
```

对于 `fact` 与 `rgcd` 它们的终止条件分别是： `val = 1`; 余数等于零。

END.