# Flutter Start Up

Flutter 初学者一键运行的简单 NoteApp

[Watch the video](https://github.com/gerry-momo/flutter_startup/blob/master/demo.mp4)

适合初学者或者set up一个新项目
使用Flutter 3.19

可以直接拉取该项目直接进行快速开发，如果你数量的话，可能1~2天就能产出一个MVP
或者自己新建项目，然后把lib目录替换过去，再把必要的依赖复制过去

对于纯新手来说可以用第一个方案，拉取项目后直接pub get然后运行项目到模拟器即可

项目已包含功能：

- Dio网络适配，开箱即用
- GetX路由导航、状态管理
- Hive数据库，包含一个简易TODO增删改查示例
- 简单的首次启动隐私条款页面

注：这个窝是本人创建新项目时的个人偏好，希望没有Flutter经验的小伙伴又想独立开发的话可以快速入手，对于犹豫不决不知道该不该选flutter的小伙伴，不妨先用这个项目试试，开发体验是否很愉快。后面可以逐渐有自己舒适的窝。
小愿望是希望更多人体验flutter开发的快乐。这是一个个人的打窝分享，暂不支持Flutter经验较丰富的人（毕竟都有自己的窝）使用。


##Android 跑不起来FAQ
我的版本：
~~~
flutter --version
Flutter 3.32.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision fcf2c11572 (10 days ago) • 2025-06-24 11:44:07 -0700
Engine • revision dd93de6fb1 (10 days ago) • 2025-06-24 07:39:37 -0700
Tools • Dart 3.8.1 • DevTools 2.45.1

dart --version
Dart SDK version: 3.8.1 (stable) (Wed May 28 00:47:25 2025 -0700) on "windows_x64"
~~~

### 1、flutter doctor -v 看下android的jdk版本，如果是比较新的Android studio, jdk是21是没法用的改为17
- 修改jdk版本， deepseek里教的不对。 要用下面这种修改后，查看
~~~
flutter config --jdk-dir "C:\Program Files\Java\jdk-17"
flutter doctor -v
~~~
### 2、升级所有插件
flutter pub upgrade --major-versions
### 3、flutter sdk更新
~~~
flutter upgrade
~~~
settings -> flutter -> Flutter SDK path 填入目标sdk
### 4、清理一下缓存
~~~
flutter clean
flutter pub cache repair
del pubspec.lock  //这句是为了避免配置被锁住删除下
flutter pub get
~~~
我的到这里就可以了