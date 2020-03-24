---
layout: tutorial
title: Schablonen
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Schablonen verwenden
{: #dab-templates }

Mit Schablonen können Sie Ihre Anwendung rasch erstellen. Die Schablonen sind mit bestimmten Features versehen, die Sie bei der schnellen Modifikation und Entwicklung von Apps unterstützen. 

Standardmäßig wird der Digital App Builder mit den beiden Schablonen "Mod Resorts" und "Tabs" geliefert.

* **Mod Resorts**: Diese Schablone stellt eine Beispiel-App mit dem Anwendungsfall einer App für Urlaubsorte bereit. Sie enthält für den Anfang das Anmeldemodul, das Chatmodul und das Modul für App-internes Feedback. Sie müssen die Anmeldung später implementieren und Ihre eigenen Chatbotberechtigungsnachweise konfigurieren.
* **Tabs**: Diese Schablone stellt die Schnittstelle einer mobilen App mit Registerkarten am unteren Rand bereit. Zu dieser Schablone gehört auch das Anmeldemodul.

### Angepasste Schablone erstellen
{: #create-custom-template }

Die Standardschablonen werden an der folgenden Position gespeichert:
* Mac OS: `Users/<Systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<Systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Erstellen Sie eine angepasste Schablone, indem Sie eine der Standardschablonen duplizieren und bearbeiten, z. B. die Schablone "Mod Resorts".
Nehmen Sie in der kopierten Schablone die erforderlichen Änderungen vor und komprimieren Sie den Ordner.
Erstellen Sie für die von Ihnen erstellte angepasste Schablone einen Ordner unter `\ionic_templates\` und kopieren Sie die ZIP-Datei in den neuen Ordner.
Bearbeiten Sie die Datei templates.json im Ordner \ionic_templates\ und fügen Sie einen neuen Eintrag für Ihre Schablone hinzu.
Die neue angepasste Schablone kann beispielsweise wie folgt hinzugefügt werden: 

```json
{
    "version": 12,
    "templates": [
        {
            "name": "Mod Resorts",
            "icon": "modresorts/modresortslogo.png",
            "templateFile": "modresorts/modresorts.zip"
        },
        {
            "name": "Tabs",
            "icon": "tabs/tabs.png",
            "templateFile": "tabs/tabs.zip"
        }
       {
            "name": "MyCustomTemplate",
            "icon": "mytemplate/customtemplate.png",
            "templateFile": "mytemplate/customtemplate.zip"
        }
     ]
}
```
>**Hinweis**
>* Vergessen Sie nicht, die `Versionsnummer` zu erhöhen.
>* Wenn das Releaseteam eine Schablone hinzufügt, ersetzt das Update den Ordner `\ionic_templates\`. Stellen Sie daher sicher, dass Sie eine Sicherung des Ordners mit Ihrer angepassten Schablone erstellen, damit Sie diese nach Updates wiederherstellen können.
