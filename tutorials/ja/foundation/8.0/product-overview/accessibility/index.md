---
layout: tutorial
title: IBM MobileFirst Foundation のアクセシビリティー機能
breadcrumb_title: アクセシビリティー機能
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
アクセシビリティー機能は、運動障がいや視覚障がいなどの障がいを持つユーザーが情報技術コンテンツを快適に使用できるように支援します。

### アクセシビリティー機能
{: #accessibility-features }
{{ site.data.keys.product_full }} には、次の主要なアクセシビリティー機能が組み込まれています。

* キーボードのみによる操作
* スクリーンリーダーを使用する操作

{{ site.data.keys.product }} では、[US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards)、および [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/) に準拠するために、最新の W3C 標準である [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/) が使用されています。アクセシビリティー機能を活用するには、最新リリースのスクリーン・リーダーを、この製品でサポートされる最新の Web ブラウザーと組み合わせて使用してください。

### キーボードによるナビゲーション
{: #keyboard-navigation }
この製品では、標準のナビゲーション・キーを使用します。

### インターフェースに関する情報
{: #interface-informaton }
{{ site.data.keys.product }} のユーザー・インターフェースには、1 秒あたり 2 回から 55 回明滅するコンテンツは含まれていません。

デジタル音声シンセサイザーを用いたスクリーン・リーダーを使用して、画面上の表示内容を聞き取ることができます。本製品およびその資料での支援技術の使用方法について詳しくは、ご使用の支援技術の資料を参照してください。

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
デフォルトでは、{{ site.data.keys.mf_cli }} で表示される状況メッセージには、正常終了、エラー、警告を表すため、さまざまな色が使用されます。どの {{ site.data.keys.mf_cli }} コマンドでも、`--no-color` オプションを使用することで、そのコマンドでのそれらの色の使用を抑止できます。`--no-color` を指定すると、出力は、オペレーティング・システム・コンソールに設定されているテキスト表示色で表示されます。

### Web インターフェース 
{: #web-interface }
{{ site.data.keys.product }} の Web ユーザー・インターフェースは、カスケーディング・スタイル・シートに依存することで、コンテンツを適切にレンダリングし、使いやすい操作画面を提供しています。このアプリケーションには、低視力のお客様がご使用のシステム表示設定（ハイコントラスト・モードなど）を使用できるように、同等の方法が用意されています。フォント・サイズの制御は、デバイスの設定または Web ブラウザーの設定を使用して行うことができます。

キーボード・ショートカットを使用することで、各種 {{ site.data.keys.product_adj }} 環境とそれぞれの資料をナビゲートできます。Eclipse には、その開発環境のためのアクセシビリティー機能が備わっています。 また、インターネット・ブラウザーにも、Web アプリケーション (例えば {{ site.data.keys.mf_console }}、{{ site.data.keys.mf_analytics_console }}、{{ site.data.keys.product }} Application Center コンソール、{{ site.data.keys.product }} Application Center モバイル・クライアントなど) のためのアクセシビリティー機能が備わっています。

{{ site.data.keys.product }} Web ユーザー・インターフェースには WAI-ARIA ナビゲーション・ランドマークが含まれています。これを使用して、アプリケーションの機能領域に素早く移動できます。

### インストールおよび構成
{: #installation-and-configuration }
{{ site.data.keys.product }} をインストールして構成するには、グラフィカル・ユーザー・インターフェース (GUI) による方法と、コマンド・ラインによる方法の 2 つがあります。

グラフィカル・ユーザー・インターフェース (ウィザード・モードの IBM Installation Manager や、サーバー構成ツール) ではユーザー・インターフェース・オブジェクトに関する情報は提供されませんが、同等の機能をコマンド・ライン・インターフェースでは利用できます。GUI の機能はすべてコマンド・ラインでサポートされます。また、コマンド・ラインのみで使用できる特定のインストール機能や構成機能もいくつかあります。[IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) のアクセシビリティー機能については、IBM Knowledge Center を参照してください。

以下のトピックに、GUI を使用せずにインストールおよび構成を実行する方法についての情報があります。

* IBM Installation Manager 用のサンプル応答ファイルの処理
この方法を使用すると、{{ site.data.keys.mf_server }} および Application Center のサイレント・インストールと構成を行うことができます。install-no-appcenter.xml という応答ファイルを使用することで、Application Center がインストールされないようにすることができます。その場合、Ant タスクを使用して、後の段階でそれをインストールできます。『Ant タスクを使用した Application Center のインストール』を参照してください。この場合、Application Center のインストールとアップグレードをそれぞれ単独で行うことができます。
* Ant タスクを使用したインストール
* Ant タスクを使用した Application Center のインストール

### ベンダー・ソフトウェア
{: #vendor-software }
{{ site.data.keys.product }} には、IBM 使用許諾契約書の対象とはならない特定のベンダー・ソフトウェアが含まれています。これらの製品のアクセシビリティー機能について、IBM は一切の保証責任を負いません。ベンダー製品のアクセシビリティー情報については、そのベンダーにお問い合せください。

### アクセシビリティー関連情報
{: #related-accessibility-information }
標準の IBM ヘルプ・デスクとサポート Web サイトに加え、IBM は、耳の不自由なお客様が営業やサポート・サービスにアクセスするために使用できる TTY 電話サービスを立ち上げました。

TTY サービス  
800-IBM-3383 (800-426-3383)  
(北米内)

### IBM とアクセシビリティー
{: #ibm-and-accessibility }
IBM のアクセシビリティーへの取り組みについて詳しくは、[IBM Accessibility](http://www.ibm.com/able) を参照してください。


