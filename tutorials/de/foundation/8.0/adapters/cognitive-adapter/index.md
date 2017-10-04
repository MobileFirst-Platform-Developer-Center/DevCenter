---
layout: tutorial
title: Adapter für kognitive Watson-Services
breadcrumb_title: Adapter für Watson-Services
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit Watson für Bluemix erhalten Sie Zugang zum derzeit breitesten Spektrum verfügbarer kognitiver Technologien für die schnelle und sichere Erstellung intelligenter Anwendungen. Die Analyse von Bildern und Videos zum besseren Verständnis von Stimmungen sowie das Extrahieren von Schlüsselwörtern und Entitäten aus Texten sind nur einige der Möglichkeiten, die Ihnen Watson-Services eröffnen. 

In Fragen der kognitiven Datenverarbeitung hat Watson weit mehr zu bieten. Das Verstehen der natürlichen Sprache und die visuelle Erkennung führen ausgehend von unstrukturierten Daten zu Einsichten, die ein Neudenken von Prozessen und eine Transformation von Industrien ermöglichen. [Hier](https://www.ibm.com/watson/developercloud/) erfahren Sie mehr über kognitive Watson-Services für Bluemix. 

Mit MobileFirst-Foundation-Adaptern wird die notwendige serverseitige Logik ausgeführt. Adapter werden zudem verwendet, um Informationen für Clientanwendungen und Cloud-Services von Back-End-Systemen abzurufen. Die {{ site.data.keys.product }} stellt jetzt Adapter für einige der kognitiven Watson-Services bereit. 

##  Adapter für Watson-Services
{: #watson-adapter}

Die {{ site.data.keys.product_full }} stellt mit dem [iFix 8.0.0.0-MFPF-IF20170710-1834](https://mobilefirstplatform.ibmcloud.com/blog/2017/07/11/8-0-ifix-release/) einsatzbereite Adpter für einige kognitive Watson-Services wie [Conversation](https://www.ibm.com/watson/developercloud/conversation.html) (Gespräche), [Discovery](https://www.ibm.com/watson/developercloud/discovery.html) (Erkennung) und [Natural Language Understanding](https://www.ibm.com/watson/developercloud/natural-language-understanding.html) (Verstehen natürlicher Sprache) bereit. Diese Adapter können in der Mobile-Foundation-Konsole über das **Download-Center** heruntergeladen werden. 

Laden Sie den Adapter für den kognitiven Watson-Service herunter und implementieren Sie ihn im {{ site.data.keys.product_adj }} Server, damit Ihre Anwendung eine Verbindung zu dem kognitiven Service herstellen kann. Die Anwendung kann jetzt die Adapter-API aufrufen, um den Watson-Service aufzurufen. 

Wenn der Adapter implementiert ist, müssen Sie ihn so konfigurieren, dass er eine Verbindung zu dem Watson-Service herstellt. Öffnen Sie dazu die Seite **Adapter Configuration** und tragen Sie aus den Watson-Serviceberechtigungsnachweisen (**Service Credentials**) die Werte für _**username**_ und _**password**_ ein. Speichern Sie dann die Konfiguration 

Falls Sie den Adapter modifizieren müssen, laden Sie den Adapterquellcode aus dem Github-Repository herunter: <br/>
[_**WatsonConversation**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter)<br/> [_**WatsonDiscovery**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter)<br/>
[_**WatsonNLU (Natural Language Understanding)**_](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter)
