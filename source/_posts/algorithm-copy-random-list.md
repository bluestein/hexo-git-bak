title: '深拷贝带随机指针的链表'
tags:
  - algorithm
  - linked list
  - deep copy
categories:
  - Dev
  - Algorithm
date: 2016-03-20 21:48:32
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 描述 ##

给出一个链表，每个节点包含一个额外增加的随机指针可以指向链表中的任何节点或空的节点。返回一个深拷贝的链表。

1. 浅拷贝(影子克隆):只复制对象的基本类型，对象类型，仍属于原来的引用
2. 深拷贝(深度克隆):不仅复制对象的基本类型，同时也复制原对象中的对象，就是说完全是新产生的对象

<!-- more --> 

介绍两种方法，分别需要： O(n) time, O(n) space 和 O(n) time, O(1) space

## Solution1 ##

三遍遍历。 O(n) time, O(n) space

分成3步：

1. 复制节点，如A-B-C => A-A’-B-B’-C-C’
2. 依次遍历节点A,B,C，将A’B’C’这些节点的随机指针与其一致
3. 分离成 A-B-C 和 A’-B’-C’，A’-B’-C’便是所求链表

```
// C++
RandomListNode* copyRandomList_nn(RandomListNode* head)
{
	if (head == nullptr) return nullptr;
	RandomListNode *cur = head;
	// 创建拷贝
	while (cur) {
		RandomListNode *node = new RandomListNode(cur->label);
		node->next = cur->next;
		cur->next = node;
		cur = node->next;
	}
	// 调整random 指针
	cur = head;
	while (cur) {
		RandomListNode *node = cur->next;
		// 指向自身
		if (cur->random == cur) node->random = node;
		// 指向非空且不指向自身
		else if (cur->random) node->random = cur->random->next;
		// 指向空时，无需操作，因为默认为空
		cur = cur->next->next;
	}
	// 分离
	RandomListNode *copy = cur = head->next;
	while (cur->next) {
		cur->next = cur->next->next;
		cur = cur->next;
	}
	return copy;
}
```

## Solution2 ##

将各节点依次往后移一位，新建最后一位节点。 O(n) time, O(1) space

分成两步：

1. 移动：1->2->3->null => 1->1->2->3->null
2. 调整指针关系

```
// C++
RandomListNode* copyRandomList_n1(RandomListNode* head)
{
	if (head == nullptr) return nullptr;
	RandomListNode *prev = head, *cur = head->next;
	RandomListNode *copy;
	int prev_label = head->label, cur_label;
	// 移动 label
	// 1-2-3-null => 1-1-2-3-null
	while (cur) {
		// label 往后移动一位
		cur_label = cur->label;
		cur->label = prev_label;
		prev_label = cur_label;

		// 往后移动指针
		prev = cur;
		cur = cur->next;
	}
	// 最后一个节点，需要新建，并连接到原链表
	RandomListNode *last = new RandomListNode(prev_label);
	prev->next = last;

	// 调整 random 指针
	prev = head, cur = head->next;
	RandomListNode *cur_random = head->random, *prev_random;
	while (cur) {
		prev_random = cur_random; // 获取prev 的random 指针
		cur_random = cur->random; // 记录当前random 指针

		// 指向自身
		if (prev_random == prev) cur->random = cur;
		// 指向非空且不指向自身
		else if (prev_random) cur->random = prev_random->next;
		// 指向空
		else cur->random = nullptr;

		prev = cur;
		cur = cur->next;
	}
	return head->next;
}
```

END.

[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/