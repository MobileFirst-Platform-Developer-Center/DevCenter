---
layout: tutorial
title: 端末を介したアプリケーション管理
breadcrumb_title: Administrating using terminal
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**mfpadm** プログラムを通じて {{ site.data.keys.product_adj }} アプリケーションを管理することができます。

>**8.0.0.0-MFPF-IF201701250919** より後の {{ site.data.keys.product_full }} SDK バージョンでは、アプリ認証性サポートが更新されています。これは、`dynamic` と `static` の検証を切り替えて、さらにこれをリセットする `mfpadm` コマンドです。
>
{{ site.data.keys.product_full }} インストール・ディレクトリー `/MobilefirstPlatformServer/shortcuts` にナビゲートして、`mfpadm` コマンドを実行します。
>
1. 検証タイプを切り替えるには、次のように入力します。
```bash
	mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] set authenticity-validation TYPE
```  
*TYPE* の値には `static` または `dynamic` を指定できます。
>
Android の場合の例: 以下では、検証 TYPE を `dynamic` に設定します。
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp test android 1.0 set authenticity-validation dynamic
```
>
2. アプリの指紋をクリアする以下のコマンドを使用してデータをリセットするには、次のように入力します。
```bash
  mfpadm --url=  --user=  --passwordfile= --secure=false app version [RUNTIME] [APPNAME] [ENVIRONMENT] [VERSION] reset authenticity
```
例 :
>
```bash
  mfpadm --url=http://localhost:8080/mfpadmin --user=admin --passwordfile="C:\userhome\mfppassword\MFP_password.txt" --secure=false app version mfp sample.com.pincodeandroid android 1.0 reset authenticity
```

#### ジャンプ先
{: #jump-to }

* [他の機能との比較](#comparison-with-other-facilities)
* [前提条件](#prerequisites)

## 他の機能との比較
{: #comparison-with-other-facilities }
{{ site.data.keys.product_full }} の管理操作は、以下の方法で実行できます。

* {{ site.data.keys.mf_console }}。対話式です。
* mfpadm Ant タスク。
* **mfpadm** プログラム。
* {{ site.data.keys.product_adj }} 管理 REST サービス。

**mfpadm** Ant タスク、mfpadm プログラム、および REST サービスは、次のようなユース・ケースの自動化または無人実行に便利です。

* 繰り返しの多い操作でオペレーターのエラーを防止する。
* オペレーターの通常の作業時間外に操作を行う。
* テスト・サーバーまたは実動前サーバーと同じ設定で実動サーバーを構成する。

**mfpadm** プログラムと mfpadm Ant タスクは、REST サービスよりも使い方が簡単で、エラー・レポートも充実しています。 mfpadm Ant タスクよりも mfpadm プログラムが優れている点は、オペレーティング・システム・コマンドとの統合がすでに使用可能なときに、統合がより容易であることです。 また、対話式の使用にも、より適しています。

## 前提条件
{: #prerequisites }
**mfpadm** ツールは、{{ site.data.keys.mf_server }} インストーラーを使用してインストールされます。 このページの残りの部分では、**product\_install\_dir** は {{ site.data.keys.mf_server }} インストーラーのインストール・ディレクトリーを示します。

**mfpadm** コマンドは、スクリプトのセットとして **product\_install\_dir/shortcuts/** ディレクトリーにあります。

* mfpadm (UNIX / Linux の場合)
* mfpadm.bat (Windows の場合)

これらのスクリプトはいつでも実行できる状態にあります。つまり、特定の環境変数を必要としないということです。 環境変数 **JAVA_HOME** が設定された場合、スクリプトはこれを受け入れます。  
**mfpadm** プログラムを使用するには、PATH 環境変数に **product\_install\_dir/shortcuts/** ディレクトリーを組み込むか、各呼び出しでプログラムの絶対ファイル名を参照します。

{{ site.data.keys.mf_server }} インストーラーの実行について詳しくは、[IBM インストール・マネージャーの実行 (Running IBM Installation Manager) ](../../installation-configuration/production/installation-manager/)を参照してください。

#### ジャンプ先
{: #jump-to-1 }

* [**mfpadm** プログラムの呼び出し](#calling-the-mfpadm-program)
* [一般構成用のコマンド](#commands-for-general-configuration)
* [アダプター用のコマンド](#commands-for-adapters)
* [アプリケーション用のコマンド](#commands-for-apps)
* [デバイス用のコマンド](#commands-for-devices)
* [トラブルシューティング用のコマンド](#commands-for-troubleshooting)


### **mfpadm** プログラムの呼び出し
{: #calling-the-mfpadm-program }
**mfpadm** プログラムを使用して、{{ site.data.keys.product_adj }} アプリケーションを管理することができます。

#### 構文
{: #syntax }
次のようにして mfpadm プログラムを呼び出します。

```bash
mfpadm --url= --user= ... [--passwordfile=...] [--secure=false] some command
```

**mfpadm** プログラムには、以下のオプションがあります。

| オプション	| タイプ | 説明 | 必須 | デフォルト |
|-----------|------|-------------|----------|---------|
| --url | 	 | URL | 管理サービスの {{ site.data.keys.product_adj }} Web アプリケーションのベース URL | はい | |
| --secure	 | ブール値 | セキュリティー・リスクをともなう操作を回避するかどうか | いいえ | true |
| --user	 | 名前 | {{ site.data.keys.product_adj }} 管理サービスにアクセスするためのユーザー名 | はい |  | 	 
| --passwordfile | ファイル| ユーザーのパスワードを含むファイル | いいえ |
| --timeout	     | 数値  | REST サービス・アクセス全体のタイムアウト (秒単位) | いいえ | 	 
| --connect-timeout | 数値 | ネットワーク接続確立のタイムアウト (秒単位) | いいえ |
| --socket-timeout  | 数値 | ネットワーク接続の損失検出のタイムアウト (秒単位) | いいえ |
| --connection-request-timeout | 数値	接続要求プールからのエントリー取得のタイムアウト (秒単位) | いいえ |
| --lock-timeout | 数値 | ロック取得のタイムアウト (秒単位) | いいえ | 2 |
| --verbose	     | 詳細出力 | いいえ	| |  

**url**  
URL には、HTTPS プロトコルを使用することを推奨します。 例えば、デフォルト・ポートとコンテキスト・ルートを使用する場合、次の URL を使用します。

* WebSphere Application Server の場合: https://server:9443/mfpadmin
* Tomcat の場合: https://server:8443/mfpadmin

**secure**  
`--secure` オプションは、デフォルトで true に設定されます。 `--secure=false` を設定すると、以下の影響がある場合があります。

* ユーザーとパスワードが、セキュアでない方法で送信される可能性があります (暗号化されていない HTTP で送信される可能性もあります)。
* サーバーの SSL 証明書は、たとえ自己署名された場合でも、あるいはサーバーのホスト名とは異なるホスト名のために作成された場合でも、受け入れられます。

**password**  
パスワードは、`--passwordfile` オプションで渡される別個のファイルで指定します。 あるいは、対話モード (「対話モード」を参照) でパスワードを対話式に指定することもできます。 パスワードは機密情報であり、保護する必要があります。 同じコンピューター上の他のユーザーがこれらのパスワードを知ることができないようにしてください。 パスワードを保護するには、パスワードをファイルに入力する前に、自分以外のユーザーに対しファイルの読み取り権限を削除する必要があります。 例えば、以下のいずれかのコマンドを使用できます。

* UNIX の場合: `chmod 600 adminpassword.txt`
* Windows の場合: `cacls adminpassword.txt /P Administrators:F %USERDOMAIN%\%USERNAME%:F`

この理由により、コマンド・ライン引数を通じてパスワードをプロセスに渡さないでください。 多くのオペレーティング・システムでは、別のユーザーがプロセスのコマンド・ライン引数を調べることができます。

mfpadm 呼び出しは、1 つのコマンドを含みます。 以下のコマンドがサポートされています。

| コマンド                           | 説明 |
|-----------------------------------|-------------|
| show info	| ユーザーと構成の情報を表示します。 |
| show global-config | グローバル構成情報を表示します。 |
| show diagnostics | 診断情報を表示します。 |
| show versions	| バージョン情報を表示します。 |
| unlock | 汎用ロックをリリースします |
| list runtimes [--in-database] | ランタイムをリストします。 |
| show runtime [runtime-name] | ランタイムに関する情報を表示します。 |
| delete runtime [runtime-name] condition | ランタイムを削除します。 |
| show user-config [runtime-name] | ランタイムのユーザー構成を表示します。 |
| set user-config [runtime-name] file | ランタイムのユーザー構成を指定します。 |
| set user-config [runtime-name] property = value | ランタイムのユーザー構成のプロパティーを指定します。 |
| show confidential-clients [runtime-name] | ランタイムの機密クライアントの構成を表示します。 |
| set confidential-clients [runtime-name] file | ランタイムの機密クライアントの構成を指定します。 |
| set confidential-clients-rule [runtime-name] id display-name secret allowed-scope | ランタイムの機密クライアントの構成のルールを指定します。 |
| list adapters [runtime-name] | アダプターをリストします。 |
| deploy adapter [runtime-name] property = value | アダプターをデプロイします。|
| show adapter [runtime-name] adapter-name | アダプターに関する情報を表示します。|
| delete adapter [runtime-name] adapter-name | アダプターを削除します。|
| adapter [runtime-name] adapter-name get binary [> tofile]	| アダプターのバイナリー・データを取得します。|
| list apps [runtime-name] | アプリケーションをリストします。|
| deploy app [runtime-name] file | アプリケーションをデプロイします。|
| show app [runtime-name] app-name | アプリケーションに関する情報を表示します。|
| delete app [runtime-name] app-name | アプリケーションを削除します。 |
| show app version [runtime-name] app-name environment version | アプリケーション・バージョンに関する情報を表示します。 |
| delete app version [runtime-name] app-name environment version | アプリケーションのバージョンを削除します。 |
| app [runtime-name] app-name show license-config | アプリケーションのトークン・ライセンス構成を表示します。 |
| app [runtime-name] app-name set license-config app-type license-type | アプリケーションのトークン・ライセンス構成を指定します。 |
| app [runtime-name] app-name delete license-config | アプリケーションのトークン・ライセンス構成を削除します。 |
| app version [runtime-name] app-name environment version get descriptor [> tofile]	| アプリケーション・バージョンの記述子を取得します。 |
| app version [runtime-name] app-name environment version get web-resources [> tofile] | アプリケーション・バージョンの Web リソースを取得します。 |
| app version [runtime-name] app-name environment version set web-resources file | アプリケーション・バージョンの Web リソースを指定します。 |
| app version [runtime-name] app-name environment version get authenticity-data [> tofile] | アプリケーション・バージョンの認証データを取得します。 |
| app version [runtime-name] app-name environment version set authenticity-data [file] | アプリケーション・バージョンの認証データを指定します。 |
| app version [runtime-name] app-name environment version delete authenticity-data | アプリケーション・バージョンの認証データを削除します。 |
| app version [runtime-name] app-name environment version show user-config | アプリケーション・バージョンのユーザー構成を表示します。 |
| app version [runtime-name] app-name environment version set user-config file | アプリケーション・バージョンのユーザー構成を指定します。 |
| app version [runtime-name] app-name environment version set user-config property = value | アプリケーション・バージョンのユーザー構成内のプロパティーを指定します。 |
| list devices [runtime-name][--query query] | デバイスをリストします。 |
| remove device [runtime-name] id | デバイスを削除します。 |
| device [runtime-name] id set status new-status | デバイスの状況を変更します。 |
| device [runtime-name] id set appstatus app-name new-status | アプリケーションのデバイスの状況を変更します。 |
| list farm-members [runtime-name] | サーバー・ファームのメンバーであるサーバーをリストします。 |
| remove farm-member [runtime-name] server-id | ファーム・メンバーのリストからサーバーを削除します。 |

#### 対話モード
{: #interactive-mode }
別の方法として、コマンド・ラインでコマンドなしで **mfpadm** を呼び出すこともできます。 その場合、1 行に 1 つずつコマンドを対話式に入力できます。
`exit` コマンド、または標準入力 (UNIX ターミナルでは **Ctrl-D**) の EOF によって、mfpadm は終了します。

このモードでは、`Help` コマンドも使用できます。 例えば、次のとおりです。

* help
* help show versions
* help device
* help device set status

#### 対話モードでのコマンド・ヒストリー
{: #command-history-in-interactive-mode }
一部のオペレーティング・システムでは、対話式の mfpadm コマンドがコマンド・ヒストリーを記憶します。 コマンド・ヒストリーによって、上下矢印キーで以前のコマンドを選択し、編集してから実行することができます。

**Linux の場合**  
rlwrap パッケージがインストール済みで、PATH に含まれていれば、端末エミュレーター・ウィンドウでコマンド・ヒストリーを使用することができます。 rlwrap パッケージをインストールするには、以下を実行します。

* Red Hat Linux の場合: `sudo yum install rlwrap`
* SUSE Linux の場合: `sudo zypper install rlwrap`
* Ubuntu の場合: `sudo apt-get install rlwrap`

**OS X の場合:**  
rlwrap パッケージがインストール済みで、PATH に含まれていれば、ターミナル・プログラムでコマンド・ヒストリーを使用することができます。 rlwrap パッケージをインストールするには、以下を実行します。

1. [www.macports.org](http://www.macports.org) から、インストーラーを使用して、MacPorts をインストールします。
2. 次のコマンドを実行します。`sudo /opt/local/bin/port install rlwrap`
3. 次に、PATH で rlwrap プログラムを使用可能にするために、Bourne 対応シェルで次のコマンドを実行します。`PATH=/opt/local/bin:$PATH`

**Windows の場合**  
cmd.exe コンソール・ウィンドウでコマンド・ヒストリーが使用可能です。

rlwrap が使用できない環境または不要の環境では、オプション `--no-readline` で使用不可にできます。

#### 構成ファイル
{: #the-configuration-file }
呼び出しごとにコマンド・ラインでオプションを渡す代わりに、オプションを構成ファイルに保管しておくことも可能です。 構成ファイルが存在し、–configfile=file オプションが指定されているときに、省略することができるオプションは以下のとおりです。

* --url=URL
* --secure=boolean
* --user=name
* --passwordfile=file
* --timeout=seconds
* --connect-timeout=seconds
* --socket-timeout=seconds
* --connection-request-timeout=seconds
* --lock-timeout=seconds
* runtime-name

これらの値を構成ファイルに保管するには、以下のコマンドを使用します。

| コマンド | コメント |
|---------|---------|
| mfpadm [--configfile=file] config url URL | |
| mfpadm [--configfile=file] config secure boolean | |
| mfpadm [--configfile=file] config user name | |
| mfpadm [--configfile=file] config password | パスワードのプロンプトを出します。 |
| mfpadm [--configfile=file] config timeout seconds | |
| mfpadm [--configfile=file] config connect-timeout seconds | |
| mfpadm [--configfile=file] config socket-timeout seconds | |
| mfpadm [--configfile=file] config connection-request-timeout seconds | |
| mfpadm [--configfile=file] config lock-timeout seconds | |
| mfpadm [--configfile=file] config runtime runtime-name | |

構成ファイルに保管されている値をリストするには、次のコマンドを使用します: `mfpadm [--configfile=file] config`

構成ファイルはテキスト・ファイルであり、現行のロケールのエンコード・フォーマットで、Java **.properties** 構文で記述されます。 デフォルトの構成ファイルは以下のとおりです。

* UNIX: **${HOME}/.mfpadm.config**
* Windows: **{{ site.data.keys.prod_server_data_dir_win }}\mfpadm.config**

**注:** `--configfile` オプションを指定しない場合、デフォルトの構成ファイルは対話モードおよび config コマンドでのみ使用されます。 他のコマンドを非対話式で使用するとき、構成ファイルを使いたい場合は、その構成ファイルを明示的に指定する必要があります。

> **重要:** パスワードは、偶発的な表示から隠すために、難読化した形式で保管されます。 ただし、この難読化はセキュリティー機能を持ちません。

#### 一般オプション
{: #generic-options }
通常の一般オプションもあります。

| オプション	| 説明 |
|-----------|-------------|
| --help	| 使い方のヘルプを表示します |
| --version	| バージョンを表示します |

#### XML 形式
{: #xml-format }
サーバーから XML 応答を受け取るコマンドは、その応答が特定のスキーマに従うか検証します。 `--xmlvalidation=none` を指定することで、この検証を無効にすることができます。

#### 出力文字セット
{: #output-character-set }
mfpadm プログラムより生成される通常の出力は、現行のロケールのエンコード・フォーマットでエンコードされます。 Windows で、このエンコード・フォーマットは「ANSI コード・ページ」です。 以下のような影響があります。

* この文字セット以外の文字は、出力時に疑問符 (?) に変換されます。
* 出力が Windows コマンド・プロンプト・ウィンドウ (cmd.exe) に表示される場合、このようなウィンドウは、非 ASCII 文字を「OEM コード・ページ」でエンコードされる文字だと見なすため、非 ASCII 文字は正しく表示されません。

この制約を回避するには、以下の手順を実行してください。

* Windows 以外のオペレーティング・システムでは、エンコード・フォーマットが UTF-8 のロケールを使用します。 この形式は、Red Hat Linux および OS X ではデフォルト・ロケールです。他の多くのオペレーティング・システムには、`en_US.UTF-8` という名前のロケールがあります。
* それ以外の場合は、`output="some file name"` 属性と一緒に mfpadm Ant タスクを使用して、コマンドの出力をファイルにリダイレクトします。

### 一般構成用のコマンド
{: #commands-for-general-configuration }
**mfpadm** プログラムを呼び出すときに、IBM {{ site.data.keys.mf_server }} またはランタイムのグローバル構成にアクセスするさまざまなコマンドを含めることができます。

#### `show global-config` コマンド
{: #the-show-global-config-command }
`show global-config` コマンドは、グローバル構成を表示します。

構文: `show global-config`

以下のオプションを取ります。

| 引数 | 説明 |
|----------|-------------|
| --xml    | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**  

```bash
show global-config
```

このコマンドは、[グローバル構成 (GET) (Global Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_global_configuration_get.html?view=kc#Global-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `show user-config` コマンド
{: #the-show-user-config-command }
`show user-config` コマンドは、ランタイムのユーザー構成を表示します。

構文: `show user-config [--xml] [runtime-name]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |

`show user-config` コマンドは、動詞の後に以下のオプションを取ります。

| 引数 | 説明 | 必須 | デフォルト |
|----------|-------------|----------|---------|
| --xml | JSON 形式の代わりに XML 形式で出力を生成します。 | いいえ | 標準出力 |

**例**  

```bash
show user-config mfp
```

このコマンドは、[ランタイム構成 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_get.html?view=kc#Runtime-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `set user-config` コマンド
{: #the-set-user-config-command }
`set user-config` コマンドは、ランタイムのユーザー構成か、またはこの構成のうちの単一プロパティーを指定します。

構成全体の場合の構文: `set user-config [runtime-name] file`

以下の引数を取ります。

| 属性 | 説明 |
|-----------|-------------|
| runtime-name | ランタイムの名前。 |
| file | 新しい構成を含む JSON または XML ファイルの名前。 |

単一プロパティーの場合の構文: `set user-config [runtime-name] property = value`

`set user-config` コマンドは以下の引数を取ります

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| property | JSON プロパティーの名前。 ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。 JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。 |
| value | プロパティーの値。 |

**例**  

```bash
set user-config mfp myconfig.json
```

```bash
set user-config mfp timeout = 240
```

このコマンドは、[ランタイム構成 (PUT) (Runtime configuration (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_configuration_put.html?view=kc#Runtime-configuration--PUT-) REST サービスに基づいています。

<br/>
#### `show confidential-clients` コマンド
{: #the-show-confidential-clients-command }
`show confidential-clients` コマンドは、ランタイムにアクセスできる機密クライアントの構成を表示します。 機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。

構文: `show confidential-clients [--xml] [runtime-name]`

以下の引数を取ります。

| 属性 | 説明 |
|-----------|-------------|
| runtime-name | ランタイムの名前。 |

`show confidential-clients` コマンドは、動詞の後に以下のオプションを取ります。

| 引数 | 説明 | 必須 | デフォルト |
|----------|-------------|----------|---------|
| --xml | JSON 形式の代わりに XML 形式で出力を生成します。 | いいえ | 標準出力 |

**例**

```bash
show confidential-clients --xml mfp
```

このコマンドは、[機密クライアント (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_get.html?view=kc#Confidential-Clients--GET-) REST サービスに基づいています。

<br/>
#### `set confidential-clients` コマンド
{: #the-set-confidential-clients-command }
`set confidential-clients` コマンドは、ランタイムにアクセスできる機密クライアントの構成を指定します。 機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。

構文: `set confidential-clients [runtime-name] file`

以下の引数を取ります。

| 属性 | 説明 |
|-----------|-------------|
| runtime-name | ランタイムの名前。 |
| file | 新しい構成を含む JSON または XML ファイルの名前。 |

**例**

```bash
set confidential-clients mfp clients.xml
```

このコマンドは、[機密クライアント (PUT) (Confidential Clients (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST サービスに基づいています。

<br/>
#### `set confidential-clients-rule` コマンド
{: #the-set-confidential-clients-rule-command }
`set confidential-clients-rule` コマンドは、ランタイムにアクセスできる機密クライアントの構成におけるルールを指定します。 機密クライアントについて詳しくは、[ 機密クライアント (Confidential clients)](../../authentication-and-security/confidential-clients) を参照してください。

構文: `set confidential-clients-rule [runtime-name] id displayName secret allowedScope`

以下の引数を取ります。

| 属性	| 説明 |
|-----------|-------------|
| runtime | ランタイムの名前。 |
| id | ルールの ID。 |
| displayName | ルールの表示名。 |
| secret | ルールのシークレット。 |
| allowedScope | ルールの適用範囲。 スペースで区切られたトークンのリスト。 複数のトークンのリストを渡すには、二重引用符を使用します。 |

**例**

```bash
set confidential-clients-rule mfp push Push lOa74Wxs "**"
```

このコマンドは、[機密クライアント (PUT) (Confidential Clients (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_confidential_clients_put.html?view=kc#Confidential-Clients--PUT-) REST サービスに基づいています。

### アダプター用のコマンド
{: #commands-for-adapters }
**mfpadm** プログラムを呼び出すときに、アダプター用のさまざまなコマンドを含めることができます。

### `list adapters` コマンド
{: #the-list-adapters-command }
`list adapters` コマンドは、ランタイムにデプロイされたアダプターのリストを返します。

構文: `list adapters [runtime-name]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |

`list adapters` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**  

```xml
list adapters mfp
```

このコマンドは、[Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapters_get.html?view=kc#Adapters--GET-) REST サービスに基づいています。

<br/>
#### `deploy adapter` コマンド
{: #the-deploy-adapter-command }
`deploy adapter` コマンドは、アダプターをランタイムにデプロイします。

構文: `deploy adapter [runtime-name] file`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| file | バイナリー・アダプター・ファイル (.adapter) |

**例**

```bash
deploy adapter mfp MyAdapter.adapter
```

このコマンドは、[Adapter (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_post.html?view=kc#Adapter--POST-) REST サービスに基づいています。

<br/>
#### `show adapter` コマンド
{: #the-show-adapter-command }
`show adapter` コマンドは、アダプターに関する詳細を表示します。

構文: `show adapter [runtime-name] adapter-name`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| adapter-name | アダプターの名前 |

`show adapter` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show adapter mfp MyAdapter
```

このコマンドは、[Adapter (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_get.html?view=kc#Adapter--GET-) REST サービスに基づいています。

<br/>
#### `delete adapter` コマンド
{: #the-delete-adapter-command }
`delete adapter` コマンドは、アダプターをランタイムから削除 (アンデプロイ) します。

構文: `delete adapter [runtime-name] adapter-name`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| adapter-name | アダプターの名前。 |

**例**

```bash
delete adapter mfp MyAdapter
```

このコマンドは、[Adapter (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_delete.html?view=kc#Adapter--DELETE-) REST サービスに基づいています。

<br/>
#### `adapter` コマンド接頭部
{: #the-adapter-command-prefix }
`adapter` コマンド接頭部では、動詞の前に以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| adapter-name | アダプターの名前。 |

<br/>
#### `adapter get binary` コマンド
{: #the-adapter-get-binary-command }
`adapter get binary` コマンドは、バイナリー・アダプター・ファイルを返します。

構文: `adapter [runtime-name] adapter-name get binary [> tofile]`

動詞の後に、以下のオプションを取ります。

| オプション | 説明 | 必須 | デフォルト |
|--------|-------------|----------|---------|
| > tofile | 出力ファイルの名前。 | いいえ | 標準出力 |

**例**

```bash
adapter mfp MyAdapter get binary > /tmp/MyAdapter.adapter
```

このコマンドは、[ ランタイム・リソースのエクスポート (GET) (Export runtime resources (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST サービスに基づいています。

<br/>
#### `adapter show user-config` コマンド
{: #the-adapter-show-user-config-command }
`adapter show user-config` コマンドは、アダプターのユーザー構成を表示します。

構文: `adapter [runtime-name] adapter-name show user-config [--xml]`

動詞の後に、以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | JSON 形式の代わりに XML 形式で出力を生成します。 |

**例**

```bash
adapter mfp MyAdapter show user-config
```

このコマンドは、[ アダプター構成 (GET) (Adapter Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_get.html?view=kc#Adapter-Configuration--GET-) REST サービスに基づいています。

<br/>
#### `adapter set user-config` コマンド
{: #the-adapter-set-user-config-command }
`adapter set user-config` コマンドは、アダプターのユーザー構成か、またはこの構成のうちの単一プロパティーを指定します。

構成全体の場合の構文: `adapter [runtime-name] adapter-name set user-config file`

動詞の後に、以下の引数を取ります。

| オプション | 説明 |
|--------|-------------|
| file | 新しい構成を含む JSON または XML ファイルの名前。 |

単一プロパティーの場合の構文: `adapter [runtime-name] adapter-name set user-config property = value`

動詞の後に、以下の引数を取ります。

| オプション | 説明 |
|--------|-------------|
| property | JSON プロパティーの名前。 ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。 JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。 |
| value | プロパティーの値。 |

**例**

```bash
adapter mfp MyAdapter set user-config myconfig.json
```

```bash
adapter mfp MyAdapter set user-config timeout = 240
```

このコマンドは、[アダプター構成 (PUT) (Adapter configuration (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_adapter_configuration_put.html?view=kc) REST サービスに基づいています。

### アプリケーション用のコマンド
{: #commands-for-apps }
**mfpadm** プログラムを呼び出すときに、アプリケーション用のさまざまなコマンドを含めることができます。

#### `list apps` コマンド
{: #the-list-apps-command }
`list apps` コマンドは、ランタイムにデプロイされているアプリケーションのリストを返します。

構文: `list apps [runtime-name]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |

`list apps` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
list apps mfp
```

このコマンドは、[Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_applications_get.html?view=kc#Applications--GET-) REST サービスに基づいています。

#### `deploy app` コマンド
{: #the-deploy-app-command }
`deploy app` コマンドは、アプリケーション・バージョンをランタイムにデプロイします。

構文: `deploy app [runtime-name] file`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| file | アプリケーション記述子、JSON ファイル。 |

**例**

```bash
deploy app mfp MyApp/application-descriptor.json
```

このコマンドは、[Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-) REST サービスに基づいています。

#### `show app` コマンド
{: #the-show-app-command }
`show app` コマンドは、ランタイム内のアプリケーションに関する詳細 (特に、その環境やバージョン) を表示します。

構文: `show app [runtime-name] app-name`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前。 |

`show app` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml	 | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show app mfp MyApp
```

このコマンドは、[Application (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_get.html?view=kc#Application--GET-) REST サービスに基づいています。

#### `delete app` コマンド
{: #the-delete-app-command }
`delete app` コマンドはすべての環境およびすべてのバージョンで、ランタイムからアプリケーションを削除 (アンデプロイ) します。

構文: `delete app [runtime-name] app-name`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前 |

**例**

```bash
delete app mfp MyApp
```

このコマンドは、[アプリケーション・バージョン (DELETE) (Application Version (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST サービスに基づいています。

#### `show app version` コマンド
{: #the-show-app-version-command }
`show app version` コマンドはランタイムでのアプリケーション・バージョンに関する詳細を表示します。

構文: `show app version [runtime-name] app-name environment version`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前。 |
| environment | モバイル・プラットフォーム。 |
| version | アプリケーションのバージョン。 |

`show app version` コマンドは、オブジェクトの後に以下のオプションを取ります。

| 引数 | 説明 |
| ---------|-------------|
| -- xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show app version mfp MyApp iPhone 1.1
```

このコマンドは、[アプリケーション・バージョン (GET) (Application Version (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_get.html?view=kc#Application-Version--GET-) REST サービスに基づいています。

#### `delete app version` コマンド
{: #the-delete-app-version-command }
`delete app version` コマンドは、アプリケーション・バージョンをランタイムから削除 (アンデプロイ) します。

構文: `delete app version [runtime-name] app-name environment version`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前。 |
| environment | モバイル・プラットフォーム。 |
| version | アプリケーションのバージョン。 |

**例**

```bash
delete app version mfp MyApp iPhone 1.1
```

このコマンドは、[アプリケーション・バージョン (DELETE) (Application Version (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_version_delete.html?view=kc#Application-Version--DELETE-) REST サービスに基づいています。

#### `app` コマンド接頭部
{: #the-app-command-prefix }
`app` コマンド接頭部では、動詞の前に以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前。 |

#### `app show license-config` コマンド
{: #the-app-show-license-config-command }
`app show license-config` コマンドは、アプリケーションのトークン・ライセンス構成を表示します。

構文: `app [runtime-name] app-name show license-config`

オブジェクトの後に以下のオプションを取ります。

| 引数 | 説明 |
|----------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
app mfp MyApp show license-config
```

このコマンドは、[ アプリケーション・ライセンス構成 (GET) (Application license configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration_get.html?view=kc) REST サービスに基づいています。

#### `app set license-config` コマンド
{: #the-app-set-license-config-command }
`app set license-config` コマンドは、アプリケーションのトークン・ライセンス構成を指定します。

構文: `app [runtime-name] app-name set license-config app-type license-type`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| appType | アプリケーションのタイプ: B2C または B2E |
| licenseType | アプリケーションのタイプ: APPLICATION または ADDITIONAL_BRAND_DEPLOYMENT または NON_PRODUCTION |

**例**

```bash
app mfp MyApp iPhone 1.1 set license-config B2E APPLICATION
```

このコマンドは、[アプリケーション・ライセンス構成 (POST) (Application License Configuration (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_license_configuration__post.html?view=kc) REST サービスに基づいています。

#### `app delete license-config` コマンド
{: #the-app-delete-license-config-command }
`app delete license-config` コマンドは、アプリケーションのトークン・ライセンス構成をリセットします。つまり、構成を初期状態に戻します。

構文: `app [runtime-name] app-name delete license-config`

**例**

```bash
app mfp MyApp iPhone 1.1 delete license-config
```

このコマンドは、[ライセンス構成 (DELETE) (License configuration (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_license_configuration_delete.html?view=kc#License-configuration--DELETE-) REST サービスに基づいています。

#### `app version` コマンド接頭部
{: #the-app-version-command-prefix }
`app version` コマンド接頭部では、動詞の前に以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| app-name | アプリケーションの名前。 |
| environment | モバイル・プラットフォーム |
| version | アプリケーションのバージョン |

#### `app version get descriptor` コマンド
{: #the-app-version-get-descriptor-command }
`app version get descriptor` コマンドは、アプリケーションのバージョンのアプリケーション記述子を返します。

構文: `app version [runtime-name] app-name environment version get descriptor [> tofile]`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 | 必須 | デフォルト |
|----------|-------------|----------|---------|
| > tofile | 出力ファイルの名前。 | いいえ | 標準出力 |

**例**

```bash
app version mfp MyApp iPhone 1.1 get descriptor > /tmp/MyApp-application-descriptor.json
```

このコマンドは、[アプリケーション記述子 (GET) (Application Descriptor (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-) REST サービスに基づいています。

#### `app version get web-resources` コマンド
{: #the-app-version-get-web-resources-command }
`app version get web-resources` コマンドは、アプリケーションのバージョンの Web リソースを .zip ファイルとして返します。

構文: `app version [runtime-name] app-name environment version get web-resources [> tofile]`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 | 必須 | デフォルト |
|----------|-------------|----------|---------|
| > tofile | 出力ファイルの名前。 | いいえ | 標準出力 |

**例**

```bash
app version mfp MyApp iPhone 1.1 get web-resources > /tmp/MyApp-web.zip
```

このコマンドは、[Web リソースの取得 (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_retrieve_web_resource_get.html?view=kc#Retrieve-Web-Resource--GET-) REST サービスに基づいています。

#### `app version set web-resources` コマンド
{: #the-app-version-set-web-resources-command }
`app version set web-resources` コマンドは、アプリケーションのバージョンの Web リソースを指定します。

構文: `app version [runtime-name] app-name environment version set web-resources file`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 |
| file | 入力ファイルの名前 (.zip ファイルでなければなりません)。 |

**例**

```bash
app version mfp MyApp iPhone 1.1 set web-resources /tmp/MyApp-web.zip
```

このコマンドは、[Web リソースのデプロイ (POST) (Deploy a web resource (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc#Deploy-a-web-resource--POST-) REST サービスに基づいています。

#### `app version get authenticity-data` コマンド
{: #the-app-version-get-authenticity-data-command }
`app version get authenticity-data` コマンドは、アプリケーションのバージョンの認証データを返します。

構文: `app version [runtime-name] app-name environment version get authenticity-data [> tofile]`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 | 必須 | デフォルト |
| > tofile | 出力ファイルの名前。 | いいえ | 標準出力 |

**例**

```bash
app version mfp MyApp iPhone 1.1 get authenticity-data > /tmp/MyApp.authenticity_data
```

このコマンドは、[ ランタイム・リソースのエクスポート (GET) (Export runtime resources (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc) REST サービスに基づいています。

#### `app version set authenticity-data` コマンド
{: #the-app-version-set-authenticity-data-command }
`app version set authenticity-data` コマンドは、アプリケ ーションのバージョンの認証データを指定します。

構文: `app version [runtime-name] app-name environment version set authenticity-data file`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| file | 入力ファイルの名前。以下のいずれかです。<ul><li>.authenticity_data ファイルまたは</li><li>認証データの抽出元である装置ファイル (.ipa、.apk、または .appx)</li></ul>|

**例**

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data /tmp/MyApp.authenticity_data
```

```bash
app version mfp MyApp iPhone 1.1 set authenticity-data MyApp.ipa
```

```bash
app version mfp MyApp android 1.1 set authenticity-data MyApp.apk
```

このコマンドは、[アプリケーション認証データのデプロイ (POST) (Deploy Application Authenticity Data (POST))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc) REST サービスに基づいています。

#### `app version delete authenticity-data` コマンド
{: #the-app-version-delete-authenticity-data-command }
`app version delete authenticity-data` コマンドは、アプリケーションのバージョンの認証データを削除します。

構文: `app version [runtime-name] app-name environment version delete authenticity-data`

**例**

```bash
app version mfp MyApp iPhone 1.1 delete authenticity-data
```

このコマンドは、[ アプリケーション認証性 (DELETE) (Application Authenticity (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_authenticity_delete.html?view=kc) REST サービスに基づいています。

#### `app version show user-config` コマンド
{: #the-app-version-show-user-config-command }
`app version show user-config` コマンドは、アプリケーションのバージョンのユーザー構成を表示します。

構文: `app version [runtime-name] app-name environment version show user-config [--xml]`

動詞の後に、以下のオプションを取ります。

| 引数 | 説明 | 必須 | デフォルト |
|----------|-------------|----------|---------|
| [--xml] | JSON 形式の代わりに XML 形式で出力を生成します。 | いいえ | 標準出力 |

**例**

```bash
app version mfp MyApp iPhone 1.1 show user-config
```

このコマンドは、[アプリケーション構成 (GET) (Application Configuration (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_get.html?view=kc#Application-Configuration--GET-) REST サービスに基づいています。

### `app version set user-config` コマンド
{: #the-app-version-set-user-config-command }
`app version set user-config` コマンドは、アプリケーションのバージョンのユーザー構成か、またはこの構成内での単一プロパティーを指定します。

構成全体の場合の構文: `app version [runtime-name] app-name environment version set user-config file`

動詞の後に、以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| file | 新しい構成を含む JSON または XML ファイルの名前。 |

単一プロパティーの場合の構文: `app version [runtime-name] app-name environment version set user-config property = value`

`app version set user-config` コマンドは、動詞の後に以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| property | JSON プロパティーの名前。 ネストされたプロパティーでは、構文 prop1.prop2.....propN を使用します。 JSON 配列エレメントでは、プロパティー名ではなくインデックスを使用します。 |
| value | プロパティーの値。 |

**例**

```bash
app version mfp MyApp iPhone 1.1 set user-config /tmp/MyApp-config.json
```

```bash
app version mfp MyApp iPhone 1.1 set user-config timeout = 240
```

このコマンドは、[アプリケーション構成 (PUT) (Application Configuration (PUT))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_configuration_put.html?view=kc) REST サービスに基づいています。

### デバイス用のコマンド
{: #commands-for-devices }
**mfpadm** プログラムを呼び出すときに、デバイス用のさまざまなコマンドを含めることができます。

#### `list devices` コマンド
{: #the-list-devices-command }
`list devices` コマンドは、ランタイムのアプリケーションと接触のあるデバイスのリストを返します。

構文: `list devices [runtime-name] [--query query]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| query | 検索対象の分かりやすい名前またはユーザー ID。 このパラメーターには、検索対象のストリングを指定します。 このストリングが含まれる (大/小文字を区別しないマッチングによって)、分かりやすい名前またはユーザー ID を持つすべてのデバイスが返されます。 |

`list devices` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
list-devices mfp
```

```bash
list-devices mfp --query=john
```

このコマンドは、[Devices (GET) REST](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_devices_get.html?view=kc#Devices--GET-) サービスに基づいています。

#### `remove device` コマンド
{: #the-remove-device-command }
`remove device` コマンドは、ランタイムのアプリケーションと接触のあるデバイスに関するレコードを消去します。

構文: `remove device [runtime-name] id`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| id | 固有のデバイス ID。 |

**例**

```bash
remove device mfp 496E974CCEDE86791CF9A8EF2E5145B6
```

このコマンドは、[Device (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_delete.html?view=kc#Device--DELETE-) REST サービスに基づいています。

#### `device` コマンド接頭部
{: #the-device-command-prefix }
`device` コマンド接頭部では、動詞の前に以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| id | 固有のデバイス ID。 |

#### `device set status` コマンド
{: #the-device-set-status-command }
`device set status` コマンドは、ランタイムの有効範囲でデバイスの状況を変更します。

構文: `device [runtime-name] id set status new-status`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| new-status | 新しい状況。 |

この状況の値は、以下のいずれかになります。

* ACTIVE
* LOST
* STOLEN
* EXPIRED
* DISABLED

**例**

```bash
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set status EXPIRED
```

このコマンドは、[Device Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_status_put.html?view=kc#Device-Status--PUT-) REST サービスに基づいています。

#### `device set appstatus` コマンド
{: #the-device-set-appstatus-command }
`device set appstatus` コマンドは、ランタイム内のアプリケーションに関して、デバイスの状況を変更します。

構文: `device [runtime-name] id set appstatus app-name new-status`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| app-name | アプリケーションの名前。 |
| new-status | 新しい状況。 |

この状況の値は、以下のいずれかになります。

* ENABLED
* DISABLED


**例**

```xml
device mfp 496E974CCEDE86791CF9A8EF2E5145B6 set appstatus MyApp DISABLED
```

このコマンドは、[Device Application Status (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_device_application_status_put.html?view=kc#Device-Application-Status--PUT-) REST サービスに基づいています。

### トラブルシューティング用のコマンド
{: #commands-for-troubleshooting }
**mfpadm** プログラムを呼び出すときに、トラブルシューティング用のさまざまなコマンドを含めることができます。

#### `show info` コマンド
{: #the-show-info-command }
`show info` コマンドは、ランタイムやデータベースにアクセスせずに返されることが可能な、{{ site.data.keys.product_adj }} 管理サービスに関する基本情報を表示します。 このコマンドは、{{ site.data.keys.product_adj }} 管理サービスが実行されているかどうかをテストするために使用できます。

構文: `show info`

オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show info
```

#### `show versions` コマンド
{: #the-show-versions-command }
`show versions` コマンドは、各種コンポーネントの {{ site.data.keys.product_adj }} バージョンを表示します。

* **mfpadmVersion**: **which mfp-ant-deployer.jar** が取得される {{ site.data.keys.mf_server }} の正確なバージョン番号。
* **productVersion**: **mfp-admin-service.war** が取得される {{ site.data.keys.mf_server }} の正確なバージョン番号。
* **mfpAdminVersion**: **mfp-admin-service.war** のみの正確なビルド・バージョン番号。

構文: `show versions`

オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show versions
```

#### `show diagnostics` コマンド
{: #the-show-diagnostics-command }
`show diagnostics` コマンドは、データベースや補助サービスの可用性など、{{ site.data.keys.product_adj }} 管理サービスの正しい運用に必要な各種コンポーネントの状況を表示します。

構文: `show diagnostics`

オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
show diagnostics
```

#### `unlock` コマンド
{: #the-unlock-command }
`unlock` コマンドは汎用ロックをリリースします。 破棄する動作の一部は、同じ構成データの同時修正を防ぐために、このロックを取得します。 まれに、そのような動作が中断されると、ロックはロック状態のままとなり、それ以上の破棄操作が不可能になります。 このような状況でロックをリリースするには、unlock コマンドを使用してください。

**例**

```bash
unlock
```

#### `list runtimes` コマンド
{: #the-list-runtimes-command }
`list runtimes` コマンドは、デプロイ済みのランタイムのリストを返します。

構文: `list runtimes [--in-database]`

以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --in-database	| MBeans 経由の代わりにデータベースを検索するかどうか。 |
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
list runtimes
```

```bash
list runtimes --in-database
```

このコマンドは、[Runtimes (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtimes_get.html?view=kc#Runtimes--GET-) REST サービスに基づいています。

#### `show runtime` コマンド
{: #the-show-runtime-command }
`show runtime` コマンドは、指定されたデプロイ済みのランタイムに関する情報を表示します。

構文: `show runtime [runtime-name]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |

`show runtime` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

このコマンドは、[Runtime (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_get.html?view=kc#Runtime--GET-) REST サービスに基づいています。

**例**

```bash
show runtime mfp
```

#### `delete runtime` コマンド
{: #the-delete-runtime-command }
`delete runtime` コマンドは、ランタイム (そのアプリケーションとアダプターを含む) をデータベースから削除します。 ランタイムを削除できるのは、その Web アプリケーションが停止している場合のみです。

構文: `delete runtime [runtime-name] condition`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| condition | 削除する条件。empty または always のいずれかです。 **注意:** always オプションは危険です。 |

**例**

```bash
delete runtime mfp empty
```

このコマンドは、[Runtime (DELETE)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_runtime_delete.html?view=kc#Runtime--DELETE-) REST サービスに基づいています。

#### `list farm-members` コマンド
{: #the-list-farm-members-command }
`list farm-members` コマンドは、所定のランタイムがデプロイされているファーム・メンバー・サーバーのリストを返します。

構文: `list farm-members [runtime-name]`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |

`list farm-members` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --xml | 表形式の出力の代わりに、XML 出力を生成します。 |

**例**

```bash
list farm-members mfp
```

このコマンドは、[ファーム・トポロジー・メンバー (GET) (Farm topology members (GET))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_get.html?view=kc#Farm-topology-members--GET-) REST サービスに基づきます。

#### `remove farm-member` コマンド
{: #the-remove-farm-member-command }
`remove farm-member` コマンドは、指定されたランタイムがデプロイされているファーム・メンバーのリストから特定のサーバーを削除します。 サーバーが使用不可になったとき、または切断されたときに、このコマンドを使用します。

構文: `remove farm-member [runtime-name] server-id`

以下の引数を取ります。

| 引数 | 説明 |
|----------|-------------|
| runtime-name | ランタイムの名前。 |
| server-id | サーバーの ID。 |

`remove farm-member` コマンドは、オブジェクトの後に以下のオプションを取ります。

| オプション | 説明 |
|--------|-------------|
| --force | ファーム・メンバーが使用可能の場合、または接続されている場合でも、ファーム・メンバーの削除を強制します。 |

**例**

```bash
remove farm-member mfp srvlx15
```

このコマンドは、[ファーム・トポロジー・メンバー (Farm topology members (DELETE))](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_farm_topology_members_delete.html?view=kc) REST サービスに基づきます。
