---
layout: tutorial
title: Authentifizierungs- und Sicherheitskonzepte umstellen
breadcrumb_title: Authentifizierungskonzepte umstellen
downloads:
  - name: Migrationsbeispiel herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/MigrationSample
weight: 3
---
## Übersicht
{: #overview }

Das {{ site.data.keys.product_full }}-Sicherheitsframework
wurde in Version 8.0 erheblich modifiziert, um die Aufgaben der Sicherheitsentwicklung und -verwaltung zu verbessern und zu vereinfachen. Zu diesen Modifikationen gehört die Ersetzung
von Sicherheitsbausteinen aus Version 7.1. OAuth-Sicherheitsbereiche und -überprüfungen in Version 8.0 ersetzen die Sicherheitstests, Realms und Anmeldemodule früherer Versionen. 

Dieses Lernprogramm führt Sie durch die erforderlichen Schritte für die Umstellung des Sicherheitscodes Ihrer Anwendung auf Version 8.0. Im Lernprogramm ist der vollständige Prozess für die Transformation einer
Beispielanwendung aus {{ site.data.keys.product_adj }} Version 7.1 in eine Anwendung der Version 8.0 mit dem gleichen Sicherheitsschutz beschrieben. Sowohl die Beispielanwendung
aus Version 7.1 als auch die umgestelte Anwendung der Version 8.0 ist über den Link **Migrationsbeispiel
herunterladen** am Anfang dieses Lernprogramms zum Download verfügbar. 

Im [ersten Teil](#migrating-the-sample-application) des Lernprogramms ist erläutert,
wie die Beispielanwendung aus Version 7.1 auf Version 8.0 umgestellt wird. Im Rahmen dieser Umstellung werden der Ressourcenadapter
umgestellt, die formular- und adapterbasierten Authentifizierungsrealms durch Sicherheitsüberprüfungen ersetzt,
und die Clientanwendung mit allen ihren Abfrage-Handlern umgestellt. <br />
Im [zweiten Teil](#migrating-other-types-of-authentication-realms) wird erklärt, wie
andere Arten von Authentifizierungsrealms aus Version 7.1, die in der Beispielanwendung nicht angewendet werden, auf
Version 8.0 umgestellt werden. <br />
Im [dritten Teil](#migrating-other-v71-security-configurations) wird erklärt, wie
weitere Sicherheitskonfigurationen von Version 7.1 auf
Version 8.0 umgestellt werden. Dazu gehören die Konfiguration des Schutzes auf Anwendungsebene, der Ablauf von Zugriffstoken sowie Benutzer- und Geräte-IDs.
{% comment %} I edited and reordered, including splitting part two into two and three - which matches the header levels in the original doc. I moved the links (which I also edited) to each second-level header ("part").
{% endcomment %}

> **Hinweis:** Bevor Sie mit der Migration beginnen, sollten Sie das
[Migrations-Cookbook für Version 8.0](../migration-cookbook) durcharbeiten.   
> Weitere Informationen zu den Basiskonzepten des neuen Sicherheitsframeworks finden Sie unter [Authentifizierung
und Sicherheit](../../authentication-and-security).

## Beispielanwendung umstellen
{: #migrating-the-sample-application }

Den Ausgangspunkt für diese Migrationsprozedur bildet eine Beispielhybridanwendung aus Version 7.1. Die Anwendung greift auf einen mit dem OAuth-Sicherheitsmodell von Version 7.1
geschützten Java-Adapter zu. Dieser Adapter verwendet die beiden folgenden Methoden: 
*  `getBalance`: Methode, die mit einem formularbasierten Authentifizierungsrealm geschützt wird, das eine Anmeldung mit Benutzernamen und Kennwort implementiert
*  `transferMoney`: Methode, die mit einem adapberbasierten Authentifizierungsrealm geschützt wird, das eine Benutzerautorisierung mit PIN-Code implementiert

Verwenden Sie den Link **Migrationsbeispiel herunterladen** am Anfang dieses Lernprogramms, um den Quellcode der Beispielanwendung
aus Version 7.1 und die umgestellte, funktional entsprechende Anwendung der Version 8.0 herunterzuladen. 

Führen Sie die folgenden Schritte aus, um die Beispielanwendung aus Version 7.1 auf Version 8.0 umzustellen: 
*  [Migrieren Sie den Ressourcenadapter](#migrating-the-resource-adapter), einschließlich der Ressourcenschutzlogik. 
*  [Migrieren Sie die Clientanwendung](#migrating-the-client-application).
*  [Migrieren Sie die Authentifizierungsrealms](#migrating-rm-and-adapter-based-auth-realms) der Beispielanwendung aus Version 7.1,
indem Sie sich durch Sicherheitsüberprüfungen der Version 8.0 ersetzen. 
*  [Migrieren Sie die Abfrage-Handler](#migrating-the-challenge-handlers) auf der Clientseite, damit diese die neue Abfrage-Handler-API verwenden. 

### Ressourcenadapter umstellen
{: #migrating-the-resource-adapter }
Beginnen Sie mit der Migration des Ressourcenadapters. In {{ site.data.keys.product }} Version 8.0 werden Adapter als separate Maven-Projekte entwickelt.
In Version 7.1 waren Adapter dagegen Teil des Anwendungsprojekts. Der Ressourcenadapter kann daher unabhängig von der Clientanwendung migriert werden. Ebenso kann der
migrierte Adapter unabhängig von der Clientanwendung erstellt und implementiert werden.
Gleiches gilt für die Clientanwendung von Version 8.0
und die Sicherheitsüberprüfungen von Version 8.0 (die innerhalb von Adaptern implementiert werden). Sie können diese Artefakte daher in einer von Ihnen gewählten Reihenfolge migrieren. Das Lernprogramm beginnt mit Anweisungen für die Migration des Ressourcenadapters. Im Rahmen dieser Anweisungen gibt es eine Einführung in die Bereichselemente der OAuth-Sicherheit, die
in Version 8.0 für den Ressourcenschutz verwendet werden. 

> **Hinweis:** 
> *  Die folgenden Anweisungen gelten für die Migration des Beispielressourcenadapters `AccountAdapter`. Den Beispieladapter `PinCodeAdapter` müssen Sie nicht migrieren, weil die mit diesem Adapter implementierte adapterbasierte Authentifizierung in Version 8.0 nicht mehr unterstützt wird. Im Schritt
[Adapterbasiertes Authentifizierungsrealm mit PIN-Code ersetzen](#replacing-the-pin-code-adapter-based-authentication-realm) ist erläutert, wie
der PIN-Code-Adapter aus Version 7.1 durch eine Sicherheitsüberprüfung der Version 8.0 mit vergleichbarem Schutz ersetzt wird.
> *  Anweisungen für die Umstellung von Adaptern auf Version 8.0 finden Sie im [Migrations-Cookbook für Version 8.0](../migration-cookbook).

Die Methoden von `AccountAdpter` im Beispiel aus Version 7.1 sind mit der Annotation
`@OAuthSecurity` geschützt. Diese Annotation definiert die schützenden Bereiche der Methoden
(`UserLoginRealm` und `PinCodeRealm`). Die gleiche Annotation wird in Version 8.0 verwendet. Allerdings haben die Bereichselemente in Version 8.0 eine andere Signifikanz. In Version 7.1 beziehen sich Bereichselemente auf die in der Datei
**authenticationConfig.xml** definierten Sicherheitsrealms. In Version 8.0 werden Bereichselemente Sicherheitsüberprüfungen zugeordnet, die
in einem in {{ site.data.keys.mf_server }} implementierten Adapter definiert sind. Wenn Sie möchten, können Sie den Ressourcenschutzcode mit den Namen der Bereichselemente ungeändert übernehmen. Da die Realmterminologie in {{ site.data.keys.product }} Version 8.0 nicht mehr verwendet wird,
wurden die Bereichselemente in der Anwendung der Version 8.0 in `UserLogin` und `PinCode` umbenannt:

```java
@OAuthSecurity(scope="UserLogin")
@OAuthSecurity(scope="PinCode")
```

#### Code zum Abrufen der Benutzeridentität aktualisieren
{: #updating-the-user-identity-retrieval-code }

Der Beispielressourcenadapter verwendet die serverseitige Sicherheits-API, um
die Identität des authentifizierten Benutzers abzurufen. Diese API wurde in Version 8.0 geändert. Sie müssen den Adapbercode daher modifizieren, damit er die aktualisierte API verwendet. Entfernen Sie aus der auf Version 8.0 umgestellten Anwendung den folgenden Code aus Version 7.1: 

```java
WLServerAPI api = WLServerAPIProvider.getWLServerAPI();
api.getSecurityAPI().getSecurityContext().getUserIdentity();
```

Ersetzen Sie den Code mit folgendem Code, der die neue API von Version 8.0 verwendet: 

```java
// Sicherheitskontext injizieren
@Context
AdapterSecurityContext securityContext;

 // Namen des authentifizierten Benutzers abrufen
String userName = securityContext.getAuthenticatedUser().getDisplayName();
```
Wenn Sie den Adaptercode bearbeitet haben, können Sie den Adapter erstellen und mit Maven oder der {{ site.data.keys.mf_cli }} im Server implementieren. Weitere Informationen finden Sie unter [Adapter erstellen und implementieren](../../adapters/creating-adapters/#build-and-deploy-adapters).
### Clientanwendung umstellen
{: #migrating-the-client-application }

Stellen Sie als Nächstes die Clientanwendung um. Ausführliche Anweisungen für die Umstellung
der Clientanwendung finden Sie im [Migrations-Cookbook für Version 8.0](../migration-cookbook). In diesem Lernprogramm geht es schwerpunktmäßig um die Migration des Sicherheitscodes. Schließen Sie an dieser Stelle den Abfrage-Handler-Code aus. Bearbeiten Sie dazu die HTML-Hauptdatei der Anwendung (**index.html**).
Schließen Sie die Zeilen für den Import des Abfrage-Handler-Codes in Kommentarzeichen ein: 

```html 
<!--  
    <script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
 -->
```

Der Abfrage-Handler-Code der Beispielanwendung wird später, im Schritt
[Abfrage-Handler umstellen](#migrating-the-challenge-handlers), modifiziert. 

#### Clientseitige API-Aufrufe aktualisieren
{: #updating-the-client-side-api-calls }

Als Teil der Clientmigration müssen Sie eine Anpassung an die Änderungen der clientseitigen API in Version 8.0 vornehmen. Eine Liste der Änderungen der
Client-API in {{ site.data.keys.product }} Version 8.0
finden Sie unter
[Upgrade für WebView](../migrating-client-applications/cordova/#upgrading-the-webview). Die Beispielanwendung ist von einer Client-API-Änderung im Bereich der Sicherheit betroffen, nämlich einer Änderung der Abmelde-API. Die Methode `WL.Client.logout` aus Version 7.1 wird in
Version 8.0 nicht unterstützt. Verwenden Sie stattdessen
die Methode `WLAuthorizationManager.logout` von Version 8.0 und übergeben Sie an diese Methode den Namen der Sicherheitsüberprüfung, die
das Autorisierungsrealm aus Version 7.1 ersetzt.
Mit der Abmeldeschaltfläche (**Logout**) in der Beispielanwendung meldet sich der Benutzer
bei den beiden Sicherheitsüberprüfungen `UserLogin` und `PinCode` ab: 

```javascript
function logout() {
    WLAuthorizationManager.logout('UserLogin').then(
        function () {
            WLAuthorizationManager.logout('PinCode').then(function () {
                $("#ResponseDiv").html("Logged out");
            }, function (error) {
                WL.Logger.debug("failure on logout from PinCode check: " +
                    JSON.stringify(error));
            });
      },
      function (error) {
          WL.Logger.debug("failure on logout from UserLogin check: " +
              JSON.stringify(error));
      });
}
```

Wenn Sie die Migrationsschritte für die Clientanwendung ausgeführt haben, müssen Sie die Anwendung erstellen und
mit dem Befehl `mfpdev app register` bei Ihrem {{ site.data.keys.mf_server }} registrieren. Nach erfolgreicher Registrierung Ihrer Anwendung sehen Sie sie
in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen**. 

### Authentifizierungsrealms der Beispielanwendung umstellen
{: #migrating-rm-and-adapter-based-auth-realms }

Inzwischen liegen eine auf Version 8.0 umgestellte Clientanwendung und ein implementierter Ressourcenadapter vor. Ihre umgestellte Anwendung kann jedoch nicht auf die geschützten Adapterressourcen zugreifen. Das liegt daran, dass die Methoden des Ressourcenadapters
mit den Bereichselementen `UserLogin` und `PinCode` geschützt werden und diese Bereichselemente
noch keinen Sicherheitsüberprüfungen zugeordnet wurden. Die Anwendung kann daher nicht das erforderliche Zugriffstoken für den Zugriff auf die geschützten Methoden anfrodern. Lösen Sie dieses Problem, indem Sie die Authentifizierungsrealms von Version 7.1 durch Sicherheitsüberprüfungen von Version 8.0 ersetzen, die den schützenden Bereichselementen der Adaptermethode zugeordnet werden. 

#### Formularbasiertes Authentifizierungsrealm für Benutzeranmeldung ersetzen
{: #replacing-the-user-login-form-based-authentication-realm }

Für die Ersetzung des formularbasierten Authentifizierungsrealms `UserLoginRealm` von Version 7.1
müssen Sie eine Sicherheitsüberprüfung `UserLogin` der Version 8.0 erstellen,
die die gleichen Authentifizierungsschritte wie der formularbasierte Authentifikator von Version 7.1 und das angepasste Anmeldemodul ausführt.
Die Sicherheitsüberprüfung muss eine Abfrage an den Client senden,
die Anmeldeberechtigungsnachweise aus der Antwort auf die Abfrage
erfassen, diese Berechtigungsnachweise validieren und eine Benutzeridentität erstellen. Wie Sie aus dem folgenden Anweisungen ersehen können, ist die Erstellung einer Sicherheitsüberprüfung nicht kompliziert. Nach Erstellung der Sicherheitsüberprüfung können Sie den Code für die Validierung
der Anmeldeberechtigungsnachweise des angepassten Anmeldemoduls von Version 7.1 in die neue Sicherheitsüberprüfung kopieren. 

In Version 8.0 werden Sicherheitsüberprüfungen in Form von Adaptern implementiert. In {{ site.data.keys.product }} Version 8.0
kann ein Java-Adapter Ressourcen bereitstellen und auch Pakete mit Sicherheitstests enthalten. In der hier beschriebenen Migrationsprozedur werden Sie jedoch
den migrierten Ressourcenadapter `AccountAdpter` übernehmen. Für Ihr neues Sicherheitsüberprüfungspaket können Sie einen gesonderten Adapter
erstellen. Beginnen Sie mit der Erstellung eines neuen Java-Adapters mit dem Namen `UserLogin`. Ausführliche Anweisungen finden Sie unter
[Neuen Java-Adapter erstellen](../../adapters/creating-adapters). 

Definieren Sie in Ihrem neuen Adapter `UserLogin` eine Sicherheitsüberprüfung `UserLogin`.
Fügen Sie dafür zur Datei **adapter.xml** des Adapters ein XML-Element
&lt;securityCheckDefinition&gt; hinzu. Sehen Sie sich dazu den folgenden Code an: 

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
     <property name="successStateExpirationSec" defaultValue="3600"/>
</securityCheckDefinition>
```

* Das Attribut `name` gibt den Namen der Sicherheitsüberprüfung ("UserLogin") an. 
* Das Attribut `class` gibt die Implementierung der Java-Klasse für die Sicherheitsüberprüfung ("com.sample.UserLogin") an. Diese Klasse wird im
[nächsten Schritt](#creating-the-user-login-security-check-java-class) erstellt. 
* Die Eigenschaft `successStateExpirationSec` ist äquivalent zur Eigenschaft `expirationInSeconds`
der Anmeldemodule von Version 7.1. Sie gibt den Ablaufzeitraum für den Erfolgszustand der Sicherheitsüberprüfung an (d. h. das Intervall in Sekunden, während dessen eine erfolgreiche Sicherheitsprüfungsanmeldung gültig bleibt). Der Standardwert für diese Eigenschaft von Version 7.1 und Version 8.0 liegt bei 3600 Sekunden. Wenn Sie in Ihrem Anmeldemodul der Version 7.1 einen anderen Ablaufzeitraum konfiguriert haben, bearbeiten Sie in Version 8.0 die
Eigenschaft `successStateExpirationSec`. Setzen Sie sie auf den von Ihnen konfigurierten Wert. 

In diesem Lernprogramm ist nur erläutert, wie die Eigenschaft `successStateExpirationSec` definiert wird. Sicherheitsüberprüfungen bieten Ihnen jedoch viele weitere Möglichkeiten. Sie können beispielsweise erweiterte Features implementieren, z. B. für den Ablauf des Blockierungszustands, für mehrere Anmeldeversuche oder für erinnerte Anmeldungen ("Remenber me"). Sie können die Standardwerte von Konfigurationseigenschaften ändern, angepasste Eigenschaften hinzufügen und in der Laufzeit
Eigenschaftswerte in der {{ site.data.keys.mf_console }} oder über die {{ site.data.keys.mf_cli }} (**mfpdev**) modifizieren. Weitere Informationen finden Sie
in der [Dokumentation zu Sicherheitsüberprüfungen in Version 8.0](../../authentication-and-security/creating-a-security-check/)
und insbesondere im Abschnitt [Sicherheitsüberprüfungen konfigurieren](../../authentication-and-security/creating-a-security-check/#security-check-configuration).

##### Java-Klasse für Sicherheitsüberprüfungen für die Anmeldung erstellen
{: #creating-the-user-login-security-check-java-class }

Erstellen Sie in Ihrem Adapter `UserLogin` eine Java-Klasse `UserLogin`,
die die abstrakte {{ site.data.keys.product_adj }}-Klasse `UserAuthenticationSecurityCheck` erweitert
(die wiederum die abstrakte {{ site.data.keys.product_adj }}-Basisklasse  `CredentialsValidationSecurityCheck` erweitert). Übeschreiben Sie als Nächstes
die Standardimplementierung
der Basisklassenmethoden `createChallenge`, `validateCredentials` und `createUser`. 

*  Die Methode `createChallenge` erstellt das Abfrageobjekt (Hash-Map), das an den Client gesendet werden soll. Die Iplementierung dieser Methode kann so modifiziert werden, dass sie eine Abfragephrase oder eine andere Art von Abfrageobjekt für die Validierung der Antwort vom Client enthält. Für die hier verwendete Beispielanwendung müssen Sie jedoch nur die Fehlernachricht zum Abfrageobjekt hinzufügen, die im Falle eines Fehlers angezeigt werden soll.
*  Die Methode `validateCredentials` enthält die Authentifizierungslogik. Kopieren Sie den Authentifizierungscode, der den Benutzernamen und das Kennwort Ihres Anmeldemoduls aus Version 7.1 validiert, in die entsprechende Methode der Version 8.0. Im Beispiel ist eine Basisvalidierungslogik implementiert, die überprüft, ob Kennwort und Benutzername übereinstimmen. 
*  Die Methode `createUser` ist äquivalent zur Methode `createIdentity` des Anmeldemoduls von Version 7.1. 

Es folgt der vollständige Klassenimplementierungscode: 

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

    private String userId, displayName;
    private String errorMsg;

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        if (credentials!=null && credentials.containsKey("username") &&
		credentials.containsKey("password")){
            String username = credentials.get("username").toString();
            String password = credentials.get("password").toString();

            // Aus dem Anmeldemodul von Version 7.1 kopierte Authentifizierungslogik
            if (!username.isEmpty() && !password.isEmpty() && username.equals(password)) {
                userId = username;
                displayName = username;

                errorMsg = null;
                return true;
            } else {
                errorMsg = "Wrong Credentials";
            }
        } else {
            errorMsg = "Credentials not set properly";
        }
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
        challenge.put("errorMsg", errorMsg);
        return challenge;
    }

    @Override
    protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
    }
}
```

Weitere Informationen zur Klasse `UserAuthenticationSecurityCheck` und ihrer Implementierung
finden Sie unter [Klasse UserAuthenticationSecurityCheck implementieren](../../authentication-and-security/user-authentication/security-check/).


Schließen Sie Ihre Änderungen ab, indem Sie den Adapter `UserLogin` erstellen und
mit Maven oder der {{ site.data.keys.mf_cli }} im Server implementieren. Weitere Informationen finden Sie unter [Adapter erstellen und implementieren](../../adapters/creating-adapters/#build-and-deploy-adapters).
Nach erfolgreicher Implementierung des Adapters sehen Sie ihn
in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} im Abschnitt **Adapter**. 

#### Adapterbasiertes Authentifizierungsrealm mit PIN-Code ersetzen
{: #replacing-the-pin-code-adapter-based-authentication-realm }

Das Realm `PinCodeRealm` der Beispielanwendung von Version 7.1 ist mit adapterbasierter Authentifizierung implementiert, die in Version 8.0 nicht mehr unterstützt wird. Erstellen Sie als Ersatz für dieses Realm einen neuen Java-Adapter `PinCode` und fügen Sie ihn
zu einer Java-Klasse `PinCode` hinzu, die
die abstrakte {{ site.data.keys.product_adj }}-Basisklasse `CredentialsValidationSecurityCheck` erweitert. 

**Hinweis:**
*  Die Schritte für die Erstellung des Adapters `PinCode` sind mit den Schritten für die Erstellung des Adapters
`UserLogin` im Abschnitt
[Formularbasiertes Authentifizierungsrealm für Benutzeranmeldung ersetzen](#replacing-the-user-login-form-based-authentication-realm) vergleichbar. 
*  Die Sicherheitsüberprüfung `PinCode` muss nur die Anmeldeberechtigungsnachweise (d. h. den PIN-Code) validieren, aber keine Benutzeridentität zuweisen. Diese Sicherheitsprüfungsklasse erweitert daher die
Basisklasse `CredentialsValidationSecurityCheck` und nicht die Klasse `UserAuthenticationSecurityCheck`,
die für die Sicherheitsüberprüfung `UserLogin` verwendet wird. 

Wenn Sie eine Sicherheitsüberprüfung erstellen wollen, die die Basisklasse
`CredentialsValidationSecurityCheck` erweitert, müssen Sie die Methoden
`createChallenge` und `validateCredentials` implementieren. 

*  Die Implementierung von `createChallenge` ist mit der Implementierung der Sicherheitsüberprüfung `UserLogin` vergleichbar. Die Sicherheitsüberprüfung `PinCode` enthält keine konkreten Informationen, die im Rahmen der Abfrage an den Client gesendet werden sollen. Sie müssen hier daher nur die Fehlernachricht zum Abfrageobjekt hinzufügen, die im Falle eines Fehlers angezeigt werden soll.

   ```java
       @Override
       protected Map<String, Object> createChallenge() {
           Map challenge = new HashMap();
           challenge.put("errorMsg",errorMsg);
           return challenge;
       }
   ```

*  Die Methode `validateCredentials` validiert den PIN-Code. Im folgenden Beispiel besteht der Validierungscode aus einer Zeile. Sie können aber auch den Validierungscode des Authentifizierungsadapters von Version 7.1 in diese Methode `validateCredentials` kopieren.

   ```java
   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
       if (credentials!=null && credentials.containsKey("pin")){
           String pinCode = credentials.get("pin").toString();
           if (pinCode.equals("1234")) {
               return true;
           } else {
               errorMsg = "Pin code is not valid.";
           }
       } else {
           errorMsg = "Pin code was not provided";
       }
       return false;
   }
   ```

Wenn Sie die Umstellung der Authentifizierungsrealms von Version 7.1 auf Sicherheitsüberprüfungen abschließen,
erstellen Sie den Adapter und implementieren Sie ihn in {{ site.data.keys.mf_server }}. Weitere Informationen finden Sie unter [Adapter erstellen und implementieren](../../adapters/creating-adapters/#build-and-deploy-adapters).


### Abfrage-Handler umstellen
{: #migrating-the-challenge-handlers }

Jetzt sind bereits der Beispielressourcenadapter und die Beispielclientanwendung migriert. Außerdem wurden die Authentifizierungsrealms von Version 7.1 auf Sicherheitsüberprüfungen von Version 8.0 umgestellt. Für die Sicherheitsmigration der Beispielanwendung steht nur noch die Migration der Abfrage-Handler der Clientanwendung aus. Die Clientanwendung verwendet die Abfrage-Handler, um auf Sicherheitsabfragen zu antworten und um die vom Benutzer empfangenen Berechtigungsnachweise an die Sicherheitsüberprüfungen zu senden. 

Als Sie die [Clientanwendung umgestellt](#migrating-the-client-application) haben, wurde der Abfrage-Handler-Code
ausgeschlossen, indem die entsprechenden Zeilen in der HTML-Hauptdatei **index.html** auf Komentar gesetzt wurden. Jetzt fügen Sie den Abfrage-Handler-Code wieder hinzu, indem Sie die
zuvor hinzugefügten Kommentarzeichen entfernen: 

```html 
<script src="js/UserLoginChallengeHandler.js"></script>
    <script src="js/PinCodeChallengeHandler.js"></script>
```

Führen Sie dann die Umstellung des Abfrage-Handler-Codes auf Version 8.0 durch. Gehen Sie dazu gemäß den folgenden Anweisungen vor. Weitere Informationen zur
Abfrage-Handler-API von Version 8.0 finden Sie in der
[Kurzrezension zu Abfrage-Handlern in {{ site.data.keys.product }} 8.0]({{ site.baseurl }}/blog/2016/06/22/challenge-handlers/)
und in der Beschreibung von `WL.Client` und `WL.Client.AbstractChallengeHandler`
in den [Referenzinformationen zur clientseitigen JavaScript-API](../../api/client-side-api/javascript/client/) von Version 8.0.

Beginnen Sie mit dem Abfrage-Handler für die Benutzeranmeldung (`userLoginChallengeHandler`), der
in Version 8.0 die gleichen Funktionen wie in Version 7.1 ausführt.
Dieser Abfrage-Handler ist dafür zuständig, dem Benutzer beim Eingang einer Abfrage das Anmeldeformular anzuzeigen.
Zudem ist er für das Senden des Benutzernamens und des Kennworts
an {{ site.data.keys.mf_server }} verantwortlich. Da die Clientabfrage-Handler-API in Version 8.0 jedoch anders und einfacher als die entsprechende API in Version 7.1 ist,
müssen Sie die folgenden Änderungen vornehmen: 

*  Ersetzen Sie den Code für die Erstellung des Abfrage-Handlers durch den folgenden Code, der die Methode `WL.Client.createSecurityCheckChallengeHandler` von Version 8.0 aufruft:

   ```javascript
   var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');
   ```
   
   `WL.Client.createSecurityCheckChallengeHandler` erstellt einen Abfrage-Handler, der Abfragen einer {{ site.data.keys.product_adj }}-Sicherheitsüberprüfung bearbeitet. In Version 8.0 ist zudem eine Methode `WL.Client.createGatewayChallengeHandler` für die Behandlung von Abfragen von einem Gateway eines anderen Anbieters hinzugekommen, die in Version 8.0 entsprechend als Gateway-Abfrage-Handler bezeichnet wird. Wenn Sie die Anwendung aus Version 7.1 auf Version 8.0 umstellen, ersetzen Sie die Aufrufe der `WL.Client`-Methode `createWLChallengeHandler` oder `createChallengeHandler` durch Aufrufe der `WL.Client`-Methode für die Erstellung von Abfrage-Handlern der Version 8.0, die zur erwarteten Abfragequelle passen. Wenn Ihre Ressource beispielsweise von einem DataPower-Reverse-Proxy geschützt wird, der eine angepasste Anmeldung vom Client sendet, verwenden Sie `createGatewayChallengeHandler`, um einen Gateway-Abfrage-Handler für die Bearbeitung von Gateway-Abfragen zu erstellen.

*  Entfernen Sie den Aufruf der Abfrage-Handler-Methode `isCustomResponse`. Diese Methode wird in Version 8.0 nicht mehr für die Bearbeitung von Sicherheitsabfragen benötigt.
*  Ersetzen Sie die Implementierung der Methode `userLoginChallengeHandler.handleChallenge` durch die Implementierung der Abfrage-Handler-Methoden `handleChallenge`, `handleSuccess` und `handleFailure` von Version 8.0. In Version 7.1 gibt nur eine Abfrage-Handler-Methode, die die Antwort auf eine Abfrage überprüft oder einen Erfolg bzw. einen Fehler zurückgibt. In Version 8.0 gibt es für jede Art von Abfrage-Handler-Antwort eine gesonderte Methode. Das Sicherheitsframework stellt den Antworttyp fest und ruft die entsprechende Methode auf.
*  Entfernen Sie den Aufruf der Methode `submitSuccess`. In Version 8.0 handhabt das Sicherheitsframework implizit die Erfolgsantwort.
*  Ersetzen Sie den Aufruf der Methode `submitFailure` durch einen Aufruf der Abfrage-Handler-Methode `cancel` von Version 8.0.
*  Ersetzen Sie den Aufruf der Methode `submitLoginForm` durch einen Aufruf der Abfrage-Handler-Methode `submitChallengeAnswer` von Version 8.0:

   ```javascript
   userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password})
   ```
   
Es folgt der vollständige Code des Abfrage-handlers nach den oben beschriebenen Änderungen:
   
```javascript
function createUserLoginChallengeHandler() {
    var userLoginChallengeHandler = WL.Client.createSecurityCheckChallengeHandler('UserLogin');

    userLoginChallengeHandler.handleChallenge = function(challenge) {
        showLoginDiv();
        var statusMsg = (challenge.errorMsg !== null) ? challenge.errorMsg : "";
        $("#loginErrorMessage").html(statusMsg);
    };

    userLoginChallengeHandler.handleSuccess = function(data) {
        hideLoginDiv();
    };

    userLoginChallengeHandler.handleFailure = function(error) {
        if (error.failure !== null) {
            alert(error.failure);
        } else {
            alert("Failed to login.");
        }
    };

    $('#AuthSubmitButton').bind('click', function () {
        var username = $('#AuthUsername').val();
        var password = $('#AuthPassword').val();
        if (username === "" || password === "") {
            alert("Username and password are required");
            return;
        }

        userLoginChallengeHandler.submitChallengeAnswer(
            {'username':username, 'password':password});});

    $('#AuthCancelButton').bind('click', function () {
        userLoginChallengeHandler.cancel();
        hideLoginDiv();
    });

    return userLoginChallengeHandler;
 }
```

Die Migration des Abfrage-Handlers für den PIN-Code (`pinCodeChallengeHandler`) ist mit der Migration des Abfrage-Handlers für die Benutzeranmeldung vergleichbar. Folgen Sie daher den Migrationsanweisungen für `userLoginChallengeHandler` und
nehmen Sie die erforderlichen Anpassungen für den Abfrage-Handler für den PIN-Code vor. Sehen Sie sich dazu den vollständigen Code des umgestellten Abfrage-Handlers für den PIN-Code in der Beispielanwendung von Version 8.0 an. 

Sie haben die Beispieanwendung aus Version 7.0 auf Version 8.0 umgestellt. Erstellen Sie einen neuen Anwendungsbuild, implementieren Sie die Anwendung in
{{ site.data.keys.mf_server }}, testen Sie die Anwendung und überprüfen Sie, ob der Zugriff auf die Adaptermethodenressourcen
wie erwartet geschützt wird. 

## Andere Arten von Authentifizierungsrealms umstellen
{: #migrating-other-types-of-authentication-realms }

Sie haben bisher gelernt, wie formular- und adapterbasierte Realms aus der Beispielanwendung von Version 7.1 umgestellt werden. Ihre Anwendung von Version 7.1
könnte aber auch andere Arten von Authentifizierungsrealms enthalten, z. B. Realms, die Teil des Tests der Anwendungssicherheit sind (`mobileSecurityTest`,
`webSecurityTest` oder `customSecurityTest`). In den folgenden Abschnitten ist erläutert, wie diese zusätzlichen Arten von Authentifizierungsrealms auf Version 8.0 umgestellt werden. 

*  [Anwendungsauthentizität](#application-authenticity)
*  [LTPA-Realm](#ltpa-realm)
*  [Bereitstellung für Geräte](#device-provisioning)
*  [Anti-XSRF-Realm](#anti-cross-site-request-forgery-anti-xsrf-realm)
*  [Realm für direkte Aktualisierung](#direct-update-realm)
*  [Realm für Inaktivierung über Fernzugriff](#remote-disable-realm)
*  [Angepasste Authentifikatoren und Anmeldemodule](#custom-authenticators-and-login-modules)

### Anwendungsauthentizität
{: #application-authenticity }

In {{ site.data.keys.product }} Version 8.0 erfolgt die Validierung der Anwendungsauthentizität im Rahmen einer vordefinierten Sicherheitsüberprüfung
(`appAuthenticity`). Standardmäßig findet diese Überprüfung während der Registrierung der Anwendungslaufzeit bei
{{ site.data.keys.mf_server }} statt, d. h., wenn eine Instanz der Anwendung zum ersten Mal versucht, eine
Verbindung zum Server herzustellen. Sie können diese vordefinierte Überprüfung wie jede andere
{{ site.data.keys.product_adj }}-Sicherheitsüberprüfung in angepasste Sicherheitsbereiche
aufnehmen. Weitere Informationen finden Sie unter
[Anwendungsauthentizität](../../authentication-and-security/application-authenticity/).

### LTPA-Realm
{: #ltpa-realm }

Verwenden Sie zum Ersetzen des LTPA-Realms von Version 7.1 die vordefinierte LTPA-basierte Sicherheitsüberprüfung von {{ site.data.keys.product }} Version 8.0 (`LtpaBasedSSO`). Weitere Informationen zu dieser Sicherheitsüberprüfung finden Sie unter
[ LTPA-basierte Sicherheitsüberprüfung für Single Sign-on (SSO)](../../authentication-and-security/ltpa-security-check/).

### Bereitstellung für Geräte
{: #device-provisioning }

Das Realm für die Bereitstellung für Geräte aus Version 7.1 (`wl_deviceAutoProvisioningRealm`) muss nicht auf Version 8.0 umgestellt werden. Der Clientregistrierungsprozess von {{ site.data.keys.product }} Version 8.0
ersetzt die Bereitstellung für Geräte von Version 7.1. In Version 8.0 registriert sich ein Client (eine Anwendungsinstanz) selbst
bei {{ site.data.keys.mf_server }}, wenn er zum ersten Mal versucht, auf den Server zuzugreifen. Bei der Registrierung stellt der Client einen öffentlichen Schlüssel bereit, der für die Authentifizierung der Clientidentität
verwendet wird. Dieser Schutzmechanismus ist immer aktiviert. Sie müssen daher das Realm für die Bereitstellung für Geräte aus Version 7.1 nicht durch eine Sicherheitsüberprüfung ersetzen. 

### Anti-XSRF-Realm
{: #anti-cross-site-request-forgery-anti-xsrf-realm }

Das Anti-XSRF-Realm `wl_antiXSRFRealm` aus Version 7.1 muss nicht auf Version 8.0 umgestellt werden. In Version 7.1.0 wurde der Authentifizierungskontext in der HTTP-Sitzung gespeichert und über ein vom Browser in standortübergreifenden Anforderungen gesendetes Sitzungscookie identifiziert. In dieser Version wird das Anti-XSRF-Realm verwendet, um die Cookieübertragung gegen XSRF-Attacken durch das Senden eines zusätzlichen Headers vom Client an den Server zu schützen.
        Der Sicherheitskontext wird in {{ site.data.keys.product }} Version 8.0 nicht mehr mit einer HTTP-Sitzung verknüpft und nicht über ein Sitzungscookie identifiziert.
        Die Autorisierung erfolgt stattdessen mithilfe eines OAuth-2.0-Zugriffstokens, das an den Authorization-Header übergeben wird.
        Da der Authorization-Header in standortübergreifenden Anforderungen nicht vom Browser gesendet wird, muss er nicht vor XSRF-Attacken geschützt werden.

### Realm für direkte Aktualisierung
{: #direct-update-realm }

Das Realm für direkte Aktualisierung aus Version 7.1 (`wl_directUpdateRealm`) muss nicht auf Version 8.0 umgestellt werden. Die Implementierung des Features für direkte Aktualisierung in
{{ site.data.keys.product }} Version 8.0 erfordert im Gegensatz zum Realm in Version 7.1 keine zugehörige Sicherheitsüberprüfung.  

**Hinweis:** Die Schritte für die Bereitstellung von Aktualisierungen im Rahmen der direkten Aktualisierung von Version 8.0
unterscheiden sich von den Schritten in Version 7.1. Weitere Informationen finden Sie unter
[Direkte Aktualisierung umstellen](../migrating-client-applications/cordova/#migrating-direct-update).

### Realm für Inaktivierung über Fernzugriff
{: #remote-disable-realm }

Das Realm für die Inaktivierung über Fernzugriff aus Version 7.1 (`wl_remoteDisableRealm`) muss nicht auf Version 8.0 umgestellt werden. Die Implementierung des Features für Inaktivierung über Fernzugriff in
{{ site.data.keys.product }} Version 8.0 erfordert im Gegensatz zum Realm in Version 7.1 keine zugehörige Sicherheitsüberprüfung. Informationen zum Feature für die Inaktivierung über Fernzugriff in Version 8.0 finden Sie unter
[Anwendungszugriff
auf geschützte Ressourcen per Fernzugriff inaktivieren](../../administering-apps/using-console/#remotely-disabling-application-access-to-protected-resources).

### Angepasste Authentifikatoren und Anmeldemodule
{: #custom-authenticators-and-login-modules }

Erstellen Sie als Ersatz für angepasste Authentifikatoren und Anmeldemodule von Version 7.1 eine neue
Sicherheitsüberprüfung.
Entsprechende Anweisungen enthält der Schritt
[Java-Klasse für die Sicherheitsüberprüfung der Benutzeranmeldung erstellen](#creating-the-user-login-security-check-java-class)
der Migrationsprozedur für die Beispielanwendung. Ihre Sicherheitsüberprüfung kann die
Basisklasse `UserAuthenticationSecurityCheck`
oder `CredentialsValidationSecurityCheck` von {{ site.data.keys.product }} Version 8.0 erweitern. Sie können die Authentifikatorklasse oder Anmeldemodulklasse von Version 7.1 nicht direkt umstellen. Allerdings können Sie relevante Codeabschnitte in Ihre
Sicherheitsüberprüfung kopieren. Dazu gehört der Code zum Generieren der Sicherheitsabfrage, zum Extrahieren der Anmeldeberechtigungsnachweise aus der Antwort auf die Abfrage oder zum Validieren der Berechtigungsnachweise. 

## Andere Sicherheitskonfigurationen von Version 7.1 umstellen
{: #migrating-other-v71-security-configurations }

*  [Test der Anwendungssicherheit](#the-application-security-test)
*  [Ablauf von Zugriffstoken](#access-token-expiration)
*  [Benutzeridentitätsrealm](#user-identity-realm)
*  [Geräteidentitätsrealm](#device-identity-realm)

### Test der Anwendungssicherheit
{: #the-application-security-test }

In Version 7.1 kann der Anwendungsdeskriptor (**application-descriptor.xml**) zusätzlich zum Schutz für bestimmte Anwendungsressourcen
einen Anwendungssicherheitstest
definieren, der auf die gesamte Anwendungsumgebung angewendet wird. Der Standardsicherheitstest für mobile Anwendungen in Version 7.1 (`mobileSecurityTest`)
wird angewendet,
wenn der Anwendungsdeskriptor keinen explizit definierten Sicherheitstest enthält
(wie in der Beispielanwendung aus Version 7.1). Dieser Sicherheitstest besteht aus Realms, die in Version 8.0 keine Rolle spielen (Anti-XSRF) oder keine explizite Migration erfordern
(direkte Aktualisierung und Inaktivierung über Fernzugriff). Für den Schutz der Anwendungsumgebung der Beispielanwendung ist daher keine spezielle Migration erforderlich. 

Wenn es in Ihrer Anwendung aus Version 7.1 einen Anwendungssicherheitstest mit Überprüfungen (Realms) gibt,
die Sie nach der Umstellung auf Version 8.0 auf der Anwendungsebene beibehalten möchten,
können Sie einen obligatorischen Anwendungsbereich konfigurieren. In Version 8.0 erfordert der Zugriff auf eine geschützte Ressource
das Bestehen der dem obligatorischen Anwendungsbereich zugeordneten Sicherheitsüberprüfungen
sowie der Überprüfungen, die dem schützenden Bereich der Ressource zugeordnet sind. Wenn Sie einen obligatorischen Anwendungsbereich definieren wollen,
wählen Sie in Version 8.0 der **Navigationsseitenleiste** der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen** Ihre Anwendung und dann das Register
**Sicherheit** aus. Wählen Sie unter
**Obligatorischer Anwendungsbereich** die Option **Zum Bereich hinzufügen** aus.

Sie können in den Anwendungsbereich jede vordefinierte oder angepasste Sicherheitsüberprüfung oder auch zugeordnete Bereichselemente aufnehmen. Weitere Informationen zum Konfigurieren
eines obligatorischen Anwendungsbereichs in Version 8.0 finden Sie unter
[Obligatorischer Anwendungsbereich](../..//authentication-and-security/#mandatory-application-scope).

### Ablauf von Zugriffstoken
{: #access-token-expiration }

Der Standardwert für den maximalen Ablaufzeitraum von Zugriffstoken liegt in Version 7.1 und Version 8.0 bei 3600 Sekunden. Wenn Ihre Anwendung aus
Version 7.1 also auf diesen Standardwert zurückgreift, ist für die Anwendung des Wertes in Version 8.0 keine Umstellung erforderlich. Falls in Ihrer
Anwendungsdeskriptor aus Version 7.1 (**application-descriptor.xml**) jedoch ein anderer Wert für
die Eigenschaft `accessTokenExpiration` festgelegt ist, können Sie
eben diesen Wert für die äquivalente Eigenschaft in Version 8.0 (`maxTokenExpiration`) konfigurieren. Führen Sie diesen Schritt in der
{{ site.data.keys.mf_console }} aus. Wählen Sie dazu das Register **Sicherheit** für Ihre Anwendung aus
und bearbeiten Sie im Abschnitt **Tokenkonfiguration** den Standardwert im Feld **Maximaler Tokanablaufzeitraum (Sekunden)**. Wenn Sie die Konsolenregisterkarte **Konfigurationsdateien** der Anwendung
auswählen, sehen Sie, dass der Wert der Eigenschaft `maxTokenExpiration` auf den von Ihnen konfigurierten Wert gesetzt ist. 

### Benutzeridentitätsrealm
{: #user-identity-realm }

In Version 7.1 können Authentifizierungsrealms als Benutzeridentitätsrealms konfiguriert werden. Anwendungen mit dem
Authentifizierungsablauf des {{ site.data.keys.product_adj }}-OAuth-Sicherheitsmodells
verwenden die Eigenschaft `userIdentityRealms` in der Anwendungsdeskriptordatei,
um eine geordnete Liste mit Benutzeridentitätsrealms zu definieren. In Anwendungen, die den Authentifizierungsablauf des
klassischen {{ site.data.keys.product_adj }}-Sicherheitsmodells (Nicht-OAuth-Sicherheit) verwenden,
zeigt das Attribut `isInternalUserId`
an, ob das Realm ein Benutzeridentitätsrealm ist. In Version 8.0 werden solche Benutzer-ID-Konfigurationen nicht mehr benötigt. Die Identität (ID) des aktiven Benutzers wird in
Version 8.0 von der letzten Sicherheitsüberprüfung, die die Methode `setActiveUser` aufgerufen hat, festgelegt. Wenn Ihre Sicherheitsüberprüfung
die abstrakte Basisklasse `UserAuthenticationSecurityCheck` erweitert, wie es bei der Beispielüberprüfung `UserLogin` in Version 8.0 der Fall ist,
können Sie auf die Basisklasse zurückgreifen, um die Identität des aktiven Benutzers festzulegen.


### Geräteidentitätsrealm
{: #device-identity-realm }

Eine Anwendung in Version 7.1 muss ein Geräteidentitätsrealm definieren In Version 8.0 ist dieses Realm nicht mehr erforderlich. Die Geräteidentität
wird in Version 8.0 nicht mit einer Sicherheitsüberprüfung verknüpft. Die Gerätedaten werden vielmehr
im Rahmen der Clientregistrierung registriert. Die Clientregistrierung wird durchgeführt, wenn der Client zum ersten Mal versucht,
auf eine geschützte Ressource zuzugreifen. 

## Weitere Schritte
{: #whats-next }

Dieses Lernprogramm deckt nur die grundlegenden Schritte ab, die für die Umstellung der Sicherheitsartefakte einer vorhandenen,
mit einer Vorgängerversion der {{ site.data.keys.product }} entwickelten Anwendung auf Version 8.0 erforderlich sind. Informationen zu einer optimalen Nutzung der
Sicherheitsfeatures von Version 8.0 finden Sie in der [Dokumentation zum Sicherheitsframework von Version 8.0](../../authentication-and-security/).

