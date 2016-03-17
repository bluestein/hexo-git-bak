title: '输入多个string对象，并存放在vector中'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-11-10 22:01:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Example ###

读入一组string类型数据，将它们存储在vector中，然后将vector中的对象复制给一个字符指针数组。即为vector中的每个元素创建一个新的字符数组，然后把vector元素的数据复制到相应的字符数组中，最后将指针插入到指针数组中。

<!-- more -->

```C++
#include <iostream>
#include <string>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::vector;

int main()
{
	vector<string> svec;
	string str;
	while (cin >> str) 
	{
		svec.push_back(str);
	}

	char **cp_arr = new char*[svec.size()];//指针数组
	int cnt = 0;
	for (vector<string>::iterator iter = svec.begin(); iter != svec.end(); ++iter) 
	{
		string s = *iter;
		char *cp = new char[s.size()+1];//+1表示为null结束符预留空间
		strncpy(cp, s.c_str(), s.size()+1);
		cp_arr[cnt] = cp;
		++cnt;
	}

	for (int i = 0; i != cnt; ++i) 
	{
		cout << cp_arr[i] << endl;
		delete[] cp_arr[i];
	}
	delete[] cp_arr;

	return 0;
}
```

outputs

```C++
hello↙
world↙
^Z↙
hello
world
```

END.