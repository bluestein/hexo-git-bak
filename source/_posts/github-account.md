title: "Github: 账户的创建和配置"
tags:
  - github
categories:
  - Odds&Ends
  - Github + Hexo
date: 2015-12-04 12:54:49
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

GitHub 是最大的 Git 版本库托管商，是成千上万的开发者和项目能够合作进行的中心。 大部分 Git 版本库都托管在 GitHub，很多开源项目使用 GitHub 实现 Git 托管、问题追踪、代码审查以及其它事情。 所以，尽管这不是 Git 开源项目的直接部分，但如果想要专业地使用 Git，你将不可避免地与 GitHub 打交道，所以这依然是一个绝好的学习机会。

<!-- more -->

### 账户的创建和配置 ###

你所需要做的第一件事是创建一个免费账户。 直接访问 [Github][1]，选择一个未被占用的用户名，提供一个电子邮件地址和密码，点击写着“Sign up for GitHub”的绿色大按钮即可。

> GitHub 为免费账户提供了完整功能，限制是你的项目都将被完全公开（每个人都具有读权限）。 GitHub 的付费计划可以让你拥有一定数目的私有项目。

### SSH 访问 ###

现在，你完全可以使用 https:// 协议，通过你刚刚创建的用户名和密码访问 Git 版本库。 但是，如果仅仅克隆公有项目，你甚至不需要注册——刚刚我们创建的账户是为了以后 fork 其它项目，以及推送我们自己的修改。

如果你习惯使用 SSH 远程，你需要配置一个公钥 (public key)。

SSH key 的生成过程请查看 [github generating-ssh-keys][2]。

点击头像下得“Settings”，然后在左侧选择“SSH keys”部分。在这个页面点击“Add an SSH key”按钮，给你的公钥起一个名字，将你的 `~/.ssh/id_rsa.pub`（或者自定义的其它名字）公钥文件的内容粘贴到文本区，然后点击“Add key”。

[1]: https://github.com
[2]: https://help.github.com/articles/generating-ssh-keys/