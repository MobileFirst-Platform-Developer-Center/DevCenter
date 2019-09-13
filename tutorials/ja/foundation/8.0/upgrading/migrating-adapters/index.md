---
layout: tutorial
title: MobileFirst Server V8.0.0 で動作するようにするための既存のアダプターのマイグレーション
breadcrumb_title: Migrating existing adapters
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_server }} の v8.0 以降、アダプターは Maven プロジェクトになりました。 以前のバージョンの {{ site.data.keys.mf_server }} で開発されたアダプターをアップグレードする方法について説明します。

このページでは、MobileFirst Server V6.2 以降で動作するように開発されたアダプターをマイグレーションして、それらが {{ site.data.keys.mf_server }} v8.0 で動作するようにするために実行するステップについて説明します。  
まず、[v8.0 で非推奨となったフィーチャー、および v8.0 での API エレメントとサーバー・サイド API の変更](../../product-overview/release-notes/deprecated-discontinued/)に記載されている、アダプター API の変更について調べます。

* 特定の条件では、既存のアダプターはそのまま {{ site.data.keys.mf_server }} v8.0 で動作します。 [{{ site.data.keys.mf_server }} V8.0 で古いアダプターをそのまま使用する](#using-older-adapters-as-is-under-mobilefirst-server-v-80)を参照してください。
* ほとんどの場合、アダプターをアップグレードする必要があります。 Java™ アダプターの場合は、[{{ site.data.keys.mf_server }} v8.0 用の Maven プロジェクトへの Java アダプターのマイグレーション](#migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80)を参照してください。 JavaScript アダプターの場合は、[{{ site.data.keys.mf_server }} v8.0 用の Maven プロジェクトへの JavaScript アダプターのマイグレーション](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)を参照してください。

## {{ site.data.keys.mf_server }} v8.0 で古いアダプターをそのまま使用する
{: #using-older-adapters-as-is-under-mobilefirst-server-v-80 }
既存のアダプターは、以下のいずれの条件にも一致していなければ、{{ site.data.keys.mf_server }} v8.0 にそのままデプロイできます。

| アダプター・タイプ | 条件 | 
|--------------|-----------|
| Java | PushAPI または SecurityAPI のインターフェースを使用している | 
| JavaScript | {::nomarkdown}<ul><li>IBM Worklight V6.2 以前を使用してビルドされた。</li><li>HTTP でも SQL でもない接続タイプを使用している。</li><li>securityTest のカスタマイズが適用されたプロシージャーが含まれている</li><li>ユーザー ID を使用してバックエンドに接続するプロシージャーが含まれている</li><li>以下のいずれかの API を使用している<ul><li>WL.Device.*</li><li>WL.Geo.\*</li><li>WL.Server.readSingleJMSMessage</li><li>WL.Server.readAllJMSMessages</li><li>WL.Server.writeJMSMessage</li><li>WL.Server.requestReplyJMSMessage</li><li>WL.Server.getActiveUser</li><li>WL.Server.setActiveUser</li><li>WL.Server.getCurrentUserIdentity</li><li>WL.Server.getCurrentDeviceIdentity</li><li>WL.Server.createEventSource</li><li>WL.Server.createDefaultNotification</li><li>WL.Server.getUserNotificationSubscription</li><li>WL.Server.notifyAllDevices</li><li>WL.Server.notifyDeviceToken</li><li>WL.Server.notifyDeviceSubscription</li><li>WL.Server.sendMessage</li><li>WL.Server.createEventHandler</li><li>WL.Server.setEventHandlers</li><li>WL.Server.setApplicationContext</li><li>WL.Server.fetchNWBusinessObject</li><li>WL.Server.createNWBusinessObject</li><li>WL.Server.deleteNWBusinessObject</li><li>WL.Server.updateNWBusinessObject</li><li>WL.Server.getBeaconsAndTriggers</li><li>WL.Server.signSoapMessage</li><li>WL.Server.createSQLStatement</li></ul></li></ul>{:/} |

## {{ site.data.keys.mf_server }} v8.0 用の Maven プロジェクトへの Java アダプターのマイグレーション
{: #migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80}
1. archetype として **adapter-maven-archetype-java** を使用して、Maven アダプター・プロジェクトを作成します。 パラメーター **artifactId** を設定する際に、アダプター名を使用します。パラメーター **package** には、既存の Java アダプター内のものと同じパッケージを使用します。 詳しくは、[Java アダプターの作成](../../adapters/creating-adapters)を参照してください。
2. ステップ 1 で作成した新規アダプター・プロジェクトの **src/main/adapter-resources** フォルダー内にあるアダプター記述子ファイル (**adapter.xml**) を上書きします。記述子について詳しくは、[Java アダプター記述子ファイル](../../adapters/java-adapters/#the-adapter-resources-folder)を参照してください。
3. 新規アダプター・プロジェクトの **src/main/java** フォルダーからファイルをすべて削除します。 次に、古い Java アダプター・プロジェクトの **src/** フォルダーからすべての Java ファイルをコピーします。ただし、同じフォルダー構造を保持してください。 古いアダプターの **src** フォルダーからすべての非 Java ファイルを新規アダプターの **src/main/resources** フォルダーにコピーします。 デフォルトでは、**src/main/resources** は存在しないため、アダプターに非 Java ファイルが含まれている場合は、そのフォルダーを作成します。 Java アダプター API の変更については、[V8.0 でのサーバー・サイド API の変更](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)を参照してください。

   以下の図で、v7.1 までのアダプターおよび v8.0 からの Maven アダプターの構造を示します。

   ```xml
    ├── adapters
    │   └── RSSAdapter
    │       ├── RSSAdapter.xml
    │       ├── lib
    │       └── src
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```
    
   新しい Java アダプター構造:

   ```xml
    ├── pom.xml
    ├── src
    │   └── main
    │       ├── adapter-resources
    │       │   └── adapter.xml
    │       └── java
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```

4. 以下のいずれかの方法を使用して、Maven リポジトリーにない JAR ファイルを追加します。
    * 『[Guide to installing 3rd party JARs](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html)』の説明に従って JAR ファイルをローカル・リポジトリーに追加してから、それらのファイルを **dependencies** エレメントに追加する。
    * **systemPath** エレメントを使用して JAR ファイルを dependencies エレメントに追加する。 詳しくは、[Introduction to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html) を参照してください。

## {{ site.data.keys.mf_server }} v8.0 用の Maven プロジェクトへの JavaScript アダプターのマイグレーション
{: #migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80 }
1. archetype として **adapter-maven-archetype-http または adapter-maven-archetype-sql** を使用して、Maven アダプター・プロジェクトを作成します。 パラメーター **artifactId** を設定する際に、アダプター名を使用します。 詳しくは、[JavaScript アダプターの作成](../../adapters/creating-adapters)を参照してください。
2. ステップ 1 で作成した新規アダプター・プロジェクトの **src/main/adapter-resources** フォルダー内にあるアダプター記述子ファイル (**adapter.xml**) を上書きします。記述子について詳しくは、[JavaScript アダプター記述子ファイル](../../adapters/javascript-adapters/#the-adapter-resources-folder)を参照してください。
3. 新規アダプター・プロジェクトの **src/main/adapter-resources/js** フォルダーにある JavaScript ファイルを上書きします。
