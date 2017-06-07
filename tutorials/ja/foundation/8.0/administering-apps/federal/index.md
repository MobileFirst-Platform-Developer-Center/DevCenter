---
layout: tutorial
title: MobileFirst Foundation での連邦標準サポート
breadcrumb_title: 連邦標準サポート
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} は、Federal Desktop Core Configuration (FDCC) および United States Government Configuration Baseline (USGCB) の仕様をサポートします。また、{{ site.data.keys.product }} は、暗号モジュールを認可するために使用されるセキュリティー標準である連邦情報処理標準 (FIPS) 140-2 もサポートします。

#### ジャンプ先
{: #jump-to }

* [FDCC および USGCB サポート](#fdcc-and-usgcb-support)
* [FIPS 140-2 サポート](#fips-140-2-support)
* [FIPS 140-2 の有効化](#enabling-fips-140-2)
* [HTTPS および JSONStore 暗号化のための FIPS 140-2 モードの構成](#configure-fips-140-2-mode-for-https-and-jsonstore-encryption)
* [既存のアプリケーションのための FIPS 140-2 の構成](#configuring-fips-140-2-for-existing-applications)

## FDCC および USGCB サポート
{: #fdcc-and-usgcb-support }
アメリカ合衆国連邦政府は、Microsoft Windows プラットフォーム上で稼働する連邦政府関係機関デスクトップに対して、Federal Desktop Core Configuration (FDCC) セキュリティー設定またはより新しい United States Government Configuration Baseline (USGCB) セキュリティー設定の採用を義務付けています。

IBM Worklight V5.0.6 は、自己認証プロセスを介して USGCB および FDCC セキュリティー設定を使用してテスト済みです。テストには、インストールおよびコア・フィーチャーがこの構成で機能することを保証する適正な水準のテストが含まれています。

#### 参照
{: #references }
詳細については、[USGCB](http://usgcb.nist.gov/) を参照してください。

## FIPS 140-2 サポート
{: #fips-140-2-support }
連邦情報処理標準 (FIPS) は、米国連邦情報・技術局 (NIST) によって連邦政府コンピューター・システム用に発行される標準および指針です。FIPS 資料 140-2 は、暗号モジュールを認可するために使用されるセキュリティー標準です。{{ site.data.keys.product }} は、Android アプリケーションおよび iOS Cordova アプリケーションに対して FIPS 140-2 をサポートします。

### {{ site.data.keys.mf_server }} に関する FIPS 140-2、および {{ site.data.keys.mf_server }} との SSL 通信
{: #fips-140-2-on-the-mobilefirst-server-and-ssl-communications-with-the-mobilefirst-server }
{{ site.data.keys.mf_server }} は、WebSphere  Application Server などのアプリケーション・サーバー上で稼働します。インバウンドおよびアウトバウンド Secure Socket Layer (SSL) 接続に対して FIPS 140-2 検証済み暗号モジュールを使用するように WebSphere Application Server を構成することができます。これらの暗号モジュールは、アプリケーションが Java Cryptography Extension (JCE) を使用して実行する暗号操作に対しても使用されます。{{ site.data.keys.mf_server }} はアプリケーション・サーバー上で稼働するアプリケーションであるため、インバウンドおよびアウトバウンドの SSL 接続に FIPS 140-2 検証済み暗号モジュールを使用します。

{{ site.data.keys.product_adj }} クライアントが、FIPS 140-2 モードを使用しているアプリケーション・サーバー上で稼働している {{ site.data.keys.mf_server }} に対して Secure Socket Layer (SSL) 接続のトランザクションを行うと、FIPS 140-2 承認済み暗号スイートが正しく使用されます。クライアント・プラットフォームが FIPS 140-2 承認済み暗号スイートの 1 つをサポートしていない場合は、SSL トランザクションが失敗し、クライアントはサーバーへの SSL 接続を確立できません。成功すれば、クライアントは FIPS 140-2 承認済み暗号スイートを使用します。

> **注:** クライアントで使用される暗号モジュール・インスタンスは必ずしも FIPS 140-2 検証済みである必要はありません。クライアント・デバイス上の FIPS 140-2 検証済みライブラリーを使用するオプションについては、以下を参照してください。

具体的にいえば、クライアントとサーバーは同じ暗号スイート (SSL_RSA_WITH_AES_128_CBC_SHA など) を使用しているが、クライアント・サイドの暗号モジュールが恐らく FIPS 140-2 検証プロセスを経ていないのに、サーバー・サイドが FIPS 140-2 認定済みモジュールを使用しているということがあります。

### JSONStore に保管されているデータおよび HTTPS 通信使用時における移動中のデータを保護するための {{ site.data.keys.product_adj }} クライアント・デバイスでの FIPS 140-2
{: #fips-140-2-on-the-mobilefirst-client-device-for-protection-of-data-at-rest-in-jsonstore-and-data-in-motion-when-using-https-communications }
クライアント・デバイスに保管されているデータの保護は、{{ site.data.keys.product }} の JSONStore フィーチャーによって行われます。移動中のデータの保護は、{{ site.data.keys.product_adj }} クライアントと {{ site.data.keys.mf_server }} 間で HTTPS 通信を使用することによって確保されます。

iOS デバイスでは、FIPS 140-2 のサポートは保存データと移動中のデータの両方に対してデフォルトで有効です。

Android デバイスは、デフォルトでは、FIPS 140-2 検証済みではないライブラリーを使用します。JSONStore が保管するローカル・データの保護 (暗号化と暗号化解除) および {{ site.data.keys.mf_server }} への HTTPS 通信のために FIPS 140-2 検証済みライブラリーを使用するオプションがあります。このサポートは、FIPS 140-2 検証 (証明書 #1747) を通った OpenSSL ライブラリーによって獲得されます。このオプションを {{ site.data.keys.product_adj }} クライアント・プロジェクトで有効にするには、オプションの Android FIPS 140-2 プラグインを追加してください。

**注:** 知っておくべき制約事項がいくつかあります。

* この FIPS 140-2 検証モードは、JSONStore 機能によって保管されたローカル・データの保護 (暗号化)、および {{ site.data.keys.product_adj }} クライアントと {{ site.data.keys.mf_server }} の間の HTTPS 通信の保護にのみ適用されます。
* この機能は、iOS および Android プラットフォームでのみサポートされます。
    * Android では、この機能は、x86 または armeabi アーキテクチャーを使用するデバイスまたはシミュレーターでのみサポートされます。armv5 または armv6 アーキテクチャーを使用する Android ではサポートされません。これは、使用される OpenSSL ライブラリーが、Android の armv5 または armv6 のための FIPS 140-2 検証を取得していないためです。{{ site.data.keys.product_adj }} ライブラリーは 64 ビット・アーキテクチャーをサポートしていますが、FIPS 140-2 は 64 ビット・アーキテクチャーではサポートされていません。FIPS 140-2 を 64 ビットのデバイス上で実行できるのは、プロジェクトに 32 ビットのネイティブ NDK ライブラリーのみが含まれる場合です。
    * iOS では、i386、x86_64、armv7、armv7s、および arm64 アーキテクチャーでサポートされます。
* この機能は、ハイブリッド・アプリケーションのみで機能します (ネイティブ・アプリケーションでは機能しません)。
* ネイティブ iOS の場合、FIPS は iOS FIPS ライブラリーを通じて有効になります。これはデフォルトで有効になっています。FIPS 140-2 を有効にするために、アクションは必要ありません。
* HTTPS 通信の場合:
    * Android デバイスの場合、{{ site.data.keys.product_adj }} クライアントと {{ site.data.keys.mf_server }} の間の通信のみが、クライアントで FIPS 140-2 ライブラリーを使用します。その他のサーバーまたはサービスへの直接接続では、FIPS 140-2 ライブラリーを使用しません。
    * {{ site.data.keys.product_adj }}クライアントは、サポートされている環境で実行されている {{ site.data.keys.mf_server }} とのみ通信できます。サポートされている環境は『[System Requirements](http://www-01.ibm.com/support/docview.wss?uid=swg27024838)』にリストされています。{{ site.data.keys.mf_server }} が非サポート環境で実行されている場合、「鍵サイズが小さすぎます (key size too small)」というエラーにより HTTPS 接続が失敗する可能性があります。このエラーは、HTTP 通信では発生しません。
* {{ site.data.keys.mf_app_center_full }} クライアントでは、FIPS 140-2 フィーチャーはサポートされません。

このチュートリアルで説明されている変更をこれまでに行った場合は、まず、環境に固有なその他の変更を保存してから、Android 環境または iOS 環境を削除して再作成してください。

![FIPS ダイアグラム](FIPS.jpg)

> JSONStore について詳しくは、[JSONStore の概要](../../application-development/jsonstore)を参照してください。

## 参照
{: #references-1 }
WebSphere Application Server で FIPS 140-2 モードを使用可能にする方法については、[連邦情報処理標準サポート](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/rovr_fips.html)を参照してください。

WebSphere Application Server Liberty プロファイルの場合、FIPS 140-2 モードを使用可能にするためのオプションが管理コンソールにありません。ただし、FIPS 140-2 検証済みモジュールを使用するように Java™ ランタイム環境を構成することで FIPS 140-2 を使用可能にすることができます。詳しくは、Java Secure Socket Extension (JSSE) IBMJSSE2 Provider Reference Guide を参照してください。

## FIPS 140-2 の有効化
{: #enabling-fips-140-2 }
iOS デバイスでは、FIPS 140-2 のサポートは保存データと移動中のデータの両方に対してデフォルトで有効です。  
Android デバイスの場合は、`cordova-plugin-mfp-fips` Corodva プラグインを追加します。

追加すると、HTTPS と JSONStore の両方のデータ暗号化に機能が適用されます。

**注:** 

* FIPS 140-2 は Android および iOS でのみサポートされます。FIPS 140-2 をサポートする iOS アーキテクチャーは、i386、armv7、armv7s、x86_64、および arm64 です。FIPS 140-2 をサポートする Android アーキテクチャーは、x86 および armeambi です。
* Android では、{{ site.data.keys.product_adj }} ライブラリーは 64 ビット・アーキテクチャーをサポートしていますが、FIPS 140-2 は 64 ビット・アーキテクチャーではサポートされていません。64 ビット・デバイスで FIPS 140-2 を使用すると、次のエラーが発生する場合があります。 
        
```bash
java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit
```

このエラーは、Android プロジェクト内に 64 ビットのネイティブ・ライブラリーがあるが、それらのライブラリーを使用した時に FIPS 140-2 が正しく機能しないことを意味しています。確認するために、Android プロジェクトの下の src/main/libs または src/main/jniLibs に移動し、x86_64 フォルダーまたは arm64-v8a フォルダーがあるかどうか確認してください。フォルダーがある場合は、これらのフォルダーを削除すると、FIPS 140-2 は再び機能できるようになります。

## HTTPS および JSONStore 暗号化のための FIPS 140-2 モードの構成
{: #configure-fips-140-2-mode-for-https-and-jsonstore-encryption }
iOS アプリケーションでは、FIPS 140-2 は iOS FIPS ライブラリーにより使用可能になります。これはデフォルトで使用可能になっているため、使用可能にしたり構成したりするアクションは必要ありません。

次のコード・スニペットは、FIPS 140-2 を構成するために、Android オペレーティング・システムの index.js 内の、initOptions オブジェクトの新しい {{ site.data.keys.product_adj }} アプリケーションに取り込まれるものです。

```javascript
var wlInitOptions = {
  ...
  // # Enable FIPS 140-2 for data-in-motion (network) and data-at-rest (JSONStore) on Android.
//   Requires the FIPS 140-2 optional feature to be enabled also.
// enableFIPS : false
  ...
};
```

Android オペレーティング・システムでは、 **enableFIPS** のデフォルト値は `false` です。HTTPS データ暗号化と JSONStore データ暗号化の両方に対して FIPS 140-2 を有効にするには、このオプションをアンコメントし、`true` に設定してください。**enableFIPS** の値を `true` に設定した後は、次のサンプルのような listen イベントを作成することにより、FIPS 対応 JavaScript イベントを listen する必要があります。

```javascript
document.addEventListener('WL/FIPS/READY', 
    this.onFipsReady, false);

onFipsReady: function() {
// FIPS SDK is loaded and ready
}
```

**enableFIPS** プロパティーの値を設定した後、Android プラットフォームを再ビルドします。

**注:* * enableFIPS プロパティーを true に設定する前に、FIPS Cordova プラグインをインストールする必要があります。これを怠ると、initOption 値は設定されているがオプション・フィーチャーが見つからなかったという警告メッセージがログに記録されます。FIPS 140-2 フィーチャーと JSONStore フィーチャーは、Android オペレーティング・システムでは両方ともオプションです。FIPS 140-2 は、JSONStore オプション・フィーチャーも同時に有効になっている場合にのみ、JSONStore データ暗号化に作用します。JSONStore が有効になっていなければ、FIPS 140-2 は JSONStore に作用しません。iOS では、JSONStore FIPS 140-2 (保存データ) および HTTPS 暗号化 (移動中のデータ) はどちらも iOS で処理されるため、FIPS 140-2 オプション・フィーチャーは不要です。Android では、JSONStore FIPS 140-2 または HTTPS 暗号化を使用する場合は、FIPS 140-2 オプション・フィーチャーを使用可能にする必要があります。

```bash
[WARN] FIPSHttp feature not found, but initOptions enables it on startup
```

## 既存のアプリケーションのための FIPS 140-2 の構成
{: #configuring-fips-140-2-for-existing-applications }
Android オペレーティング・システムの任意のバージョン用に作成されたアプリケーションと、バージョン 8.0 より前のバージョンの {{ site.data.keys.product_full }} の iOS アプリケーションで、デフォルトでは FIPS 140-2 オプション・フィーチャーは使用不可です。Android オペレーティング・システムに対して FIPS 140-2 オプション・フィーチャーを使用可能にするには、『FIPS 140-2 の有効化』を参照してください。このオプション・フィーチャーが有効になってから、FIPS 140-2 を構成することができます。

『FIPS 140-2 の有効化』で説明されているステップを完了した後、index.js ファイル内の initOptions オブジェクトを変更して FIPS 構成プロパティーを追加することによって FIPS 140-2 を構成する必要があります。

**注:** FIPS 140-2 フィーチャーは JSONStore フィーチャーと併用されて、JSONStore に対する FIPS 140-2 のサポートを有効にします。これらのフィーチャーの併用は、IBM  Worklight V6.0 以前で使用可能なチュートリアル「JSONStore - Encrypting sensitive data with FIPS 140-2」で記述された内容に代わるものです。このチュートリアル内の指示に従ってこれまでに変更したアプリケーションがある場合は、そのアプリケーションの iPhone、iPad、および Android の各環境を削除して再作成してください。これまでに行った環境固有の変更は、環境を削除すると失われるので、環境を削除する前にそれらの変更を必ずバックアップしてください。環境を再作成すると、それらの変更を新しい環境に再適用することができます。

以下のプロパティーを index.js ファイル内の initOptions オブジェクトに追加します。

```javascript
enableFIPS : true
```

Android プラットフォームを再ビルドします。
