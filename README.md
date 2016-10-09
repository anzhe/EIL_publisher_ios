EIL易居互动直播云平台采集推流IOS SDK使用说明
### 一 功能特点
- [x] 视频编码：H.264硬编  
- [x] 音频编码：AAC  
- [x] 推流协议：RTMP  
- [x] 可设置视频参数（分辨率，码率，帧率）  
- [x] 支持横屏／竖屏推流  
- [x] 支持前后摄像头动态切换  

### 二 系统要求
* 最低支持iOS版本：iOS 9.2  
* 最低支持iPhone型号：iPhone 5  
* 支持CPU架构： armv7,arm64  

### 三 快速集成
#### 3.1 下载工程
从github上获取。

####  3.2 工程目录
* demo：一个演示程序  
* prebuilt：预编译的头文件和库文件  
* README.md：SDK说明  
* ReleaseNote.txt：版本日志  

#### 3.3 配置项目
使用SDK可参考以下步骤：
##### 1.将prebuilt/include目录路径加入到工程的“Header Search Paths”中
##### 2.将prebuilt/libeilpublisher.a加入工程
##### 3.将以下系统库加入工程
* libz.tbd  
* libstdc++.tbd  
* CoreMedia.framework  
* AVFoundation.framework  
* VideoToolbox.framework  
* AudioToolbox.framework  
* OpenGLES.framework  
* CoreGraphics.framework  

#### 3.4 demo演示
##### 1.SDk自带一个演示demo，使用者可自行编译安装。
##### 2.该demo使用和演示了SDK的所有接口。

### 四 API使用说明
SDK的推流可分为三个阶段：初始化，推流（动态设置），结束释放。  
相对应的，使用API时应参照下图所示的顺序。  


初始化 EILLiveInit／EILConnect  

推流 EILSetCameraFront／EILSetFilter  

结束释放 EILDisconnect／EILLiveRelease  
