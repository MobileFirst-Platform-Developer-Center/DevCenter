---
layout: tutorial
title: 将 MobileFirst Foundation SDK 添加到 Android 应用程序
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} SDK 包含通过 [Maven Central](http://search.maven.org/) 可用并且可添加到 Android Studio 项目的依赖关系集合。依赖关系与核心函数和其他函数对应：

* **IBMMobileFirstPlatformFoundation** - 实现客户机到服务器连接，并处理认证和安全方面、资源请求及其他必需的核心函数。
* **IBMMobileFirstPlatformFoundationJSONStore** - 包含 JSONStore 框架。有关更多信息，请查看[针对 Andoid 的 JSONStore 教程](../../jsonstore/android/)。
* **IBMMobileFirstPlatformFoundationPush** - 包含“推送通知”框架。有关更多信息，请查看[通知教程](../../../notifications/)。

在此教程中，了解如何使用 Gradle 将 {{ site.data.keys.product_adj }} 本机 SDK 添加到新的或现有的 Android 应用程序。您还可以了解如何配置 {{ site.data.keys.mf_server }} 以识别应用程序，查找有关添加到项目的 {{ site.data.keys.product_adj }} 配置文件的信息。

**先决条件：**

- Android Studio 和 {{ site.data.keys.mf_cli }} 已安装在开发人员工作站上。  
- {{ site.data.keys.mf_server }} 的本地或远程实例正在运行。
- 阅读[设置您的 {{ site.data.keys.product_adj }} 开发环境](../../../installation-configuration/development/mobilefirst)和[设置您的 Android 开发环境](../../../installation-configuration/development/android)教程。

#### 跳转至：
{: #jump-to }
- [添加 {{ site.data.keys.product_adj }} 本机 SDK](#adding-the-mobilefirst-native-sdk)
- [手动添加 {{ site.data.keys.product_adj }} 本机 SDK](#manually-adding-the-mobilefirst-native-sdk)
- [更新 {{ site.data.keys.product_adj }} 本机 SDK](#updating-the-mobilefirst-native-sdk)
- [已生成 {{ site.data.keys.product_adj }} 本机 SDK 工件](#generated-mobilefirst-native-sdk-artifacts)
- [对 Javadoc 和 Android 服务的支持](#support-for-javadoc-and-android-service)
- [接下来要遵循的教程](#tutorials-to-follow-next)

## 添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #adding-the-mobilefirst-native-sdk }
遵循下面的指示信息将 {{ site.data.keys.product_adj }} 本机 SDK 添加到新的或现有的 Android Studio 项目，以将应用程序注册到 {{ site.data.keys.mf_server }} 实例。

在您开始之前，确保 {{ site.data.keys.mf_server }} 正在运行。  
如果您使用本地安装的服务器：从**命令行**窗口，浏览至服务器的文件夹，并且在 Mac 或 Linux OS 上运行命令 `./run.sh`，或者在 Windows 上运行 `run.cmd`。

### 创建 Android 应用程序
{: #creating-an-android-application }
创建 Android Studio 项目或使用现有项目。  

### 添加 SDK
{: #adding-the-sdk }
1. 在 **Android → Gradle Scripts** 中，选择 **build.gradle (Module: app)** 文件。

2. 在 `apply plugin: 'com.android.application'` 之后添加以下行：

   ```xml
   repositories{
        jcenter()
   }
   ```

3. 在 `android` 节内添加以下行：

   ```xml
   packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
   }
   ```

4. 在 `dependencies` 节内添加以下行：

   ```xml
   compile group: 'com.ibm.mobile.foundation',
   name: 'ibmmobilefirstplatformfoundation',
   version: '8.0.+',
   ext: 'aar',
   transitive: true
   ```

   或者在单行上：

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
   ```

5. 在 **Android → 应用程序 → 清单**中，打开 `AndroidManifest.xml` 文件。在 **application** 元素上方添加以下许可权：

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   ```

6. 将 {{ site.data.keys.product_adj }} UI 活动添加到现有 **activity** 元素旁：

   ```xml
   <activity android:name="com.worklight.wlclient.ui.UIActivity" />
   ```

> 如果显示“Gradle 同步”请求，接受该请求。

### 手动添加 {{ site.data.keys.product_adj }} 本机 SDK
{: #manually-adding-the-mobilefirst-native-sdk }
您还可以手动添加 {{ site.data.keys.product_adj }} SDK：

<div class="panel-group accordion" id="adding-the-sdk" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>单击以获取指示信息</b></a>
            </h4>
        </div>

        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                <p>要手动添加 {{ site.data.keys.product_adj }} SDK，请先通过 <b>{{ site.data.keys.mf_console }} → 下载中心 → SDK</b> 选项卡下载 SDK .zip 文件。在完成上面的步骤之后，也遵循下面的信息。</p>

                <ul>
                    <li>解压缩下载的 .zip 文件并将相关的 aar 文件放置到 <b>app\libs</b> 文件夹中。</li>
                    <li>将以下内容添加到 <b>dependencies</b> 结尾：
{% highlight xml %}
compile(name:'ibmmobilefirstplatformfoundation', ext:'aar')
compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'   
compile 'com.squareup.okhttp3:okhttp:3.4.1'
{% endhighlight %}
                    </li>
                    <li>将以下内容添加到 <b>repositories</b> 结尾：
{% highlight xml %}
repositories {
    flatDir {
        dirs 'libs'
    }
}
{% endhighlight %}
                    </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>结束部分</b></a>
            </div>
        </div>
    </div>
</div>



### 注册应用程序
{: #registering-the-application }
1. 打开**命令行**窗口并浏览至 Android Studio 项目的根目录。  

2. 运行以下命令：

    ```bash
    mfpdev app register
    ```
    - 如果使用的是远程服务器，请[使用 `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) 进行添加。

`mfpdev app register` CLI 命令先连接到 {{ site.data.keys.mf_server }} 以注册应用程序，之后在 Android Studio 项目的 **[project root]/app/src/main/assets/** 文件夹中生成 **mfpclient.properties** 文件，然后向其添加标识 {{ site.data.keys.mf_server }} 的元数据。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您还可以从 {{ site.data.keys.mf_console }} 注册应用程序：    
>
> 1. 装入 {{ site.data.keys.mf_console }}。  
> 2. 单击**应用程序**旁边的**新建**按钮以注册新应用程序，并遵循屏幕上的指示信息。  
> 3. 注册应用程序之后，浏览至应用程序的**配置文件**选项卡，然后复制或下载 **mfpclient.properties** 文件。遵循屏幕上的指示信息将此文件添加到您的项目。

### 创建 WLClient 实例
{: #creating-a-wlclient-instance }
在使用任何 {{ site.data.keys.product_adj }} API 之前，请先创建 `WLClient` 实例：

```java
WLClient.createInstance(this);
```

**注：**在整个应用程序生命周期中只应创建一次 `WLClient` 实例。建议使用 Android 应用程序类来创建。

## 更新 {{ site.data.keys.product_adj }} 本机 SDK
{: #updating-the-mobilefirst-native-sdk }
要使用最新发行版更新 {{ site.data.keys.product_adj }} 本机 SDK，请在 **build.gradle** 文件中找到发行版版本号并相应地更新 `version` 属性。  
请参阅上面的步骤 4。

可以在 SDK 的 [JCenter 存储库](https://bintray.com/bintray/jcenter/com.ibm.mobile.foundation%3Aibmmobilefirstplatformfoundation/view#)中找到 SDK 发行版。

## 已生成 {{ site.data.keys.product_adj }} 本机 SDK 工件
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.properties
{: #mfpclient.properties }
此文件位于 Android Studio 项目的 **./app/src/main/assets/** 文件夹中，可定义用于在 {{ site.data.keys.mf_server }} 上注册 Android 应用程序的客户机端属性。

| 属性            | 描述                                                         | 示例值 |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol    | 与 {{ site.data.keys.mf_server }} 的通信协议。             | http 或 https  |
| wlServerHost        | {{ site.data.keys.mf_server }} 的主机名。                            | 192.168.1.63   |
| wlServerPort        | {{ site.data.keys.mf_server }} 的端口。                    | 9080           |
| wlServerContext     | {{ site.data.keys.mf_server }} 上的应用程序的上下文根路径。 | /mfp/          |
| languagePreferences | 为客户机 sdk 系统消息设置缺省语言。           | zh             |

## 对 Javadoc 和 Android 服务的支持
{: #support-for-javadoc-and-android-service }
有关对 Javadoc 和 Android 服务的支持的信息，请参阅[其他信息](additional-information)页面。

## 接下来要学习的教程
{: #tutorials-to-follow-next }
集成 {{ site.data.keys.product_adj }} 本机 SDK 之后，您现在可以：

- 查看[使用 {{ site.data.keys.product }} SDK 教程](../)
- 查看[适配器开发教程](../../../adapters/)
- 查看[认证和安全教程](../../../authentication-and-security/)
- 查看[通知教程](../../../notifications/)
- 查看[所有教程](../../../all-tutorials)
