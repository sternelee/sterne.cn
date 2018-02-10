title: heX——基于 HTML5 和 Node.JS 开发桌面应用
tags: 
  - Nodejs
  - ideas
  - h5
  - WebAPP
permalink: hex-ji-yu-html5-he-node-js-kai-fa-zhuo-mian-ying-yong
id: 24
updated: '2015-06-10 13:51:22'
date: 2014-04-29 11:58:16
categories: 前端
---

简介

heX 是网易有道团队的一个开源项目，允许你采用前端技术（HTML，CSS，JavaScript）开发桌面应用软件的跨平台解决方案。heX 是你开发桌面应用的一种新的选择，意在解决传统桌面应用开发中繁琐的UI和交互开发工作，使其变的简单而高效，特别适合于开发重UI，重交互的桌面应用软件。

<!--more-->

Homepage: http://hex.youdao.com
Mailing list: https://groups.google.com/group/youdao_hex
Documentation: http://hex.youdao.com/documentation
Wiki: https://github.com/netease-youdao/hex/wiki
Issues: https://github.com/netease-youdao/hex/issues

近几年，移动应用和web2.0大行其道，相比之下，传统桌面应用程序开发显得相对冷清（包括该领域技术人才的后继力量），但在一些场景下，它依然有其不可替代的优势。探索中我们尝试了一种新的办法，并给它取名heX，将HTML5和Node.JS的技术优势，应用于桌面应用程序开发，使得工作变得简单而高效。

2012年前后，一位研发工程师（外号6哥，精通web前端和桌面应用开发），先后参与了两个传统桌面应用程序UI改版工作（有道云笔记和有道词典），任务是把软件界面中部分区域的浏览器渲染引擎，由IE内核替换为webkit，在这个过程中，有一种强烈的欲望：把整个软件界面的渲染都交由浏览器引擎来完成，这样一来，UI和交互部分都可以用前端技术来实现，那么，开发过程将变的简单许多，而客户端开发人员的主要精力也可放在业务逻辑上，何乐而不为！


为此，我们做了大量的调研，经反复尝试，最终确定通过整合Chromium和Node.JS，来解决桌面应用开发中遇到的大量繁琐的UI和交互开发工作。期间，发现一款类似的开源项目node-webkit，调研的结论是它暂时还无法用于正式的项目，所以，于2012年6月，我们正式成立一人开发小组（确实够小），经3个月的努力，终有小成，现已经应用于有道词典最新版。

选择Chromium，是因为它对HTML5的支持非常优秀，其内嵌的V8引擎，更是业内效率最好的JavaScript脚本引擎之一，且其项目开源，又有专门的社区和团队维护，作为UI渲染引擎，它是不二之选，体验上，你可以试用下google chrome浏览器，基本一致。

选择Node.JS，是因为开发桌面应用，本地资源操作是必备的能力，这方面JavaScript无能为力，而Node.JS则很好的解决了这个问题，它使得JavaScript操作本地资源变的毫无障碍。另一方面，Node.JS核心也是采用V8引擎，使得其与Chromium的整合变得更顺理成章。

用heX开发桌面应用的优势

HTML5这几年很火，在成熟产品中的应用却极少，受各浏览器和平台的软/硬件性能问题的限制，整体感觉总是难以舒展（用的不踏实），具体原因网上可以找到一大堆，这里列举一个移动web app相关的，中英对照版，推荐抽空看一看:

英文版：http://sealedabstract.com/rants/why-mobile-web-apps-are-slow/

中文版：http://www.cnblogs.com/codemood/p/3213459.html

尽管如此，HTML5的优势依然很明显，普及程度也正逐年提高，我们对它的未来信心十足。好东西，都值得我们主动去尝试，heX做的一个事情，就是提前把它应用于桌面应用开发，而不用顾忌它的兼容性和平台性能问题（PC性能过剩）。

用HTML5开发桌面应用，到底有什么样的优势呢？这里列举几项：

精准还原UI设计。现在客户端软件UI设计用native方式来实现的成本越来越高，对HTML5来说却很容易，对后续的维护也非常的友好；
用户体验。如果你不清楚HTML5所能做到的体验效果，可以看看Chrome Experiments（http://www.chromeexperiments.com/）；
开发调试便利。heX保留了开发者工具（Chrome Developer Tools），让你在开发调试过程中，就如同web开发一样便利；
学习成本。相比传统桌面应用开发，web技术的入门成本明显偏低，你不用担心团队成员的离开，而苦于寻找后续开发力量。
桌面应用开发，本地资源操作能力必不可少，Node.JS提供了丰富的自带API，让你免于逐个封装C++实现，就能在heX环境下的html页面中直接使用，如：本地文件系统操作，二进制数据处理，方便的创建子进程等等，详见Node.JS API DOCS。

在桌面应用开发中用Node.JS的好处（一部分来自于heX的努力）：

直接用JavaScript对本地资源进行操作，相比C/C++，你无需编译，即写即用；
页面交互逻辑，窗体行为操作，与C++通信，用JavaScript都能搞定，开发一个桌面应用，你无需在语言之间来回切换；
Node.JS丰富的第三扩展，你都可以直接使用，无需从零开始；
继承于Node.JS优秀的扩展能力，以及它所遵循的commonjs规范，代码管理也将变的方便和易于控制。
从技术角度来讲，选择一个新生事物，我们持谨慎态度，需要经过充分的调研，考虑的因素众多，比如：性能，用户体验，开发效率，是否有团队在维护，文档是否完备，是否开源（如果是商业用处，还需考虑它的开源协议）等等。

而heX作为桌面应用开发的一种新的选择，它在这些方面的表现如何呢？前面已经讲到一些，这里再补充几点：

性能和体验，heX的基础由Chromium和Node.JS整合而成，整合后这两者的性能表现不受影响，体验方面，你可以参考google chrome浏览器，基本保持一致；
开发效率，如果你有过web前端开发经历，现在仅要求你支持最新版的chrome浏览器，你觉得如何？睡着了都能笑醒的事，heX做到了；
heX即将开源，请大家关注  http://hex.youdao.com 和 @yoduao_hex
一种东西，只能解决一方面的需求，heX亦非万能，亦有它适合的使用场景，最适合重UI、重交互的桌面应用，比如即将推出的新版有道词典（亿级桌面应用软件）beta版，就是采用heX作为其界面的解决方案。
如何用heX开始一个桌面应用程序

采用heX开发桌面应用程序，有两种方式：

直接基于heX做开发，针对web前端开发者，不要求桌面应用开发经验；
以模块形式引入到现在桌面工程中，针对传统桌面应用开发者，适合有一定历史的项目，或仅在界面中局部区域支持即可的项目。
不管采用哪种方式，开发过程都很简单，这里就第一种方式，从零开始，一起来制作一个 hello word，如下：

1、下载heX二进制包（http://codown.youdao.com/hex/hex_1453_web_develop_windows.zip），解压到本地，打开后目录结构如下图所示，其中“hexclient.exe”是主程序文件，双击即可运行heX，“manifest.json”是heX的配置文件，可配置入口文件，窗口初始大小、位置等信息

2、创建一个用于写hello word程序的测试目录“test”，同时在其中新建html、js文件，如下图所示

3、修改manifest.json文件，入口改为test/index.html，如下图所示

4、双击 hexclient.exe，运行，一秒后界面由“……”变为“Hello Word！”，如下图所示，到此为止，一个简单的桌面应用就搞定了

正式产品案例：目前已经应用于新版有道词典（亿级桌面客户端软件）beta版，下图的整个界面和交互都是基于heX实现，欢迎下载体验：http://download.ydstatic.com/cidian/static/6.0/20130812/YoudaoDict.exe

了解更多heX信息欢迎微博 @youdao_hex 或访问http://hex.youdao.com

原文链接：heX：用 HTML5 和 Node.JS 开发桌面应用