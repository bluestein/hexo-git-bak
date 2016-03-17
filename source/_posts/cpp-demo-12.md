title: '单词转换程序'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2016-01-14 20:03:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

源代码

<!-- more -->

```cpp
#include <iostream>
#include <map>
#include <string>
#include <utility>
#include <fstream>
#include <sstream>
using namespace std;


int main(int argc, char **argv)
{
	map<string, string> trans_map;
	string key, value;
	if (argc != 3) {
		throw runtime_error("wrong number of arguments");
	}
	ifstream map_file;
	map_file.open(argv[1]);
	if (!map_file) {
		throw runtime_error("no transformation file");
	}
	while (map_file >> key >> value) {
		trans_map.insert(make_pair(key, value));
	}
	ifstream input;
	input.open(argv[2]);
	if (!input) {
		throw runtime_error("no input file");
	}
	string line;
	while (getline(input, line)) {
		istringstream s(line);
		string word;
		bool first = true;
		while (s >> word) {
			map<string, string>::const_iterator map_citer = trans_map.find(word);
			if (map_citer != trans_map.end()) {
				word = map_citer->second;
			}
			if (first) {
				first = false;
			}
			else {
				cout << " ";
			}
			cout << word << endl;
		}
		cout << endl;
	}

    return 0;
}
```