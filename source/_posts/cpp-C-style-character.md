title: 'C风格字符串'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-10-09 16:49:54
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

前面的内容我们使用过字符串字面值，并了解字符串字面值的类型是字符常量的数组，现在可以更加明确的认识到：**字符串字面值的类型就是 const char 类型的数组**。C++从C继承下来的一种通用的结构是**C风格字符串（C-Style character string）**，字符串字面值就是该类型的实例。实际上，C风格字符串既不能确切的归结为C语言类型，也不能归结为C++的类型，而是以空字符 `null` 结束的字符数组：

<!-- more -->

```C++
char c1[] = {'C', '+', '+'};		//c1 维数为3，not c-style
char c2[] = {'C', '+', '+', '\0'};	//c2 维数为4
char c3[] = "C++";					//c3 维数为4，自动添加空字符
const char *cp = "C++";		//自动添加空字符
char *cp1 = c1;		//指向c1数组的第一个元素，not c-style
char *cp2 = c2;		//指向c1数组的第一个元素，以空字符 `null` 结束的字符数组
```

`c1` 和 `cp1` 都不是C风格字符串：`c1` 是不带结束符 `null` 的字符数组。其他都是C风格字符串。

### 1、C风格字符串的使用 ###
---

C++通过 (const) char* 类型的指针来操作C风格的字符串。

```C++
const char *cp = "C++";
while (*cp) {
	cout << *cp << endl;
	++cp;
}
```

输出

```C++
C
+
+
```

> 如果cp指向的字符数组没有 null 结束符，作为循环会失败。这时循环继续进行，知道遇到内存中某处的 null 结束符。

### 2、C风格字符串的标准库函数 ###
---

下表类除了C语言标准库函数提供的一系列处理C风格字符串的库函数，这些库函数包含在 string.h 中。

|库函数|含义|
|--|--|
|strlen(s)|返回s的长度，不包括null结束符|
|strcmp(s1, s2)|比较s1和s2是否相同。s1等于s2,返回0;s1大于s2，返回正数；s1小于s2，返回负数|
|strcat(s1, s2)|将字符串s2连接到s1后面，返回s1|
|strcpy(s1, s2)|将s2复制给s2，返回s1|
|strncat(s1, s2, n)|将s2的前n个字符连接到s1后面，并返回s1|
|strncpy(s1, s2, n|将s2的前n个字符赋给s1，并返回s1|

传递给这些函数的指针必须具有非零值，并且指向以null结束的字符数组中的第一个元素。并且要确保目标字符串必须有足够大的空间存放结果串。

**字符串的比较和比较结果都必须使用标准库函数 strcmp 进行**

```C++
const char *cp1 = "C++";
const char *cp2 = "C";
int i = strcmp(cp1, cp2);
cout << i << endl; 
i = strcmp(cp2, cp1);
cout << i << endl;
i = strcmp(cp1, cp1);
cout << i << endl;
```

输出

```C++
1
-1
0
```

**不要忘记字符串结束符null**

```C++
char c[] = { 'c' };
cout << strlen(c) << endl;
```

输出结果是不可预料的，因为会一直寻找null结束符，然后再输出。比如在我的电脑是输出是 `324`，这明显是错误的，在不同的电脑会输出不同的值。

**必须确保目标字符串有足够的大小**

库函数 strcat 和 strcpy 的第一个参数必须有足够大的空间

```C++
const char *cp1 = "C++";
const char *cp2 = "C";
char str[3 + 1 + 2];
strcpy(str, cp1);
strcat(str, " ");
strcat(str, cp2);
cout << str << endl;
```

输出

```C++
C++ C
```

上述程序就目前来看是完全没问题的，但如果 cp1 和 cp2 指向的字符串大小发生了改变，str 所需的大小就不满足要求了。会导致严重的安全漏洞。

**strn函数处理C风格的字符串**

如果必须处理C风格字符串，strncat，strncpy会比strcat，strcpy更安全

```C++
char str[3 + 1 + 2];
strncpy(str, cp1, 4);	//1. 包含null
strncat(str, " ", 2);	//2. 包含null，看起来冗余，但是个好习惯
strncat(str, cp2, 2);	//3. 要包含null
cout << str << endl;
```

分步骤解释：

- 1. strncpy cp1 时需要复制 4 个字符：cp1 中所有字符，加上 null 结束符；此时 strlen(str) = 3.
- 2. strncat " " 时需要复制 2 个字符：一个空格字符，加上 null 结束符；此时空格符会把步骤1复制的 null 结束符覆盖。此时 strlen(str) = 4.
- 3. strncat cp2 时需要复制 2 个字符：cp2 中所有字符，加上 null 结束符；此时 strlen(str) = 6.

最后 str 的内容：cp1 和 cp2 中所有字符，一个空格，和一个null结束符。

**尽可能使用string类型**

```C++
string str = cp1;
str += " ";
str += cp2;
```

可以达到上面一样的效果。

### 3、创建动态数组 ###
---

数组类型的限制：长度不变；编译时须知道长度；数组只在定义它的语句内存在。可以使用动态分配解决这一问题，跟C中的malloc和free类似，C++中使用 **new** 和 **delete** 实现。

#### 3.1、定义 ####

数组变量需要指定类型、数组名和维数定义，而动态分配的数组只需指定类型和长度，不必为数组对象命名。

```C++
int *ip = new int[10];
```

#### 3.2、初始化 ####

动态分配的数组，如果有类型，则使用类型的默认构造函数初始化；如果是内置类型，则无初始化:

```C++
string *sp = new string[10];	//初始化为10个空字符串
int *ip = new int[10];		//不初始化
int *ip2 = new int [10]();	//初始化为10个0
```

> 圆括号要求编译器对数组进行初始化；
> 动态分配的数组，其元素只能初始化为默认值，而不能像变量一样提供初始化列表进行初始化

#### 3.3、const对象的动态数组 ####

必须为该数组提供初始化值，因为数组内都是const对象，无法赋值

```C++
const int *caip_bad = new const int[10];	//error
const int *caip_ok = new const int[10]();	//ok
```

也可以定义类类型的const数组，但该类型必须提供默认构造函数

```C++
	const string *csp = new const string[10];	//ok
```

#### 3.4、动态分配空数组 ####

有时候，编译时并不知道数组的长度，这时可以动态分配空数组。看如下程序

```C++
size_t n = get_size();
int *p = new int[n];
for (int *q = p; q != p + n; ++q)
	//process the array
```

即使 `get_size()` 返回 0 也是可以的。例如

```C++
char arr[0];	//error
char *cp = new char[0];	//ok，但不能被解引用
```

上述 `cp` 指针 **允许** 的操作有：比较；本身加（减）0。

#### 3.5、动态空间释放 ####

动态分配的空间必须释放，不然内存会被逐渐耗尽

```C++
delete [] cp;
```

该语句回收了 `cp` 所指向的数组。把相应的内存返还给自由存储区。

> 理论上，如果少了 `[]` 应该会导致少释放空间，从而产生内存泄露，因此，释放动态数组时，不能忘记 `[]`

#### 3.6、动态数组的使用 ####

长度不一样的两个字符串，赋给同一个新的字符数组

```C++
const char *txt1 = "HAHAHA";
const char *txt2 = "HEHEHEHEHEHE";

const char *txt;
if(condition)	//condition表示某个条件
	txt = txt1;
else
	txt = txt2;
size_t demension = strlen(txt) + 1;
char *msg = new char[demension];
strncpy(msg, txt, demension);
cout << msg << endl;
```

### 4、新旧代码的兼容 ###

#### 4.1、混合使用string库和C风格字符串 ####

可用字符串字面值初始化string对象

```C++
string str("Hello World");
```

通常，C风格字符串与字符串字面值有相同的数据类型，而且都是以空字符null结束，因此可以把C风格字符串用在任何可以使用字符串字面值的地方：

- C风格字符串对string对象进行赋值或初始化；
- C风格字符串可以作为string类型的加法操作两个参数中的一个；

但反之不成立，但可以通过名为 `c_str()` 的函数转化为C风格字符串

```C++
char *str1 = str;	//error
const char *str2 = str.c_str();	//ok
```

#### 4.2、使用数组初始化vector对象 ####

```C++
const size_t arr_size = 6;
int int_arr[arr_size] = {0, 1, 2, 3, 4, 5};
vector<int> ivec(int_arr, int_arr + arr_size);
	
//相当于用 int_arr[1], int_arr[2], int_arr[3] 初始化 ivec1
vector<int> ivec1(int_arr + 1, int_arr + 4);
```

**举例1**

编写程序: 从标准输入设备读入字符串，并把字符串存放在字符数组中（输入的字符串长度不定）。

```C++
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

运行测试

```C++
Enter some chars:
asdfghjklqwertyuiop↙
^Z↙
outputs:
asdfghjklqwertyuiop(输出换行符)

asdfghjklqwertyuiop(输出换行符)

end
```

**举例2**

编写程序：读入一组string类型数据，将它们存储在vector中，然后将vector中的对象复制给一个字符指针数组。即为vector中的每个元素创建一个新的字符数组，然后把vector元素的数据复制到相应的字符数组中，最后将指针插入到指针数组中。

```C++
int main()
{
	vector<string> svec;
	string str;
	while (cin >> str) {
		svec.push_back(str);
	}

	char **cp_arr = new char*[svec.size()];//指针数组
	int cnt = 0;
	for (vector<string>::iterator iter = svec.begin(); iter != svec.end(); ++iter) {
		string s = *iter;
		char *cp = new char[s.size()+1];//+1表示为null结束符预留空间
		strncpy(cp, s.c_str(), s.size()+1);
		cp_arr[cnt] = cp;
		++cnt;
	}

	for (int i = 0; i != cnt; ++i) {
		cout << cp_arr[i] << endl;
		delete[] cp_arr[i];
	}
	delete[] cp_arr;
	return 0;
}
```

运行结果

```C++
hello↙
world↙
^Z↙
hello
world
```

### 5、多维数组 ###

> 严格的讲，C++中没有多维数组，只有**数组的数组**

**初始化**

```C++
int ia[3][2] = {
	{0, 1},
	{2, 3},
	{4, 5}
};
```

且等价于

```C++
int ia[3][2] = {0, 1, 2, 3, 4, 5};
```

而下面情况只初始化第一个元素，则其余初始化为0

```C++
int ia[3][2] = {{1}, {2}, {3}};
```

等价于

```C++
int ia[3][2] = {{1, 0}, {2, 0}, {3, 0}};
```

但不会等价于

```C++
int ia[3][2] = {1, 2, 3};//等价于int ia[3][2] = {1, 2, 3, 0, 0, 0}
```

**下标引用**

```C++
const size_t rsz = 3;
const size_t csz = 2;
int ia[rsz][csz];
for (int i = 0; i != rsz; ++i) {
	for (int j = 0;j != csz; ++j) {
		ia[i][j] = i + j;
	}
}
```

访问特定元素时，必须提供行下标与列下标

**指针与多维数组**

与普通数组一样，多为数组名也是指向第一个元素的指针。

```C++
int main()
{
	int ia[3][2] = {
		{ 0, 1 },
		{ 2, 3 },
		{ 4, 5 }
	};
	int (*ip)[2];	//ok: 一个指向包含2个int值的数组的指针
	ip = &ia[1];	//ok: ia[1] 包含2个int值
	cout << (*ip)[0] << "," << (*ip)[1] << endl;
	return 0;
}
```

运行结果

```C++
2,3
```

> int (*ip)[2];//指向数组的指针；即ip是指向包含两个int值的数组的指针
> int *ip[2];//指针的数组；即ip是包含两个指针的数组

**typedef简化多维数组指针**

指向 `ia` 的指针

```C++
typedef int int_arr[2];
int_arr *ip = ia;
```

用 `int_arr` 输出 `ia` 的元素

```C++
int ia[3][2] = {
	{ 0, 1 },
	{ 2, 3 },
	{ 4, 5 }
};
typedef int int_arr[2];
for (int_arr *p = ia; p != ia + 3; ++p) {
	for (int *q = *p; q != *p + 2; ++q){
		cout << *q << endl;
	}
}
```

结果

```C++
0
1
2
3
4
5
```

END.