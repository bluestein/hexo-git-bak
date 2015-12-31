title: 'while, ex6.12'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-12-22 15:03:42
---

### Example ###

将一个数组拷贝到另一个数组

<!-- more -->

```C++
#include <iostream>

using std::cin;
using std::cout;
using std::endl;


int main()
{
	int arr[5] = { 1, 2, 3, 4, 5 };
	int *source = arr;
	size_t sz = sizeof(arr) / sizeof(*arr);
	int *dest = new int[sz];
	while (source != arr + sz) 
	{
		*dest++ = *source++;
	}

	// test
	int *dp = dest - sz;
	for (size_t i = 0; i < sz; ++i) 
	{
		cout << *dp << endl;
		dp++;
	}
	return 0;
}
```

outputs

```C++
1
2
3
4
5
```


### Exercise 6.12 ###

输入一些单词，统计里面单词出现的次数。

如：how, now now now brown cow cow
则需输出: how 1次，now 3次，brown 1次，cow 2次

```C++
#include <iostream>
#include <string>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::vector;

bool isCharacter(char ch) 
{
	return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z');
}

int main()
{
	// 把单词存入vector，并忽略非字母
	string str;
	getline(cin, str);
	const char *cp = str.c_str();
	vector<string> raw;
	string tmp = "";
	while (*cp) {
		if (isCharacter(*cp)) 
		{
			tmp += *cp++;
			if (*cp != '\0') 
			{
				continue;
			}
		}
		
		if (!tmp.empty()) 
		{
			raw.push_back(tmp);
			tmp = "";
		}
		++cp;
	}

	// 统计各单词出现的次数
	vector<string> unique;
	vector<int> cnt;
	unique.push_back(raw[0]);
	cnt.push_back(0);
	for (vector<string>::size_type i = 0; i != raw.size(); ++i) 
	{
		bool found = false;
		for (vector<string>::size_type j = 0; j != unique.size(); ++j) 
		{
			if (raw[i] == unique[j]) 
			{
				++cnt[j];
				found = true;
			}
		}
		if(!found) 
		{
			unique.push_back(raw[i]);
			cnt.push_back(1);
		}
	}

	// 输出
	int max = cnt[0];
	int max_index = 0;
	vector<int>::size_type i = 0;
	for (; i != cnt.size(); ++i)
	{
		cout << "单词：" << unique[i] << ",出现次数为：" << cnt[i] << endl;
		if (max < cnt[i]) 
		{
			max = cnt[i];
			max_index = i;
		}
	}
	cout << endl <<"出现最多的是："<< unique[max_index] << ",次数为：" << cnt[max_index] << endl;

	return 0;
}
```

outputs

```C++
how, now now now brown cow cow↙
单词：how,出现次数为：1
单词：now,出现次数为：3
单词：brown,出现次数为：1
单词：cow,出现次数为：2

出现最多的是：now,次数为：3
```