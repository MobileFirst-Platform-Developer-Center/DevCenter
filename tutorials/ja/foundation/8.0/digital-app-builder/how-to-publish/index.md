---
layout: tutorial
title: IBM App Center へのアプリケーションの公開
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## App Center へのアプリケーションの公開
{: #dab-app-publish }

IBM MobileFirst Foundation Application Center は、モバイル・アプリケーションのリポジトリーです。公開アプリケーション・ストアに似ていますが、組織またはチームのニーズに焦点を置いています。 これはプライベートなアプリケーション・ストアです。 App Center について詳しくは、[こちら](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/app-center-tutorial/)を参照してください。

Digital App Builder の**「公開 (Publish)」**機能を使用して、アプリケーションをサーバー上のリポジトリーに追加できます。

>**注**: App Center へ公開する前に、エラーなしの状態でアプリケーションがビルドされていることを確認してください。

1. アプリケーション・プロジェクトで、**「公開 (Publish)」**をクリックします。 これにより、プラットフォームが選択された状態のポップアップが表示されます。

    ![公開](dab-publish.png)

2. **「App Center に公開する (Publish to App Center)」**をクリックします。

    ![「App Center に公開する (Publish to App Center)」](dab-publish-app-center.png)

3. 既存の App Center を選択するか、**「新規接続 (Connect New)」**をクリックします。 **「接続」**をクリックします。
4. これにより、選択されたプラットフォーム向けのパッケージがビルドされます。
5. *iOS のみ*: *app-build.json* ファイルを編集し、`developmentTeam` フィールドを Apple Developer チーム ID で更新してください。 チーム ID を見つけるには、[Apple Developer アカウント](https://developer.apple.com/account/#/membership)にログインしてください。 

    ![iOS 公開](dab-publish-ios.png)

6. パッケージの準備ができたら、**「公開 (Publish)」**をクリックします。
7. 正常に公開されると、QR コードが生成されます。

    ![App Center への公開と QR コード](dab-publish-code-scan.png)

8. **App Center** > **「アプリケーション管理 (Application Management)」**にログインすることで、App Center 内でアプリケーションが使用可能であることを検証できます。

>**注**: 必要なプラットフォームを再度選択し、アプリケーションをビルドして**「App Center」**へ公開できます。

