title: 把HTML插入canvas实现网页截图
tags: 
  - javascript
  - h5
permalink: ba-htmlcha-ru-canvasshi-xian-wang-ye-jie-tu
id: 51
updated: '2015-11-23 15:05:24'
date: 2015-09-29 09:43:17
categories: 前端
---

将DOM内容HTML绘制到画布中是有可能的，但如何有把握并且安全地实现它，就应该按照规范行事。你不能把HTML画到canvas上。相反，你需要使用一个SVG图像，其中包含你想要呈现的内容。可以使用＜foreignobject>元素包含HTML内容，之后把这个svg绘制到你的canvas中。  
<!--more-->
唯一真正棘手的事情可能是创建SVG图像，所有你需要做的是创建一个包含XML字符串的SVG，然后按照下面的步骤构造一个Blob：  

`blob对象的媒体类型mime为 “image/svg+xml”<svg> 元素. 
在svg元素中包含 <foreignobject> 元素.
（格式化好的）HTML，被包裹到<foreignobject>中.`  

如上所述通过使用一个object URL，我们可以内联HTML而不是从外部源加载它。当然，如果你喜欢，可以使用外部源，只要域与原始文件相同，比如：  
```html
<!DOCTYPE html>
<html>
<body>
<p><canvas id="canvas" style="border:2px solid black;" width="200" height="200"></canvas>
<script>
var canvas = document.getElementById("canvas");
var ctx = canvas.getContext("2d");
var data = "<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'>" +
             "<foreignObject width='100%' height='100%'>" +
               "<div xmlns='http://www.w3.org/1999/xhtml' style='font-size:40px'>" +
                 "<em>I</em> like <span style='color:white; text-shadow:0 0 2px blue;'>cheese</span>" +
               "</div>" +
             "</foreignObject>" +
           "</svg>";
var DOMURL = self.URL || self.webkitURL || self;
var img = new Image();
var svg = new Blob([data], {type: "image/svg+xml;charset=utf-8"});
var url = DOMURL.createObjectURL(svg);
img.onload = function() {
    ctx.drawImage(img, 0, 0);
    DOMURL.revokeObjectURL(url);
};
img.src = url;
</script>
</body>
</html>
```
data变量设置了SVG图像的内容（这包括HTML），我们希望绘制到我们的canvas中。通过调用 new Image()我们建立一个新的html < img>元素，添加数据进去，指定一个object URL，之后在图片onload的时候调用 drawImage() 来把图片绘制到画布中。

您可能想知道这种方式是否安全，担心canvas会读取敏感数据。答案是这样的：这个解决方案的实现依赖的SVG图像是非常严格的。SVG图像不允许加载任何外部资源，即使似乎来自同一个域。资源如栅格图像（如JPEG图像）或< iframe>s 需要用 data: URIs来内联引入。

此外，你不能在一个SVG图像中引入脚本文件，所以没有从其他脚本访问DOM的风险，而且DOM元素在SVG图像中不能接收事件的输入，所以没有办法通过把隐私信息加载到一个表单控件（如一个文件的完整路径< input> 元素）然后渲染出来，之后通过读取像素把这些信息取出。

访问过的链接风格并不应用于SVG图像中呈现的链接，所以历史信息也不能被检索，本地的主题也不呈现在SVG图像中，这使得它很难确定用户的平台。

生成的canvas元素是纯净的，意味着你可以通过调用 toBlob(function(blob){…})来返回canvas的blob，或者toDataURL()来返回Base64-编码的data: URI。

SVG必须是合法的XML，你需要解析并把HTML转为规范的符合格式的。下面的代码可以很方便地解析HTML：
```javascript
var doc = document.implementation.createHTMLDocument("");
doc.write(html);

// You must manually set the xmlns if you intend to immediately serialize the HTML
// document to a string as opposed to appending it to a <foreignObject> in the DOM
doc.documentElement.setAttribute("xmlns", doc.documentElement.namespaceURI);

// Get well-formed markup
html = (new XMLSerializer).serializeToString(doc);
```
本文为Anyforweb技术分享博客，需要了解网站建设及更多Web应用相关信息，请访问anyforweb.com。
