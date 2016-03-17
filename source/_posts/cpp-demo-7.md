title: 'ex6.16'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-12-22 20:03:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Exercise 6.16 ###

比较两个int型vector对象，判断一个是否是另一个的前缀。
即，假设有{ 0, 1, 1, 2 } 和 { 0, 1, 1, 2, 3, 5, 8 }则应返回true。

<!-- more -->

```C++
#include <iostream>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::vector;

bool isPrefix(vector<int> a, vector<int> b)
{
	int sz1 = a.size(), sz2 = b.size();
	int sz = sz1 > sz2 ? sz2 : sz1;
	int matched = 0;
	for (size_t i = 0; i < sz; i++)
	{
		if (a[i] == b[i]) 
		{
			++matched;
		}
	}
	return sz == matched;
}

int main()
{
	int arr1[4] = { 0, 1, 1, 2 };
	int arr2[7] = { 0, 1, 1, 2, 3, 5, 8 };
	int sz1 = sizeof(arr1) / sizeof(*arr1);
	int sz2 = sizeof(arr2) / sizeof(*arr2);
	vector<int> vec1(arr1, arr1 + sz1);
	vector<int> vec2(arr2, arr2 + sz2);
	cout << isPrefix(vec1, vec2) << endl;
	return 0;
}
```

outputs

```C++
1
```