---
title: WebAssembly动态内存分配
date: 2021-01-12 13:33:04
tags:
  - javascript
  - webassembly
---


### [WebAssembly动态内存分配](https://www.xspdf.com/resolution/56019003.html)

**WebAssembly中的内存管理：C和Rust指南**，动态内存分配是指通过一组C语言以C编程语言对动态内存分配执行手动内存管理。对于WebAssembly中动态内存分配的简单示例，让我们考虑一下记录数据类型，该数据类型具有与之关联的任意字段。例如，说一个ID，一个X和一个Y值。为了动态创建这些记录之一，我们将使用createRecord函数，该函数将其字段作为其参数。

**WebAssembly和动态内存**，我们演示了如何构建依赖于malloc的WebAssembly模块，在运行时链接到预构建的malloc实现中，使用JS绑定技巧来使WebAssembly模块不了解有关对象大小的任何线索在内存中创建。WebAssembly需要分配内存。我们必须手动编写内存的分配和释放。在此步骤中，我们发送数组的长度并分配该内存。这将为我们提供一个指向内存位置的指针。

**使用中的Malloc在WebAssembly中分配动态内存**，了解WebAssembly的内存模型在反向功能中将很重要，最初，此堆已用输入数组填充。WebAssembly线性内存对象的大小以页为单位。每页为65536（2 ^ 16）字节。在WebAssembly版本1中，线性内存最多可以有65536页，总共2 ^ 32字节（4吉字节）。除了该页数限制，当前所有内存指令都将i32类型用作内存索引。

<!--more-->

### Web装配体内存

**`WebAssembly.Memory`**， WebAssembly.Memory对象是可调整大小的ArrayBuffer或SharedArrayBuffer，用于保存由A访问的内存的原始字节。JavaScript或WebAssembly代码创建的内存将可以从JavaScript和WebAssembly访问并可变。语法new WebAssembly.Memory（memoryDe​​scriptor）; 参数memoryDe​​scriptor一个对象，可以包含以下成员：initial WebAssembly内存的初始大小，以WebAssembly页面为单位。maximum可选允许WebAssembly内存增加到的最大大小，以WebAssembly页面为单位。如果存在，则最大值参数用作提示

**WebAssembly.Memory（）构造函数**， WebAssembly.Memory（）构造函数创建一个新的Memory对象，其缓冲区属性是可调整大小的ArrayBuffer或SharedArrayBuffer。WebAssembly模块的memory部分是线性内存的向量。

**WebAssembly中的内存（以及为什么它比您想象的更安全）**，什么是内存对象？实例化WebAssembly模块时，它需要一个内存对象。您可以创建一个新的WebAssembly。WebAssembly线性内存对象的大小以页为单位。每页为65536（2 ^ 16）字节。在WebAssembly版本1中，线性内存最多可以有65536页，总共2 ^ 32字节（4吉字节）。除了该页数限制，当前所有内存指令都将i32类型用作内存索引。

### WebAssembly内存缓冲区W

**`WebAssembly.Memory.prototype.buffer`**， WebAssembly.Memory对象的缓冲区原型属性返回内存中包含的缓冲区。WebAssembly.Memory对象的buffer prototype属性返回包含在内存中的缓冲区。示例使用缓冲区。下面的示例（请参阅GitHub上的memory.html，并实时查看它）使用WebAssembly.instantiateStreaming（）方法获取并实例化已加载的memory.wasm字节代码，同时导入在上一行中创建的内存。然后它将一些值存储在该内存中，然后导出一个函数并使用它求和一些值。

`WebAssembly.Memory`，其buffer属性将返回ArrayBuffer。var memory = new WebAssembly.Memory（{initial：WebAssembly.Memory（）构造函数创建一个新的Memory对象，其缓冲区属性是可调整大小的ArrayBuffer或SharedArrayBuffer，用于保存WebAssembly实例访问的内存的原始字节。语法new WebAssembly.Memory（memoryDe​​scriptor）;参数memoryDe​​scriptor可以包含以下成员的对象：初始值的初始大小，可以从JavaScript和WebAssembly访问和更改。

**`WebAssembly.memory.buffer-JavaScript`**，然后将一些值存储在该内存中，然后导出一个函数并将其用于求和一些值。WebAssembly.instantiateStreaming（fetch（'memory.wasm'），概述。WebAssembly的另一个功能是它的线性内存。线性内存是无符号字节的连续缓冲区，可以由Wasm和Javascript读取和存储。换句话说，Wasm内存是可扩展的字节数组，Javascript和Wasm可以同步读取和修改这些字节；线性内存可以用于很多事情，其中​​之一是在Wasm和Javascript之间来回传递值。

### Web汇编线性存储器

**WebAssembly线性内存**，概述。WebAssembly的另一个功能是它的线性内存。线性内存是无符号字节的连续缓冲区，可以从WebAssembly线性内存概述中读取并存储到其中。WebAssembly的另一个功能是它的线性内存。线性内存是无符号字节的连续缓冲区，Wasm和Javascript均可读取和存储它们。换句话说，Wasm内存是可扩展的字节数组，Javascript和Wasm可以同步读取和修改这些字节。

**使用WebAssembly JavaScript API，线性内存**。线性存储器是连续的，可字节寻址的存储器范围，范围从偏移量0扩展到可变的存储器大小。var wasmModule = new WebAssembly.Module（wasmCode）; var wasmInstance = new WebAssembly.Instance（wasmModule，wasmImports）; //获取数组的偏移量var offset = wasmInstance.exports.getData（）; //在指向该数组的内存上创建一个视图var linearMemory = new Uint32Array（wasmInstance.exports.memory.buffer，offset，10）; //用一些数据填充（var i = 0; i <linearMemory.length; i ++）{linearMemory [i] = i; } //更改WebAssembly模块中的数组

`design/Semantics.md at master · WebAssembly/design · GitHub`，线性内存模型。线性内存模型是一种内存寻址技术，其中通过提供线性内存将内存组织在一个具有传染性的单一传染性中，我听说WebAssembly的安全性。我想知道线性存储器包含什么？wasm堆栈和堆位于此内存空间中吗？如果是，我认为wasm堆栈和胶水代码堆栈（例如js python等）是分开的，对吗？我可以通过使用导入表来了解wasm的内存安全性。

### Wasm内存管理

WebAssembly中的内存管理：C和Rust指南， Webassembly怎么样？在WebAssembly中，功能从不由其地址表示，而由功能表中的索引表示。这并没有结合磁盘和内存的优势。SQL，HA，群集，事务记录。灵活，具有独特的功能组合。经过验证的最快和最先进的内存DBMS。

WebAssembly中的内存（以及为什么它比您想象的更安全）有助于使内存管理安全。在JS和WebAssembly之间传递值。因为这只是一个JavaScript对象，所以这意味着有多个优化选项，并且这是保留用于内存管理的实用程序的最有效方法。-s WASM = 1-通知编译器输出WebAssembly。请改用0发出asm.js。-s EXPORTED_FUNCTIONS-将函数从C代码公开到所生成的JavaScript模块。

`WebAssembly.Memory`， WebAssembly.Memory对象是可调整大小的ArrayBuffer或SharedArrayBuffer，用于保存WASM访问的内存的原始字节：内存管理＃cpp＃webassembly＃javascript。shaafiee 7月2日・读了1分钟

#### Emscripten malloc脚本分配

与代码交互，在这里，如果callSomething调用malloc并返回分配的指针，并且该malloc增加了内存，则您将无法读取返回的数据，除非您使用Emscripten Malloc Emscripten项目从llvmR生成WebAssembly代码。目前，只有一个线性内存段需要手动。对于编译器编写者，在WebAssembly中具有Malloc / Freeimplementation很有用。

`Sable/emscripten_malloc: Contains an extracted Malloc`。Emscripten项目从llvmR生成WebAssembly代码。由于WebAssembly目前只有一个线性内存段。在Emscripten中，malloc的C ++版本在JavaScript中转换为Module._malloc（）; 同样，Module._free（）与C ++的free（）相同。

`Module._malloc is not a function · Issue #6882 · emscripten-core `，因此无需使用malloc，只需将数组直接复制到HEAPU8中即可，因为已经为其创建了空间。Emscripten似乎是使用LLVM到WebAssembly的完整编译器工具链，特别关注速度，大小和Web平台。移植将用C或C ++或使用LLVM的任何语言编写的现有项目编译到浏览器，Node.js或wasm运行时。

#### Function import requires a callable 函数导入需要可调用

`WebAssembly LinkError: function import requires a callable`，您没有在imports.env中提供log（）的实现。Object.assign（imports.env，{memoryBase：0，tableBase：0，memory：new WebAssembly LinkError：函数导入需要可调用。询问3年5个月前。活动3年5个月前。已查看5k乘6。2。

`function import requires a callable · Issue #10074`， LinkError：WebAssembly实例化：导入＃0 module =“ env” function =“ sbrk”错误：函数导入需要可调用＃10074。关闭。wasm错误：函数导入要求在1.12 beta2＃30052中可调用。advanderveer关闭了本期杂志，2019年2月1日·3条评论

`function import requires a callable · Issue #6024`， LinkError：WebAssembly实例化：导入＃1 module =“ env” function =“ setTempRet0”错误：函数导入需要可调用＃6024。关闭。setTempRet0是该模块中的导入，您必须提供该导入。从JS跨到wasm并返回时，这是为某些64位操作设置的临时值。例如，当wasm向JS返回64位值时，它将返回低32位，并使用高32位调用setTempRet0。

### Web组装自由内存

WebAssembly·V8中最多有4GB的内存， WebAssembly.Memory对象是可调整大小的ArrayBuffer或SharedArrayBuffer，用于保存由WebAssembly模块访问的内存的原始字节，不会对在内存中创建的对象的大小有任何了解。WebAssembly需要分配内存。我们必须手动编写内存的分配和释放。在此步骤中，我们发送数组的长度并分配该内存。这将为我们提供一个指向内存位置的指针。

WebAssembly.Memory， WebAssembly不提供任何释放内存的指令，只有增加分配大小的能力。实际上，当我使用Webassembly进行编译时，我使用以下命令：emcc llab / *。c client_side / *。c -s WASM = 1 -s ASSERTIONS = 1 -s ALLOW_MEMORY_GROWTH = 1 -s USE_PTHREADS = 1 -s WASM_MEM_MAX = 4GB -s PTHREAD_POOL_SIZE = 4-预加载文件数据--no-heap-copy -O3 -lm -lpthread -o index.js在执行此功能期间，客户端应创建一些线程并执行一些操作。

如何释放由WebAssembly中的内存管理中公开的Rust代码分配的内存：来宾可以使用标准的free（）函数来释放C和Rust程序员指南。或者，即使保留了指针后面的内存，也可能需要进行新的分配来增加WebAssembly内存。当通过JavaScript API或相应的memory.grow指令扩展WebAssembly.Memory时，它将使现有ArrayBuffer以及从其支持的所有视图无效。让我使用DevTools（或Node.js）控制台来演示此行为：> memory = new WebAssembly。内存（{initial：1}）内存{}>视图=新的Uint8Array（内存缓冲区，42，10）

### Rust wasm线性内存

WebAssembly线性内存，线性内存可用于许多事情，其中​​之一是在Wasm和Javascript之间来回传递值。在锈蚀中，诸如wasm-bindgen之类的工具，线性内存可用于许多事情，其中​​之一是在Wasm和Javascript之间来回传递值。在rust中，像wasm-bindgen这样的工具是wasm-pack工作流程的一部分，它抽象了线性内存，并允许在rust和Javascript之间使用本机数据结构。但是在此示例中，我们将使用简单的字节（无符号8位整数）缓冲区和指针（Wasm内存阵列索引）作为来回传递内存并展示概念的简单方法。

如何从编译为的rust代码访问线性内存，但是，我试图在rust-native / rust-wasm边界上传递一些复杂的结构：在'序列化为线性内存从wasm模块中访问线性内存，您只需要从内存中进行定期加载即可。例如，假设在rust-native中，您将数据复制到某个地址data_ptr，该地址在线性内存中具有计数字节，并在rust-wasm端调用函数process_data。

WebAssembly中的内存模型-DEV，标有rust，javascript，webdev，初学者。WebAssembly模块的内存部分是线性内存的向量。在Rust中生成（和分配）字符串，然后将wasm-bindgen将其转换为有效的JavaScript字符串将导致不必要的Universe单元副本。由于JavaScript代码已经知道Universe的宽度和高度，并且可以读取直接构成单元格的WebAssembly的线性内存，因此，我们将修改render方法以将指针返回到cells数组的开头。

#### 处理SSI文件时出错

Wasm导入内存
WebAssembly.Memory，使用WebAssembly.instantiateStreaming（）方法输入字节字节代码，同时导入上一行中创建的内存。然后，它存储window.Module = {} //用20页初始化内存（20 * 64KiB = 1.25 MiB）const memory = new WebAssembly.Memory（{initial：20}）; const import = {env：{memory：memory}}; //在实例化时，我们传递导入对象fetchAndInstantiate（“ ./ string-passing.wasm”，imports）.then（mod => {Module.memory = memory; Module.alloc = mod.exports.alloc; Module.dealloc = mod.exports.dealloc; Module.dealloc_str = mod.exports.dealloc_str; Module.roundtrip = function（str）{let buf = newString

导入WASM内存，（键入$ FUNCSIG $ vi（func（参数i32）。））（导入“ env”“内存”（内存。$ mem 1））。（导入“ env”“免费”（func $ free。（参数i32）））。（import“ env”“ malloc”（func。看来，奇怪的是，wasm模块导入其内存似乎使这成为一种利基功能，但是随着WebAssembly线程提案的到来，我认为这是更常见的事情之一要做的是导入内存，以确保可以在所有线程上的所有wasm实例之间共享完全相同的SharedArrayBuffer。

演示：导入内存，具有此属性的WebAssembly模块将不会导出自己的内存缓冲区，而是从环境中导入内存，让调用者对其进行设置。
```javascript
var wasmModule = new WebAssembly.Module(wasmCode);
var wasmInstance = new WebAssembly.Instance(wasmModule, wasmImports);
//获取数组的偏移量
var offset = wasmInstance.exports.getData();
//在指向该数组的内存上创建一个视图
var linearMemory = new Uint32Array(wasmInstance.exports.memory.buffer, offset, 10);
//用一些数据填充
for (var i = 0; i < linearMemory.length; i++) { linearMemory[i] = i; }
//更改WebAssembly模块中的数组
```

##### 处理SSI文件时出错

Wasm C malloc
如何在Wasm中实现“ malloc”， Emscripten不仅是从C / C ++到Wasm的编译器，而且包括Web运行时和专门为Emscripten libc设计的自己的libc的完整工具链是对musl的重大修改。它实现/模拟了多种标准C库（包括malloc，sbrk）和POSIX API（如pthread和BSD套接字），除了某些在Wasm环境中没有用的exec和fork这样的API。通过使用emcc命令，您可以直接将这些libc端口链接起来。

maxkl / wasm-malloc：WebAssembly的malloc / free，编译build / main.wasm src / malloc.c src / test.c。可以使用预处理器宏MALLOC_DEBUG启用调试日志记录。这还添加了功能，我们演示了如何构建依赖于malloc的WebAssembly模块，并在运行时使用JS绑定技巧处理两个WebAssembly模块之间的循环引用，从而链接到预构建的malloc实现。然后，我们优化加载过程，以确保并行获取这些模块。

Sable / emscripten_malloc：包含一个提取的Malloc， entry.c包含用于用Emscripten编译并提取该代码的C代码。用于编译的命令：emcc entry.c -s WASM = 1 -o entry.js -s您可以将walloc.c链接到程序中，只需将其添加到链接行中即可，如上所述。尺寸。生成的wasm文件约为2 kB（未压缩）。Walloc不是那里最小的分配器。一个永不释放的简单碰撞指针分配器是您可以拥有的最快的东西。

##### 处理SSI文件时出错
### _Emscripten_resize_heap

如何监控wasm内存？（中止无法扩大内存， abortOnCannotGrowMemory @ render.js：6965 _emscripten_resize_heap @ render.js：6967 _sbrk _malloc。Module._malloc @ render.js：8726您好，我使用的是pthreads +固定内存，该内存在JS胶水代码中自动初始化我的代码重复处理并显示图像，并且当图像数量达到

`abortOnCannotGrowMemory`具有错误的类型签名`_，也似乎缺少_emscripten_get_heap_size和_emscripten_resize_heap。这些甚至不在原始wasm中导入。使用Emscripten v 1.38.43，我正在编译C代码。出于优化原因，我精简了生成的JS粘合代码，并最小化了代码大小。这样做时，我发现JS调用

WebAssembly中的内存访问基础·ariya.io，长度；}，_emscripten_resize_heap：function（size）{return false; // //总是失败}，_emscripten_memcpy_big：function（dest，src，count）{ + JS + Wasm：emcc main.cpp [库]-