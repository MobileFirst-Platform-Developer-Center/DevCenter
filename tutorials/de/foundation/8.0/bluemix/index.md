---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Mobile Foundation in IBM Cloud verwenden
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **Hinweis:** *IBM Bluemix hat jetzt den Namen IBM Cloud. Weitere Informationen finden Sie [hier](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/).*

## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} kann in IBM Cloud gehostet werden. Nachfolgend erhalten Sie einige Basisinformationen zu IBM Cloud. 

IBM Cloud ist eine Implementierung der IBM Open Cloud Architecture, die Cloud Foundry nutzt, um Entwicklern eine rasche Entwicklung, Implementierung und Verwaltung ihrer Cloudanwendungen zu ermöglichen und ihnen gleichzeitig Zugang zu einem wachsenden System verfügbarer Services und Laufzeitframeworks gewähren. 

> Weitere Informationen zu den Konzepten der IBM Cloud Architecture und von IBM Cloud finden Sie [hier](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview).

### Funktionsweise
{: #how-does-it-work }
Kurz zusammengefasst gibt es je nach Lizenzberechtigung zwei Möglichkeiten, die {{ site.data.keys.product }} in IBM Cloud auszuführen. 

> **Hinweis:** *Der Service "IBM Containers" wird nicht mehr verwendet, weil die Mobile Foundation nicht in IBM Containern unterstützt wird. [Hier finden Sie weitere Informationen](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/).*

* IBM Cloud-Abonnement oder oder Prepaid-Lizenz: Service {{ site.data.keys.mf_bm_full }}
* Lizenz für Vor-Ort-Installation: Mit IBM Scripts können Sie eine Instanz der {{ site.data.keys.product_full }} in Kubernetes-Clustern oder einer Liberty-for-Java-Laufzeit einrichten. 

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

Wenn Sie die {{ site.data.keys.product}} für IBM Cloud in einer Liberty-for-Java-Laufzeit ausführen möchten, verwenden Sie die folgenden Komponenten: eine **Cloudfoundry-App**, die eine **WebSphere-Liberty-Installation** enthält, in der eine **MobileFirst-Server-Instanz** implementiert ist.

### Kubernetes-Cluster in IBM Cloud
Kubernetes ist ein Orchestrierungstool für die Planung von App-Containern in einem Cluster von Rechenmaschinen. Mit Kubernetes können Entwickler die Leistungsfähigkeit und Flexibilität von Containern nutzen, um rasch hoch verfügbare Anwendungen zu entwickeln.
Für die Erstellung und Verwaltung Ihrer Kubernetes-Cluster können Sie die Kubernetes-CLI nutzen. 

[Informieren Sie sich über Kubernetes-Cluster in IBM Cloud](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials). 

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Liberty-for-Java-Laufzeit
{: #liberty-for-java-runtime }
Die Liberty-for-Java-Laufzeit basiert auf dem Buildpack liberty-for-java. Dieses Buildpack stellt eine komplette Laufzeitumgebung für die Ausführung von Anwendungen auf der Basis von WebSphere Liberty Profile bereit. Für die Verwaltung Ihrer Apps in IBM Cloud wird dann eine Befehlszeilenschnittstelle verwendet.

[Informieren Sie sich über Liberty for Java](https://console.bluemix.net/docs/runtimes/liberty/index.html).


## Nächste Lernprogramme
{: #tutorials-to-follow-next }

* Erstellen Sie in IBM Cloud [mit von IBM bereitgestellten Scripts](mobilefirst-server-on-kubernetes-using-scripts/) eine Mobile-Foundation-Instanz für Kubernetes-Cluster.
* Erstellen Sie eine MobileFirst-Server-Instanz. Nutzen Sie dazu das Lernprogramm [Service {{ site.data.keys.mf_bm }} einrichten](using-mobile-foundation/).
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* Erstellen Sie in IBM Cloud [mit von IBM bereitgestellten Scripts](mobilefirst-server-using-scripts-lbp/) eine MobileFirst-Server-Instanz unter Verwendung von Liberty for Java.
