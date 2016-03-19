title: '按奇偶分割数组'
tags:
  - algorithm
  - partition
  - array
categories:
  - Dev
  - Algorithm
date: 2016-03-18 22:00:05
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 问题描述 ##

给定一个数组，比如 array = { 6, 2, 3, 1, 1, 3, 5, 8}，对该数组进行整理，使得所有奇数都在前面，所有的偶数都在后面。且满足下列条件之一：

1. 保证所有奇数的相对顺序不改变，所有偶数的相对顺序不改变
2. 不要求相对顺序不变

<!-- more -->

愚钝，暂时只想到下面这些：

## 1. 保持相对位置 ##

### a. 利用冒泡思想 ###

复杂度： T(n) = O(n^2), S(n) = O(1)
描述：从左至右扫描，遇到奇数则将其往左移动，直到遇到最近的奇数停止

```
void partitionArray_bubble(vector<int>& nums)
{
	int i = 0, j = 0;
	while (i < nums.size()) {
		if (nums[i] % 2) {  // odd
			int k = i;
			while (k > j) {  // bubble: swap with the previous one
				int tmp = nums[k];
				nums[k] = nums[k - 1];
				nums[k - 1] = tmp;
				--k;
			}
			j += 1;
		}
		++i;
	}
}


```

以array = { 6, 2, 3, 1, 1, 3, 5, 8} 为例，调整后array 的结构如下：

```
31135628
```

### b. 使用额外数组 ###

复杂度： T(n) = O(n), S(n) = O(n)
描述： 
1. 新建一个数组，扫描原数组中的奇数并保存到新数组
2. 再次扫描原数组，保存扫描到的所有偶数至新数组
3. 然后把新数组的元素拷贝到原数组即可

```
void Arrays::partitionArray_copy(vector<int>& nums)
{
	vector<int> copy;
	for (int i = 0; i < nums.size(); ++i)  // 1. put odd number to copy
	{
		if (nums[i] % 2) copy.push_back(nums[i]);
	}
	for (int i = 0; i < nums.size(); ++i)  // 2. put even number to copy
	{
		if (!(nums[i] % 2)) copy.push_back(nums[i]);
	}
	for (int i = 0; i < nums.size(); ++i)  // 3. copy to nums
	{
		nums[i] = copy[i];
	}
}
```

以array = { 6, 2, 3, 1, 1, 3, 5, 8} 为例，调整后array 的结构如下：

```
31135628
```

## 2. 不保持相对位置 ##

### a. 借助快速排序分区的方法 ###

复杂度： T(n) = O(n), S(n) = O(1)
描述： 
1. 使用两个指针i, j，从数组左边（右边一样）同时开始扫描
2. 指针i 所指的元素是奇数时，则与j 所指元素对换
3. 重复过程2，直到i 到达末尾

```
void partitionArray_same(vector<int> &nums) {
	int i = 0, j = 0;
	for (int i = 0; i < nums.size(); ++i) {
		if (nums[i] % 2) { // odd
			swap(nums[i], nums[j]);
			++j;
		}
	}
}
```

以array = { 6, 2, 3, 1, 1, 3, 5, 8} 为例，调整后array 的结构如下：

```
31135268
```

### b. 两指针相撞 ###

复杂度： T(n) = O(n), S(n) = O(1)
描述：
1. 使用两个指针，i 指向头, j 指向尾，分别从数组左右边两边同时开始扫描
2. i 寻找第一个偶数，j 寻找第一个奇数，然后将它们所指元素对换
3. 重复过程2 直至i < j

```
void partitionArray_both(vector<int>& nums)
{
	int i = 0, j = nums.size() - 1;
	while (i < j)
	{
		if (!(nums[i] % 2) && (nums[j] % 2))
		{
			swap(nums[i], nums[j]);
			i++, j--;
		}
		if (nums[i] % 2) i++;  // skip odd
		if (!(nums[j] % 2)) j--;  // skip even
	}
}
```

以array = { 6, 2, 3, 1, 1, 3, 5, 8} 为例，调整后array 的结构如下：

```
53311268
```

END.


[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/