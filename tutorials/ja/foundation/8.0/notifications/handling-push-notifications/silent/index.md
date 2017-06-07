---
layout: tutorial
title: サイレント通知
relevantTo: [ios,cordova]
show_in_nav: false
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
サイレント通知は、アラートを表示しない、あるいはユーザーを妨げない通知です。サイレント通知が到着すると、アプリケーションをフォアグラウンドに移行せずに、アプリケーションの処理コードがバックグラウンドで実行されます。現在、サイレント通知は、バージョン 7 以降の iOS デバイスでサポートされています。バージョン 7 より低いバージョンの iOS デバイスにサイレント通知が送信された場合、アプリケーションがバックグラウンドで実行されていると、通知は無視されます。アプリケーションがフォアグラウンドで実行されていると、通知のコールバック・メソッドが呼び出されます。

## サイレント・プッシュ通知の送信
{: #sending-silent-push-notifications }
通知を準備して送信します。詳しくは、[プッシュ通知の送信](../../sending-notifications)を参照してください。

iOS 用にサポートされている 3 つのタイプの通知は、`DEFAULT`、`SILENT`、および `MIXED` という定数で表されます。タイプが明示的に指定されない場合は `DEFAULT` タイプとみなされます。

`MIXED` タイプの通知の場合、デバイスにメッセージが表示され、一方、バックグラウンドではアプリケーションが起動してサイレント通知を処理します。`MIXED` タイプの通知のコールバック・メソッドは、2 回呼び出されます。サイレント通知がデバイスに到達したときと、通知をタップしてアプリケーションが開かれたときです。

要件に応じて、**{{ site.data.keys.mf_console }} →「 [ご使用のアプリケーション] 」→「プッシュ」→「通知の送信」→「iOS カスタム設定」**で、適切なタイプを選択します。 

> **注:** 通知がサイレントの場合、**アラート**、**サウンド**、および**バッジ**のプロパティーは無視されます。

![{{ site.data.keys.mf_console }} での iOS サイレント通知の通知タイプの設定](notification-type-for-silent-notifications.png)

## Cordova アプリケーションでのサイレント・プッシュ通知の処理
{: #handling-silent-push-notifications-in-cordova-applications }
JavaScript プッシュ通知のコールバック・メソッド内で、以下のステップを実行する必要があります。

1. 通知タイプをチェックします。例えば、次のとおりです。

   ```javascript
   if(props['content-available'] == 1) {
        //Silent Notification or Mixed Notification. Perform non-GUI tasks here.
   } else {
        //Normal notification
   }
   ```

2. 通知がサイレントまたは混合の場合は、バックグラウンド・ジョブの実行後に `WL.Client.Push.backgroundJobDone` API を呼び出します。

## ネイティブ iOS アプリケーションでのサイレント・プッシュ通知の処理
{: #handling-silent-push-notifications-in-native-ios-applications }
サイレント通知を受け取るには、以下のステップに従う必要があります。

1. リモート通知の受信時にバックグラウンド・タスクを実行するアプリケーション機能を有効にします。
2. `content-available` キーが **1** に設定されているかどうかを検査することで、通知がサイレントであるかどうかを調べます。
3. 通知の処理が終了したら、handler パラメーターのブロックをすぐに呼び出す必要があります。そうしないと、アプリケーションは強制終了されます。アプリケーションは通知の処理を最大 30 秒待ち、指定の完了ハンドラー・ブロックを呼び出します。
