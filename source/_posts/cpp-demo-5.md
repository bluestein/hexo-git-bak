title: 'Cpp Code: switch, ex6.9'
tags:
  - Cpp
categories:
  - Code
  - Cpp
date: 2015-12-22 09:42:42
---

### Example ###

统计输入的一句话中元音出现的次数。

<!-- more -->

```C++
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int main()
{
	char ch;
	int aCnt = 0, eCnt = 0, iCnt = 0, oCnt = 0, uCnt = 0, otherCnt = 0;
	while (cin >> ch)
	{
		switch (ch)
		{
		case 'a':
		case 'A':
			++aCnt;
			break;
		case 'e':
		case 'E':
			++eCnt;
			break;
		case 'i':
		case 'I':
			++iCnt;
			break;
		case 'o':
		case 'O':
			++oCnt;
			break;
		case 'u':
		case 'U':
			++uCnt;
			break;
		default:
			++otherCnt;
			break;
		}
	}
	cout << "Number of vowel a/A:\t" << aCnt << "\n"
		<< "Number of vowel e/E:\t" << eCnt << "\n"
		<< "Number of vowel i/I:\t" << iCnt << "\n"
		<< "Number of vowel o/O:\t" << oCnt << "\n"
		<< "Number of vowel u/U:\t" << uCnt << "\n"
		<< "Number of other characters:\t" << otherCnt << endl;
	return 0;
}
```

outputs

```C++
Sorry! Who Are You Again?↙
^Z↙
Number of vowel a/A:    3
Number of vowel e/E:    1
Number of vowel i/I:    1
Number of vowel o/O:    3
Number of vowel u/U:    1
Number of other characters:     12
```

### Exercise 6.9 ###

统计下列字符序列出现的次数：ff、fl以及fi。 

```C++
int main()
{
	char pre_ch = '\0', cur_ch;
	int ffCnt = 0, flCnt = 0, fiCnt = 0, otherCnt = 0;
	while ((cur_ch = getchar()) != EOF)
	{
		if (pre_ch == 'f')
		{
			switch (cur_ch)
			{
			case 'f':
				++ffCnt;
				break;
			case 'l':
				++flCnt;
				break;
			case 'i':
				++fiCnt;
				break;
			default:
				++otherCnt;
				break;
			}
		}
		pre_ch = cur_ch;
	}
	cout <<"Number of ff:\t" << ffCnt <<"\n"
		<< "Number of fl:\t" << flCnt << "\n"
		<< "Number of fi:\t" << fiCnt << "\n"
		<< "Number of other:\t" << otherCnt << "\n";
	return 0;
}
```

outputs

```C++
flfmffi↙
^Z↙
Number of ff:   1
Number of fl:   1
Number of fi:   1
Number of other:        1
```

END.

---

Github Pages同步更新: [Humooo's Blog][1]

[1]: http://bluestein.github.io/