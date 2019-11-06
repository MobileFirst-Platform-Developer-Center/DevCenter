---
layout: tutorial
title: App-internes Benutzerfeedback
breadcrumb_title: User Feedback
relevantTo: [ios,android,cordova]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Mit dem App-internen Feature für Benutzerfeedback können Benutzer Ihrer Anwendungen Momentaufnahmen der Anwendung erstellen und diese mit Markierungen und Kommentaren versehen, die ihre Meinung zu der Anwendung widerspiegeln.    

Stellen Sie vor allem anderen sicher, dass das App-interne Erfassen und Senden von Benutzerfeedback in Ihrer mobilen Anwendung aktiviert ist. Lesen Sie hierzu die Informationen unter [Benutzerfeedback App-intern erfassen & senden](../../analytics-api#sending-userfeedback-data).

Benutzerrückmeldungen, die auf mobilen Geräten erfasst und von diesen Geräten gesendet wurden, werden vom Mobile Foundation Analytics Service zusammengefasst und den Eignern und Entwicklern der Anwendung in der Analytics Console präsentiert, sodass diese Einblicke erhalten und ggf. Aktionen einleiten können.   

## Liste der App-internen Benutzerrückmeldungen anzeigen

Wählen Sie in der Mobile Foundation Analytics Console links im Navigationsbereich die Option **Dashboard** aus. Wählen Sie dann im rechten Fensterbereich oben die Menüoption **Benutzerfeedback** aus.    

Bei Auswahl der Option sehen Sie im rechten Fensterbereich der Analytics Console eine Tabelle mit einer Auflistung der Benutzerrückmeldungen, die von den Benutzern Ihrer Anwendung eingegangen sind. Sie können den Tabelleninhalt nach Zeitraum, Anwendung sowie nach Betriebssystem und Version des Geräts filtern. Darüber hinaus können Sie das Feedback nach eingeleiteten Aktionen filtern. 

![Zusammenfassung zum Benutzerfeedback](userFeedbackSummary.png)

## Details der App-internen Benutzerrückmeldungen anzeigen

Wenn Sie die Details der Rückmeldungen anzeigen möchten, klicken Sie auf das Feedback, das Sie näher interessiert. Daraufhin wird ein Modaldialog mit folgendem Inhalt geöffnet:  

* Rotierbare Screenshots der mobilen Anwendung mit Benutzeranmerkungen    
* Liste der Kommentartexte eines Benutzers zu jedem Screenshot
* Angaben zu Aktionen des Anwendungseigners oder des Feedbackprüfers für das gesamte Feedback (einschließlich der Screenshots). Der Eiger oder Prüfer kann das Feedback beispielsweise teilweise oder vollständig akzeptieren, aber auch zurückweisen. Zusätzlich gibt es einen Textbereich, in dem der Anwendungseiger oder der Prüfer des Feedbacks Komentare eingeben kann.   

Sie haben außerdem die Möglichkeit, das Feedback mit allen Details (d. h. Screenshots und Kommentaren) herunterzuladen. Der Anwendungseigner kann die heruntergeladenen Feedbackdetails beispielsweise einem Git- oder Jira-Problem zuordnen und an die entsprechende Stelle hochladen.   

![Benutzerfeedbackdetails](userFeedbackDetail.png)

> **Hinweis**: Die Aktionseinstellung für Feedback ist derzeit nur eine Markierung für den Feedbackprüfstatus. Es gibt keine integrierten gestaffelten Aktionen wie die Erstellung eines Jira- oder Git-Problems, in das dann alle Feedbackinformationen kopiert werden können.    

