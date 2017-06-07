---
layout: tutorial
title: MobileFirst Server の Eclipse への使用
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.mf_server }} は、Eclipse IDE に統合することができます。これにより、開発エクスペリエンスを一元化することができます。

* また、Eclipse で CLI 機能を使用できるようにすることも可能です。[Eclipse での {{ site.data.keys.mf_server }} の使用](../../../../application-development/using-mobilefirst-cli-in-eclipse)のチュートリアルを参照してください。
* さらに、Eclipse でアダプターを開発できます。[Eclipse でのアダプターの開発](../../../../adapters/developing-adapters)のチュートリアルを参照してください。

### Eclipse へのサーバーの追加
{: #adding-the-server-to-eclipse }
1. Eclipse の**「サーバー」**ビューから、**「新規」→「サーバー」**を選択します。
2. IBM フォルダー・オプションが存在しない場合は、「追加サーバー・アダプターをダウンロード」をクリックします。
3. **「WebSphere Application Server Liberty Tools」**を選択して画面の指示に従います。
4. Eclipse の**「サーバー」**ビューから、**「新規」→「サーバー」**を選択します。
5. **「IBM」→「WebSphere Application Server Liberty」**を選択します。
6. サーバーの**「名前」**と**「ホスト名」**を指定し、**「次へ」**をクリックします。
7. サーバーのルート・ディレクトリーへのパスを指定し、使用する JRE バージョンを選択します。{{ site.data.keys.mf_dev_kit }} を使用した場合、ルート・ディレクトリーは **[インストール・ディレクトリー]/mfp-server** フォルダーです。
8. **「次へ」**をクリックして、**「終了」**をクリックします。

これで、Eclipse IDE の「サーバー」ビューから {{ site.data.keys.mf_server }} の始動および停止を行えます。
