title: '8:迭代器iterator'
tags:
- C++
- C++ primer
categories: 
- Dev
- C++
date: 2015-11-18 16:49:34
---

除了使用下标访问vector对象的元素外，还有另一种方式：**迭代器（iterator）**。标准库为每一种容器（包括 vector）定义了一种迭代器类型，现代的C++程序更倾向于使用迭代器，即使支持下标操作的容器也是如此，如 vector。在第11章会详细介绍迭代器。

<!-- more -->

### 1、容器的iterator类型 ###
---

每种容器都定义了自己的迭代器类型，如vector：

```C++
vector<int>::iterator iter;
```

> 同一术语 `iterator` 往往表示两个不同的事物，一般来说是指 **迭代器** 的概念；而具体而言时是指由容器定义的iterator类型，如vector<int>。

### 2、begin和end操作 ###
---

每种容器都定义了一对名为 begin 和 end 的函数，用于返回迭代器。容器不为空时，begin 返回的是容器的第一个元素：

```C++
vector<int>::iterator iter = intv.begin();
```

`iter` 指向的是 `intv[0]`。

end 返回的迭代器指向的是vector的 **末端的下一个**，通常称为 **超出末端迭代器（off-the-end iterator）**，它指向一个不存在的元素，如果vector为空，则begin和end返回的迭代器相同。

> end只是起一个**哨兵（sentinel）**的作用，表示已处理完所有元素。

### 3、vector迭代器的自增和解引用运算等 ###
---

- **自增操作** `++`：表示向前移动迭代器，指向下一个元素。可以结合 int 的自增理解：对于 int 类型来说，表示 “加1”，而对容器来说，是“下移一个位置”。如果当前迭代器指向第一个元素，则 `++iter` 表示指向第二个元素。

- **解引用操作** `*`：可以用来访问迭代器所指向的元素
```C++
*iter = 0;
```
	如果迭代器当前指向第一个元素，则上述程序表示：`intv[0] = 0`。

- `==, !=` 可以用来比较两个迭代器

### 3、示例 ###
---

```C++
#include <iostream>
#include <vector>
using std::cin;
using std::cout;
using std::endl;
using std::vector;

int main()
{
	vector<int> intv;	//这是空vector，没有元素
	for (vector<int>::size_type i = 0; i != 10; ++i) {
		intv.push_back(i);	//ok:动态增加
	}	//添加元素 0-9

	for (vector<int>::iterator iter = intv.begin(); iter != intv.end(); ++iter){
		cout << *iter <<",";
		*iter = 1;	//改变vector的值
	}	//跟下面的可以达到相同的效果

	cout << endl;

	for (vector<int>::size_type i = 0; i != intv.size(); ++i) {
		cout<< intv[i] << ",";
	}

	return 0;
}
```

输出结果

```C++
0,1,2,3,4,5,6,7,8,9,
1,1,1,1,1,1,1,1,1,1,
```

### 4、const_iterator ###
---

前面的 `vector::iterator` 可以用来改变元素的值，每个容器还定义了一种只能读取元素但不能改变值得iterator类型：**const_iterator**。

跟普通的iterator类型的区别在于：普通iterator类型解引用时得到的是非const引用，而const_iterator解引用时，得到的是const引用。

```C++
for (vector<int>::const_iterator iter = intv.begin(); iter != intv.end(); ++iter){
	cout << *iter <<",";	//ok
	*iter = 0;				//error
}
```

不能把 const_iteraor 与const iterator 混淆。

```C++
vector<int> nums(10);
const vector<int>::iterator citer = nums.begin();
*citer = 1;	//ok
++citer;	//error：不能改变迭代器的值
```
const_iterator 可以用于 const vector 和非 const vector。但由于不能改变值，const iterator 基本没什么用:

```C++
const vector<int> nines(10, 9);		//这样定义的nines的元素不能被改变
const vector<int>::iterator citer = nines.begin();	//ok
vector<int>::const_iterator iter = nines.begin();
*iter = 1;	//error：*iter是const
++iter;		//ok
```

> vector<int>::const_iterator //不能改变容器的值
> const vector<int>::iterator //不能改变迭代器的值

### 5、迭代器的算术运算 ###
---

除了一次移动一个元素之外，迭代器还支持其他算术操作

- `iter +(-) n`：产生一个新的迭代器，其位置在iter之前（加）或之后（减）的位置。但是加减后的位置还必须是指向vector中的某个元素，或末端的下一个；
- `iter1 - iter2`：计算两个迭代器间的距离，该距离是 **difference_type** 的 signed 类型的值，类似于 size_type 也是由vector定义。iter1 和 iter2 必须都指向同一个vector容器，或末端的下一个；

下面语句可直接定位vector中间元素

```C++
vector<int>::iterator mid = intv.begin() + intv.size()/2;
```

> 任何改变vector长度的操作都会使已存在的迭代器失效。例如调用 push_back 之后，迭代器所指向的元素将会改变。

END.