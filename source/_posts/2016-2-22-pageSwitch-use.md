title: pageSwitch使用与修改
date: 2016-2-22 18:08:23
categories: 前端
tags:
- H5
- js
---

pageSwitch 简介
--------------

pageSwitch适用场景为全屏切换，即一切一屏，移动与web端单页切换，制作翻页H5等等，并且在此基础上实现了超过一百种切换效果。

GitHub地址：https://github.com/qiqiboy/pageSwitch

pageSwitch修改
---------------------

由于原作者版本没有区别当前页面的标签，
<!--more-->
因此在原基本上修改了firePlay函数，大约在840行左右。原firePlay函数

```javascript
firePlay:function(){
    var self=this;
        if(this.playing){
            this.playTimer=setTimeout(function(){
                self.slide((self.current+1)%(self.loop?Infinity:self.length));
                },this.interval);
            }
        return this;
    }
```
在此基本上，为了让当前显示页面添加标识，为便当前操作，内容动画更改等提供接口，修改如下
```javascript
firePlay:function(){
        var self=this;
        each(self.pages,function(page){
            var pcn=page.className.replace(/\s+current/g,"");
            page.className=pcn;
        });
        self.pages[self.current].className +=' current';
        if(this.playing){
            this.playTimer=setTimeout(function(){
                self.slide((self.current+1)%(self.loop?Infinity:self.length));
            },this.interval);
        }
        return this;
    }
```

也就在给予当前显示页面加上class=current，这样更方便页面内元素与动画的操作与实现。
