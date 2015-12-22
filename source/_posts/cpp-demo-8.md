title: 'c++ demo: do-while & break'
tags:
  - C++
  - C++ Demo
categories:
  - Demo
  - C++
date: 2015-12-22 20:03:42
---

### Exercise 6.18 ###

输入两个string对象，比较哪个按字典序靠前。

<!-- more -->

```C++
#include <iostream>
#include <string>

using std::cin;
using std::cout;
using std::endl;
using std::string;

string dictOrder(string a, string b) {
	const char *cp1 = a.c_str();
	const char *cp2 = b.c_str();
	while (*cp1 && *cp2)
	{
		if (*cp1 != *cp2) {
			return *cp1 > *cp2 ? "First bigger" : "First smaller";
		}
		cp1++;
		cp2++;
	}
	return "Same";
}

int main()
{
	string str1, str2;
	cout << "Please input two strings.\nIf you want to quit, input two 'q'." << endl;
	do {
		cout << "\nTwo strings:\n";
		cin >> str1 >> str2;
		cout<< dictOrder(str1, str2) << endl;
	} while (str1 != "q" && str2 != "q");

	return 0;
}
```

outputs

```C++
Please input two strings.
If you want to quit, input two 'q'.

Two strings:
ab↙
ac↙
First smaller

Two strings:
b↙
a↙
First bigger

Two strings:
q↙
q↙
Same
```

### Exercise 6.20 ###

读入一系列string，直到出现重复的单词时停止，或者没有重复时请说明。

```C++
#include <iostream>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::vector;

int main()
{

	vector<string> v;
	string str;
	bool found = false;
	while (cin >> str)
	{
		for (size_t i = 0; i < v.size(); i++)
		{
			if (v[i] == str) {
				found = true;
				break;
			}
		}
		if (found) {
			break;
		}
		else {
			v.push_back(str);
		}
	}
	cout << (found ? "Repeat found": "No repeated") << endl;
	return 0;
}
```

outputs

```C++
// test1
hi↙
hey↙
hello↙
hi↙
Repeat found

// test2
hi↙
hey↙
hello↙
^Z↙
No repeated
```
