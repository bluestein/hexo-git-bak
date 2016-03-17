title: 'vector存放指针'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-11-20 22:01:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Example ###

定义vector对象，其每个元素指向string类型的指针；输出每个元素的内容及长度。

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
	string s;
	vector<string *> v;
	while (cin >> s)
	{
		string *sp = new string(s);
		v.push_back(sp);
	}
	vector<string *>::iterator iter = v.begin();
	while (iter != v.end()) 
	{
		string *tmp = *iter;
		cout << tmp->size() << ", " << *tmp << endl;
		delete tmp;
		iter++;
	}
	return 0;
}
```

outputs

```C++
hello↙
world!↙
^Z↙
5, hello
6, world!
```

END.