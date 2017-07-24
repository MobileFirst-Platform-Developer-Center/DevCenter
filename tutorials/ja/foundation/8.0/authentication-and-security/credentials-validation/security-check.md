---
layout: tutorial
title: CredentialsValidationSecurityCheck クラスの実装
breadcrumb_title: セキュリティー検査
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: セキュリティー検査のダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
この抽象クラスは、`ExternalizableSecurityCheck` を継承し、その大部分のメソッドを実装して、簡単に使用できるようにします。`validateCredentials` と `createChallenge` の 2 つのメソッドは必須です。  
`CredentialsValidationSecurityCheck` クラスは、リソースへのアクセスを認可するために任意の資格情報を検証する単純なフロー向けです。設定されている試行回数に達した後にアクセスをブロックする組み込み機能も提供されます。

このチュートリアルでは、ハードコーディングされた PIN コードでリソースを保護する例を使用します。また、ユーザーには 3 回まで試行が許されます (この回数を過ぎると、クライアント・アプリケーション・インスタンスは 60 秒間ブロックされます)。

**前提条件:** [許可の概念](../../)および[セキュリティー検査の作成](../../creating-a-security-check)のチュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [セキュリティー検査の作成](#creating-the-security-check)
* [チャレンジの作成](#creating-the-challenge)
* [ユーザー資格情報の検証](#validating-the-user-credentials)
* [セキュリティー検査の構成](#configuring-the-security-check)
* [サンプルのセキュリティー検査](#sample-security-check)

## セキュリティー検査の作成
{: #creating-the-security-check }
[Java アダプターを作成](../../../adapters/creating-adapters)し、`CredentialsValidationSecurityCheck` を継承する `PinCodeAttempts` という名前の Java クラスを追加します。

```java
public class PinCodeAttempts extends CredentialsValidationSecurityCheck {

    @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }
}
```

## チャレンジの作成
{: #creating-the-challenge }
セキュリティー検査がトリガーされると、セキュリティー検査はクライアントにチャレンジを送信します。`null` を返すと空のチャレンジが作成されます。場合によっては、それで十分なこともあります。  
オプションで、チャレンジと一緒にデータを返すこともできます。例えば、表示するエラー・メッセージや、クライアントが使用できるその他のデータなどです。

例えば、`PinCodeAttempts` は、事前定義エラー・メッセージと残りの試行回数を送信します。

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

> `errorMsg` の実装がサンプル・アプリケーションに組み込まれています。

`getRemainingAttempts()` は、`CredentialsValidationSecurityCheck` を継承しています。

## ユーザー資格情報の検証
{: #validating-the-user-credentials }
クライアントがチャレンジの応答を送信すると、応答は `Map` として `validateCredentials` に渡されます。このメソッドに必要なロジックを実装し、資格情報が有効な場合には `true` を返す必要があります。

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals("1234")){
            return true;
        }
        else {
            errorMsg = "The pin code is not valid.";
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

### 構成クラス
{: #configuration-class }
adapter.xml ファイルと {{ site.data.keys.mf_console }} を使用して、有効な PIN コードを構成することもできます。

`CredentialsValidationSecurityCheckConfig` を継承する新規 Java クラスを作成します。デフォルト構成を継承するために、親のセキュリティー検査クラスに一致するクラスを継承する必要があります。

```java
public class PinCodeConfig extends CredentialsValidationSecurityCheckConfig {

    public String pinCode;

    public PinCodeConfig(Properties properties) {
        super(properties);
        pinCode = getStringProperty("pinCode", properties, "1234");
    }

}
```

このクラスの必須メソッドは、`Properties` インスタンスを処理できるコンストラクターのみです。adapter.xml ファイルから特定のプロパティーを取得するには、`get[Type]Property` メソッドを使用します。値が見つからない場合は、3 番目のパラメーターでデフォルト値 (`1234`) を定義します。

以下のように、`addMessage` メソッドを使用して、このコンストラクターにエラー処理を追加することもできます。

```java
public PinCodeConfig(Properties properties) {
    //Make sure to load the parent properties
    super(properties);

    //Load the pinCode property
    pinCode = getStringProperty("pinCode", properties, "1234");

    //Check that the PIN code is at least 4 characters long. Triggers an error.
    if(pinCode.length() < 4) {
        addMessage(errors,"pinCode","pinCode needs to be at least 4 characters");
    }

    //Check that the PIN code is numeric. Triggers warning.
                try {
int i = Integer.parseInt(pinCode);
    }
    catch(NumberFormatException nfe) {
        addMessage(warnings,"pinCode","PIN code contains non-numeric characters");
    }
}
```

メイン・クラス (`PinCodeAttempts`) 内に、以下の 2 つのメソッドを追加して、構成をロードできるようにします。

```java
@Override
public SecurityCheckConfiguration createConfiguration(Properties properties) {
    return new PinCodeConfig(properties);
}
@Override
protected PinCodeConfig getConfiguration() {
    return (PinCodeConfig) super.getConfiguration();
}
```

これで、`getConfiguration().pinCode` メソッドを使用してデフォルトの PIN コードを取得できます。  

ハードコーディングされた値の代わりに構成から取得した PIN コードを使用するように、`validateCredentials` メソッドを変更できます。

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(getConfiguration().pinCode)){
            return true;
        }
        else {
            errorMsg = "Pin code is not valid. Hint: " + getConfiguration().pinCode;
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    //In any other case, credentials are not valid
    return false;

}
```

## セキュリティー検査の構成
{: #configuring-the-security-check }
adapter.xml 内に、`<securityCheckDefinition>` エレメントを追加します。

```xml
<securityCheckDefinition name="PinCodeAttempts" class="com.sample.PinCodeAttempts">
  <property name="pinCode" defaultValue="1234" description="The valid PIN code"/>
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed"/>
  <property name="blockedStateExpirationSec" defaultValue="60" description="How long before the client can try again (seconds)"/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)"/>
</securityCheckDefinition>
```

`name` 属性は、セキュリティー検査の名前にしてください。`class` パラメーターは、先に作成したクラスに設定します。

`securityCheckDefinition` には、ゼロ個以上の `property` エレメントを含めることができます。`pinCode` プロパティーは、`PinCodeConfig` 構成クラスで定義したプロパティーです。その他のプロパティーは、`CredentialsValidationSecurityCheckConfig` 構成クラスから継承されたものです。

デフォルトでは、これらのプロパティーを adapter.xml ファイル内に指定しないと、`CredentialsValidationSecurityCheckConfig` によって設定されたデフォルト値を受け取ります。

```java
public CredentialsValidationSecurityCheckConfig(Properties properties) {
    super(properties);
    maxAttempts = getIntProperty("maxAttempts", properties, 1);
    attemptingStateExpirationSec = getIntProperty("attemptingStateExpirationSec", properties, 120);
    successStateExpirationSec = getIntProperty("successStateExpirationSec", properties, 3600);
    blockedStateExpirationSec = getIntProperty("blockedStateExpirationSec", properties, 0);
}
```
`CredentialsValidationSecurityCheckConfig` クラスにより、以下のプロパティーが定義されます。

- `maxAttempts`: *失敗* に至るまでに許可される試行回数。
- `attemptingStateExpirationSec`: クライアントが有効な資格情報を提供しなければならない時間間隔 (秒数) であり、この時間内で試行がカウントされます。
- `successStateExpirationSec`: ログイン成功が保持される期間 (秒数)。
- `blockedStateExpirationSec`: `maxAttempts` に達した後でクライアントがブロックされる期間 (秒数)。

`blockedStateExpirationSec` のデフォルト値は `0` に設定される点に注意してください。すなわち、クライアントが無効な資格情報を送信した場合、「0 秒経過後」に再試行できます。これは、デフォルトでは「試行」機能が無効になることを意味します。


## サンプルのセキュリティー検査
{: #sample-security-check }
セキュリティー検査 Maven プロジェクトを[ダウンロード](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)します。

Maven プロジェクトには、CredentialsValidationSecurityCheck の実装が含まれます。
