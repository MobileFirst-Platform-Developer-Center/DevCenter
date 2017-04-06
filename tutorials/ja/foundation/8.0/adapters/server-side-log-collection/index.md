---
title: サーバー・サイドのログ収集
breadcrumb_title: サーバー・サイドのログ収集
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

ロギングは、診断およびデバッグを容易にするために、API 呼び出しを使用してメッセージを記録するソース・コードの装備です。{{site.data.keys.mf_server }} は、どのログをリモート側で収集するかを制御する機能を提供します。これにより、サーバー管理者はサーバー・リソースをさらにきめ細かく調整することができます。

ロギング・ライブラリーには通常、詳細度制御 (多くの場合、**レベル**と呼ばれる) があります。詳細度の低い方から順に、ERROR、WARN、INFO、DEBUG です。 

## アダプター内のログ収集
{: #log-collection-in-adapters }

基礎となるアプリケーション・サーバーのロギング・メカニズムで、アダプター内のログを表示できます。  
WebSphere のフル・プロファイルおよび Liberty プロファイルでは、指定のロギング・レベルに応じて **messages.log** ファイルおよび **trace.log** ファイルが使用されます。 

[Java アダプター](java-adapter)および [JavaScript アダプター](javascript-adapter)のチュートリアルで説明しているとおり、これらのログを Analytics コンソールに転送することもできます。

## ログ・ファイルへのアクセス
{: #accessing-the-log-files }

* {{site.data.keys.mf_server }} のオンプレミス・インストールでは、このファイルは基礎となるアプリケーション・サーバーに応じて使用可能です。 
    * [IBM WebSphere Application Server のフル・プロファイル](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server の Liberty プロファイル](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* クラウド・デプロイメントでログを取得するには、以下を使用します。
    * IBM Containers または Liberty Build Pack。[IBM Containers ログおよびトレースの収集](../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/)チュートリアルを参照してください。
    * Mobile Foundation Bluemix サービス。[Mobile Foundation の使用](../../bluemix/using-mobile-foundation)チュートリアルの[サーバー・ログへのアクセス](../../bluemix/using-mobile-foundation/#accessing-server-logs)セクションを参照してください。
