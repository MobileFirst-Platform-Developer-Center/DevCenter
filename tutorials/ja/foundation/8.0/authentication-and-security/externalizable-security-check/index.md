---
layout: tutorial
title: ExternalizableSecurityCheck の実装
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
抽象 `ExternalizableSecurityCheck` クラスは、`SecurityCheck` インターフェースを実装し、セキュリティー検査機能の 2 つの重要な側面、すなわち外部化と状態管理を処理します。

* 外部化 - このクラスは、`Externalizable` インターフェースを実装して、派生クラスがこのインターフェースを実装する必要がなくなるようにします。
* 状態管理 - このクラスは、`STATE_EXPIRED` 状態を事前定義します。これは、セキュリティー検査を期限切れにし、その状態が保持されないようにすることを意味します。 派生クラスは、それぞれのセキュリティー検査によってサポートされるその他の状態を定義する必要があります。

サブクラスでは、3 つのメソッドを実装する必要があります。それらは、`initStateDurations`、`authorize`、および `introspect` です。

このチュートリアルでは、クラスを実装する方法について説明し、状態を管理する方法を例示します。

**前提条件:** [許可の概念](../)および[セキュリティー検査の作成](../creating-a-security-check)のチュートリアルをお読みください。

#### ジャンプ先:
{: #jump-to }
* [initStateDurations メソッド](#the-initstatedurations-method)
* [authorize メソッド](#the-authorize-method)
* [introspect メソッド](#the-introspect-method)
* [AuthorizationContext オブジェクト](#the-authorizationcontext-object)
* [RegistrationContext オブジェクト](#the-registrationcontext-object)

## initStateDurations メソッド
{: #the-initstatedurations-method }
`ExternalizableSecurityCheck` によって、`initStateDurations` という抽象メソッドが定義されます。 サブクラスは、それぞれのセキュリティー検査でサポートされるすべての状態について、名前と期間を指定することで、このメソッドを実装する必要があります。 期間の値は、通常、セキュリティー検査構成から取得されます。

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((SecurityCheckConfig) config).successStateExpirationSec);
}
```

> セキュリティー検査構成について詳しくは、『CredentialsValidationSecurityCheck の実装』チュートリアルの[構成クラス](../credentials-validation/security-check/#configuration-class)のセクションを参照してください。

## authorize メソッド
{: #the-authorize-method }
`SecurityCheck` インターフェースによって、`authorize` というメソッドが定義されます。 このメソッドが、セキュリティー検査のメイン・ロジックの実装、状態の管理、およびクライアントへの応答の送信 (成功、チャレンジ、または失敗) の責任を負います。

状態の管理には、以下のヘルパー・メソッドを使用します。

```java
protected void setState(String name)
```
```java
public String getState()
```
以下のサンプルは、ユーザーがログインしているかどうかを単純にチェックし、その結果に応じて成功または失敗を返します。

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (loggedIn){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();           
        failure.put("failure", "User is not logged-in");
        response.addFailure(getName(), failure);
    }
}
```

`AuthorizationResponse.addSuccess` メソッドは、成功のスコープとその有効期限を応答オブジェクトに追加します。 これは以下を必要とします。

* セキュリティー検査によって認可されたスコープ。
* 認可されたスコープの有効期限。  
`getExpiresAt` ヘルパー・メソッドは、現在の状態の有効期限が切れる時間か、現在の状態がヌルの場合には 0 を返します。

  ```java
  public long getExpiresAt()
  ```
   
* セキュリティー検査の名前。

`AuthorizationResponse.addFailure` メソッドは、失敗を応答オブジェクトに追加します。 これは以下を必要とします。

* セキュリティー検査の名前。
* 失敗 `Map` オブジェクト。

`AuthorizationResponse.addChallenge` メソッドは、チャレンジを応答オブジェクトに追加します。 これは以下を必要とします。

* セキュリティー検査の名前。
* チャレンジ `Map` オブジェクト。

## introspect メソッド
{: #the-introspect-method }
`SecurityCheck` インターフェースによって、`introspect` というメソッドが定義されます。 このメソッドにより、セキュリティー検査の状態が、要求されたスコープを認可しているかどうかが検査されます。 スコープが認可されている場合、セキュリティー検査は、認可されるスコープ、その有効期限、およびカスタムのイントロスペクション・データを結果のパラメーターに報告しなければなりません。 スコープが認可されていない場合、セキュリティー検査は何も行いません。  
このメソッドによって、セキュリティー検査の状態またはクライアント登録レコード、あるいはその両方が変更されることがあります。

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```

## AuthorizationContext オブジェクト
{: #the-authorizationcontext-object }
`ExternalizableSecurityCheck` クラスは、`AuthorizationContext authorizationContext` オブジェクトを提供します。このオブジェクトは、セキュリティー検査の現行クライアントに関連した一時データを保管するために使用されます。  
データの保管と取得には、以下のメソッドを使用します。

* 現行クライアントに関して、このセキュリティー検査によって設定された認証済みユーザーを取得します。

  ```java
  AuthenticatedUser getActiveUser();
  ```
  
* このセキュリティー検査で使用する現行クライアントのアクティブ・ユーザーを設定します。

  ```java
  void setActiveUser(AuthenticatedUser user);
  ```

## RegistrationContext オブジェクト
{: #the-registrationcontext-object }
`ExternalizableSecurityCheck` クラスは、`RegistrationContext registrationContext` オブジェクトを提供します。このオブジェクトは、現行クライアントに関連した永続データ/デプロイメント・データを保管するために使用されます。  
データの保管と取得には、以下のメソッドを使用します。

* 現行クライアントに関して、このセキュリティー検査によって登録されたユーザーを取得します。

  ```java
  AuthenticatedUser getRegisteredUser();
  ```
  
* 現行クライアントを対象に、指定されたユーザーを登録します。

  ```java
  setRegisteredUser(AuthenticatedUser user);
  ```
  
* 現行クライアントの公開されている永続属性を取得します。

  ```java
  PersistentAttributes getRegisteredPublicAttributes();
  ```
  
* 現行クライアントの保護されている永続属性を取得します。

  ```java
  PersistentAttributes getRegisteredProtectedAttributes();
  ```
  
* 指定された検索基準を使用して、モバイル・クライアントの登録データを検索します。

  ```java
  List<ClientData> findClientRegistrationData(ClientSearchCriteria criteria);
  ```

## サンプル・アプリケーション
{: #sample-application }
`ExternalizableSecurityCheck` を実装するサンプルについては、[登録](../enrollment)チュートリアルを参照してください。
