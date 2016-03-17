title: '参数传递'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-12-29 20:49:49
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### 引用型形参 ###

利用引用形参，交换两个数的值

```C++
void rSwap(int &v1, int &v2)
{
	int temp = v1;
	v1 = v2;
	v2 = temp;
}
```

<!-- more -->

> 利用引用型的形参，可以解决函数只能返回一个值得情况

比如，在某个vector中寻找某个特定的值，然后返回它出现的位置及出现的次数

```C++
vector<int>::const_iterator findValue(
	vector<int>::const_iterator begin,
	vector<int>::const_iterator end,
	int value,
	vector<int>::size_type &occurs)
{
	vector<int>::const_iterator result_iter = end;
	occurs = 0;
	for (; begin != end; ++begin)
	{
		if (*begin == value)
		{
			// remember first occurrence of value
			if (result_iter == end)
			{
				result_iter = begin;
			}
			++occurs;
		}
	}
	return result_iter;
}
```

### 利用const引用避免复制 ###

一般的形参传递时需要复制，引用不需要。当使用大型引用形参时，为了避免复制实参，使用const引用。

```C++
bool isShorter(const string &s1, const string &s2)
{
	return s1.size() < s2.size();
}
```

形参是引用，所以不需要复制实参；形参是const，所以不能通过该引用形参来修改实参的值。

### 传递指针的引用 ###

交换指向数值的指针

```C++
void prSwap(int *&v1, int *&v2)
{
	int *temp = v1;
	v1 = v2;
	v2 = temp;
}
```

### vector或其他容器作为形参 ###

为避免直接使用vector等类型做形参，一般使用它们的迭代器。

```C++
void print(	vector<int>::const_iterator begin,
			vector<int>::const_iterator end)
{
	while(begin != end)
	{
		cout << *begin++;
		if (begin != end) cout << " ";
	}
	cout << endl;
}
```

### 数组作为形参 ###

肯定不能直接传递数组，通常使用指针进行操作。而下面三种是等价的

```C++
void print(int *);
void print(int[]);
void print(int[10]);
```

但是后两种很容易引起误解。下面可以看出是否真的等价

```C++
void printv(const int ia[10])
{
	for (size_t i = 0; i != 10; ++i)
	{
		cout << ia[i] << endl;
	}
}

int v1 = 32, arr[2] = {4, 0};
printv(&v1); //编译ok, 但会输出其他9个其他的值或者运行时错误
printv(arr); //编译ok, 但会输出其他8个其他的值或者运行时错误
```

> 编译器不会检查形参数组的大小。

### 通过引用传递数组 ###

一般来讲，将数组作为形参传递给函数都会被转换为指针，但是数组的引用不会。此时，传递的是数组的引用本身，编译器会检查形参数组的大小。

```C++
void print(int (&arr)[3]);
int i = 0, j[2] = {0, 1};
int k[3] = {0, 1, 2};
print(&i); // error
print(j); // error
print(k); // ok
```

### 多维数组的传递 ###

所谓多维数组，就是数组的数组。它的每个元素就是一个数组，第二维必须指定

```C++
void print(int (matrix*)[10], int row_size);
// 或者
void print(int matrix[][10], int row_size);
```

`matrix` 是指向含10个int值的数组的指针。

### 在函数内处理数组 ###

任何数组的操作都必须保持在数组的边界内。

有三种常见的方法可以保证这一点：
1. 第一种是在数组的本身放置一个标记进行检测数组的结束。如C风格的字符串，使用 `\0` 标记表示结束；
2. 第二种是传递指向数组的第一个和最后一个元素的下一个位置的指针；
3. 显式地传递数组的大小。意思是告诉函数，我的大小是多少；
```C++
void print(const int ia[], size_t size)
{
	for (size_t i = 0; i < size; ++i)
	{
		cout << ia[i] << endl;
	}
}
```