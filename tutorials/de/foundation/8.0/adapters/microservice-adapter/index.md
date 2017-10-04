---
layout: tutorial
title: Automatische Adaptergenerierung
breadcrumb_title: Automatische Adaptergenerierung
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit MobileFirst-Foundation-Adaptern wird die notwendige serverseitige Logik ausgeführt. Adapter werden zudem verwendet, um Informationen für Clientanwendungen und Cloud-Services von Back-End-Systemen abzurufen.

##  Adapter anhand der zugehörigen OpenAPI-Spezifikation generieren
{: #generate-adapter-openapi-spec}

Mit der automatischen Adaptergenerierung anhand der zugehörigen OpenAPI-Spezifikation (Swagger-Spezifikation) können Sie die Anwendungsentwicklung beschleunigen. Der Benutzer der {{ site.data.keys.product }} kann sich jetzt auf die Anwendungslogik konzentrieren, anstatt den MobileFirst-Foundation-Adapter zu erstellen, der die Anwendung mit dem gewünschten Back-End-Service verbindet. 

>**Hinweis:** Dieses Feature ist nur im DevKit verfügbar.

Für die Nutzung dieses Features muss die JSON-OpenAPI-Spezifikation für den Mikroservice (oder den gewünschten Back-End-Service) zur Verfügung stehen. Das Feature für Adaptergenerierung wird von einem Erweiterungsadapter mit der Bezeichnung **Microservice Connector** oder **Microservice Adapter Generator** bereitgestellt, der in der MobileFirst-Foundation-Konsoel über das **Download-Center** heruntergeladen werden kann. 

>**Hinweis:** Als Voraussetzung muss die Variable JAVA_HOME so konfiguriert sein, dass sie auf den installierten JDK-Ordner zeigt. 


  ![Adaptergenerator im Download-Center](./AdapterGen_DownloadCenter.png)


Laden Sie den Adapter **Microservice Adapter Generator** herunter und implementieren Sie ihn im Mobile-Foundation-Server. Der implementierte Adapter wird damm im Navigationsfenster unter **Erweiterungen** aufgelistet. 


  ![Adaptergenerator im Navigationsfenster](./AdapterGen_naviagtionPane.png)


Wenn Sie auf **Microservice Adapter Generator** klicken, wird eine Seite göffnet, auf der der Benutzer eine JSON-Datei mit der OpenAPI-Spezifikation angeben und bei Bedarf den Adapter anhand eben dieser OpenAPI-Spezifikation generieren lassen kann. 

  ![Seite für den Adaptergenerator](./AdapterGen_generationPage.png)


Nach der Genrierung wird der Adapter automatisch in den Browser heruntergeladen. Der Benutzer ist nun gefordert, den generierten Adapter für die Nutzung in seinen Apps zu implementieren. 

Der Adaptergenerator ist auf die Korrektheit der JSON-Datei mit der OpenAPI-Spezifikation angewiesen. Wenn die Spezifikation unvollständig oder fehlerhaft ist, kann die Generierung fehlschlagen oder können Adapter-APIs generiert werden, die nicht zu den APIs der Back-End-Mikroservices passen. 

>Weitere Informationen finden Sie im Blogbeitrag [Auto Generate Adapters for Microservices and backend systems from its OpenAPI Specification](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/10/autogenerate-adapter-from-openapi-specification/).
