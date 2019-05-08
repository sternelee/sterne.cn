---
title: node-env
date: 2019-05-08 17:12:20
tags:
    - 记录
    - nodejs
---

# 前端`nodejs`开发平台

## 安装`nodejs`开发环境

```bash
// 安装`npm`淘宝源
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

## 安装`git`工具

## 前端模块

- [cnpm](https://npm.taobao.org/)
- [node-tinypng](https://www.npmjs.com/package/node-tinypng)
    + usage: `tinypng *.png(or folder)`
- [json-server](https://www.npmjs.com/package/json-server)
    + usage: 快速构建 `REST API` 本地服务
- bower
- babel-cli
    + usage: `babel example.js -o compiled.js`
- [phantomjs](http://javascript.ruanyifeng.com/tool/phantomjs.html)
- [typescript](https://www.tslang.cn/docs/tutorial.html) , [ts-node](https://github.com/TypeStrong/ts-node) 与 [typings](https://github.com/typings/typings)
    + usage: `tsc file.ts`
- react-native
- [React UI构建工具 react-storybook](https://getstorybook.io/)
    + usage: `npm i -g getstorybook`
- [pm2](https://pm2.io/doc/en/runtime/overview/)  node应用进程管理工具
- [spy-debugger](https://www.npmjs.com/package/spy-debugger)
- [gulp](https://gulpjs.com/)
- [create-react-app](https://github.com/facebookincubator/create-react-app)
- [create-react-native-app](https://github.com/react-community/create-react-native-app)
- [dawn](https://alibaba.github.io/dawn/docs/)
    + 阿里前端构建和工程化工具
- [prepack](https://prepack.io/getting-started.html)
    + usage: `prepack script.js`
- [jsmonkey](https://www.npmjs.com/package/jsmonkey)
- stylus
    + usage: `stylus -w style.styl -o style.css`
- less
    + usage: `lessc styles.less > styles.css`
- [serve](https://www.npmjs.com/package/serve)
    + usage: `Yarn` 推荐本地静态服务
- [serve-here](https://www.npmjs.com/package/serve-here)
    + usage: `here [-p 8888][-S][here -d directory][-w 3]`
- pushstate-server
    + usage: `pushstate-server [directory] [port]`
- yarn
    + usage: 设置国内镜像  `yarn config set registry https://registry.npm.taobao.org`
- pnpm
- [npm-home](https://github.com/sindresorhus/npm-home)
- [apollo-client](https://github.com/apollographql/apollo-client) 面向UI框架的GraphQL客户端
- nodemon
    + usage: `npm install -g nodemon`
- webpack
- [koa-generator](https://github.com/17koa/koa-generator)
    + usage: (koa教程)(http://17koa.com/koa-generator-examples/koa-generator/install.html)
- postcss-cli
- autoprefixer
    + usage: `postcss --use autoprefixer *.css -d build/`
- npm-check
- gatsby
- requirejs (r.js)
- browserify
- express
- [fkill-cli](https://github.com/sindresorhus/fkill-cli)
- [parcel](https://parceljs.org/)
- [n](https://www.npmjs.com/package/n)
- [nrm](https://www.npmjs.com/package/nrm) npm源快速切换

## 常用`JS`框架

<!--more-->

### `DOM`操作工具

- [Jquery](http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js)
- [Zepto](http://apps.bdimg.com/libs/zepto/1.1.4/zepto.min.js)
- [Touchjs手势](https://github.com/Clouda-team/touch.code.baidu.com)
- [Hammer.js手势](http://hammerjs.github.io/)
- [Video.js视频](http://videojs.com/)
- [Howler音频](https://github.com/goldfire/howler.js)

### 页面适配

- [flexible.js](https://github.com/sternelee/lib-flexible)
- [Hotcss](https://github.com/sternelee/hotcss)
- [Modernizr](https://github.com/Modernizr/Modernizr)


### 翻页轮播单页面

- [Swiper](http://www.swiper.com.cn/)
- [pageSwitch 页面切换库](https://github.com/sternelee/pageSwitch)
- [fullPage.js](https://github.com/alvarotrigo/fullPage.js)

### `3D`制作

- [Three.js](http://threejs.org/)
- [css3d-engine](https://github.com/shrekshrek/css3d-engine)


### `js`动画引擎

- [anime-js](http://anime-js.com/)
- [TweenMax](http://greensock.com/tweenmax)

### `Canvas`动画等

- [Layabox](http://www.layabox.com/)
- [白鹭引擎](https://www.egret.com/)
- [createjs](http://www.createjs.cc/)
- [pixi.js](http://www.pixijs.com/)

### `SVG`表格，图示

- [Echarts.js百度](http://echarts.baidu.com/index.html)
- [Chart.js图表绘制](http://www.bootcss.com/p/chart.js/)
- [D3](http://d3js.org/)
- [mojs运动](https://github.com/legomushroom/mojs)
