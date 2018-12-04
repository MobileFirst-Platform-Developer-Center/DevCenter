---
layout: tutorial
title: 迁移现有适配器以在 MobileFirst Server V8.0.0 下工作
breadcrumb_title: Migrating existing adapters
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
从 {{ site.data.keys.mf_server }} V8.0 开始，适配器是 Maven 项目。 了解如何升级在 {{ site.data.keys.mf_server }} 的较早版本下开发的适配器。

本页面描述了迁移适配器（开发为与 MobileFirst Server V6.2 或更高版本一起使用）以与 {{ site.data.keys.mf_server }} V8.0一起使用所需采取的步骤。  
首先请了解 [V8.0 中不推荐使用的功能以及 API 元素和服务器端 API 更改](../../product-overview/release-notes/deprecated-discontinued/)中描述的适配器 API 更改。

* 在某些情况下，现有适配器可按原样与 {{ site.data.keys.mf_server }} V8.0 一起使用。 请参阅[在 {{ site.data.keys.mf_server }} V8.0 下按原样使用较旧的适配器](#using-older-adapters-as-is-under-mobilefirst-server-v-80)。
* 在大多数情况下，需要升级适配器。 对于 Java™ 适配器，请参阅[针对 {{ site.data.keys.mf_server }} V8.0 将 Java 适配器迁移到 Maven 项目](#migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80)。 对于 JavaScript 适配器，请参阅[针对 {{ site.data.keys.mf_server }} V8.0 将 JavaScript 适配器迁移到 Maven 项目](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)。

## 在 {{ site.data.keys.mf_server }} V8.0 下按原样使用较旧的适配器
{: #using-older-adapters-as-is-under-mobilefirst-server-v-80 }
除非符合以下任何条件，否则现有适配器可按原样部署在 {{ site.data.keys.mf_server }} V8.0 下：

| 适配器类型 | 条件 | 
|--------------|-----------|
| Java | 使用 PushAPI 或 SecurityAPI 接口 | 
| JavaScript | {::nomarkdown}<ul><li>使用 IBM Worklight V6.2 或更低版本构建。</li><li>使用不是 HTTP 或 SQL 的连接类型。</li><li>包含 securityTest 定制过程</li><li>包含使用用户身份来连接到后端的过程</li><li>使用以下任何 API：<ul><li>WL.Device.*</li><li>WL.Geo.\*</li><li>WL.Server.readSingleJMSMessage</li><li>WL.Server.readAllJMSMessages</li><li>WL.Server.writeJMSMessage</li><li>WL.Server.requestReplyJMSMessage</li><li>WL.Server.getActiveUser</li><li>WL.Server.setActiveUser</li><li>WL.Server.getCurrentUserIdentity</li><li>WL.Server.getCurrentDeviceIdentity</li><li>WL.Server.createEventSource</li><li>WL.Server.createDefaultNotification</li><li>WL.Server.getUserNotificationSubscription</li><li>WL.Server.notifyAllDevices</li><li>WL.Server.notifyDeviceToken</li><li>WL.Server.notifyDeviceSubscription</li><li>WL.Server.sendMessage</li><li>WL.Server.createEventHandler</li><li>WL.Server.setEventHandlers</li><li>WL.Server.setApplicationContext</li><li>WL.Server.fetchNWBusinessObject</li><li>WL.Server.createNWBusinessObject</li><li>WL.Server.deleteNWBusinessObject</li><li>WL.Server.updateNWBusinessObject</li><li>WL.Server.getBeaconsAndTriggers</li><li>WL.Server.signSoapMessage</li><li>WL.Server.createSQLStatement</li></ul></li></ul>{:/} |

## 针对 {{ site.data.keys.mf_server }} V8.0 将 Java 适配器迁移到 Maven 项目
{: #migrating-java-adapters-to-maven-projects-for-mobilefirst-server-v-80}
1. 创建 archetype 为 **adapter-maven-archetype-java** 的 Maven 适配器项目。 在设置参数 **artifactId** 时，请使用适配器名称；对于参数 **package**，请使用与现有 Java 适配器中的包相同的包。 有关更多信息，请参阅[创建 Java 适配器](../../adapters/creating-adapters)。
2. 覆盖在步骤 1 中创建的新适配器项目的 **src/main/adapter-resources** 文件夹中的适配器描述符文件 (**adapter.xml**)。有关描述符的更多详细信息，请参阅 [Java 适配器描述符文件](../../adapters/java-adapters/#the-adapter-resources-folder)。
3. 从新适配器项目的 **src/main/java** 文件夹中除去所有文件。 然后，复制旧 Java 适配器项目的 **src/** 文件夹下的所有 Java 文件，并保持相同的文件夹结构。 将所有非 Java 文件从旧适配器的 **src** 文件夹复制到新适配器的 **src/main/resources** 文件夹。 缺省情况下，**src/main/resources** 不存在，因此如果适配器包含非 Java 文件，请创建此目录。 有关 Java 适配器 API 中的更改，请参阅 [V8.0 中的服务器端 API 更改](#migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80)。

   下图说明了 V7.1 之前适配器的结构以及 Maven 适配器（从 V8.0 开始）的结构：

   ```xml
    ├── adapters
    │   └── RSSAdapter
    │       ├── RSSAdapter.xml
    │       ├── lib
    │       └── src
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```
    
   Java 适配器的新结构：

   ```xml
    ├── pom.xml
    ├── src
    │   └── main
    │       ├── adapter-resources
    │       │   └── adapter.xml
    │       └── java
    │           └── com
    │               └── sample
    │                   ├── RSSAdapterApplication.java
    │                   └── RSSAdapterResource.java
   ```

4. 使用以下任一方法，添加 Maven 存储库中未包含的任何 JAR 文件：
    * 将 JAR 文件添加到本地存储库（如 [Guide to installing third-party JARs](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html) 中所述），然后将其添加到 **dependencies** 元素。
    * 使用 **systemPath** 元素将 JAR 文件添加到 dependencies 元素中。 有关更多信息，请参阅 [Introduction to the Dependency Mechanism](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)。

## 针对 {{ site.data.keys.mf_server }} V8.0 将 JavaScript 适配器迁移到 Maven 项目
{: #migrating-javascript-adapters-to-maven-projects-for-mobilefirst-server-v-80 }
1. 创建 archetype 为 **adapter-maven-archetype-http 或 adapter-maven-archetype-sql** 的 Maven 适配器项目。 在设置参数 **artifactId** 时，使用适配器名称。 有关更多信息，请参阅[创建 JavaScript 适配器](../../adapters/creating-adapters)。
2. 覆盖在步骤 1 中创建的新适配器项目的 **src/main/adapter-resources** 文件夹中的适配器描述符文件 (**adapter.xml**)。有关描述符的详细信息，请参阅 [JavaScript 适配器描述符文件](../../adapters/javascript-adapters/#the-adapter-resources-folder)。
3. 覆盖新适配器项目的 **src/main/adapter-resources/js** 文件夹中的 JavaScript 文件。
