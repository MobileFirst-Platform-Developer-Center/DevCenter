---
layout: tutorial
title: IBM Digital App Builder
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
**IBM Digital App Builder** は、ローコード・ツールであり、Watson サービスが提供する AI 機能を備えた、モバイル、Web、および PWA (プログレッシブ Web アプリケーション) マルチチャネル・アプリケーションを迅速に作成するのに役立ちます。 Digital App Builder を使用して作成されたアプリケーションは、セキュリティー、バックエンド接続、および分析のために IBM Mobile Foundation V8 (オンプレミスまたはクラウド) を利用します。

IBM Digital App Builder の主な特長は、以下のとおりです。

* このツールを使用して、マルチチャネルで実行できるデジタル・アプリケーションを迅速に作成できます。 Digital App Builder は、コンポーネントをドラッグ・アンド・ドロップしてアプリケーションを迅速に作成する機能を提供します。 このアプリケーションは、iOS (iPhone、iPad) のアプリケーション、Android (携帯電話、タブレット) のアプリケーション、プログレッシブ Web アプリケーション (PWA)、および Web ページなどの複数のチャネルをターゲットにすることができます。

* チャットボットや画像認識のような Watson AI 機能を簡単に統合できます。 チャットボットや画像認識機能をアプリケーションに追加するのが、コントロールの追加と同じくらい簡単になります。 また、質問と回答のセットを追加したり、分類する一連の画像をドラッグ・アンド・ドロップしたりすることで、AI サービスを簡単にトレーニングできます。 データ・サイエンティストが複雑な機械学習モデルを構築する必要はありません。

* マイクロサービス・バックエンド用のデータ・バインドされたコントロールを追加できます。 ウィザードを使用して、マイクロサービスの Open API 仕様 (Swagger) をインポートできます。 これは、アプリケーション内のデータ・バインドされた UI コントロールにバインドされたサービスのフロントエンドを作成するためのデータ・セットを作成するのに役立ちます。 アプリケーションの高度なコーディングを実行するために、コード・ビューに切り替えることができます。

* プッシュ通知サービスをエンゲージメントの一部として追加できます。

* アプリケーションがライブになった後、ライブ・アップデートを使用してアプリケーションの機能のオンとオフを動的に切り替えることができます。

* 実動環境の実際のマイクロサービスをシミュレーションするためのモック REST API をデプロイすることでアプリケーションをコード化できます。

* アプリケーション所有者は、アプリケーションに対して Analytics を有効にすることができます。 そうすると、アプリケーションは Mobile Foundation サーバーにデータを送信するようになります。

作成されたアプリケーションは、Cordova、Ionic、Angular などのオープン・ソース・テクノロジーを使用します。 アプリケーションがデプロイされる前に、さまざまなフォーム・ファクターでアプリケーションをプレビューすることができます。 クイック・スタート・テンプレートを使用して、アプリケーションを作成することもできます (例えば、Watson チャットボット)。

## Digital App Builder 入門サンプル
{: #samples-dab}

1. [Digital App Builder を使用して新規サンプル・アプリケーションを作成する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/1-getting-started)
2. [新規アプリケーションに Watson Chatbot を追加する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/2-watson-chatbot)
3. [アプリケーションにアプリケーション機能コードを追加する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/3-toggle-design-code)
4. [いくつかのモック・バックエンド API を作成することによって、アプリケーションをバックエンド・コードに対してテストする。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/3-toggle-design-code)
5. [アプリケーションからマイクロサービス・バックエンドを起動する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/5-microservice-invocation)
6. [API プロキシーを使用して、アプリケーションからバックエンド・マイクロサービスを起動する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/6-api-proxy)
7. [アプリケーション通知を送信する機能を追加することによって、アプリケーション・ユーザーをエンゲージする。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/7-push-notifications)
8. [アプリケーションが提供するフィーチャーを制御するためにフィーチャー切り替え機能を追加する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/8-liveupdate)
9. [カスタム分析を追加することによって、アプリケーション使用法の洞察を得る。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/9-custom-analytics)
10. [アプリケーション内フィードバックを使用することによって、アプリケーションのフィードバックを listen する。](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted/tree/release80/10-inapp-feedback)

>**注:** 上記の Digital App Builder サンプルを使用した入門のために、[この Git リポジトリー](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)の Readme にある指示に従うこともできます。

### 使用するチュートリアル
{: #tutorials-to-follow }

製品の詳細情報については以下を参照してください。
