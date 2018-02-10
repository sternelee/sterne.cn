---
title: react-native环境开发Ubuntu篇
date: 2017-03-25 22:44:37
categories: 前端
tags: 
  - jsvascript
  - WebAPP
  - ReactNative
---

由于`Facebook`的开发工程师都是用`MacOS`的，所以这`React native`的开发环境还是`MacOS`最好，其次是`Linux`,由于`windows`坑太多，这次的尝试是利用`Ubuntu`开发`React-Native`初实践

<!--more-->

##Ubuntu环境安装

###JDK 环境

`ubuntu`下安装`jdk`可使用默认的`openJDK`，只需要以下两行代码
```bash
sudo apt-get install default-jre
sudo apt-get install default-jdk
```
亲测可以使用，毕竟`Oracle`的`jdk`太麻烦了哈哈

### Android 开发工具环境

利用`Android Studio`来安装使用更有效率，毕竟官方认证的啦。

1. 官方下载`Android Studio`，解压后看安装说明，CD到bin目录，运行 `./studio.sh`
2. 安装时，选择`Custom`, 勾选 `Android Virtual Device`
3. 在启动界面，选择 `Configure`, 下面的 `Create Desktop Entry`, 可以创建快捷启动
4. 相关要下载的sdk可以去 `React Native` 查看详细说明

注意以下两点

> 添加 `ANDROID_HOME` 路径 与 `SDK` 路径到 系统变量中

```bash
vi ~/.bashrc
# 添加到文本中

PATH="~/Android/Sdk/tools:~/Android/Sdk/platform-tools:${PATH}"
export PATH

export ANDROID_HOME=~/Android/Sdk
```

> 必须安装以下依赖, 且必须在安装`Android Studio` 前安装好

```bash
sudo apt-get install lib32stdc++6
sudo apt-get install lib32ncurses5 ia32-libs
```

### Node.js开发环境

众所周知，`React-Native`是利用前端`JavaScript`的技术来开发原生APP应用，而`nodejs`是前端开发的基础环境，是`JavaScript`作为服务器语言的环境基础，当然也是目前最火的技术啦。

推荐安装`git`

```bash
sudo apt-get install git
```

安装`nodejs`与`npm`

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs
```

安装 `react-native-cli`

```bash
sudo npm install -g react-native-cli
# 如果出现权限问题可以加上命令 --unsafe-perm --verbose ，同时适用gulp, bower, webpack等库
sudo npm install -g react-native-cli --unsafe-perm --verbose
```

开发启动`React Native` 项目

1. 启动Android模拟器，推荐Android 5.1以上
2. 初始化目录, react-native init AwesomeProject, cd AwesomeProject, 3. react-native start, react-native run-android
3. 等待下载编译器并开始编译

如看到模拟器打开了一上`React Native`应用，则表示你已经成功完成开发环境了。
更多的开发使用请参考官网[React Native](https://facebook.github.io/react-native/) .