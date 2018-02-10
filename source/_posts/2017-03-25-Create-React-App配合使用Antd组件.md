---
title: Create-React-App配合使用Antd组件
date: 2017-03-25 22:22:09
categories: 前端
tags: 
  - jsvascript
  - WebAPP
  - React
  - JS
---

## 简介

[Create-React-APP](https://github.com/facebookincubator/create-react-app) 是 Facebook 官方的 `react` 页面生成工具，可以实现零配置就能使用 `react`来开发页面，使用起来非常方便。而 [Antd](http://ant.design/) 是阿里巴巴的一个 UI 设计语言，设计非常全面的大师级页面组件，当然比 `Bootstrap` 牛逼多了啊。

> 注：已过期，具体使用请看`antd`官网使用方法 [在 create-react-app 中使用](https://ant.design/docs/react/use-with-create-react-app-cn#安装和初始化)

<!--more-->

## 使用

下面就来利用 `creact-react-app` 快速生成 `react` 页面， 并配合使用 `antd` 作为 页面的组件来开发。

### 安装

首先安装 create-react-app
打开命令行输入
```bash
npm install create-react-app -g
```
`create-react-app` 是属于全局的命令脚手架工具，需要 `-g` 来安装
然后初始化 `react` 页面
```bash
create-react-app react-app
cd react-app
npm start
```
这样就可以运行 `react-app` 页面 了

在 `react-app` 项目目录，安装 `antd`
```bash
npm install antd --save
```
这时我们试着在 `src` 目录下打开编辑 `App.js` , 比如添加
```javascript
import { Row, Col, Button, Icon } from 'antd';
// ...
<div className="antd">
    <Row>
        <Col span={12}>
            <Button>默认按钮<Button>
        </Col>
        <Col span={8}>
            <Icon type="check-circle" />
        </Col>
    </Row>
</div>
```
然后运行 `npm start` ，我们会发现，页面结构已经用 `antd` 来展示了，但没有样式。

### 配置 create-react-app

在 `antd` 的使用介绍中，我们发现配合 `webpack` 与 `babel` 时需要利用插件`babel-plugin-antd` ,而在 `react-app` 项目中并没有发现 配置文件。

在 `create-react-app` 官方教程中，我们看到有个命令 `eject`，意思是弹出完整项目实现自主配置。运行
```bash
npm run eject
```
这时我们就可以发现生成一个文件配置的目录，打开 `babel.dev.js`并编辑将 `plugins `后面的代码改成下面

```javascript
plugins: [
    'babel-plugin-syntax-trailing-function-commas',
    'babel-plugin-transform-class-properties',
    'babel-plugin-transform-object-rest-spread'
  ].map(require.resolve).concat([
    [require.resolve('babel-plugin-transform-runtime'), {
      helpers: false,
      polyfill: false,
      regenerator: true
    }]
  ]).concat([
    [require.resolve('babel-plugin-antd'), {
      style: "css",
    }]
  ])

  ```
  再次运行 `npm start` 我们就看到了 `antd` 组件的样式了。好了，之后就是专心制作页面吧。
