---
title: shadow-dom入门
date: 2019-05-30 14:02:31
tags:
    - JavaScript
    - 前端
---

## 认识 Shadow DOM

### 什么是 Shadow DOM

Shadow DOM 是 Web Components 定义的四大标准之一(Custom elements, Shadow DOM, HTML templates 和 HTML Imports)。

Shadow DOM是一组**JavaScript API**，用于将封装的“影子”DOM树附加到元素（与主文档DOM分开呈现）并控制其关联的功能。通过这种方式，您可以保持元素的功能私有，这样它们就可以被脚本化和样式化，而不用担心与文档的其他部分发生冲突。这直接解决了HTML、CSS 和 JS 的**全局性**污染的问题。
<!--more-->
### Shadow DOM 结构表现

第一步：打开 Chrome 的开发者工具，点击右上角的“Settings”按钮，勾选“Show user agent shadow DOM”。
第二步：创建包含 `video` 元素的页面（`audio`, `select`, `progress`, `input` 等等 都行)

![1.png](https://raw.githubusercontent.com/sternelee/assets/master/imgs1.png)

`#shadow-root`称为影子根，可以看到它在video里面，换句话说，`#shadow-root`寄生在`video`上，所以video此时称为影子宿主。可以看到上图有两个`#shadow-root`，这是因为`#shadow-root`可以嵌套，形成节点树，即称为影子树（shadow trees）。影子树对其中的内容进行了封装，有选择性的进行渲染。这就意味着我们可以插入文本、重新安排内容、添加样式等等。

![3.png](https://raw.githubusercontent.com/sternelee/assets/master/imgs3.png)

### Shadow DOM vs DOM vs Light DOM

> tip: Light DOM 组件用户编写的标记，该 DOM 不在组件 shadow DOM 之内，它是元素实际的子项。
> 如：`<button is="better-button"><img src="gear.svg" slot="icon"><span>Settings</span></button>`

shadow DOM 有以下优点：

1. 隔离 DOM：组件的 DOM 是独立的（例如，`document.querySelector()` 不会返回组件 Shadow DOM 中的节点）。

2. 作用域 CSS：Shadow DOM 内部定义的 CSS 在其作用域内。样式规则不会泄漏，页面样式也不会渗入。

3. 组合：为组件设计一个声明性、基于标记的 API。

4. 简化 CSS： 作用域 DOM 意味着您可以使用简单的 CSS 选择器，更通用的 id/class 名称，而无需担心命名冲突。

5. 效率：将应用看成是多个 DOM 块，而不是一个大的（全局性）页面。

### 使用 Shadow DOM

```html
...
<style type="text/css">
#app {
    --text-color: green;
}
</style>
<div id="app">
    <h1>我是根元素</h1>
</div>
<script>
    const app = document.getElementById('app');
    const shadowRoot = app.attachShadow({mode: 'open'});
    shadowRoot.innerHTML = `
    <style>
        :host {color: blue;}
        h2 {color: var(--text-color, black);background: red;}
    </style>
    <h2>Hello Shadow DOM</h2>
    `;
    const span = document.createElement('span');
    span.textContent = "你好";
    shadowRoot.appendChild(span);

    let css = document.createTextNode("h2{ font-size: 20px}");
    const style = document.createElement('style')
    style.appendChild(css)
    shadowRoot.appendChild(style)

    setTimeout(_ => {
        span.textContent = "两秒后我改变了";
        span.setAttribute('style', 'color: green;');
        css = document.createTextNode("h2{ font-size: 30px}");
        style.appendChild(css)
    }, 2000)
</script>
```

在原生dom节点上创建shadowDOM,添加样式和内容，并进行更新。


注意点：

1. 并不是所有的元素都可以挂载 Shadow DOM，其主要原因是：

   1. 浏览器已为该元素托管其自身的内部 shadow DOM（比如 textarea、input）。
   2. 让元素托管 shadow DOM 毫无意义 (比如 img)。
2. Shadow DOM，一旦创建就无法删除，它只能用新的替换
3. 在调用 attachShadow 创建 ShadowRoot 之后，attachShdow 方法会返回 ShadowRoot 对象实例
4. `mode` 有 `open` 和 `closed` 选项，当为 closed 时无法获取shadowRoot属性
5. 增加 Shadow DOM 后原父级子元素会无效
6. 更新内容和样式都使用原生的JavaScript API

### template 和 slot

前面说了,shadow dom可以实现dom的隔离，比如样式的封装，那么如何实现呢？shadow规定了一种名为`template`的标签，这种标签类似我们经常用的`<script type='tpl'>`，它不会被解析为dom树的一部分，template的内容可以被塞入到shadow dom中并且反复利用，在template中可以设置style，但只对这个template中的元素有效，看下示例：
```html
<style>
span {
  background-color:blue;/*设置页面所有span背景为蓝色，然而对shadow dom没什么卵用*/
}
</style>
<div id="con">
    没什么卵用的文字
  </div>
   <template id="tpl">
     <style>
       span {
         color:red;
       }
     </style>
     <span>hello world</span>
   </template>
```
```javascript
var host = document.querySelector('#con');
var root = host.attachShadow({mode:'open'});

var con = document.getElementById("tpl").content.cloneNode(true);

root.appendChild(con);
```
可以看到，template的内容被塞入到宿主，并且其文案被设置为红色，而body 中对 span 设置为蓝色背景却没有生效；另外这里要注意document.getElementById("tpl").content中的content属性，它是template标签的特有属性，你可以通过嗅探该属性来判断浏览器是否支持shadow dom和template标签。这是shadow dom的组件化复用的基本方式。


由于shadow dom的内容会掩盖宿主的内容，那么现在问题来了，我就是想把宿主的内容显示出来怎么办？

这时就需要`slot`了，slot是一个插槽，一个坑位，可以在template中定义坑位，然后宿主中的内容可以标记属于哪一个坑位，这样一个萝卜一个坑，宿主的内容就会被正确地插入到template所标记的位置去，还是来看一个例子：

```html
<div id="con">
    没什么卵用的文字
    <span slot="main1">
      坑位1
    </span>
    <span slot="main2">
      坑位2
    </span>
    没什么卵用的文字 </div>
  <template id="tpl">tpl begin
    <slot name="main1">
    </slot>
    <slot name="main2">
    </slot>
    tpl end
      </template>
```
```javascript
var host = document.querySelector('#con');
var root = host.attachShadow({mode:'open'});

var con = document.getElementById("tpl").content.cloneNode(true);

root.appendChild(con);
```

看看，这就是Vue的solt插槽的方式。
宿主中的两个span分别插入到了其标记的slot坑位中。在slot出现之前，仍然可以实现类似的功能，只不过标签名叫content。

### 基于 Shadow DOM 的前端框架 [omi](https://github.com/Tencent/omi/blob/master/README.CN.md) ——  腾讯出品

1. 基于 Shadow Dom 设计,Web Components + JSX + HTM 融合为一个框架 Omi
2. Shadow DOM 与 Virtual DOM 融合，Omi 既使用了虚拟 DOM，也是使用真实 Shadow DOM，让视图更新更准确更迅速
3. 局部 CSS 最佳解决方案(Shadow DOM)，社区为局部 CSS 折腾了不少框架和库(使用js或json写样式，如:Radium，jsxstyle，react-style；与webpack绑定使用生成独特的className文件名—类名—hash值，如：CSS Modules，Vue)，还有运行时注入scoped atrr 的方式，都是 hack 技术；Shadow DOM Style 是最完美的方案

...

### 参考

1. [Shadow DOM v1：独立的网络组件](https://developers.google.com/web/fundamentals/web-components/shadowdom?hl=zh-cn)
2. [神奇的Shadow DOM](https://aotu.io/notes/2016/06/24/Shadow-DOM/index.html)