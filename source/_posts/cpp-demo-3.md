title: 'c++ demo: vector存放指针'
tags:
  - C++
  - C++ Demo
categories:
  - Dev
  - C++ Demo
date: 2015-12-02 22:01:42
---

编写程序：定义vector对象，其每个元素指向string类型的指针；输出每个元素的内容及长度。

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
	while (iter != v.end()) {
		string *tmp = *iter;
		cout << tmp->size() << ", " << *tmp << endl;
		delete tmp;
		iter++;
	}
	return 0;
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

END.