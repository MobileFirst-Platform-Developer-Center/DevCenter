---
layout: tutorial
title: アプリケーション・サーバー上での Application Center のロギングおよびトレースの設定
breadcrumb_title: Setting up logging and tracing
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
特定のアプリケーション・サーバーについてロギングとトレース用のパラメーターを設定できるだけでなく、JNDI プロパティーを使用して、サポートされているすべてアプリケーション・サーバーで出力を制御することができます。

アプリケーション・サーバーごとに特定の方法で、Application Center のトレース・オペレーションにロギング・レベルと出力ファイルを設定できます。 また、{{ site.data.keys.product_full }} には、トレース出力のフォーマットやリダイレクトを制御したり、生成される SQL ステートメントを出力したりするための Java™ Naming and Directory Interface (JNDI) プロパティーが用意されています。

#### ジャンプ先
{: #jump-to }
* [WebSphere Application Server フル・プロファイルでのロギングとトレースの有効化](#logging-in-websphere)
* [WebSphere Application Server Liberty でのロギングとトレースの有効化](#logging-in-liberty)
* [Apache Tomcat でのロギングとトレースの有効化](#logging-in-tomcat)
* [トレース出力を制御する JNDI プロパティー](#jndi-properties-for-controlling-trace-output)

## WebSphere Application Server フル・プロファイルでのロギングとトレースの有効化
{: #logging-in-websphere }
アプリケーション・サーバーでのトレース・オペレーションに、ロギング・レベルと出力ファイルを設定することができます。

Application Center (または、{{ site.data.keys.product }} の他のコンポーネント) で問題の診断を試みるときは、ログ・メッセージを参照できることが重要です。 読み取り可能なログ・メッセージをログ・ファイルに出力するには、適切な設定を Java™ 仮想マシン (JVM) のプロパティーとして指定する必要があります。

1. WebSphere Application Server 管理コンソールを開きます。
2. **「トラブルシューティング (Troubleshooting)」→「ログおよびトレース (Logs and Trace)」**を選択します。
3. **「ロギングおよびトレース (Logging and tracing)」で**、適切なアプリケーション・サーバーを選択し、**「ログ詳細レベルの変更 (Change log detail levels)」**を選択します。
4. パッケージと、それに対応する詳細レベルを選択します。 この例は、Application Center を含む {{ site.data.keys.product }} に対し、**FINEST** レベル (**ALL** と同等) のロギングを有効にします。

```xml
com.ibm.puremeap.*=all
com.ibm.mfp.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

各部の意味は次のとおりです。

* **com.ibm.puremeap.*** は Application Center 用です。
* **com.ibm.mfp.**\*、**com.ibm.worklight.*** および **com.worklight.*** は、他の {{ site.data.keys.product_adj }} コンポーネント用です。

トレースは **trace.log** というファイルに送信されます。**SystemOut.log** や **SystemErr.log** には送信されません。

## WebSphere Application Server Liberty でのロギングとトレースの有効化
{: #logging-in-liberty }
Liberty アプリケーション・サーバー上の Application Center のトレース・オペレーションに、ロギング・レベルと出力ファイルを設定することができます。

Application Center で問題の診断を試みるときは、ログ・メッセージを参照できることが重要です。 読み取り可能なログ・メッセージをログ・ファイルに出力するには、適切な設定を指定する必要があります。

Application Center を含む {{ site.data.keys.product }} に対し FINEST レベル (ALL と同等) のロギングを有効にするには、server.xml に 1 つの行を追加します。 例えば、次のとおりです。

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.mfp.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

この例では、パッケージの複数の項目とそのロギング・レベルは、それぞれをコロン (:) で区切ります。

トレースは **trace.log** というファイルに送信されます。**messages.log** や **console.log** には送信されません。

詳しくは、[Libertyプロファイル: ロギングとトレース (Liberty profile: Logging and Trace)](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc) を参照してください。

## Apache Tomcat でのロギングとトレースの有効化
{: #logging-in-tomcat }
Apache Tomcat アプリケーション・サーバーで実行されるトレース・オペレーションに、ロギング・レベルと出力ファイルを設定することができます。

Application Center で問題の診断を試みるときは、ログ・メッセージを参照できることが重要です。 読み取り可能なログ・メッセージをログ・ファイルに出力するには、適切な設定を指定する必要があります。

Application Center を含む {{ site.data.keys.product }} に対し ** FINEST** レベル (**ALL** と同等) のロギングを有効にするには、**conf/logging.properties** ファイルを編集します。 例えば、以下のような行を追加します。

```xml
com.ibm.puremeap.level = ALL
com.ibm.mfp.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

詳しくは、[Tomcat でのロギング (Logging in Tomcat)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html) を参照してください。

## トレース出力を制御する JNDI プロパティー
{: #jndi-properties-for-controlling-trace-output }
サポートされているすべてのプラットフォームで、Java™ Naming and Directory Interface (JNDI) プロパティーを使用して、Application Center のトレース出力のフォーマットやリダイレクトを行ったり、生成される SQL ステートメントを出力したりすることができます。

以下の JNDI プロパティーが、Application Center サービス (**applicationcenter.war**) 用の Web アプリケーションに適用されます。

| プロパティーの設定 | 設定 | 説明 |
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | デフォルトでは、このプロパティーは false に設定されます。 ログ・ファイル内で読みやすくするために JSON 出力をブランク・スペースでフォーマットするには、この値を true に設定してください。 |
| ibm.appcenter.logging.tosystemerror | true | デフォルトでは、このプロパティーは false に設定されます。 システム・エラーへのすべてのログ・メッセージをログ・ファイルに出力するには、この値を true に設定してください。 このプロパティーを使用すると、グローバルなロギングをオンにすることができます。 |
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE | この設定は、生成されるすべての SQL ステートメントをログ・ファイルに出力します。 |
