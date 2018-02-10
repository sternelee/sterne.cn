title: 用Canvas来实时处理Video
tags: 
  - h5
  - JS
  - javascript
  - WebAPP
permalink: yong-canvaslai-chu-li-h5shi-pin
id: 60
updated: '2016-01-27 14:07:12'
date: 2016-01-27 13:10:17
categories: 前端
---

结合HTML5下的video和canvas的功能，你可以实时处理视频数据，如播放暂停等，解决各平台的H5播放视频的bug，并为正在播放的视频添加各种各样的视觉效果，以使用JavaScript代码实现chroma-keying特效（也被称为“绿色屏幕效应”）。
#### canvas视频播放
<!--more-->
利用sublime text 快速新建html文件，结构代码如下
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <style>
    body{background:black;color:#CCCCCC;}
    div{float:left;border:1px solid #444444;padding:10px;margin:10px;background:#3B3B3B;}
  </style>
</head>
<body onload="processor.doLoad()">
  <div style="display:none;">
    <video id="video" src="video.ogv" controls="true"/>
  </div>
  <div>
    <canvas id="c1" width="160" height="96"/>
  </div>
</body>
</html>
```
由于我们播放视频用canvas来展示，因此大可把video标签隐藏，直接display:none;然后在body的后面添加播放动作：
```javascript
var btn = document.getElementById('c1');
var video = document.getElementById('video');
btn.addEventListener('click',function(){
  if(video.paused){
      video.play();
    }
  else{
      video.pause();
    }
 });
```
canvas中可以用drawImage()来绘制图片，同样我们也可以用来绘制视频画面，监听video的play事件并且用setTimeout()来不断绘制视频画面。
细节代码如下：
```javascript
var processor = {
      timerCallback: function() {
        if (this.video.paused || this.video.ended) {
          return;
        }
        this.computeFrame();
        var self = this;
        setTimeout(function () {
            self.timerCallback();
          }, 0);
      },
      doLoad: function() {
        this.video = document.getElementById("video");
        this.c1 = document.getElementById("c1");
        this.ctx1 = this.c1.getContext("2d");
        var self = this;
        this.video.addEventListener("play", function() {
            self.width = self.video.videoWidth / 2;
            self.height = self.video.videoHeight / 2;
            self.timerCallback();
          }, false);
      },
      computeFrame: function() {
        this.ctx1.drawImage(this.video, 0, 0, this.width, this.height);
        return;
      }
    };
```
初步播放视频的效果如下：
[点击查看效果](http://sterne.cn/examples/canvas-video-1.html)

##### 初始化chroma-key
doLoad()方法在XHTML文档初始加载时调用。这个方法的作用是为chroma-key处理代码准备所需的变量，设置一个事件侦听器，当用户开始播放视频时我们能检测到。
##### 视频监听
addEventListener()监听video元素，当用户按下视频上的播放按钮时被调用。为了应对用户回放，这段代码获取视频的宽度和高度，并且减半（我们将在执行chroma-keying效果时将视频的大小减半），然后调用timerCallback()方法来启动视频捕捉和视觉效果计算。
##### 定时回调
setTimeout()定时器回调函数在视频开始播放时被调用（当“播放”事件发生时），然后负责自身周期调用，为每一帧视频实现keying特效。

##### 处理视频帧数据
在canvas中，有两个图像数据处理函数getImageData()和putImageData()，获取与写入图像数据。因此，我们可以给canvas2添加一个背景，并将canvas1的图像数据处理后放入canvas2中，来实现图像叠加与色彩更换。

注意图像数据的处理：
computeFrame()方法，如下所示，实际上负责抓取每一帧的数据和执行chroma-keying特效。
```javascript
//ctx1 与ctx2分别为两个canvas在context
var frame = this.ctx1.getImageData(0, 0, this.width, this.height);
var l = frame.data.length / 4;

for (var i = 0; i < l; i++) {
      var r = frame.data[i * 4 + 0];
      var g = frame.data[i * 4 + 1];
      var b = frame.data[i * 4 + 2];
      if (g > 100 && r > 100 && b < 43)
           frame.data[i * 4 + 3] = 0;
      }
      this.ctx2.putImageData(frame, 0, 0);
}
```
通过调用第一个canvas上下文的getImageData()方法，来获取原始图像数据当前视频帧的一个副本。它提供了原始的32位像素图像数据，这样我们就能够进行操作。
![原图像](http://7j1z9o.com1.z0.glb.clouddn.com/6941baebgw1evu0hgko9fj204g02oq2t.jpg)
通过将帧图像数据的总长度除以4，来计算图像的总像素数。循环扫描所有像素，获取每个像素的红、绿、蓝值，同时和预定义的背景色进行比较，这些背景色将用foo.png中导入的背景图像替换。

被检测成背景的每一个像素，将它的alpha值替换为零，表明该像素是完全透明的。结果，最终的图像背景部分是100%透明的，这样视频内容就叠加到静态背景上了。
![转换后的图像](http://7j1z9o.com1.z0.glb.clouddn.com/6941baebgw1evu0hg71voj204h02oweg.jpg)

利用这种方法，可以在纯色幕布中制作真人视频，然后更改背景！
注意，要在服务器环境下使用！

最终的效果如下：[点击查看效果](http://sterne.cn/examples/canvas-video-2.html)



