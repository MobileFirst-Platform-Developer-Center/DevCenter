---
layout: tutorial
title: 어댑터 그룹화
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
Mobile Foundation 어댑터는 서버 측 로직을 실행하고 백엔드 시스템에서 데이터를 전송하거나 검색합니다. 어댑터는 Mobile Foundation 런타임의 모든 인스턴스에 배치되며 사용량에 관계없이 시스템 리소스를 이용합니다. 일부 어댑터가 모바일 애플리케이션에서 자주 사용되지 않는 상황에서 자주 사용되는 어댑터만 사용하여 Mobile Foundation 인스턴스를 스케일링할 수 있는 방법은 없습니다. 환경을 스케일링하면 새로 추가된 모든 노드에 모든 어댑터가 배치되고 실행됩니다. 런타임이 모든 어댑터를 배치하고 실행해야 하므로 이 동작으로 인해 Mobile Foundation 인스턴스의 시작 속도가 느려집니다.

어댑터 그룹화 기능을 사용하면 다수의 리소스 어댑터를 그룹화하여 Mobile Foundation 노드 세트에서 함께 실행할 수 있습니다. 이 노드 세트를 **그룹**이라고 합니다. 어댑터 로드에 따라 노드를 더 추가하여 그룹을 스케일링할 수 있습니다. 고객은 해당 그룹에서 실행 중인 어댑터에 도달하는 예상 로드를 기반으로 각 그룹의 노드 수를 미리 결정할 수 있습니다.

>어댑터 그룹화는 리소스 어댑터에만 지원되며 보안 검사 어댑터 어댑터에는 지원되지 않습니다.

### 구성
{: #configuration }

어댑터 그룹화의 그룹은 다수의 리소스 어댑터를 실행할 Mobile Foundation 노드의 콜렉션입니다.
예를 들어, 10개의 노드가 포함된 팜(farm) 토폴로지에서 고객은 5개의 노드(노드 1, 노드 2, 노드 3, 노드 4, 노드 5)가 포함된 그룹 1, 3개의 노드(노드 6, 노드 7, 노드 8)가 포함된 그룹 2 및 2개의 노드(노드 9, 노드 10)가 포함된 그룹 3 등 3개의 그룹을 작성할 수 있습니다.

WAS(WebSphere Application Server) ND 토폴로지에서 어댑터 그룹화를 달성하기 위해 고객이 어댑터 그룹화의 그룹에 맵핑되는 WAS ND 클러스터를 작성할 수 있습니다.
다음 절에서는 어댑터 그룹 구성을 정의하고 노드를 어댑터 그룹의 일부로 지정하여 Mobile Foundation에서 어댑터 그룹화가 작동하도록 하는 방법을 설명합니다.
어댑터 그룹화가 작동하려면 두 가지 구성 변경사항이 Mobile Foundation에 적용되어야 합니다.

### 어댑터 그룹 구성 정의 및 배치
{: #deploy-adapter-group-config }

어댑터 그룹 구성은 그룹 및 그룹에 속하는 리소스 어댑터를 정의합니다. 어댑터 그룹 구성은 다음과 같은 구조이며 관리 API를 사용하여 배치해야 합니다.

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

위의 구성은 어댑터 그룹 및 해당 그룹에 속해야 하는 어댑터를 정의합니다. 어댑터 그룹의 이름은 `id` 키에 대한 값입니다. `adapters` 키는 각 그룹에 배치될 리소스 어댑터의 목록인 값을 보유합니다.
어댑터 그룹 구성에 사용 가능한 관리 API가 아래에 나열되어 있습니다.

#### 어댑터 구성 배치
어댑터 그룹 구성을 배치하려면 다음 Mobile Foundation 관리 API를 사용하고 위에 설명된 구성 매개변수를 json 페이로드로 제공하십시오.

**POST** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

예:

```bash
curl -X POST --user admin:admin --header 'Content-Type: application/json' -- header 'Accept: application/json' -d '{ "groups": [{ "id": "finance", "adapters":
[ {"name": "SavingAccountAdapter" }, {"name": "LoanProcessingAdapter"}] },{"id": "hr", "adapters": [ {"name": "EmployeeInfoAdapter"}, {"name": "OnboardingAdapter"}]}]}' "http://<host>:<port>/mfpadmin/management apis/2.0/ runtimes/mfp/adapterGroupConfig"
```

#### 어댑터 그룹 구성 검색
이미 배치된 어댑터 그룹 구성을 가져오려면 다음 Mobile Foundation 관리 API를 사용하십시오.

**GET** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

예:

```bash
curl -X GET --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

#### 어댑터 그룹 구성 삭제
이미 배치된 어댑터 그룹 구성을 삭제하려면 다음 Mobile Foundation 관리 API를 사용하십시오.

**DELETE** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

예:

```bash
curl -X DELETE --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

### 어댑터 그룹화를 위한 그룹 정의
{: #define-groups }

어댑터 그룹 구성을 정의하고 배치한 후 다음 단계는 그룹을 작성하는 것입니다. Mobile Foundation 노드를 그룹의 일부로 지정하려면 값이 그룹 이름인 `mfp.adaptergroup.name`이라는 런타임 JNDI 특성을 추가하십시오.

예:
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value="finance"/>
```

팜 토폴로지에서 JNDI 특성 `mfp.adaptergroup.name`을 팜 노드의 `server.xml`에 추가하면 노드가 JNDI에 언급된 그룹의 일부가 됩니다. 위의 JNDI 특성이 노드에 대해 언급되지 않은 경우 기본 동작이 관찰됩니다. 즉, 모든 어댑터가 해당 노드에 배치됩니다.

Group1이 node1, node2, node3, node4 및 node5로 구성된 경우 모든 노드에서 `server.xml`을 수정하여 값이 `Group1`인 JNDI 특성을 추가해야 합니다.

예: Group1 = [node 1, node 2, node 3, node 4, node 5]
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value=”Group1”/>
```

마찬가지로 다른 그룹을 정의할 수 있습니다. 각 WAS ND 클러스터에 대해 해당 클러스터가 어댑터 그룹화를 위한 그룹이 되도록 JNDI 특성을 정의할 수 있습니다.

### 어댑터 배치
{: #adapter-deployment }

어댑터 그룹 구성을 배치하고 그룹을 정의한 후에는 후속 리소스 어댑터 배치가 어댑터 그룹 구성에 언급된 규칙을 준수합니다. 어댑터가 그룹의 어댑터 목록에 있는 경우 어댑터가 `mfp.adaptergroup.name` JNDI 특성에서 식별된 그룹의 노드에만 배치됩니다.

이미 실행 중인 Mobile Foundation 인스턴스에 대한 일부 변경사항(예: 한 그룹에서 다른 그룹으로 어댑터 이동)을 적용하려면 모든 그룹의 Mobile Foundation 인스턴스를 다시 시작해야 할 수 있습니다. 그러나 새 어댑터를 어댑터 목록에 추가하는 경우에는 노드를 다시 시작할 필요가 없습니다.

### 어댑터 호출 변경사항
{: #adapter-call-changes }

어댑터 그룹화의 이점을 활용하려면 클라이언트 측 어댑터 호출이 리소스 요청 URI에 그룹 정보를 포함하도록 변경되어야 합니다. URI는 `/adaptergroups/<groupname>/adapters/<adaptername>/<method>` 양식으로 되어 있습니다.

예:

```java
adapterPath = new URI(“/adaptergroups/finance/adapters/SavingAccountAdapter/getBalance”);
WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
```

URI에 어댑터 그룹 정보를 포함하면 호출이 지정된 그룹에서 실행 중인 어댑터로 경로 지정되어야 한다고 로드 밸런서(아래 설명됨)에 알립니다.

### 로드 밸런서 변경사항
{: #load-balancer-changes }

어댑터 그룹화가 작동하도록 하기 위해 필요한 주요 변경사항은 로드 밸런서에 있습니다. URI 패턴을 기반으로 어댑터 호출을 적절한 그룹으로 경로 지정하도록 로드 밸런서를 구성해야 합니다.

![로드 밸런서](load-balancer.png)

다음은 팜 토폴로지에 대한 HAProxy의 샘플 로드 밸런서 구성입니다. 이 구성에서는 팜 노드 *host1* 및 *host2*가 group1의 일부로 구성되고 팜 노드 *host3* 및 *host4*가 *group2*의 일부로 구성되며 팜 노드 *host5*가 기본 호스트입니다. 어댑터 호출 요청이 HAProxy 에 도달하고 URL에 *group1*이 포함된 경우 호출이 *host1* 및 *host2*로 경로 지정됩니다. 요청 URL에 *group2*가 포함된 경우 요청이 *host3* 및 *host4*로 경로 지정됩니다. 나머지 요청은 모두 *host5*로 경로 지정됩니다.
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
>**참고**: 어댑터 그룹화 기능은 Mobile Foundation 콘솔을 통해서는 사용할 수 없습니다. 어댑터 그룹 구성의 배치는 Mobile Foundation 관리 서비스 API를 통해서만 수행할 수 있습니다.
