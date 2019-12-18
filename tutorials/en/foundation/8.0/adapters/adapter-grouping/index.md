---
layout: tutorial
title: Adapter Grouping
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Mobile Foundation adapters execute the server-side logic and the transfer or retrieval of data from back-end systems. Adapters are deployed on all the instances of Mobile Foundation runtime, adapters consume system resources irrespective of its usage. In a situation where some adapters are infrequently used by the mobile application, there exists no way to scale the Mobile Foundation instance only with the frequently used adapters. Scaling the environment results in all the adapters getting deployed and running on all the newly added nodes. This behavior results in a slow start-up of the Mobile Foundation instance as the runtime needs to deploy and run all the adapters.

The adapter grouping feature enables you to group a bunch of resource adapters and run them together on a set of Mobile Foundation nodes. This set of nodes is called a **group**. The group can be scaled by adding more nodes based on the adapter load. Customers can decide beforehand the number of nodes in each group based on the expected load reaching the adapters running in that group.

>Adapter grouping is only supported for resource adapters and not for security check adapters.

### Configuration
{: #configuration }

A group in adapter grouping is a collection of Mobile Foundation nodes to run a bunch of resource adapters on it.
For example, in a farm topology with 10 nodes, customers can create three groups, Group 1 with 5 nodes (node 1, node 2, node 3, node 4, node 5), Group 2 with 3 nodes (node 6, node 7, node 8) and Group 3 with 2 nodes (node 9 , node 10).

In a WebSphere Application Server (WAS) ND topology, to achieve adapter grouping, customers can create WAS ND clusters that map to the groups in adapter grouping.
The next section explains how to get adapter grouping to work with Mobile Foundation by defining an adapter group configuration and making the nodes a part of an adapter group.
Two configuration changes need to be applied to Mobile Foundation to get adapter grouping to work.

### Define and deploy adapter group configuration
{: #deploy-adapter-group-config }

Adapter group configuration defines groups and resource adapters that belong to the group. The adapter group configuration has the following structure and needs to be deployed using the Administration API.

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

The configuration above defines adapter groups and the adapters that need to be part of those groups. The name of the adapter group is the value against the key `id`. The `adapters` key holds a value, which is a list of the resource adapters that will be deployed in the respective groups.
Listed below are the Administration APIs available for adapter group configuration.

#### Deploy Adapter Configuration
To deploy an adapter group configuration, use the following Mobile Foundation Administration API and provide the configuration parameters described above as a json payload.

**POST** `http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig`

For example,

```bash
curl -X POST --user admin:admin --header 'Content-Type: application/json' -- header 'Accept: application/json' -d '{ "groups": [{ "id": "finance", "adapters":
[ {"name": "SavingAccountAdapter" }, {"name": "LoanProcessingAdapter"}] },{"id": "hr", "adapters": [ {"name": "EmployeeInfoAdapter"}, {"name": "OnboardingAdapter"}]}]}' "http://<host>:<port>/mfpadmin/management apis/2.0/ runtimes/mfp/adapterGroupConfig"
```

#### Retrieve Adapter Group Configuration
To get an already deployed adapter group configuration, use the following Mobile Foundation Administration API.

**GET** ```http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig```

For example,

```bash
curl -X GET --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

#### Delete Adapter Group Configuration
To delete an already deployed adapter group configuration, use the following Mobile Foundation Administration API.

**DELETE** ```http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/<runtime>/adapterGroupConfig```

For example,

```bash
curl -X DELETE --user admin:admin --header 'Content-Type: application/json' "http://<host>:<port>/mfpadmin/management-apis/2.0/runtimes/mfp/adapterGroupConfig"
```

### Define groups for adapter grouping
{: #define-groups }

After you define and deploy the adapter group configuration, the next step is to create the groups. Add a runtime JNDI property called `mfp.adaptergroup.name` with value as the group name, to make the Mobile Foundation nodes part of a group.

For example,
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value="finance"/>
```

In a farm topology, if you add the JNDI property `mfp.adaptergroup.name` in the `server.xml` of a farm node then that node becomes a part of the group mentioned in the JNDI. If the above JNDI property is not mentioned for a node then the default behavior is observed, which means all the adapters get deployed on that node.

If Group1 consists of node1, node2, node3, node4, and node5, then on all nodes the `server.xml` should be modified to add the JNDI property with a value `Group1`.

For example, Group1 = [node 1, node 2, node 3, node 4, node 5]
```xml
<jndiEntry jndiName="mfp/mfp.adaptergroup.name" value=”Group1”/>
```

Similarly, other groups can be defined. For each WAS ND cluster, the JNDI property can be defined to make that cluster a group for adapter grouping.

### Adapter deployment
{: #adapter-deployment }

After you deploy the adapter group configuration and define groups, subsequent resource adapter deployments will honor the rules mentioned in the adapter group configuration. If an adapter is in the list of adapters in a group, then the adapter is deployed only on those nodes of the group that is identified by the `mfp.adaptergroup.name` JNDI property.

Some changes such as moving an adapter from one group to another group, for an already running Mobile Foundation instance, would require the restart of the Mobile Foundation instance on all the groups. However, adding a new adapter to the adapters list does not require the restart of the nodes.

### Adapter call changes
{: #adapter-call-changes }

To leverage the benefits of adapter grouping, the client side adapter calls needs to be changed to include the group information in the resource request URI. The URI will be of the form `/adaptergroups/<groupname>/adapters/<adaptername>/<method>`.

For example,

```java
adapterPath = new URI(“/adaptergroups/finance/adapters/SavingAccountAdapter/getBalance”);
WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
```

Including adapter group information in the URI informs the load balancer (as explained below) that the call should be routed to adapters running in the specified group.

### Load Balancer changes
{: #load-balancer-changes }

To get the adapter grouping to work, the main changes required are in the Load Balancer. Load Balancer should be configured to route the adapter calls to appropriate group based on the URI patterns.

![load-balancer](load-balancer.png)

Here is a sample load balancer configuration for HAProxy for a farm topology. In this configuration, the farm nodes *host1* and *host2* are configured to be part of group1, farm nodes *host3* and *host4* are configured to be part of *group2* and farm node *host5* is the default host. When the adapter call request reaches the HAProxy and if the url contains *group1*, the call is routed to *host1* and *host2*. If the request url contains *group2*, the request is routed to *host3* and *host4*. All the rest of the requests are routed to *host5*.
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
>**Note**: Adapter Grouping feature is not enabled via Mobile Foundation console. The deployment of adapter group configuration can only be done through Mobile Foundation Administration Service APIs.
