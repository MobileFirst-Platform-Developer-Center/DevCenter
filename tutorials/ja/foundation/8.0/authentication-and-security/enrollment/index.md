---
layout: tutorial
title: 登録
breadcrumb_title: Enrollment
relevantTo: [android,ios,windows,javascript]
weight: 7
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このサンプルは、カスタムの登録プロセスとステップアップ許可を例示します。 この一回限りの登録プロセスの間に、ユーザーはユーザー名とパスワードを入力し、PIN コードを定義する必要があります。  

**前提条件:** [ExternalizableSecurityCheck](../externalizable-security-check/) および[ステップアップ](../step-up/)のチュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [アプリケーション・フロー](#application-flow)
* [永続属性へのデータの保管](#storing-data-in-persistent-attributes)
* [セキュリティー検査](#security-checks)
* [サンプル・アプリケーション](#sample-applications)

## アプリケーション・フロー
{: #application-flow }
* アプリケーションが初めて開始されると (登録の前)、アプリケーションは、**「公開データの照会 (Get public data)」**と**「登録 (Enroll)」**の 2 つのボタンがある UI を表示します。
* ユーザーが**「登録 (Enroll)」**ボタンをタップして登録を開始すると、ログイン・フォームのプロンプトが出され、その後、PIN コードを設定するように要求されます。
* ユーザーが正常に登録されると、UI には、**「公開データの照会 (Get public data)」**、**「残高照会 (Get balance)」**、**「取引照会 (Get transactions)」**、および**「ログアウト」**の 4 つのボタンが表示されます。 ユーザーは、PIN コードを入力しなくとも 4 つすべてのボタンを利用できます。
* アプリケーションが 2 回目に起動されたとき (登録の後)、UI には引き続き 4 つすべてのボタンが含まれています。 ただし、ユーザーが**「取引照会 (Get transactions)」**ボタンをクリックすると、ユーザーは PIN コードの入力を要求されます。

PIN コードの入力に 3 回失敗すると、ユーザーは再度、ユーザー名とパスワードを使用して認証を受け、PIN コードを再設定するように要求されます。

## 永続属性へのデータの保管
{: #storing-data-in-persistent-attributes }
保護データを `PersistentAttributes` オブジェクトに保存するように選択できます。このオブジェクトは、登録済みクライアントのカスタム属性用のコンテナーです。 オブジェクトにはセキュリティー検査クラスまたはアダプター・リソース・クラスのいずれかからアクセスできます。

提供されるサンプル・アプリケーションでは、`PersistentAttributes` オブジェクトをアダプター・リソース・クラスで使用して、PIN コードを保管しています。

* **setPinCode** リソースは、**pinCode** 属性を追加し、`AdapterSecurityContext.storeClientRegistrationData()` メソッドを呼び出して変更を保管します。

  ```java
  @POST
  @OAuthSecurity(scope = "setPinCode")
  @Path("/setPinCode/{pinCode}")
  
  public Response setPinCode(@PathParam("pinCode") String pinCode){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		clientData.getProtectedAttributes().put("pinCode", pinCode);
  		adapterSecurityContext.storeClientRegistrationData(clientData);
  		return Response.ok().build();
  }
  ```
  
  ここで、`users` には `EnrollmentUserLogin` というキーが存在し、このキー自体に `AuthenticatedUser` オブジェクトが含まれています。

* **unenroll** リソースは、**pinCode** 属性を削除し、`AdapterSecurityContext.storeClientRegistrationData()` メソッドを呼び出して変更を保管します。

  ```java
  @DELETE
  @OAuthSecurity(scope = "unenroll")
  @Path("/unenroll")
  
  public Response unenroll(){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		if (clientData.getProtectedAttributes().get("pinCode") != null){
  			clientData.getProtectedAttributes().delete("pinCode");
  			adapterSecurityContext.storeClientRegistrationData(clientData);
  		}
  		return Response.ok().build();
  }
  ```

## セキュリティー検査
{: #security-checks }
登録のサンプルには 3 つのセキュリティー検査が含まれています。

### EnrollmentUserLogin
{: #enrollmentuserlogin }
`EnrollmentUserLogin` セキュリティー検査は、**setPinCode** リソースを保護して、認証済みユーザーのみが PIN コードを設定できるようにします。 このセキュリティー検査は、すぐに期限切れになるように作られており、「初回に起動」された期間中のみ有効であるように意図されています。 このセキュリティー検査は、追加の `isLoggedIn` メソッドと `getRegisteredUser` メソッドがある点を除けば、[UserAuthenticationSecurityCheck の実装](../user-authentication/security-check)のチュートリアルで説明している `UserLogin` セキュリティー検査と同じものです。  
`isLoggedIn` メソッドは、セキュリティー検査の状態が SUCCESS と等しい場合には `true` を返し、それ以外の場合には `false` を返します。  
`getRegisteredUser` メソッドは、認証済みユーザーを返します。

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```
```java
public AuthenticatedUser getRegisteredUser() {
    return registrationContext.getRegisteredUser();
}
```

### EnrollmentPinCode
{: #enrollmentpincode }
`EnrollmentPinCode` セキュリティー検査は、**「取引照会 (Get transactions)」**リソースを保護します。いくつかの違いを除いて、[CredentialsValidationSecurityCheck の実装](../credentials-validation/security-check)のチュートリアルで説明している `PinCodeAttempts` セキュリティー検査に似ています。

このチュートリアルの例の場合、`EnrollmentPinCode` は、`EnrollmentUserLogin` に**依存**しています。 `EnrollmentUserLogin` へのログインが成功した後でのみ、ユーザーは PIN コードの入力を求められます。

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

アプリケーションが**始めて**開始され、ユーザーが正常に登録されると、ユーザーは、設定した PIN コードを入力しなくとも**「取引照会 (Get transactions)」**リソースにアクセスできなければなりません。 その目的のために、`authorize` メソッドは `EnrollmentUserLogin.isLoggedIn` メソッドを使用して、ユーザーがログイン状態であるかどうかをチェックします。 これは、`EnrollmentUserLogin` の有効期限が切れていない限り、ユーザーは**「取引照会 (Get transactions)」**にアクセスできることを意味します。

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    }
}
```

ユーザーが 3 回試行しても PIN コードの入力に失敗すると、チュートリアルの設計では、ユーザー名とパスワードで認証を受け、PIN コードを再設定するようにユーザーにプロンプトが出される前に **pinCode** 属性が削除されます。

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    } else {
        super.authorize(scope, credentials, request, response);
        if (getState().equals(STATE_BLOCKED)){
            attributes.delete("pinCode");
        }
    }
}
```

`validateCredentials` メソッドは、`PinCodeAttempts` セキュリティー検査内のものと同様ですが、ここでは、保管されている **pinCode** 属性に対して資格情報が比較される点が異なります。

```java
@Override

protected boolean validateCredentials(Map<String, Object> credentials) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals(attributes.get("pinCode"))){
            errorMsg = null;
            return true;
        }
        else {
            errorMsg = "The pin code is not valid. Hint: " + attributes.get("pinCode");
        }
    }
    else{
        errorMsg = "The pin code was not provided.";
    }
    //In any other case, credentials are not valid
    return false;
}
```

### IsEnrolled
{: #isenrolled }
`IsEnrolled` セキュリティー検査は以下を保護します。

* **getBalance** リソース。登録済みユーザーのみが残高を確認できるようにします。
* **transactions** リソース。登録済みユーザーのみが取り引きを照会できるようにします。
* **unenroll** リソース。**pinCode** があらかじめ設定されている場合にのみ、これを削除できるようにします。

#### セキュリティー検査の作成
{: #creating-the-security-check }
[Java アダプターを作成](../../adapters/creating-adapters/)し、`ExternalizableSecurityCheck` を継承する `IsEnrolled` という名前の Java クラスを追加します。

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

#### IsEnrolledConfig 構成クラス
{: #the-isenrolledconfig-configuration-class }
`ExternalizableSecurityCheckConfig` を継承する `IsEnrolledConfig` 構成クラスを作成します。

```java
public class IsEnrolledConfig extends ExternalizableSecurityCheckConfig {

    public int successStateExpirationSec;

    public IsEnrolledConfig(Properties properties) {
        super(properties);
        successStateExpirationSec = getIntProperty("expirationInSec", properties, 8000);
    }
}
```

`createConfiguration` メソッドを `IsEnrolled` クラスに追加します。

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    @Override
    public SecurityCheckConfiguration createConfiguration(Properties properties) {
        return new IsEnrolledConfig(properties);
    }
}
```
#### initStateDurations メソッド
{: #the-initstatedurations-method }
SUCCESS 状態を維持する期間を `successStateExpirationSec` に設定します。

```java
@Override
protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((IsEnrolledConfig) config).successStateExpirationSec);
}
```

#### authorize メソッド
{: #the-authorize-method }
コード・サンプルは、ユーザーが登録されているかどうかを単純にチェックし、その結果に応じて成功または失敗を返します。

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```

* `pinCode` 属性が存在する場合は、以下が実行されます。

 * `setState` メソッドを使用して状態を SUCCESS に設定します。
 * `addSuccess` メソッドを使用して応答オブジェクトに成功を追加します。

* `pinCode` 属性が存在しない場合は、以下が実行されます。

 * `setState` メソッドを使用して状態を EXPIRED に設定します。
 * `addFailure` メソッドを使用して応答オブジェクトに失敗を追加します。

<br/>
`IsEnrolled` セキュリティー検査は、`EnrollmentUserLogin` に**依存**しています。

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

以下のコードを追加することで、アクティブ・ユーザーを設定します。

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
   
その後、`transactions` リソースによって、表示名を提供するために現在の `AuthenticatedUser` オブジェクトが取得されます。

```java
@GET
@Produces(MediaType.TEXT_PLAIN)
@OAuthSecurity(scope = "transactions")
@Path("/transactions")

public String getTransactions(){
  AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
  return "Transactions for " + currentUser.getDisplayName() + ":\n{'date':'12/01/2016', 'amount':'19938.80'}";
}
```
    
> `securityContext` について詳しくは、Java アダプターのチュートリアルにある[セキュリティー API](../../adapters/java-adapters/#security-api) セクションを参照してください。

以下を追加することで、登録済みユーザーを応答オブジェクトに追加します。

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Is there a user currently active?
        if (!userLogin.isLoggedIn()){
            // If not, set one here.
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), getName(), "user", userLogin.getRegisteredUser());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
    
サンプル・コードの場合、`IsEnrolled` チャレンジ・ハンドラーの `handleSuccess` メソッドは、表示名を提供するために user オブジェクトを使用します。

<img alt="登録サンプル・アプリケーション" src="sample_application.png" style="float:right"/>
## サンプル・アプリケーション
{: #sample-applications }

### セキュリティー検査
{: #security-check }
`EnrollmentUserLogin`、`EnrollmentPinCode`、および `IsEnrolled` の各セキュリティー検査は、Enrollment Maven プロジェクトの下にある SecurityChecks プロジェクトで入手できます。
[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) してセキュリティー検査 Maven プロジェクトをダウンロードします。

### アプリケーション
{: #applications }
iOS (Swift)、Android、Cordova、および Web 用のサンプル・アプリケーションを使用できます。

* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80) して Cordova プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80) して iOS Swift プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80) して Android プロジェクトをダウンロードします。
* [ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80) して Web アプリケーション・プロジェクトをダウンロードします。

### サンプルの使用法
{: #sample-usage }
サンプルの README.md ファイルの指示に従ってください。
