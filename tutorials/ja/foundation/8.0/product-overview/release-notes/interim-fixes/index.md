---
layout: tutorial
title: 暫定修正の新機能
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
暫定修正では、問題を修正し、モバイル・オペレーティング・システムの新しいリリースに対して {{ site.data.keys.product_full }} を最新にしておくためのパッチおよび更新を提供します。

暫定修正は累積的です。 最新の V8.0 暫定修正をダウンロードすると、V8.0 より前の暫定修正のすべての修正が得られます。

以下のセクションに記載されているすべての修正を取得するには、最新の暫定修正をダウンロードしてインストールします。 最新より前の修正をインストールすると、ここで説明されている説明されている修正のすべては取得できない可能性があります。

> {{ site.data.keys.product }} 8.0 の暫定修正のリストは、[これらのブログ投稿を参照してください]({{site.baseurl}}/blog/tag/iFix_8.0/)。

APAR 番号がリストされている場合は、その APAR 番号について暫定修正の README ファイルを検索することで、暫定修正にその機能があるかどうかを確認できます。

### ライセンス交付
{: #licensing }
#### PVU ライセンス交付
{: #pvu-licensing }
新しいオファリングの {{ site.data.keys.product }} Extension V8.0.0 は、PVU (プロセッサー・バリュー・ユニット) ライセンス交付によって使用可能です。 {{ site.data.keys.product }} Extension の PVU ライセンス交付について詳しくは、[{{ site.data.keys.product_adj }} のライセンス交付](../../licensing)を参照してください。

### Web アプリケーション
{: #web-applications }
#### {{ site.data.keys.mf_cli }} からの Web アプリケーションの登録 (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
{{ site.data.keys.mf_console }} から登録する代わりの方法として、{{ site.data.keys.mf_cli }} (mfpdev) を使用して、クライアント Web アプリケーションを {{ site.data.keys.mf_server }} に登録できるようになりました。 詳しくは、『{{ site.data.keys.mf_cli }} からの Web アプリケーションの登録』を参照してください。

### Cordova アプリケーション
{: #cordova-applications }
#### Studio プラグインを使用して、Eclipse から Cordova プロジェクトのネイティブ IDE を開く
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Eclipse IDE にインストールされた Studio プラグインを使用して、既存の Cordova プロジェクトを Android Studio または Xcode に Eclipse インターフェースから開いて、プロジェクトのビルドと実行を行うことができます。

#### マイグレーション・アシスト・ツールを使用するときのオプションとして、*projectName* ディレクトリーが追加された
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
マイグレーション・アシスト・ツールを使用してプロジェクトをマイグレーションするときに、Cordova プロジェクト・ディレクトリーの名前を指定できます。 名前を指定しない場合、デフォルト名は *app_name-app_id-version* です。

#### マイグレーション・アシスト・ツールのユーザビリティーの向上
{: #usability-improvements-to-the-migration-assistance-tool }
マイグレーション・アシスト・ツールのユーザビリティーを向上させるために、以下の変更が行われました。

* マイグレーション・アシスト・ツールは、HTML ファイルと JavaScript ファイルをスキャンします。
* スキャンが終了すると、スキャン・レポートが自動的にデフォルトのブラウザーに開きます。
* *--out* フラグはオプションです。 これが指定されていなければ、作業ディレクトリーが使用されます。
* *--out* フラグが指定され、そのディレクトリーが存在しなければ、そのディレクトリーが作成されます。

### アダプター
{: #adapters }
#### Java および JavaScript のアダプター構成用に、`mfpdev push` コマンドと `pull` コマンドが追加された
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
{{ site.data.keys.mf_cli }} を使用して、Java および JavaScript のアダプター構成を {{ site.data.keys.mf_server }} にプッシュしたり、アダプター構成を {{ site.data.keys.mf_server }} からプルしたりできます。

### Application Center
{: #application-center}

iOS および Android 用の Cordova ベースの Application Center クライアントを使用できます。
