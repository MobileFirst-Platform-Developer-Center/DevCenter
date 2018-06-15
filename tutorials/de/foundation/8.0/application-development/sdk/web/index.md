---
layout: tutorial
title: MobileFirst-Foundation-SDK zu Webanwendungen hinzufügen
breadcrumb_title: Web
relevantTo: [javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können mobile {{ site.data.keys.product_adj }}-Webanwendungen oder Desktopwebanwendungen in Ihrer bevorzugten Entwicklungsumgebung und mit Ihren bevorzugten Tools entwickeln.   
In diesem Lernprogramm erfahren Sie, wie das {{ site.data.keys.product_adj }}-Web-SDK zu einer Webanwendung hinzugefügt und die Webanwendung bei {{ site.data.keys.mf_server }} registriert wird. 

Das {{ site.data.keys.product_adj }}-Web-SDK wird in Form von JavaScript-Dateien bereitgestellt und ist [über NPM verfügbar](https://www.npmjs.com/package/ibm-mfp-web-sdk).  
Das SDK enthält die folgenden Dateien: 

- **ibmmfpf.js** - Kern des SDK
- **ibmmfpfanalytics.js** - Unterstützung für {{ site.data.keys.mf_analytics }}

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }
- [Voraussetzungen](#prerequisites)
- [{{ site.data.keys.product_adj }}-Web-SDK hinzufügen](#adding-the-mobilefirst-web-sdk)
- [{{ site.data.keys.product_adj }}-Web-SDK initialisieren](#initializing-the-mobilefirst-web-sdk)
- [Webanwendung registrieren](#registering-the-web-application)
- [{{ site.data.keys.product_adj }}-Web-SDK aktualisieren](#updating-the-mobilefirst-web-sdk)
- [Same-Origin-Policy](#same-origin-policy)
- [Secure-Origins-Policy](#secure-origins-policy)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

## Voraussetzungen
{: #prerequisites }
-   Informieren Sie sich über die vorausgesetzten [unterstützten Web-Browser](../../../installation-configuration/development/web/#web-app-supported-browsers) zum Einrichten der Webentwicklungsumgebung.

-   Für die Ausführung von NPM-Befehlen müssen Sie [Node.js](https://nodejs.org) installieren.

## {{ site.data.keys.product_adj }}-Web-SDK hinzufügen
{: #adding-the-mobilefirst-web-sdk }
Wenn Sie das SDK zu Webanwendungen hinzufügen möchten, müssen Sie es zunächst auf Ihre Workstation herunterladen. 

### SDK herunterladen
{: #downloading-the-sdk }
1. Navigieren Sie in einem **Befehlszeilenfenster** zum Stammverzeichnis Ihrer Webanwendung.
2. Führen Sie den Befehl `npm install ibm-mfp-web-sdk` aus.

Dieser Befehl erstellt die folgende Verzeichnisstruktur:

![SDK-Ordnerinhalt](sdk-folder.png)

### SDK hinzufügen
{: #adding-the-sdk }
Sie müssen das Web-SDK der {{ site.data.keys.product }} mit Standardverfahren in der Webanwendung referenzieren, um es zur Anwendung hinzuzufügen.   
Das SDK [unterstützt auch AMD](https://en.wikipedia.org/wiki/Asynchronous_module_definition), sodass Sie das SDK mit Modulladeprogrammen wie [RequireJS](http://requirejs.org/) laden können. 

#### Standard
Referenzieren Sie die Datei **ibmmfpf.js** im Element `HEAD`.   

```html
<head>
    ...
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

#### RequireJS

**HTML**  

```html
<script type="text/javascript" src="node_modules/requirejs/require.js" data-main="index"></script>
```

**JavaScript**

```javascript
require.config({
	'paths': {
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['mfp'], function(WL) {
    // Anwendungslogik
});
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:** Wenn Sie Analytics-Unterstützung hinzufügen  möchten, platzieren Sie die Verweise auf die Datei **ibmmfpfanalytics.js** **vor** dem Verweis auf die Datei **ibmmfpf.js**.



## {{ site.data.keys.product_adj }}-Web-SDK initialisieren
{: #initializing-the-mobilefirst-web-sdk }
Initialisieren Sie das Web-SDK der {{ site.data.keys.product }}, indem Sie in der Haupt-JavaScript-Datei Ihrer Webanwendung das **Kontextstammverzeichnis** und die **Anwendungs-ID** angeben: 

```javascript
var wlInitOptions = {
mfpContextRoot : '/mfp', // "mfp" ist das Standardkontextstammverzeichnis der {{ site.data.keys.product }}
    applicationId : 'com.sample.mywebapp' // Durch eigenen Wert ersetzen
};

WL.Client.init(wlInitOptions).then (
    function() {
        // Anwendungslogik
});
```

- **mfpContextRoot:** Von {{ site.data.keys.mf_server }} verwendetes KKontextstammverzeichnis
- **applicationId:** Name des Anwendungspakets, der beim [Registrieren der Anwendung](#registering-the-web-application) definiert wurde

### Webanwendung registrieren
{: #registering-the-web-application }
Sie können Anwendungen über die {{ site.data.keys.mf_console }} oder die {{ site.data.keys.mf_cli }} registrieren.

#### {{ site.data.keys.mf_console }}
{: #from-mobilefirst-operations-console }
1. Öffnen Sie Ihren bevorzugten Browser und laden Sie die {{ site.data.keys.mf_console }}. Geben Sie dazu die URL `http://localhost:9080/mfpconsole/` ein.
2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu erstellen.
3. Wählen Sie **Web** als Plattform aus und geben Sie einen Namen und eine ID an.
4. Klicken Sie auf **Anwendung registrieren**.

![Webplattform hinzufügen](add-web-platform.png)

#### {{ site.data.keys.mf_cli }}
{: #from-mobilefirst-cli }
Navigieren Sie in eiem **Befehlszeilenfenster** zum Stammverzeichnis der Webanwendung und führen Sie den Befehl `mfpdev app register` aus.

## {{ site.data.keys.product_adj }}-Web-SDK aktualisieren
{: #updating-the-mobilefirst-web-sdk }
SDK-Releases sind im [NPM-Repository](https://www.npmjs.com/package/ibm-mfp-web-sdk) für das jeweilige SDK enthalten.  
Gehen Sie wie folgt vor, um das {{ site.data.keys.product_adj }}-Web-SDK auf den neuesten Releasestand zu bringen: 

1. Navigieren Sie zum Stammordner der Webanwendung.
2. Führen Sie den Befehl `npm update ibm-mfp-web-sdk` aus.

## Same-Origin-Policy
{: #same-origin-policy }
Wenn Webressourcen von einer Servermaschine bereitgestellt werden, auf der {{ site.data.keys.mf_server }} nicht installiert ist, wird ein Verstoß gegen die [Same-Origin-Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) ausgelöst. Das SOP-Sicherheitsmodell (Same-Origin-Policy) ist für den Schutz vor Sicherheitsbedrohungen durch nicht verifizierte Quellen konzipiert. Gemäß diesem Modell erlaubt ein Browser Webressourcen (wie Scripts) nur mit Ressourcen zu interagieren, die denselben Ursprung haben (der als eine Kombination aus URI-Schema, Hostname und Portnummer definiert ist). Weitere Informationen zu SOP (Same-Origin-Policy) finden Sie in der Spezifikation [The Web Origin Concept](https://tools.ietf.org/html/rfc6454) unter [3. Principles of the Same-Origin Policy](https://tools.ietf.org/html/rfc6454#section-3).

Web-Apps, die das {{ site.data.keys.product_adj }}-Web-SDK verwenden, müssen in einer unterstützenden Topologie ausgeführt werden. Nutzen Sie beispielsweise einen Reverse Proxy, der Anforderungen indirekt und unter Wahrung des einheitlichen Ursprungs zum vorgesehenen Server weiterleitet. 

### Alternativen
{: #alternatives }
Sie können eine der folgenden Methoden anwenden, um den Richtlinienanforderungen zu genügen: 

- Stellen Sie die Webanwendungsressourcen mit einem Anwendungsserver (WebSphere Application Server Liberty Profile) bereit, der im {{ site.data.keys.mf_dev_kit_full }} verwendet wird.
- Verwenden Sie Node.js als Reverse Proxy, um Anwendungsanforderungen an {{ site.data.keys.mf_server }} weiterzuleiten.

> Weitere Informationen enthält das Lernprogramm [Webentwicklungsumgebung einrichten](../../../installation-configuration/development/web). 

## Secure-Origins-Policy
{: #secure-origins-policy }
Wenn Sie während der Entwicklung Chrome und sowohl HTTP als auch einen Host verwenden, der **nicht** `localhost` ist, erlaubt der Browser möglicherweise nicht das Laden einer Anwendung. Der Grund dafür ist die in diesem Browser implementierte und standardmäßig verwendete Secure-Origins-Policy. 

Sie können dies ändern, indem Sie den Chrome-Browser mit folgender Option starten: 

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- Die Option funktioniert, wenn Sie "test-to-new-user-profile/myprofile" durch die Position eines Ordners ersetzen, der als neues Chrome-Benutzerprofil verwendet werden kann.

Weitere Informationen zum sicheren Ursprung enthält [dieses Chormium-Dokument für Entwickler](https://www.chromium.org/Home/chromium-security/prefer-secure-origins-for-powerful-new-features).

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das {{ site.data.keys.product_adj }}-Web-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch.
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch.
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch.
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an.
