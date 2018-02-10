title: AngularJS：在Windows上安装Yeoman
tags: 
  - ideas
  - h5
  - WebAPP
permalink: angularjszai-windowsshang-an-zhuang-yeoman
id: 12
updated: '2015-06-10 13:55:11'
date: 2014-04-19 22:04:11
categories: 前端
---

Yeoman 是 Google 官方推荐的一款 AngularJS 开发工具，详细描述参见以下站点：

  http://yeoman.io/index.html

         它 github 上的路径位于：

         https://github.com/yeoman/yeoman
<!--more-->
大家都知道，跟我天朝上国相比，老外们都比较穷，所以他们都很喜欢在 Linux 上折腾，所以 Yeoman 这个东西是针对 Linux 设计的，想要在 Windows 上安装使用有点麻烦。

         网上有很多安装教程，经小僧实测都无法安装成功。

         没办法啦，只能亲自动手了。

         好，看我的。

 

【注意】请严格按照下面的安装步骤进行，否则不保证能安装成功：

1、安装 Ruby

    自己到 Ruby 官方下载最新安装包： http://rubyinstaller.org/downloads/

注意看好自己的操作系统版本，比如我的是 Win7 64 位，选的就是 Ruby 2.0.0-p195 (x64) 。

 
 

注意把上面三个框都勾起。

安装完成之后，打开命令行，输入以下命令：

ruby –v

如果成功打出了版本号，说明 Ruby 安装成功，如下图：

 
 

  2、 安装 Compass

Compass 是一个用来开发 CSS 的工具，官方站点： http://compass-style.org/ 。后面 Yeoman 启动的时候需要依赖这个工具，所以是必须安装的。

官方介绍了使用 gem 自动安装的方式，可惜，这种方法不成功，因为自动获取的那个 URL 被墙掉了！！！（跟我一起高呼：方校长威武荡漾！方校长永垂不朽！）

再看我口型儿： WQNMLGB ！

次奥！既然没法自动安装，那咱就手动吧。

进入以下站点： http://rubygems.org/gems/compass ，向下拉，找到“ Runtime Dependencies ”，先把那 3 个需要依赖的东西装上（分别点击那 3 个链接，找到安装命令）。

然后下载【最新的】 compass 的 gem 包，下载完成之后，从本地来安装它，命令如下：

   gem install --local G:\compass***.gem

   （注意你自己的存放路径！）

 
 

3、安装 NodeJS

      http://nodejs.org/download/

   选好版本自己装。

4、 安装 python 环境

http://www.python.org/download/

      选好版本自己装，装完自己确认 python 的环境变量有没有配好。

5、开始安装 Yeoman

    从命令行进入 nodejs 的安装目录，例如我的目录是：

       E:\Program Files\nodejs\node_modules

   【注意】如果你把 Yeoman 安装到了其它目录，请记好安装路径（等会儿要配环境变量）。

输入以下命令开始安装 Yeoman ：

       npm install yeoman

 
 

如果你网速比较慢可能会下载很久，等吧！

看到下面这张图说明 Yeoman 安装成功：

 
 

6、开始测试 Yeoman

      首先把 Yeoman 的环境变量加上，例如我的位于：

           E:\Program Files\nodejs\node_modules\.bin

 
 

         加上之后就可以在任意目录运行 yeoman 了，你懂的。

         好，还是在下面的目录里面： E:\Program Files\nodejs\node_modules

         运行 yeoman init

 
 

         所有问题全部输入 y ，然后回车。 yeoman 会自动创建一些目录和文件。

         完成之后输入： yeoman server 启动服务器。

 
 

         启动成功之后会自动弹出你的默认浏览器，显示如下内容：

 
 

         如果看到以上内容，说明 yeoman 环境已经 OK 了！！！

         如果有报错起不来，使用以下命令尝试强制启动：

         yeoman server –force

         如果强制启动成功，就算 ok ，有一些小错误可以无视，不影响开发的（ Yeoman 官方一直在更新一些鸟东西，版本不是太稳定）。

        

如果有其它开发环境方面的问题或者 AngularJS 相关的问题，可以加入我们进行讨论。