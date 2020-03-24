---
layout: tutorial
title: Verbindung zu Mikroservices über den API-Proxy
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## API-Proxy
{: #dab-api-proxy }

Wenn Sie eine Verbindung zum Unternehmens-Back-End herstellen, können Sie den API-Proxy nutzen, um von den Sicherheits- und Analysefunktionen der MobileFirst Platform profitieren zu können. Wie der Name schon sagt, handelt es sich um einen Proxy, über den die Anforderungen zum tatsächlichen Back-End weitergeleitet werden. 

### Vorteile bei Verwendung des API-Proxys

* Der tatsächliche Back-End-Host wird für die mobile App nicht zugänglich gemacht und bleibt von MobileFirst Server geschützt.
* Sie können die an das Back-End gerichteten Anforderungen analysieren.

### Verwendung des API-Proxys

1. Laden Sie den Mobile-API-Proxy-Adapter über die Mobile Foundation Console herunter.

    ![API-Proxy](dab-api-proxy.png)

2. Implementieren Sie den API-Proxy-Adapter in Mobile Foundation Server.

3. Konfigurieren Sie die Back-End-URI im API-Proxy-Adapter. Die URI muss das Format `Protokoll:Host:Port/Kontext` haben. Beispiel: `http://secure-backend/basecontext/`.
4. Verwenden Sie für Anforderungen an das Back-End die `API WLResourceRequest`. Nutzen Sie dazu das Code-Snippet "API Call" aus dem Abschnitt **MOBILE CORE**. Ändern Sie das Optionsobjekt so, dass der Schlüssel `useAPIProxy` auf "true" gesetzt ist.

    Beispiel:
```
    var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
    );
    resourceRequest.send().then(
        function(response) {
            alert("Success: " + response.responseText);
        },
        function(response) {
            alert("Failure: " + JSON.stringify(response));
        }
    );
    ```
