---
layout: tutorial
title: MobileFirst CLI を使用した MobileFirst 成果物の管理
breadcrumb_title: MobileFirst CLI の使用
weight: 2
relevantTo: [ios,android,windows,javascript]
---
## 概説
{: #overview }
{{ site.data.keys.product_full }} には、クライアント成果物およびサーバー成果物を簡単に管理するための、開発者向けのコマンド・ライン・インターフェース (CLI) ツール **mfpdev** が用意されています。  
この CLI を使用して、{{ site.data.keys.product_adj }} Cordova プラグインを使用した Cordova ベースのアプリケーション、および {{ site.data.keys.product_adj }} ネイティブ SDK を使用したネイティブ・アプリケーションを管理できます。

ローカルまたはリモートの {{ site.data.keys.mf_server }} インスタンスに対するアダプターを作成、登録、管理し、コマンド・ラインから、あるいは REST サービス経由で、あるいは {{ site.data.keys.mf_console }} から、プロジェクトを管理することもできます。

**mfpdev** コマンドには、対話モードと直接モードの 2 つのモードがあります。対話モードでは、オプションを指定せずにコマンドを入力すると、応答を求めるプロンプトが出されます。直接モードでは、オプションも含めて完全なコマンドを入力します。プロンプトは出されません。該当する場合、プロンプトは、アプリケーションのターゲット・プラットフォーム (コマンドを実行したディレクトリーによって判別される) のコンテキストに依存したものになります。キーボードの上下矢印キーを使用して選択項目間を移動し、目的の選択項目が強調表示され、その前に「>」という 文字が表示されたら、Enter キーを押します。

このチュートリアルでは、`mfpdev` コマンド・ライン・インターフェース (CLI) のインストール方法と、この CLI を使用して {{ site.data.keys.mf_server }} のインスタンス、アプリケーション、およびアダプターを管理する方法について学習します。

> Cordova アプリケーションおよびネイティブ・アプリケーションとの SDK の統合について詳しくは、[{{ site.data.keys.product }} SDK の追加](../../application-development/sdk/)カテゴリーのチュートリアルを参照してください。

#### ジャンプ先
{: #jump-to }
* [前提条件](#prerequisites)
* [{{ site.data.keys.mf_cli }}](#installing-the-mobilefirst-cli) のインストール
* [CLI コマンドのリスト](#list-of-cli-commands)
* [対話モードと直接モード](#interactive-and-direct-modes)
* [{{ site.data.keys.mf_server }} インスタンスの管理](#managing-mobilefirst-server-instances)
* [アプリケーションの管理](#managing-applications)
* [アダプターの管理とテスト](#managing-and-testing-adapters)
* [役立つコマンド](#helpful-commands)
* [コマンド・ライン・インターフェースの更新とアンインストール](#update-and-uninstall-the-command-line-interface)

## 前提条件
{: #prerequisites }
{{ site.data.keys.mf_cli }} は、NPM パッケージとして [NPM レジストリー](https://www.npmjs.com/)で入手できます。  

NPM パッケージをインストールするため、開発環境に **node.js** がインストールされていることを確認します。  
[nodejs.org](https://nodejs.org) のインストール手順に従って、node.js をインストールします。

node.js が正しくインストールされていることを確認するには、コマンド `node -v` を実行します。

```bash
node -v
v4.2.3
```

> **注:** サポートされている node.js の最小バージョンは 4.2.3 です。

## {{ site.data.keys.mf_cli }} のインストール
{: #installing-the-mobilefirst-cli }
コマンド・ライン・インターフェースをインストールするには、次のコマンドを実行します。

```bash
npm install -g mfpdev-cli
```

CLI の .zip ファイルを {{ site.data.keys.mf_console }} のダウンロード・センターからダウンロードした場合は、次のコマンドを使用します。

```bash
npm install -g <path-to-mfpdev-cli.tgz>
```

- オプションの従属関係を含めずに CLI をインストールするには、`--no-optional` フラグを追加して、次のようにします。`npm install -g --no-optional path-to-mfpdev-cli.tgz`

インストールを確認するには、引数を付けずに `mfpdev` コマンドを実行します。次のようなヘルプ・テキストが表示されます。

```shell
NAME
     IBM MobileFirst Foundation Command Line Interface (CLI).

SYNOPSIS
     mfpdev <command> [options]

DESCRIPTION
     The IBM MobileFirst Foundation Command Line Interface (CLI) is a command-line
     for developing MobileFirst applications. The command-line can be used by itself, or in conjunction
     with the IBM MobileFirst Foundation Operations Console. Some functions are available from  
     the command-line only and not the console.

     For more information and a step-by-step example of using the CLI, see the IBM Knowledge Center for
     your version of IBM MobileFirst Foundation at

          https://www.ibm.com/support/knowledgecenter.
    ...
    ...
    ...
```

## CLI コマンドのリスト
{: #list-of-cli-commands }

| コマンド接頭部                                                | コマンド・アクション                               | 説明                                                             |
|---------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------|
| `mfpdev app`	                                                | register                                     | アプリケーションを {{ site.data.keys.mf_server }} に登録します。                           |
|                                                               | config                                       | アプリケーションで使用するバックエンド・サーバーおよびランタイムを指定できます。さらに、Cordova アプリケーションの場合、システム・メッセージのデフォルト言語やチェックサム・セキュリティー検査を実行するかどうかなどのさまざまな側面も構成できます。Cordova アプリケーションでは、その他の構成パラメーターが含まれます。                                                                                                                                                |
|                                                               | pull                                         | サーバーから既存のアプリケーション構成を取得します。                |
|                                                               | push                                         | アプリケーションの構成をサーバーに送信します。                             |
|                                                               | preview                                      | ターゲット・プラットフォーム・タイプの実際のデバイスがなくても Cordova アプリケーションをプレビューできます。{{ site.data.keys.mf_mbs }}か Web ブラウザーのいずれかでプレビューを表示できます。                                                                               |
|                                                               | webupdate                                    | www ディレクトリーに入っているアプリケーション・リソースを、ダイレクト・アップデート・プロセスで使用できる .zip ファイルにパッケージします。                                                                                                                                     |
| mfpdev server	                                                | info                                         | {{ site.data.keys.mf_server }} に関する情報を表示します。                      |
|                                                               | add                                          | 新規サーバー定義を環境に追加します。                        |
|                                                               | edit                                         | サーバー定義を編集できます。                                |
|                                                               | remove                                       | サーバー定義を環境から削除します。                      |
|                                                               | console                                      | {{ site.data.keys.mf_console }} を開きます。                               |
|                                                               | clean                                        | アプリケーションを登録抹消し、アダプターを {{ site.data.keys.mf_server }} から削除します。      |
| mfpdev adapter                                                | create                                       | アダプターを作成します。                                                     |
|                                                               | build                                        | アダプターをビルドします。                                                      |
|                                                               | build all                                    | 現行ディレクトリーおよびそのサブディレクトリー内にあるすべてのアダプターを検出してビルドします。 |
|                                                               | deploy                                       | アダプターを {{ site.data.keys.mf_server }} にデプロイします。                           |
|                                                               | deploy all                                   | 現行ディレクトリーおよびそのサブディレクトリー内にあるすべてのアダプターを検出して、{{ site.data.keys.mf_server }} にそれらをデプロイします。 |
|                                                               | call                                         | {{ site.data.keys.mf_server }} でアダプターのプロシージャーを呼び出します。                 |
|                                                               | pull                                         | サーバーから既存のアダプター構成を取得します。                |
|                                                               | push                                         | アダプターの構成をサーバーに送信します。                             |
| mfpdev                                                        | config                                       | mfpdev コマンド・ライン・インターフェースのプレビュー・ブラウザー・タイプ、プレビュー・タイムアウト値、およびサーバー・タイムアウト値の構成設定を指定します。                                                                                                                   |
|                                                               | info                                         | オペレーティング・システム、メモリー使用量、ノード・バージョン、コマンド・ライン・インターフェースのバージョンなど、環境に関する情報を表示します。現行ディレクトリーが Cordova アプリケーションである場合、Cordova cordova info コマンドで提供される情報も表示されます。 |
|                                                               | -v                                           | 現在使用されている {{ site.data.keys.mf_cli }} のバージョン番号を表示します。 |
|                                                               | -d, --debug                                  | デバッグ・モード: デバッグ出力を生成します。                                      |
|                                                               | -dd, --ddebug                                | 冗長デバッグ・モード: 冗長デバッグ出力を生成します。                      |
|                                                               | -no-color                                    | コマンド出力でのカラーの使用を抑止します。                              |
| mfpdev help                                                   | コマンドの名前                              | {{ site.data.keys.mf_cli }} (mfpdev) コマンドのヘルプを表示します。引数を指定した場合、各コマンド・タイプまたはコマンドに関するより具体的なヘルプ・テキストを表示します。例: 「mfpdev help server add」 |

## 対話モードと直接モード
{: #interactive-and-direct-modes }
すべてのコマンドは、**対話モード**または**直接モードで実行できます。**。対話モードでは、そのコマンドに必要なパラメーターの入力を求めるプロンプトが出され、いくつかのデフォルト値が使用されます。直接モードでは、実行するコマンドと一緒にパラメーターを指定する必要があります。

例:

対話モードでの `mfpdev server add`:

```bash
? Enter the name of the new server definition: mydevserver
? Enter the fully qualified URL of this server: http://mydevserver.example.com:9080
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the admin password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'mydevserver' added successfully.
```
同じコマンドが直接モードでは次のようになります。

```bash
mfpdev server add mydevserver --url http://mydevserver.example.com:9080 --login admin --password admin --setdefault
```

直接モードでのコマンドの正しい構文を見るには、`mfpdev help < コマンドを使用します。>`.


## {{ site.data.keys.mf_server }} インスタンスの管理
{: #managing-mobilefirst-server-instances }
`mfpdev server <option>` コマンドを使用すると、現在使用中の {{ site.data.keys.mf_server }} インスタンスを管理できます。常に、少なくとも 1 つのサーバー・インスタンスがデフォルト・インスタンスとしてリストされている必要があります。別のサーバーが指定されなかった場合は、常にデフォルト・サーバーが使用されます。

### サーバー・インスタンスのリスト
{: #list-server-instances }
使用可能なすべての {{ site.data.keys.mf_server }} インスタンスをリストするには、次のコマンドを実行します。

```bash
mfpdev server info
```

デフォルトでは、CLI によってローカル・サーバー・プロファイルが自動的に作成され、現行のデフォルトとして使用されます。

### 新規サーバー・インスタンスの追加
{: #add-a-new-server-instance }
ローカルまたはリモートの {{ site.data.keys.mf_server }} インスタンスをさらに使用する場合、次のコマンドを使用して、使用可能なインスタンスのリストに、そのインスタンスを追加できます。

```bash
mfpdev server add
```

対話式プロンプトに従って、サーバーの名前、サーバー URL、およびユーザー/パスワード資格情報を指定します。  
例えば、Mobile Foundation Bluemix サービス上で稼働している {{ site.data.keys.mf_server }} を追加するには、次のようにします。

```bash
$ mfpdev server add
? Enter the name of the new server profile: MyBluemixServer
? Enter the fully qualified URL of this server: https://mobilefoundation-7abcd-server.mybluemix.net:443
? Enter the {{ site.data.keys.mf_server }} administrator login ID: admin
? Enter the {{ site.data.keys.mf_server }} administrator password: *****
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the {{ site.data.keys.mf_server }} connection timeout in seconds: 30
? Make this server the default?: Yes
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyBluemixServer' added successfully. 
```

- 「fully qualified URL of this server」は、使用するサーバーの URL に置き換えてください。

### サーバー・インスタンスの編集
{: #edit-server-instances }
登録済みのサーバー・インスタンスの詳細を編集する必要がある場合は、次のコマンドを実行し、対話式プロンプトに従って、編集するサーバーを選択し、どういった情報に更新するのかを指定します。

```bash
mfpdev server edit
```

デフォルトのサーバーを設定するには、次のコマンドを使用します。

```bash
mfpdev server edit <server_name> --setdefault
```

### サーバー・インスタンスの削除
{: #remove-server-instances }
登録済みサーバーのリストからサーバー・インスタンスを削除するには、次のコマンドを実行します。

```bash
mfpdev server remove
```

その後、対話式リストから目的のサーバーを選択します。

### {{ site.data.keys.mf_console }} を開く
{: #open-mobilefirst-operations-console }
登録済みデフォルト・サーバーのコンソールを開くには、次のコマンドを実行します。

```bash
mfpdev server console
```

別のサーバーのコンソールを開くには、次のように、コマンドのパラメーターとしてサーバー名を指定します。

```bash
mfpdev server console <server_name>
```

### サーバーからのアプリケーションとアダプターの削除
{: #remove-apps-and-adapters-from-a-server }
サーバーに登録済みのアプリケーションとアダプターをすべて削除するには、次のコマンドを実行します。

```bash
mfpdev server clean
```

その後、対話式プロンプトから、クリーンアップするサーバーを選択します。  
これで、そのサーバー・インスタンスは、どんなアプリケーションもアダプターもデプロイされていない、クリーンな状態になります。

## アプリケーションの管理
{: #managing-applications }
コマンド `mfpdev app <option>` を使用すると、{{ site.data.keys.product }} SDK を使用して作成されたアプリケーションの管理を行うことができます。

### サーバー・インスタンスへのアプリケーションの登録
{: #register-an-application-in-a-server-instance }
実行の準備の整ったアプリケーションは、{{ site.data.keys.mf_server }} に登録する必要があります。  
アプリケーションを登録するには、そのアプリケーション・プロジェクトのルート・フォルダーから次のコマンドを実行します。

```bash
mfpdev app register
```

このコマンドは、Cordova アプリケーション、Android アプリケーション、iOS アプリケーション、または Windows アプリケーションのルートから実行できます。  
このコマンドは、デフォルトのサーバーとランタイムを使用して次のタスクを実行します。

* アプリケーションをサーバーに登録する。
* アプリケーション用のデフォルトのクライアント・プロパティー・ファイルを生成する。
* サーバー情報をこのクライアント・プロパティー・ファイルに含める。

Cordova アプリケーションの場合は、このコマンドにより config.xml ファイルが更新されます。  
iOS アプリケーションの場合は、このコマンドにより mfpclient.plist ファイルが更新されます。  
Android アプリケーションまたは Windows アプリケーションの場合は、このコマンドにより mfpclient.properties ファイルが更新されます。

デフォルトではないサーバーおよびランタイムにアプリケーションを登録するには、次の構文を使用します。

```
mfpdev app register <server> <runtime>
```

Cordova Windows プラットフォームの場合は、`-w <platform>` 引数をコマンドに追加する必要があります。`<platform>` 引数は、登録する Windows プラットフォームのコンマ区切りリストです。有効値は、`windows`、`windows8`、および `windowsphone8` です。

```
mfpdev app register -w windows8
```

### アプリケーションの構成
{: #configure-an-application }
アプリケーションが登録されると、その構成ファイルにサーバー関連の属性が追加されます。  
これらの属性の値を変更するには、次のコマンドを実行します。

```bash
mfpdev app config
```

このコマンドを実行すると、変更できる属性のリストが対話式に提示され、当該属性の新規値を求めるプロンプトが出されます。  
使用可能な属性は、各プラットフォーム (iOS、Android、Windows) ごとに異なります。

使用可能な構成は次のとおりです。

* アプリケーションの登録先となるサーバー・アドレスおよびサーバー・ランタイム

    > **ユース・ケースの例:** アプリケーションを、ある特定のアドレスを持つ {{ site.data.keys.mf_server }} に登録するが、さらにそのアプリケーションが異なるサーバー・アドレス (DataPower アプライアンスなど) に接続するように設定する場合は、次のようにします。
    >
    > 1. `mfpdev app register` を実行して、アプリケーションを目的の {{ site.data.keys.mf_server }} アドレスに登録します。
    > 2. `mfpdev app config` を実行し、**server** プロパティーの値を、DataPower アプライアンスのアドレスと一致するように変更します。また、このコマンドを**直接モード**で、次のように実行することもできます: `mfpdev app config server http(s)://server-ip-or-host:port`

* ダイレクト・アップデートの認証性フィーチャー用の公開鍵の設定 
* アプリケーションのデフォルト言語の設定 (デフォルトは英語 (en))
* Web リソース・チェックサム・テストを有効にするかどうか
* Web リソース・チェックサム・テストで無視するファイル拡張子

<div class="panel-group accordion" id="app-config" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="app-config-options">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>Web リソース・チェックサムの設定に関する追加情報</b></a>
            </h4>
        </div>

        <div id="collapse-app-config-options" class="panel-collapse collapse" role="tabpanel" aria-labelledby="app-config-options">
            <div class="panel-body">
                <p>Web リソース・チェックサムの設定については、使用可能なターゲット・プラットフォーム (Android、iOS、Windows 8、Windows Phone 8、Windows 10 UWP) ごとに、<b>mfpdev</b> 直接モードで使用するためのプラットフォーム固有の鍵があります。これらの鍵は、プラットフォーム名を表すストリングで始まります。例えば、<code>windows10_security_test_web_resources_checksum</code> は、Windows10 UWP で Web リソース・チェックサム・テストを有効にするかどうかを指定する true/false 設定です。</p>
                
                <table class="table table-striped">
                    <tr>
                        <td><b>設定</b></td>
                        <td><b>説明</b></td>
                    </tr>
                    <tr>
                        <td><code>direct_update_authenticity_public_key</code></td>
                        <td>ダイレクト・アップデート認証の公開鍵を指定します。鍵は Base64 形式でなければなりません。</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_test_web_resources_checksum</code></td>
                        <td><code>true</code> に設定した場合、iOS Cordova アプリケーションに対する Web リソース・チェックサムのテストが有効になります。デフォルトは <code>false</code> です。</td>
                    </tr>
                    <tr>
                        <td><code>android_security_test_web_resources_checksum</code></td>
                        <td><code>true</code> に設定した場合、Android Cordova アプリケーションに対する Web リソース・チェックサムのテストが有効になります。デフォルトは <code>false</code> です。</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_test_web_resources_checksum</code></td>
                        <td><code>true</code> に設定した場合、Windows 10 UWP Cordova アプリケーションに対する Web リソース・チェックサムのテストが有効になります。デフォルトは <code>false</code> です。</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_test_web_resources_checksum</code></td>
                        <td><code>true</code> に設定した場合、Windows 8.1 Cordova アプリケーションに対する Web リソース・チェックサムのテストが有効になります。デフォルトは <code>false</code> です。</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_test_web_resources_checksum</code></td>
                        <td><code>true</code> に設定した場合、Windows Phone 8.1 Cordova アプリケーションに対する Web リソース・チェックサムのテストが有効になります。デフォルトは <code>false</code> です。</td>
                    </tr>
                    <tr>
                        <td><code>ios_security_ignore_file_extensions</code></td>
                        <td>iOS Cordova アプリケーションに対する Web リソース・チェックサム・テスト時に無視するファイル拡張子を指定します。複数の拡張子はコンマで区切って指定します。例えば、jpg,gif,pdf などです。</td>
                    </tr>
                    <tr>
                        <td><code>android_security_ignore_file_extensions</code></td>
                        <td>Android Cordova アプリケーションに対する Web リソース・チェックサム・テスト時に無視するファイル拡張子を指定します。複数の拡張子はコンマで区切って指定します。例えば、jpg,gif,pdf などです。</td>
                    </tr>
                    <tr>
                        <td><code>windows10_security_ignore_file_extensions</code></td>
                        <td>Windows 10 UWP Cordova アプリケーションに対する Web リソース・チェックサム・テスト時に無視するファイル拡張子を指定します。複数の拡張子はコンマで区切って指定します。例えば、jpg,gif,pdf などです。</td>
                    </tr>
                    <tr>
                        <td><code>windows8_security_ignore_file_extensions</code></td>
                        <td>Windows 8.1 Cordova アプリケーションに対する Web リソース・チェックサム・テスト時に無視するファイル拡張子を指定します。複数の拡張子はコンマで区切って指定します。例えば、jpg,gif,pdf などです。</td>
                    </tr>
                    <tr>
                        <td><code>windowsphone8_security_ignore_file_extensions</code></td>
                        <td>Windows Phone 8.1 Cordova アプリケーションに対する Web リソース・チェックサム・テスト時に無視するファイル拡張子を指定します。複数の拡張子はコンマで区切って指定します。例えば、jpg,gif,pdf などです。</td>
                    </tr>
                </table>
 
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#app-config-options" data-target="#collapse-app-config-options" aria-expanded="false" aria-controls="collapse-app-config-options"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>


### Cordova アプリケーションのプレビュー
{: #preview-a-cordova-application }
ブラウザーを使用して Cordova アプリケーションの Web リソースをプレビューすることができます。アプリケーションをプレビューすることで、ネイティブ・プラットフォーム固有のエミュレーターやシミュレーターを使用することなく、迅速な開発が可能になります。

プレビュー・コマンドを実行する前に、`wlInitOptions` 変数を追加することによってそのプロジェクトを準備する必要があります。以下のステップを実行します。

1. *wlInitOptions* 変数を、メインの JavaScript ファイル (標準 Cordova アプリケーション内の **index.js**) に追加します。

   ```javascript
   var wlInitOptions = {
      mfpContextRoot:'/mfp', // "mfp" is the default context root of {{ site.data.keys.mf_server }}
      applicationId:'com.sample.app' // Replace with your own value.
   };
   ```

2. 次のコマンドを使用して、アプリケーションを再度登録します。

   ```bash
   mfpdev app register
   ```

 3. 以下のコマンドを実行します。
 
    ```bash
    cordova prepare
    ```

 4. 次のコマンドを Cordova アプリケーションのルート・フォルダーから実行することで、Cordova アプリケーションをプレビューします。

    ```bash
    mfpdev app preview
    ```

どのプラットフォームをプレビューし、どのタイプのプレビューを使用するかを選択するためのプロンプトが出されます。
プレビューのオプションには、MBS とブラウザーの 2 つがあります。

* MBS: {{ site.data.keys.mf_mbs }}。この方式は、ブラウザーでモバイル・デバイスをシミュレートするだけでなく、カメラ、ファイルのアップロード、地理位置情報など、基本的な Cordova API のシミュレーションも提供します。注: MBS オプションでは Cordova Browser は使用できません。
* ブラウザー: Simple Browser レンダリング。この方式は、Cordova アプリケーションの www リソースを、通常のブラウザーの Web ページとして表現します。

> プレビュー・オプションについて詳しくは、[Cordova 開発のチュートリアル](../cordova-apps)を参照してください。

### ダイレクト・アップデートでの Web リソースの更新
{: #update-web-resources-for-direct-update }
モバイル・デバイスでアプリケーションを再インストールしなくても、Cordova アプリケーションの Web リソース (**www** フォルダー内にある .html ファイル、.css ファイル、.js ファイルなど) を更新できます。これは、{{ site.data.keys.product }} によって提供されるダイレクト・アップデート・フィーチャーによって可能になります。

> ダイレクト・アップデートがどのように機能するかについて詳しくは、チュートリアル[Cordova アプリケーションでのダイレクト・アップデートの使用](../direct-update)を参照してください。

更新対象の Web リソースの新規セットを Cordova アプリケーションに送信するには、次のコマンドを実行します。

```bash
mfpdev app webupdate
```

このコマンドにより、更新された Web リソースが .zip ファイルにパッケージ化され、登録済みのデフォルトの {{ site.data.keys.mf_server }} にアップロードされます。パッケージ化された Web リソースは、**[cordova-project-root-folder]/mobilefirst/** フォルダー内にあります。

Web リソースを別のサーバー・インスタンスにアップロードするには、コマンドの一部としてサーバー名とランタイムを指定します。

```bash
mfpdev app webupdate <server_name> <runtime>
```

--build パラメーターを使用すると、パッケージ化された Web リソースが含まれた .zip ファイルを、サーバーにアップロードすることなく生成できます。

```bash
mfpdev app webupdate --build
```

以前にビルド済みのパッケージをアップロードするには、--file パラメーターを使用します。

```bash
mfpdev app webupdate --file mobilefirst/com.ibm.test-android-1.0.0.zip
```

--encrypt パラメーターを使用してパッケージの内容を暗号化するという選択肢もあります。

```bash
mfpdev app webupdate --encrypt
```

### {{ site.data.keys.product_adj }} アプリケーション構成のプルおよびプッシュ
{: #pull-and-push-the-mobilefirst-application-configuration }
{{ site.data.keys.product_adj }} アプリケーションを {{ site.data.keys.mf_server }} に登録したら、{{ site.data.keys.mf_server }} Console を使用してアプリケーション構成の一部を変更し、それらの構成を、次のコマンドでサーバーからアプリケーションにプルすることができます。

```bash
mfpdev app pull
```

また、アプリケーション構成をローカルに変更して、次のコマンドで変更を {{ site.data.keys.mf_server }} にプッシュすることもできます。

```bash
mfpdev app push
```

**例:** {{ site.data.keys.mf_console }} でセキュリティー検査へのスコープ・マッピングを実行した後、上記のコマンドを使用してサーバーからプルすることができます。ダウンロードした .zip ファイルは、プロジェクトの **[root directory]/mobilefirst** フォルダーに保管されるので、後でこれを `mfpdev app push` コマンドを使用して別の {{ site.data.keys.mf_server }} にアップロードすることができます。このように、事前に定義済みの構成を再利用することで、迅速な構成とセットアップが可能になります。

## アダプターの管理とテスト
{: #managing-and-testing-adapters }
コマンド `mfpdev adapter <option>`を使用してアダプターを管理できます。

> アダプターについて詳しくは、[アダプター](../../adapters/)・カテゴリーのチュートリアルを参照してください。


### アダプターの作成
{: #create-an-adapter }
新規アダプターを作成するには、次のコマンドを使用します。

```bash
mfpdev adapter create
```

次に、プロンプトに従って、アダプターの名前、タイプ、およびグループ ID を指定します。

### アダプターのビルド
{: #build-an-adpater }
アダプターをビルドするには、アダプターのルート・フォルダーから以下のコマンドを実行します。

```bash
mfpdev adapter build
```

これにより、**<AdapterName>/target** フォルダーに .adapter ファイルが作成されます。

### アダプターのデプロイ
{: #deploy-an-adapter}
次のコマンドを実行すると、デフォルト・サーバーにアダプターがデプロイされます。

```bash
mfpdev adapter deploy
```

別のサーバーにデプロイするには、次のコマンドを使用します。

```bash
mfpdev adapter deploy <server_name>
```

### コマンド・ラインからのアダプターの呼び出し
{: #call-an-adapter-from-the-command-line }
アダプターをデプロイしたら、次のコマンドを使用して、アダプターをコマンド・ラインから呼び出してその動作をテストすることができます。

```bash
mfpdev adapter call
```

使用するアダプター、プロシージャー、およびパラメーターを指定するよう求めるプロンプトが出されます。コマンドの実行結果として、アダプター・プロシージャーの応答が出力されます。

> 詳しくは、[アダプターのテストおよびデバッグ](../../adapters/testing-and-debugging-adapters/)に関するチュートリアルを参照してください。

## 役立つコマンド
{: #helpful-commands }
デフォルトのブラウザーやデフォルトのプレビュー・モードなど、mfpdev CLI の環境を設定するには、次のコマンドを使用します。

```bash
mfpdev config
```

全 mfpdev コマンドが記述されたヘルプ・コンテンツを参照するには、次のコマンドを使用します。

```bash
mfpdev help
```

次のコマンドを実行すると、ご使用の環境に関する情報が含まれたリストが生成されます。

```bash
mfpdev info
```

mfpdev CLI のバージョンを出力するには、次のコマンドを使用します。

```bash
mfpdev -v
```

## コマンド・ライン・インターフェースの更新とアンインストール
{: #update-and-uninstall-the-command-line-interface }
コマンド・ライン・インターフェースを更新するには、次のコマンドを実行します。

```bash
npm update -g mfpdev-cli
```

コマンド・ライン・インターフェースをアンインストールするには、次のコマンドを実行します。

```bash
npm uninstall -g mfpdev-cli
```
