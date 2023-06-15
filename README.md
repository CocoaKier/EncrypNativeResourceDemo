# EncrypNativeResourceDemo

有时候我们会把一些配置放到plist文件里，运行时去读取这些配置，但是我们不想让这些配置信息被其它人看到，那么如何加密iOS本地的plist文件呢？

我的提供的方案具有以下优点：

1、一劳永逸。传统的做法是在外部把资源文件加密后在拖入工程内，如果修改了资源文件(比如plist配置文件可能会经常修改)需要重新加密后导入，很麻烦。我的这个方案配置一次后，可以直接在工程中修改资源文件，无需再次加密和导入。

2、静默无感知。加密过程在Xcode编译阶段自动进行，程序员无感知。

3、无侵入。原资源文件在工程中保持不变，可以直接预览和修改。

4、支持多种格式。理论上支持所有的资源文件格式，包括但不限于plist、html、txt、jpg、png等。

5、安全。采用AES加密，相对比较安全。

## v1.1版本 2023.6.15更新（修复了Xcode14解密失败的问题）
1.弃用了RNOpenSSLCryptor库，改为原生的方式实现了一个轻量的CCOpenSSLHelper解密类
2.openssl脚本改为通过key（密钥）和iv（初始向量）方式加密，以前是通过pass密码加密
3.Xcode脚本引擎改为 /bin/bash，以前是 /bin/sh
