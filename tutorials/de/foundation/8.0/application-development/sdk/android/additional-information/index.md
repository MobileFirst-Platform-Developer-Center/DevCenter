---
layout: tutorial
title: Zusätzliche Informationen
breadcrumb_title: Zusätzliche Infos
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Javadocs für ein Android-Studio-Gradle-Projekt registrieren
{: #registering-javadocs-to-an-android-studio-gradle-project }
Die {{ site.data.keys.product_adj }}-Android-Javadocs sind in den
von Gradle importierten *.aar-Dateien enthalten. Sie müssen diese jedoch mit der zugehörigen Bibliothek in
Android Studio verlinken. 

1. Sie müssen die Ansicht **Project** von Android Studio öffnen.
2. Suchen Sie unter dem Knoten **External
Libraries** nach dem Bibliotheksnamen. (Darunter erscheint die Javadoc-Datei.)
3. Klicken Sie mit der rechten Maustaste auf den Bibliotheksnamen und wählen Sie **Library Properties** aus.
4. Wählen Sie im Dialog "Library Properties" die Schaltfläche mit dem
Pluszeichen ("+") aus.
5. Navigieren Sie zu der heruntergeladenen Javadoc-JAR-Datei
(**ibmmobilefirstplatformfoundation-javadoc.jar**)
unter **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** und wählen Sie sie aus.
6. Klicken Sie auf **OK**. Die Javadocs sind jetzt in Ihrem Projekt verfügbar.

### Hinweise
{: #notes }

* Die {{ site.data.keys.product_adj }}-APIs
können nicht aus einem Android-Service heraus aktiviert werden.
