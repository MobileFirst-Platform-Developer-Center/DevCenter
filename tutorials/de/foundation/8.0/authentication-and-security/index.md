---
layout: tutorial
title: Authentifizierung und Sicherheit
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Das {{ site.data.keys.product_adj }}-Sicherheitsframework basiert auf dem Protokoll [OAuth 2.0](http://oauth.net/). Gemäß diesem Protokoll kann eine Ressource mit einem **Bereich** geschützt
werden,
in dem die erforderlichen Berechtigungen für den Zugriff auf die Ressource definiert sind. Für den Zugriff auf eine geschützte Ressource muss die Clientanwendung ein passendes **Zugriffstoken** bereitstellen, in das der Bereich für die dem Client gewährte Autorisierung eingebunden ist. 

Das OAuth-Protokoll
unterscheidet die Rolle
des Autorisierungsservers von der Rolle des Ressourcenservers, der die Ressourcen bereitstellt. 

* Der Autorisierungsserver verwaltet die Clientberechtigungen und die Tokengenerierung. 
* Der Ressourcenserver
verwendet den Autorisierungsserver, um das vom Client bereitgestellte Zugriffstoken zu validieren und um sicherzustellen, dass das Token zum Schutzbereich der angeforderten
Ressource passt. 

Im Zentrum des Sicherheitsframeworks steht ein
Autorisierungsserver, der das
OAuth-Protokoll implementiert und die OAuth-Endpunkte, mit denen der Client beim Anfordern von Zugriffstoken interagiert, zugänglich macht. Das Sicherheitsframework enthält die logischen Bausteine
für die Implementierung einer angepassten Autorisierungslogik unter Verwendung des Autorisierungsservers und des zugrunde liegenden
OAuth-Protokolls. {{ site.data.keys.mf_server }} fungiert standardmäßig auch als
**Autorisierungsserver**. Sie können aber auch ein IBM
WebSphere-DataPower-Gerät als Autorisierungsserver konfigurieren, der mit
{{ site.data.keys.mf_server }} interagiert. 

Die Clientanwendung kann diese Token dann für den Zugriff auf Ressourcen eines
**Ressourcenservers** verwenden, bei dem es sich um {{ site.data.keys.mf_server }} oder um einen externen Server handeln kann. Der Ressourcenserver überprüft die
Gültigkeit des Tokens, um sicherzustellen, dass dem Client der Zugriff auf die angeforderte Ressource gewährt werden kann. Durch die Trennung von Ressourcenserver und
Autorisierungsserver können Sie die Sicherheit für Ressourcen durchsetzen, die außerhalb von
{{ site.data.keys.mf_server }} ausgeführt werden.

Anwendungsentwickler schützen den Zugriff auf Ressourcen, indem sie
für jede Ressource den erforderlichen Bereich definieren
und die **Sicherheitsüberprüfungen** und **Abfrage-Handler** implementieren. Das serverseitige Sicherheitsframework
und die clientseitige API kümmern sich transparent um den OAuth-Nachrichtenaustausch und die Interaktion mit dem Autorisierungsserver, sodass
sich Entwickler vollständig auf die Autorisierungslogik konzentrieren können. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Autorisierungsentitäten](#authorization-entities)
* [Ressourcen schützen](#protecting-resources)
* [Autorisierungsablauf](#authorization-flow)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Autorisierungsentitäten
{: #authorization-entities }

### Zugriffstoken
{: #access-tokens }

Ein MobileFirst-Zugriffstoken
ist eine digital signierte Entität, die die Autorisierungsberechtigungen eines Clients
beschreibt.
Wenn der Autorisierungsanforderung des Clients für einen bestimmten Bereich entsprochen und der Client authentifiziert wurde,
sendet der Tokenendpunkt des Autorisierungsservers eine HTTP-Antwort mit dem angeforderten Zugriffstoken an den
Client. 

#### Struktur
{: #structure }

Das
{{ site.data.keys.product_adj }}-Zugriffstoken
enthält folgende Informationen: 

* **Client-ID**: Eine eindeutige Kennung des Clients 
* **Bereich**: Der Bereich, für den das Token ausgestellt wurde (siehe "OAuth-Bereiche"). Dieser Bereich umfasst nicht den [obligatorischen
Anwendungsbereich](#mandatory-application-scope). 
* **Tokenablaufzeit**: Die Zeit, nach der das Token ungültig wird (abläuft), in Sekunden

#### Tokenablaufzeit
{: #token-expiration }

Das ausgestellte Zugriffstoken bleibt gültig, bis der Ablaufzeitpunkt
erreicht ist.
Die Ablaufzeit des Zugriffstokens ist, verglichen mit den Ablaufzeiten aller Sicherheitsüberprüfungen im Bereich, die kürzeste. Wenn jedoch die kürzeste Ablaufzeit länger als der maximale Tokenablaufzeitraum der
Anwendung ist, wird die Ablaufzeit des Tokens auf die aktuelle Zeit zuzüglich des maximalen Ablaufzeitraums gesetzt. Der Standardwert für den maximalen
Tokenablaufzeitraum (d. h. die maximale Gültigkeitsdauer) liegt bei
3.600 Sekunden (1 Stunde). Der Wert kann jedoch konfiguriert werden, indem der Wert der
Eigenschaft `maxTokenExpiration` gesetzt wird
(siehe "Maximalen Ablaufzeitraum für Zugriffstoken konfigurieren"). 

<div class="panel-group accordion" id="configuration-explanation" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="access-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>Maximalen Ablaufzeitzeitraum für Zugriffstoken konfigurieren</b></a>
            </h4>
        </div>

        <div id="collapse-access-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="access-token-expiration">
            <div class="panel-body">
            <p>Wählen Sie eine der folgenden Alternativen, um für die Anwendung den maximalen Ablaufzeitraum für Zugriffstoken zu konfigurieren:</p>
            <ul>
                <li>{{ site.data.keys.mf_console }}:
                    <ul>
                        <li>Wählen Sie Ihre Anwendung und dann das Register <b>Sicherheit</b> aus.</li>
                        <li>Setzen Sie im Abschnitt <b>Tokenkonfiguration</b> das Feld <b>Maximaler Tokanablaufzeitraum (Sekunden)</b> auf den gewünschten Wert und klicken Sie auf <b>Speichern</b>. Sie können diesen Schritt jederzeit wiederholen, um den maximalen Tokenablaufzeitraum zu ändern, oder <b>Standardwerte wiederherstellen</b> auswählen, um den Standardwert wiederherzustellen.</li>
                    </ul>
                </li>
                <li>Konfigurationsdatei der Anwendung bearbeiten:
                    <ol>
                        <li>Navigieren Sie in eiem <b>Befehlszeilenfenster</b> zum Projektstammverzeichnis und führen Sie den Befehl <code>mfpdev app pull</code> aus.</li>
                        <li>Öffnen Sie die Konfigurationsdatei aus dem Ordner <b>[Projektordner]\mobilefirst</b>. </li>
                        <li>Bearbeiten Sie die Datei. Definieren Sie eine Eingeschaft <code>maxTokenExpiration</code> und setzen Sie sie auf den Wert für den maximalen Ablaufzeitraum für Zugriffstoken (in Sekunden).

{% highlight xml %}
{
    ...
    "maxTokenExpiration": 7200
}
{% endhighlight %}</li>
                        <li>Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl <code>mfpdev app push</code> aus.</li>
                    </ol>
                </li>
            </ul>

            <br/>
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>Abschnitt schließen</b></a>
                </div>
        </div>
    </div>
</div>

<div class="panel-group accordion" id="response-access-token" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="response-structure">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>Antwortstruktur für Zugriffstoken</b></a>
            </h4>
        </div>

        <div id="collapse-response-structure" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure">
            <div class="panel-body">
                <p>Die HTTP-Antwort auf eine erfolgreiche Zugriffstokenanforderung enthält ein JSON-Objekt mit dem Zugriffstoken und zusätzliche Daten. Das folgende Beispiel zeigt eine Antwort mit gültigem Token vom Autorisierungsserver:</p>

{% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
    "token_type": "Bearer",
    "expires_in": 3600,
    "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
    "scope": "scopeElement1 scopeElement2"
}
{% endhighlight %}

<p>Das JSON-Objekt mti der Tokenantwort enthält die folgenden Eigenschaftsobjekte:</p>
<ul>
    <li><b>token_type</b>: Der Tokentyp ist immer <i>"Bearer"</i> (siehe <a href="https://tools.ietf.org/html/rfc6750">OAuth 2.0 Authorization Framework: Bearer Token Usage</a>).</li>
    <li><b>expires_in</b>: Die Ablaufzeit des Zugriffstokens in Sekunden</li>
    <li><b>access_token</b>: Das generierte Zugriffstoken (tatsächliche Token sind länger als im Beispiel dargestellt)</li>
    <li><b>scope</b>: Der angeforderte Bereich</li>
</ul>

<p>Die Angaben <b>expires_in</b> und <b>scope</b> sind auch im Token selbst (<b>access_token</b>) enthalten.</p>

<blockquote><b>Hinweis:</b> Die Struktur einer gültigen Zugriffstokenantwort ist relevant, wenn Sie die
untergeordnete Klasse <code>WLAuthorizationManager</code> verwenden und selbst die OAuth-Interaktion zwischen dem Client und dem Autorisierungsserver sowie den Ressourcenservern
verwalten oder einen vertraulichen Client verwenden. Falls Sie die übergeordnete
Klasse <code>WLResourceRequest</code> verwenden, die den OAuth-Ablauf für den Zugriff auf geschützte Ressourcen einbindet, verarbeitet das Sicherheitsframework die
Zugriffstokenantworten für Sie. Lesen Sie hierzu die Informationen unter
<a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_oauth_client_apis.html?view=kc#c_oauth_client_apis">Client security APIs</a> und
<a href="confidential-clients">Vertrauliche Clients</a>.</blockquote>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>Abschnitt schließen</b></a>
                </div>
        </div>
    </div>
</div>

### Aktualisierungstoken
{: #refresh-tokens}

Ein Aktualisierungstoken ist eine besondere Art von Token. Wenn das Zugriffstoken abgelaufen ist, kann das Aktualisierungstoken verwendet werden, um ein neues Zugriffstoken anzufordern. Für die Anforderung eines neuen Zugriffstokens kann ein gültiges Aktualisierungstoken vorgelegt werden. Aktualisierungstoken sind langlebige Token, die länger als Zugriffstoken gültig bleiben. 

Eine Anwendung muss Vorsicht walten lassen, wenn sie Aktualisierungstoken verwendet, da ein Benutzer mit einem solchen Token unbegrenzte Zeit authentifiziert bleiben kann. Social-Media-Anwendungen, E-Commerce-Anwendungen, Produktkataloganzeigen und Dienstprogrammanwendungen, bei denen Benutzer nicht regelmäßig vom Anwendungsprovider authentifiziert werden, können Aktualisierungstoken nutzen. Anwendungen, die eine regelmäßige Benutzerauthentifizierung erfordern, sollten die Verwendung von Aktualisierungstoken vermeiden.  

#### MobileFirst-Aktualisierungstoken
{: #mfp-refresh-token}

Ein MobileFirst-Aktualisierungstoken ist eine digital signierte Entität wie ein Zugriffstoken, die die Autorisierungsberechtigungen eines Clients beschreibt.
Aktualisierungstoken können verwendet werden, um neue Zugriffstoken desselben Geltungsbereichs zu erhalten. Wenn der Autorisierungsanforderung des Clients für einen bestimmten Bereich entsprochen und der Client authentifiziert wurde, sendet der Tokenendpunkt des Autorisierungsservers eine HTTP-Antwort mit dem angeforderten Zugriffstoken und Aktualisierungstoken an den Client. Wenn das Zugriffstoken abläuft, sendet der Client ein Aktualisierungstoken an den Tokenendpunkt des Autorisierungsservers, um ein neues Zugriffstoken und ein neues Aktualisierungstoken zu erhalten. 

**Struktur**

Das MobileFirst-Aktualisierungstoken enthält ähnlich wie ein MobileFirst-Zugriffstoken die folgenden Informationen: 
* **Client-ID**: Eine eindeutige Kennung des Clients 
* **Bereich**: Der Bereich, für den das Token ausgestellt wurde (siehe "OAuth-Bereiche"). Dieser Bereich umfasst nicht den obligatorischen Anwendungsbereich. 
* **Tokenablaufzeit**: Die Zeit, nach der das Token ungültig wird (abläuft), in Sekunden

#### Tokenablaufzeit
{: #token-expiration}

Der Ablaufzeitraum für Aktualisierungstoken ist länger als der normale Ablaufzeitraum für Zugriffstoken. Ein einmal ausgestelltes Aktualisierungstoken bleibt gültig, bis der Ablaufzeitpunkt erreicht ist.
Dank dieses Gültigkeitszeitraums kann ein Client ein Aktualisierungstoken verwenden, um ein neues Zugriffstoken und ein neues Aktualisierungstoken zu erhalten. Der Ablaufzeitraum eines Aktualisierungstokens ist festgelegt und liegt bei 30 Tagen. Jedes Mal, wenn der Client erfolgreich ein neues Zugriffstoken und Aktualisierungstoken erhält, wird der Ablaufzeitraum des Aktualisierungstokens zurückgesetzt, sodass der Client den Eindruck hat, das Token würde nie ablaufen. Die Regeln für die Ablaufzeit des Zugriffstokens sind die im Abschnitt **Zugriffstoken** erläuterten.

<div class="panel-group accordion" id="configuration-explanation-rt" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="refresh-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>Aktualisierungstoken aktivieren</b></a>
            </h4>
        </div>

        <div id="collapse-refresh-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="refresh-token-expiration">
            <div class="panel-body">
            <p>Aktualisierungstoken können mit den folgenden Eigenschaften jeweils auf der Client- und der Serverseite aktiviert werden. </p>
            <b>Clientseitige Eigenschaft</b><br/>

            <i>Dateiname</i>:            mfpclient.properties<br/>
            <i>Eigenschaftsname</i>:   wlEnableRefreshToken<br/>
            <i>Eigenschaftswert</i>:   true<br/>

            Beispiel:<br/>
            <i>wlEnableRefreshToken=true</i><br/><br/>

            <b>Serverseitige Eigenschaft</b><br/>

            <i>Dateiname</i>:            server.xml<br/>
            <i>Eigenschaftsname</i>:   mfp.security.refreshtoken.enabled.apps<br/>
            <i>Eigenschaftswert</i>:   <i>Anwendungsbundle-IDs, jeweils getrennt durch ‘;’</i><br/><br/>

            <p>Beispiel:</p><br/>
            {% highlight xml %}
            <jndiEntry jndiName="mfp/mfp.security.refreshtoken.enabled.apps" value='"com.sample.android.myapp1;com.sample.android.myapp2"'/>
            {% endhighlight %}

            <p>Verwenden Sie für verschiedene Plattformen unterschiedliche Bundle-IDs.</p>

                                    <br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>Abschnitt schließen</b></a>
                </div>
                                </div>
                            </div>
                        </div>

<div class="panel-group accordion" id="response-refresh-token" role="tablist">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="response-structure-rt">
        <h4 class="panel-title">
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>Struktur der Aktualisierungstokenantwort</b></a>
        </h4>
    </div>

    <div id="collapse-response-structure-rt" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure-rt">
      <div class="panel-body">
        <p>Das folgende Beispiel zeigt eine gültige Aktualisierungstokenantwort vom Autorisierungsserver:</p>

        {% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{"token_type": "Bearer",
            "expires_in": 3600,
            "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
            "scope": "scopeElement1 scopeElement2",
            "refresh_token": "yI7ICasdsdJodHRwOi8vc2Vashnneh "
        }
        {% endhighlight %}

        <p>Das Aktualisierungstoken hat neben den Eigenschaftenobjekten, die im Abschnitt zur Struktur der Zugriffstokenantwort erklärt sind, hat die Aktualisierungstokenantwort das Eigenschaftsobjekt <code>refresh_token</code>. </p>

        <br/>
              <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>Abschnitt schließen</b></a>
                </div>
          </div>
        </div>
</div>


>**Hinweis:** Aktualisierungstoken sind im Vergleich zu Zugriffstoken langlebig. Daher sollten Sie Aktualisierungstoken mit Vorsicht verwenden. Anwendungen, die keine regelmäßige Benutzerauthentifizierung erfordern, sind ideale Kandidaten für die Verwendung von Aktualisierungstoken. MobileFirst unterstützt Aktualisierungstoken derzeit nur für die Android-Plattform. Sie sollten für Android- und iOS-Anwendungen unterschiedliche Bundle-IDs verwenden. 


### Sicherheitsüberprüfungen
{: #security-checks }

Eine Sicherheitsüberprüfung ist eine serverseitige Entität, die die Sicherheitslogik zum Schutz sererseitiger Anwendungsressourcen
implementiert. Ein einfaches Beispiel für eine Sicherheitsüberprüfung ist die Sicherheitsüberprüfung einer Benutzeranmeldung, bei der die Berechtigungsnachweise eines Benutzers
empfangen und anhand einer Benutzerregistry verifiziert werden. Ein weiteres Beispiel ist die vordefinierte
Sicherheitsüberprüfung der {{ site.data.keys.product_adj }}-Anwendungsauthentizität,
bei der die Authentizität der mobilen Anwendung validiert wird und die Anwendungsressourcen vor unbefugtem Zugriff gescützt werden. Dieselbe Sicherheitsüberprüfung kann genutzt werden, um diverse Ressourcen zu schützen. 

Eine Sicherheitsüberprüfung setzt normalerweise Sicherheitsabfragen ab, auf die der Client in einer bestimmten Weise
antworten muss, um die Prüfung zu bestehen. Dieser Handshake erfolgt im Rahmen des
OAuth-Ablaufs für die Anforderung eines Zugriffstokens. Der Client verwendet **Abfrage-Handler** für die Behandlung von Abfragen der Sicherheitsüberprüfungen. 

#### Integrierte Sicherheitsüberprüfungen
{: #built-in-security-checks }

Die folgenden vordefinierten Sicherheitsüberprüfungen sind verfügbar: 

- [Anwendungsauthentizität](application-authenticity/)
- [LTPA-basiertes Single Sign-on (SSO)](ltpa-security-check/)
- [Direkte Aktualisierung](../application-development/direct-update)

### Abfrage-Handler
{: #challenge-handlers }
Wenn der Client versucht, auf eine geschützte Ressource zuzugreifen, kann er eine Abfrage erhalten. Bei dieser Abfrage kann es sich um eine Frage, einen
Sicherheitstest oder eine Eingabeaufforderung des Servers handeln. Mit der Abfrage soll sichergestellt werden, dass der Client berechtigt ist, auf diese Ressource zuzugreifen. In den meisten Fällen werden im Rahmen der Abfrage Berechtigungsnachweise angefordert, z. B. ein Benutzername und ein Kennwort. 

Ein Abfrage-Handler ist
eine clientseitige Entität, die die clientseitige Sicherheitslogik und die zugehörigen Benutzerinteraktionen implementiert. **Wichtiger Hinweis**: Eine erhaltene Abfrage kann nicht ignoriert werden. Sie muss beantwortet werden oder der laufende Vorgang
muss abgebrochen werden. Das Ignorieren einer Abfrage kann zu nicht erwartetem Verhalten führen. 

> Weitere Informationen zu Sicherheitsüberprüfungen enthält das Lernprogramm [Sicherheitsüberprüfungen erstellen](creating-a-security-check/). Weitere
Informationen zu Abfrage-Handlern finden Sie im Lernprogramm [Berechtigungsnachweise validieren](credentials-validation).


### Bereiche
{: #scopes }

Sie können Ressourcen wie Adapter vor unbefugtem Zugriff schützen, indem Sie den Ressourcen einen **Bereich** zuweisen. 

Ein Bereich ist durch eine Zeichenfolge mit einem oder mehreren, jeweils durch ein Leerzeichen getrennten Bereichselement(en) definiert ("Bereichselement1 Bereichselement2 ...") oder auf null gesetzt, wenn der Standardbereich (`RegisteredClient`) angewendet werden soll. Das {{ site.data.keys.product_adj }}-Sicherheitsframework erfordert für jede Adapterressource ein Zugriffstoken.
Dies gilt auch dann, wenn der Ressource kein Bereich zugewiesen ist, solange nicht der Ressourcenschutz für die Ressource inaktiviert ist (siehe [Adapterressourcen schützen](#protecting-adapter-resources )).

#### Bereichselemente
{: #scope-elements }

Folgendes kann ein Bereichselement sein: 

* Name der Sicherheitsüberprüfung
* Beliebiges Schlüsselwort wie `access-restricted` oder `deletePrivilege`, das
die für diese Ressource erforderliche Sicherheitsstufe definiert. Dieses Schlüsselwort wird später einer Sicherheitsüberprüfung zugeordnet. 

#### Bereichszuordnung
{: #scope-mapping }

Die **Bereichselemente**, die Sie in Ihren **Bereich** schreiben, werden
standardmäßig einer **Sicherheitsüberprüfung mit demselben Namen** zugeordnet.Wenn Sie beispielsweise eine Sicherheitsüberprüfung mit der Bezeichnung
`PinCodeAttempts` schreiben, können Sie in Ihrem Bereich ein Bereichselement mit eben diesem Namen verwenden. 

Die Bereichszuordnung ermöglicht die Zuordnung von Bereichselementen zu Sicherheitsüberprüfungen. Wenn der Client nach einem Bereichselement fragt, definiert diese Konfiguration,
welche Sicherheitsüberprüfungen durchgeführt werden sollen. Sie können beispielsweise das Bereichselement `access-restricted` Ihrer Sicherheitsprüfung `PinCodeAttempts` zuordnen. 

Die Bereichszuordnung ist hilfreich, wenn der Schutz einer Ressource von der Anwendung abhängig sein soll, die
versucht, auf die Ressource zuzugreifen. Sie können einen Bereich auch einer Liste mit null oder mehr Sicherheitsüberprüfungen zuordnen. 

Beispiel:
scope = `access-restricted deletePrivilege`

* App A: 
  * `access-restricted` ist `PinCodeAttempts` zugeordnet.
  * `deletePrivilege` ist einer leeren Zeichenfolge zugeordnet. 
* App B: 
  * `access-restricted` ist `PinCodeAttempts` zugeordnet.
  * `deletePrivilege` ist `UserLogin` zugeordnet.

> Wenn Sie Ihr Bereichselement einer leeren Zeichenfolge zuordnen, wählen Sie im Popup-Menü **Neue Zuordnung von Bereichselementen hinzufügen** keine Sicherheitsüberprüfung aus.



<img class="gifplayer" alt="Bereichszuordnung" src="scope_mapping.png"/>

Sie können auch die JSON-Konfigurationsdatei der Anwendung manuell bearbeiten und die erforderliche Konfiguration definieren.
Senden Sie dann die Änderungen per Push-Operation zurück an {{ site.data.keys.mf_server }}.

1. Navigieren Sie in eiem **Befehlszeilenfenster** zum Projektstammverzeichnis
und führen Sie den Befehl `mfpdev app pull` aus.
2. Öffnen Sie die Konfigurationsdatei aus dem Ordner **[Projektordner]\mobilefirst**. 
3. Bearbeiten Sie Datei. Definieren Sie eine Eigenschaft `scopeElementMapping` und definieren Sie in dieser Eigenschaft Datenpaare, die jeweils aus dem Namen Ihres ausgewählten Bereichselements
und einer Zeichenfolge mit null oder mehr durch Leerzeichen getrennten
Sicherheitsüberprüfungen besteht, denen das Element zugeordnet wird. Beispiel: 

    ```xml
    "scopeElementMapping": {
        "UserAuth": "UserAuthentication",
        "SSOUserValidation": "LtpaBasedSSO CredentialsValidation"
    }
    ```
4. Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl `mfpdev app push` aus.

> Sie können aktualisierte Konfigurationen auch per Push-Operation auf ferne Server übertragen. Sehen Sie sich dazu das Lernprogramm
[{{ site.data.keys.product_adj }}-Artefakte
über die {{ site.data.keys.mf_cli }} verwalten](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) an.



## Ressourcen schützen
{: #protecting-resources }

Im OAuth-Modell ist eine geschützte Ressource eine Ressource, für die ein Zugriffstoken erforderlich ist. Sie können das {{ site.data.keys.product_adj }}-Sicherheitsframework verwenden, um
von einer Instanz von
{{ site.data.keys.mf_server }}
und von einem externen Server bereitgestellte Ressourcen zu schützen. Für den Schutz einer Ressource weisen Sie ihr einen Bereich zu, der die Berechtigungen definiert, die erforderlich sind, um ein Zugriffstoken
für die Ressource beziehen zu können.


Sie können Ihre Ressourcen auf verschiedenen Wegen schützen: 

### Obligatorischer Anwendungsbereich
{: #mandatory-application-scope }

Auf der Anwendungsebene können Sie einen Bereich definieren, der auf alle von der Anwendung verwendeten Ressourcen angewendet wird. Das Sicherheitsframework führt diese
Überprüfungen (soweit vorhanden) zusätzlich zu den Sicherheitsüberprüfungen des angeforderten Ressourcenbereichs aus. 

**Hinweis:**
* Der obligatorische Anwendungsbereich wird nicht angewendet,
wenn auf eine [ungeschützte Ressource](#unprotected-resources) zugegriffen wird.
* Das Zugriffstoken, das für den Ressourcenbereich ausgestellt wird, enthält nicht den obligatorischen Anwendungsbereich. 

<br/>
Wählen Sie in der **Navigationsseitenleiste** der {{ site.data.keys.mf_console }} im Abschnitt **Anwendungen** Ihre Anwendung und dann das Register
**Sicherheit** aus. Wählen Sie unter
**Obligatorischer Anwendungsbereich** die Option **Zum Bereich hinzufügen** aus.



<img class="gifplayer" alt="Obligatorischer Anwendungsbereich" src="mandatory-application-scope.png"/>

Sie können auch die JSON-Konfigurationsdatei der Anwendung manuell bearbeiten und die erforderliche Konfiguration definieren.
Senden Sie dann die Änderungen per Push-Operation zurück an {{ site.data.keys.mf_server }}.

1.  Navigieren Sie in eiem **Befehlszeilenfenster** zum Projektstammverzeichnis
und führen Sie den Befehl `mfpdev app pull` aus.
2.  Öffnen Sie die Konfigurationsdatei aus dem Ordner **[Projektordner]\mobilefirst**. 
3.  Bearbeiten Sie die Datei. Definieren Sie eine Eigenschaft `mandatoryScope` und
legen Sie als Eigenschaftswert eine Bereichszeichenfolge fest, die Ihre ausgewählten Bereichselemente jeweils mit einem Leerzeichen als Trennzeichen auflistet. Beispiel: 

    ```xml
    "mandatoryScope": "appAuthenticity PincodeValidation"
    ```
4.  Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl `mfpdev app push` aus.

> Sie können aktualisierte Konfigurationen auch per Push-Operation auf ferne Server übertragen. Sehen Sie sich dazu das Lernprogramm
[{{ site.data.keys.product_adj }}-Artefakte
über die {{ site.data.keys.mf_cli }} verwalten](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) an.



### Adapterressourcen schützen
{: #protecting-adapter-resources }

In Ihrem Adapter können Sie den schützenden Bereich für eine Java-Methode, eine JavaScript-Ressourcenprozedur oder eine ganze JavaScript-Ressourcenklasse angeben
(siehe folgende Abschnitte zu [Java](#protecting-java-adapter-resources) und [JavaScript](#protecting-javascript-adapter-resources)). Ein Bereich ist durch eine Zeichenfolge mit einem oder mehreren, jeweils durch ein Leerzeichen getrennten Bereichselement(en) definiert ("Bereichselement1 Bereichselement2 ...") oder auf null gesetzt, wenn der Standardbereich angewendet werden soll (siehe [Bereiche](#scopes)). 

Der {{ site.data.keys.product_adj }}-Standardbereich ist `RegisteredClient`. Dieser Bereich fordert für den Zugriff auf die Ressource ein Zugriffstoken an
und überprüft, ob die Ressourcenanforderung von einer Anwendung stammt, die bei {{ site.data.keys.mf_server }} registriert ist. Dieser Schutz wird immer angewendet, sofern Sie nicht
den [Ressourcenschutz inaktivieren](#disabling-resource-protection). Wenn Sie also keinen Bereich für Ihre Ressource festlegen, ist die Ressource trotzdem geschütztz. 

> <b>Hinweis:</b> `RegisteredClient` ist ein reserviertes {{ site.data.keys.product_adj }}-Schlüsselwort. Definieren Sie keine angepassten Bereichselemente oder Sicherheitsüberprüfungen mit diesem Namen.



#### Java-Adapterressourcen schützen
{: #protecting-java-adapter-resources }

Wenn Sie einer JAX-RS-Methode oder -Klasse einen schützenden Bereich zuweisen möchten, fügen Sie die Annotation `@OAuthSecurity` zur Methoden- oder Klassendeklaration hinzu und setzen Sie das Element `scope` der Annotation auf Ihren bevorzugten Bereich. Ersetzen Sie `IHR_BEREICH` durch eine Zeichenfolge mit einem oder mehreren Bereichselement(en) ("Bereichselement1 Bereichselement2 ..."):
```
@OAuthSecurity(scope = "IHR_BEREICH")
```

Ein Klassenbereich wird auf alle Methoden der Klasse angewendet. Eine Ausnahme bilden Methoden mit eigener Annotation `@OAuthSecurity`. 

<b>Hinweis:</b> Wenn das Element `enabled` der Annotation `@OAuthSecurity` auf `false` gesetzt ist, wird das Element `scope` ignoriert (siehe [Java-Ressourcenschutz inaktivieren](#disabling-java-resource-protection)).

##### Beispiele
{: #java-adapter-resource-protection-examples }

Der folgende Code schützt eine Methode `helloUser` durch einen Bereich, der die Bereichselemente `UserAuthentication` und `Pincode` enthält: 
```java
@GET
@Path("/{username}")
@OAuthSecurity(scope = "UserAuthentication Pincode")
public String helloUser(@PathParam("username") String name){
    ...
}
```

Der folgende Code schützt eine Klasse `WebSphereResources` durch die vordefinierte Sicherheitsprüfung `LtpaBasedSSO`: 
```java
@Path("/users")
@OAuthSecurity(scope = "LtpaBasedSSO")
public class WebSphereResources {
    ...
}
```

#### JavaScript-Adapterressourcen schützen
{: #protecting-javascript-adapter-resources }

Wenn Sie einer JavaScript-Prozedur einen schützenden Bereich zuweisen möchten, setzen Sie in der Datei <b>adapter.xml</b> das Bereichsattribut des Elements &lt;procedure&gt; auf Ihren bevorzugten Bereich. Ersetzen Sie `PROZEDURNAME` durch den Namen Ihrer Prozedur und `IHR_BEREICH` durch eine Zeichenfolge mit einem oder mehreren Bereichselement(en) ("Bereichselement1 Bereichselement2 ..."):
```xml
<procedure name="PROZEDURNAME" scope="IHR_BEREICH">
```

<b>Hinweis:</b> Wenn das Attribut `secured` des Elements &lt;procedure&gt; auf "false" gesetzt ist, wird das Bereichsattribut (`scope`) ignoriert (siehe [JavaScript-Ressourcenschutz inaktivieren](#disabling-javascript-resource-protection)).

#### Beispiel
{: #javascript-adapter-resource-protection-examples }

Der folgende Code schützt eine Prozedur `userName` durch einen Bereich, der die Bereichselemente `UserAuthentication` und `Pincode` enthält: 
```xml
<procedure name="userName" scope="UserAuthentication Pincode">
```

### Ressourcenschutz inaktivieren
{: #disabling-resource-protection }

Sie können den [{{ site.data.keys.product_adj }}-Standardressourcenschutz](#protecting-adapter-resources) für eine bestimmte Java- oder JavaScript-Adapterressource oder für eine ganze Java-Klasse inaktivieren (siehe folgende Abschnitte
[Java](#disabling-java-resource-protection) und [JavaScript](#disabling-javascript-resource-protection)). Wenn der Ressourcenschutz inaktiviert ist,
erfordert das {{ site.data.keys.product_adj }}-Sicherheitsframework kein Token für den Zugriff auf die Ressource (siehe [Ungeschützte Ressourcen](#unprotected-resources)).

#### Java-Ressourcenschutz inaktivieren
{: #disabling-java-resource-protection }

Wenn Sie den OAuth-Schutz für eine Java-Ressourcenmethode oder -Ressourcenklasse vollständig inaktivieren möchten,
fügen Sie die Annotation `@OAuthSecurity` zur Methoden- oder Klassendeklaration hinzu und setzen Sie
das Element `enabled` auf den Wert `false`:
```java
@OAuthSecurity(enabled = false)
```
Der Standardwert des
Annotationselements `enabled` ist
`true`. Wenn das Element `enabled` auf `false` gesetzt ist, wird das Element `scope` ignoriert und die Ressource oder Ressourcenklasse [nicht geschützt](#unprotected-resources).



<b>Hinweis:</b> Wenn Sie einer Methode einer ungeschützten Klasse einen Bereich zuweisen,
wird dieser Methode ungeachtet der Klassenannotation geschützt, solange Sie das Element
`enabled` der Ressourcenannotation nicht auf `false` setzen.

##### Beispiele
{: #disabling-java-resource-protection-examples }

Der folgende Code inaktiviert den Ressourcenschutz für eine Methode `helloUser`: 
```java
    @GET
    @Path("/{username}")
    @OAuthSecurity(enabled = "false")
    public String helloUser(@PathParam("username") String name){
        ...
    }
```

Der folgende Code inaktiviert den Ressourcenschutz für eine Klasse `MyUnprotectedResources`: 
```java
    @Path("/users")
    @OAuthSecurity(enabled = "false")
    public class MyUnprotectedResources {
        ...
    }
```

#### JavaScript-Ressourcenschutz inaktivieren
{: #disabling-javascript-resource-protection }

Wenn Sie den OAuth-Schutz für eine JavaScript-Adapterressource (Prozedur) vollständig inaktivieren möchten,
setzen Sie in der Datei <b>adapter.xml</b> das Attribut `secured` des Elements &lt;procedure&gt; auf `false`:
```xml
<procedure name="procedureName" secured="false">
```

Wenn das Attribut `secured` auf `false` gesetzt ist, wird das Bereichsattribut
(`scope`) ignoriert. Die Ressource ist dementsprechend [ungeschützt](#unprotected-resources).

##### Beispiel
{: #disabling-javascript-resource-protection-examples }

Der folgende Code inaktiviert den Ressourcenschutz für eine Prozedur `userName`: 
```xml
<procedure name="userName" secured="false">
```

### Ungeschützte Ressourcen
{: #unprotected-resources }

Eine ungeschützte Ressource ist eine Ressource, für die kein Zugriffstoken erforderlich ist. Das {{ site.data.keys.product_adj }}-Sicherheitsframework verwaltet nicht den
Zugriff auf ungeschützte Ressourcen und überprüft oder validiert nicht die Identität von Clients, die auf solche Ressourcen zugreifen. Features wie die direkte Aktualisierung, die Blockierung des Gerätezugriffs oder die Inaktivierung einer Anwendung über Fernzugriff werden daher für
ungeschützte Ressourcen nicht unterstützt. 

### Externe Ressourcen schützen
{: #protecting-external-resources }

Zum Schutz externer Ressourcen müssen Sie einen Ressourcenfilter mit Validierungsmodul für Zugriffstoken zum externen Ressourcenserver
hinzufügen.
Das Tokenvalidierungsmodul verwendet den Introspektionsendpunkt des Autorisierungsservers des Sicherheitsframeworks, um
die {{ site.data.keys.product_adj }}-Zugriffstoken zu valisieren, bevor
der OAuth-Clientzugriff auf die Ressourcen gewährt wird. Sie können die [{{ site.data.keys.product_adj }}-REST-API
für die {{ site.data.keys.product_adj }}-Laufzeit verwenden](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_runtime_overview.html?view=kc#rest_runtime_api), um für externe Server ein eigenes Validierungsmodul
für Zugriffstoken zu erstellen.
Sie können aber auch eine der bereitgestellten {{ site.data.keys.product_adj }}-Erweiterungen für den
Schutz externer Java-Ressourcen nutzen. Sehen Sie sich dazu das Lernprogramm [Externe Ressourcen schützen](protecting-external-resources) an. 

## Autorisierungsablauf
{: #authorization-flow }

Die Autorisierung erfolgt in zwei Phasen: 

1. Der Client fordert ein Zugriffstoken an. 
2. Der Client nutzt das Token, um auf eine geschützte Ressource zuzugreifen.


### Zugriffstoken anfordern
{: #obtaining-an-access-token }

In dieser Phase durchläuft der Client **Sicherheitsüberprüfungen**, um ein Zugriffstoken zu erhalten. 

Bevor der Client ein Zugriffstoken anfordert, registriert er sich bei {{ site.data.keys.mf_server }}. Bei der Registrierung stellt der Client einen öffentlichen Schlüssel bereit, der für die Authentifizierung der Clientidentität
verwendet wird. Diese Phase gibt es während der gesamten Lebensdauer einer mobilen Anwendungsinstanz nur einmal. Wenn die Sicherheitsüberprüfung der Anwendungsauthentizität
aktiviert ist, wird die Authentizität der Anwendung während ihrer Registrierung
validiert. 

![Token anfordern](auth-flow-1.jpg)

1.  Die Clientanwendung sendet eine Anforderung, um ein Zugriffstoken für einen angegebenen Bereich zu erhalten. 

    > Der Client fordert ein Zugriffstoken mit einem bestimmten Bereich an. Der angeforderte Bereich muss derselben
Sicherheitsüberprüfung zugeordnet sein wie der Bereich der geschützten Ressource, auf die der Client zugreifen möchte. Darüber hinaus kann der angeforderte Bereich
weiteren Sicherheitsüberprüfungen zugeordnet sein. Wenn der Client den Bereich der geschützten Ressource nicht kennt, kann er zunächst ein Zugriffstoken mit einem leeren Bereich anfordern.
Versucht er, mit dem empfangenen Token auf die Ressource zuzugreifen, empfängt er eine Antwort mit einem Fehler
403 (Zugriff verboten) und dem erforderlichen Bereich für die angeforderte Ressource. 

2.  Die Clientanwendung durchläuft die im angeforderten Bereich vorgesehenen
Sicherheitsüberprüfungen. 

    > {{ site.data.keys.mf_server }} führt
die Sicherheitsüberprüfungen aus, denen der Bereich aus der Clientanforderung zugeordnet ist. Ausgehend vom Ergebnis dieser Überprüfung entspricht der
Autorisierungsserver der Anforderung des Clients oder weist diese Anforderung zurück. Wenn ein obligatorischer Anwendungsbereich definiert ist,
werden die Sicherheitsüberprüfungen nicht nur für den Bereich aus der Anforderung, sondern auch für den obligatorischen Bereich
durchgeführt. 

3.  Nach erfolgreichem Abschluss des Abfrageprozesses leitet die Clientanwendung die Anforderung an den Autorisierungsserver weiter. 

    > Nach erfolgreicher Autorisierung wird der Client zum Tokenendpunkt des Autorisierungsservers umgeleitet, wo er mithilfe des öffentlichen Schlüssels, der bei der Clientregistrierung bereitgestellt wurde, authentifiziert wird. Auf erfolgreicher Authentifizierung stellt der
Autorisierungsserver für den Client ein digital signiertes Zugriffstoken (mit der ID des Clients, dem angeforderten Bereich und der Ablaufzeit des Tokens) aus. 

4.  Die Clientanwendung
empfängt das Zugriffstoken. 

### Token für den Zugriff auf eine geschützte Ressource verwenden
{: #using-a-token-to-access-a-protected-resource }

Sie können die Sicherheit für Ressourcen, die
in {{ site.data.keys.mf_server }} ausgeführt werden (siehe Diagramm), und für Ressourcen,
die auf einem externen Ressourcenserver ausgeführt werden, durchsetzen.
Diesbezügliche Erläuterungen finden sie im Lernprogramm
[Externe Ressourcen mit {{ site.data.keys.mf_server }} authentifizieren](protecting-external-resources/).

Wenn der Client ein Zugriffstoken erhalten hat, hängt er das Token
an alle neue Zugriffsanforderungen für geschützte Ressourcen an. Der Ressourcenserver verwendet den
Introspektionsendpunkt des Autorisierungsservers, um das Token zu validieren. Für die Validierung wird die digitale Signatur des Tokens verwendet, um die Client-ID zu verfizieren. Außerdem wird während der Validierung
geprüft, ob der Bereich mit dem aus der autorisierten Anforderung übereinstimmt. Zudem wird sichergestellt, dass das Token nicht abgelaufen ist. Wenn das Token validiert ist,
wird dem Client der Zugriff auf die Ressource gewährt. 

![Ressourcen schützen](auth-flow-2.jpg)

1. Die Clientanwendung sendet eine Anforderung mit dem empfangenen Token. 
2. Das Validierungsmodul validiert das Token. 
3. {{ site.data.keys.mf_server }} fährt mit dem Adapteraufruf fort. 

## Nächste Lernprogramme
{: #tutorials-to-follow-next }

In der Seitenleistennavigation können Sie
Lernprogramme auswählen, um sich näher mit der Authentifizierung in der {{ site.data.keys.product_adj }} Foundation zu beschäftigen. 
