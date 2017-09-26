---
layout: tutorial
title: Übersetzung von JavaScript-Anwendungen (Cordova, Web) in mehrere Sprachen
breadcrumb_title: Übersetung in mehrere Sprachen
relevantTo: [javascript]
weight: 9
downloads:
  - name: Cordova-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/Translation/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können das Framework der {{ site.data.keys.product_full }} nutzen, um zu JavaScript-Anwendungen (Cordova, Web) Übersetzungen in mehrere Sprachen hinzuzufügen.   
Zu den Elementen, die übersetzt werden können, gehören Anwendungszeichenfolgen und Systemnachrichten.  

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Anwendungszeichenfolgen übersetzen](#translating-application-strings)
* [Systemnachrichten übersetzen](#translating-system-messages)
* [Übersetzung in mehrere Sprachen](#multilanguage-translation)
* [Ländereinstellung und Sprache eines Geräts erkennen](#detecting-the-device-locale-and-language)
* [Beispielanwendung](#sample-application)

## Anwendungszeichenfolgen übersetzen
{: #translating-application-strings }
Zeichenfolgen, die übersetzt werden sollen, werden in einem `JSON`-Objekt mit der Bezeichnung "Messages" gespeichert. 

- Bei Cordova-Anwendungen, die das {{ site.data.keys.product_adj }}-SDK verwenden, finden Sie das Objekt
in der Datei **index.js** der Cordova-Anwendung (**[Stammverzeichnis_des_Cordova-Projekts]/www/js/index.js**).
- Bei Webanwendungen müssen Sie das Objekt hinzufügen. 

### Beispiel für die JSON-Objektstruktur
{: #json-object-structure-example }

```javascript
var Messages = {
    headerText: "Default header",
    actionsLabel: "Default action label",
    sampleText: "Default sample text",
};
```

Es gibt zwei Möglichkeiten für die Anwendungslogik, die im `JSON`-Objekt "Messages" gespeicherten Zeichenfolgen zu referenzieren: 

**Als JavaScript-Objekteigenschaft:**

```javascript
Messages.headerText
```

**Als ID eines HTML-Elements mit `class="translate"`:**

```html
<h1 id="headerText" class="translate"></h1>
```

## Systemnachrichten übersetzen
{: #translating-system-messages }
Es ist möglich, von der Anwendung angezeigte Systemnachrichten zu übersetzen, z. B. die Naricht "Internet connection is not available" oder "Invalid username or password". Systemnachrichten werden im Objekt `WL.ClientMessages` gespeichert. 

**Hinweis:** Sie müssen Systemnachrichten auf einer globalen JavaScript-Ebene überschreiben,
weil Teile des Codes erst nach erfolgreicher Initialisierung der Anwendung ausgeführt werden. 

### Webanwendungen
{: #web-applications }
Eine vollständige Liste der Systemnachrichten ist in der Datei `messages.json` im Ordner **[Projektstammverzeichnis]\node_modules\ibm-mfp-web-sdk\lib\messages\** enthalten.

### Cordova-Anwendungen
{: #cordova-applications }
Eine vollständige Liste der Systemnachrichten ist in der Datei `messages.json` des generierten Projekts. 

- Android: `[Cordova-Projekt]\platforms\android\assets\www\plugins\cordova-plugin-mfp\worklight\messages`
- iOS, Windows: `[Cordova-Projekt]\platforms\[ios or windows]\www\plugins\cordova-plugin-mfp\worklight\messages`

Zum Übersetzen einer Systemnachricht müssen Sie sie im Anwendungscode überschreiben. 

```javascript
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
```

## Übersetzung in mehrere Sprachen
{: #multilanguage-translation }
Mit JavaScript können Sie für Ihre Anwendung eine Übersetzung in mehrere Sprachen implementieren.   
Nachfolgend ist die Implementierung der Beispielanwendung für dieses Lernprogramm erläutert. 

1. Definieren Sie die Standardanwendungszeichenfolgen in der Datei `index.js`. 

   ```javascript
   var Messages = {
        headerText: "Default header",
        actionsLabel: "Default action label",
        sampleText: "Default sample text",
        englishLanguage: "English",
        frenchLanguage: "French",
        russianLanguage: "Russian",
        hebrewLanguage: "Hebrew"
   };
   ```

2. Überschreiben Sie bei Bedarf bestimmte Zeichenfolgen. 

   ```javascript
   function setFrench(){
        Messages.headerText = "Traduction";
        Messages.actionsLabel = "Sélectionnez une langue:";
        Messages.sampleText = "Ceci est un exemple de texte en français.";
   }
   ```

3. Aktualisieren Sie die grafische Benutzerschnittstelle mit den neuen Zeichenfolgen. Sie können weitere Aufgaben ausführen. Beispielsweise können Sie für Sprachen wie Hebräisch oder Arabisch die Ausrichtung des Textes von rechts nach links festlegen. Immer, wenn ein Element aktualisiert wird, erfolgt die Aktualisierung mit Zeichenfolgen der derzeit aktiven Sprache.

   ```javascript
   function languageChanged(lang) {
        if (typeof(lang)!="string")
            lang = $("#languages").val();

        switch (lang) {
            case "english":
                setEnglish();
                break;
            case "french":
                setFrench();
                break;
            case "russian":
                setRussian();
                break;
            case "hebrew":
                setHebrew();
                break;
        }
               
        if ($("#languages").val()=="hebrew")
            $("#wrapper").css({direction: 'rtl'});
        else
            $("#wrapper").css({direction: 'ltr'});
      
        $("#sampleText").html(Messages.sampleText);
        $("#headerText").html(Messages.headerText);
        $("#actionsLabel").html(Messages.actionsLabel);
   }
   ```

## Ländereinstellung und Sprache eines Geräts erkennen
{: #detecting-the-device-locale-and-language }
Gehen Sie wie folgt vor, um die vom Gerät oder Browser verwendete Sprache zu erkennen: 

### Webanwendungen
{: #web-applications-locale}
Verwenden Sie `navigator.language` oder andere verfügbare Frameworks und Lösungen, um die Browsersprache zu erkennen. 

### Cordova-Anwendungen
{: #cordova-applications-locale }
Verwenden Sie das Cordova-Globalisierungs-Plug-in `cordova-plugin-globalization`, um die Ländereinstellung und die Sprache eines Geräts zu erkennen.  
Das Globalisierungs-Plug-in wird automatisch installiert, wenn eine Plattform zu einer Cordova-Anwendung hinzugefügt wird. 

Verwenden Sie die Funktionen `navigator.globalization.getLocaleName` und `navigator.globalization.getPreferredLanguage`,
um die Ländereinstellung bzw. die Sprache zu erkennen. 

```javascript
navigator.globalization.getLocaleName(
	function (localeValue) {
		WL.Logger.debug(">> Detected locale: " + localeValue);
		
        ...
        ...
        ...
	},
	function() {
		WL.Logger.debug(">> Unable to detect locale.");
	}
);

navigator.globalization.getPreferredLanguage(
	function (langValue) {
		lang = langValue.value;
		WL.Logger.debug(">> Detected language: " + lang);
	},
	function() {
		WL.Logger.debug(">> Unable to detect language.");
	}
);
```

Das Ergebnis sehen Sie im Geräteprotokoll, z. B. im LogCat von Android Studio:   
![Ländereinstellung und Sprache eines Geräts abrufen](DeviceLocaleLangugae.png)

## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/Translation), um das Cordova-Projekt herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Das LogCat
können Sie in der LogCat-Konsole von Android Studio untersuchen, während die Anwendung ausgeführt wird.
