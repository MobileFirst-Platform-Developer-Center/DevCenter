---
layout: tutorial
title: デバイス・シングル・サインオン (SSO) の構成
breadcrumb_title: Device SSO
relevantTo: [android,ios,windows,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
{{ site.data.keys.product_full }} は、同じデバイス上にある複数のアプリケーション間で、任意のカスタム・セキュリティー検査の状態を共有可能にするシングル・サインオン (SSO) 機能を提供します。 例えば、デバイス SSO を使用すると、ユーザーはデバイス上の、あるアプリケーションに正常にサインオンできるとともに、同じ実装を使用する同じデバイス上のその他のアプリケーションでも認証されます。

**前提条件**: [認証およびセキュリティー](../)のチュートリアルをお読みください。

## SSO の構成
{: #configuring-sso }
{{ site.data.keys.mf_console }} で、次のようにします。

1. **「 [ご使用のアプリケーション] 」→「セキュリティー」タブ→「セキュリティー検査の構成」**セクションにナビゲートします。
2. **「新規」**ボタンをクリックして、新しいセキュリティー検査構成を作成するか、セキュリティー検査構成が既に存在する場合は、**「編集」**アイコンをクリックします。
3. **「セキュリティー検査プロパティーの構成」**ダイアログで、**「デバイス SSO を有効にする (Enable Device SSO)」**設定を **true** に設定し、`「OK」`を押します。

デバイス SSO を有効にするアプリケーションごとに、上記のステップを繰り返します。

<img class="gifplayer" alt="{{ site.data.keys.mf_console }} でのデバイス SSO の構成" src="enable-device-sso.png"/>

必要な構成を指定してアプリケーションの構成 JSON ファイルを手動で編集し、変更を {{ site.data.keys.mf_server }} にプッシュして戻すこともできます。

1. **コマンド・ライン・ウィンドウ**から、プロジェクトのルート・フォルダーにナビゲートし、`mfpdev app pull` を実行します。
2. **[project-folder]\mobilefirst** フォルダーにある構成ファイルを開きます。
3. ファイルを編集して、選択したカスタム・セキュリティー検査のデバイス SSO を有効にします。デバイス SSO を有効にするには、カスタム・セキュリティー検査の `enableSSO` プロパティーを `true` に設定します。 このプロパティー構成は、`securityCheckConfigurations` オブジェクト内にネストされているセキュリティー検査オブジェクトに含まれています。 これらのオブジェクトをアプリケーション記述子ファイル内で見つけるか、欠落している場合は作成します。 例えば、次のとおりです。

   ```xml
   "securityCheckConfigurations": {
        "UserAuthentication": {
            ...
            ...
            "enableSSO": true
        }
   }
   ```
   
4. コマンド `mfpdev app push` を実行することで、更新済み構成 JSON ファイルをデプロイします。

## 既存サンプルでのデバイス SSO の使用
{: #using-device-sso-with-a-pre-existing-sample }
[資格情報の検証](../credentials-validation/)チュートリアルのサンプルを使用してデバイス SSO を構成するので、このチュートリアルをお読みください。  
このデモンストレーションでは Cordova サンプル・アプリケーションを使用しますが、iOS、Android、または Windows サンプル・アプリケーションでも同じことを実行できます。

1. [サンプルの使用法に関する指示](../credentials-validation/javascript/#sample-usage)に従います。
2. 別のサンプル名とアプリケーション ID を使用してステップを繰り返します。
3. 同じデバイス上で両方のアプリケーションを実行します。 各アプリケーションで PIN コード (1234) の入力を求めるプロンプトが出される点に注目してください。
4. {{ site.data.keys.mf_console }} で、上記の説明に従い、各アプリケーションの`「デバイス SSO を有効にする (Enable Device SSO)」` を `true` に設定します。
5. 両方のアプリケーションを終了し、やり直します。 最初に開くアプリケーションでは、**「残高照会 (Get Balance)」**ボタンをタップすると、PIN コードの入力を求めるプロンプトが 1 回出されます。 2 番目のアプリケーションを開いて、**「残高照会 (Get Balance)」**ボタンをタップしたとき、残高を照会するために再度 PIN コードを入力する必要はありません。
`
PinCodeAttempts` セキュリティー検査には、60 秒の有効期限トークンが設定されています。 したがって、60 秒経過後にもう 1 回試行すると、2 番目のアプリケーションでも PIN コードを要求されます。

![PIN コード Cordova サンプル・アプリケーション](pincode-attempts-cordova.png)
