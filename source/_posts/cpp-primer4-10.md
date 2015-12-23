title: 'Cpp:数组'
tags:
  - Cpp
  - Cpp primer
categories:
  - Dev
  - Cpp
date: 2015-11-20 16:49:44
---

现在开始学习第四章“数组和指针”。C++语言提供了两种类似于vector和迭代器类型的低级复合类型——**数组和指针**。数组与vector类似，区别在于：数组的长度是固定的，一经创建不允许添加新的元素，如果一定要增加元素，只能创建更大的数组；指针则可以像迭代器一样用于遍历和检查数组中的元素。

<!-- more -->

> 现代的C++程序应尽量使用vector和迭代器类型，而避免使用低级的数组和指针。设计良好的程序只有在强调速度时才在类实现的内部使用数组和指针。

### 1、数组的定义及初始化 ###
---

数组是由类型名、标识符和维数组成的复合数据类型，类型名规定了存放在数组中元素类型，而维数是指数组能存放的个数。

> 数组定义中的类型名可以是内置数据类型或类类型；除引用之外，数组元素的类型还可以是任意的复合类型。没有所有元素都是引用的数组。

数组维数必须用值大于等于 1 的常量表达式定义。此常量表达式只能是整型字面值常量、枚举常量或者用常量表达式初始化的整型const对象。**非const变量或要到运行阶段才知道其值的const变量都不能用于定义数组的维数**。

```C++
const unsigned buf_size = 512, max_files = 20;	//const
int staff_size = 27;	//non const
const unsigned run_size = get_size();	//const value unknown until run time
char input_buffer[buf_size];		//ok：const
string file_table[max_files + 1];	//ok：constant expression
double salaries[staff_size];		//error:non const variable
int test[get_size()];				//error:non const expression
int vals[run_size];					//error:value unknown until run time
```

虽然 `staff_size` 是用字面值常量进行初始化，但它本身是一个非const变量，**只有在运行时才能获得它的值**；`run_size` 虽然是 const 对象，但它的值要到运行时调用 get_size() 函数才能知道；因此这两种都不能用来初始化维数。

没有显式提供元素初值时，数组会跟普通的变量一样：

- 在函数体 **外** 定义的内置数组，其元素均初始化为 0；
- 在函数体 **内** 定义的内置数组，其元素均无初始化值；
- 不管数组在哪定义，如富哦其元素是类类型，则自动调用默认构造函数进行初始化；如果无默认构造函数，则必须现实提供初始化值。

```C++
const unsigned array_size = 3;
int vals1[array_size] = {1, 2, 3};	//显式初始化
int vals2[] = {1, 2, 3};			//显示初始化，可以不提供维数
int vals3[array_size] = {1};		//初始化列表的元素个数可以小于维数，但不能大于
```

上面的数组初始化结果为

```C++
vals1 = {1, 2, 3};
vals2 = {1, 2, 3};
//对于vals3，若是内置类型，超出初始化列表的元素初始化为0；若是类类型，则使用默认构造函数初始化
vals3 = {1, 0, 0};
```

**字符数组**： 既可以用花括号初始化，也可以用字符串字面值初始化。但不太相同，字符串字面值包含一个额外的空字符（null）用于结束字符串

```C++
char c1[] = {'C', '+', '+'};		//c1 维数为3
char c2[] = {'C', '+', '+', '\0'};	//c2 维数为4
char c3[] = "C++";					//c3 维数为4，自动添加空字符
char c4[3] = "C++";					//error:自动添加空字符，所以 "C++" 维数为4
```

**不允许数组直接复制和赋值**

```C++
int vals1[] = {0,1,2};	//ok
int vals2[](vals1);		//error
int vals3[3] = vals1;	//error
```

### 2、数组的操作 ###
---

与vector类似，用下标类访问元素；vector用vector::size_type作为下标类型，数组的下标正确类型则是 size_t。

```C++
const size_t array_size = 10;
int arr1[array_size], arr2[array_size];
for (size_t i = 0; i != array_size; ++i){
	arr1[i] = i;
}

//复制arr1数组到arr2
for (size_t i = 0; i != array_size; ++i){
	arr2[i] = arr1[i];
}
```

> 需要注意下标不能越界

END.