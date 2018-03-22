---
layout: tutorial
title: JavaScript (Cordova、Web) アプリケーションのマルチリンガル・トランスレーション
breadcrumb_title: Multilingual translation
relevantTo: [javascript]
weight: 9
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Translation/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} フレームワークを使用すると、JavaScript (Cordova、Web) アプリケーションに他言語へのマルチリンガル・トランスレーションを追加できます。  
翻訳可能な項目は、アプリケーション・ストリングとシステム・メッセージです。 

#### ジャンプ先:
{: #jump-to }
* [アプリケーション・ストリングの翻訳](#translating-application-strings)
* [システム・メッセージの翻訳](#translating-system-messages)
* [複数言語翻訳](#multilanguage-translation)
* [デバイスのロケールおよび言語の検出](#detecting-the-device-locale-and-language)
* [サンプル・アプリケーション](#sample-application)

## アプリケーション・ストリングの翻訳
{: #translating-application-strings }
翻訳することが予定されたストリングは、「Messages」と呼ばれる`JSON` オブジェクトに保存されます。 

- {{ site.data.keys.product_adj }} SDK を使用した Cordova アプリケーションでは、このオブジェクトは、次のような Cordova アプリケーションの **index.js** ファイル内にあります。**[cordova-project-root-directory]/www/js/index.js**
- Web アプリケーションでは、このオブジェクトを追加する必要があります。

### JSON オブジェクト構造の例
{: #json-object-structure-example }

```javascript
var Messages = {
    headerText: "Default header",
    actionsLabel: "Default action label",
    sampleText: "Default sample text",
};
```

Messages `JSON` オブジェクトに保存されたストリングは、アプリケーションのロジックにおいて次の 2 つの方法で参照することができます。

**JavaScript オブジェクト・プロパティーとして参照する場合:**

```javascript
Messages.headerText
```

**`class="translate"` を持つ HTML エレメントの ID として参照する場合:**

```html
<h1 id="headerText" class="translate"></h1>
```

## システム・メッセージの翻訳
{: #translating-system-messages }
「インターネット接続が使用できません」や「ユーザー名またはパスワードが無効です」など、アプリケーションが表示するシステム・メッセージも翻訳することができます。 システム・メッセージは `WL.ClientMessages` オブジェクト内に保管されます。

**注:** 一部のコードはアプリケーションの初期化が正常に完了して初めて実行されるため、システム・メッセージはグローバル JavaScript レベルでオーバーライドしてください。

### Web アプリケーション
{: #web-applications }
システム・メッセージの完全なリストは、**[project root folder]\node_modules\ibm-mfp-web-sdk\lib\messages\ フォルダーに配置されている `messages.json` ファイル内にあります**。

### Cordova アプリケーション
{: #cordova-applications }
システム・メッセージの完全なリストは、生成されたプロジェクト内に配置されている `messages.json` ファイル内にあります。

- Android: `[Cordova-project]\platforms\android\assets\www\plugins\cordova-plugin-mfp\worklight\messages`
- iOS、Windows: `[Cordova-project]\platforms\[ios or windows]\www\plugins\cordova-plugin-mfp\worklight\messages`

システム・メッセージを翻訳するには、アプリケーション・コード内でそのシステム・メッセージをオーバーライドします。

```javascript
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
```

## 複数言語翻訳
{: #multilanguage-translation }
JavaScript を使用して、アプリケーションの複数言語の翻訳を実装できます。  
以下に、このチュートリアルのサンプル・アプリケーションの実装手順を示します。

1. デフォルトのアプリケーション・ストリングを `index.js` ファイルにセットアップします。

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

2. 必要に応じて特定のストリングをオーバーライドします。

   ```javascript
   function setFrench(){
        Messages.headerText = "Traduction";
        Messages.actionsLabel = "Sélectionnez une langue:";
        Messages.sampleText = "Ceci est un exemple de texte en français.";
   }
   ```

3. GUI コンポーネントを新しいストリングで更新します。 右から左に読む言語 (ヘブライ語やアラビア語など) 用にテキスト方向を設定するなど、追加のタスクを実行できます。 エレメントは、更新されるたびに、アクティブな言語に従って異なるストリングで更新されます。

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

## デバイスのロケールおよび言語の検出
{: #detecting-the-device-locale-and-language }
デバイスまたはブラウザーで使用されている言語を検出するには、以下のようにします。

### Web アプリケーション
{: #web-applications-locale}
`navigator.language` または任意の数の使用可能なフレームワークおよびソリューションを使用して、ブラウザーの言語を検出します。

### Cordova アプリケーション
{: #cordova-applications-locale }
Cordova のグローバリゼーション・プラグインである `cordova-plugin-globalization` を使用して、デバイスのロケールおよび言語を検出します。  
このグローバリゼーション・プラグインは、任意のプラットフォームを Cordova アプリケーションに追加したときに自動的にインストールされます。

ロケールを検出するには `navigator.globalization.getLocaleName` 関数、言語を検出するには `navigator.globalization.getPreferredLanguage` 関数を使用します。

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

結果は、デバイスのログ、例えば Android Studio の LogCat などで、次のように確認できます。  
![デバイスのロケールと言語の取得](DeviceLocaleLangugae.png)

## サンプル・アプリケーション
{: #sample-application }
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Translation) して Cordova プロジェクトをダウンロードします。  

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** Android の LogCat は、アプリケーションの実行中に Android Studio の LogCat コンソールで調べることができます。
