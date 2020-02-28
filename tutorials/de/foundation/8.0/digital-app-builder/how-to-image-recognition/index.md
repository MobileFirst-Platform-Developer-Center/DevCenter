---
layout: tutorial
title: Bilderkennung zur App hinzufügen
weight: 11
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Watson Visual Recognition
{: #dab-watson-vr }

Die Bilderkennung erfolgt durch den Service Watson Visual Recognition in IBM Cloud. Erstellen Sie eine Watson-Visual-Recognition-Instanz in IBM Cloud. Weitere Informationen finden Sie [hier](https://cloud.ibm.com/catalog/services/visual-recognition).

Im Anschluss an die Konfiguration können Sie ein neues Modell erstellen und Klassen zu diesem hinzufügen. Sie können mit der Maus Bilder in den Application Builder ziehen und dann Ihr Modell mithilfe dieser Bilder trainieren. Nach Abschluss des Trainings können Sie das zentrale ML-Modell herunterladen oder das Modell in einem KI-Steuerelement in Ihrer App verwenden.

Gehen Sie wie folgt vor, um Visual Recognition für Ihre App zu aktivieren:

1. Klicken Sie auf **Watson** und dann auf **Bilderkennung**. Daraufhin erscheint die Anzeige **Arbeiten mit Watson Visual Recognition**.

    ![Watson Visual Recognition](dab-watson-vr.png)

2. Klicken Sie auf **Verbinden** für eine Verbindung zu Ihrer Watson-Visual-Recognition-Instanz.

    ![Watson-Visual-Recognition-Instanz](dab-watson-vr-instance.png)

3. Geben Sie die Details des **API-Schlüssels** ein und geben Sie die **URL** Ihrer Watson-Visual-Recognition-Instanz an. 
4. Geben Sie einen **Namen** für Ihre Bilderkennungsinstanz in der App an und klicken Sie auf **Verbinden**. Daraufhin wird das Dashboard für Ihr Modell angezeigt.

    ![Watson VR - Neues Modell](dab-watson-vr-new-model.png)

5. Klicken Sie auf **Neues Modell hinzufügen**, um ein neues Modell zu erstellen. Daraufhin erscheint die Anzeige **Neues Modell erstellen**.

    ![Watson VR - Modellname](dab-watson-vr-model-name.png)

6. Geben Sie den **Modellnamen** ein und klicken Sie auf **Erstellen**. Daraufhin werden die Klassen für dieses Modell und eine Klasse **Negative** angezeigt.

    ![Watson VR - Modellklasse](dab-watson-vr-model-class.png)

7. Klicken Sie auf **Neue Klasse hinzufügen**. Daraufhin erscheint eine Anzeige, in der Sie einen Namen für die neue Klasse angeben müssen.

    ![Watson VR - Modellklassenname](dab-watson-vr-model-class-name.png)

8. Geben Sie den **Klassennamen** für die neue Klasse ein und klicken Sie auf **Erstellen**. Daraufhin erscheint der Arbeitsbereich, in dem Sie Ihre Bilder zum Trainieren des Modells hinzufügen können.

    ![Watson VR - Modellklassentraining](dab-watson-vr-model-class-train.png)

9. Fügen Sie die Bilder zu dem Modell hinzu, indem Sie sie mit der Maus in den Arbeitsbereich ziehen und dort ablegen. Sie können auch die Funktion "Durchsuchen" nutzen, um auf die Bilder zuzugreifen.

10. Nach dem Hinzufügen der Bilder können Sie auf **Modell testen** klicken, um für Tests zu Ihrem Arbeitsbereich zurückzukehren.

    ![Watson VR - Modellklassentests](dab-watson-vr-model-class-train-test.png)

11. Fügen Sie im Abschnitt **Modell ausprobieren** ein Bild hinzu. Das Ergebnis wird dann angezeigt.

