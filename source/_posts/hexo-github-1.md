title: "hexo3.1.1 + github pages教程：添加多说评论系统"
tags:
  - hexo
  - github
  - github pages
categories:
  - Odds&Ends
  - Github + Hexo
date: 2015-11-30 15:54:49
---

### 一、添加多说ID(必须) ###

在根目录的 `_config.yml` 中定义 `duoshuo_shortname: (你的多说ID)` 形如

```json
# Comments
duoshuo_shortname: (你的多说ID)
```

### 二、引入多说JS(必须) ###

<!-- more -->

将 `themes/(你的主题)/layout/_partial/after-footer.ejs` 中的

```javascript
<% if (config.disqus_shortname){ %>
<script>
  var disqus_shortname = '<%= config.disqus_shortname %>';
  <% if (page.permalink){ %>
  var disqus_url = '<%= page.permalink %>';
  <% } %>
  (function(){
    var dsq = document.createElement('script');
    dsq.type = 'text/javascript';
    dsq.async = true;
    dsq.src = '//' + disqus_shortname + '.disqus.com/<% if (page.comments) { %>embed.js<% } else { %>count.js<% } %>';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
  })();
</script>
<% } %>
```

部分修改成

```javascript
<% if (config.duoshuo_shortname){ %>
<script>
  var duoshuoQuery = {short_name:"你的多说ID"};
  (function() {
    var ds = document.createElement('script');
    ds.type = 'text/javascript';ds.async = true;
    ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
    ds.charset = 'UTF-8';
    (document.getElementsByTagName('head')[0] 
     || document.getElementsByTagName('body')[0]).appendChild(ds);
  })();
</script>
<% } %>
```

这个步骤是全局引入多说js，后面就可以直接使用了。

### 三、引入多说评论窗口(必须) ###

**首先，**将 `themes/(你的主题)/layout/_partial/article.ejs` 中的下面部分

```javascript
<footer class="article-footer">
      <a data-url="<%- post.permalink %>" data-id="<%= post._id %>" class="article-share-link">Share</a>
      <% if (post.comments && config.disqus_shortname){ %>
        <a href="<%- post.permalink %>#disqus_thread" class="article-comment-link">Comments</a>
      <% } %>
      <%- partial('post/tag') %>
</footer>
```

修改成

```javascript
<footer class="article-footer">
      <a data-url="<%- post.permalink %>" data-id="<%= post._id %>" class="article-share-link">Share</a>
      <% if (post.comments && config.duoshuo_shortname){ %>
        <a href="<%- post.permalink %>#duoshuo_thread" class="article-comment-link">评论</a>
      <% } %>
      <%- partial('post/tag') %>
</footer>
```

**其次，**将同一文件，即 `article.ejs` 中的

```javascript
<% if (!index && post.comments && config.disqus_shortname){ %>
<section id="comments">
  <div id="disqus_thread">
    <noscript>Please enable JavaScript to view the <a href="//disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
  </div>
</section>
<% } %>
```

修改成

```javascript
<% if (!index && post.comments && config.duoshuo_shortname){ %>
<section id="comments">
  <div id="duoshuo_thread">
    <div class="ds-thread" data-thread-key="<%= post.slug %>" data-title="<%= post.title %>" data-url="<%- post.permalink %>"></div>
  </div>
</section>
<% } %>
```

至此，多说的评论功能基本可以用了。

### 四、引入多说的分享插件(可选) ###

在 `themes/(你的主题)/layout/_partial/article.ejs` 文件的末尾添加下列代码即可

```javascript
<% if (!index && post.comments && config.duoshuo_shortname){ %>

  <div class="ds-share" data-thread-key="<%= post.slug %>" data-title="<%= post.title %>" data-images="" data-content="<%= post.content %>" data-url="<%- post.permalink %>">
    <div class="ds-share-aside-right">
      <div class="ds-share-aside-inner">
      </div>
      <div class="ds-share-aside-toggle">分享</div>
    </div>
  </div>

<% } %>
```

> 注：请注意替换 `你的多说ID` 和 `你的主题`

END.

