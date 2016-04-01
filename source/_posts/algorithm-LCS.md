title: 'LCS: Longest Common Subsequence(最长公共子序列)'
tags:
  - algorithm
  - LCS
  - DP
  - Subsequence
categories:
  - Dev
  - Algorithm
date: 2016-03-25 22:30:32
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 概念 ##

### 子序列 ###

设X = < x1, x2,..., xm >，若有1≤ i1 < i2 < ... < ik &le; m，使得 Z = < z1, z2, ..., zk> = < xi1, xi2, ..., xik >，则称Z 是X 的子序列， 记为Z < X。 
e.g. X = < A,B,C,B,D,A,B >,  Z = < B,C,B,A >,  则有Z < X。

<!-- more --> 

### 公共子序列 ###

设X，Y 是两个序列，且有Z < X 和Z < Y， 则称Z 是X 和Y 的公共子序列。 

### 最长公共子序列的概念 ###
  
若Z < X，Z < Y，且不存在比Z 更长的X 和Y 的公共子序列， 则称Z是X和Y 的最长公共子序列，记为Z &isin; LCS(X, Y)。

### 最长公共子序列往往不止一个 ###

e.g. X = < A,B,C,B,D,A,B >,  Y = < B,D,C,A,B,A >.

则 Z = < B,C,B,A >,   Z’ = < B,C,A,B >,  Z’’ = < B,D,A,B > 均属于LCS(X, Y) ，即X,Y 有3 个LCS。

## 算法 ##

### Brute-force（暴力法） ###

列出X 的所有长度不超过n （即|Y|）的子序列，从长到短逐一进行检查，看其是否为Y 的子序列，直到找到第一个最长公共子序列。由于X共有2^m 个子序列，故此方法对较大的m 没有实用价值。

### DP(动态规划) ###

记Xi = &lt; x1，...，xi &gt;即X序列的前i个字符 (1 &le; i &le; m)（前缀） Yj = &lt; y1，...，yj &gt;即Y 序列的前j 个字符 (1≤ j≤ n)（前缀） 假定Z = &lt; z1，...，zk &gt; &isin; LCS(X, Y)。 

1. 若xm = yn（最后一个字符相同），则不难用反证法证明：
该字符必是X 与Y 的任一最长公共子序列Z（设长度为k）的 最后一个字符，即有zk = xm = yn 且显然有 Zk-1 &isin; LCS(Xm-1 , Yn-1) 即Z 的前缀Zk-1 是Xm-1 与Yn-1 的最长公共子序列。 
2. 若xm &ne; yn，则亦不难用反证法证明： 
要么Z &isin; LCS(Xm-1, Y)，要么Z &isin; LCS(X, Yn-1)。 由于zk &ne; xm 与zk &ne; yn 其中至少有一个必成立，因此： 若zk &ne; xm则有Z &isin; LCS(Xm-1 , Y)， 若zk &ne; yn 则有Z &isin; LCS(X, Yn-1)。


**所以**

1. 若xm = yn，则问题化归成求Xm-1 与Yn-1 的LCS。
（LCS(X, Y)的长度等于LCS(Xm-1, Yn-1) 的长度加1） 
2. 若xm &ne; yn 则问题化归成求Xm-1 与Y 的LCS 及X 与Yn-1 的LCS
LCS(X , Y)的长度为：max{LCS(Xm-1, Y)的长度, LCS(X, Yn-1)的长度} 

引进一个二维数组C，用C[i,j]记录Xi与Yj的LCS的长度   如果我们是自底向上进行递推计算，那么在计算C[i,j]之前， C[i-1,j-1], C[i-1,j]与C[i,j-1]均已计算出来。此时我们 根据X[i]=Y[j]还是X[i]Y[j]，就可以计算出C[i,j]： 
1. 若X[i] = Y[j]，则执行C[i,j]←C[i-1,j-1]+1；
2. 若X[i] &ne; Y[j]，则根据： 若C[i-1,j]≥C[i,j-1]则C[i,j]←C[i-1,j]；
3. 否则C[i,j]←C[i,j-1]。即有

```
          0;                         若i = 0 或j = 0；
C[i,j] ={ C[i-1, j-1] + 1;           若i, j > 0 且 xi = yj；
          max{C[i-1, j], C[i, j-1]}  若i, j > 0 且 xi != yj；
```

如下图

![][LCS]

为了构造出LCS，使用一个m &times; n 的二维数组b， b[i,j] 记录C[i,j] 是通过哪一个子问题的值求得的, 以决定搜索的方向： 

1. 若X[i] = Y[j]，，则b[i,j] 中记入“↖”；
2. 若C[i-1,j] ≥ C[i,j-1]，则b[i,j] 中记入“↑”； 
3. 若C[i-1,j] < C[i,j-1]，则b[i,j] 中记入“←”；

算法伪代码

```
LCS(X,Y,m,n,C) {
    for i=0 to m do C[i,0]←0
    for j=1 to n do C[0,j]←0 
    for i=1 to m do {
        for j=1 to n do{
            if x[i]=y[j] {
                C[i,j]←C[i-1,j-1]+1；
                b[i,j]←“↖” ；
            }
            else if C[i-1,j]≥C[i,j-1] {
                C[i,j]←C[i-1,j]；
                b[i,j]←“↑” ；
            }
            else {
                C[i,j]←C[i,j-1]；
                b[i,j]←“←”;
            }
        }
    } 
}
```

输出**一个**LCS(X,Y) 的递归算法

```
LCS_Output(b,X,i,j) {
    if i=0 or j=0 
        return; 
    if b[i,j]=“↖” {             /*X[i]=Y[j]*/
        LCS_Output(b,X,i-1,j-1)；
        输出 X[i]；
    } 
    else if b[i,j]=“↑”           /*C[i-1,j]≥C[i,j-1]*/
        LCS_Output(b,X,i-1,j) 
    else if b[i,j]=“←”           /*C[i-1,j]<C[i,j-1]*/
        LCS_Output(b,X,i,j-1)
}
```

对上述例子调用 **LCS_Output(b,X,7,6)**。

下面是输出全部LCS 的C++ 代码：

```
#include <string>
#include <vector>
#include <stack>
#include <iostream>
using namespace std;

class LCS
{
    vector<string> ans;

    void LCS_L(string x, string y, vector<vector<int>>& C)
	{
		int m = x.size(), n = y.size();
		C = vector<vector<int>>(m + 1, vector<int>(n + 1, 0));
		for (int i = 1; i <= m; i++)
		{
			for (int j = 1; j <= n; j++)
			{
				if (x[i - 1] == y[j - 1]) C[i][j] = C[i - 1][j - 1] + 1;  // 相同
				else if (C[i - 1][j] >= C[i][j - 1]) C[i][j] = C[i - 1][j];  // 不相同，取较大的一个
				else C[i][j] = C[i][j - 1];
			}
		}
	}

	void LCS_output(string x, string y, vector<vector<int>>& C, int i, int j, string lcs)
	{
		while (i > 0 && j > 0) {
			if (x[i - 1] == y[j - 1])  // 由右上角产生
			{
				lcs.push_back(x[i - 1]);
				--i;
				--j;
			}
			else
			{
				if      (C[i - 1][j] > C[i][j - 1]) --i;
				else if (C[i - 1][j] < C[i][j - 1]) --j;
				else  // equal
				{
					LCS_output(x, y, C, i - 1, j, lcs);
					LCS_output(x, y, C, i, j - 1, lcs);
					return;
				}
			}
		}
		reverse(lcs.begin(), lcs.end());
		ans.push_back(lcs);
	}

};
```

调用

```
int main()
{
	LCS lcs;
	vector<vector<int>> C;
	string x = "ABCBDAB", y = "BDCABA", str;
	lcs.LCS_L(x, y, C);
	lcs.LCS_output(x, y, C, x.size(), y.size(), str);;
	for (auto s : lcs.ans)
	{
		cout << s << endl;
	}
    return 0;
}
```

结果

```
BCBA
BCAB
BDAB
```

END.

[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[LCS]: /images/LCS.png