title: 搭建Hexo博客并部署到Github
date: 2015-12-16 16:16:56
categories: 笔记
tags: 
- hexo 
- github 
- git
---
搭建Hexo博客并部署到Github的小细节

## git SSH-key

### 在本地添加ssh-key的过程中，最好是直接回车使用默认的配置

比如在passphrase时应直接回车，不然会生成SHA:256的key而还需要相关的转化

然后添加到github的ssh-key表单进行登记

<!--more-->

## hexo 配置

### 在_config.yml文件里面的repo里，在windows下最好用https而不要用ssh链接

## hexo命令

### 更新博客时要求按照下列步骤进行

```bash
hexo clean
hexo generate
hexo deploy
```


[详细操作可参考博客园文章](http://www.cnblogs.com/zhcncn/p/4097881.html)





