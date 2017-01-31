---
layout: tutorial
title: 単純データ共有
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
単純データ共有フィーチャーにより、単一のデバイスにおいて、アプリケーション・ファミリー間で軽量情報を安全に共有できるようになります。
このフィーチャーは、さまざまなモバイル SDK に既に存在するネイティブ API を使用して、1 つの統一された開発者 API を提供します。
この {{site.data.keys.product_adj }} API は、さまざまなプラットフォームの複雑性を抽象化して、アプリケーション間通信を可能にするコードを開発者が迅速に実装できるようにします。

このフィーチャーは、iOS および Android で、Cordova アプリケーションとネイティブ・アプリケーションの両方についてサポートされています。

単純データ共有フィーチャーを有効にしたら、提供された Cordova API およびネイティブ API を使用して、デバイス上のアプリケーション・ファミリー間で単純ストリング・トークンを交換できます。

#### ジャンプ先
{: #jump-to}
* [用語](#terminology)
* [単純データ共有フィーチャーの有効化](#enabling-the-simple-data-sharing-feature)
* [単純データ共有 API の概念](#simple-data-sharing-api-concepts)
* [制限と考慮事項](#limitations-and-considerations)

## 用語
{: #terminology }
### {{site.data.keys.product_adj }} アプリケーション・ファミリー
{: #mobilefirst-application-family }
アプリケーション・ファミリーとは、同じレベルの信頼を共有するアプリケーションのグループを関連付けるための手段です。
同じファミリー内のアプリケーションは、セキュアにかつ安全に、互いに情報を共有できます。


同じ {{site.data.keys.product_adj }} アプリケーション・ファミリーの一部とみなされるには、同じファミリー内のすべてのアプリケーションが以下の要件に準拠している必要があります。

* アプリケーション記述子でアプリケーション・ファミリーに同じ値を指定する。
	* iOS アプリケーションの場合、この要件は、アクセス・グループ資格値と同義です。
	* Android アプリケーションの場合、この要件は、**AndroidManifest.xml** ファイル内の **sharedUserId** 値と同義です。
		
    > **注:** Android の場合、名前は **x.y** 形式でなければなりません。

* アプリケーションは、同じ署名 ID で署名されなければならない。
この要件は、同じ組織のアプリケーションのみがこのフィーチャーを使用できるということを意味します。	
    * iOS アプリケーションの場合、この要件は、同じアプリケーション ID 接頭部、同じプロビジョニング・プロファイル、および同じ署名 ID を使用してアプリケーションに署名する、ということを意味します。
	* Android アプリケーションの場合、この要件は、同じ署名証明書と署名鍵が使用される、ということを意味します。

{{site.data.keys.product }} 提供の API に加えて、同じ {{site.data.keys.product_adj }} アプリケーション・ファミリー内の各アプリケーションは、それぞれのネイティブ・モバイル SDK API を通じて使用可能なデータ共有 API を使用することもできます。

### ストリング・トークン
{: #string-tokens }
同じ {{site.data.keys.product_adj }} アプリケーション・ファミリーのアプリケーション間でのストリング・トークンの共有は、単純データ共有フィーチャーを使用して、ハイブリッドまたはネイティブの iOS アプリケーションおよび Android アプリケーションで実現できるようになりました。

ストリング・トークンは、パスワードや Cookie などの、単純なストリングとみなされます。
大きなストリングを使用すると、著しいパフォーマンス低下を招きます。

API を使用する場合、トークンを暗号化して、さらにセキュリティーを高めることを検討してください。

> 詳しくは、[JSONStore セキュリティー・ユーティリティー](../jsonstore/security-utilities/)を参照してください。

## 単純データ共有フィーチャーの有効化
{: #enabling-the-simple-data-sharing-feature }
アプリケーションがネイティブ・アプリケーションであるか Cordova ベースのアプリケーションであるかに関わらず、下記の手順は両方にあてはまります。  
Xcode/Android Studio でアプリケーションを開き、以下のようにします。

### iOS
{: #ios }
1. Xcode で、同じアプリケーション・ファミリーの一部とするすべてのアプリケーション用に、ある 1 つの固有の名前を持つキーチェーン・アクセス・グループを追加します。このアプリケーション ID 資格は、ファミリー内のすべてのアプリケーションに対して同一である必要があります。
2. 同じファミリーに属しているアプリケーションが、同じアプリケーション ID 接頭部を共有していることを確認します。詳しくは、iOS Developer Library の『 3. 複数のアプリケーション ID 接頭部の管理 (3. Managing Multiple App ID Prefixes)』を参照してください。
4. アプリケーションを保存して署名します。このグループ内のすべてのアプリケーションが同じ iOS 証明書およびプロビジョニング・プロファイルによって署名されるようにします。
5. 同じアプリケーション・ファミリーの一部とするすべてのアプリケーションに対して、これらの手順を繰り返します。

これで、ネイティブ単純データ共有 API を使用して、同じファミリーに属するアプリケーション・グループの間で単純なストリングを共有できるようになりました。 

### Android
{: #android }
1. **AndroidManifest.xml** ファイルのマニフェスト・タグ内の **android:sharedUserId** エレメントとして、アプリケーション・ファミリー名を指定することによって、「単純データ共有」オプションを有効にします。例えば、次のとおりです。 

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
   ```
    
2. 同じファミリーに属しているアプリケーションが同じ署名資格情報により署名されていることを確認します。
3. **sharedUserId** を指定していなかった、または異なる **sharedUserId** を使用していた、前のバージョンのアプリケーションをすべてアンインストールします。
4. アプリケーションをデバイスにインストールします。
5. 同じアプリケーション・ファミリーの一部とするすべてのアプリケーションに対して、これらの手順を繰り返します。

これで、提供されたネイティブ単純データ共有 API を使用して、同じファミリーに属するアプリケーション・グループの間で単純ストリングを共有できるようになりました。

## 単純データ共有 API の概念
{: #simple-data-sharing-api-concepts }
単純データ共有 API により、同じファミリー内のどのアプリケーションも、共通の場所にあるキー/値のペアを設定、取得、およびクリアすることができます。
単純データ共有 API は、すべてのプラットフォームで同様であり、抽象化層を提供して、各ネイティブ SDK の API について存在する複雑性を隠し、使用しやすくしています。

以下の例では、さまざまな環境で共有資格情報ストレージ内にあるトークンをどのように設定、取得、および削除できるかを示しています。

### JavaScript
{: #javascript }
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> Cordova API について詳しくは、API リファレンスで [getSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#setSharedToken)、[setSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#getSharedToken)、および [clearSharedToken](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjavascript-client/html/WL.Client.html#clearSharedToken) の各関数を参照してください。

### Objective-C
{: #objective-c }
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> Objective-C API について詳しくは、API リファレンスで [WLSimpleDataSharing](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLSimpleDataSharing.html) クラスを参照してください。

### Java
{: #java }
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> Java API については、API リファレンスでクラス [WLSimpleDataSharing](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/WLSimpleDataSharing.html) を参照してください。

## 制限および考慮事項
{: #limitations-and-considerations }
### セキュリティーに関する考慮事項
{: #security-considerations }
このフィーチャーは、グループに属するアプリケーション同士のデータ・アクセスを可能にするため、未許可ユーザーによるデバイスへのアクセスを防止するために特殊な注意を払う必要があります。
セキュリティーの以下の側面を考慮してください。

#### デバイス・ロック
{: #device-lock }
さらにセキュリティーを高めるため、デバイスの紛失または盗難があってもデバイスへのアクセスがセキュリティーで保護されるように、デバイスのパスワード、パスコード、または PIN によってデバイスを保護する必要があります。

#### Jailbreak 検出
{: #jailbreak-detection }
企業内のデバイスが Jailbreak されたりルート化されたりしないようにするため、モバイル・デバイス管理ソリューションの使用を検討してください。

#### 暗号化
{: #encryption }
さらにセキュリティーに高めるため、どのトークンであっても、共有する前に暗号化することを検討してください。
詳しくは、JSONStore セキュリティー・ユーティリティーを参照してください。

### サイズ制限
{: #size-limit }
このフィーチャーは、パスワードや Cookie などの、小さなストリングの共有を意図しています。
大きな値のデータの暗号化と暗号化解除や読み取りと書き込みなどを試みると、パフォーマンスへの影響があるため、このフィーチャーを誤用しないように注意する必要があります。

### メンテナンスの課題
{: #maintenance-challenges }
Android の開発者は、このフィーチャーを有効にするか、アプリケーション・ファミリー値を変更すると、異なるファミリー名の下でインストールされた既存のアプリケーションをアップグレードできなくなるということに注意する必要があります。
セキュリティー上の理由から、Android では、新しいファミリー名の下でアプリケーションをインストールする場合は、その前に、以前のアプリケーションをアンインストールする必要があります。
