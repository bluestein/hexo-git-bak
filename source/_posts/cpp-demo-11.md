title: 'ex9.9'
tags:
  - Cpp
  - Cpp Code
categories:
  - Code
  - Cpp
date: 2016-01-02 14:03:42
---

### Exercise 9.9 ###

编写一个循环将 list 以逆序输出

```cpp
#include <vector>
#include <list>
#include <deque>
#include <iostream>
#include <string>

using namespace std;

int main()
{
	string s[] = { "hi", "hey", "hello" };
	list<string> slist(s, s + 3); 
	list<string>::iterator iter = --slist.end();
	int sz = sizeof(s) / sizeof(s[0]);
	int cnt = 0;
	while (cnt < sz) {
		cout << (*iter) << endl;
		if (++cnt < sz) {
			--iter;
		}
	}
    return 0;
}
// prints:
// hello
// hey
// hi
```

待续。。。

