title: "Github: Git的使用 - 安装配置"
tags:
  - github
  - git
categories:
  - Github + Hexo
date: 2015-12-03 09:54:49
---

**Github 是什么？**

> GitHub is the best place to share code with friends, co-workers, classmates, and complete strangers.
> （GitHub是和朋友、同学、同事或完全陌生的人分享代码最好的地方）

本着我一直以来推崇的 **够用就好** 原则，本篇文章不会过多去说专业术语，而是要成为让新手也能直接上手使用的教程。下面开始正文内容：

<!-- more -->

说到 **github**，能看出来这个词是 git+hub 的组合，hub 就不用多说了，就是字面意思 “枢纽、中心”之类的，我们首先主要关注的是 **git** 。

## Git

官网有这么一句话，说明了git到底是何方神圣：

> Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

这句话的意思是：Git是一个免费开源的分布式版本控制系统，用于高效地处理从小型到大型项目的所有东西。
- 它能够保留文件的或项目的更新版本记录，并且能回滚至某一个历史记录的状态。举个栗子，比如今天你把上次能够正确运行的程序修改后down掉了，这时你就可以使用 **回滚**功能。
- 所谓 **分布式版本控制** 就是指每个参与人员都可以拥有一份项目的源代码，每个成员在自己的这份copy上进行修改、增加而不影响其他人，然后在提交至仓库中（个人理解，勿喷 =_=）
- git具有分支（branch）功能。比如你想开发点新奇的功能但又不想影响主项目时，就可以新建一个分支。

### 1、安装git

git支持不同的操作系统，可以通过软件包或源码安装。

**windows系统**

在[git官网下载可安装程序][1]，然后按提示安装即可。安装完后开始菜单应该会出现如下目录

```bash
- Git Bash
- Git GUI
```

**Linux系统**

在 Linux 上用二进制安装程序来安装 Git，可以使用发行版包含的基础软件包管理工具来安装。 如果以 Fedora 上为例，你可以使用 yum：

```bash
$ sudo yum install git
```

如果你在基于 Debian 的发行版上，请尝试用 apt-get：

```bash
$ sudo apt-get install git
```

**Mac系统**

跟windows一样，[官网下载安装][2]即可。

> 下面所有内容仅适用于windows系统

### 2、配置Git

> 我的git版本是1.9.5，不过新的版本也大同小异。

当安装完 Git 应该做的第一件事就是设置你的用户名称与邮件地址。 这样做很重要，因为每一个 Git 的提交都会使用这些信息，并且它会写入到你的每一次提交中，不可更改，打开 `Git Bash` 输入下面命令：

```bash
$ git config --global user.name "your-name"
$ git config --global user.email your-name@example.com
```

`--global` 命令只需要运行一次，因为之后无论你在该系统上做任何事情， Git 都会使用那些信息。 当你想针对特定项目使用不同的用户名称与邮件地址时，可以在那个项目目录下运行没有 `--global` 选项的命令来配置，即

```bash
$ git config user.name "your-name"
$ git config user.email your-name@example.com
```

**检查配置信息**

如果想要检查你的配置，可以使用 `git config --list` 命令来列出所有 Git 当时能找到的配置。

```bash
$ git config --list
user.name=your-name
user.email=your-name@example.com
color.status=auto
color.branch=auto
color.interactive=auto
color.diff=auto
...
```

**获取帮助**

若你使用 Git 时需要获取帮助，有三种方法可以找到 Git 命令的使用手册：

```bash
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```

例如，要想获得 config 命令的手册，执行

```bash
$ git help config
```

### 3、使用Git

### 3.1、生成仓库

**在现有目录中初始化仓库**

如果你打算使用 Git 来对现有的项目进行管理，你只需要进入该项目目录并输入：

```bash
$ git init
```

该命令将创建一个名为 `.git` 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。 但是，在这个时候，仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪。

如果你是在一个已经存在文件的文件夹（而不是空文件夹）中初始化 Git 仓库来进行版本控制的话，你应该开始跟踪这些文件并提交。 你可通过 `git add` 命令来实现对指定文件的跟踪，然后执行 `git commit` 提交到仓库：

```bash
$ git add *.c
$ git add LICENSE
$ git commit -m 'initial project version'
```
**克隆现有的仓库**

如果你想获得一份已经存在了的 Git 仓库的拷贝，比如说，你想为某个开源项目贡献自己的一份力，这时就要用到 `git clone` 命令。 如果你对其它的 VCS 系统（比如说Subversion）很熟悉，请留心一下你所使用的命令是"clone"而不是"checkout"。 这是 Git 区别于其它版本控制系统的一个重要特性，Git 克隆的是该 Git 仓库服务器上的几乎所有数据，而不是仅仅复制完成你的工作所需要文件。 当你执行 git clone 命令的时候，默认配置下远程 Git 仓库中的每一个文件的每一个版本都将被拉取下来。

克隆仓库的命令格式是 `git clone [url]` 。 比如，要克隆 Git 的可链接库 hexo-theme-allgreen，可以用下面的命令：

```bash
$ git clone https://github.com/bluestein/hexo-theme-allgreen.git
```

这会 **在当前目录下** 创建一个名为 “hexo-theme-allgreen” 的目录，并在这个目录下初始化一个 .git 文件夹，从远程仓库拉取下所有数据放入 .git 文件夹，然后从中读取最新版本的文件的拷贝。 如果你进入到这个新建的 hexo-theme-allgreen 文件夹，你会发现所有的项目文件已经在里面了，准备就绪等待后续的开发和使用。 如果你想在克隆远程仓库的时候，自定义本地仓库的名字，你可以使用如下命令：

```bash
$ git clone https://github.com/bluestein/hexo-theme-allgreen.git myallgreen
```

这将执行与上一个命令相同的操作，不过在本地创建的仓库名字变为 myallgreen。

### 3.2、更新到仓库

现在我们手上有了一个真实项目的 Git 仓库，并从这个仓库中取出了所有文件的工作拷贝。 接下来，对这些文件做些修改，在完成了一个阶段的目标之后，提交本次更新到仓库。

**检查当前文件状态**

要查看哪些文件处于什么状态，可以用 `git status` 命令。 如果在克隆仓库后立即使用此命令，会看到类似这样的输出：

```bash
$ git status
On branch master

Initial commit

nothing to commit, working directory clean
```

这说明你现在的工作目录相当干净。换句话说，所有已跟踪文件在上次提交后都未被更改过。

现在，让我们在项目下创建一个新的 README 文件。 如果之前并不存在这个文件，使用 `git status` 命令，你将看到一个新的未跟踪文件：

```bash
$ echo 'My Project' > README
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

    README

nothing added to commit but untracked files present (use "git add" to track)
```

在状态报告中可以看到新建的 README 文件出现在 `Untracked files` 下面。 未跟踪的文件意味着 Git 在之前的快照（提交）中没有这些文件；Git 不会自动将之纳入跟踪范围，除非你明明白白地告诉它“我需要跟踪该文件”， 这样的处理让你不必担心将生成的二进制文件或其它不想被跟踪的文件包含进来。 不过现在的例子中，我们确实想要跟踪管理 README 这个文件。

**跟踪新文件**

使用命令 `git add` 开始跟踪一个文件。 所以，要跟踪 README 文件，运行：

```bash
$ git add README
```
此时再运行 git status 命令，会看到 README 文件已被跟踪，并处于暂存状态：

```bash
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   README
```

只要在 `Changes to be committed` 这行下面的，就说明是已暂存状态。 如果此时提交，那么该文件此时此刻的版本将被留存在历史记录中。 你可能会想起之前我们使用 `git init` 后就运行了 `git add (files)` 命令，开始跟踪当前目录下的文件。 `git add` 命令使用文件或目录的路径作为参数；如果参数是目录的路径，该命令将递归地跟踪该目录下的所有文件。

**暂存已修改文件**

现在我们来修改一个已被跟踪的文件。 如果你修改了一个名为 CONTRIBUTING.md 的已被跟踪的文件，然后运行 `git status` 命令，会看到下面内容：

```bash
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   README

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

文件 CONTRIBUTING.md 出现在 `Changes not staged for commit` 这行下面，说明已跟踪文件的内容发生了变化，但还没有放到暂存区。 要暂存这次更新，需要运行 `git add` 命令。 这是个多功能命令：可以用它开始跟踪新文件，或者把已跟踪的文件放到暂存区，还能用于合并时把有冲突的文件标记为已解决状态等。 将这个命令理解为“添加内容到下一次提交中”而不是“将一个文件添加到项目中”要更加合适。 现在让我们运行 `git add` 将"CONTRIBUTING.md"放到暂存区，然后再看看 `git status` 的输出：

```bash
$ git add CONTRIBUTING.md
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README
    modified:   CONTRIBUTING.md
```

现在两个文件都已暂存，下次提交时就会一并记录到仓库。

**状态简览**

`git status` 命令的输出十分详细，但其用语有些繁琐。 如果你使用 `git status -s` 命令或 `git status --short` 命令，你将得到一种更为紧凑的格式输出。 运行 `git status -s` ，状态报告输出如下：

```bash
$ git status -s
 M README
MM Rakefile
A  lib/git.rb
M  lib/simplegit.rb
?? LICENSE.txt
```

新添加的未跟踪文件前面有 `??` 标记，新添加到暂存区中的文件前面有 `A` 标记，修改过的文件前面有 `M` 标记。 你可能注意到了 `M` 有两个可以出现的位置，出现在右边的 M 表示该文件被修改了但是还没放入暂存区，出现在靠左边的 M 表示该文件被修改了并放入了暂存区。 例如，上面的状态报告显示： `README` 文件在工作区被修改了但是还没有将修改后的文件放入暂存区,`lib/simplegit.rb` 文件被修改了并将修改后的文件放入了暂存区。 而 `Rakefile` 在工作区被修改并提交到暂存区后又在工作区中被修改了，所以在暂存区和工作区都有该文件被修改了的记录。

**忽略文件**

一般我们总会有些文件无需纳入 Git 的管理，也不希望它们总出现在未跟踪文件列表。 通常都是些自动生成的文件，比如日志文件，或者编译过程中创建的临时文件等。 在这种情况下，我们可以创建一个名为 `.gitignore` 的文件，列出要忽略的文件模式。 来看一个实际的例子：

```bash
$ touch .gitignore
```

然后再在`.gitignore` 文件添加以下内容

```bash
*.[oa]
*~
```

第一行告诉 Git 忽略所有以 `.o` 或 `.a` 结尾的文件。一般这类对象文件和存档文件都是编译过程中出现的。 第二行告诉 Git 忽略所有以波浪符（~）结尾的文件，许多文本编辑软件（比如 Emacs）都用这样的文件名保存副本。 此外，你可能还需要忽略 log，tmp 或者 pid 目录，以及自动生成的文档等等。 要养成一开始就设置好 .gitignore 文件的习惯，以免将来误提交这类无用的文件。

文件 `.gitignore` 的格式规范如下：

- 所有空行或者以 ＃ 开头的行都会被 Git 忽略（可以理解为注释）。
- 可以使用标准的 glob 模式匹配。
- 匹配模式可以以（/）开头防止递归。
- 匹配模式可以以（/）结尾指定目录。
- 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。

我们再看一个 `.gitignore` 文件的例子：

```bash
# 忽略 .a 文件
*.a

# 即使上面已经忽略 .a 文件, 还是不跟踪 lib.a，任性！ 
!lib.a

# 只忽略当前文件夹下的TODO文件，不是子文件夹/TODO
/TODO

# 忽略 build/ 文件夹中的所有文件
build/

# 忽略 doc/notes.txt, 但不会忽略 doc/server/arch.txt
doc/*.txt

# 忽略 doc/ 文件夹下所有 .pdf 文件
doc/**/*.pdf
```

**查看已暂存和未暂存的修改**

如果 `git status` 命令的输出对于你来说过于模糊，你想知道具体修改了什么地方，可以用 `git diff` 命令。 稍后会详细介绍 `git diff`，你可能通常会用它来回答这两个问题：当前做的哪些更新还没有暂存？ 有哪些更新已经暂存起来准备好了下次提交？ 尽管 `git status` 已经通过在相应栏下列出文件名的方式回答了这个问题，`git diff` 将通过文件补丁的格式显示具体哪些行发生了改变。

假如再次修改 README 文件后暂存，然后编辑 CONTRIBUTING.md 文件后先不暂存， 运行 status 命令将会看到：

```bash
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    modified:   README

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

要查看尚未暂存的文件更新了哪些部分，不加参数直接输入 `git diff`。此命令比较的是工作目录中当前文件和暂存区域快照之间的差异， 也就是修改之后还没有暂存起来的变化内容。若要查看已暂存的将要添加到下次提交里的内容，可以用 `git diff --staged` 命令。

**提交更新**

现在的暂存区域已经准备妥当可以提交了。 在此之前，请一定要确认还有什么修改过的或新建的文件还没有 `git add` 过，否则提交的时候不会记录这些还没暂存起来的变化。 这些修改过的文件只保留在本地磁盘。 所以，每次准备提交前，先用 `git status` 看下，是不是都已暂存起来了， 然后再运行提交命令 `git commit`：

```bash
$ git commit -m "提交说明"
```

如下所示：

```bash
$ git commit -m "Story 182: Fix benchmarks for speed"
[master <root-commit> 463dc4f] Story 182: Fix benchmarks for speed
 2 files changed, 2 insertions(+)
 create mode 100644 README
```

**跳过使用暂存区域**

尽管使用暂存区域的方式可以精心准备要提交的细节，但有时候这么做略显繁琐。 Git 提供了一个跳过使用暂存区域的方式， 只要在提交的时候，给 `git commit` 加上 `-a` 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 `git add` 步骤：

```bash
$ git commit -a -m 'added new benchmarks'
[master 83e38c7] added new benchmarks
 1 file changed, 5 insertions(+), 0 deletions(-)
```

**移动文件**

不像其它的 VCS 系统，Git 并不显式跟踪文件移动操作。 如果在 Git 中重命名了某个文件，仓库中存储的元数据并不会体现出这是一次改名操作。 不过 Git 非常聪明，它会推断出究竟发生了什么，至于具体是如何做到的，我们稍后再谈。

既然如此，当你看到 Git 的 `mv` 命令时一定会困惑不已。 要在 Git 中对文件改名，可以这么做：

```bash
$ git mv file_from file_to
```

它会恰如预期般正常工作。 实际上，即便此时查看状态信息，也会明白无误地看到关于重命名操作的说明：

```bash
$ git mv README.md README
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    README.md -> README
```

其实，运行 git mv 就相当于运行了下面三条命令：

```bash
$ mv README.md README
$ git rm README.md
$ git add README
```

END.


[1]: http://www.git-scm.com/download/win "git for windows"
[2]: http://www.git-scm.com/download/mac "git for mac"