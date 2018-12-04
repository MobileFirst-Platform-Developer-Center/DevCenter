---
layout: tutorial
title: Cordova アプリケーションでの MobileFirst Foundation 開発
breadcrumb_title: Cordova application development
relevantTo: [cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
[http://cordova.apache.org/](http://cordova.apache.org/) から:

> Apache Cordova は、オープン・ソースのモバイル開発フレームワークです。 HTML5、CSS3、および JavaScript など、クロスプラットフォーム開発用の標準 Web テクノロジーを使用することができ、個々のモバイル・プラットフォームのネイティブ開発言語を使用せずに済みます。 アプリケーションは、個々のプラットフォームを対象としたラッパー内で実行され、標準に準拠した API バインディングに依存して、各デバイスのセンサー、データ、およびネットワーク状況にアクセスします。

{{ site.data.keys.product_full }} は、複数の Cordova プラグインの形式で SDK を提供しています。 [{{ site.data.keys.product }} SDKをCordova アプリケーションに追加する](../../application-development/sdk/cordova)方法を説明します。

> **注:** iOS アプリケーションのストアへの提出および検証のために Test Flight または iTunes Connect を使用して生成されたアーカイブ・ファイルおよび IPA ファイルにより、ランタイムの異常終了や失敗が発生する場合があります。詳細については、ブログ[『{{ site.data.keys.product_full }} でのアプリ・ストアへの提出のための iOS アプリの準備』](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/)を参照してください。

#### ジャンプ先:
{: #jump-to }

* [Cordova アプリケーション開発](#cordova-application-development)
* [{{ site.data.keys.product_adj }} API](#mobilefirst-apis)
* [{{ site.data.keys.product_adj }} SDK 開始フロー](#mobilefirst-sdk-startup-flow)
* [Cordova アプリケーション・セキュリティー](#cordova-application-security)
* [Cordova アプリケーション・リソース](#cordova-application-resources)
* [アプリケーションの Web リソースのプレビュー](#previewing-an-applications-web-resources)
* [JavaScript コードの実装](#implementing-javascript-code)
* [Android 用の CrossWalk サポート](#crosswalk-support-for-android)
* [iOS 用の WKWebView のサポート](#wkwebview-support-for-ios)
* [発展的なチュートリアル](#further-reading)
* [次に使用するチュートリアル](#tutorials-to-follow-next)

## Cordova アプリケーション開発
{: #cordova-application-development }
Cordova を使用して開発されたアプリケーションは、以下の Cordova 提供の開発パスおよびフィーチャーを使用してさらに拡張できます。

### フック
{: #hooks }
Cordova フックは、Cordova コマンドをカスタマイズする機能を開発者に提供するスクリプトで、例えば、カスタム・ビルド・フローの作成を可能にします。  
詳しくは、[Cordova フック](http://cordova.apache.org/docs/en/dev/guide/appdev/hooks/index.html#Hooks%20Guide)に関する説明を参照してください。

### マージ
{: #merges }
Merges フォルダーを使用すると、プラットフォーム固有の Web リソース (HTML、CSS、および JavaScript のファイル) を保持することができます。 その後、これらの Web リソースは、`cordova prepare` ステップ中に適切なネイティブ・ディレクトリーにデプロイされます。 **merges/** フォルダーの下に配置されたファイルは、関連プラットフォームの **www/** フォルダー内の一致するファイルをオーバーライドします。 詳しくは、[Merges フォルダー](https://github.com/apache/cordova-cli#merges)に関する説明を参照してください。

### Cordova プラグイン
{: #cordova-plug-ins }
Cordova プラグインは、ネイティブ UI エレメント (ダイアログ、タブ・バー、スピナーなど) の追加などの機能拡張に加え、マッピングおよび地理位置情報、外部コンテンツのロード、カスタム・キーボード、デバイス統合 (カメラ、コンタクト、センサー等) などのより高度な機能を提供できます。

Cordova プラグインは、[GitHub.com](https://github.com) 上、およびよく使用されている Cordova プラグインの Web サイト ([Plugreg](http://plugreg.com/) および [NPM](http://npmjs.org)) にあります。

サンプル・プラグイン:

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

>**注:** {{ site.data.keys.product_adj }} Cordova SDK がプロジェクトに追加されるときに、Cordova アプリケーションのデフォルトの動作を変更する (「戻る」ボタンの動作をオーバーライドするなど) と、送信時に、Google Play Store によってアプリケーションが拒否される原因となることがあります。
Google Play Store へのサブミットに関する他の障害については、Google サポートにお問い合わせください。


### サード・パーティー製フレームワーク
{: #3rd-party-frameworks }
Cordova アプリケーション開発は、[Ionic](http://ionicframework.com/)、[AngularJS](https://angularjs.org/)、[jQuery Mobile](http://jquerymobile.com/)、[Backbone](http://backbonejs.org/) などのフレームワークを使用してさらに拡張できます。

**統合ブログ投稿**

* [MobileFirst Foundation 8.0 を使用した AngularJS アプリケーションのビルドのベスト・プラクティス](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/11/best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/)
* [Ionic ベースのアプリケーションでの {{ site.data.keys.product }} の統合]({{site.baseurl}}/blog/2016/07/19/integrating-mobilefirst-foundation-8-in-ionic-based-apps/)
* [Ionic 2 ベースのアプリケーションでの {{ site.data.keys.product }} の統合]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

### サード・パーティー製パッケージ
{: #3rd-party-packages }
アプリケーションの Web リソース等のミニファイおよび連結などの要件を達成するために、サード・パーティー製パッケージを使用してアプリケーションを変更できます。 この目的でよく使用されているパッケージは、以下のとおりです。

- [uglify-js](https://www.npmjs.com/package/uglify-js)
- [clean-css](https://www.npmjs.com/package/clean-css)

## {{ site.data.keys.product_adj }} API
{: #mobilefirst-apis }
[{{ site.data.keys.product_adj }} Cordova SDK を](../../application-development/sdk/cordova) Cordova アプリケーションに追加すると、API メソッドの {{ site.data.keys.product_adj }} セットが使用できるようになります。

> 使用可能な API メソッドの完全なリストについては、[API リファレンス](../../api)を参照してください。

## {{ site.data.keys.product_adj }} SDK 開始フロー
{: #mobilefirst-sdk-startup-flow }
<div class="panel-group accordion" id="startup-flows" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Android 開始フロー</b></a>
            </h4>
        </div>

        <div id="collapse-android-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-flow">
            <div class="panel-body">
                <p>Android Studio で、{{ site.data.keys.product_adj }} を使用する Android 用 Cordova アプリケーションの開始プロセスを検討できます。 {{ site.data.keys.product_adj }} Cordova プラグイン <b>cordova-plugin-mfp</b> には、ネイティブの非同期ブートストラップ・シーケンスがあります。 ブートストラップ・シーケンスは、Cordova アプリケーションがアプリケーションのメイン html ファイルをロードする前に完了する必要があります。</p>

                <p><b>cordova-plugin-mfp</b> プラグインを Cordova アプリケーションに追加すると、アプリケーションの <b>AndroidManifest.xml</b> ファイルが装備されます。また、({{ site.data.keys.product_adj }} の初期化を実行するように <code>CordovaActivity</code> ネイティブ・コードを拡張する) <code>MainActivity</code> ファイルも装備されます。</p>

                <p>アプリケーションのネイティブ・コードのインスツルメンテーションは以下で構成されます。</p>
                <ul>
                    <li>{{ site.data.keys.product_adj }} の初期化を実行するための <code>com.worklight.androidgap.api.WL</code> API 呼び出しを追加します。</li>
                    <li><b>AndroidManifest.xml</b> ファイルで以下を追加します。
                        <ul>
                            <li><code>MFPLoadUrlActivity</code> というアクティビティー。このアクティビティーにより、<b>cordova-plugin-crosswalk-webview</b>がインストールされていた場合に、{{ site.data.keys.product_adj }} を適切に初期化することができます。</li>
                            <li>カスタム属性 <b>android:name="com.ibm.MFPApplication"</b>。これを <code>application</code> エレメントに追加します (以下を参照)。</li>
                        </ul>
                    </li>
                </ul>

                <h3>WLInitWebFrameworkListener の実装と WL オブジェクトの作成</h3>
                <p><b>MainActivity.java</b> ファイルは、<code>CordovaActivity</code> クラスを拡張する初期の <code>MainActivity</code> クラスを作成します。 <code>WLInitWebFrameworkListener</code> は、{{ site.data.keys.product_adj }} フレームワークが初期化される際に、通知を受信します。</p>

{% highlight java %}
public class MainActivity extends CordovaActivity implements WLInitWebFrameworkListener {
{% endhighlight %}

                <p><code>MFPApplication</code> クラスは <code>onCreate</code> 内から呼び出され、アプリケーションを通して使用される {{ site.data.keys.product_adj }} クライアント・インスタンス (<code>com.worklight.androidgap.api.WL</code>) を作成します。 <code>onCreate</code> メソッドは <b>WebView フレームワーク</b>を初期化します。</p>

{% highlight java %}
@Overridepublic void onCreate(Bundle savedInstanceState){
super.onCreate(savedInstanceState);

if (!((MFPApplication)this.getApplication()).hasCordovaSplashscreen()) {
           WL.getInstance().showSplashScreen(this);
       }
   init();
   WL.getInstance().initializeWebFramework(getApplicationContext(), this);
}
{% endhighlight %}

                <p><code>MFPApplication</code> クラスには、以下の 2 つの機能があります。</p>
                <ul>
                    <li>スプラッシュ画面が存在する場合にロードするための <code>showSplashScreen</code> メソッドを定義します。</li>
                    <li>分析を使用可能にする 2 つのリスナーを作成します。 これらのリスナーは、不要な場合に削除することができます。</li>
                </ul>

                <h3>WebView のロード</h3>
                <p><b>cordova-plugin-mfp</b> プラグインは、Crosswalks WebView を初期化するために必要な以下のアクティビティーを <b>AndroidManifest.xml</b> ファイルに追加します。</p>

{% highlight xml %}
<activity android:name="com.ibm.MFPLoadUrlActivity" />
{% endhighlight %}

                <p>このアクティビティーを使用して、以下のように Crosswalk WebView が非同期に初期化されるようにします。</p>

                <p>{{ site.data.keys.product_adj }} フレームワークが初期化されて WebView へのロード準備ができた後、<code>WLInitWebFrameworkResult</code> が成功すると、<code>onInitWebFrameworkComplete</code> は URL に接続します。</p>

{% highlight java %}
public void onInitWebFrameworkComplete(WLInitWebFrameworkResult result){
if (result.getStatusCode() == WLInitWebFrameworkResult.SUCCESS) {
super.loadUrl(WL.getInstance().getMainHtmlFilePath());
   } else {
      handleWebFrameworkInitFailure(result);
   }
}
{% endhighlight %}



                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>iOS 開始フロー</b></a>
            </h4>
        </div>

        <div id="collapse-ios-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-flow">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} フレームワークは iOS プラットフォームで初期化され、{{ site.data.keys.product_adj }} を使用する Cordova アプリケーションで WebView を表示します。</p>

                <b>AppDelegate.m</b>
                <p><code>AppDelegate.m</code> ファイルは Classes フォルダーにあります。 これは、ビュー・コントローラーが WebView をロードする前に {{ site.data.keys.product_adj }} フレームワークを初期化します。</p>

                <p><code>didFinishLaunchingWithOptions</code> メソッドは、次のフレームワークを初期化します。</p>

{% highlight objc %}
[[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
{% endhighlight %}

                <p>初期化が成功すると、<code>wlInitWebFrameworkDidCompleteWithResult</code> は、{{ site.data.keys.product_adj }} フレームワークがロードされたことを検査し、デフォルトの <b>index.html</b> ページに接続する <code>MainViewController</code> を作成します。</p>

                <p>iOS Cordova アプリケーションが Xcode でエラーなしでビルドされると、フィーチャーをネイティブ・プラットフォームと WebView に追加できるようになります。</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Windows 開始フロー</b></a>
            </h4>
        </div>

        <div id="collapse-windows-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows-flow">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} Cordova プラグイン <b>cordova-plugin-mfp</b> には、ネイティブの非同期ブートストラップ・シーケンスがあります。 ブートストラップ・シーケンスは、Cordova アプリケーションがアプリケーションのメイン HTML ファイルをロードする前に完了する必要があります。</p>

                <p>Cordova アプリケーションに <b>cordova-plugin-mfp</b> プラグインを追加すると、アプリケーションの  <b>appxmanifest</b> ファイルに  <b>index.html</b> ファイルが追加されます。 これにより、{{ site.data.keys.product_adj }} の初期化を実行するように <code>CordovaActivity</code> ネイティブ・コードが拡張されます。</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>

## Cordova アプリケーション・セキュリティー
{: #cordova-application-security }
{{ site.data.keys.product_full }} は、Cordova アプリケーションを保護する際に役立つセキュリティー・フィーチャーを提供します。

クロスプラットフォーム・アプリケーションのコンテンツの多くは、ネイティブ・アプリケーションよりもさらに容易に無許可な個人によって変更される可能性があります。 クロスプラットフォーム・アプリケーションの一般的なコンテンツの多くは読み取り可能なフォーマットであるため、IBM MobileFirst Foundation では、ご使用のクロスプラットフォーム Cordova アプリケーションに高水準のセキュリティーを提供できるフィーチャーを用意しています。

> 詳しくは、[{{ site.data.keys.product_adj }} セキュリティー・フレームワーク](../../authentication-and-security)に関する説明を参照してください。

以下のフィーチャーを使用して、Cordova アプリケーションのセキュリティーを強化します。

* [Cordova パッケージの Web リソースの暗号化](securing-apps/#encrypting-the-web-resources-of-your-cordova-packages)  
    Cordova アプリケーションの www フォルダーにあるコンテンツを暗号化し、アプリケーションが最初にインストールされて実行されたときに暗号化を解除します。 この暗号化により、アプリケーションがパッケージ化されている間、そのフォルダーにあるコンテンツを表示または変更することがより困難になります。
* [Web リソース・チェックサム機能の有効化](securing-apps/#enabling-the-web-resources-checksum-feature)  
    アプリケーションの開始時に、そのコンテンツを、アプリケーションが初めて開始されたときに収集された基準値となるチェックサム結果と比較して、整合性を確認します。 このテストは、インストール済みのアプリケーションの変更を防ぐのに役立ちます。
* [FIPS 140-2 の有効化](../../administering-apps/federal/#enabling-fips-140-2)  
    休止中のデータと動作中のデータの暗号化に使用される暗号化アルゴリズムが、必ず連邦情報処理標準 (FIPS) 140-2 に準拠するようにします。
* [証明書ピン留め](../../authentication-and-security/certificate-pinning)  
    予想される公開鍵にホストを関連付けることで、中間者 (man-in-the-middle) 攻撃を防ぎます。

## Cordova アプリケーション・リソース
{: #cordova-application-resources }
Cordova アプリケーションの一部として、特定のリソースが必要です。 それらは、ほとんどの場合、任意の Cordova 開発ツールで Cordova アプリケーションを作成すると生成されます。 {{ site.data.keys.product }} テンプレートを使用した場合、スプラッシュ画面およびアイコンも提供されます。

{{ site.data.keys.product_adj }} 機能の使用に対応した Cordova プロジェクトで使用するために、IBM 提供のプロジェクト・テンプレートを使用できます。 この {{ site.data.keys.product_adj }} テンプレートを使用する場合、開始点として以下のリソースが使用可能になります。 この {{ site.data.keys.product_adj }} テンプレートを使用しない場合、スプラッシュ画面とアイコンを除く、すべてのリソースが提供されます。 このテンプレートを追加するには、Cordova プロジェクトの初期作成時に `--template` オプションおよび {{ site.data.keys.product_adj }} テンプレートを指定します。

いずれかのリソースのデフォルトのファイル名とパスを変更する場合は、Cordova 構成ファイル (config.xml) 内でもその変更を指定する必要があります。 また、場合によっては、デフォルトの名前およびパスを mfpdev app config コマンドで変更できます。 mfpdev app config コマンドで名前およびパスを変更できる場合は、特定のリソースについてのセクションにその旨の注記があります。

### Cordova 構成ファイル (config.xml)
{: #cordova-configuration-file-configxml }
Cordova 構成ファイルは、アプリケーション・メタデータを含む必須の XML ファイルであり、アプリケーションのルート・ディレクトリーに保管されます。 このファイルは Cordova アプリケーションを作成すると自動的に生成されます。 mfpdev app config コマンドを使用して、このファイルを変更してカスタム・プロパティーを追加できます。

### メインファイル (index.html)
{: #main-file-indexhtml}
このメインファイルは、アプリケーション・スケルトンを含む HTML5 ファイルです。 このファイルは、アプリケーションの一般コンポーネントの定義および必要なドキュメント・イベントへの接続に必要なすべての Web リソース (スクリプトやスタイル・シートなど) をロードします。 このファイルは、**your-project-name/www** ディレクトリーにあります。 `mfpdev app config` コマンドを使用して、このファイルの名前を変更することができます。

### サムネール・イメージ
{: #thumbnail-image }
サムネール・イメージでは、{{ site.data.keys.mf_console }} でアプリケーションをグラフィカルに識別できます。 これは、正方形イメージでなければならず、推奨されるサイズは 90 x 90 ピクセルです。  
テンプレートを使用する場合、デフォルトのサムネール・イメージが提供されます。 このデフォルト・イメージを、同じファイル名を使用して別のイメージでオーバーライドして置き換えることができます。 thumbnail.png は、**your-project-name/www/img** フォルダーにあります。 `mfpdev app config` コマンドを使用して、このファイルの名前またはパスを変更することができます。

### スプラッシュ・イメージ
{: #splash-image }
スプラッシュ・イメージは、アプリケーションの初期化中に表示されます。 {{ site.data.keys.product_adj }} のデフォルト・テンプレートを使用する場合、スプラッシュ・イメージが提供されます。 これらのデフォルトのイメージは、以下のディレクトリーに保管されています。

* iOS: <your project name>/res/screen/ios/
* Android: <your project name>/res/screen/android/
* Windows: <your project name>/res/screen/windows/

各種のディスプレイに適したもの、iOS および Windows 向けのもの、異なるバージョンのオペレーティング・システム向けのものなど、さまざまなデフォルト・スプラッシュ・イメージが含まれています。 テンプレートで提供されているデフォルト・イメージを独自のスプラッシュ・イメージに置き換えることができます。また、テンプレートを使用していない場合は、イメージを追加できます。 {{ site.data.keys.product_adj }} テンプレートを使用して Android プラットフォーム用のアプリケーションをビルドした場合、**cordova-plugin-splashscreen** プラグインがインストールされます。 このプラグインが統合されている場合、{{ site.data.keys.product }} で使用されるイメージの代わりに、Cordova が使用するスプラッシュ・イメージが表示されます。 フォルダーに含まれている screen.png フォーマットのイメージは、Cordova 標準スプラッシュ・イメージです。 Cordova **config.xml** ファイルの設定を変更することで、表示するスプラッシュ・イメージを指定できます。

{{ site.data.keys.product_adj }} テンプレートを使用していない場合に表示されるデフォルト・スプラッシュ・イメージは、{{ site.data.keys.product }} プラグインで使用されるイメージです。 デフォルト {{ site.data.keys.product_adj }} ソース・スプラッシュ・イメージのファイル名の形式は、**splash-string.9.png** です。

> ユーザー独自のスプラッシュ・イメージの使用について詳しくは、[『Cordova アプリケーションへのカスタム・スプラッシュ画面およびアイコンの追加』](adding-images-and-icons)を参照してください。

### アプリケーション・アイコン
{: #application-icons }
アプリケーション・アイコン用のデフォルト・イメージがテンプレートで提供されます。 これらのデフォルトのイメージは、以下のディレクトリーに保管されています。

* iOS: <your project name>/res/icon/ios/
* Android: <your project name>/res/icon/android/
* Windows: <your project name>/res/icon/windows/

デフォルト・イメージを独自のイメージに置き換えることができます。 カスタム・アプリケーション・イメージは、置き換えようとしているデフォルトのアプリケーション・イメージのサイズと一致する必要があり、同じファイル名を使用する必要があります。 さまざまなディスプレイおよびオペレーティング・システム・バージョンに適した各種デフォルト・イメージが用意されています。

> ユーザー独自のスプラッシュ・イメージの使用について詳しくは、[『Cordova アプリケーションへのカスタム・スプラッシュ画面およびアイコンの追加』](adding-images-and-icons)を参照してください。

### スタイル・シート
{: #stylesheets }
アプリケーション・ビューを定義する CSS ファイルをアプリケーション・コードに組み込むことができます。

スタイルシート・ファイルは <your project name>/www/css ディレクトリーにあり、以下のプラットフォーム固有のフォルダーにコピーされます。

* iOS: <your project name>/platforms/ios/www/css
* Android: <your project name>/platforms/android/assets/www/css
* Windows: <your project name>/platforms/windows/www/css

### スクリプト
{: #scripts }
アプリケーションのさまざまな機能 (対話式ユーザー・インターフェース・コンポーネント、ビジネス・ロジック、バックエンド照会の統合など) を実装する JavaScript ファイルをアプリケーションに組み込むことができます。

JavaScript ファイル index.js がテンプレートによって提供され、**your-project-name/www/js** フォルダーに置かれます。 このファイルは、以下のプラットフォーム固有のフォルダーにコピーされます。

* iOS: <your project name>/platforms/ios/www/js
* Android: <your project name>/platforms/android/assets/www/js
* Windows: <your project name>/platforms/windows/assets/www/js

## アプリケーションの Web リソースのプレビュー
{: #previewing-an-applications-web-resources }
Cordova アプリケーションの Web リソースは、iOS シミュレーター、Android エミュレーター、Windows エミュレーター、または物理デバイスのいずれかでプレビューできます。 {{ site.data.keys.product }} では、{{ site.data.keys.mf_mbs_full }} と Simple Browser レンダリングの 2 つの追加のライブ・プレビュー・オプションを使用できます。

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **セキュリティー制限:** Web リソースはプレビュー可能ですが、そのシミュレーターですべての {{ site.data.keys.product_adj }} JavaScript API がサポートされているわけではありません。 特に、OAuth プロトコルは完全にはサポートされていません。 ただし、`WLResourceRequest` を使用したアダプターの呼び出しをテストすることはできます。 このケースでは、次のようになります。
>
> * セキュリティー検査はサーバー・サイドでは実行されず、セキュリティー・チャレンジは {{ site.data.keys.mf_mbs }} 内で実行されるクライアントに送信されません。
> * 開発環境で {{ site.data.keys.mf_server }} を使用しない場合、許可スコープのリスト中にアダプターのスコープが含まれている機密クライアントを登録してください。 機密クライアントは {{ site.data.keys.mf_console }} で「ランタイム/設定」メニューを使用して定義できます。 機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。
>
> **注:** 開発環境での {{ site.data.keys.mf_server }} には、無制限の許可スコープ (「*」) を持つ機密クライアント「test」が含まれています。 デフォルトで、mfpdev app preview はこの機密クライアントを使用します。

#### Simple Browser
{: #simple-browser }
Simple Browser プレビューでは、アプリケーションの Web リソースは、「アプリケーション」として扱われることなく、デスクトップ・ブラウザーでレンダリングされ、Web リソースのみの簡単なデバッグが可能です。  

#### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator }
{{ site.data.keys.mf_mbs }} は、エミュレーターまたは物理デバイスにアプリケーションをインストールすることなく、デバイス・フィーチャーをシミュレートすることによって Cordova アプリケーションをテストできるようにする Web アプリケーションです。

**サポートされるブラウザー:**

* Firefox バージョン 38 以降
* Chrome 49 以降
* Safari 9 以降

### プレビュー
{: #previewing }
1. **コマンド・ライン**・ウィンドウから、次のコマンドを実行します。

    ```bash
    mfpdev app preview
    ```

2. プレビュー・オプションを選択します。

    ```bash
    ? Select how to preview your app: (Use arrow keys)
    ❯ browser: Simple browser rendering
    mbs: Mobile Browser Simulator
    ```
3. プレビューするプラットフォームを選択します (追加されたプラットフォームのみが表示されます)。

    ```bash
    ❯◯ android
    ◯ ios
	```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **ヒント:** さまざまな CLI コマンドについて詳しくは、『[CLI を使用した {{ site.data.keys.product_adj }} 成果物の管理](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/)』チュートリアルを参照してください。

### ライブ・プレビュー
{: #live-preview }
ライブ・プレビューを使用して、応用コード (HTML、CSS、および JS) をリアルタイムで編集できるようになりました。   
リソースに変更を加えた後、変更を保存すると、その変更は即時にブラウザーで反映されます。

### ライブ再ロード
{: #live-reload }
物理デバイスまたはシミュレーター/エミュレーターでのプレビュー時に同様の効果を得るには、**cordova-plugin-livereload** プラグインを追加します。使用手順については、[プラグイン GitHub ページ](https://github.com/omefire/cordova-plugin-livereload)を参照してください。

### エミュレーターまたは物理デバイスでのアプリケーションの実行
{: #running-the-application-on-emulator-or-on-a-physical-device }
アプリケーションをエミュレートするには、Cordova CLI コマンド `cordova emulate ios|android|windows` を実行します。例えば、次のとおりです。

```bash
cordova emulate ios
```

開発ワークステーションに接続されている物理デバイス上でアプリケーションを実行するには、Cordova CLI コマンド `cordova run ios|android|windows` を実行します。例えば、次のとおりです。

```bash
cordova run ios
```

## JavaScript コードの実装
{: #implementing-javascript-code }
WebView リソースの編集は、JavaScript のオートコンプリートを可能にする IDE を使用すると便利です。

Xcode、Android Studio、および Visual Studio は、Objective C、Swift、C#、および Java を編集するための全編集機能を提供しますが、JavaScript の編集を支援する方法については制限される場合があります。 JavaScript の編集を容易にするため、{{ site.data.keys.product_adj }} Cordova プロジェクトには、{{ site.data.keys.product_adj }} API エレメントのオートコンプリートを提供する定義ファイルが含まれています。

各 {{ site.data.keys.product_adj }} Cordova プラグインは、{{ site.data.keys.product_adj }} JavaScript ファイルごとに `d.ts` 構成ファイルを提供します。`d.ts` ファイル名は対応する JavaScript ファイル名と一致し、プラグイン・フォルダー内にあります。例えば、メインの {{ site.data.keys.product_adj }} SDK の場合、このファイルは **[myapp]\plugins\cordova-plugin-mfp\typings\worklight.d.ts** です。

`d.ts` 構成ファイルは、TypeScript をサポートしているすべての IDE ([TypeScript Playground](http://www.typescriptlang.org/Playground/)、[Visual Studio Code](http://www.microsoft.com/visualstudio/eng)、[WebStorm](http://www.jetbrains.com/webstorm/)、[WebEssentials](http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f)、[Eclipse](https://github.com/palantir/eclipse-typescript)) に対してオートコンプリートを提供します。

WebView のリソース (HTML ファイルおよび JavaScript ファイル) は、**[myapp]\www** フォルダーにあります。プロジェクトを cordova build コマンドでビルドする場合、または cordova prepare コマンドを実行する場合、これらのリソースは、**[myapp]\platforms\ios\www** フォルダー、**[myapp]\platforms\android\assets\www** フォルダー、または **[myapp]\platforms\windows\www** フォルダー内の対応する **www** フォルダーにコピーされます。

前述の IDE の 1 つでメイン・アプリケーション・フォルダーを開くと、コンテキストが保持されます。 IDE エディターは関連する `d.ts` ファイルにリンクされるようになり、入力に応じて {{ site.data.keys.product_adj }} API エレメントをオートコンプリートします。

## Android 用の CrossWalk サポート
{: #crosswalk-support-for-android }
Android プラットフォーム用の Cordova アプリケーションでは、デフォルトの WebView を [CrossWalk WebView](https://crosswalk-project.org/) に置換できます。  
これを追加するには、以下のようにします。

1. **コマンド・ライン**行から次のコマンドを実行します。

   ```bash
   cordova plugin add cordova-plugin-crosswalk-webview
   ```

   このコマンドにより、アプリケーションに CrossWalk WebView が追加されます。  
{{ site.data.keys.product_adj }} Cordova SDK は、表に出ないところで、これを使用するように Android プロジェクト・アクティビティーを調整します。

2. 次のコマンドを実行して、プロジェクトをビルドします。

   ```bash
   cordova build
   ```

## iOS 用の WKWebView サポート
{: #wkwebview-support-for-ios }
Cordova iOS アプリケーションで使用されているデフォルトの UIWebView を、[Apple の WKWebView](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/) に置換できます。  
追加するには、コマンド・ライン・ウィンドウで `cordova plugin add cordova-plugin-wkwebview-engine` コマンドを実行します。

> 詳しくは、[Cordova WKWebView プラグイン](https://github.com/apache/cordova-plugin-wkwebview-engine)を参照してください。

## 参考文献
{: #further-reading }
Cordova についてさらに詳しく学習するには、以下を参照してください。

- [Cordova 概要](https://cordova.apache.org/docs/en/latest/guide/overview/index.html)
- [Cordova ベスト・プラクティス、テスト、デバッグ、考慮事項、および最新情報の入手](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)
- [Cordova アプリケーション開発の開始](https://cordova.apache.org/#getstarted)

## 次に使用するチュートリアル
{: #tutorials-to-follow-next }
[Cordova アプリケーションへの MobileFirst SDK の追加](../../application-development/sdk/cordova)から始めて、『[すべてのチュートリアル](../../all-tutorials/)』セクションで {{ site.data.keys.product_adj }} 提供のフィーチャーを検討します。
