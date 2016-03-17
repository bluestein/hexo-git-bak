title: 'if语句'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-12-17 15:32:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Example ###

寻找vector中的最小值，并记录这个最小值出现的次数。

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
	vector<int> ivec;
	for (size_t i = 0; i < 10; i++)
	{
		ivec.push_back(i);
	}
	// 这两步是为了制造最小值
	ivec[0] = ivec[1] = 3;
	ivec[5] = ivec[8] = 0;

	int min_val = ivec[0];
	int min_cnt = 0;
	for (size_t i = 0; i < ivec.size(); i++)
	{
		cout << ivec[i] << endl;
		if (min_val == ivec[i])
		{
			++min_cnt;
		}
		else if (min_val > ivec[i])
		{
			min_val = ivec[i];
			min_cnt = 1;
		}
	}
	cout <<"min value: "<< min_val <<", count: "<< min_cnt << endl;
	
	return 0;
}
```

outputs

```C++
3
3
2
3
4
0
6
7
0
9
min value: 0, count: 2
```

END.