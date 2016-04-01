title: 'LPS: Longest Palindromic Substring(最长回文子串)'
tags:
  - algorithm
  - LPS
  - DP
  - Palindromic
  - Substring
categories:
  - Dev
  - Algorithm
date: 2016-03-29 20:04:32
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## 描述 ##

回文字符串的意思是指一个字符串，从头开始读和从尾开始读都是一样。例如，aba 是一个回文字符串，而 abc 不是。其中，单个字符也是回文字符串。

最长回文子串指在一个字符串中找到最长的那个回文字符串（可以假设该字符串只有一个最长字符串）。例如，

s = “caba”

最长的回文子串是 aba。

<!-- more -->

## Brute force solution, O(n^3) ##

暴力法就是取出所有可能的子字符串，然后验证它是否为回文字符串，最后得到最长的回文子串。

总共有 C(n, 2) 种子字符串（不包括单个字符的情况），因为验证每个子字符串的需要 O(n) 时间，故总共需要 O(n^3)。

## Dynamic programming solution, O(n^2) ##

为了改善暴力法的时间复杂度，首先需要避免重复计算的问题。比如，ababa，当我们知道 bab 是回文字符串时，很明显就可以看出 ababa 是回文字符串，因为 bab 的左边和右边的字符是相同的，都为 a。

更一般的：

```
假设 P(i, j) ← true  当且仅当 si...sj（字符串 s 下标从 i 到 j 的子串）是回文字符串
否则 P(i, j) ← false
```

即有

```
P(i, j) ← ( P(i+1, j-1) && Si == Sj )
```

综合起来就是

```
            true                             ,i = j
P[i][j] = { s[i] = s[j]                      ,j = i + 1
            s[i] = s[j] and P(i + 1, j - 1)  ,j > i + 1
```

于是有如下 O(n^2) time, O(n^2) space 的解法：

```
string longestPalindrome_DP(string s)
{
	const int n = s.size();
	bool *P = new bool[n * n];
	for (int i = 0; i < n * n; i++)
	{
		P[i] = false;
	}
	// vector<vector<bool>> P(n, vector<bool>(n, false)); // time exceeded
	int max_len = 1, start = 0;
	for (int i = 0; i < s.size(); i++)
	{
		P[i * n + i] = true; // P[i][i]
		for (int j = 0; j < i; j++)
		{
			// P[j][i] = (s[j] == s[i] && (i - j < 2 || P[j + 1][i - 1]));
			P[j * n + i] = (s[j] == s[i] && (i - j < 2 || P[(j + 1) * n + i - 1]));
			if (P[j * n + i] && max_len < (i - j + 1))
			{
				max_len = i - j + 1;
				start = j;
			}
		}
	}
	delete[] P;
	P = 0;
	return s.substr(start, max_len);
}
```

上述方法需要 O(n^2) 的空间和时间复杂度，可作如下改进，得到  O(n^2) time, O(1) space 的解法：

通过观察可以发现，回文字符串是中心对称的。所以一个会文字符串可以从它的中心开始展开，并且一共有 2n - 1 个这样的中心。

为什么有 2n - 1 个中心？是因为回文的中心可以在两个字符之间，如，abba 的中心在两个 b 之间。

因为从中心展开一个回文字符串需要 O(n) 时间复杂度，故总的时间复杂度为 O(n^2)。

```
string expandCenter(string s, int l, int r)
{
	const int n = s.size();
	while (l >= 0 && r <= n - 1 && s[l] == s[r])
	{
		l--;
		r++;
	}
	return s.substr(l + 1, r - l - 1);
}

string longestPalindrome_DP(string s)
{
	const int n = s.size();
	if (n == 0) return string();  
    // single char itself is a palindrome
	string longest = s.substr(0, 1);
	for (int i = 0; i < n - 1; i++)
	{
		string s1 = expandCenter(s, i, i);
		string s2 = expandCenter(s, i, i + 1);
		if (s1.size() > longest.size()) longest = s1;
		if (s2.size() > longest.size()) longest = s2;
	}
	return longest;
}
```

## Manacher’s algorithm, O(n) ##

### 转换 ###

首先，我们利用 # 将输入的字符串转换。如

s = "abaaba"  =>  t = "#a#b#a#a#b#a#"

为了避免边界的检测，我们还可以在**两边分别插入一个不同的字符作为边界哨兵**（# 除外），例如 ^ 和 $

t = "^#a#b#a#a#b#a#$"

根据前面（动态规划方法2）所说，我们需要根据 t\_{i} 展开得到 t\_{i-d} ... t\_{i+d} 回文串。则很容易发现 d 就是以 t\_{i} 为中心的回文串的长度。

我们利用 P[i] 来记录以 t\_{i} 为中心的回文子串的长度，则 p[i] 中最大值就是最长回文子串的长度。

直观地：

```
t = ^ # a # b # a # a # b # a # $
P = 0 0 1 0 3 0 1 6 1 0 3 0 1 0 0
```

通过观察 P 可以知道，最长的回文子串为 abaaba 且长度为 6。

并且很容易看出，s 的长度不管是奇数还是偶数的都会转换为长度为奇数的 t。


### 举例 ###

下面介绍一个更加复杂的例子，s = "babcbabcbaccba"

![][pic-1]

假设我们计算到当前状态 i = 13 的时候，实竖线表示回文串 "abcbabcba" 的中心（C）。两个虚线 L 和 R 分别表示左右边界。此时该如何计算 P[i] 呢？

假设我们现在处于 i = 13，现在需要计算 p[i]（用？标明的地方）。我们先看它关于中心 C 的对称点 i'，它的下标是 i' = 9

![][pic-2]

两条绿色的实线分别表示以 i 和 i' 为中心的回文串所覆盖的范围。它们满足对称的性质，故有 P[i] = p[i'] = 1。实际上，接下来的三个元素都满足该性质（即，P[ 12 ] = P[ 10 ] = 0, P[ 13 ] = P[ 9 ] = 1, P[ 14 ] = P[ 8 ] = 0）。

![][pic-3]

现在 i = 15，它的对称点为 i' = 7 且 P[7] = 7，那么 P[15] = P[7] = 7？

我们通过观察发现 P[15] = 5 != P[7] = 7，如果我们在 t\_{15} 进行展开，它的回文串为 "a#b#c#b#a"，这比 7 小，为什么？

![][pic-4]

上面标出颜色的线表示 i 和 i' 的覆盖范围，实绿线表示符合对称性质的区域，红实线表示可能不符合，虚绿线表示重合的地方。

显然，绿实线表示的区域是完全符合对称的。注意到 P[i'] = 7 一直展开至 L 的左边，所以 L 左边的部分不符合对称。我们知道的是 P[i] >= 5，为了找到确切的 P[i] 我们需要增加 R 来进行更多匹配。对于本例来说，因为 P[21] != P[1]，则有 P[i] = 5。

现在总结该算法如下：

```
if   P[i'] <= R - i,
then P[i]   = P[i']
else P[i]  >= P[i'].(这种情况需要展开 R 来找 P[i])
```

接下来就是，何时我们才需要往右移动 C 和 R，即：

```
如果以 i 为中心的回文串展开超过 R，则更新 C = i（作为新回文串的中心），同时将 R 更新为新回文串的右边界。
```

每一步都只有两种情况：

1. P[i] <= R - i：则 P[i] = P[i']，只需要一步计算。
2. 从右边界 R 开始拓展，试图将回文串的中心更改为 i。

拓展 R 做多只需要做 n 步，并且中心测试也只需要 n 次。所以该算法能够保证在 2\*n 内做完，即 O(n)。

```
// Transform S into T.
// For example, S = "abba", T = "^#a#b#b#a#$".
// ^ and $ signs are sentinels appended to each end to avoid bounds checking
string preProcess(string s)
{
	int n = s.size();
	if (n == 0) return "^$";
	string ans = "^";
	for (int i = 0; i < n; i++) ans += "#" + s.substr(i, 1);
	ans += "#$";
	return ans;
}

// Manacher's Algorithm, O(n) time, O(n) space
string longestPalindrome_Manachers(string s)
{
	string T = preProcess(s);
	const int n = T.size();
	int *P = new int[n];
	int C = 0, R = 0;
	for (int i = 1; i < n - 1; i++)
	{
		int i_mirror = 2 * C - i;  // equals to i' = C - (i - C)
		P[i] = (R > i) ? min(R - i, P[i_mirror]) : 0;

		// Attempt to expand palindrome centered at i
		while (T[i + 1 + P[i]] == T[i - 1 - P[i]])
		{
			P[i]++;
		}

		// If palindrome centered at i expand past R,
		// adjust center based on expanded palindrome
		if (i + P[i] > R)
		{
			C = i;
			R = i + P[i];
		}
	}

	// find the maximun element in P
	int max_len = 0, center_index = 0;
	for (int i = 1; i < n - 1; i++)
	{
		if (P[i] > max_len)
		{
			max_len = P[i];
			center_index = i;
		}
	}
	delete[] P;
	P = 0;
	return s.substr((center_index - 1 - max_len) / 2, max_len);
}
```

Reference：

1. [longest palindromic substring part I][LPS-i]
2. [longest palindromic substring part II][LPS-ii]

END.

[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[LPS-i]: http://articles.leetcode.com/longest-palindromic-substring-part-i/
[LPS-ii]: http://articles.leetcode.com/longest-palindromic-substring-part-ii/
[pic-1]: /images/lps/lps_1.png
[pic-2]: /images/lps/lps_2.png
[pic-3]: /images/lps/lps_3.png
[pic-4]: /images/lps/lps_4.png