---
layout: tutorial
title: App im IBM Application Center veröffentlichen
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## App veröffentlichen
{: #dab-app-publish }

Mithilfe der Option "Veröffentlichen" können Sie Ihre App für Android/iOS erstellen und im App Center veröffentlichen oder direkte Aktualisierungen mit neuen Webressourcen für Ihre App drahtlos veröffentlichen.

### App im Application Center veröffentlichen
{: #dab-app-publish-to-app-center }

Das IBM MobileFirst Foundation Application Center ist ein Repository für mobile Anwendungen, das mit öffentlichen App Stores vergleichbar ist, jedoch auf die Bedürfnisse einer Organisation oder eines Teams ausgerichtet ist. Das Application Center ist ein privater App Store. Weitere Informationen zum Application Center finden Sie [hier](http://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/appcenter/app-center-tutorial/).

Sie können Ihre App mit der Funktion **Veröffentlichen** des Digital App Builder zum Repository auf dem Server hinzufügen.

>**Hinweis**: Stellen Sie sicher, dass Ihre App fehlerfrei erstellt wurde, bevor Sie sie im Application Center veröffentlichen. 

1. Klicken Sie für Ihr App-Projekt auf **Veröffentlichen**. Daraufhin wird ein Popup-Fenster mit den ausgewählten Plattformen geöffnet.

    ![Veröffentlichung](dab-publish.png)

2. Wählen Sie die **Plattform** aus, für die Ihre App veröffentlicht werden soll.

3. Klicken Sie auf **Web Checksum**, um das Kontrollsummenfeature für Webressourcen zu aktivieren. Weitere Informationen finden Sie unter [Kontrollsummenfeature für Webressourcen aktivieren](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Klicken Sie auf **Web Resource Encryption**, um die Webressourcen Ihrer Cordova-Pakete zu verschlüsseln. Weitere Informationen finden Sie unter [Webressourcen Ihrer Cordova-Pakete verschlüsseln](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).

2. Klicken Sie auf **Im Application Center veröffentlichen**.

    ![Veröffentlichung im Application Center](dab-publish-app-center.png)

3. Wählen Sie ein vorhandenes Application Center aus oder klicken Sie auf **Neu verbinden**. Klicken Sie auf **Verbinden**.
4. Daraufhin wird das Paket für die ausgewählte Plattform erstellt.
5. *iOS*: Bearbeiten Sie die Datei *app-build.json* und aktualisieren Sie den Wert im Feld `developmentTeam` mit Ihrer Apple Developer Team ID. Wenn Sie die Team ID herausfinden möchten, melden Sie sich mit Ihrem [Apple Developer Account](https://developer.apple.com/account/#/membership) an. 

    ![Veröffentlichung unter iOS](dab-publish-ios.png)

6. Klicken Sie auf **Veröffentlichen**, wenn die Pakete bereit sind.
7. Nach erfolgreicher Veröffentlichung wird ein QR-Code generiert.

    ![QR-Code bei Veröffentlichung im Application Center](dab-publish-code-scan.png)

8. Sie können prüfen, ob die App im Application Center verfügbar ist. Melden Sie sich dazu beim **Application Center** an und wählen Sie **Anwendungsmanagement** aus.

>**Hinweis**: Sie können die erforderliche Plattform erneut auswählen und die App dann erstellen und im **Application Center** veröffentlichen.

### Direkte Aktualisierung veröffentlichen
{: #dab-publish-direct-update }

Sie können die [direkte Aktualisierung](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/application-development/direct-update/) nutzen, um Cordova-Anwendungen drahtlos mit neuen Webressourcen zu aktualisieren, z. B. mit geänderter, korrigierter oder neuer Anwendungslogik (JavaScript), mit HTML, mit CSS oder mit Bildern. Organisationen können so sicherstellen, dass Endbenutzer immer die neueste Version der Anwendung nutzen.

>**Hinweis**: Stellen Sie sicher, dass Ihre App fehlerfrei erstellt wurde, bevor Sie sie im Application Center veröffentlichen. 

1. Klicken Sie für Ihr App-Projekt auf **Veröffentlichen**. Daraufhin wird ein Popup-Fenster mit den ausgewählten Plattformen geöffnet.

    ![Veröffentlichung](dab-publish.png)

2. Wählen Sie die **Plattform** aus, für die Ihre App veröffentlicht werden soll.

3. Klicken Sie auf **Web Checksum**, um das Kontrollsummenfeature für Webressourcen zu aktivieren. Weitere Informationen finden Sie unter [Kontrollsummenfeature für Webressourcen aktivieren](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/application-development/cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature).

4. Klicken Sie auf **Web Resource Encryption**, um die Webressourcen Ihrer Cordova-Pakete zu verschlüsseln. Weitere Informationen finden Sie unter [Webressourcen Ihrer Cordova-Pakete verschlüsseln](https://mobilefirstplatform.ibmcloud.com/tutorials/de/foundation/8.0/application-development/cordova-apps/securing-apps/#encrypting-the-web-resources-of-your-cordova-packages).
5. Klicken Sie auf **Direkte Aktualisierung veröffentlichen**. Wenn Benutzer die App starten und eine Verbindung zu Mobile Foundation Server herstellen, erscheint eine Aufforderung, die Webressourcen zu aktualisieren. Nach entsprechender Bestätigung werden dem Benutzer die aktualisierten Webressourcen zur Verfügung gestellt.
