---
layout: tutorial
title: セキュリティー検査の作成
breadcrumb_title: Creating a security check
relevantTo: [android,ios,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

セキュリティー検査は、{{ site.data.keys.product_adj }} セキュリティー・フレームワークの基本的なサーバー・サイド・ビルディング・ブロックから構成されます。 セキュリティー検査は、クライアント資格情報を取得して検証するなど、特定の許可ロジックを実装するサーバー・サイド・エンティティーです。 ゼロ個以上のセキュリティー検査にマップされるスコープをリソースに割り当てることで、リソースを保護します。 セキュリティー・フレームワークにより、保護スコープのすべてのセキュリティー検査に合格したクライアントのみにリソースに対するアクセス権限が付与されるようになります。 セキュリティー検査を使用して、{{ site.data.keys.mf_server }} 上にホストされているリソースと外部リソース・サーバー上のリソースの両方に対するアクセスを許可できます。

アダプターは、*リソース*・アダプター (クライアントに送信するリソースおよびコンテンツを提供するアダプター)、*SecurityCheck* アダプター、または**その両方**にすることができます。

> <b>注:</b> セキュリティー検査はアダプター内に実装されますが、{{ site.data.keys.product_adj }} セキュリティー・フレームワークとアダプター API はそれぞれ独立しており、混在することはできません。 したがって、アダプター API (`AdpatersAPI` インターフェースなど) をセキュリティー検査コード内で使用したり、セキュリティー検査 API をアダプター・リソース・コード内で使用したりすることはできません。

セキュリティー・フレームワークのアーキテクチャーは、モジュラー型の柔軟なアーキテクチャーです。したがって、セキュリティー検査の実装は、本質的に、特定のリソースやアプリケーションに依存しません。 同じセキュリティー検査を再使用してさまざまなリソースを保護したり、各種許可フローでさまざまなセキュリティー検査の組み合わせを使用したりすることができます。 柔軟性を高めるために、セキュリティー検査クラスは、{{ site.data.keys.mf_console }} からセキュリティー検査定義とランタイムのどちらでもアダプター・レベルでカスタマイズ可能な構成プロパティーを公開します。

開発プロセスを促進および加速するために、{{ site.data.keys.product }} には、`SecurityCheck` インターフェースの基底抽象実装が用意されています。 さらに、`SecurityCheckConfiguration` インターフェースの基底抽象実装が提供されるほか (`SecurityCheckConfigurationBase`)、提供される各基底セキュリティー検査クラスの補足的なサンプルのセキュリティー検査構成クラスも提供されます。 開発ニーズに最も適合した基底セキュリティー検査実装 (および関連のサンプル構成) で始めて、必要に応じて実装を拡張および変更してください。

> [セキュリティー検査コントラクト](contract)について詳細を参照してください。

**前提条件:**

* [許可の概念](../)チュートリアルをお読みください。
* [アダプターの作成](../../adapters/creating-adapters)方法について理解している必要があります。

**使用法:**  
下記で説明しているセキュリティー検査の基底クラスは、{{ site.data.keys.product_adj }} `com.ibm.mfp.security.checks.base` Java Maven ライブラリーの一部として入手できます。これらのクラスは [Maven 中央リポジトリー](http://search.maven.org/#search|ga|1|a%3A%22mfp-security-checks-base%22)からアダプターを作成するときにダウンロードされます。 オフラインで開発を行っている場合は、**{{ site.data.keys.mf_console }} →「ダウンロード・センター」→「ツール」タブ→「セキュリティー検査」**からダウンロードできます。

#### ジャンプ先:
{: #jump-to }
* [セキュリティー検査の定義](#defining-a-security-check)
* [セキュリティー検査の実装](#security-check-implementation)
* [セキュリティー検査の構成](#security-check-configuration)
* [事前定義セキュリティー検査](#predefined-security-checks)
* [次のステップ](#what-s-next)

## セキュリティー検査の定義
{: #defining-a-security-check }

[Java アダプターまたは JavaScript アダプターを作成](../../adapters/creating-adapters/)するか、既存のアダプターを使用します。

> Java アダプターを作成する場合、デフォルトのテンプレートはアダプターが**リソース**を提供するものと想定します。 セキュリティー検査とリソースを同じアダプター内にバンドルするか、別々のアダプターに分けるかは、開発者が選択できます。

デフォルトの**リソース**実装を削除するには、**[AdapterName]Application.java** ファイルと **[AdapterName]Resource.java** ファイルを削除します。 **adapter.xml** から `<JAXRSApplicationClass>` エレメントも削除してください。

Java アダプターの **adapter.xml** ファイル内に、`securityCheckDefinition` という XML エレメントを追加します。 例えば、次のとおりです。

```xml
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    <property name="successStateExpirationSec" defaultValue="60"/>
    <property name="blockedStateExpirationSec" defaultValue="60"/>
    <property name="maxAttempts" defaultValue="3"/>
</securityCheckDefinition>
```

* `name` 属性は、セキュリティー検査の名前です。
* `class` 属性は、セキュリティー検査の実装 Java クラスを指定します。 このクラスを作成する必要があります。
* セキュリティー検査は、`property` エレメントのリストを使用して[さらに詳細に構成](#security-check-configuration)できます。
* カスタム・プロパティーの定義方法については、[セキュリティー検査の構成](#security-check-configuration)を参照してください。

アダプターとセキュリティー検査定義を {{ site.data.keys.mf_server }} に正常にデプロイした後は、**{{ site.data.keys.mf_console }} →「アダプター」→「 [ご使用のアダプター] 」** から、セキュリティー検査とその構成情報を確認したり、ランタイム構成を変更したりすることもできます。

* **「構成ファイル」**タブには、アダプター記述子のサーバー・コピーが表示されます。これには、カスタム・セキュリティー検査とその構成可能プロパティーを定義する `<securityCheckDefinition>` エレメントも含まれます。 また、[アダプター構成をプル](../../adapters/java-adapters/#custom-properties)して、それを他のサーバーにプッシュすることもできます。
* **「セキュリティー検査」**タブには、セキュリティー検査定義で公開したすべての構成プロパティーのリストが表示されます。 プロパティーは、構成されている `displayName` 属性の値で参照されます。表示名が構成されていない場合は、name 属性の値で参照されます。 定義でプロパティーの description 属性を設定した場合は、この説明も表示されます。
各プロパティーで、`defaultValue` 属性に構成された値が、現行値として表示されます。 この値を変更して、セキュリティー検査定義のデフォルト値をオーバーライドできます。 また、セキュリティー検査定義の最初のデフォルト値をいつでも復元できます。
* {{ site.data.keys.mf_console }} の**「アプリケーション」**セクションからアプリケーション・バージョンを選択することもできます。

## セキュリティー検査の実装
{: #security-check-implementation }

セキュリティー検査の **Java クラス**を作成します。 実装では、以下に示す、提供される基底クラスのいずれかを継承する必要があります。 選択する親クラスによって、カスタマイズと単純さの間のバランスが決まります。

### セキュリティー検査
{: #security-check }
`SecurityCheck` は、セキュリティー検査を表すために最低限必要なメソッドを定義する Java **インターフェース**です。  
各シナリオへの対処は、もっぱら、セキュリティー検査を実装する開発者の責任になります。

### ExternalizableSecurityCheck
{: #externalizablesecuritycheck }
この抽象クラスは、セキュリティー検査インターフェースの基本バージョンを実装します。  
JSON としての外部化、非アクティブ・タイムアウト、有効期限のカウントダウンなどのオプションを提供しますが、その他のオプションもいろいろ提供します。

このクラスをサブクラス化することで、セキュリティー検査実装に大きな柔軟性が生まれます。

> [ExternalizableSecurityCheck](../externalizable-security-check) チュートリアルで詳細を参照してください。

### CredentialsValidationSecurityCheck
{: #credentialsvalidationsecurityCheck }
このクラスは、`ExternalizableSecurityCheck` を継承し、その大部分のメソッドを実装して、簡単に使用できるようにします。 `validateCredentials` と `createChallenge` の 2 つのメソッドを実装する必要があります。 この実装では、特定間隔の間に限られた数のログイン試行が許可されます。その後、構成された期間、セキュリティー検査がブロックされます。 ログインが成功した場合、セキュリティー検査の状態は、構成された期間、成功のままになり、その間、ユーザーは要求されたリソースにアクセスすることができます。

`CredentialsValidationSecurityCheck` クラスは、リソースへのアクセスを認可するために任意の資格情報を検証する単純なフロー向けです。 設定されている試行回数に達した後にアクセスをブロックする組み込み機能も提供されます。

> [CredentialsValidationSecurityCheck](../credentials-validation/) チュートリアルで詳細を参照してください。

### UserAuthenticationSecurityCheck
{: #userauthenticationsecuritycheck}
このクラスは、`CredentialsValidationSecurityCheck` を継承し、したがってそのすべての機能を継承します。 このクラスはそこに、現行ログイン・ユーザーを識別するのに使用できる `AuthenticatedUser` ユーザー ID オブジェクトを作成する実装を追加します。 「ユーザーを記憶する (Remember Me)」ログイン動作をオプションで有効にする組み込み機能も提供されます。 `createUser`、`validateCredentials`、および `createChallenge` の 3 つのメソッドを実装する必要があります。

> [UserAuthentication セキュリティー検査](../user-authentication/)チュートリアルで詳細を参照してください。

## セキュリティー検査の構成
{: #security-check-configuration }

各セキュリティー検査実装クラスは、そのセキュリティー検査で使用可能なプロパティーを定義する `SecurityCheckConfiguration` クラスを使用できます。 各基本 `SecurityCheck` クラスには、対応する `SecurityCheckConfiguration` クラスが付属しています。 基本 `SecurityCheckConfiguration` クラスのいずれかを継承する実装を独自に作成し、それをカスタム・セキュリティー検査に使用できます。

例えば、`UserAuthenticationSecurityCheck` の `createConfiguration` メソッドは、`UserAuthenticationSecurityCheckConfig` のインスタンスを返します。

```java
public abstract class UserAuthenticationSecurityCheck extends CredentialsValidationSecurityCheck {
  @Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
      return new UserAuthenticationSecurityCheckConfig(properties);
  }
}
```

`UserAuthenticationSecurityCheckConfig` は、デフォルトの `0` を設定して `rememberMeDurationSec` というプロパティーを使用可能にします。

```java
public class UserAuthenticationSecurityCheckConfig extends CredentialsValidationSecurityCheckConfig {

    public int rememberMeDurationSec;

    public UserAuthenticationSecurityCheckConfig(Properties properties) {
        super(properties);
        rememberMeDurationSec = getIntProperty("rememberMeDurationSec", properties, 0);
    }

}
```

<br/>
これらのプロパティーは、以下のいくつかのレベルで構成できます。

### adapter.xml
{: #adapterxml }
Java アダプターの **adapter.xml** ファイル内で、`<securityCheckDefinition>` 内に 1 つ以上の `<property>` エレメントを追加できます。  
`<property>` エレメントには、以下の属性を設定できます。

- **name**: 構成クラスで定義されるプロパティーの名前。
- **defaultValue**: 構成クラスに定義されているデフォルト値をオーバーライドします。
- **displayName**: *オプション*。コンソールに表示する分かりやすい名前。
- **description**: *オプション*。コンソールに表示する説明。
- **type**: *オプション*。プロパティーが特定の型 (`integer`、`string`、`boolean`)、または有効な値のリスト (例えば、`type="['1','2','3']"`) になるようにします。

例:

```xml
<property name="maxAttempts" defaultValue="3" displayName="How many attempts are allowed?" type="integer"/>
```

> 実際の例については、CredentialsValidation セキュリティー検査チュートリアルの[セキュリティー検査の構成](../credentials-validation/security-check/#configuring-the-security-check)セクションを参照してください。

### {{ site.data.keys.mf_console }} - アダプター
{: #mobilefirst-operations-console-adapter }
{{ site.data.keys.mf_console }} →**「 [ご使用のアダプター] 」→「セキュリティー検査」タブ**で、**adapter.xml** ファイル内に定義されている任意のプロパティーの値を変更できます。  
この画面に表示されるのは、**adapter.xml** ファイルに定義されているプロパティー**のみ**です。構成クラスに定義されているプロパティーは、自動的にはここに表示されません。

![コンソールに表示されるアダプター](console-adapter-security.png)

必要な構成を指定してアダプターの構成 JSON ファイルを手動で編集し、変更を {{ site.data.keys.mf_server }} にプッシュして戻すこともできます。

1. **コマンド・ライン・ウィンドウ**から、プロジェクトのルート・フォルダーにナビゲートし、`mfpdev adapter pull` を実行します。
2. **project-folder\mobilefirst** フォルダーにある構成ファイルを開きます。
3. ファイルを編集します。`securityCheckDefinitions` オブジェクトを見つけてください。 このオブジェクト内で、選択したセキュリティー検査の名前を持つオブジェクトを見つけるか、作成します。 セキュリティー検査オブジェクト内で、properties オブジェクトを見つけるか、追加します。 構成する必要がある使用可能な各構成プロパティーについて、properties オブジェクト内に構成プロパティー名と値のペアを追加します。 例えば、次のとおりです。

   ```xml
   "securityCheckDefinitions": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "4",
                "failureExpirationSec: "90"
            }
        }
   }
   ```

4. コマンド `mfpdev adapter push` を実行することで、更新済み構成 JSON ファイルをデプロイします。

### {{ site.data.keys.mf_console }} - アプリケーション
{: #mobilefirst-operations-console-application }
プロパティー値はアプリケーション・レベルでもオーバーライドできます。

{{ site.data.keys.mf_console }} →**「 [ご使用のアプリケーション] 」→「セキュリティー」タブ**の**「セキュリティー検査構成」**セクションの下で、使用可能な各セキュリティー検査に定義されている値を変更できます。

<img class="gifplayer" alt="セキュリティー検査プロパティーの構成" src="console-application-security.png"/>

必要な構成を指定してアダプターの構成 JSON ファイルを手動で編集し、変更を {{ site.data.keys.mf_server }} にプッシュして戻すこともできます。

1. **コマンド・ライン・ウィンドウ**から、プロジェクトのルート・フォルダーにナビゲートし、`mfpdev app pull` を実行します。
2. **project-folder\mobilefirst** フォルダーにある構成ファイルを開きます。
3. ファイルを編集します。`securityCheckConfigurations` オブジェクトを見つけてください。 このオブジェクト内で、選択したセキュリティー検査の名前を持つオブジェクトを見つけるか、作成します。 セキュリティー検査オブジェクト内に、構成する必要がある使用可能な各構成プロパティーについて、構成プロパティーの名前と値のペアを追加します。 例えば、次のとおりです。

   ```xml
   "SecurityCheckConfigurations": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "2",
                "failureExpirationSec: "60"
            }
        }
   }
   ```

4. コマンド `mfpdev app push` を実行することで、更新済み構成 JSON ファイルをデプロイします。

## 事前定義セキュリティー検査
{: #predefined-security-checks }

以下の事前定義セキュリティー検査も使用可能です。

- [アプリケーション認証性](../application-authenticity/)
- [ダイレクト・アップデート](../../application-development/direct-update)
- LTPA

## 次のステップ
{: #what-s-next }

セキュリティー検査に関する以下のチュートリアルを続けてお読みください。  
開発が完了したとき、または変更が完了したときは、必ずアダプターをデプロイしてください。

* [CredentialsValidationSecurityCheck の実装](../credentials-validation/)。
* [UserAuthenticationSecurityCheck の実装](../user-authentication/)。
* {{ site.data.keys.product }} の追加の[認証およびセキュリティーの機能](../)について学習してください。
