title: '由前序遍历和中序遍历树构造二叉树'
tags:
  - algorithm
  - binary tree
  - preorder
  - inorder
categories:
  - Dev
  - Algorithm
date: 2016-03-17 22:23:05
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

## 算法 ##

算法首先利用先序遍历序列构造“跟”节点，然后依据中序遍历序列来构造左右子树。就拿上面二叉树举例，算法流程如下：

1. 根节点（root）是先序序列中的第一个节点preorder[0] = 1；
2. 在inorder 中找到值等于1 的点，然后将inorder 分为左右两块，即[2,4] 和[3,5]
3. 利用两块[2,4] 和[3,5] 分别用来构造根节点1 的左右子树。
4. 递归产生各子树

C++代码如下（仅供参考）：

```
/**
 * Definition of TreeNode:
 * class TreeNode {
 * public:
 *     int val;
 *     TreeNode *left, *right;
 *     TreeNode(int val) {
 *         this->val = val;
 *         this->left = this->right = NULL;
 *     }
 * }
 */
 

class Solution {
    /**
     *@param preorder : A list of integers that preorder traversal of a tree
     *@param inorder : A list of integers that inorder traversal of a tree
     *@return : Root of a tree
     */
public:
    TreeNode *buildTree(vector<int> &preorder, vector<int> &inorder) {
        int len_pre = preorder.size(), len_in = inorder.size();
        if (!len_in || !len_pre) return NULL;
        TreeNode *root = new TreeNode(preorder[0]);
        int in = 0;  // in: 中序遍历根节点所在位置
        while (preorder[0] != inorder[in]) in++;  // 在中序遍历找到根节点位置
        preorder.erase(preorder.begin()); // 去除preorder的第一个元素
        vector<int>::iterator it_in = inorder.begin();
        vector<int> inorder_left, inorder_right;
        if (in != 0)  // 有左子树
        {
            inorder_left = vector<int>(it_in, it_in + in);  // 左侧子树的中序遍历
        }
        if (in != len_in -1)  // 有右子树
        {
            inorder_right = vector<int>(it_in + in + 1, inorder.end());  // 右侧子树的中序遍历
        }
        root->left = buildTree(preorder, inorder_left);  // 构造左子树
        root->right = buildTree(preorder, inorder_right);  // 构造右子树
        return root;
    }
};
```

END.


[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/