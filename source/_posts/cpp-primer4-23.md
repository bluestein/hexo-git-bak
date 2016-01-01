title: 'IO库'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2016-01-01 15:11:49
---

### 标准库 ###

IO类型在三个独立的头文件中定义：iostream，fstream，sstream

|头文件|类型|
|--|--|
|iostream|istream 从流中读取；<br/>ostream 写到流中去；<br/>iostream 对流进行读写，由 iostream 和 ostream 派生而来；|
|fstream|ifstream 从文件对象中读取，由 istream 派生而来；<br/>ofstream 写到文件对象中去，由 ostream 派生而来；<br/>fstream 对文件进行读写，由 iostream 派生而来；|
|sstream|istringstream 从 string 对象中读取，由 istream 派生而来；<br/>ostringstream 写到 string 对象中去，由 ostream 派生而来；<br/>stringstream 对 string 进行读写，由 iostream 派生而来；|

<!-- more -->

**国际字符的支持**

前面所说的流类（stream class）读写均是 char 类型组成的流，不过，标准库还定义了一套支持 wchar_t 的类型。每个类加上 **w** 前缀，表示宽字符，如 wostream, wistream, wiostream。

**IO 对象不可复制或赋值**

处于一些原因，标准库不允许赋值或复制操作，原因在后面阐明

```cpp
ofstream out1, out2;
out1 = out2; // error
// function func: parameter is copied
ofstream func(ofstream);
out2 = func(out2); //error: cannot copy stream objects
```

1. 由于不能复制，因此不能存储在 vector 等容器中
2. 形参或返回类型也不能为流类型。如果需要传递或返回 IO 类型，则必须使用**指针或引用**：
```cpp
ofstream &func(ofstream&); // ok: takes a reference, no copy
while (func(out2)) { /*...*/ } // ok: pass reference to out2
```

### 条件状态 ###

IO 标准库管理一系列的**条件状态（condition state）**成员，用来标记给定的 IO 对象是否处于可用状态，或者碰到了哪种特定的错误。

|IO 标准库的条件状态|意义|
|--|--|
|strm::iostate|机器相关的整型名，由各个 iostream 类定义，用于定义条件状态|
|strm::badbit|strm::iostate类型的值，用于指出被破坏的流|
|strm::failbit|strm::iostate类型的值，用于指出失败的 IO 操作|
|strm::eofbit|strm::iostate类型的值，用于指出流已经达到文件的结束符|
|s.eof()|如果设置了流 s 的 eofbit 值，该函数返回true|
|s.fail()|如果设置了流 s 的 failbit 值，该函数返回true|
|s.bad()|如果设置了流 s 的 badbit 值，该函数返回true|
|s.good()|如果设置了流 s 处于有效状态，该函数返回true|
|s.clear()|将流 s 的所有状态值重设为有效状态|
|s.clear(flag)|将流 s 中某个指定的条件状态设置为有效。flag 类型为 strm::iostate|
|s.setstate(flag)|给流 s 添加指定条件。flag 类型为 strm::iostate|
|s.rdstate()|返回流 s 当前条件。返回值类型为 strm::iostate|

流的状态由 bad、fail、eof 或 good 操作揭示。badbit 标志着系统级的错误，如无法读写的错误。其他都设置了 failbit 标志，通常可修正。

**流状态的查询和控制**

```cpp
int ival;
// read cin and test only for EOF; loop is executed even if there are IO failures
while (cin >> ival, !cin.eof()) {
	if (cin.bad()) {
		throw runtime_error("IO stream corrupted");
	}
	if(cin.fail()) {
		cerr << "bad data, try again";
		cin.clear(istream::failbit);
		continue;
	}
}
```

**条件状态的访问**

rdstate 成员函数返回一个 iostate 类型的值，该值对应于流当前的整个条件状态：

```cpp
istream::iostate old_state = cin.rdstate();
cin.clear();
process_input(); // use cin
cin.clear(old_state); // reset cin to old state
```

### 输出缓冲区的管理 ###

每个IO对象管理一个缓冲区，用于存储程序读写的数据。如有下面语句：

```cpp
os << "Plz enter a value:";
```

系统会将字符串字面值存储在与流 os 关联的缓冲区中。

下面情况将导致缓冲区的内容被刷新，即写入到真实的输出设备或文件中：

1. 程序正常结束。作为 main 返回工作的一部分，将清空所有输出缓冲区；
2. 缓冲区已满，写入下一个值时；
3. 用操纵符显示刷新缓冲区，如行结束符 endl；
4. 每次输出操作完成后，用 unitbuf 操纵符设置流内部的状态，从而清空缓冲区；
5. 将输出流与输入流关联起来。在读入流时将刷新其关联的输出缓冲区；

**输出缓冲区的刷新**

除了 `endl` 之外，还有其他两个类似的操纵符： `flush`, `ends`

```cpp
cout << "hi" << flush; // flushes the buffer, adds no data;
cout << "hi" << ends; // inserts a null, then flushes the buffer; 
cout << "hi" << endl; // inserts a newline, then flushes the buffer;
```

**unitbuf**

如果需要刷新所有输出，最好使用 unitbuf 操纵符。

```cpp
cout << unitbuf << "first" << "second" << nounitbuf;
```

等价于


```cpp
cout << "first" << flush << "second" << flush;
```

> 如果程序崩溃了，则不刷新缓冲区。

**输入与输出绑定**

将 cout 与 cin 绑定，则任何读输入流的操作都将刷新其输出流关联的缓冲区。使用 tie 函数：

```cpp
cin.tie(&cout);
ostream *old_tie = cin.tie();
cin.tie(0); // 终止绑定
cin.tie(&cerr); // cin 与 cerr 绑定，但不推荐
cin.tie(0);
cin.tie(old_tie); // cin 与 cout 重新绑定
```

### 文件的输入输出 ###

#### 文件流对象的使用 ####

```cpp
// construct an ifstream and bind it to the file named ifile 
ifstream infile(ifile.c_str());
// ofstream output file object to write file named ofile
ofstream outfile(ofile.c_str());
```

> open需要使用C风格字符串

或者

```cpp
ifstream infile; // input file stream
ofstream outfile; // output file stream
infile.open("in"); // open file named "in" in current directory
outfile.open("out"); // open file named "out" in current directory
```

**检查文件打开是否成功**

```cpp
if (!infile) {
	cerr << "error: unable to open input file:" << ifle << endl;
	return -1;
}
```

**与其他文件绑定**

如果把现有 fstream 对象与另一个不同的文件关联，则必须先关闭现有文件，然后打开另一个文件

```cpp
ifstream infile("in");
infile.close();
infile.open("next");
```

**清楚文件流的状态**

使用 clear() 函数即可。比如有一个vector对象，存放了一些要打开的文件名，程序要对这些文件处理

```cpp
ifstream input;
vector<string>::const_iterator it = files.begin();
while (it != files.end()) {
	input.open(it->c_str());
	if (!input) {
		break;
	}
	while (input >> s)
		process(s);
	input.close();
	input.clear();
	++it;
}
```

如果忽略 `input.clear()` 则循环只能读入一个文件，因为读取文件到达文件的结束或出错时，input 的状态都是 failbit，此时任何尝试读取 input 都会失败。

#### 文件模式 ####

|文件模式|意义|
|--|--|
|in|打开文件作读操作|
|out|打开文件作写操作|
|app|每次写之前找到文件尾|
|ate|打开文件后立即定位到文件尾|
|trunc|打开文件时，清空已存在的文件流|
|binary|以二进制模式进行IO操作|

- out, trunc, app 模式只能用于指定与 ofstream 或 fstream 对象关联的文件；
- in 模式只能用于指定与 ifstream 或 fstream 对象关联的文件；
- ate, binary 模式可用于所有文件；

默认时，与 ifstream 流对象关联的文件以 in 模式打开；与 ofstream 流对象关联的文件以 out 模式打开；**以out模式打开文件原内容会被清空**，若要保留，则以 app 模式打开：

```cpp
// 会清空file1
ofstream outfile("file1");
// 等价上面，显式清空
ofstream outfile2("file1", ofstream::out | ofstream::trunc);
// 在末尾添加内容
ofstream appfile("file2", ofstream::app);
```

- 默认情况下，fstream 以 in 和 out 模式同时打开。此时，文件不会被清空。
- 如果打开 fstream 所关联的文件，只使用 out 模式，而不指定 in 模式，则会被清空。
- 如果指定了 trunc 模式，则无论如何都会被清空；

```cpp
// open for input and output
fstream inOut("copyOut", fstream::in | fstream::out)
```

**有效的文件模式组合**

|模式组合|意义|
|--|--|
|out|打开文件做写，清空已有数据|
|out &#124; app|打开文件做写，文件尾写入|
|out &#124; trunc|同out模式|
|in|打开文件做读|
|in &#124; out|打开文件做读、写，定位在文件开头|
|in &#124; out &#124; trunc|打开文件做读、写，清空已有数据|

举例

```cpp
ifstream& open_file(ifstream &in, const string &file) {
	in.close();
	in.clear();
	in.open(file.c_str());
	return in;
}
```

由于不清楚流 in 的状态，则先调用 close 和 clear 设置为有效状态。然后尝试打开文件，最后返回流 in 对象。此时，in 要么与文件绑定，要么处于错误状态。

### 字符串流 ###

标准库定义了三个类型的字符串流：

- istringstream，由 istream 派生而来，提供读 string 的功能。
- ostringstream，由 ostream 派生而来，提供写 string 的功能。
- stringstream，由 iostream 派生而来，提供读写 string 的功能

```cpp
stringstream strm; // 创建 stringstream 对象
stringstream strm(s); //存储 s 的副本 stringstream 对象，其中 s 是 string 类型的对象
strm.str(); // 返回 strm 中存储的 string 对象
strm.str(s); // 将 string 对象 s 复制给 strm，返回 void
```

**操纵每行中的每个单词**

```cpp
string line, word;
while (getline(cin, line)) // 读取一行到 line 中
{
	istringstream stream(line); // bind strem to the line
	while (stream >> word) // 从 line 读取一个单词
	{
		cout << word << endl; // 可以操纵这句话中的每个单词，这里是输出它
	}
}
```

**stringstream提供转换的格式化**

把一些数据转换成它们的 string 表示形式

```cpp
int v1 = 512, v2 = 1024;
ostringstream format_msg;
format_msg << "v1: " << v1 << ", v2: " << v2 ;
cout << format_msg.str();
// prints:
// v1: 512, v2: 1024
```

或者反过来

```cpp
int v1 = 512, v2 = 1024;
ostringstream format_msg;
format_msg << "v1: " << v1 << ", v2: " << v2 << "\n";
cout << format_msg.str();
istringstream istring(format_msg.str());
string dump;
int new_v1, new_v2;
istring >> dump >> new_v1 >> dump >> dump >> new_v2;
cout << new_v1 << " " << new_v2 << " " << endl;
cout << dump << endl;
// prints:
// v1: 512, v2: 1024
// 512 1024
// v2:
```

可以发现 istringstream 可以将 string 对象按原来的位置恢复到对应的变量位置。上面程序中 `dump` 在此过程中相当于一个临时变量，在不断的变化。从输出来看，最后一次 `dump` 的值为 `v2:`，前面两次的值依次是：`v1:`, `,`（string类型，不带空格）。

END.