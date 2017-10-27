---
layout: tutorial
title: JavaScript（Cordova 或 Web）应用程序的多语言翻译
breadcrumb_title: 多语言翻译
relevantTo: [javascript]
weight: 9
downloads:
  - name: 下载 Cordova 项目
    url: https://github.com/MobileFirst-Platform-Developer-Center/Translation/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
您可以使用 {{ site.data.keys.product_full }} 框架将 JavaScript（Cordova 或 Web）应用程序中的多语言翻译添加到其他语言。  
可以翻译的项包括应用程序字符串和系统消息。 

#### 跳转至：
{: #jump-to }
* [翻译应用程序字符串](#translating-application-strings)
* [翻译系统消息](#translating-system-messages)
* [多语言翻译](#multilanguage-translation)
* [检测设备语言环境和语言](#detecting-the-device-locale-and-language)
* [样本应用程序](#sample-application)

## 翻译应用程序字符串
{: #translating-application-strings }
确定要翻译的字符串存储在名为“Messages”的 `JSON` 对象中。 

- 在使用 {{ site.data.keys.product_adj }} SDK 的 Cordova 应用程序中，您可以在 Cordova 应用程序的 **index.js** 文件中找到它：**[cordova-project-root-directory]/www/js/index.js**。
- 在 Web 应用程序中，您需要添加它。

### JSON 对象结构示例
{: #json-object-structure-example }

```javascript
var Messages = {
    headerText: "Default header",
    actionsLabel: "Default action label",
    sampleText: "Default sample text",
};
```

可以在应用程序逻辑中通过两种方式引用存储在 Messages `JSON` 对象中的字符串：

**作为 JavaScript 对象属性：**

```javascript
Messages.headerText
```

**作为具有 `class="translate"` 的 HTML 元素的标识：**

```html
<h1 id="headerText" class="translate"></h1>
```

## 翻译系统消息
{: #translating-system-messages }
还可能会翻译应用程序显示的系统消息，例如，“因特网连接不可用”或“用户名或密码无效”。 系统消息存储在 `WL.ClientMessages` 对象中。

**注：**在全局 JavaScript 级别覆盖系统消息，因为只会在成功初始化应用程序之后才会执行部分代码：

### Web 应用程序
{: #web-applications }
您可以在位于 **[project root folder]\node_modules\ibm-mfp-web-sdk\lib\messages\ 文件夹**内的 `messages.json` 文件中找到系统消息的完整列表。

### Cordova 应用程序
{: #cordova-applications }
您可以在位于已生成项目内的 `messages.json` 文件中找到系统消息的完整列表。

- Android：`[Cordova-project]\platforms\android\assets\www\plugins\cordova-plugin-mfp\worklight\messages`
- iOS 或 Windows：`[Cordova-project]\platforms\[ios or windows]\www\plugins\cordova-plugin-mfp\worklight\messages`

要翻译系统消息，请在应用程序代码中将其覆盖。

```javascript
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
```

## 多语言翻译
{: #multilanguage-translation }
通过使用 JavaScript，您可以对应用程序实施多语言翻译。  
下面的步骤解释了此指南的样本应用程序的实施。

1. 在 `index.js` 文件中设置缺省应用程序字符串。

   ```javascript
   var Messages = {
        headerText: "Default header",
        actionsLabel: "Default action label",
        sampleText: "Default sample text",
        englishLanguage: "English",
        frenchLanguage: "French",
        russianLanguage: "Russian",
        hebrewLanguage: "Hebrew"
   };
   ```

2. 在需要时覆盖特定字符串。

   ```javascript
   function setFrench(){
        Messages.headerText = "Traduction";
        Messages.actionsLabel = "Sélectionnez une langue:";
        Messages.sampleText = "Ceci est un exemple de texte en français.";
   }
   ```

3. 使用新字符串更新 GUI 组件。 您可以执行更多任务，如为自右向左语言（如希伯来语或阿拉伯语）设置文本方向。 每次更新元素时，都会根据活动的语言使用不同的字符串进行更新。

   ```javascript
   function languageChanged(lang) {
        if (typeof(lang)!="string") 
            lang = $("#languages").val();
        
        switch (lang) {
            case "english":
                setEnglish();
                break;
            case "french":
                setFrench();
                break;
            case "russian":
                setRussian();
                break;
            case "hebrew":
                setHebrew();
                break;
        }
               
        if ($("#languages").val()=="hebrew")
            $("#wrapper").css({direction: 'rtl'});
        else
            $("#wrapper").css({direction: 'ltr'});
      
        $("#sampleText").html(Messages.sampleText);
        $("#headerText").html(Messages.headerText);
        $("#actionsLabel").html(Messages.actionsLabel);
   }
   ```

## 检测设备语言环境和语言
{: #detecting-the-device-locale-and-language }
要检测设备或浏览器使用的语言：

### Web 应用程序
{: #web-applications-locale}
使用 `navigator.language` 或任意数量的可用框架和解决方案检测浏览器语言。

### Cordova 应用程序
{: #cordova-applications-locale }
使用 Cordova 的全球化插件检测设备的语言环境和语言：`cordova-plugin-globalization`。  
将平台添加到 Cordova 应用程序时，将自动安装全球化插件。

分别使用 `navigator.globalization.getLocaleName` 和 `navigator.globalization.getPreferredLanguage` 函数检测语言环境和语言。

```javascript
navigator.globalization.getLocaleName(
	function (localeValue) {
		WL.Logger.debug(">> Detected locale: " + localeValue);
		
        ...
        ...
        ...
	},
	function() {
		WL.Logger.debug(">> Unable to detect locale.");
	}
);

navigator.globalization.getPreferredLanguage(
	function (langValue) {
		lang = langValue.value;
		WL.Logger.debug(">> Detected language: " + lang);
	},
	function() {
		WL.Logger.debug(">> Unable to detect language.");
	}
);
```

然后可以在设备日志（例如从 Android Studio 的 LogCat）中查看结果：  
![获取设备语言环境和语言](DeviceLocaleLangugae.png)

## 样本应用程序
{: #sample-application }
[单击以下载](https://github.com/MobileFirst-Platform-Developer-Center/Translation) Cordova 项目。  

### 样本用法
{: #sample-usage }
遵循样本的 README.md 文件获取指示信息。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **提示：**您可以在应用程序正在运行时从 Android Studio 的 LogCat 控制台检查 Android 的 LogCat。
