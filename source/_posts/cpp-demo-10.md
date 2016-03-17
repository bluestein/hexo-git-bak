title: 'ex8.3, 8.7, 8.8'
tags:
  - Cpp
  - Cpp Code
categories:
  - Code
  - Cpp
date: 2016-01-01 14:03:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Exercise 8.3 ###

编写一个程序，一个形参和返回值都是 `istream&` 类型。该函数一直读取直到结束符为止，并且将读取到的内容输出到标准输出中，最后重设流使其有效，并返回该流。

<!-- more -->

```cpp
#include <iostream>
using namespace std;

istream &input(istream &in) {
	int val;
	while (in >> val, !in.eof())
	{
		cout << val << endl;
	}
	in.clear();
	return in;
}
// use cin for test
// prints:
// 1↙
// 1
// 2↙
// 2
// ^Z↙
```

### Exercise 8.7 ###

vector 容器中存放了将要处理的文件名，当打开失败时，输出警告信息，然后取下一个文件处理。假设当前文件夹下有一个名为 `test.txt` 的文件，内容是：

```txt
test!
```

则程序及运行测试如下：

```cpp
int main()
{
	ifstream input;
	vector<string> files;
	files.push_back("willfail.txt");
	files.push_back("test.txt");
	files.push_back("willfail.txt");
	files.push_back("test.txt");
	vector<string>::const_iterator it = files.begin();
	while (it != files.end()) {
		input.open(it->c_str());
		if (!input) {
			cerr << it->c_str() << ": failed to open." << endl;
			++it;
			continue;
		}
		cout << it->c_str() << ": ";
		char s;
		while (input >> s)
			cout << s;
		cout << endl;
		input.close();
		input.clear();
		++it;
	}
    return 0;
}
// prints:
// willfail.txt: failed to open
// test.txt: test!
// willfail.txt: failed to open
// test.txt: test!
```

### Exercise 8.8 ###

不用 continue 实现 ex8.7

```cpp
int main()
{
	ifstream input;
	vector<string> files;
	files.push_back("willfail.txt");
	files.push_back("test.txt");
	files.push_back("willfail.txt");
	files.push_back("test.txt");
	vector<string>::const_iterator it = files.begin();
	while (it != files.end()) {
		input.open(it->c_str());
		if (!input) {
			cerr << it->c_str() << ": failed to open." << endl;
		}
		else {
			cout << it->c_str() << ": ";
			char s;
			while (input >> s)
				cout << s;
			cout << endl;
			input.close();
			input.clear();
		}
		++it;
	}
    return 0;
}
```

END.