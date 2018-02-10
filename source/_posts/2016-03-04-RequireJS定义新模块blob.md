title: RequireJS定义新模块blob
tags: 
  - jsvascript
  - WebAPP
  - webapi
  - JS
permalink: requirejsding-yi-xin-mo-kuai-define
id: 63
updated: '2016-03-10 13:13:21'
date: 2016-03-04 13:53:51
categories: 前端
---

RequireJS是一个非常小巧的JavaScript模块载入框架，目标为实现浏览器端的模块化开发。
##### Require使用入门
在[RequireJS](http://www.requirejs.cn/)中下载最新版require.js文件，在index.html中加载
<!--more-->
```html5
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Require Blob</title>
	<script src="require.js" data-main="main"></script>
</head>
<body>
<img src="blob.jpg" alt="" >
</body>
</html>
```
其中，data-main所指向的为函数代码入口，即是main.js
```javascript
require.config({
	paths: {
		jquery:'jquery.min'
	}
});
```
详细配置请看官方文档

##### define模块定义
在RequireJS中，require()是用来加载和使用模块，define()是用来定义新模块(注册为requirejs中模块)，define("",[], function(){})中第一个参数是定义模块的名字，第二个参数是依赖的名称数组，第三个参数是函数，在模块的所有依赖加载完毕后，该函数会被调用来定义该模块。依赖关系会以参数的形式注入到该函数上，参数列表与依赖名称列表一一对应。    
一个简单的例子:
```javascript
define('app',['jquery'],function($){
	return {
		log: function(msg){
			if(window.console && console.log){
				console.log(msg);
			}else{
				alert(msg);
			}
		},
		hello: function(){
			this.log("hello, I'm powered by jquery"+$().jquery+"!");
		}
	};
});
```
然后在使用该模块:
```javascript
require(['app'],function(sub){
	sub.hello();
});
```
我们可以看到，新模块以及在定义是依赖了jQuery，在使用中已经实现了jQuery模块的依赖并实现了新模块的操作。
##### 定义blob模块
[详细blob的介绍](http://www.zhangxinxu.com/study/201310/blob-get-image-show.html)在此不再重复，以下直接上代码:
```javascript
define("blob",[],function(){
	var t = function(e){
        var that = e;
        window.URL = window.URL || window.webkitURL;
        if(typeof history.pushState == "function"){
            var xhr = new XMLHttpRequest();
            xhr.open("get",that.src,true);
            xhr.responseType="blob";
            xhr.onload=function(){
                if(this.status == 200){
                    var blob = this.response;
                    that.src = window.URL.createObjectURL(blob);
                }
            }
            xhr.send();
        }else{
            console.log("不支持blob,请更新浏览器哈");
        }
    };
	return t
});
require(["jquery","blob"],function($,blob){
	$(document).ready(function(){
		blob($("img")[0]);
	});
});
```
此模块的功能是将页面图片的src链接转化成blob对象链接，define用返回一个函数对象来实现require中依赖的实例化。    

注意：blob是属于XMLHttpRequest()返回的对象，因此需要在服务器中运行才能获取得对象链接。

