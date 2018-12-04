---
layout: tutorial
title: Benachrichtigungen im Hintergrund
relevantTo: [ios,cordova]
show_in_nav: false
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die Benachrichtigung im Hintergrund erfolgt ohne Anzeige von Alerts oder andere Störungen des Benutzers. Wenn eine Benachrichtigung im Hintergrund eingeht,
wird der Handling-Code der Anwendung im Hintergrund ausgeführt, ohne die Anwendung in den Vordergrund zu bringen. Zurzeit werden Benachrichtigungen im Hintergrund auf
iOS-Geräten der Version 7 oder einer aktuelleren Version unterstützt. Wenn die Benachrichtigung im Hintergrund an iOS-Geräte mit einer älteren Version als Version 7
gesendet wird und die Anwendung im Hintergrund ausgeführt wird, wird die Benachrichtigung ignoriert. Falls
die Anwendung im Vordergrund ausgeführt wird, wird die Callback-Methode für Benachrichtigungen aufgerufen.

## Push-Benachrichtigungen im Hintergrund senden
{: #sending-silent-push-notifications }
Bereiten Sie die Benachrichtigung vor und senden Sie sie. Weitere Informationen finden Sie unter [Push-Benachrichtigungen senden](../../sending-notifications).

Die drei für
iOS unterstützten Benachrichtigungstypen werden durch die Konstanten `DEFAULT`, `SILENT` und `MIXED` repräsentiert. Wenn der Typ nicht explizit angegeben ist, wird vom Typ `DEFAULT` ausgegangen.

Bei Benachrichtigungen vom Typ `MIXED` wird auf dem Gerät eine Nchricht angezeigt, während die App im Hintergrund aktiviert wird und eine Benachrichtigung im Hintergrund verarbeitet. Die Callback-Methode für Benachrichtigungen vom Typ
`MIXED` wird zweimal aufgerufen. Der erste Aufruf erfolgt, wenn die Benachrichtigung im Hintergrund das Gerät erreicht. Der zweite Aufruf erfolgt, wenn der Benutzer auf die Benachrichtigung tippt und so die Anwendung öffnet. 

Wählen Sie ausgehend von der Anforderung
unter **{{ site.data.keys.mf_console }} → [Ihre Anwendung] → Push →
Benachrichtigungen senden → Angepasste iOS-Einstellungen** den entsprechenden Typ. 

> **Hinweis:** Wenn die Benachrichtigung im Hintergrund erfolgt,
werden die Eigenschaften **alert**, **sound** und **badge** ignoriert. 

![Benachrichtigungstyp für iOS-Benachrichtigungen im Hintergrund in der {{ site.data.keys.mf_console }} festlegen](notification-type-for-silent-notifications.png)

## Benachrichtigungen im Hintergrund in Cordova-Anwendungen
{: #handling-silent-push-notifications-in-cordova-applications }
In der
JavaScript-Callback-Methode für Push-Benachrichtigungen müssen Sie die folgenden Schritte
ausführen: 

1. Überprüfen Sie den Benachrichtigungstyp. Beispiel:

   ```javascript
   if(props['content-available'] == 1) {
        // Benachrichtigung im Hintergrund oder gemischte Benachrichtigung. Hier Nicht-GUI-Tasks ausführen.
   } else {
        // Normale Benachrichtigung
   }
   ```

2. Rufen Sie für Benachrichtigungen im Hintergrund oder gemischte Benachrichtigungen nach Abschluss des Hintergrundjobs die API `WL.Client.Push.backgroundJobDone` auf.

## Benachrichtigungen im Hintergrund in nativen iOS-Anwendungen
{: #handling-silent-push-notifications-in-native-ios-applications }
Für den Empfang von Benachrichtigungen im Hintergrund müssen Sie die folgenden Schritte ausführen:

1. Aktivieren Sie die Anwendungsfunktion für die Ausführung von Hintergrundtasks beim Empfang der fernen Benachrichtigungen.
2. Überprüfen Sie, ob die Benachrichtigung im Hintergrund erfolgt. Prüfen Sie dazu, ob der Schlüssel `content-available` auf **1** gesetzt ist.
3. Nach der Verarbeitung der Benachrichtigung müssen Sie sofort den Block im handler-Parameter aufrufen, weil Ihre App andernfalls beendet wird. Die App hat maximal 30 Sekunden Zeit, die Benachrichtigung zu verarbeiten und den angegebenen Completion-Handler-Block aufzurufen.
