title: 'LaTeX: LLNCS v2.4'
tags:
  - LaTeX
  - LLNCS
categories:
  - Odds&Ends
  - LaTex
date: 2016-01-09 10:02:00
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

最近写的论文需要使用到 LaTeX 格式，故学习一些相关的知识。不过下面的并不是 LaTeX 教程，只是 Springer 的 LLNCS 类，具体的 LaTex 相关请见[官网](http://www.latex-project.org/)

### How to proceed ###

下载的压缩包包含如下文件:

|Files in package|说明|
|--|--|
|history.txt| the version history of the package|
|llncs.cls| class ﬁle for LATEX|
|llncs.dem| an example showing how to code the text|
|llncs.doc| general instructions (source of this document), llncs.doc means latex documentation for Lecture Notes in Computer Science|
|llncsdoc.pdf| the documentation of the class (PDF version)|
|llncs.doc| general instructions (source of this document)|
|llncsdoc.sty| class modiﬁcations to help for the instructions|
|llncs.ind| an external (faked) author index ﬁle|
|subjidx.ind| subject index demo from the Springer book package|
|llncs.dvi| the resultig DVI ﬁle (remember to use binary transfer!)|
|sprmindx.sty| supplementary style ﬁle for MakeIndex (usage: `makeindex -s sprmindx.sty <yourfile.idx>`)|

<!-- more -->

#### Invoke LLNCS class ####

LLNCS 只是标准 LATEX “article” class 的拓展版本，所以在文章中可以使用所有 “article” 的语法。如果要使用 LLNCS class，则使用如下形式：

```cpp
\documentclass{llncs}
%
\begin{document}
<Your contribution>
\end{document}
```

#### 文章已经用 LATEX 写好而未使用 LLNCS 格式的情况 ####

请不要使用任何会影响文档布局或格式的 LATEX 或 TEX命令（即像 `\textheight`, `\vspace`, `\headsep`, etc）。然而，有可能会有例外的情况下，可以使用一些。

### 公式输入 ###

公式会以您文章出现的顺序在右手边使用阿拉伯数字自动编号。当你的工作在数学模式时，都是用斜体字排版。有时候你需要插入非数学元素（例如单词或短语）。这种插入的代码应该使用 roman（即 `\mbox`）如下例所示： 

```cpp
\begin{equation} 
\left(\frac{a^{2} + b^{2}}{c^{3}} \right) = 1 \quad
\mbox{ if } c\neq 0 \mbox{ and if } a,b,c\in \bbbr \enspace .
\end{equation}
```

输出示例：

![](/images/equation_sample.png)

如果你想在一个显示公式后立即开始新的段落，插入一个空白行，以产生所需的缩进。如果不插入一个空白行或代码 `\noindent` 会立即继续之前的文本而没有没有新的段落。

displayed 公式也使用相同的方式处理，其他普通文本则在结束本句前使用 `\enspace`。

注意括号的尺寸或其他分隔符必须保证是闭合的，使用下面命令可以保证：

```cpp
\left( 或者 \left[ 和 \right) 或者 \right].
```

#### 斜体和 Roman 体 ####

1. 在公式中，一般使用斜体，但下标应使用 Roman 体而不是斜体。
2. 确保一些物理标记使用 `\mathrm` 命令，如 Hz： `\mathrm{Hz}`。还有一些常用的数学函数，如 log，sin，exp，max和sup应该使用：`\log`，`\sin`，`\exp`，`\max` 和 `\sup`。
3. 化学式应该使用 Roman 体，如： H2O。
4. 熟悉的单词或句子不应使用斜体，如： et al., a priori, in situ, bremsstrahlung, eigenvalues。

### How to Edit Input (Source) File ###

#### Headings ####

标题中的所有单词应该都大写，除了连词、介词 (例如 on, of, by, and, or, but, from, with, without, under) 还有定冠词和不定冠词 (the, a, an) 除非他们出现在开头，否则均小写。公式的字母必须在文本内排版。

#### 大写和不大写 ####

1. 下面情况均需大写：
	1. Headings。
	2. 文章中的缩写和表达式，如：  Fig(s)., Table(s), Sect(s)., Chap(s)., Theorem, Corollary, Deﬁnition etc. 跟数字一起使用时，如： Fig.3, Table 1, Theorem 2。
2.  下面情况不能大写：
	1.  在文章中，当 ﬁgure(s), table(s), equation(s), theorem(s) 等词没有与编号一起使用时。
	2.  图表图例和表格标题，除非是缩写。

#### 词的缩写 ####

1. 下列词除非是出现在句子开头，否则在文章中应该使用缩写： Chap., Sect., Fig.。例如： The results are depicted in Fig.5. Figure 9 reveals that .... 
	> 注： 公式一般使用括号跟数字代替，但出现在句子开头时需使用 “Equation”。 例如：Equation (14) is very important. However, (15) makes it clear that .... 
2. 如果文章中有出现全局的缩写，应该在第一次出现的时候标明，如： Plurisubharmonic (PSH) Functions, Strong Optimization (SOPT) Problem.

### 文章的开头 ###

文章的标题（必须的）使用如下形式：

```cpp
\title{<Your contribution title>} 
```

标题中所有单词应大写，除了连词、介词和不出现在开头的定冠词和不定冠词。标题没有结束标点。

如果是很长的标题，使用 `\\` 另起一行。

If you are to produce running heads for a speciﬁc volume the standard (of no such running heads) is overwritten with the [runningheads] option in the \documentclass line. For long titles that do not ﬁt in the single line of the running head a warning is generated. You can specify an abbreviated title for the running head on odd pages with the command：

```cpp
\titlerunning{<Your abbreviated contribution title>}
```

There is also a possibility to change the text of the title that goes into the table of contents (that’s for volume editors only – there is no table of contents for a single contribution). For this use the command:

```cpp
\toctitle{<Your changed title for the table of contents>}
```

副标题使用：

```cpp
\subtitle{<subtitle of your contribution>}
```

作者使用：

```cpp
\author{<author(s) name(s)>}
```

为每个作者或地址指定标号时，使用： 

```cpp
\inst{<no>}
```

超过一位作者的话，可以使用 `\and` 分隔。例如：

```cpp
\author{Ivar Ekeland\inst{1} \and Roger Temam\inst{2}}
```

下面就是地址（学校，公司）了，多于一个地址，使用 `\and` 命令会自动编号，请确保跟作者顺序对应。

```cpp
\institute{<name of an institute>
\and <name of the next institute>
\and <name of the next institute>} 
```

在 `\institute` 内使用 `\email{<email address>} ` 可以提供email地址。如果在文章的任何地方需要注脚，请使用(immediately after the word where the footnote indicator should be placed)：

```cpp
\thanks{<text>} 
```

`\thanks` 仅能出现在 `\title`, `\author` and `\institute`中. 如果有两个或更多的脚注使用 `\fnmsep` (i.e. footnote mark separator) 分隔.

```cpp
\maketitle
```

然后 heading 就结束了，到这一步为止，还不会产生任何文本。

接下来就是摘要：

```cpp
\begin{abstract}
<Text of the summary of your article>
\end{abstract}
``` 

### How to Code Your Text ###

用以下代码的话，标题会自动编号：

```cpp
\section{This is a First-Order Title} 
\subsection{This is a Second-Order Title} 
\subsubsection{This is a Third-Order Title.} 
\paragraph{This is a Fourth-Order Title.} 
```

`\section` and `\subsection` 没有 end punctuation。`\subsubsection` and `\paragraph` 需要在末尾 punctuate。 

另外，theorem-like environments 会自动编号，如果要使用计数器，只需指定 `envcountsame`:

```cpp
\documentclass[envcountsame]{llncs}
```

例如 `\begin{lema}`，第一次调用时会编号为1，再次调用编号为2，以此类推。如果需要每个 section 都重新计数，则指定为 `envcountreset`:

```cpp
\documentclass[envcountreset]{llncs} 
```

### 预定义的 Theorem-like Environments ###

下面的标题随你选择：

1. 加粗并带斜体文本的 run-in 标题：
```cpp
\begin{corollary} <text> \end{corollary} 
\begin{lemma} <text> \end{lemma} 
\begin{proposition} <text> \end{proposition} 
\begin{theorem} <text> \end{theorem} 
```
2. 以下的一般表现为斜体 run-in 标题：
```cpp
\begin{proof} <text> \qed \end{proof}
```
这不编号，并且在结束前有一个吸引眼球的 square （即 `\qed`）。
3.  更多斜体和加粗体 run-in 标题：
```cpp
\begin{definition} <text> \end{definition}
\begin{example} <text> \end{example} 
\begin{exercise} <text> \end{exercise} 
\begin{note} <text> \end{note} 
\begin{problem} <text> \end{problem} 
\begin{question} <text> \end{question} 
\begin{remark} <text> \end{remark} 
\begin{solution} <text> \end{solution}
```

### 自定义的 Theorem-like Environments ###

加强了标准的 `\newtheorem` 命令，得到两个新的命令 `\ spnewtheorem` 和 `\spnewtheorem*`，现在可以使用来定义新的语法。需要两个参数：type style 和 text style。type style 表示所出现的环境，text style 表示新环境的 text style。使用 `\ spnewtheorem` 的两种方法：

#### 第一种（推荐！） ####

如果想与其他环境共享计数器，使用

```cpp
\spnewtheorem{<env_nam>}[<num_like>]{<caption>} {<cap_font>}{<body_font>} 
```

`[<num_like>]` 指定为想要共享的环境。

例如：

```cpp
\spnewtheorem{mainth}[theorem]{Main Theorem}{\bfseries}{\itshape} 
\begin{theorem} The early bird gets the worm. \end{theorem} 
\begin{mainth} The early worm gets eaten. \end{mainth}
```

输出为

```cpp
Theorem 3. The early bird gets the worm. 
Main Theorem 4. The early worm gets eaten. 
```

#### 第二种 ####

```cpp
\spnewtheorem{<env_nam>}{<caption>}[<within>]
{<cap_font>}{<body_font>}
```

上述代码会定义一个名为 `<env_name>` 的环境，它以 `<cap_font>` 打印标题 `<caption>`， 它以 `<body_font>` 打印文本。在每个新 section 指定 `<within>` 时，会重新编号。

例如：

```cpp
\spnewtheorem{joke}{Joke}[subsection]{\bfseries}{\rmfamily} 
```

deﬁnes a new environment called joke which prints the caption Joke in boldface and the text in roman. The jokes are numbered starting from 1 at the beginning of every subsection with the number of the subsection preceding the number of the joke e.g. 7.2.1 for the ﬁrst joke in subsection 7.2.

#### Unnumbered Environments ####

如果想要非编号环境，使用：

```cpp
\spnewtheorem*{<env_nam>}{<caption>}{<cap_font>}{<body_font>}
```

### 程序代码 ###

可以使用 verbatim 环境或者 LATEX 的 verbatim package。

文章示例：

```cpp
\title{Hamiltonian Mechanics}
\author{Ivar Ekeland\inst{1} \and Roger Temam\inst{2}}
\institute{Princeton University, Princeton NJ 08544, USA
\and 
Universit\’{e} de Paris-Sud, 
Laboratoire d’Analyse Num\’{e}rique, B\^{a}timent 425,\\
F-91405 Orsay Cedex, France}

\maketitle 
% 
\begin{abstract}
This paragraph shall summarize the contents of the paper in short terms. 
\end{abstract} 
%
\section{Fixed-Period Problems: The Sublinear Case} 
% 
With this chapter, the preliminaries are over, and we begin the search for periodic solutions \dots 
% 
\subsection{Autonomous Systems} 
% 
In this section we will consider the case when the Hamiltonian 
$H(x)$ \dots 
% 
\subsubsection*{The General Case: Nontriviality.} 
% 
We assume that $H$ is 
$\left(A_{\infty}, B_{\infty}\right)$-subqua\-dra\-tic 
at infinity, for some constant \dots 
% 
\paragraph{Notes and Comments.} 
The first results on subharmonics were \dots 
% 
\begin{proposition}
Assume $H’(0)=0$ and $ H(0)=0$. Set \dots 
\end{proposition} 
\begin{proof}[of proposition] 
Condition (8) means that, for every $\delta’>\delta$, there is 
some $\varepsilon>0$ such that \dots \qed 
\end{proof} 
% 
\begin{example}[\rmfamily (External forcing)] 
Consider the system \dots 
\end{example} 
\begin{corollary} 
Assume $H$ is $C^{2}$ and 
$\left(a_{\infty}, b_{\infty}\right)$-subquadratic 
at infinity. Let \dots 
\end{corollary} 
\begin{lemma} 
Assume that $H$ is $C^{2}$ on $\bbbr^{2n}\backslash \{0\}$ 
and that $H’’(x)$ is \dots 
\end{lemma} 
\begin{theorem}[(Ghoussoub-Preiss)] 
Let $X$ be a Banach Space and $\Phi:X\to\bbbr$ \dots
\end{theorem} 
\begin{definition} 
We shall say that a $C^{1}$ function $\Phi:X\to\bbbr$ 
satisfies \dots 
\end{definition}
```

输出示例如下图，或[官网](http://www.springer.com/computer/lncs/lncs+authors)下载查看

![](/images/paper_sample.png)

### 文本优化 ###

|文本优化|意义|
|--|--|
|\\,|产生一个小型空格。例如在数字之间|
|---|产生一个横杠。前后无空格|
|&nbsp;---&nbsp;|产生一个横杠。前后各一空格|
|-|连字符。前后无空格|
|$-$|负号。只在文本中使用|

例如

```cpp
21\,$^{\circ}$C etc., 
Dr h.\,c.\,Rockefellar-Smith \dots 
20,000\,km and Prof.\,Dr Mallory \dots 
1950--1985 \dots 
this -- written on a computer -- is now printed 
$-30$\,K \dots 
```

输出

```cpp
21◦C etc., Dr h.c.Rockefellar-Smith ... 
20,000km and Prof.Dr Mallory ... 
1950–1985 ... 
this – written on a computer – is now printed 
−30K ...
```

### 特殊字体 ###

普通的字体类型（Roman）不需要代码。斜体 (`{\em <text>}` 或 `\emph{<text>}`)，如果需要，黑体用于强调：

|特殊字体|意义|
|--|--|
|`{\itshape Text}`|斜体文本|
|`{\em <text>}`|强调的文本|
|`{\bfseries Text}`|重要文本|
|`\vec{Symbol}`|向量只能出现在 math mode。如 `$\vec{A \times B\cdot C}` 得到 `A×B ·C`|

### Footnotes ###

注脚应该被包含在下面代码中：

```cpp
\footnote{Text}
```
例如

```cpp
Text with a footnote\footnote{The footnote is automatically numbered.} and text continues ... 
```

输出

```cpp
Text with a footnote^4 and text continues ...
```

### Lists ###

例如

```cpp
\begin{enumerate} 
  \item First item 
  \item Second item 
  \begin{enumerate} 
    \item First nested item 
    \item Second nested item 
  \end{enumerate} \item 
  Third item 
\end{enumerate} 
```

输出

```cpp
1. First item 
2. 2. Second item 
   (a) First nested item
   (b) Second nested item 
3. Third item
```

### 插图 ###

图片应该插入到第一次提到该图片的段落后（不是段落中），它会被自动编号。图片应该是 PostScript 文件——最好是 EPS 数据，通过 epsfig package 生成。

格式：

```cpp
\begin{figure} 
\vspace{x cm} 
\caption[ ]{...text of caption...} (Do type [ ]) 
\end{figure}
```
`x`表示图片的高度。 

例如：

```cpp
\begin{figure} 
\vspace{2.5cm} 
\caption{This is the caption of the figure displaying a white eagle and a white horse on a snow field}
\end{figure}
```

> 更多请参见 LATEX 文档 p. 26 ff. 和 p. 204

### 表格 ###

#### 使用 LATEX 编写表格 ####

例如

```cpp
\begin{table} 
\caption{Critical $N$ values} 
\begin{tabular}{llllll} 
\hline\noalign{\smallskip}
${\mathrm M}_\odot$ & $\beta_{0}$ & $T_{\mathrm c6}$ & $\gamma$ 
  & $N_{\mathrm{crit}}^{\mathrm L}$ 
  & $N_{\mathrm{crit}}^{\mathrm{Te}}$\\ 
\noalign{\smallskip} 
\hline 
\noalign{\smallskip} 
  30 & 0.82 & 38.4 & 35.7 & 154 & 320 \\ 
  60 & 0.67 & 42.1 & 34.7 & 138 & 340 \\ 
  120 & 0.52 & 45.1 & 34.0 & 124 & 370 \\ 
\hline 
\end{tabular} 
\end{table}
```

输出

![](/images/table_sample.png)

#### 不使用 LATEX ####

```cpp
\begin{table}
\caption{text of your caption} 
\vspace{x cm} % the actual height needed for your table 
\end{table}
```

#### Signs and Characters ####

更多请参见原文档和 LATEX 官方文档 pp.41 ff.

#### 参考文献 ####

有三种参考文献模式：number only，letter-number， 或 author-year。更多请参见 LATEX 官方文档 p. 71.
LLNCS 有一种特殊的 BIBTEX 格式，使用class： splncs.bst。调用代码 `\bibliographystyle{splncs}`。
如果打算使用 author BIBTEX style，请指定 `[oribibl]` 参数：

```cpp
\documentclass[oribibl]{llncs}
```

#### Letter-Number 或 Number Only ####

在文章中使用 `\cite` 命令来引用文章，会得到形如：[1]，[E1, S2], [P1] 中之一的格式，这取决于  thebibliography 环境中 `\bibitem` 的使用。

thebibliography 环境:

```cpp
\begin{thebibliography}{[MT1]} 
. 
. 
\bibitem[CE1]{clar:eke} 
Clarke, F., Ekeland, I.: 
Nonlinear oscillations and boundary-value problems for 
Hamiltonian systems. 
Arch. Rat. Mech. Anal. 78, 315--333 (1982) 
.
. 
\end{thebibliography}
```

会产生类似的效果：

```cpp
[CE1] Clarke, F., Ekeland, I.: Nonlinear oscillations and boundary-value problems for Hamiltonian systems. Arch. Rat. Mech. Anal. 78, 315–333 (1982) 
[CE2] Clarke, F., Ekeland, I.: Solutions p´eriodiques, du p´eriode donn´ee, des ´equations hamiltoniennes. Note CRAS Paris 287, 1013–1015 (1978) 
```

在文章中引用时：

```cpp
The results in this section are a refined version of \cite{clar:eke};
```

会得到

```cpp
The results in this section are a refined version of [CE1];
```

**Number-Only System**

thebibliography 环境:

```cpp
\begin{thebibliography}{1} 
\bibitem {clar:eke} 
Clarke, F., Ekeland, I.: 
Nonlinear oscillations and boundary-value problems for 
Hamiltonian systems. 
Arch. Rat. Mech. Anal. 78, 315--333 (1982) 
\end{thebibliography}
```

在文章中引用时：

```cpp
\cite{n1,n3,n2,n3,n4,n5,foo,n1,n2,n3,?,n4,n5}
```

能够得到：

```cpp
[1,3,2-5,foo,1-3,?,4,5]
```

#### Author-Year System ####

效果就像这样：`(Smith 1970,1980),(Ekelandetal.1985,Theorem2),(JonesandJffe 1986; Farrow 1988, Chap.2)`。如果名字作为句子的一部分，那么括号内就可能只出现年份，如，`Ekeland et al. (1985, Sect.2.1)`。

如果有几个文章属于同一（多）个作者，引用时应列在适当的顺序，表示如下：

1. 一个作者：按文章时间排序；
2. 相同的合作作者：按文章时间排序；
3. 和不同的合作作者：按合作作者名字进行字母排序；

如果，有多个同样的作者同样的时间的文章，用 "a", "b", "c", etc 区分。

**How to Code Author-Year System**

要使用这个系统，则需指定 `[citeauthoryear]` 参数，如：

```cpp
\documentclass[citeauthoryear]{llncs}
```

thebibliography 环境:

```cpp
\begin{thebibliography}{} % (do not forget {})
. 
. 
\bibitem[1982]{clar:eke} 
Clarke, F., Ekeland, I.: 
Nonlinear oscillations and boundary-value problems for 
Hamiltonian systems. 
Arch. Rat. Mech. Anal. 78, 315--333 (1982) 
.
. 
\end{thebibliography}
```

产生样例：
cpp
```
Clarke, F., Ekeland, I.: Nonlinear oscillations and boundary-value problems for Hamiltonian systems. Arch. Rat. Mech. Anal. 78, 315–333 (1982)
```

在文章中引用时：

```cpp
The results in this section are a refined version of Clarke and Ekeland (\cite{clar:eke}); 
```

产生

```cpp
The results in this section are a refined version of Clarke and Ekeland (1982);
```

END. 