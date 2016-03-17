title: 'KMP: 字符串匹配算法'
tags:
  - algorithm
  - KMP
categories:
  - Dev
  - Algorithm
date: 2016-03-08 15:23:05
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

## KMP搜索 ##

字符串匹配是计算机的基本任务之一。举例来说，有一个字符串"BBC ABCDAB ABCDABCDABDE"，我想知道，里面是否包含另一个字符串"ABCDABD"？

许多算法可以完成这个任务，[Knuth-Morris-Pratt][kmp]算法（简称KMP）是最常用的之一。它以三个发明者命名，起头的那个K就是著名科学家[Donald Knuth][knuth]。下面用图例的方法展示一个搜索过程：

<!-- more -->

### 1 ###

![][kmp-1]

首先，字符串"BBC ABCDAB ABCDABCDABDE"的第一个字符与搜索词"ABCDABD"的第一个字符，进行比较。因为B与A不匹配，所以搜索词后移一位。

### 2 ###

![][kmp-2]

因为B与A不匹配，搜索词再往后移。

### 3 ###

![][kmp-3]

就这样，直到字符串有一个字符，与搜索词的第一个字符相同为止。

### 4 ###

![][kmp-5]

直到字符串有一个字符，与搜索词对应的字符不相同为止。

### 5 ###

![][kmp-6]

这时，最自然的反应是，将搜索词整个后移一位，再从头逐个比较就像上图所示。**这样做虽然可行，但是效率很差**，因为你要把"搜索位置"移到已经比较过的位置，重比一遍。

一个基本事实是，当空格与D不匹配时，你其实知道前面六个字符是"ABCDAB"。KMP算法的想法是，设法利用这个已知信息，不要把"搜索位置"移回已经比较过的位置，继续把它向后移，这样就提高了效率。

### 6 ###

![][kmp-8]

可以针对搜索词，算出一张**部分匹配表**（Partial Match Table）。这张表是如何产生的，后面再介绍，这里只要会用就可以了。

### 7 ###

![][kmp-5]

已知空格与D不匹配时，前面六个字符"ABCDAB"是匹配的。查表可知，最后一个匹配字符B对应的"部分匹配值"为2，因此按照下面的公式算出向后移动的位数：

```
　　移动位数 = 已匹配的字符数 - 对应的部分匹配值
```

因为 6 - 2 等于4，所以将搜索词向后移动4位。


### 8 ###

![][kmp-10]

因为空格与Ｃ不匹配，搜索词还要继续往后移。这时，已匹配的字符数为2（"AB"），对应的"部分匹配值"为0。所以，移动位数 = 2 - 0，结果为 2，于是将搜索词向后移2位。

### 9 ###

![][kmp-11]
因为空格与A不匹配，继续后移一位。

### 10 ###

![][kmp-12]

逐位比较，直到发现C与D不匹配。于是，移动位数 = 6 - 2，继续将搜索词向后移动4位。

### 11 ###

![][kmp-13]

逐位比较，直到搜索词的最后一位，发现完全匹配，于是搜索完成。如果还要继续搜索（即找出全部匹配），移动位数 = 7 - 0，再将搜索词向后移动7位，这里就不再重复了。

## Partial Match Table：部分匹配表 ##

![][kmp-14]

首先，要了解两个概念："前缀"和"后缀"。 "前缀"指除了最后一个字符以外，一个字符串的全部头部组合；"后缀"指除了第一个字符以外，一个字符串的全部尾部组合。

"部分匹配值"就是"前缀"和"后缀"的最长的共有元素的长度。以"ABCDABD"为例

- "A"的前缀和后缀都为空集，共有元素的长度为0；
- "AB"的前缀为[A]，后缀为[B]，共有元素的长度为0；
- "ABC"的前缀为[A, AB]，后缀为[BC, C]，共有元素的长度0；
- "ABCD"的前缀为[A, AB, ABC]，后缀为[BCD, CD, D]，共有元素的长度为0；
- "ABCDA"的前缀为[A, AB, ABC, ABCD]，后缀为[BCDA, CDA, DA, A]，共有元素为"A"，长度为1；
- "ABCDAB"的前缀为[A, AB, ABC, ABCD, ABCDA]，后缀为[BCDAB, CDAB, DAB, AB, B]，共有元素为"AB"，长度为2；
- "ABCDABD"的前缀为[A, AB, ABC, ABCD, ABCDA, ABCDAB]，后缀为[BCDABD, CDABD, DABD, ABD, BD, D]，共有元素的长度为0。

"部分匹配"的实质是，有时候，字符串头部和尾部会有重复。比如，"ABCDAB"之中有两个"AB"，那么它的"部分匹配值"就是2（"AB"的长度）。搜索词移动的时候，第一个"AB"向后移动4位（字符串长度-部分匹配值），就可以来到第二个"AB"的位置。

参考 @阮一峰 [KMP-cnblog][kmp-cnblog]

END.


[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[kmp]: https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm
[knuth]: https://en.wikipedia.org/wiki/Donald_Knuth
[kmp-cnblog]: http://kb.cnblogs.com/page/176818/
[kmp-1]: /images/kmp/kmp_1.png
[kmp-2]: /images/kmp/kmp_2.png
[kmp-3]: /images/kmp/kmp_3.png
[kmp-4]: /images/kmp/kmp_4.png
[kmp-5]: /images/kmp/kmp_5.png
[kmp-6]: /images/kmp/kmp_6.png
[kmp-7]: /images/kmp/kmp_7.png
[kmp-8]: /images/kmp/kmp_8.png
[kmp-9]: /images/kmp/kmp_9.png
[kmp-10]: /images/kmp/kmp_10.png
[kmp-11]: /images/kmp/kmp_11.png
[kmp-12]: /images/kmp/kmp_12.png
[kmp-13]: /images/kmp/kmp_13.png
[kmp-14]: /images/kmp/kmp_14.png