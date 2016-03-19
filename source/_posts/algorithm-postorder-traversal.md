title: '二叉树的后序遍历'
tags:
  - algorithm
  - binary tree
  - postorder traversal
categories:
  - Dev
  - Algorithm
date: 2016-03-19 20:09:32
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 二叉树的遍历 ##

二叉树的先序、中序、后序说的都是根相对的位置来说的。

1. 先序（先根）：根-左-右
2. 中序（中根）：左-根-右
3. 后序（后根）：左-右-根

<!-- more -->

比如，有如下二叉树：

```
  1
 / \
2   3
 \   \
  4   5
```

则我们可以知道

1. 先序：preorder = [1,2,4,3,5]
2. 中序：inorder = [2,4,1,3,5]
3. 后序：postorder = [4,2,5,3,1]

下面介绍的是后序遍历算法，分别使用递归和非递归方法。

## 递归方法 ##

算法首先遍历左子树，然后遍历右子树，最后是根节点。

```
// C++
vector<int> postorderTraversal(TreeNode *root) {
	vector<int> ans;
	postorder(root, ans);
	return ans;
}  
void postorder(TreeNode *root, vector<int> &ans) {
	if (!root) return;
	postorder(root->left, ans);  // 左子树
	postorder(root->right, ans);  // 右子树
	ans.push_back(root->val);  // 根
}
```

## 非递归方法 ##

可以用栈或 Morris 遍历

### 1. 栈 ###

```
// C++
// 栈：时间复杂度 O(n)， 空间复杂度 O(n)
vector<int> Trees::postorderTraversal(TreeNode* root)
{
	
	vector<int> ans;
	stack<const TreeNode*> s;
	// *p 正在访问的点，*q 刚刚访问的点
	const TreeNode *p, *q;
	p = root;
	do {
		while (p) {  // 往左走
			s.push(p);
			p = p->left;
		}
		q = nullptr;  // 未被访问过
		while (!s.empty()) {
			p = s.top();
			s.pop();
			// 右孩子不存在，或已被访问
			if (p->right == q) {
				ans.push_back(p->val);
				q = p;  // 保存刚访问的节点
			}
			else {
				//当前节点不能访问，再次进栈
				s.push(p);
				// 先处理右子树
				p = p->right;
				break;
			}
		}
	} while (!s.empty());
	return ans;
}
```

### 2. Morris ###

```
// C++
// Morris：时间复杂度 O(n)， 空间复杂度 O(1)
vector<int> Trees::postorderTraversal_Morris(TreeNode* root)
{
	vector<int> ans;
	TreeNode fake(-1);
	TreeNode *cur, *prev = nullptr;
	function< void(const TreeNode*) > visit = [&ans](const TreeNode *node) {
		ans.push_back(node->val);
	};

	fake.left = root;
	cur = &fake;
	while (cur != nullptr)
	{
		if (cur->left == nullptr)
		{
			prev = cur; // 必须要有
			cur = cur->right;
		}
		else
		{
			TreeNode *node = cur->left;
			while (node->right != nullptr && node->right != cur)
			{
				node = node->right;
			}
			/* 还没线索化，则建立线索 */
			if (node->right == nullptr)
			{
				node->right = cur;
				prev = cur;  // 必须要有
				cur = cur->left;
			}
			/* 已经线索化，则访问节点，并删除线索 */
			else
			{
				visit_reverse(cur->left, prev, visit);
				prev->right = nullptr;
				prev = cur;  // 必须要有
				cur = cur->right;
			}
		}
	}
	return ans;
}
// 逆转路径
void Trees::reverse(TreeNode *from, TreeNode *to)
{
	TreeNode *x = from, *y = from->right, *z;
	if (from == to) return;
	while (x != to)
	{
		z = y->right;
		y->right = x;
		x = y;
		y = z;
	}
}
// 访问逆转后的路径上的所有结点
void Trees::visit_reverse(TreeNode *from, TreeNode *to,
	function< void(const TreeNode*) >& visit)
{
	TreeNode *p = to;
	reverse(from, to);
	while (true)
	{
		visit(p);
		if (p == from) break;
		p = p->right;
	}
	reverse(to, from);
}
```

较复杂，可以参考 [Morris Traversal方法遍历二叉树（非递归，不用栈，O(1)空间）- cnblogs][morris]

END.

[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[morris]: http://www.cnblogs.com/AnnieKim/archive/2013/06/15/MorrisTraversal.html