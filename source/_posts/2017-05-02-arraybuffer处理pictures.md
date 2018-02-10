---
title: arraybuffer处理pictures
date: 2017-05-02 19:48:34
tags:
  - jsvascript
  - Node.js
---

利用 `arraybuffer` 来处理图片，包含图片的路径名称与数据，并把多张图片合并一个 `arraybuffer` 并生成单张图片，以及图片的解析。

<!--more-->

### 前提了解

之前看到的一个`H5`叫[四大导师拯救麦渣](http://evt.dianping.com/market/2015073117/index.html) 特别吸引我，使用 `canvas` 配合 `xml` 来构建页面的效果真的非常棒，但代码太多一直都没能提取出来做个`React`框架。

然后我简单的总结下这个`H5`使用 `arraybuffer` 来提取图片信息的方法，做个笔记啦。
具体代码请看 [buffer-images](https://github.com/sternelee/buffer-images/blob/master/README-zh_CN.md)。

ArrayBuffer对象、TypedArray对象、DataView对象是JavaScript操作二进制数据的一个接口，具体了解有[阮一峰大神](http://javascript.ruanyifeng.com/stdlib/arraybuffer.html)很好的教程。

### 合并图片信息

利用 `arraybuffer` 来处理图片，包含图片的路径名称与数据，并把多张图片合并一个 `arraybuffer` 并生成单张图片。

#### 图片路径名称

为兼容中文，使用 4 位字节来存储为`Uint32Array`，而图片信息为`Uint8Array`,其中有 `new ArrayBuffer(l*4+4+4+q)` ，
即 图片路径名称的长度lx4 + 前面数据长度记录为4 + 图片信息数据长度为4 + 图片数据

#### 合并方式

#### 利用`html`服务器

具体可看 [pics2ab.html](https://github.com/sternelee/buffer-images/blob/master/pics2ab.html), 由于是用 `XMLHttpRequest` 来加载图片必须要有服务器环境。

以及页面生成的图片不能直接保存，我的方式是用火狐浏览器打开页面，并查看时可保存，更改文件后缀即可(jpg或png 都行)。

#### 利用`nodejs`

读取你需要的图片来合成

```
node index.js
```

读取目录下的图片来合成

```
node main.js
```


### 解析图片

用上面的方式合成的图片信息，就可以用反向的方式来生成。
请看案例代码 [index.html](https://github.com/sternelee/buffer-images/blob/master/index.html)
