---
layout: tutorial
title: Cordova アプリケーションの複数言語への翻訳
relevantTo: [cordova]
weight: 12
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Translation/tree/release80
---

## 概要
IBM MobileFirst Platform Foundation フレームワークを使用すると、Cordova アプリケーションを他の言語に置き換える複数言語翻訳を追加できます。  
翻訳可能な項目は、アプリケーション・ストリングとシステム・メッセージです。 

#### 関連リンク:

* [アプリケーション・ストリングの翻訳](#アプリケーション・ストリング-の-翻訳)
* [システム・メッセージの翻訳](#システム・メッセージ-の-翻訳)
* [複数言語の翻訳](#複数言語-の-翻訳)
* [デバイスのロケールおよび言語の検出](#デバイス-の-ロケール-および-言語-の-検出)
* [サンプル・アプリケーション](#サンプル-アプリケーション)

## アプリケーション・ストリングの翻訳
翻訳されるストリングは "Messages" と呼ばれる `JSON` オブジェクト内に保管されています。これは Cordova アプリケーションの index.js ファイルにあります: **[cordova-project-root-directory]/www/js/index.js**

### JSON オブジェクトの構造の例

```JavaScript
var Messages = {
    headerText: "Default header",
    actionsLabel: "Default action label",
    sampleText: "Default sample text",
};
```

Messages `JSON` オブジェクトに保管されるストリングは、アプリケーション・ロジックで 2 つの方法で参照することができます。

**JavaScript オブジェクト・プロパティーとして:**

```JavaScript
Messages.headerText
```

**`class="translate"` 付きの HTML エレメントの ID として:**

```html
<h1 id="headerText" class="translate"></h1>
```

## システム・メッセージの翻訳
「インターネット接続が使用できません」や「ユーザー名またはパスワードが無効です」など、アプリケーションが表示するシステム・メッセージも翻訳することができます。システム・メッセージは `WL.ClientMessages` オブジェクト内に保管されています。

システム・メッセージの完全なリストは、生成されたプロジェクト内の `messages.json` ファイル内にあります。 

- Android: `[Cordova-project]\platforms\android\assets\www\plugins\cordova-plugin-mfp\worklight\messages`
- iOS、Windows: `[Cordova-project]\platforms\[ios or windows]\www\plugins\cordova-plugin-mfp\worklight\messages`

システム・メッセージを翻訳するには、アプリケーション・コード内でそのメッセージをオーバーライドします。

```javascript
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
```

**注意:** 一部のコードはアプリケーションの初期化が正常に完了して初めて実行されるため、システム・メッセージはグローバル JavaScript レベルでオーバーライドしてください。

## 複数言語の翻訳
JavaScript を使用して、アプリケーションの複数言語への翻訳を実装できます。  
以下のステップは、このチュートリアルのサンプル・アプリケーションの実装について説明します。

1. `index.js` ファイル内にデフォルトのアプリケーション・ストリングをセットアップします。

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

3. GUI コンポーネントを新しいストリングで更新します。右から左に読む言語 (ヘブライ語やアラビア語など) 用にテキスト方向を設定するなど、追加のタスクを実行できます。エレメントは、更新されるたびに、アクティブな言語に従って異なるストリングで更新されます。

    ```javascript
    function languageChanged(lang) {
        if (typeof(lang)!="string") 
            lang = $("#languages").val();
        
            switch (lang){
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
Cordova のグローバリゼーション・プラグインを使用して、デバイスのロケールおよび言語を検出することができます:`cordova-plugin-globalization`  
グローバリゼーション・プラグインは Cordova プラグインにプラットフォームを追加するときに自動インストールされます。

ロケールおよび言語の検出には、`navigator.globalization.getLocaleName` および `navigator.globalization.getPreferredLanguage` 関数を使用します。

```javascript
navigator.globalization.getLocaleName(
	function (localeValue) {
		WL.Logger.debug(">> Detected locale: " + localeValue);
		
        ...
        ...
        ...
	        }, function() {
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

![デバイスのロケールおよび言語の取得](DeviceLocaleLangugae.png)

## サンプル・アプリケーション
Cordova プロジェクトを[ダウンロードするにはここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Translation)します。  

### サンプルの使用法
1. コマンド・ラインから Cordova プロジェクトにナビゲートします。
2. `cordova platform add` コマンドを使用してプラットフォームを追加します。
3. `cordova prepare` の後に `cordova run` を使用して Cordova アプリケーションを準備および実行します。

> ヒント: アプリケーションの実行中に Android Studio の LogCat コンソールから Android の LogCat を調べることができます。
