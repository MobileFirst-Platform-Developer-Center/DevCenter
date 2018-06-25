---
layout: tutorial
title: 分析工作流程
breadcrumb_title: Workflows
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

利用
{{ site.data.keys.mf_analytics_full }}
最好地满足您的业务需要。在识别您的目标之后，使用 {{ site.data.keys.mf_analytics_short }} 客户机 SDK 来收集相应的数据，并使用 {{ site.data.keys.mf_analytics_console }} 来构建报告。以下典型场景将演示收集和报告分析数据的方法。

#### 跳转至
{: #jump-to }

* [应用程序使用情况分析](#app-usage-analytics)
* [崩溃捕获](#crash-capture)

## 应用程序使用情况分析
{: #app-usage-analytics }

### 初始化您的客户机应用程序以捕获应用程序使用情况
{: #initializing-your-client-app-to-capture-app-usage }

应用程序使用情况可度量将特定应用程序切换至前台然后发送至后台的次数。要在移动应用程序中捕获应用程序使用情况，{{ site.data.keys.mf_analytics }} 客户机 SDK 必须配置为侦听应用程序生命周期事件。

您可以使用 {{ site.data.keys.mf_analytics }}
API 来捕获应用程序使用情况。确保您已先创建相关的设备侦听器。然后将数据发送到服务器。

#### iOS
{: #ios }

在 **AppDelegate.m/AppDeligate.swift** 文件内的应用程序委托 `application:didFinishLaunchingWithOptions` 方法中添加以下代码。

**Objective-C**

```objc
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
```

 要发送分析数据：

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```Swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

要发送分析数据：

```Swift
WLAnalytics.sharedInstance().send;
```

#### Android
{: #android }

在应用程序子类 `onCreate` 方法中添加以下代码。

```Java
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

要发送分析数据：

```Java
WLAnalytics.send();
```

#### Cordova
{: #cordova }

对于 Cordova 应用程序，必须使用本机平台代码创建侦听器，类似于 iOS 和 Android 应用程序。将数据发送到服务器：

```javascript
WL.Analytics.send();
```

#### Web 应用程序
{: #web-apps }

对于 Web 应用程序，不需要任何侦听器。可以通过 `WLlogger` 类来启用和禁用分析。


```javascript                                    
ibmmfpfanalytics.logger.config({analyticsCapture: true});                
ibmmfpfanalytics.send();
```

### 缺省的“使用情况”和“设备”图表
{: #default-usage-and-devices-charts }

在 {{ site.data.keys.mf_analytics_console }} 的“应用程序”部分的**使用情况和设备**页面中，提供了一些缺省图表以帮助您管理应用程序使用情况。

#### 设备总数
{: #total-devices }

**设备总数**图表显示设备总数。

#### 应用程序会话总数
{: #total-app-sessions }

**应用程序会话总数**图表显示应用程序会话总数。将应用程序切换至设备前台时，将记录一个应用程序会话。

#### 活动用户数
{: #active-users }

**活动用户**图表显示以下数据的交互式多线图。

* 活动用户 - 所显示时间范围的非重复用户。
* 新用户 - 所显示时间范围的新用户。

缺省显示的时间范围为一天，每个小时一个数据点。如果将显示的时间范围更改为大于一天，那么数据点将反映每天。您可以单击图例中对应的键来切换是否显示此线。缺省情况下，将显示所有键，不能切换所有键以不显示所有行。

要在折线图中查看最准确的数据，必须检测您的应用程序代码以通过调用 `setUserContext` API 来提供 `userID`。如果为 `userID` 值提供匿名，那么必须先散列值。如果未提供 `userID`，那么缺省情况下使用设备的标识。如果多个用户使用一个设备并且未提供 `userID`，那么折线图无法反映准确数据，因为会将设备标识视为一个用户。

#### 应用程序会话
{: #app-sessions }
**应用程序会话**图表显示随时间推移应用程序会话的条形图。

#### 应用程序使用情况
{: #app-usage }

**应用程序使用情况**图表显示每个应用程序的应用程序会话百分比的饼图。

#### 新设备
{: #new-devices }

**新设备**图表显示随时间推移新设备的条形图。

#### 型号使用情况
{: #model-usage }

**型号使用情况**图表显示每个设备型号的应用程序会话百分比的饼图。

#### 操作系统使用情况
{: #operating-system-usage }
**操作系统使用情况**图表显示每个设备操作系统的应用程序会话百分比的饼图。

### 为平均会话持续时间创建定制图表
{: #creating-acustom-chart-for-average-session-duration }

应用程序会话的持续时间是可直观显示的有价值的指标。对于任何应用程序，您都想了解用户花费于特定会话的时间量。

1. 在 {{ site.data.keys.mf_analytics_console }} 中，单击“仪表板”部分的**定制图表**页面中的**创建图表**。
2. 为您的图表指定一个标题。
3. 针对**事件类型**选择**应用程序会话**。
4. 针对**图表类型**选择**条形图**。
5. 单击**下一步**。
6. 针对 **X 轴**选择**时间线**。
7. 针对 **Y 轴**选择**平均值**。
8. 针对**属性**选择**持续时间**。
9. 单击**保存**。

## 崩溃捕获
{: #crash-capture }

{{ site.data.keys.mf_analytics }} 包含有关应用程序崩溃的数据和报告。将自动与其他生命周期事件数据一起收集此数据。崩溃数据由客户机收集，并且会在应用程序再次启动和运行后发送至服务器。

发生未捕获异常并导致程序进入不可恢复状态时会记录为应用程序崩溃。在应用程序关闭之前，{{ site.data.keys.mf_analytics }}
SDK 会记录崩溃事件。通过下一个 logger send 调用将此数据发送至服务器。

### 初始化应用程序以捕获崩溃数据
{: #initializing-your-app-to-capture-crash-data }

要确保崩溃数据被收集并包含在 {{ site.data.keys.mf_analytics_console }} 报告中，请确保将崩溃数据发送至服务器。

确保按照[初始化您的客户机应用程序以捕获应用程序使用情况](#initializing-your-client-app-to-capture-app-usage)中所述收集应用程序生命周期事件。

必须在应用程序重新运行后发送客户机日志，以便获取与崩溃关联的堆栈跟踪。使用计时器确保定期发送日志。

#### iOS
{: #ios-crash-data }

**Objective-C**

```objc
- (void)sendMFPAnalyticData {
  [OCLogger send];
  [[WLAnalytics sharedInstance] send];
}

// then elsewhere in the same implementation file:

[NSTimer scheduledTimerWithTimeInterval:60
  target:self
  selector:@selector(sendMFPAnalyticData)
  userInfo:nil
  repeats:YES]
```

**Swift**

```swift
overridefuncviewDidLoad() {
       super.viewDidLoad()
       WLAnalytics.sharedInstance();
       lettimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(sendMFPAnalyticData), userInfo: nil, repeats: true);
       timer.fire();
       // Do any additional setup after loading the view, typically from a nib.
   }

   funcsendMFPAnalyticData() {
       OCLogger.send()
       WLAnalytics.sharedInstance().send()
   }
```

#### Android
{: #android-crash-data }

```Java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
    WLAnalytics.send();
  }
}, 0, 60000);
```

#### Cordova
{: #cordova-crash-data }

```Java
setInterval(function() {
  WL.Logger.send();
  WL.Analytics.send();
}, 60000)
```

#### Web
{: #web-crash-data }

```Java
setInterval(function() {
  ibmmfpfanalytics.logger.send();
}, 60000);
```

### 应用程序崩溃监控
{: #app-crash-monitoring }

在崩溃之后，如果重新启动应用程序，会将崩溃日志发送至 {{ site.data.keys.mf_analytics_server }}。您可以在 {{ site.data.keys.mf_analytics_console }}的**仪表板**部分中快速查看有关应用程序崩溃的信息。  
在**仪表板**部分的**概述**页面中，**崩溃**条形图将显示随时间推移崩溃的直方图。

可以按照以下两种方式显示数据：

* **显示崩溃率**：随时间变化的崩溃率
* **显示总崩溃次数**：随时间变化的总崩溃次数

> **注：**“崩溃”图表将查询 `MfpAppSession` 文档。您必须检测应用程序以收集应用程序使用和崩溃次数，使数据显示在图表中。如果未收集 `MfpAppSession` 数据，那么将查询 `MfpAppLog` 文档。在这种情况下，该图表可以计算崩溃次数，但是无法计算崩溃率，因为应用程序使用次数未知，这将导致以下限制：

>
> * 当选择**显示崩溃率** 时，**崩溃**条形图不显示任何数据。

### 崩溃的缺省图表
{: #default-charts-for-crashes }

在 {{ site.data.keys.mf_analytics_console }}的**应用程序**部分的**崩溃**页面中，提供了一些缺省图表以帮助您管理应用程序崩溃。

**崩溃概述**图表将显示崩溃概述表。  
**崩溃**条形图显示崩溃次数随时间变化的直方图。您可以按崩溃率或总崩溃次数来显示数据。“崩溃”条形图也位于“应用程序”部分的“崩溃”页面中。

**崩溃摘要**图表显示崩溃摘要的可排序表。
您可以通过单击 + 图标来展开个别崩溃，以查看**崩溃详细信息**表，其中包含有关崩溃的更多详细信息。在“崩溃详细信息”表中，可以单击 **>** 图标以查看有关特定崩溃实例的更多详细信息。

### 应用程序崩溃故障诊断
{: #app-crash-troubleshooting }

您可以查看 {{ site.data.keys.mf_analytics_console }}的**应用程序**部分中的**崩溃**页面，以更好地管理您的应用程序。

**崩溃概述**表显示以下数据列：

* **应用程序：**应用程序名称
* **崩溃：**该应用程序的崩溃总数
* **总使用次数：**用户打开并关闭该应用程序的总次数
* **崩溃率：**崩溃次数占使用次数的百分比

**崩溃**条形图是显示在**仪表板**部分的**概述**页面中的相同图表。

> **注：**这两个图表均查询 `MfpAppSession` 文档。您必须检测应用程序以收集应用程序使用和崩溃次数，使数据显示在图表中。如果未收集 `MfpAppSession` 数据，那么将查询 `MfpAppLog` 文档。在这种情况下，这些图表可以计算崩溃次数，但是无法计算崩溃率，因为应用程序使用次数未知，这将导致以下限制：

>
> * “崩溃概述”表的“总使用次数”和“崩溃率”列为空。
> * 当选择“显示崩溃率”时，“崩溃”条形图不显示任何数据。

**崩溃摘要**表可排序，包含以下数据列：

* 崩溃
* 设备
* 上次崩溃
* 应用程序
* 操作系统
* 消息

您可以单击任意条目旁的 **+** 图标，以显示包含以下各列的**崩溃详细信息**表：

* 崩溃时间
* 应用程序版本
* 操作系统版本
* 设备型号
* 设备标识
* 下载：用于下载一直到发生此崩溃时的日志的链接

您可以展开**崩溃详细信息**表中的任何条目，以获取包含堆栈跟踪在内的更多详细信息。


> **注：**通过查询严重级别的客户机日志来填充**崩溃摘要**表的数据。如果您的应用程序未收集严重客户机日志，将没有可用数据。

