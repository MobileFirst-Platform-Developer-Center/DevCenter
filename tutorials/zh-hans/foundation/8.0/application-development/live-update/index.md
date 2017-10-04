---
layout: tutorial
title: 实时更新
relevantTo: [ios,android,cordova]
weight: 11
downloads:
  - name: 下载 Xcode 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80
  - name: 下载 Android Studio 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80
  - name: 下载实时更新适配器
    url: https://github.com/mfpdev/resources/blob/master/liveUpdateAdapter.adapter?raw=true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
用户分段是将用户分组的做法，反映每个组的用户之间的相似度。 常见示例是[地理分段](https://en.wikipedia.org/wiki/Market_segmentation#Geographic_segmentation)，也就是按地理划分用户。 分段用户的目标是决定如何关联每个分段中的用户以使价值最大化。

{{ site.data.keys.product }} 中的实时更新功能部件提供一种简单方式以针对应用程序的每个用户分段定义和提供不同的配置。 其包含 {{ site.data.keys.mf_console }} 中的组件以供定义配置结构以及每个分段的配置值。 另外，随附一个客户机 SDK（适用于 Android 和 iOS **本机**应用程序以及 Cordova 应用程序）以供使用配置。

#### 常见用例
{: #common-use-cases }
实时更新支持定义和使用基于分段的配置，从而易于对应用程序进行基于分段的定制。 常见用例可以是：

* 发行培训和功能部件开关
* A/B 测试
* 基于上下文的应用程序定制（例如，地理分段）

#### 演示
{: #demonstration }
以下视频提供实时更新功能部件的演示。

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/TjbC9thSfmM"></iframe>
    </div>
</div>

#### 跳转至：
{: #jump-to }
* [实时更新体系结构](#live-update-architecture)
* [向 {{ site.data.keys.mf_server }} 添加实时更新](#adding-live-update-to-mobilefirst-server)
* [配置应用程序安全性](#configuring-application-security)
* [模式和分段](#schema-and-segments)
* [向应用程序添加实时更新 SDK](#adding-live-update-sdk-to-applications)
* [使用实时更新 SDK](#using-the-live-update-sdk)
* [高级主题](#advanced-topics)
* [样本应用程序](#sample-application)


## 实时更新体系结构
{: #live-update-architecture }
以下系统组件一起运行以提供实时更新功能。

![体系结构概述](architecture_overview.png)

* **实时更新适配器：**提供以下功能的适配器：
 - 应用程序模式和分段管理
 - 向应用程序提供配置
* **分段解析器适配器：***可选*。 开发人员实施的定制适配器。 适配器接收应用程序上下文（例如，设备和用户上下文以及定制参数）并返回对应于上下文的分段标识。
* **客户机端 SDK：**实时更新 SDK 用于从 {{ site.data.keys.mf_server }} 检索和访问配置元素，例如，功能部件和属性。
* **{{ site.data.keys.mf_console }}：**用于配置实时更新适配器和设置。
* **配置服务：***内部*。 针对实时更新适配器提供配置管理服务。

## 向 {{ site.data.keys.mf_server }} 添加实时更新
{: #adding-live-update-to-mobilefirst-server }
缺省情况下，将隐藏 {{ site.data.keys.mf_console }} 中的“实时更新设置”。 要启用，需要部署提供的实时更新适配器。  

1. 打开 {{ site.data.keys.mf_console }}。 从侧边栏，单击**下载中心 → 工具**选项卡。
2. 下载并部署实时更新适配器。

一旦部署，那么将针对每个已注册的应用程序显示**实时更新设置**屏幕。

<img class="gifplayer" alt="部署实时更新" src="deploy-live-update.png"/>

## 配置应用程序安全性
{: #configuring-application-security }
为支持与实时更新集成，需要一个作用域元素。 如果没有，适配器将拒绝来自客户机应用程序的请求。  

装入 {{ site.data.keys.mf_console }}，然后单击**[您的应用程序] → 安全性选项卡 → 作用域/元素映射**。 单击**新建**并输入作用域元素 **configuration-user-login**。 然后，单击**添加**。

在应用程序中使用时，也可以将作用域元素映射到安全性检查。

> [了解有关 {{ site.data.keys.product_adj }} 安全框架的更多信息](../../authentication-and-security/)

<img class="gifplayer" alt="添加作用域映射" src="scope-mapping.png"/>

## 模式和分段
{: #schema-and-segments }
“实时更新设置”屏幕上提供两个选项卡：

#### 什么是模式
{: #what-is-schema }
模式用于定义功能部件和属性。  

* 使用“功能部件”，您可以定义可配置的应用程序功能部件并设置其缺省值。  
* 使用“属性”，您可以定义可配置的应用程序属性并设置其缺省值。

#### 分段
{: #segments }
分段通过定制模式所定义的缺省功能部件和属性来定义独特应用程序行为。

### 添加模式和分段
{: #adding-schema-and-segments }
在针对应用程序添加模式和分段之前，开发人员或产品管理团队需要就多个方面达成决策：

* 要利用实时更新的**功能部件**及其缺省状态的集合
* 可配置字符串**属性**及其缺省值的集合
* 应用程序的消费群

对于每个消费群，应决定：

* 每个功能部件的状态，以及在应用程序生命周期内此状态如何更改
* 每个属性的值，以及在应用程序生命周期内此值如何更改

<br/>
在决定参数后，可添加“模式功能部件和属性”以及“分段”。  
要添加，请单击**新建**并提供请求的值。

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="schema">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSchema" aria-expanded="false" aria-controls="collapseSchema">单击以复审模式术语</a>
            </h4>
        </div>

        <div id="collapseSchema" class="panel-collapse collapse" role="tabpanel" aria-labelledby="schema">
            <div class="panel-body">
                <ul>
                    <li><b>功能部件：</b>功能部件确定是启用还是禁用某些部分的应用程序功能。 在应用程序模式中定义功能部件时，应提供以下元素：
                        <ul>
                            <li><i>id</i> - 唯一功能部件标识。 字符串，不可编辑。</li>
                            <li><i>name</i> - 功能部件的描述性名称。 字符串，可编辑。</li>
                            <li><i>description</i> - 功能部件的简短描述。 字符串，可编辑。</li>
                            <li><i>defaultValue</i> - 将提供的功能部件的缺省值，除非在分段内进行覆盖（请参阅以下分段）。 布尔值，可编辑。</li>
                        </ul>
                    </li>
                    <li><b>属性：</b>属性是一个可用于定制应用程序的“键:值”实体。 在应用程序模式中定义属性时，应提供以下元素：
                        <ul>
                            <li><i>id</i> - 唯一属性标识。 字符串，不可编辑。</li>
                            <li><i>name</i> - 属性的描述性名称。 字符串，可编辑。</li>
                            <li><i>description</i> - 属性的简短描述。 字符串，可编辑。</li>
                            <li><i>defaultValue</i> - 将提供的属性的缺省值，除非在分段内进行覆盖（请参阅以下分段）。 字符串，可编辑。</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="segment">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSegment" aria-expanded="false" aria-controls="collapseSegment">单击以复审分段术语</a>
            </h4>
        </div>

        <div id="collapseSegment" class="panel-collapse collapse" role="tabpanel" aria-labelledby="segment">
            <div class="panel-body">
                <ul>
                    <li><b>分段：</b>分段是对应于消费群的实体。 其包含在模式中定义的功能和属性，可能会覆盖值。 在定义分段时，应提供以下元素：
                        <ul>
                            <li><i>id</i> - 唯一分段标识。 字符串，不可编辑。</li>
                            <li><i>name</i> - 分段的描述性名称。 字符串，可编辑。</li>
                            <li><i>description</i> - 分段的简短描述。 字符串，可编辑。</li>
                            <li><i>Features</i> - 在模式中定义的功能部件列表，用户可为功能部件设置不同于模式缺省值的静态值。</li>
                            <li><i>Properties</i> - 模式中定义的属性列表，用户可为属性设置不同于模式缺省值的静态值。</li>
                        </ul>
                    </li>
                </ul>

                <blockquote><b>注：</b><br/>
                    <ul>
                        <li>在向模式添加功能部件或属性时，会自动将对应的功能部件或属性添加到应用程序的所有分段（含缺省值）。</li>
                        <li>在从模式除去功能部件或属性时，会自动从应用程序的所有分段除去对应的功能部件或属性。</li>
                    </ul>
                </blockquote>
            </div>
        </div>
    </div>
</div>

#### 定义模式功能部件和属性以及缺省值
{: #define-schema-features-and-properties-with-default-values }
<img class="gifplayer" alt="添加模式功能部件和属性" src="add-feature-property.png"/>

#### 定义对应于消费群的分段
{: #define-degments-that-correspond-to-market-segments }
<img class="gifplayer" alt="添加分段" src="add-segment.png"/>

#### 覆盖功能部件和属性的缺省值
{: #override-default-values-of-features-and-properties }
启用功能部件并更改其缺省状态。
<img class="gifplayer" alt="启用功能部件" src="feature-enabling.png"/>

覆盖属性的缺省值。
<img class="gifplayer" alt="覆盖属性" src="property-override.png"/>

## 向应用程序添加实时更新 SDK
{: #adding-live-update-sdk-to-applications}
实时更新 SDK 向开发人员提供 API 以查询在 {{ site.data.keys.mf_console }} 的注册应用程序的“实时更新设置”屏幕中预先定义的运行时配置功能部件和属性。

* [Cordova 插件文档](https://github.com/mfpdev/mfp-live-update-cordova-plugin)
* [iOS Swift SDK 文档](https://github.com/mfpdev/mfp-live-update-ios-sdk)
* [Android SDK 文档](https://github.com/mfpdev/mfp-live-update-android-sdk)

### 添加 Cordova 插件
{: #adding-the-cordova-plugin }
在 Cordova 应用程序文件夹中，运行：

```bash
cordova plugin add cordova-plugin-mfp-liveupdate
```

### 添加 iOS SDK
{: #adding-the-ios-sdk }
1. 通过添加 `IBMMobileFirstPlatformFoundationLiveUpdate` pod 编辑应用程序的 pod 文件。  
 例如：

   ```xml
   use_frameworks!

   target 'your-Xcode-project-target' do
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationLiveUpdate'
   end
   ```

2. 从**命令行**窗口，浏览至 Xcode 项目的根文件夹并运行命令：`pod install`。

### 添加 Android SDK
{: #adding-the-android-sdk }
1. 在 Android Studio 中，选择 **Android → Gradle 脚本**，然后选择 **build.gradle（模块：应用程序）**文件。
2. 在 `dependencies` 中添加 `ibmmobilefirstplatformfoundationliveupdate`：

   ```xml
   dependencies {
        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundation',
        version: '8.0.+',
        ext: 'aar',
        transitive: true

        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundationliveupdate',
        version: '8.0.0',
        ext: 'aar',
        transitive: true
   }   
   ```

## 使用实时更新 SDK
{: #using-the-live-update-sdk }
可通过多种方法使用实时更新 SDK。

### 预先确定的分段
{: #pre-determined-segment }
实施逻辑以检索相关分段的配置。  
将“segment-name”、“property-name”和“feature-name”替换为自己的项。

#### Cordova
{: #cordova }
```javascript
    var input = { segmentId :'segment-name' };
    LiveUpdateManager.obtainConfiguration(input,function(configuration) {
        // do something with configration (JSON) object, for example,
        // if you defined in the server a feature named 'feature-name':
        // if (configuration.features.feature-name) {
        //   console.log(configuration.properties.property-name);
	// }
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });
```

#### iOS
{: #ios }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration("segment-name", completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android }
```java
LiveUpdateManager.getInstance().obtainConfiguration("segment-name", new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});
```

利用检索的实时更新配置，可用逻辑和应用程序流程可基于功能部件和属性的状态。 例如，如果今天是全国性假日，那么在应用程序中引入新的市场营销促销活动。

### 分段解析器适配器
{: #segment-resolver-adapter }
在[实时更新体系结构](#live-update-architecture)主题中，已提及“分段解析器”适配器。  
此适配器的目的是提供定制业务逻辑，以基于应用程序/设备/用户上下文和可用定制参数检索分段。

要使用分段解析器适配器：

1. [创建新的 Java 适配器](../../adapters/creating-adapters/)。
2. 在**适配器 → 实时更新适配器 → segmentResolverAdapterName** 中将适配器定义为分段解析器适配器。
3. 在完成开发后，请记住要[重新构建并部署](../../adapters/creating-adapters/)。

分段解析器适配器可定义 REST 接口。 此适配器的请求在其主体中包含所有必需的信息，以决定最终用户所属的分段并将其发送回应用程序。

要通过参数获取配置，请使用实时更新 API 来发送请求：

#### Cordova 解析器
{: cordova-resolver }
```javascript
var input = { params : { 'paramKey': 'paramValue'} ,useClientCache : true };                                                                                                    
LiveUpdateManager.obtainConfiguration(input,function(configuration) {
        // do something with configration (JSON) object, for example:
        // console.log(configuration.properties.property-name);                                                                                                             // console.log(configuration.data.features.feature-name);                                                                                                        
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });
```

#### iOS
{: #ios-resolver }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(["paramKey":"paramValue"], completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android-resolver }
```java
Map <String,String> params = new HashMap<>();
params.put("paramKey", "paramValue");

LiveUpdateManager.getInstance().obtainConfiguration(params , new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});
```

#### 适配器实现
{: #adapter-implementation }
然后，会将应用程序使用实时更新客户机 SDK 提供的参数传递到实时更新适配器，并从此处传递到分段解析器适配器。 实时更新适配器自动完成此操作，而无需开发人员执行任何操作。

更新新创建的分段解析器适配器的实现，以处理这些参数，从而返回相关分段。  
以下是可使用的样本代码。

**注：**确保在适配器的 `pom.xml` 中添加 Gson 依赖关系：

```xml
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.7</version>
</dependency>
```

**SampleSegmentResolverAdapterApplication.java**  

```java
@Api(value = "Sample segment resolver adapter")
@Path("/")
public class SampleSegmentResolverAdapter {

    private static final Gson gson = new Gson();
    private static final Logger logger = Logger.getLogger(SampleSegmentResolverAdapter.class.getName());

    @POST
    @Path("segment")
    @Produces("text/plain;charset=UTF-8")
    @OAuthSecurity(enabled = true, scope = "configuration-user-login")
    public String getSegment(String body) throws Exception {
        ResolverAdapterData data = gson.fromJson(body, ResolverAdapterData.class);
        String segmentName = "";

        // Get the custom arguments
        Map<String, List<String>> arguments = data.getQueryArguments();

        // Get the authenticatedUser object
        AuthenticatedUser authenticatedUser = data.getAuthenticatedUser();
        String name = authenticatedUser.getDisplayName();

        // Get registration data such as device and application
        RegistrationData registrationData = data.getRegistrationData();
        ApplicationKey application = registrationData.getApplication();
        DeviceData deviceData = registrationData.getDevice();

        // Based on the above context (arguments, authenticatedUser and registrationData) resolve the segment name.
        // Write your custom logic to resolve the segment name.

        return segmentName;
    }
}
```

**SampleSegmentResolverAdapter.java**

```java
public class ResolverAdapterData {
    public ResolverAdapterData() {
    }

    public ResolverAdapterData(AdapterSecurityContext asc, Map<String, List<String>> queryArguments)
    {
        ClientData cd = asc.getClientRegistrationData();

        this.authenticatedUser = asc.getAuthenticatedUser();
        this.registrationData = cd == null ? null : cd.getRegistration();
        this.queryArguments = queryArguments;
    }

    public AuthenticatedUser getAuthenticatedUser() {
        return authenticatedUser;
    }

    public RegistrationData getRegistrationData() {
        return registrationData;
    }

    public Map<String, List<String>> getQueryArguments() {
        return queryArguments;
    }

    private AuthenticatedUser authenticatedUser;
    private RegistrationData registrationData;
    private Map<String, List<String>> queryArguments;
}
```

#### 分段解析器适配器的 REST 接口
{: #rest-interface-of-the-segment-resolver-adapter }
**请求**

| **属性** |  **值**                                                                                     |  
|:----------------|:--------------------------------------------------------------------------------------------------|
| *URL*           | /segment                                                                                          |
| *Method*        | POST                                                                                              |               
| *Content-type*  | application/json                                                                                  |
| *Body*          | &lt;JSON 对象，其中包含要进行分段解析而必需的所有信息&gt;                     |

**响应**

|  **属性** |  **值**                             |
|:-------------------|:--------------------------------------------|
| *Content-type*     | text/plain                                  |                                                                          
| *Body*             |  &lt;描述分段标识的字符串&gt;   |


## 高级主题
{: #advanced-topics }
### 导入/导出
{: #importexport }
在定义模式和分段后，系统管理员可将其导出并导入到其他服务器实例。

#### 导出模式
{: #export-schema }
```bash
curl --user admin:admin http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/schema > schema.txt
```

#### 导入模式
{: #import-schema }
```bash
curl -X PUT -d @schema.txt --user admin:admin -H "Content-Type:application/json" http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/schema
```

* 将“admin:admin”替换为自己的项（缺省值为“admin”）
* 将“localhost”和端口号替换为自己的项（如果需要）
* 将应用程序标识“com.sample.HelloLiveUpdate”替换为自己的应用程序标识。

#### 导出分段
{: #export-segments }
```bash
curl --user admin:admin http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/segment?embedObjects=true > segments.txt
```

#### 导入分段
{: #import-segments }
```bash
#!/bin/bash
segments_number=$(python -c 'import json,sys;obj=json.load(sys.stdin);print len(obj["items"]);' < segments.txt)
counter=0
while [ $segments_number -gt $counter ]
do
    segment=$(cat segments.txt | python -c 'import json,sys;obj=json.load(sys.stdin);data_str=json.dumps(obj["items"]['$counter']);print data_str;')
    echo $segment | curl -X POST -d @- --user admin:admin --header "Content-Type:application/json" http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/segment
    ((counter++))
done
```

* 将“admin:admin”替换为自己的项（缺省值为“admin”）
* 将“localhost”和端口号替换为自己的项（如果需要）
* 将应用程序标识“com.sample.HelloLiveUpdate”替换为自己的应用程序标识。

### 高速缓存
{: #caching }
缺省情况下，启用高速缓存以避免网络等待时间。 这意味着更新可能不会立即发生。  
如果需要较频繁的更新，那么可禁用高速缓存。

#### Cordova
{: #cordova-caching }
使用可选的 _useClientCache_ 布尔标志控制客户机端高速缓存：

```javascript
	var input = { segmentId :'18' ,useClientCache : false };
        LiveUpdateManager.getConfiguration(input,function(configuration) {
                // do something with resulting configuration, for example:
                // console.log(configuration.data.properties.property-name);  
                // console.log(configuration.data.features.feature-name);
        } ,
        function(err) {
                if (err) {
                   alert('liveupdate error:'+err);
                }
  });
```

#### iOS
{: #ios-caching }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration("segment-name", useCache: false, completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android-caching }
```java
LiveUpdateManager.getInstance().obtainConfiguration("segment-name", false, new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
      Log.i("LiveUpdateSample", configuration.getProperty("property-name"));
      Log.i("LiveUpdateSample", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateSample", wlFailResponse.getErrorMsg());
    }
});
```

### 高速缓存到期
{: #cache-expiration }
**适配器 → 实时更新适配器**中定义的 `expirationPeriod` 值规定高速缓存到期前的时间长度。

<img alt="样本应用程序的图像" src="live-update-app.png" style="margin-left: 10px;float:right"/>

## 示例应用程序
{: #sample-application }
在样本应用程序中，选择国家或地区标志并使用实时更新，然后应用程序以对应于选中国家或地区的语言输出文本。 如果启用地图功能并提供地图，那么将显示对应国家或地区的地图。

[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80) Xcode 项目。  
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80) Android Studio 项目。

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件以获取指示信息。

#### 更改实时更新设置
{: #changing-live-update-settings }
每个分段从模式获取缺省值。 根据语言更改每项。 例如，对于法语，添加：**helloText** - **Bonjour le monde**。

在 **{{ site.data.keys.mf_console }} → [您的应用程序] → 实时更新设置 → 分段选项卡**中，单击所属的**属性**链接，例如，**FR**。

* 单击**编辑**图标并提供图像链接，例如，表示法国地图的图像。
* 要在使用应用程序时查看地图，需要启用 `includeMap` 功能。
