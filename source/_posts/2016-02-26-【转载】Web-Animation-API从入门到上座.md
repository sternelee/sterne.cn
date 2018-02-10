title: 【转载】Web Animation API从入门到上座
tags: 
  - WebAPP
  - jsvascript
  - JS
  - webapi
permalink: zhuan-zai-web-animation-apicong-ru-men-dao-shang-zuo
id: 61
updated: '2016-02-26 11:48:01'
date: 2016-02-26 10:26:21
categories: 前端
---

#### 远观：认识WAAPI
***
当我们谈及网页动画时，自然联想到的是CSS3动画、JS动画、SVG动画、APNG动画等技术以及jQuery.animate()等动画封装库，根据实际动画内容设计去选择不同的实现方式。然而，每个现行的动画技术都存在一定的缺点，如CSS3动画必须通过JS去获取动态改变的值，setInterval的时间往往是不精确的而且还会卡顿，APNG动画会带来文件体积较大的困扰，引入额外的动画封装库也并非对性能敏感的业务适用。目前情形对开发者而言，鱼和熊掌似乎不可兼得，既希望获得更强大便捷的动画控制能力，又希望性能和体验上足够流畅优雅，如果能有一种浏览器原生支持的通用的动画解决方案，那将是极好极好的呢。
<!--more-->
W3C提出Web Animation API（简称WAAPI）正缘于此，它致力于集合CSS3动画的性能、JavaScript的灵活、动画库的丰富等各家所长，将尽可能多的动画控制由原生浏览器实现，并添加许多CSS不具备的变量、控制以及或调的选项。看起来一切都很棒，是不是以后我们在动画技术选型上可以一招鲜吃遍天了呢？接下来请跟我一起敲开Web Animation API的奇妙之门。

#### 入门：从实例开始
***
WAAPI核心在于提供了
```javascrippt
Element.animate()
```
方法，下面看个最简单的例子：
```javascript
document.body.animate(
    [{'background': 'red'}, {'background': 'green'}, {'background': 'blue'}]
    , 3000);
```
使用Chrome 39以上的浏览器运行一下，页面背景色进行了红绿蓝的依次过渡，3s后结束。我们当然是不会满足于这么简单的控制参数，继续看下个例子：
```javascript
var dot = document.querySelector('.dot');
  var frames = [
    {transform: 'rotate(0deg) translate(80px)'},
    {transform: 'rotate(360deg) translate(80px) '},
  ];
  var timing = {
    duration: 2500,         //ms
    delay: 0,               //ms
    iterations: Infinity,   //1, 2, 3 ... Infinity
    direction: 'alternate', //'normal', 'reverse'等
    easing: 'ease-in-out',  //'linear', 'ease-in'等
    fill: 'forwards',       //'backwards', 'both', 'none', 'auto'
  };
  dot.animate(frames, timing);
```
可以看到DOM节点具备全新的**animate**方法，第一个参数是关键帧数组**frames[]**，对应CSS3中的**@keyframes**，每一帧的描述与CSS3极其类似；第二个参数是时间控制**timing**，包括有**duration**持续时间、**iterations**执行次数、**direction**动画方向、**easing**缓动函数等属性。是不是很像CSS3的语法，以上**timing**参数等同于：
```css3
.dot {
  animation: frames 2500ms ease-in-out 0ms infinite alternate forwards;
}
```
效果如下所示：
![效果图1](http://cdn2.w3cplus.com/cdn/farfuture/dsOki-8akuAh6aMvaGGTKYgx4SEwmSgNR4-5UGP1Or0/mtime:1455634587/sites/default/files/blogs/2016/1602/demo1.gif)
#### 进院：细数WAAPI众妙
***
##### 动画回调与动画状态
在最初的例子中，我们可以定义一个对象来接收**Element.animate()**的返回值，如：
```javascript
var player = document.body.animate(/* ... */);
```
**player**即成为该动画返回的一个“动画播放器”对象，同时动画开始播放。我们需要了解动画当前的状态，可以通过该对象的只读属性**playState**来获得：
```javascript
console.log(player.playState); //"running","paused","finished"...
```
播放器共有五种状态，除了代码中注释的三种基本状态，还包括"idle"表示恢复到初始状态，"pending"表示播放或者暂停即将发生时。

播放器可以通过四种方法可以改变动画当前的状态。
```javascript
player.pause(); //"paused"
player.play();  //"running"
player.cancel(); //"idle"
player.finish(); //"finished"
```
与CSS3动画类似，**player**可以为动画自然结束或者手动结束时指定一个**onfinish**函数。
```javascript
player.onfinish = function(e) {
    // ...
}
```
请注意，设置播放次数**Infinity**的动画没有自然结束的时机去调用**onfinish**函数。
##### 时间控制与时间轴
播放器**player**具有一个读写属性**playbackRate**，用于控制动画的播放速度。
```javascript
var player = element.animate(/* ... */);
console.log(player.playbackRate); //1
player.playbackRate = 2; 
```
playbackRate默认值为1，可以通过设置更大的整数使得动画加速，也可以通过设置大于零的小数来使得动画减缓播放速度。

**player**还具有两个与时间相关的读写属性**currentTime**和**startTime**。前者返回动画当前过去的毫秒数，它的最大值是**timing**参数设置的**delay+(duration*iterations)**，而设置**Infinity**的动画没有**currentTime**的最大值。

当设置了**playbackRate**时，动画的**currentTime**并不会发生变化，真正变化的是时间轴，播放速度改变使得时间轴被相应拉伸或者压缩。

播放器可以调用**reverse()**倒叙播放动画，由时间轴的终点走向起点，动画结束时**currentTime**的值回到0。
```javascript
player.onfinish = function() {
    player.reverse();
}
```
###### 多个动画
CSS3动画是可以同时指定多个keyframes动画到一个DOM节点上，WAAPI同样具备应用多个动画的能力。在一个元素上多次调用animate方法，即实现了一个元素多个动画：
```javascript
var animated = document.getElementById('toAnimate');
var pulseKeyframes, activateKeyframes, haveFunKeyframes;
var pulse = animated.animate(pulseKeyframes, 1000); 
var activate = animated.animate(activateKeyframes, 3000);
var haveFunWithIt = animated.animate(haveFunKeyframes, 2500);
```
每个子动画也拥有独立的**timing**参数，以及独立的动画状态（播放、停止、完成、取消）和独立的时间轴（启动时间、播放速度和结束时间），方便动画进行细节控制。
##### 更高级的接口
WAAPI还拥有**timeline**属性，对动画进行分组和排序的能力，以及沿自定义路径移动（再也不是SVG的天下了）的能力，光这一点就足够令人激动不已，然而篇幅有限于是下回再表。
#### 登堂：官方案例
***
[Codelabs](https://github.com/web-animations/web-animations-codelabs) 越来越多基于WAAPI的Codelabs实例涌现，这些实例非常适合初接触WAAPI的同学作为开始的[范例](https://github.com/web-animations/web-animations-codelabs)。
![图例2](http://cdn1.w3cplus.com/cdn/farfuture/fy-SWNAXsFt-byMQkld5kIXhNn7GEeJHw7K8gfgx4OA/mtime:1455634593/sites/default/files/blogs/2016/1602/preview.gif)
![图例3](http://cdn.w3cplus.com/cdn/farfuture/10FuXl47mkYFhds2Ht4LSJLeFAC-zIm4heeNHngcYqA/mtime:1455634589/sites/default/files/blogs/2016/1602/demo22.gif)
[Google’s demos](http://web-animations.github.io/web-animations-demos) 如果你希望用WAAPI挑战更炫酷的动画，特别是遵循Material Design风格的动画效果，这将是不错的灵感来源。
![图例4](http://cdn.w3cplus.com/cdn/farfuture/D6WJQ6cOuVFukfWGwdeSsao4-3Onuer65CHDkS7a3pA/mtime:1455634589/sites/default/files/blogs/2016/1602/demo2.gif)
#### 上座：移动端运行
***
看到这里，相信你已经不只一次体验到WAAPI带来的惊喜。作为一名彻头彻尾的移动端H5开发，我当然也想把WAAPI应用到移动业务上去服务用户…什么？手机上怎么没效果！
![图例5](http://sterne.qiniudn.com/image/b/e9/51b3ea5c99dfb7df407bec295ec6c.png)
为了在现代浏览器厂商还没完全跟进到位的时候抢先用上WAAPI，我们可以选择引入针对Web Animation API的[Polyfill](https://github.com/web-animations/web-animations-js)库，从而在IE/Firefox/Safari等浏览器上体验到WAAPI的精彩。
```html5
<script src="https://cdn.jsdelivr.net/web-animations/latest/web-animations.min.js"></script>
<script>
  document.body.animate([
    {'background': 'red'},
    {'background': 'green'}
  ], 1000);
</script>
```
移动端浏览器，Android 5.0以上的Android Browser和Chrome for Android本身就已经支持WAAPI了，加上Polyfill之后，iOS的Safari也支持了。别忘了，还有我大手Q的X5内核浏览器。

至此，小伙伴们终于露出欣慰的笑容。敬请期待下篇《Web Animation API 从上座到书墨》。
#### 品茗：参考文献
***
* [W3C Spec](https://w3c.github.io/web-animations/)
* [《Let’s talk about the Web Animations API》](http://danielcwilson.com/blog/2015/07/animations-intro)
* [Google's Demo](http://web-animations.github.io/web-animations-demos)
* [codelabs](https://github.com/web-animations/web-animations-codelabs)
* [Polyfill](https://github.com/web-animations/web-animations-js)
* [Resources](https://developers.google.com/web/updates/2015/10/web-animations-resources)

> 本文转载自AlloyTeam：[http://www.alloyteam.com/2015/12/web-animation-api-from-entry-to-the-top。](http://www.alloyteam.com/2015/12/web-animation-api-from-entry-to-the-top。)