---
layout: tutorial
title: Vertrauliche Clients
relevantTo: [android,ios,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mobile Anwendungen können die {{ site.data.keys.product_adj }}-Client-SDKs verwenden, um den Zugriff auf geschützte Ressourcen anzufordern.   
Andere Entitäten, die keine mobilen Anwendungen sind, können dies ebenfalls tun. Entitäten dieser Art werden als **vertrauliche Clients** betrachtet. 

Vertrauliche Clients sind Clients, die fähig sind, die Vertraulichkeit ihrer Authentifizierungsnachweise zu wahren. Der
{{ site.data.keys.product_adj }}-Autorisierungsserver kann vertraulichen Clients gemäß der OAuth-Spezifikation den Zugriff
auf geschützte Ressourcen gewähren. Mit diesem Feature können Sie nicht mobilen Clients (z. B. Anwendungen für Leistungstests) und
anderen Arten von Back-Ends, die eine geschützte Ressource anfordern müssen
oder eine der **REST-APIs** der {{ site.data.keys.product }} wie die REST-API für **Push-Benachrichtigungen** verwenden,
Zugriff auf Ihre Ressourcen gewähren.

Beginnen Sie mit der Registrierung
eines vertraulichen Clients bei {{ site.data.keys.mf_server }}.
Im Rahmen der Registrierung stellen Sie die Berechtigungsnachweisen des vertraulichen Clients bereit, die aus einer ID und einem geheimen Schlüssel bestehen. Außerdem legen Sie den zulässigen Bereich des Clients fest,
der bestimmt, für welche Bereiche dieser Client berechtigt werden kann. Wenn ein registrierter vertraulicher Client beim Autorisierungsserver ein Zugriffstoken anfordert, authentifiziert der
Server den Client anhand der registrierten Berechtigungsnachweise. Darüber hinaus verifiziert der Server, dass der angeforderte Bereich mit dem zulässigen Bereich für den Client
übereinstimmt. 

Registrierte vertrauliche Clients können ein Token abrufen, dass in allen Anforderungen an {{ site.data.keys.mf_server }} verwendet wird. Dieser Ablauf basiert
auf dem in der OAuth-Spezifikation
(unter [client credentials](https://tools.ietf.org/html/rfc6749#section-1.3.4)) definierten Ablauf für Clientberechtigungsnachweise. Ein Zugriffstoken
für einen vertraulichen Client ist eine Stunde gültig. Wenn Sie einen vertraulichen Client für eine Aufgabe verwenden, die länger als eine Stunde dauert,
erneuern Sie das Token jede Stunde, indem Sie eine neue Tokenanforderung senden. 

## Vertraulichen Client registrieren
{: #registering-the-confidential-client }
Klicken Sie in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} auf **Laufzeiteinstellungen** →
**Vertrauliche Clients**. Klicken Sie auf
**Neu**, um einen neuen Eintrag hinzuzufügen.   
Sie müssen folgende Informationen angeben: 

- **Anzeigename**: Ein optionaler Anzeigename, mit dem auf den vertraulichen Client verwiesen wird. Der Standardanzeigename ist der Wert des Parameters
ID. Beispiel: **Back-end Node server**.
- **ID**: Eine eindeutige Kennung für den vertraulichen Client (die als eine Art Benutzername betrachtet werden kann). Die ID darf nur ASCII-Zeichen enthalten. 
- **Geheimer Schlüssel**: Eine private Kennphrase zur Autorisierung des Zugriffs des vertraulichen Clients (die als ein API-Schlüssel angesehen werden kann). Der geheime Schlüssel darf nur ASCII-Zeichen enthalten. 
- **Zulässiger Bereich**: Einem vertraulichen Client, der eine solche Kombination aus ID und geheimem Schlüssel verwendet, wird automatisch
der hier definierte Bereich zugeordnet. Weitere Informationen zu Bereichen finden Sie unter [Bereiche](../#scopes).
    - Ein Element eines zulässigen Bereichs kann auch einen Stern (`*`) als besonderes Platzhalterzeichen enthalten, das eine beliebige Folge von null oder mehr Zeichen repräsentiert. Wenn das Bereichselement beispielsweise
`send*` ist, kann dem vertraulichen Client Zugriff auf Bereiche gewährt werden, die ein mit "send" beginnendes Bereichselement enthalten, z. B.
"sendMessage". Der Stern als Platzhalterzeichen kann an jeder Stelle des Namens eines Bereichselements und sogar mehrfach angegeben werden.  
    - Ein Parameter
allowed-scope, als dessen Wert nur ein Stern
(*) angegeben ist, zeigt an, dass für den vertraulichen Client ein Token für jeden Bereich ausgestellt werden kann. 

**Beispiele für Bereiche:**

- Für den [Schutz externer Ressourcen](../protecting-external-resources) wird der Bereich `authorization.introspect` verwendet.
- Wenn Sie eine [Push-Benachrichtigung über die REST-API senden](../../notifications/sending-notifications), werden die jeweils durch ein Leerzeichen getrennten Bereichselemente `messages.write` und `push.application.<Anwendungs-ID>` verwendet.
- Adapter können mit einem angepassten Bereichselement wie `accessRestricted` geschützt werden.
- Mit dem Bereich `*` wird alles abgedeckt und der Zugriff auf jeden angeforderten Bereich gewährt. 

<img class="gifplayer" alt="Vertraulichen Client konfigurieren" src="push-confidential-client.png"/>

## Vordefinierte vertrauliche Clients
{: #predefined-confidential-clients }
{{ site.data.keys.mf_server }} wird mit einigen vordefinierten vertraulichen Clients geliefert: 

### test
{: #test }
Der Client `test` ist nur im Entwicklungsmodus verfügbar und ermöglicht das einfache Testen von Ressourcen. 

- **ID**: `test`
- **Geheimer Schlüssel**: `test`
- **Zulässiger Bereich**: `*` (beliebiger Bereich)

### admin
{: #admin }
Der Client `admin` wird intern vom Verwaltungsservice der {{ site.data.keys.product }} verwendet. 

### push
{: #push }
Der Client `push` wird intern vom Push-Service der {{ site.data.keys.product }} verwendet. 

## Zugriffstoken anfordern
{: #obtaining-an-access-token }
Ein Token kann vom **Tokenendpunkt** des {{ site.data.keys.mf_server }} abgerufen werden.   

**Für Testzwecke** können Sie Postman verwenden, wie es unten beschrieben ist.   
Implementieren Sie Postman mit einer Technologie Ihrer Wahl in einer realen Situation in Ihre Back-End-Logik. 

1.  Setzen Sie eine **POST**-Anforderung an **http(s)://[IP-Adresse_oder_Hostname]: [Port]/[Laufzeit]/api/az/v1/token** ab.  
    Beispiel: `http://localhost:9080/mfp/api/az/v1/token`
    - In einer Entwicklungsumgebung verwendet {{ site.data.keys.mf_server }} eine bereits vorhandene `mfp`-Laufzeit.   
    - Ersetzen Sie den Laufzeitwert in einer Produktionsumgebung durch den Namen Ihrer Laufzeit. 

2.  Legen Sie für die Anforderung `application/x-www-form-urlencoded` als Inhaltstyp fest.  
3.  Definieren Sie die beiden folgenden Formularparameter: 
    - Setzen Sie `grant_type` auf den Wert `client_credentials`.
    - Setzen Sie `scope` auf den schützenden Bereich für Ihre Ressource. Wenn Ihrer Ressource kein schützender Bereich zugewiesen ist, lassen Sie diesen Parameter weg, damit der Standardbereich (`RegisteredClient`) verwendet wird. Weitere Informationen finden Sie unter [Bereiche](../../authentication-and-security/#scopes).

       ![Postman-Konfiguration](confidential-client-steps-1-3.png)

4.  Verwenden Sie zum Authentifizieren der Anforderung die [Basisauthentifizierung](https://en.wikipedia.org/wiki/Basic_access_authentication#Client_side). Verwenden Sie die
**ID** und den **geheimen Schlüssel** Ihres vertraulichen Clients.

    ![Postman-Konfiguration](confidential-client-step-4.png)

    Wenn Sie außerhalb von Postman den vertraulichen Client **test** verwenden,
setzen Sie den **HTTP-Header** auf `Authorization: Basic dGVzdDp0ZXN0` (`test:test`
in **base64**-Codierung).

Die Antwort auf diese Anforderung enthält ein `JSON`-Objekt mit dem
**Zugriffstoken** und dessen Ablaufzeit (von 1 Stunde). 

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImp ...",
  "token_type": "Bearer",
  "expires_in": 3599,
  "scope": "sendMessage accessRestricted"
}
```

![Vertraulichen Client erstellen](confidential-client-access-token.png)

## Verwendung des Zugriffstokens
{: #using-the-access-token }
Ab diesem Punkt können Sie die gwünschten Ressourcen anfordern, indem Sie
den **HTTP-Header** hinzufügen: `Authorization: Bearer eyJhbGciOiJSUzI1NiIsImp ...` hinzufügen
und das Zugriffstoken durch das aus dem vorgenannten JSON-Objekt extrahierte Token ersetzen. 

## Mögliche Antworten
{: #possible-responses }
Suchen Sie neben den normalen Antworten, die von Ihrer Ressource generiert werden können,
nach Antworten, die von {{ site.data.keys.mf_server }} generiert wurden.

### Bearer
{: #bearer }
Ein HTTP-Antwortstatus **401** mit dem HTTP-Header `WWW-Authenticate : Bearer` bedeutet,
dass im `Authorization`-Header der ursprünglichen Anforderung kein Token gefunden wurde. 

### invalid_token
{: #invalid-token }
Ein HTTP-Antwortstatus **401** mit dem HTTP-Header
`WWW-Authenticate: Bearer error="invalid_token"` bedeutet, dass das gesendete Token
**ungültig** oder **abgelaufen** ist.

### insufficient_scope
{: #insufficient-scope }
Ein HTTP-Antwortstatus **403** mit dem HTTP-Header `WWW-Authenticate : Bearer error="insufficient_scope", scope="RegisteredClient scopeA scopeB"` bedeutet, dass das in der ursprünglichen Anforderung gefundene Token nicht zu dem von dieser Ressource geforderten Bereich passt. Der Header enthält außerdem den erwarteten Bereich. 

Wenn Sie eine Anforderung absetzen und nicht wssen, welchen Bereich die Ressource fordert, können Sie mit `insufficient_scope` den erforderlichen Bereich bestimmen. Fordern Sie beispielsweise ein Token ohne Angabe eines Bereichs an, wenn Sie die Ressourcenanforderung absetzen. Anschließend extrahieren Sie den erforderlichen Bereich
aus der Antwort 403 und fordern ein neues Token für diesen Bereich an. 

