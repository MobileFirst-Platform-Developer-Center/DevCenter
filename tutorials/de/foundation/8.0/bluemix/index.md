---
layout: tutorial
breadcrumb_title: Foundation on Bluemix
title: IBM MobileFirst Foundation on Bluemix
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} kann in Bluemix gehostet werden. Nachfolgend erhalten Sie einige Basisinformationen zu Bluemix. 

IBM Bluemix ist eine Implementierung der IBM Open Cloud Architecture, die Cloud Foundry nutzt, um Entwicklern eine rasche Entwicklung, Implementierung und Verwaltung ihrer Cloudanwendungen zu ermöglichen und ihnen gleichzeitig Zugang zu einem wachsenden System verfügbarer Services und Laufzeitframeworks gewähren. 

> Weitere Informationen zur Bluemix-Architektur und zu Bluemix-Konzepten finden Sie auf der [Bluemix-Website](https://console.ng.bluemix.net/docs/overview/whatisbluemix.html#bluemixoverview).

### Funktionsweise
{: #how-does-it-work }
Kurz zusammengefasst gibt es je nach Lizenzberechtigung zwei Möglichkeiten, die {{ site.data.keys.product }} in Bluemix auszuführen. 

* Bluemix-Abonnement oder oder Prepaid-Lizenz: Service {{ site.data.keys.mf_bm_full }}
* Lizenz für Vor-Ort-Installation: Mit IBM Scripts können Sie eine Instanz der {{ site.data.keys.product_full }} in IBM Containern oder einer Liberty-for-Java-Laufzeit einrichten. 

Für die Ausführung von {{ site.data.keys.product }} on Bluemix in IBM Containern müssen mehrere Komponenten miteinander interagieren. Die erste Komponente ist ein **Image** mit einer **Linux-Distribution mit
einer WebSphere-Liberty-Installation**, in der eine **MobileFirst-Server-Instanz** implementiert ist. Dieses Image wird in einem **IBM Container** gespeichert, und der IBM Container wird dann von **Bluemix** verwaltet.

Wenn Sie {{ site.data.keys.product}} on Bluemix in einer Liberty-for-Java-Laufzeit ausführen möchten,
verwenden Sie die folgenden Komponenten: eine **Cloudfoundry-App**, die eine
**WebSphere-Liberty-Installation** enthält, in der eine **MobileFirst-Server-Instanz** implementiert ist. 

### Kubernetes-Cluster in Bluemix
Kubernetes ist ein Orchestrierungstool für die Planung von App-Containern in einem Cluster von Rechenmaschinen. Mit Kubernetes können Entwickler die Leistungsfähigkeit und Flexibilität von Containern nutzen, um rasch hoch verfügbare Anwendungen zu entwickeln.
Für die Erstellung und Verwaltung Ihrer Kubernetes-Cluster können Sie die CLI des Service IBM Container für Bluemix oder die Kubernetes-CLI nutzen. 

[Informieren Sie sich über Kubernetes-Cluster in Bluemix](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials). 

### IBM Container
{: #ibm-containers }
IBM Container sind Objekte, die verwendet werden, um Images in einer gehosteten Cloudumgebung auszuführen. IBM Container enthalten alles, was für die Ausführung einer App notwendig ist. 

Zur Infrastruktur von IBM Containern gehört eine private Registry für Ihre Images, sodass sie Images hochladen, speichern und abrufen können. Wenn Sie möchten, können Sie diese Images von Bluemix verwalten lassen. Für die Verwaltung Ihrer Container in Bluemix wird dann eine Befehlszeilenschnittstelle verwendet. Weitere Informationen hierzu finden Sie in den folgenden Lernprogrammen. 

[Informieren Sie sich über IBM Container](https://www.ng.bluemix.net/docs/containers/container_index.html).

### Liberty-for-Java-Laufzeit
{: #liberty-for-java-runtime }
Die Liberty-for-Java-Laufzeit basiert auf dem Buildpack liberty-for-java. Dieses Buildpack stellt eine komplette Laufzeitumgebung für die Ausführung von Anwendungen auf der Basis von WebSphere Liberty Profile bereit. Für die Verwaltung Ihrer Apps in Bluemix wird dann eine Befehlszeilenschnittstelle verwendet. 

[Informieren Sie sich über Liberty for Java](https://new-console.ng.bluemix.net/docs/runtimes/liberty/index.html).


## Nächste Lernprogramme
{: #tutorials-to-follow-next }

* Mobile-Foundation-Instanz in Bluemix mit [IBM Scripts](mobilefirst-server-using-kubernetes/) und einem Kubernetes-Cluster erstellen
* MobileFirst-Server-Instanz mit dem [Service {{ site.data.keys.mf_bm }}](using-mobile-foundation/) erstellen
* MobileFirst-Server-Instanz in Bluemix mit [IBM Scripts](mobilefirst-server-using-scripts/) und IBM Containern erstellen
* MobileFirst-Server-Instanz in Bluemix mit [IBM Scripts](mobilefirst-server-using-scripts-lbp/) und Liberty erstellen
