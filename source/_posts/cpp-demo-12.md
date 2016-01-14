单词转换程序
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