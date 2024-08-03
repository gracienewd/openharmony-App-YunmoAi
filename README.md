<a name="readme-top"></a>

<br />
<div align="center">
   <a href="https://github.com/gracienewd/openharmony-App-YunmoAi">
    <img alt="ic_launcher_round" src="https://github.com/gracienewd/openharmony-App-YunmoAi/blob/master/doc/images/ic_launcher_round.png" width="65">
  </a>
  <h1 style="margin: 0;" align="center">🚀 YunMoAi - 鸿蒙 AI 聊天、创作、图像生成</h1>
  <p>
    YunMoApp鸿蒙版本-快来Fork一下~
  </p>
</div>

### 简介
> 一款集成了主流大语言模型以及绘图模型的 APP， 采用 **鸿蒙 ArkTs** 开发，支持以下功能：
- 支持 OpenAI 的 **GPT-3.5**，**GPT-4** 大语言模型
- 支持 Google 的 **Gemini** 大语言模型
- 支持国产模型：**通义千问**，**文心一言**
- 支持**文生图**、**图生图**
- **App聊天**、**TTS语音播放**、**图片文字识别**、**Markdown展示&编辑**、收藏、打卡等
- 后续功能持续更新中

### 鸿蒙App截图
> <img alt="ic_launcher_round" src="https://yunmonitor.oss-cn-hangzhou.aliyuncs.com/github/hongmeng_1.png" width="200">


### 体验
> 🌈 [App下载](http://yunmoapp.yunmonitor.com/) 可以从官网下载App抢先体验部分功能[YunMoAi](http://yunmoapp.yunmonitor.com/)欢迎开发者提问。或扫描二维码下载App：
> <img height="200px" width="200px" style="margin-top:10px;" src="https://yunmonitor.oss-cn-hangzhou.aliyuncs.com/github/httpsm.yunmonitor.comdownload%20%281%29.png" />

<div style="display:flex;flex-direction:row;just-content:center;align-items:center;width:'100%'">

| 目录            | 下载/体验地址                                                                                                                  | 
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| 鸿蒙App         | [点击下载](https://github.com/gracienewd/openharmony-App-YunmoAi/blob/master/doc/app/heelo-default-1.0.0.app)                |
| Android       | [点击下载](https://yunmonitor.oss-cn-hangzhou.aliyuncs.com/app/yunmoai_website.apk) |
| iOS（AppStore） | [点击下载](https://apps.apple.com/cn/app/yunmoai/id6503045016)                                                               |

</div>


### 技术交流

> <img alt="ic_launcher_round" src="https://yunmonitor.oss-cn-hangzhou.aliyuncs.com/github/wechat.jpg" width="300">

>  微信技术交流群，如果无法加入，请添加微信号 `wxid_15u5shphxbc222` 为好友，拉你进群。

## 鸿蒙App技术架构

<div style="position:absolute;">
   <img height="450px" src="https://github.com/gracienewd/openharmony-App-YunmoAi/blob/master/doc/images/architecture.png" align="right" />
</div>

**开发工具**
- DevEco Studio NEXT Developer Beta1
- Build Version: 5.0.3.403

**语言**
- ArkTs [👉前往](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/arkts-get-started-0000001504769321-V2)

**架构**
- Base on [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) + [Repository](https://docs.microsoft.com/ja-jp/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)

<br />
<br />
<br />

<br />
<br />
<br />


## 鸿蒙App代码结构

| 目录         | 说明                                                                                                                                                       |
|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| common     | 通用包                                                                                                                                                      |
| ⌞ net      | 为 YunMoAi 客户端软件提供的的 <a href="https://github.com/gracienewd/openharmony-App-YunmoAi/blob/master/entry/src/main/ets/common/net/RequestUtils.ets">接口请求库</a> |
| ⌞ constant | 常量类                                                                                                                                                      |
| data       | 数据管理                                                                                                                                                     |
| ⌞ bean     | 数据解析类                                                                                                                                                    |
| ⌞ provider | 数据仓库                                                                                                                                                     | |
| manager    | 全局 <a src="https://github.com/gracienewd/openharmony-App-YunmoAi/tree/master/entry/src/main/ets/manager">管理类</a>                                         |
| pages      | UI                                                                                                                                                       |
| store      | ui <a src="https://github.com/gracienewd/openharmony-App-YunmoAi/tree/master/entry/src/main/ets/store">状态管理</a>                                          |

## 🍀 YunMoAPP 预览图

![image](https://github.com/gracienewd/openharmony-App-YunmoAi/blob/master/doc/images/app_images.jpg)


