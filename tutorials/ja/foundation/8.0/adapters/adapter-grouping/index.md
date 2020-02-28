---
layout: tutorial
title: アダプターのグループ化
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
Mobile Foundation アダプターは、サーバー・サイドのロジックを実行し、バックエンド・システムからのデータの転送または取得を行います。アダプターは Mobile Foundation ランタイムのすべてのインスタンスにデプロイされ、使用方法に関係なくシステム・リソースを消費します。いくつかのアダプターがモバイル・アプリケーションによって使用される頻度が少ないシチュエーションでは、頻繁に使用されるアダプターのみで Mobile Foundation インスタンスのスケーリングを行う方法は存在しません。このような環境のスケーリングは、新しく追加されるすべてのノードにすべてのアダプターをデプロイして実行する結果になります。この動作では、ランタイムはすべてのアダプターをデプロイして実行する必要があるため、結果として Mobile Foundation インスタンスの始動は遅くなります。

アダプターのグループ化のフィーチャーにより、一群のリソース・アダプターをグループ化し、それらのアダプターを一緒に 1 セットの Mobile Foundation ノードで実行することができます。このノードのセットを**グループ**と呼びます。 アダプター負荷に基づいてさらにノードを追加することによって、グループのスケーリングを行うことができます。各グループ内のノードの数を、グループで実行されるアダプターに到達すると予期される負荷に基づいて前もって決定できます。

>アダプターのグループ化は、リソース・アダプターにのみサポートされていて、セキュリティー検査アダプターにはサポートされていません。

### 構成
{: #configuration }

アダプターのグループ化におけるグループとは、一群のリソース・アダプターが実行される Mobile Foundation ノードの集合です。
例えば、10 個のノードがあるファーム・トポロジーで、5 個のノード (ノード 1、ノード 2、ノード 3、ノード 4、ノード 5) のあるグループ 1、3 個のノード (ノード 6、ノード 7、ノード 8) があるグループ 2、および、2 個のノード (ノード 9、ノード 10) があるグループ 3 という 3 つのグループを作成できます。

WebSphere Application Server (WAS) ND トポロジーでは、アダプターのグループ化を実現するために、アダプターのグループ化におけるグループにマップする WAS ND クラスターを作成できます。
次のセクションでは、アダプター・グループ構成を定義し、ノードをアダプター・グループの一部にすることによって、アダプターのグループ化が Mobile Foundation で機能するようにする方法を説明します。
アダプターのグループ化が機能するようにするには、2 つの構成変更を Mobile Foundation に適用する必要があります。

### アダプター・グループ構成の定義とデプロイ
{: #deploy-adapter-group-config }

アダプター・グループ構成は、グループと、グループに属すリソース・アダプターを定義します。アダプター・グループ構成は、以下のような構造であり、管理 API を使用してデプロイする必要があります。

```json
{
  "groups": [
    {
      "id": "finance",
      "adapters": [
        {
          "name": "SavingAccountAdapter"
        },
        {
          "name": "LoanProcessingAdapter"
        }
      ]
    },
    {
      "id": "hr",
      "adapters": [
        {
          "name": "EmployeeInfoAdapter"
        },
        {
          "name": "OnboardingAdapter"
        }
      ]
    }
  ]
}
```

上記の構成は、アダプター・グループと、それらのグループの一部になる必要のあるアダプターを定義しています。アダプター・グループの名前は、キー `id` に対する値です。 `adapters` キーが保持している値は、各グループにデプロイされるリソース・アダプターのリストです。
アダプター・グループ構成に使用可能な管理 API は以下にリストされているとおりです。

#### アダプター構成のデプロイ
アダプター・グループ構成をデプロイするには、以下の Mobile Foundation 管理 API を使用し、上記の構成パラメーターを JSON ペイロードとして指定します。

**POST** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

以下に例を示します。

```bash
curl -X POST --user admin:admin --header 'Content-Type: application/json' -- header 'Accept: application/json' -d '{ "groups": [{ "id": "finance", "adapters":
[ {"name": "SavingAccountAdapter" }, {"name": "LoanProcessingAdapter"}] },{"id": "hr", "adapters": [ {"name": "EmployeeInfoAdapter"}, {"name": "OnboardingAdapter"}]}]}' "http://<host>:<port>/mfpadmin/management apis/2.0/ runtimes/mfp/adapterGroupConfig"
```

#### アダプター・グループ構成の取得
既にデプロイ済みのアダプター・グループ構成を取得するには、以下の Mobile Foundation 管理 API を使用します。

**GET** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

以下に例を示します。

```bash
curl -X GET --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

#### アダプター・グループ構成の削除
既にデプロイ済みのアダプター・グループ構成を削除するには、以下の Mobile Foundation 管理 API を使用します。

**DELETE** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

以下に例を示します。

```bash
curl -X DELETE --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

### アダプターのグループ化のためのグループの定義
{: #define-groups }

アダプター・グループ構成を定義およびデプロイした後の次のステップは、グループを作成することです。Mobile Foundation ノードをグループの一部にするには、`mfp.adaptergroup.name` という名前のランタイム JNDI プロパティーをグループ名の値と共に追加します。

以下に例を示します。
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value="finance"/>
```

ファーム・トポロジーでは、あるファーム・ノードの `server.xml` 内に JNDI プロパティー `mfp.adaptergroup.name` を追加すると、そのノードは JNDI で示されたグループの一部になります。上記の JNDI プロパティーが示されていないノードの場合、デフォルト動作になります。つまり、そのノードにはすべてのアダプターがデプロイされます。

Group1 が node1、node2、node3、node4、および node5 からなる場合、すべてのノードで `server.xml` を更新して、JNDI プロパティーを値 `Group1` と共に追加する必要があります。

例: Group1 = [node 1, node 2, node 3, node 4, node 5]
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value=”Group1”/>
```

他のグループも同様に定義できます。WAS ND クラスターごとに、JNDI プロパティーを定義して、そのクラスターをアダプターのグループ化のためのグループにすることができます。

### アダプターのデプロイメント
{: #adapter-deployment }

アダプター・グループ構成をデプロイし、グループを定義した後、それ以降のリソース・アダプターのデプロイメントでは、アダプター・グループ構成で示されたルールが守られます。あるアダプターが、あるグループ内のアダプターのリストに含まれている場合、そのアダプターは、`mfp.adaptergroup.name` JNDI プロパティーで識別されるグループのそれらのノードにのみデプロイされます。

既に実行中の Mobile Foundation インスタンスに対して変更 (あるグループから別のグループへのアダプターの移動など) を行う場合、すべてのグループでの Mobile Foundation インスタンスの再始動が必要になることがあります。ただし、アダプター・リストに新規アダプターを追加する場合は、ノードの再始動は必要ありません。

### アダプター呼び出しの変更
{: #adapter-call-changes }

アダプターのグループ化を有効に活用するには、クライアント・サイドのアダプター呼び出しを変更して、リソース要求 URI にグループ情報を含める必要があります。URI の形式は `/adaptergroups/<groupname>/adapters/<adaptername>/<method>` になります。

以下に例を示します。

```java
adapterPath = new URI(“/adaptergroups/finance/adapters/SavingAccountAdapter/getBalance”);
WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
```

URI にアダプター・グループ情報を含めることで、指定されたグループ内で実行されているアダプターに呼び出しをルーティングする必要があることがロード・バランサー (下の説明を参照) に通知されます。

### ロード・バランサーの変更
{: #load-balancer-changes }

アダプターのグループ化が機能するようにするためには、ロード・バランサーに主要な変更が必要です。URI パターンに基づいて適切なグループにアダプター呼び出しをルーティングするようにロード・バランサーを構成する必要があります。

![ロード・バランサー](load-balancer.png)

以下に、ファーム・トポロジーの HAProxy 用のロード・バランサー構成例を示します。この構成では、ファーム・ノード *host1* と *host2* が group1 の一部として、ファーム・ノード *host3* と *host4* が *group2* の一部として構成されていて、ファーム・ノード *host5* はデフォルトのホストです。アダプター呼び出し要求が HAProxy に到達したとき、URL に *group1* が含まれていると、その呼び出しは *host1* および *host2* にルーティングされます。 要求 URL に *group2* が含まれている場合、その要求は *host3* および *host4* にルーティングされます。 残りのすべての要求は *host5* にルーティングされます。
```
frontend localnodes
  bind *:81
  mode http
  acl is_group1 url_sub group1
  use_backend group1_server if is_group1
  acl is_group2 url_sub group2
  use_backend group2_server if is_group2
  default_backend nodes

backend group1_server
  mode http
  balance roundrobin
  option forwardfor
  http-request set-header X-Forwarded-Port %[dst_port]
  http-request add-header X-Forwarded-Proto https if { ssl_fc }
  option httpchk HEAD / HTTP/1.1\r\nHost:localhost
  server group1_server1 <host1>:<port> check
  server group1_server2 <host2>:<port> check

backend group2_server
  mode http
  balance roundrobin
  option forwardfor
  http-request set-header X-Forwarded-Port %[dst_port]
  http-request add-header X-Forwarded-Proto https if { ssl_fc }
  option httpchk HEAD / HTTP/1.1\r\nHost:localhost
  server group2_server1 <host3>:<port> check
  server group2_server2 <host4>:<port> check

backend nodes
  mode http
  balance roundrobin
  option forwardfor
  http-request set-header X-Forwarded-Port %[dst_port]
  http-request add-header X-Forwarded-Proto https if { ssl_fc }
  option httpchk HEAD / HTTP/1.1\r\nHost:localhost
  server default_server <host5>:<port> check

```
>**注:** アダプターのグループ化のフィーチャーは、Mobile Foundation コンソールを介して有効にされることはありません。アダプター・グループ構成のデプロイメントは、Mobile Foundation 管理サービス API を介してのみ実行できます。
