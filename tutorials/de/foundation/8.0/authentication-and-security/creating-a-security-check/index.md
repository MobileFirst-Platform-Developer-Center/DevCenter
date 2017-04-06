---
layout: tutorial
title: Sicherheitsüberprüfung erstellen
breadcrumb_title: Sicherheitsüberprüfung erstellen
relevantTo: [android,ios,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Sicherheitsüberprüfungen sind der grundlegende serverseitige Baustein des
{{ site.data.keys.product_adj }}-Sicherheitsframeworks. Eine Sicherheitsüberprüfung ist
eine serverseitige Entität, die eine bestimmte Autorisierungslogik implementiert, z. B. für das Anfordern und Validieren von Clientberechtigungsnachweisen. Für den Schutz einer Ressource weisen Sie ihr einen Bereich zu, der null oder mehr Sicherheitsüberprüfungen zugeordnet ist. Das Sicherheitsframework stellt sicher, dass nur
ein Client, der alle Sicherheitsüberprüfungen des schützenden Bereichs besteht, Zugriff auf die Ressource
erhält. Sie können Sicherheitsüberprüfungen verwenden, um den
Zugriff auf Ressourcen zu genehmigen, die von
{{ site.data.keys.mf_server }} oder einem externen Ressourcenserver
bereitgestellt werden. 

Ein Adapter kann ein Ressourcenadapter (*resource*) sein (also Ressourcen und
Inhalte bereitstellen, die an den Client gesendet werden sollen)
und/oder ein Adapter für Sicherheitsüberprüfungen (*SecurityCheck*). 

> <b>Hinweis:</b> Sicherheitsüberprüfungen werden in Adaptern implementiert.
Dennoch sind das {{ site.data.keys.product_adj }}-Sicherheitsframework und die Adapter-APIs voneinander getrennt
und können nicht gemischt werden. Sie können daher
keine Adapter-API wie die Schnittstelle `AdpatersAPI` im Code Ihrer Sicherheitsüberprüfung
und keine APIs für Sicherheitsüberprüfungen im Quellcode von Adaptern verwenden.

Die Architektur des Sicherheitsframeworks ist modular und
flexibel, und die Implementierung der Sicherheitsüberprüfung ist grundsätzlich nicht von einer bestimmten Ressource oder Anwendung abhängig. Sie können eine
Sicherheitsüberprüfung wiederverwenden, um andere Ressourcen zu schützen, und für verschiedene Autorisierungsabläufe unterschiedliche Kombinationen von Sicherheitsüberprüfungen verwenden. Für noch mehr Flexibilität macht eine Sicherheitsprüfungsklasse
Konfigurationseigenschaften zugänglich, die auf Adapterebene in der Definition der Sicherheitsüberprüfung und während der Laufzeit
in der {{ site.data.keys.mf_console }} angepasst werden können. 

Zur Vereinfachung und Beschleunigung des
Entwicklungsprozesses stellt die {{ site.data.keys.product }} Implementierungen abstrakter Basisklassen für die
Schnittstelle `SecurityCheck` bereit.
Zusätzlich steht eine abstrakte Basisimplementierung der Schnittstelle
`SecurityCheckConfiguration`
(`SecurityCheckConfigurationBase`) zur Verfügung sowie
komplementäre Beispielkonfigurationsklassen für Sicherheitsüberprüfungen für jede der bereitgestellten Basisklassen für Sicherheitsüberprüfungen. Beginnen Sie mit der
Basisimplementierung für Sicherheitsüberprüfungen (und der zugehörigen Beispielkonfiguration), die am ehesten Ihren Entwicklungsanforderungen entspricht, und modifizieren Sie die
Implementierung nach Bedarf. 

> Machen Sie sich mit der [Vereinbarung einer Sicherheitsüberprüfung](contract) vertraut.

**Voraussetzungen:**

* Gehen Sie das Lernprogramm [Autorisierungskonzepte](../) durch. 
* Informieren Sie sich über das [Erstellen von Adaptern](../../adapters/creating-adapters).

**Verwendung:**  
Die nachfolgend beschriebenen Basisklassen für Sicherheitsüberprüfungen
sind Teil
der Java-Maven-Bibliothek {{ site.data.keys.product_adj }} `com.ibm.mfp.security.checks.base`,
die beim Erstellen des Adapters aus dem
[Maven Central Repository](http://search.maven.org/#search|ga|1|a%3A%22mfp-security-checks-base%22) heruntergeladen wird. Wenn Sie die Entwicklungsschritte offline ausführen,
können Sie
die Basisklassen in der {{ site.data.keys.mf_console }} über das Download-Center
auf der Registerkarte "Tools"  unter **Sicherheitsüberprüfungen** herunterladen. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Sicherheitsüberprüfungen definieren](#defining-a-security-check)
* [Sicherheitsüberprüfungen implementieren](#security-check-implementation)
* [Sicherheitsüberprüfungen konfigurieren](#security-check-configuration)
* [Vordefinierte Sicherheitsüberprüfungen](#predefined-security-checks)
* [Weitere Schritte](#what-s-next)

## Sicherheitsüberprüfungen definieren
{: #defining-a-security-check }

[Erstellen Sie einen Java- oder JavaScript-Adapter](../../adapters/creating-adapters/) oder verwenden Sie einen vorhandenen Adapter. 

> Wenn ein Java-Adapter mit der Standardschablone erstellt wird, wird davon ausgegangen, dass der Adapter **Ressourcen** bereitstellen soll. Der Entwickler kann beschließen,
Sicherheitsüberprüfungen und Ressourcen in das Adapterpaket oder in speziell dafür vorgesehene Adapter aufzunehmen.

Wenn Sie die Standardimplementierung für **Ressourcen** entfernen möchten,
löschen Sie die Dateien **[Adaptername]Application.java** und **[Adaptername]Resource.java**. Entfernen Sie
außerdem das Element `<JAXRSApplicationClass>` aus der Datei **adapter.xml**. 

Fügen Sie zur Datei **adapter.xml** des Java-Adapters ein XML-Element mit der Bezeichnung
`securityCheckDefinition` hinzu. Beispiel: 

```xml
<securityCheckDefinition name="sample" class="com.sample.sampleSecurityCheck">
    <property name="successStateExpirationSec" defaultValue="60"/>
    <property name="blockedStateExpirationSec" defaultValue="60"/>
    <property name="maxAttempts" defaultValue="3"/>
</securityCheckDefinition>
```

* Das Attribut `name` gibt den Namen der Sicherheitsüberprüfung an. 
* Das Attribut `class` gibt die Implementierung der Java-Klasse für die Sicherheitsüberprüfung an. Sie müssen diese Klasse erstellen. 
* Sicherheitsüberprüfungen können mit einer Liste von `property`-Elementen [weiter konfiguriert](#security-check-configuration) werden. 
* Informationen zum Definieren angepasster Eigenschaften finden Sie unter [Sicherheitsüberprüfungen konfigurieren](#security-check-configuration).

Wenn Sie einen Adapter mit einer Sicherheitsprüfungsdefinition erfolgreich in
{{ site.data.keys.mf_server }} implementiert haben, können Sie Ihre Sicherheitsüberprüfung und die zugehörigen Konfigurationsdaten
auch in der {{ site.data.keys.mf_console }} unter **Adapter → [Ihr Adapter]** anzeigen und dort Laufzeitkonfigurationsänderungen vornehmen: 

* Auf der Registerkarte **Konfigurationsdateien** sehen Sie die Serverkopie
Ihres Adapterdeskriptors mit dem Element
`<securityCheckDefinition>`, das Ihre Sicherheitsüberprüfung und deren konfigurierbare Eigenschaften definiert. Sie können die [Adapterkonfiguration auch per Pull-Operation übertragen](../../adapters/java-adapters/#custom-properties) und per Push-Operation
an verschiedene Server senden. 
* Auf der Registerkarte **Sicherheitsüberprüfungen** können Sie eine Liste aller Konfigurationseigenschaften sehen, die Sie in der Sicherheitsüberprüfung
zugänglich gemacht haben. Auf die Eigenschaften wird mit dem Wert des konfigurierten Attributs
`displayName` oder - wenn kein Anzeigename konfiguriert ist - mit dem Wert des Attributs
name verwiesen. Falls Sie in der Definition das Attribut description der Eigenschaft
festgelegt haben, wird die Beschreibung ebenfalls angezeigt. Für jede Eigenschaft wird der Wert, der mit dem Attribut
`defaultValue` konfiguriert wurde, als aktueller Wert angezeigt. Sie können den Wert ändern, um den Standardwert aus Ihrer Sicherheitsprüfungsdefinition
außer Kraft zu setzen. Sie können auch jederzeit die ursprünglichen Standardwerte aus Ihrer Sicherheitsprüfungsdefinition wiederherstellen.  
* Sie können auch in der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen** eine Anwendungsversion auswählen. 

## Sicherheitsüberprüfungen implementieren
{: #security-check-implementation }

Erstellen Sie die **Java-Klasse** für die Sicherheitsüberprüfung. Die Implementierung sollte - wie unten gezeigt - eine der
bereitgestellten Basisklassen erweitern. Die von Ihnen gewählte übergeordnete Klasse bestimmt die Ausgewogenheit von Anpassung und Einfachheit. 

### Sicherheitsüberprüfung
{: #security-check }
`SecurityCheck` ist eine **Java-Schnittstelle**, die Methoden definiert, die für die Darstellung einer Sicherheitsüberprüfung als Minimum erforderlich sind.   
Die Verantwortung für die einzelnen Szenarien liegt ganz beim Entwickler, der die Sicherheitsüberprüfung implementiert. 

### ExternalizableSecurityCheck
{: #externalizablesecuritycheck }
Diese abstrakte Klasse implementiert eine Basisversion der Schnittstelle für Sicherheitsüberprüfungen.   
Sie ermöglicht unter anderem die Externalisierung als JSON, Inaktivitätszeitlimits und einen Ablauf-Countdown. 

Durch die Bildung von Unterklassen zu dieser Klasse sind Sie hinsichtlich der Implementierung Ihrer Sicherheitsüberprüfung sehr flexibel. 

> Weitere Informationen enthält das Lernprogramm [ExternalizableSecurityCheck](../externalizable-security-check). 

### CredentialsValidationSecurityCheck
{: #credentialsvalidationsecurityCheck }
Diese Klasse erweitert `ExternalizableSecurityCheck` und implementiert die meisten Methoden dieser Klasse, um die Nutzung zu vereinfachen. Die beiden
Methoden `validateCredentials` und `createChallenge` müssen implementiert werden. Die Implementierung erlaubt eine begrenzte Anzahl von
Anmeldeversuchen in einem bestimmten Zeitraum. Nach diesem Zeitraum wird die Sicherheitsüberprüfung für eine konfigurierte Zeit
blockiert. Im Falle einer erfolgreichen Anmeldung bleibt die Sicherheitsüberprüfung für eine konfigurierte Zeit im Zustand "erfolgreich". Während dieser
Zeit kann der Benutzer auf die angeforderte Ressource zugreifen. 

Die Klasse `CredentialsValidationSecurityCheck` ist für einfache Abläufe gedacht, um
beliebige Berechtigungsnachweise zu validieren, damit der Zugriff auf eine Ressource gewährt werden kann. Es gibt eine integrierte Funktion,
die nach einer Reihe von Versuchen den Zugriff blockiert. 

> Weitere Informationen enthalten die Lernprogramme zu [CredentialsValidationSecurityCheck](../credentials-validation/). 

### UserAuthenticationSecurityCheck
{: #userauthenticationsecuritycheck}
Diese Klasse erweitert `CredentialsValidationSecurityCheck` und übernimmt daher alle zugehörigen Features. Sie ergänzt
eine Implementierung, die ein Benutzer-ID-Objekt (`AuthenticatedUser`)
erstellt, das verwendet werden kann, um den derzeit angemeldeten Benutzer zu identifizieren. Außerdem gibt es eine integrierte Möglichkeit,
das Feature "Remember Me" zu aktivieren, damit die Anmeldung erinnert wird. Die drei Methoden
`createUser`, `validateCredentials` und `createChallenge` müssen implementiert werden.

> Weitere Informationen enthalten die Lernprogramme zu [UserAuthenticationSecurityCheck](../user-authentication/). 

## Sicherheitsüberprüfungen konfigurieren
{: #security-check-configuration }

Jede Implementierungsklasse für Sicherheitsüberprüfungen kann
eine Klasse `SecurityCheckConfiguration` verwenden, die für die jeweilige Sicherheitsüberprüfung verfügbare Eigenschaften definiert. Zu jeder
`SecurityCheck`-Basisklasse gibt es eine passende Klasse `SecurityCheckConfiguration`. Sie können Ihre eigene Implementierung
erstellen, die eine der `SecurityCheckConfiguration`-Basisklassen erweitert, und sie
für Ihre angepasste Sicherheitsüberprüfung verwenden. 

Die Methode `createConfiguration` von
`UserAuthenticationSecurityCheck` gibt beispielsweise eine Instanz von `UserAuthenticationSecurityCheckConfig` zurück.

```java
public abstract class UserAuthenticationSecurityCheck extends CredentialsValidationSecurityCheck {
  @Override
  public SecurityCheckConfiguration createConfiguration(Properties properties) {
      return new UserAuthenticationSecurityCheckConfig(properties);
  }
}
```

`UserAuthenticationSecurityCheckConfig` aktiviert eine Eigenschaft mit der Bezeichnung
`rememberMeDurationSec` und dem Standardwert `0`.

```java
public class UserAuthenticationSecurityCheckConfig extends CredentialsValidationSecurityCheckConfig {

    public int rememberMeDurationSec;

    public UserAuthenticationSecurityCheckConfig(Properties properties) {
        super(properties);
        rememberMeDurationSec = getIntProperty("rememberMeDurationSec", properties, 0);
    }

}
```

<br/>
Diese Eigenschaften können auf verschiedenen Ebenen konfiguriert werden:

### adapter.xml
{: #adapterxml }
In der Datei **adapter.xml** des Java-Adapters können Sie innerhalb von
`<securityCheckDefinition>` ein `<property>`-Element oder mehrere solche Elemente hinzufügen.   
Das Element `<property>` wird mit folgenden Attributen verwendet:


- **name**: Name der Eigenschaft, wie er in der Konfigurationsklasse definiert ist
- **defaultValue**: Setzt den in der Konfigurationsklasse definierten Wert außer Kraft
- **displayName**: benutzerfreundlicher Anzeigename, der in der Konsole erscheint (*optional*) 
- **description**: Beschreibung, die in der Konsole angezeigt wird (*optional*)
- **type**: stellt sicher, dass die Eigenschaft einen bestimmten Typ hat, z. B. `integer`, `string` oder `boolean` bzw. eine Liste mit gültigen Werten wie `type="['1','2','3']"` (*optional*) 

Beispiel:


```xml
<property name="maxAttempts" defaultValue="3" displayName="How many attempts are allowed?" type="integer"/>
```

> Ein Praxisbeispiel finden Sie
im Abschnitt [Sicherheitsüberprüfung konfigurieren](../credentials-validation/security-check/#configuring-the-security-check)
des Lernprogramms "CredentialsValidationSecurityCheck".

### {{ site.data.keys.mf_console }} - Adapter
{: #mobilefirst-operations-console-adapter }
In der {{ site.data.keys.mf_console }} können Sie unter **[Ihr Adapter]** auf der Registerkarte "Sicherheitsüberprüfung" den Wert
jeder in der Datei **adapter.xml** definierten Eigenschaft ändern.   
Beachten Sie, dass in dieser Anzeige **nur** die in der Datei
**adapter.xml** definierten Eigenschaften erscheinen.
In der Konfigurationsklasse definierte Eigenschaften werden hier nicht automatisch angezeigt. 

![Adapter in der Konsole](console-adapter-security.png)

Sie können auch die JSON-Konfigurationsdatei des Adapters manuell bearbeiten und die erforderliche Konfiguration definieren.
Senden Sie dann die Änderungen per Push-Operation zurück an {{ site.data.keys.mf_server }}.

1. Navigieren Sie in eiem **Befehlszeilenfenster** zum Projektstammverzeichnis
und führen Sie den Befehl `mfpdev adapter pull` aus.
2. Öffnen Sie die Konfigurationsdatei aus dem Ordner **[Projektordner]\mobilefirst**. 
3. Bearbeiten Sie die Datei und suchen Sie nach dem Objekt `securityCheckDefinitions`. Finden oder erstellen Sie in diesem Objekt
ein Objekt, das den Namen Ihrer ausgewählten Sicherheitsüberprüfung hat. Suchen Sie in dem Sicherheitsprüfungsobjekt
ein Eigenschaftenobjekt ("properties"). Fügen Sie ggf. ein solches Objekt hinzu. Fügen Sie für jede verfügbare Konfigurationseigenschaft, die Sie definieren wollen,
zum Objekt properties ein Paar aus Name und Wert der Konfigurationseigenschaft hinzu. Beispiel:  

   ```xml
   "securityCheckDefinitions": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "4",
                "failureExpirationSec: "90"
            }
        }
   }
   ```
   
4. Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl `mfpdev adapter push` aus.

### {{ site.data.keys.mf_console }} - Anwendung
{: #mobilefirst-operations-console-application }
Eigenschaftswerte können auch auf der Anwendungsebene überschrieben werden. 

In der {{ site.data.keys.mf_console }} können Sie unter **[Ihre Anwendung]** auf der Registerkarte **Sicherheit** im Abschnitt
**Konfigurationen für Sicherheitsüberprüfungen** die Werte modifizieren, die
in den einzelnen Sicherheitsüberprüfungen verfügbar sind. 

<img class="gifplayer" alt="Eigenschaften für Sicherheitsüberprüfungen konfigurieren" src="console-application-security.png"/>

Sie können auch die JSON-Konfigurationsdatei des Adapters manuell bearbeiten und die erforderliche Konfiguration definieren.
Senden Sie dann die Änderungen per Push-Operation zurück an {{ site.data.keys.mf_server }}.

1. Navigieren Sie in eiem **Befehlszeilenfenster** zum Projektstammverzeichnis
und führen Sie den Befehl `mfpdev app pull` aus.
2. Öffnen Sie die Konfigurationsdatei aus dem Ordner **[Projektordner]\mobilefirst**. 
3. Bearbeiten Sie die Datei und suchen Sie nach dem Objekt `securityCheckConfigurations`. Finden oder erstellen Sie in diesem Objekt
ein Objekt, das den Namen Ihrer ausgewählten Sicherheitsüberprüfung hat. Fügen Sie innerhalb des Sicherheitsprüfungsobjekts
für jede verfügbare Konfigurationseigenschaft, die Sie konfigurieren möchten, ein Paar aus Eingeschaftsname und -wert hinzu. Beispiel: 

   ```xml
   "SecurityCheckConfigurations": {
        "UserAuthentication": {
            "properties": {
                "maxAttempts": "2",
                "failureExpirationSec: "60"
            }
        }
   }
   ```
   
4. Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl `mfpdev app push` aus.

## Vordefinierte Sicherheitsüberprüfungen
{: #predefined-security-checks }

Die folgenden vordefinierten Sicherheitsüberprüfungen sind ebenfalls verfügbar: 

- [Anwendungsauthentizität](../application-authenticity/)
- [Direkte Aktualisierung](../../application-development/direct-update)
- LTPA

## Weitere Schritte
{: #what-s-next }

Informieren Sie sich anhand der folgenden Lernprogramme intensiver über Sicherheitsüberprüfungen.   
Vergessen Sie nicht, Ihren Adapter zu implementieren, wenn Sie die Entwicklung abgeschlossen oder Ihre Änderungen vorgenommen haben. 

* [Implementieren Sie CredentialsValidationSecurityCheck](../credentials-validation/). 
* [Implementieren Sie UserAuthenticationSecurityCheck](../user-authentication/). 
* Informieren Sie sich über weitere {{ site.data.keys.product }} [Authentifizierungs- und Sicherheitsfeatures](../).
