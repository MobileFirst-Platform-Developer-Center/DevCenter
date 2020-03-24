---
layout: tutorial
title: Adaptergruppierung
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mobile-Foundation-Adapter führen die serverseitige Logik aus. Außerdem übertragen sie Daten zu Back-End-Systemen und empfangen Daten von Back-End-Systemen. Adapter werden in allen Instanzen der Mobile-Foundation-Laufzeit implementiert und verbrauchen unabhängig von ihrer Verwendung Systemressourcen. Wenn einige Adapter nicht oft von der mobilen Anwendung genutzt werden, gibt es keine Möglichkeit, die Mobile-Foundation-Instanz nur mit den häufig verwendeten Adaptern zu skalieren. Die Skalierung der Umgebung führt dazu, dass alle Adapter auf allen neu hinzugefügten Knoten implementiert und ausgeführt werden. Dieses Verhalten führt zu einem langsamen Start der Mobile-Foundation-Instanz, weil die Laufzeit alle Adapter implementieren und ausführen muss.

Mit dem Feature für Adaptergruppierung können Sie Ressourcenadapter gruppieren und dann zusammen auf einer Reihe von Mobile-Foundation-Knoten ausführen. Diese Reihe von Knoten wird als **Gruppe**bezeichnet. Die Gruppe kann durch das Hinzufügen weiterer Knoten in Abhängigkeit von der Adapterlast skaliert werden. Kunden können anhand der erwarteten Auslastung der Adapter in einer Gruppe im Voraus die Anzahl der Knoten in dieser Gruppe bestimmen.

>Die Adaptergruppierung wird nur für Ressourcenadapter unterstützt, nicht aber für Adapter für Sicherheitsüberprüfungen.

### Konfiguration
{: #configuration }

Im Rahmen der Adaptergruppierung ist eine Gruppe eine Sammlung von Mobile-Foundation-Knoten, auf denen eine Reihe von Ressourcenadaptern ausgeführt wird.
In einer Farmtopologie mit 10 Knoten können Kunden beispielsweise drei Gruppen erstellen: Gruppe 1 mit 5 Knoten (Knoten 1, Knoten 2, Knoten 3, Knoten 4, Knoten 5), Gruppe 2 mit 3 Knoten (Knoten 6, Knoten 7, Knoten 8) und Gruppe 3 mit 2 Knoten (Knoten 9, Knoten 10).

In einer WAS-ND-Topologie (WebSphere Application Server Network Deployment) können Kunden für die Adaptergruppierung WAS-ND-Cluster erstellen, die den Gruppen der Adaptergruppierung zugeordnet werden.
Im nächsten Abschnitt ist erläutert, wie die Adaptergruppierung in der Mobile Foundation funktioniert. Es wird eine Adaptergruppenkonfiguration definiert und die Knoten werden zu einem Teil einer Adaptergruppe gemacht.
Zwei Konfigurationsänderungen sind in der Mobile Foundation erforderlich, damit die Adaptergruppierung funktioniert. 

### Adaptergruppenkonfiguration definieren und implementieren
{: #deploy-adapter-group-config }

Die Adaptergruppenkonfiguration definiert Gruppen und die zugehörigen Ressourcenadapter. Die Adaptergruppenkonfiguration hat folgende Struktur und muss mit der Verwaltungs-API implementiert werden.

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

Die obige Konfiguration definiert Adaptergruppen und die Adapter, die Teil dieser Gruppen sein müssen. Der Name der Adaptergruppe ist der Wert für den Schlüssel `id`. Der Wert für den Schlüssel `adapters` ist eine Liste der Ressourcenadapter, die in den jeweiligen Gruppen implementiert werden. Nachfolgend sind die für die Adaptergruppenkonfiguration verfügbaren Verwaltungs-APIs aufgelistet. 

#### Adapterkonfiguration implementieren
Wenn Sie eine Adaptergruppenkonfiguration implementieren möchten, verwenden Sie die folgende Mobile-Foundation-Verwaltungs-API und geben Sie die oben beschriebenen Konfigurationsparameter als JSON-Nutzdaten an.

**POST** `http://<Host>:<Port>/mfpadmin/management-apis/2.0/runtimes/<Laufzeit>/adapterGroupConfig`

Beispiel:

```bash
curl -X POST --user admin:admin --header 'Content-Type: application/json' -- header 'Accept: application/json' -d '{ "groups": [{ "id": "finance", "adapters":
[ {"name": "SavingAccountAdapter" }, {"name": "LoanProcessingAdapter"}] },{"id": "hr", "adapters": [ {"name": "EmployeeInfoAdapter"}, {"name": "OnboardingAdapter"}]}]}' "http://<host>:<port>/mfpadmin/management apis/2.0/ runtimes/mfp/adapterGroupConfig"
```

#### Adaptergruppenkonfiguration abrufen
Wenn Sie eine bereits implementierte Adaptergruppenkonfiguration abrufen möchten, verwenden Sie die folgende Mobile-Foundation-Verwaltungs-API.

**GET** `http://<Host>:<Port>/mfpadmin/management-apis/2.0/runtimes/<Laufzeit>/adapterGroupConfig`

Beispiel:

```bash
curl -X GET --user admin:admin --header 'Content-Type: application/json' "http://<Host>:<Port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

#### Adaptergruppenkonfiguration löschen
Wenn Sie eine bereits implementierte Adaptergruppenkonfiguration löschen möchten, verwenden Sie die folgende Mobile-Foundation-Verwaltungs-API.

**DELETE** `http://<Host>:<Port>/mfpadmin/management-apis/2.0/runtimes/<Laufzeit>/adapterGroupConfig`

Beispiel:

```bash
curl -X DELETE --user admin:admin --header 'Content-Type: application/json' "http://<Host>:<Port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

### Gruppen für die Adaptergruppierung definieren
{: #define-groups }

Nachdem Sie die Adaptergruppenkonfiguration definiert und implementiert haben, ist als nächster Schritt die Erstellung der Gruppen erforderlich. Fügen Sie eine JNDI-Laufzeiteigenschaft mit dem Namen `mfp.adaptergroup.name` als Gruppennamen hinzu, um die Mobile-Foundation-Knoten zum Teil einer Gruppe zu machen.

Beispiel:
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value="finance"/>
```

Wenn Sie in einer Farmtopologie die JNDI-Eigenschaft `mfp.adaptergroup.name` zur Datei `server.xml` eines Farmknotens hinzufügen, wird dieser Knoten zu einem Teil der in der JNDI-Eigenschaft genannten Gruppe. Wenn die obige JNDI-Eigenschaft für einen Knoten nicht angegeben ist, können Sie das Standardverhalten beobachten. Das bedeutet, alle Adapter werden auf diesem Knoten implementiert.

Wenn Gruppe 1 (Group1) aus den Knoten 1 bis 5 (node1, node2, node3, node4 und node5) besteht, muss auf allen Knoten die Datei `server.xml` modifiziert werden. Die JNDI-Eigenschaft muss mit dem Wert `Group1` hinzugefügt werden.

Beispiel: Group1 = [node 1, node 2, node 3, node 4, node 5]
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value=”Group1”/>
```

In ähnlicher Weise können andere Gruppen definiert werden. Für jeden WAS-ND-Cluster kann die JNDI-Eigenschaft definiert werden, um diesen Cluster zu einer Gruppe für die Adaptergruppierung zu machen.

### Adapterimplementierung
{: #adapter-deployment }

Nachdem Sie die Adaptergruppenkonfiguration implementiert und Gruppen definiert haben, werden bei nachfolgenden Ressourcenadapterimplementierungen die in der Adaptergruppenkonfiguration genannten Regeln berücksichtigt. Wenn ein Adapter in der Liste der Adapter für eine Gruppe enthalten ist, wird er nur auf den Knoten der durch die JNDI-Eigenschaft `mfp.adaptergroup.name` bezeichneten Gruppe implementiert.

Einige Änderungen, z. B. das Verschieben eines Adapters in eine andere Gruppe, erfordern bei einer bereits aktiven Mobile-Foundation-Instanz den Neustart der Mobile-Foundation-Instanz für alle Gruppen. Wenn ein neuer Adapter zur Adapterliste hinzugefügt wird, ist jedoch kein Neustart der Knoten erforderlich. 

### Änderungen an Adapteraufrufen
{: #adapter-call-changes }

Wenn Sie von den Vorteilen der Adaptergruppierung profitieren möchten, müssen Sie die clientseitigen Adapteraufrufe so ändern, dass sie die Gruppeninformationen in der URI der Ressourcenanforderung enthalten. Der URI hat das Format `/adaptergroups/<Gruppenname>/adapters/<Adaptername>/<Methode>`.

Beispiel:

```java
adapterPath = new URI(“/adaptergroups/finance/adapters/SavingAccountAdapter/getBalance”);
WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
```

Durch die Einbeziehung von Adaptergruppeninformationen in die URI wird der Load Balancer (siehe unten) darüber informiert, dass der Aufruf an Adapter weitergeleitet werden soll, die in der angegebenen Gruppe ausgeführt werden.

### Load-Balancer-Änderungen
{: #load-balancer-changes }

Die wichtigsten Änderungen, die für ein Funktionieren der Adaptergruppierung erforderlich sind, müssen im Load Balancer vorgenommen werden. Der Load Balancer muss so konfiguriert werden, dass Adapteraufrufe an die laut URI-Muster richtige Gruppe weitergeleitet werden.

![Load Balancer](load-balancer.png)

Hier sehen Sie eine Load-Balancer-Beispielkonfiguration für HAProxy in einer Farmtopologie. In dieser Konfiguration sind die Farmknoten *host1* und *host2* als Teil der Gruppe group1 definiert, die Farmknoten *host3* und *host4* als Teil der Gruppe *group2* und der Farmknoten *host5* als Standardhost. Wenn die Adapteraufrufanforderung HAProxy erreicht und die URL *group1* enthält, wird der Aufruf an *host1* und *host2* weitergeleitet. Enthält die Anforderungs-URL *group2*, wird die Anforderung an *host3* und *host4* weitergeleitet. Alle übrigen Anforderungen werden an *host5* weitergeleitet.
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
  server group1_server1 <host1>:<Port> check
  server group1_server2 <host2>:<Port> check

backend group2_server
  mode http
  balance roundrobin
  option forwardfor
  http-request set-header X-Forwarded-Port %[dst_port]
  http-request add-header X-Forwarded-Proto https if { ssl_fc }
  option httpchk HEAD / HTTP/1.1\r\nHost:localhost
  server group2_server1 <host3>:<Port> check
  server group2_server2 <host4>:<Port> check

backend nodes
  mode http
  balance roundrobin
  option forwardfor
  http-request set-header X-Forwarded-Port %[dst_port]
  http-request add-header X-Forwarded-Proto https if { ssl_fc }
  option httpchk HEAD / HTTP/1.1\r\nHost:localhost
  server default_server <host5>:<Port> check

```
>**Hinweis**: Das Feature für Adaptergruppierung wird nicht über die Mobile-Foundation-Konsole aktiviert. Die Implementierung der Adaptergruppenkonfiguration ist nur mithilfe der APIs des Mobile-Foundation-Verwaltungsservice möglich. 
