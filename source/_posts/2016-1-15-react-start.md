title: reactjs学习体验
date: 2016-1-15 11:46:56
categories: 前端
tags: 
- react
- js 
- ReactJS
---
reactjs 是什么？
--------------

reactjs是来自facebook公司的用于构建用户界面的JavaScript库。

GitHub地址：https://github.com/facebook/react

reactjs的两个衍生项目也值得注意。
---------------------

* react-native:用reactjs写手机app 

GitHub地址：https://github.com/facebook/react-native

* react-canvas:用canvas代替臃肿缓慢的DOM作为UI，在移动端获得能与原生应用媲美的流畅效果
<!--more-->
GitHub地址：https://github.com/Flipboard/react-canvas 

reactjs 真的将html/xml和js代码混杂在一起吗？
------------------------------------------
reactjs的jsx语法，让许多人感觉仿佛回到了原始社会。这么多年努力地让html\css\javascript三者分离，好不容易走到今天，reactjs却走回老路，让人难以接受。我也几次三番因为jsx而放弃了解reactjs。

目前体验下来，发觉那是误解。

reactjs比其他前端模板引擎更彻底的分离html与javascript。前端模板引擎，绝大多数基于html字符串；而reactjs不是。能接受前端模板引擎的人，也能接受jsx。

jsx的实质是：用xml的语法写函数调用。它没有拼接html字符串，也不要求一定要使用jsx，手写函数调用，也是可以的。

在原生DOM中，用js构造dom的方式是这样的：

```javascript
//要构造的dom：
<a class="link" href="https://github.com/facebook/react">React<a>
var a = document.createElement('a')
a.setAttribute('class', 'link')
a.setAttribute('href', 'https://github.com/facebook/react')
a.appendChild(document.createTextNode('React'))
```
如你所见，它颇为繁琐，我们可以封装一下：
```javascript
//第一个参数为node名
//第二个参数为一个对象，dom属性与事件都以键值对的形式书写
//第三个到第n个为子node，它们将按参数顺序出现，
//在这个例子中只有一个子元素，而且也是文本元素，所以可以直接书写，否则还得React.createElement一下
var a = React.createElement('a', {
    className: 'link',
    href: 'https://github.com/facebook/react'
}, 'React')
```
如上，从html语法到js构造dom，再到React.createElement的封装。

现在有个编译工具，可以让你用html语法来写React.createElement，部署上线前编译回来。你愿意吗？

不管你的答案是什么，但这就是jsx的一半真相。

正是由于jsx不是html字符串，所以有如下特点：
* html的class与for属性在js里是保留字，所以jsx里要用别名className与htmlFor
* 不能像下面那样操作html的checked属性

```javascript
//在其他前端模板引擎中，可以这么做，因为是拼接字符串
var checkbox = <input type="checkbox" {this.props.selected ? 'checked' : ''} />

//但在jsx中，这是错误的，因为无法构成键值对，一定要有个key=value的格式，所以得这样
var checkbox = <input className="class是js的保留字" type="checkbox" checked={this.props.selected} />

//编译后：
var checkbox = React.createElement('input', {
    type: 'checkbox',
    className: 'class是js的保留字',
    checked: this.props.selected
})
```
* 不能直接写并列的元素
```javascript
//这样写是错误的
var MyComponent = React.createClass({
    render: function() {
        return <div>first div</div><div>second div</div>
    }
})
//因为编译后，return 两个函数调用，就算不报错，也只调用第一个函数，不合意图
var MyComponent = React.createClass({
    render: function() {
        return React.createElement('div', null, 'first div') React.createElement('div', null, 'second div')
    }
})

//所以有时难免要增加dom层级
var MyComponent = React.createClass({
    render: function() {
        return (
            <div>
                <div>first div</div>
                <div>second div</div>
            </div>
        )
    }
})

//编译后,合乎语法和编程意图了
var MyComponent = React.createClass({
    render: function() {
        return React.createElement('div', null, 
            React.createElement('div', null, 'first div'),
            React.createElement('div', null, 'second div'))
    }
})
```
* jsx要求标签一定要闭合，html5中不强制要求闭合的，在jsx也都要闭合，以便识别
* 封装的组件要用大写字母开头，以便跟html标签区分。
```javascript
//不合规则
<tap />
//合乎规则
<Tap />
```
reactjs与web component
--------------------
web component是下一代的前端标准，提供了shadow dom、templete元素、Imports与自定义元素的功能。其中自定义元素提供了生命周期回调函数:
* createdCallback: 创建时调用
* attachedCallback: 添加到dom树时调用
* detachedCallback: 从dom树衣橱时调用
* attributeChangedCallback：属性改变时调用

在reactjs中也有相似但更丰富的生命周期方法：
* componentWillMount: 初始化渲染前调用
* componentDidMount: 初始化渲染后调用
* componentWillReceiveProps： 接受新props时调用
* shouldComponentUpdate：接受新props或state时调用，返回值true/false决定是否更新视图
* componentWillUpdate: 在接收到新的 props 或者 state 之前立刻调用。在初始化渲染的时候该方法不会被调用
* componentDidUpdate：在组件的更新已经同步到 DOM 中之后立刻被调用
* componentWillUnmount: 在组件从 DOM 中移除的时候立刻被调用

reactjs与web component的关系，在我个人看来：reactjs是纯js实现的一种component标准，它可以与DOM无关，甚至与Web无关。    

在reactjs中注册组件像这样：
```javascript
//reactjs跟objective-c在方法命名上有些相似，使劲儿用全称，与传统js编程的缩写习惯相悖
var MyComponent = React.createClass({
    //每个组件必须有render方法
    render: function() {
        return <div className={this.props.className}>
            //jsx遇大括号就当作js表达式来看待
            //map返回的数组会自动展开
            {
                this.props.textList.map(function(text) {
                    return <p>text</p>
                })
            }
            </div>
    }
})

//像这样使用
var TestComponent = React.createClass({
    render: function() {
        return (
            <div>
                <MyComponent className="组件内部的this.props.className来自它被调用时传递的参数，就是我啦" textList={['组件的this.props.textList', '就是我啦', '用花括号包裹', '以便让jsx将我作为数组直接量的表达式来看待']} />
            </div>
        )
    }
})

//这里才是插入dom，用React.render方法
//第一个参数为React组件，第二个参数为DOM
React.render(
    <TestComponent />,
    document.body
)
```

总的来说，reactjs允许我们用React.createClass来拓展React.createElement的参数范畴。
- 默认情况下，它接受原生html标签，所以web Component普及后，reactjs也不会被淘汰，无非是多了一些html标签罢了
- React.createClass方法，可以提供新的html标签给React.createElement，创造了封装复杂dom结构、组件化的空间

reactjs 的虚拟dom
----------------
之前说了jsx的一半真相，另一半是，React.createElement并没有直接了当的用js构造dom，它构造了一种数据结构。

使用reactjs时，表面上我们在操作dom，其实是操作数据，reactjs通过自己的dom diff算法，对比前后的数据，找到diff差异点，按最小粒度更新视图。

正因如此，reactjs的UI层才是可替换的，构造另一套从数据到视图的映射逻辑，就能应用在canvas乃至手机原生UI上。

reactjs 的单向数据流
--------------------
reactjs组件内部的this.props对象，是组件实例的父级组件提供的，提供方式就像写html属性一样。

如此，父级复父级，数据可以从最顶层的组件实例，层层传递到最底层的组件中去，然而反过来却不行，这就是单向数据流的意思。
```javascript
//最底层的todo
var Todo = React.createClass({
    render: function() {
        return (
            //只有html属性和data-*以及aria-*才会显示在dom中，其余的key或其他，是扩展性质的，便于向下级组件传递数据
            <li title={this.props.time} key={this.props.id}>
                <input type="checkbox" checked={this.props.completed} />
                <label>{this.props.title}</label>
            </li>
            )
    }
})
//todo的父级组件
var TodoList = React.createClass({
    render: function() {
        return ({
            <ul>{
                this.props.todos.map(function(todo) {
                    //形如ES6的属性展开式语法，等价于用key=value的形式一个个书写
                    return <Todo {...todo} />
                })
            }</ul>
        })
    }
})
//todoList的父级组件
var TodoApp = React.createClass({
    render: function() {
        return (
            <TodoList todos={this.props.todos} />
        )
    }
})

//模拟的todos数据
var data = [{
    id: new Date().getTime(),
    time: new Date().toLocaleString(),
    title: '第一个待办事项',
    completed: false
}, {
    id: new Date().getTime(),
    time: new Date().toLocaleString(),
    title: '第二个待办事项',
    completed: true
}]

//渲染TodoApp组件到#todo-app，数据从TodoApp传递到TodoList,从TodoList传递到Todo,在Todo中展开为一种DOM结构并注入数据，展示在前端页面中
React.render(
    <TodoApp todos={data} />,
    document.getElementById('todo-app')
)
```

结语
----------------
reactjs是有趣且富有生命力与表现力的javascript库，有其适用的场景，也有许多需要注意的事项与容易踩到的坑。

总体而言，学会它不会让人后悔（想想那些学angular1的同学吧）。

在此，可以去[TodoMVC](http://todomvc.com/) 下载react制作的mvc项目来参考学习[React-TodoMVC](http://todomvc.com/)
