title: '输入可变长字符串'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-11-05 22:01:42
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Example ###

从标准输入设备读入字符串，并把字符串存放在字符数组中（输入的字符串长度不定）。

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
	size_t arry_size = 10;
	char *p_str = new char[arry_size];
	int count = 0;//统计输入的字符数
	char c;//存放字符

	cout << "Enter some chars:" << endl;
	while (cin.get(c))//每次读取一个字符赋给c
	{
		if (count + 1 >= arry_size)//超出预设长度
		{
			arry_size += 10;//长度增加10
			char *p_temp = new char[arry_size];//申请新空间
			strncpy(p_temp, p_str, count);//将就空间的内容拷贝到新空间
			delete[] p_str;//销毁以前的p_str(p_temp)
			p_str = p_temp;//将新空间p_temp赋给p_str
		}

		p_str[count] = c;
		count++;
	}
	p_str[count] = '\0';//添加null结束符

	cout << "outputs:" <<endl;
	for (size_t i = 0;i != strlen(p_str); ++i)
	{
		cout << p_str[i];
	}
	cout << endl;
	cout << p_str << endl;
	delete[] p_str;//最后销毁p_str
	cout << "end" <<endl;
	return 0;
}
```

outputs

```C++
Enter some chars:
asdfghjklqwertyuiop↙
^Z↙
outputs:
asdfghjklqwertyuiop(输出换行符)

asdfghjklqwertyuiop(输出换行符)

end
```

END.