title: '阿里电话面试'
tags:
  - interview
  - alibaba
  - hhh
categories:
  - Odds&Ends
  - JobHunting
date: 2016-03-08 22:00:05
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0][cc]

今天（2016-03-08）是我人生中接受的第一次面试，并不是想象中的那么顺利（意思是不行hhh）。当我看到电话上“浙江-杭州”四个字时，手就开始抖了，即使是现在（接完电话1个小时）心也还未平静下来。因为我知道我没准备好，不是说仅仅心理上没准备好，而是心理上、身体上（嗯，身体上）和知识储备上完完全全、彻彻底底的没准备好！所以我方了，以至于听不清对方讲话，听清了也回答不上来。。。尴尬症都犯了。。。不过面试官人好、态度好，想必是个帅哥、暖男？（我是男的！没那种意思。。），问的问题虽然简单，但是我答不上来啊hhh。

<!-- more -->

关于我答不上来这件事，我知道完全是我自己没准备，以至于错失一次好机会。也总结出关于投递简历的一点小建议（其实是师兄告诉我的。。）：**在deadline之前，在没准备好的情况下，先别冲动投简历！**至于怎么界定“准备好”，就得看大家自己的感觉了。对于我来说，至少需要把基础书看上一遍吧。。不能跟我一样卡壳在基础知识上，以至于面试官认为你根本不是简历上说的那么犀利（excellent？就那意思啦），甚至认为在造假，这种错误我绝不能再犯第二次，嗯，不能。。


下面是今天的问题，大概。。

1，	HTPP中URL由几部分组成
答：（参考[URL-Wikipedia][wiki-url]）

超文本传输协议（HTTP）的统一资源定位符将从因特网获取信息的五个基本元素包括在一个简单的地址中：
- 传送协议。
- 服务器。（通常为域名，有时为IP地址）
- 端口号。（以数字方式表示，若为HTTP的预设值“:80”可省略）
- 路径。（以“/”字元区别路径中的每一个目录名称）
- 查询。（GET模式的表单参数，以“?”字元为起点，每个参数以“&”隔开，再以“=”分开参数名称与资料，通常以UTF8的URL编码，避开字元冲突的问题）

2，排序算法
答：（参考[排序算法-Wikipedia][wiki-sort]）

#### 稳定的排序 ####

1. 冒泡排序（bubble sort）— O(n2)
2. 鸡尾酒排序（cocktail sort）—O(n2)
3. 插入排序（insertion sort）—O(n2)
4. 桶排序（bucket sort）—O(n)；需要O(k)额外空间
5. 计数排序（counting sort）—O(n+k)；需要O(n+k)额外空间
6. 归并排序（merge sort）—O(n log n)；需要O(n)额外空间
7. 原地归并排序— O(n log2 n)如果使用最佳的现在版本
8. 二叉排序树排序（binary tree sort）— O(n log n)期望时间；O(n2)最坏时间；需要O(n)额外空间
9. 鸽巢排序（pigeonhole sort）—O(n+k)；需要O(k)额外空间
10. 基数排序（radix sort）—O(n·k)；需要O(n)额外空间
11. 侏儒排序（gnome sort）— O(n2)
12. 图书馆排序（library sort）— O(n log n)期望时间；O(n2)最坏时间；需要(1+ε)n额外空间
13. 块排序（block sort）— O(n log n)
14. 额外儿童网二对一后退萨大人排序（children two to one additional network Back Sa adults sort）— O(n2)

#### 不稳定排序 ####

1. 选择排序（selection sort）—O(n2)
2. 希尔排序（shell sort）—O(n log2 n)如果使用最佳的现在版本
3. Clover排序算法（Clover sort）—O(n)期望时间，O(n2)最坏情况
4. 梳排序— O(n log n)
5. 堆排序（heap sort）—O(n log n)
6. 平滑排序（smooth sort）— O(n log n)
7. 快速排序（quick sort）—O(n log n)期望时间，O(n2)最坏情况；对于大的、随机数列表一般相信是最快的已知排序
8. 内省排序（introsort）—O(n log n)
9. 耐心排序（patience sort）—O(n log n + k)最坏情况时间，需要额外的O(n + k)空间，也需要找到最长的递增子序列（longest increasing subsequence）

3，浏览器输入一个网址，其背后原理解释
答：(参考 [在浏览器中输入网址后都发生了什么][URL-TCP])

从输入一个网址到显示，包括dns解析，http协议解析，html解析，js解析，以及各种内容渲染
1. 浏览器发起DNS查询请求
在广域网中，我们是基于IP地址进行通信的。但通常客户访问的是一个网址，为此，我们需要先得到网址对应的IP地址，这就需要域名服务系统将域名转换成IP地址。

2. 域名服务器向客户端返回查询结果域名，从而完成域名到IP地址的转换

3. 客户端向web服务器发送HTTP请求
在得到了域名对应的IP地址后，客户端便可以向真正的web服务器发生HTTP请求。
HTTP请求是一个基于TCP协议之上的应用层协议——超文本传输协议。浏览器通过DNS获取到web服务器真的IP地址后，便向web服务器发起tcp连接请求，通过TCP三次握手建立好连接后，浏览器便可以将HTTP请求数据通过发送给服务器了。

4. 发送响应数据给客户端
Web服务器通常通过监听80端口，来获取客户端的HTTP请求。与客户端建立好TCP连接后，web服务器开始接受客户端发来的数据，并通过HTTP解码，从接受到的网络数据中解析出请求的url信息以前其他诸如Accept-Encoding、Accept-Language等信息。
至此，一个HTTP通信过程完成。web服务器会根据HTTP请求头中的Connection字段值决定是否关闭TCP链接通道，当Connection字段值为keep-alive时，web服务器不会立即关闭此连接。

[wiki-url]: https://zh.wikipedia.org/wiki/%E7%BB%9F%E4%B8%80%E8%B5%84%E6%BA%90%E5%AE%9A%E4%BD%8D%E7%AC%A6
[wiki-sort]: https://zh.wikipedia.org/wiki/%E6%8E%92%E5%BA%8F%E7%AE%97%E6%B3%95
[URL-TCP]: http://www.cricode.com/3696.html
[cc]: https://creativecommons.org/licenses/by-nc-nd/4.0/