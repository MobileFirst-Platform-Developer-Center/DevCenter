---
layout: tutorial
title: Neuerungen
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
In {{ site.data.keys.product_full }} Version 8.0 gibt es wesentliche Änderungen für eine zeitgemäße Entwicklung, Implementierung und Verwaltung Ihrer {{ site.data.keys.product_adj }}-Anwendungen.

<div class="panel-group accordion" id="release-notes" role="tablist" aria-multiselectable="true">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">Neuerungen bei der Erstellung von Apps</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>Das SDK und die Benutzerschnittstelle der {{ site.data.keys.product }} wurden überarbeitet, damit Sie Ihre Apps noch flexibler und effizienter entwickeln können. Bei der Entwicklung plattformübergreifender Apps können Sie jetzt außerdem Ihre bevorzugten Cordova-Tools verwenden.</p>

                <p>In den folgenden Abschnitten erfahren Sie, was sich bei der Entwicklung Ihrer Apps geändert hat.</p>

                <h3>Neuer Entwicklungs- und Implementierungsprozess</h3>
                <p>Sie erstellen keine Projekt-WAR-Datei mehr, die im Anwendungsserver installiert werden muss. Stattdessen wird {{ site.data.keys.mf_server }} einmalig installiert, und Sie laden dann die serverseitige Konfiguration für Ihre Apps, für Ressourcensicherheit oder für den Push-Service auf den Server hoch. Sie können die Konfiguration Ihrer Apps in der {{ site.data.keys.mf_console }} modifizieren.</p>

                <p>{{ site.data.keys.product_adj }}-Projekte gibt es nicht mehr. Sie entwickeln Ihre mbile App nun in der Entwicklungsumgebung Ihrer Wahl.<br/>
                Sie können dafür die serverseitige Konfiguration Ihrer Apps und Adapter modifizieren, ohne {{ site.data.keys.mf_server }} zu stoppen.</p>

                <ul>
                    <li>Weitere Informationen zum neuen Entwicklungsprozess finden Sie unter <a href="../../../application-development/">Entwicklungskonzepte und -übersicht</a>.</li>
                    <li>Weitere Informationen zur Migration vorhandener Anwendungen finden Sie im <a href="../../../upgrading/migration-cookbook">Cookbook zur Migration</a>.</li>
                    <li>Weitere Informationen zur Verwaltung von {{ site.data.keys.product_adj }}-Anwendungen finden Sie unter "{{ site.data.keys.product_adj }}-Anwendungen verwalten".</li>
                </ul>

                <h3>Webanwendungen</h3>
                <p>Die clientseitige {{ site.data.keys.product_adj }}-JavaScript-API gibt Ihnen die Möglichkeit, mit Ihren bevorzugten Tools und Ihrer bevorzugten IDE Webanwendungen zu entwickeln. Sie können Ihre Webanwendung bei {{ site.data.keys.mf_server }} registrieren, um Sicherheitsfunktionen zur Anwendung hinzuzufügen.</p>

                <p>Sie können auch die neue clientseitige JavaScript-API für Webanalysen nutzen, um Funktionen von {{ site.data.keys.mf_analytics }} zu Ihrer Webanwendung hinzuzufügen. Die API wird mit dem neuen Web-SDK bereitgestellt.</p>

                <h3>Plattformübergreifende Apps mit bevorzugten Cordova-Tools entwickeln</h3>
                <p>Sie können für die Entwicklung Ihrer plattformübergreifenden Hybrid-Apps Ihre bevorzugten Cordova-Tools (z. B. Apache Cordova CLI oder Ionic Framework) verwenden. Diese Tools müssen Sie sich unabhängig von der {{ site.data.keys.product }} beschaffen und dann {{ site.data.keys.product_adj }}-Plug-ins hinzufügen, damit die {{ site.data.keys.product_adj }}-Back-End-Funktionalität bereitgestellt wird.</p>

                <p>Sie können das Studio-Eclipse-Plugin der {{ site.data.keys.product }} installieren, um Ihre plattformübergreifenden Cordova-Apps der {{ site.data.keys.product }} in der Eclipse-Entwicklungsumgebung zu verwalten. Das Studio-Plug-in der {{ site.data.keys.product }} Studio bietet zusätzliche Befehle der {{ site.data.keys.mf_cli }} an, die Sie in der Eclipse-Umgebung ausführen können.</p>

                <h3>SDK-Aufteilung in Komponenten</h3>
                <p>Bisher wurde das {{ site.data.keys.product_adj }}-Client-SDK als ein Framework oder eine JAR-Datei bereitgestellt. Jetzt können Sie wählen, welche konkreten Funktionen Sie einbeziehen oder ausschließen möchten. Für jede {{ site.data.keys.product_adj }}-API gibt es neben dem zentralen SDK eigene optionale Komponenten.</p>

                <h3>Neue, verbesserte Befehlszeilenschnittstelle (CLI) für Entwicklung</h3>
                <p>Die {{ site.data.keys.mf_cli }} wurde überarbeitet, damit Sie noch effienter entwickeln können, und kann jetzt auch in automatisierten Scripts genutzt wreden. Befehle beginnen jetzt mit dem Präfix mfpdev. Die CLI ist Bestandteil des {{ site.data.keys.mf_dev_kit_full }}. Sie können aber auch schnell die neueste Version der CLI mit npm herunterladen.</p>

                <h3>Unterstützungstool für die Migration</h3>
                <p>Das Unterstützungstool für die Migration vereinfacht die Migration Ihrer vorhandenen Apps auf {{ site.data.keys.product }} Version 8.0. Das Tool scannt Ihre vorhandenen {{ site.data.keys.product_adj }}-Apps und erstellt eine Liste der verwendeten APIs, die in Version 8.0 entfernt oder ersetzt wurden oder nicht weiter unterstützt werden. Wenn Sie das Unterstützungstool für die Migration für Apache-Cordova-Anwendungen, die mit der {{ site.data.keys.product }} erstellt wurden, ausführen, erstellt das Tool für diese Anwendungen eine neue Cordova-Struktur, die mit Version 8.0 kompatibel ist.</p>

                <h3>Crosswalk WebView in Cordova</h3>
                <p>Ab Cordova 4.0 kann das die Standardweblaufzeit durch das WebView-Plug-in ersetzt werden. Crosswalk wird jetzt von Cordova-Anwendungen mit {{ site.data.keys.product }} unterstützt. Die Verwendung von Crosswalk WebView für Android ermöglicht auf einer Vielzahl mobiler Geräte eine hohe Leistung und eine konsistente Benutzererfahrung. Wenn Sie von den Crosswalk-Funktionen profitieren möchten, wenden Sie das Cordova-Crosswalk-Plug-in an.</p>

                <h3>SDK der {{ site.data.keys.product_adj }} für universelle Windows-8- und Windows-10-Apps mit NuGet verteilen</h3>
                <p>Das SDK der {{ site.data.keys.product_adj }} für universelle Windows-8- und Windows-10-Apps ist in NuGet unter <a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a> verfügbar.</p>

                <h3>org.apache.http durch okHttp ersetzt</h3>
                <p><code>org.apache.http</code> wurde aus dem Android-SDK entfernt. Als HTTP-Abhängigkeit wird jetzt okHttp verwendet.</p>

                <h3>WKWebView-Unterstützung für Cordova-Hybrid-Apps für iOS</h3>
                <p>Sie können jetzt das standardmäßige UIWebView in Cordova-Apps durch WKWebView ersetzen.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">Neuerungen bei MobileFirst-APIs</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>Die APIs, die Sie für die Entwicklung mobiler Anwendungen nutzen können, wurden mit neuen Features verbessert und erweitert. Nutzen Sie die neuesten APIs, um von neuen, verbesserten oder geänderten Funktionen der {{ site.data.keys.product }} profitieren zu können.</p>

                <h3>Aktualisierte serverseitige JavaScript-API</h3>
                <p>Back-End-Aufruffunktionen werden nur für bestimmte Adaptertypen unterstützt. Zurzeit sind dies HTTP- und SQL-Adapter. Die Back-End-Aufrufer <code>WL.Server.invokeHttp</code> und <code>WL.Server.invokeSQL</code> werden somit auch unterstützt.</p>

                <h3>Neue serverseitige Java-API</h3>
                <p>Eine neue serverseitige API steht bereit, mit der Sie {{ site.data.keys.mf_server }} erweitern können.</p>

                <h4>Neue serverseitige Java-API für Sicherheit</h4>
                <p>Das neue Sicherheits-API-Paket <code>com.ibm.mfp.server.security.external</code> und die darin enthaltenen Pakete beinhalten die Schnittstellen, die benötigt werden, um Sicherheitsüberprüfungen und Adapter zu entwickeln, die den Kontext der Sicherheitsüberprüfung verwenden.</p>

                <h4>Neue serverseitige Java-API für Clientregistrierungsdaten</h4>
                <p>Das neue API-Paket für Clientregistrierungsdaten <code>com.ibm.mfp.server.registration.external</code> und die darin enthaltenen Pakete beinhalten eine Schnittstelle für den Zugriff auf persistente {{ site.data.keys.product_adj }}-Clientregistrierungsdaten.</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>Mit dieser neuen API können Sie die JAX-RS-Anwendung für den Adapter zurückgeben.</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>Mit dieser neuen API können Sie den Wert von der Adapterkonfiguration (oder den Standardwert) abrufen.</p>

                <h3>Aktualisierte serverseitige Java-API</h3>
                <p>Eine aktualisierte serverseitige API steht bereit, mit der Sie {{ site.data.keys.mf_server }} erweitern können.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>Die Signatur dieser neuen API hat sich in dieser Version nicht geändert. Das Verhalten dieser API ist jetzt jedoch mit dem der unter "Neue serverseitige Java-API" beschriebenen API <code>String getPropertyValue (String propertyName)</code> identisch.</p>

                <h4>WLServerAPIProvider</h4>
                <p>In den Versionen 7.0.0 und 7.1.0 wurde über die Schnittstelle WLServerAPIProvider auf die Java-API zugegriffen, z. B. mit <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> und <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code>.</p>

                <p>Diese statischen Schnittstellen werden weiter unterstützt, damit in Vorgängerversionen des Produkts entwickelte Adapter kompiliert und implementiert werden können. Alte Adapter, die weder Push-Benachrichtigungen noch die bisherige Sicherheits-API verwenden, funktionieren in der neuen Version weiter. Adapter, die Push-Benachrichtigungen oder die Sicherheits-API verwenden, funktionieren nicht mehr.</p>

                <h3>Clientseitige <tm trademark="JavaScript" tmtype="tm">JavaScript</tm>-APIs für Webanwendungen</h3>
                <p>Die für die Entwicklung plattformübergreifender Cordova-Anwendungen verwendete, clientseitige JavaScript-API ist jetzt mit geringfügigen Variationen bei der Initialisierungsmethode auch für die Entwicklung von Webanwendungen verfügbar. Beachten Sie, dass nicht alle Funktionen der JavaScript-API auf Webanwendungen angewendet werden können.</p>

                <p>Zusätzlich gibt es eine neue clientseitige JavaScript-API für Webanalysen, über die Funktionen von {{ site.data.keys.mf_analytics }} zu Ihrer Webanwendung hinzugefügt werden können.</p>

                <h3>Aktualisierte clientseitige C#-API für Windows 8 Universal und Windows Phone 8 Universal</h3>
                <p>Die clientseitige C#-API für Windows 8 Universal und Windows Phone 8 Universal wurde geändert.</p>

                <h3>Neue clientseitige Java-APIs für Android</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>Mit dieser neuen Methode können Sie aus den Registrierungsdaten von {{ site.data.keys.mf_server }} den Anzeigenamen eines Geräts abrufen.</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>Mit dieser neuen Methode können Sie den Anzeigenamen eines Geräts in den Registrierungsdaten von {{ site.data.keys.mf_server }} festlegen.</p>

                <h3>Neue clientseitige Objective-C-APIs für iOS</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>Mit dieser neuen Methode können Sie aus den Registrierungsdaten von {{ site.data.keys.mf_server }} den Anzeigenamen eines Geräts abrufen.</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>Mit dieser neuen Methode können Sie den Anzeigenamen eines Geräts in den Registrierungsdaten von {{ site.data.keys.mf_server }} festlegen.</p>

                <h3>Aktualisierte REST-API für den Verwaltungsservice</h3>
                <p>Die REST-API für den Verwaltungsservice wurde teilweise refaktoriert. Namentlich wurde die API für Beacons und Madiatoren entfernt. Die meisten REST-Services für Push-Benachrichtigungren sind jetzt Teil der REST-API für den Push-Service.</p>

                <h3>Aktualisierte REST-API für die Laufzeit</h3>
                <p>Die REST-API für die {{ site.data.keys.product_adj }}-Laufzeit stellt jetzt diverse Services bereit, mit denen mobile und vertrauliche Clients Adapter aufrufen, Zugriffstoken anfordern, Inhalte der direkten Aktualisierung abrufen können und vieles mehr. Die meisten REST-API-Endpunkte werden mit OAuth geschützt. Auf einem Entwicklungsserver können Sie das Swagger-Dokument zur Laufzeit-API unter <code>http(s)://Server-IP-Adresse:Server-Port/Kontextstammverzeichnis/doc</code> anzeigen.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">Neuerungen bei der MobileFirst-Sicherheit</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>Das Sicherheitsframework der {{ site.data.keys.product }} wurde komplett überarbeitet. Neue Sicherheitseinrichtungen wurden aufgenommen und an vorhandenen Features wurden einige Änderungen vorgenommen.</p>

                <h3>Modernisierung des Sicherheitsframeworks</h3>
                <p>Das {{ site.data.keys.product_adj }}-Sicherheitsframework wurde neu gestaltet und reimplementiert, um die Aufgaben der Sicherheitsentwicklung und -verwaltung zu verbessern und zu vereinfachen. Das Framework basiert jetzt ausschließlich auf dem OAuth-Modell. Die Implementierung ist sitzungsunabhängig (siehe "Übersicht über das {{ site.data.keys.product_adj }}-Sicherheitsframework").</p>

                <p>Auf der Serverseite wurden die verschiedenen Komponenten des Frameworks durch (in Adaptern implementierte) Sicherheitsüberprüfungen ersetzt, wodurch die Entwicklung mit neuen APIs vereinfacht wird. Beispielimplementierungen und vordefinierte Sicherheitsüberprüfungen werden zur Verfügung gestellt (siehe "Sicherheitsüberprüfungen"). Sicherheitsüberprüfungen können im Adapterdeskriptor konfiguriert und durch Änderungen an der Adapter- oder Anwendungskonfiguration zur Laufzeit angepasst werden, ohne dass der Adapter neu implementiert werden muss oder der Verarbeitungsablauf unterbrochen wird. Die Konfigurationsschritte können mithilfe der überarbeiteten Sicherheitsschnittstellen der {{ site.data.keys.mf_console }} ausgeführt werden. Sie können die Konfigurationsdateien auch manuell bearbeiten oder die {{ site.data.keys.mf_cli }} bzw. die mfpadm-Tools verwenden.</p>

                <h3>Sicherheitsüberprüfung für die Anwendungsauthentizität</h3>
                <p>Die Validierung der {{ site.data.keys.product_adj }}-Anwendungsauthentizität ist jetzt als vordefinierte Sicherheitsprüfung implementiert, die die bisherige Überprüfung der erweiterten Anwendungsauthentizität ersetzt. Sie können die Validierung der Anwendungsauthentizität in der {{ site.data.keys.mf_console }} oder mit mfpadm dynamisch aktivieren, inaktivieren und konfigurieren. Zum Generieren einer Anwendungsauthentizitätsdatei wird ein eigenständiges Java-Tool für die {{ site.data.keys.product_adj }}-Anwendungsauthentizität (mfp-app-authenticity-tool.jar) bereitgestellt.</p>

                <h3>Vertrauliche Clients</h3>
                <p>Die Unterstützung für vertrauliche Clients wurde überarbeitet und mit dem neuen OAuth-Sicherheitsframework reimplementiert.</p>

                <h3>Sicherheit von Webanwendungen</h3>
                <p>Das überarbeitete, OAuth-basierte Sicherheitsframework unterstützt Webanwendungen. Sie können jetzt Webanwendungen bei {{ site.data.keys.mf_server }} registrieren, um Sicherheitsfunktionen zu Ihrer Anwendung hinzuzufügen und Ihre Webressourcen vor unbefugtem Zugriff zu schützen. Weitere Informationen zur Entwicklung von {{ site.data.keys.product_adj }}-Webanwendungen finden Sie unter "Webanwendungen entwickeln". Die Sicherheitsüberprüfung der Anwendungsauthentizität wird nicht für Webanwendungen unterstützt.</p>

                <h3>Neue und geänderte Sicherheitsfunktionen für plattformübergreifende Anwendungen (Cordova-Apps)</h3>
                <p>Es stehen zusätzliche Sicherheitsfeatures zum Schutz Ihrer Cordova-App zur Verfügung. Zu diesen Features gehören unter anderem:</p>

                <ul>
                    <li>Verschlüsselung von Webressourcen: Verwenden Sie dieses Feature, um Webressourcen in Ihrem Cordova-Paket zu verschlüsseln, sodass niemand das Paket modifizieren kann.</li>
                    <li>Kontrollsumme für Webressourcen: Verwenden Sie dieses Feature, um einen Kontrollsummentest durchzuführen, der die aktuellen statistischen Daten der App-Webressourcen mit den statistischen Referenzdaten vergleicht, die beim ersten Öffnen der App erstellt wurden. Durch diese Überprüfung können Sie verhinerdern, dass die App nach der Installation und dem Öffnen modifiziert wird.</li>
                    <li>Certificate Pinning: Verwenden Sie dieses Feature, um das Zertifikat einer App einem Zertifikat auf dem Host-Server zuzuordnen. Mit diesem Feature können Sie verhindern, dass zwischen der App und dem Server ausgetauschte Informationen gesehen oder modifiziert werden.</li>
                    <li>Unterstützung für FIPS 140-2 (Federal Information Processing Standard): Verwenden Sie dieses Feature, um sicherzustellen, dass übertragene Daten mit dem Verschlüsselungsstandard FIPS 140-2 entsprechen.</li>
                    <li>OpenSSL: Wenn Sie OpenSSL für die Ver- und Entschlüsselung von Daten Ihrer Cordova-App für die iOS-Plattform verwenden möchten, können Sie das Cordova-Plug-in cordova-plugin-mfp-encrypt-utils nutzen.</li>
                </ul>

                <h3>Geräte-Single-Sign-on</h3>
                <p>Das Geräte-Single-Sign-on wird jetzt über die neue Konfigurationseigenschaft <code>enableSSO</code> für die Sicherheitsüberprüfung im Anwendungsdeskriptor unterstützt.</p>

                <h3>Direkte Aktualisierung</h3>
                <p>Im Gegensatz zur älteren MobileFirst-Versionen gilt ab Version 8.0 Folgendes:</p>

                <ul>
                    <li>Wenn eine Clientanwendung auf eine ungeschützte Ressource zugreift, empfängt sie keine Aktualisierungen, auch wenn in {{ site.data.keys.mf_server }} Aktualisierungen verfügbar sind.</li>
                    <li>Die direkte Aktualisierung wird nach ihrer Aktivierung bei jeder Anforderung einer geschützten Ressource durchgesetzt.</li>
                </ul>

                <h3>Schutz externer Ressourcen</h3>
                <p>Die unterstützte Methode und die bereitgestellten Artefakte für den Schutz von Ressourcen auf externen Servern wurden modifiziert.</p>

                <ul>
                    <li>Eine neues Validierungsmodul für Zugriffstoken (der {{ site.data.keys.product_adj }}-Java-Token-Validator) wird bereitgestellt, sodass das {{ site.data.keys.product_adj }}-Sicherheitsframework für den Schutz von Ressourcen auf jedem externen Java-Server eingesetzt werden kann. Das Modul wird als Java-Bibliothek (mfp-java-token-validator-8.0.0.jar) bereitgestellt und ersetzt den veralteten MobileFirst-Server-Endpunkt für Tokenvalidierung bei der Erstellung eines angepassten Java-Validierungsmoduls.</li>
                    <li>Der {{ site.data.keys.product_adj }}-OAuth-TAI-Filter für den Schutz von Java-Ressourcen auf einem externen Server mit WebSphere Application Server oder  WebSphere Application Server Liberty wird jetzt als Java-Bibliothek (com.ibm.imf.oauth.common_8.0.0.jar) bereitgestellt. Die Bibliothek verwendet das neue Validierungsmodul (den neuen Java-Token-Validator). Die Konfiguration des bereitgestellten TAI ist auch eine andere.</li>
                    <li>Die serverseitige API für den {{ site.data.keys.product_adj }}-OAuth-TAI ist nicht mehr erforderlich und wurde entfernt.</li>
                    <li>Das {{ site.data.keys.product_adj }}-Node.js-Framework passport-mfp-token-validation für den Schutz von Java-Ressourcen auf einem externen Node.js-Server wurde so modifiziert, dass es das neue Sicherheitsframework unterstützt.</li>
                    <li>Sie können auch einen eingenen Filter und ein eigenes Validierungsmodul für Ressourcenserver schreiben, der bzw. das den neuen Introspektionsendpunkt des Autorisierungsservers nutzt.</li>
                </ul>

                <h3>Integration von WebSphere DataPower als Autorisierungsserver</h3>
                <p>Sie können jetzt anstelle des Standardautorisierungsservers ({{ site.data.keys.mf_server }}) WebSphere DataPower als OAuth-Autorisierungsserver auswählen. Sie können DataPower für die Integration in das {{ site.data.keys.product_adj }}-Sicherheitsframework konfigurieren.</p>

                <h3>Sicherheitsüberprüfung für LTPA-basiertes Single Sign-on</h3>
                <p>Die serverübergreifende Benutzerauthentifizierung für Server, die die WebSphere-LTPA-Authentifizierung verwenden, wird jetzt über die neue vordefinierte Sicherheitsüberprüfung für LTPA-basiertes Single-Sign-on unterstützt. Diese Überprüfung ersetzt das veraltete {{ site.data.keys.product_adj }}-LTPA-Realm und macht die zuvor erforderliche Konfiguration überflüssig.</p>

                <h3>Verwaltung mobiler Anwendungen in der {{ site.data.keys.mf_console }}</h3>
                <p>Es wurden einige Änderungen vorgenommen, um Unterstützung für die Verfolgung und Verwaltung von mobilen Anwendungen, Benutzern und Geräten über die {{ site.data.keys.mf_console }} zu ermöglichen. Ein Gerät oder der Anwendungszugriff kann nur blockiert werden, wenn versucht wird, auf geschützte Ressourcen zuzugreifen.</p>

                <h3>MobileFirst-Server-Keystore</h3>
                <p>Zum Signieren von OAuth-Token und von Paketen für die direkte Aktualisierung sowie für die gegenseitige HTTPS-Authentifizierung (SSL) wird ein einzelner MobileFirst-Server-Keystore verwendet. Sie können diesen Keystore in der {{ site.data.keys.mf_console }} oder mit mfpadm dynamisch konfigurieren.</p>

                <h3>Native Verschlüsselung/Entschlüsselung für iOS</h3>
                <p>OpenSSL wurde aus dem Hauptframework für iOS entfernt und durch eine native Verschlüsselung/Entschlüsselung ersetzt. Sie können OpenSSL als gesondertes Framework hinzufügen (siehe "OpenSSL für iOS aktivieren"). Für die Cordova-JavaScript-Entwicklung für iOS ist OpenSSL noch in das Framework integriert. Für beide APIs ist sowohl die native als auch die OpenSSL-Verschlüsselung verfügbar.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">Neuerungen bei der Betriebssystemunterstützung</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>Die {{ site.data.keys.product }} bietet jetzt Unterstützung für universelle Windows-10-Apps, Bitcode-Builds und Apple watchOS 2.</p>

                <h3>Unterstützung für native, universelle Windows-10-Anwendungen</h3>
                <p>In der {{ site.data.keys.product }} können Sie jetzt native C#-Anwendungen für die universelle App-Plattform schreiben, bei denen das SDK der {{ site.data.keys.product_adj }} innerhalb der App verwendet wird.</p>

                <h3>Unterstützung für Windows-Hybridumgebungen</h3>
                <p>Windows 10 UWP (universelle Windows-Plattform) wird für Windows-Hybridumgebungen unterstützt.</p>

                <h3>Ende der Unterstützung für BlackBerry</h3>
                <p>Die BlackBerry-Umgebung wird in der {{ site.data.keys.product }} nicht mehr unterstützt.</p>

                <h3>Bitcode</h3>
                <p>Bitcode-Builds werden jetzt für iOS-Projekte unterstützt. Für Apps, die mit Bitcode erstellte wurden, wird jedochnicht die Sicherheitsüberprüfung der {{ site.data.keys.product_adj }}-Anwendungsauthentizität unterstützt.</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 wird jetzt unterstützt und erfordert Bitcode-Builds.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">Neuerungen bei der Implementierung und Verwaltung von Apps</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-deploy-manage-apps">
            <div class="panel-body">
                <p>In die {{ site.data.keys.product }} wurden neue Leistungsmerkmale integriert, die Sie bei der Implementierung und Verwaltung Ihrer Apps unterstützen sollen. Sie können Ihre Apps und Adapter jetzt aktualisieren, ohne {{ site.data.keys.mf_server }} neu zu starten.</p>

                <h3>Verbesserte DevOps-Unterstützung</h3>
                <p>{{ site.data.keys.mf_server }} wurde grundlegend überarbeitet, um Ihre DevOps-Umgebung besser unterstützen zu können. {{ site.data.keys.mf_server }} wird einmal in Ihrer Anwendungsserverumgebung installiert, und wenn Sie eine Anwendung hochladen oder die Konfiguration von {{ site.data.keys.mf_server }} ändern, muss die Konfiguration des Anwendungsservers nicht geändert werden.</p>

                <p>Sie müssen {{ site.data.keys.mf_server }} nicht neu starten, wenn Sie Ihre Apps oder Adapter, von denen Ihre Apps abhängig sind, aktualisieren. Sie können Konfigurationsaufgaben ausführen oder eine neue Version eines Adapters hochladen oder eine neue Anwendung registrieren, während sich der Server weiter um den Datenverkehr kümmert.</p>

                <p>Konfigurationsänderungen und die Entwicklung sind Bereiche, die mit Sicherheitsrollen geschützt sind.</p>

                <p>Für das Hochladen von Entwicklungsartefakten auf den Server gibt es verschiedene Möglichkeiten, die Ihnen mehr Flexibilität beim Arbeiten ermöglichen sollen.</p>

                <ul>
                    <li>Die {{ site.data.keys.mf_console }} wurde erweitert. Jetzt können Sie in der Konsole eine Anwendung oder eine neue Version einer Anwendung registrieren, App-Sicherheitsparameter verwalten, Zertifikate implementieren, Tags für Push-Benachrichtigungen erstellen und Push-Benachrichtigungen senden. Außerdem bietet die Konsole jetzt eine Kontexthilfe an.</li>
                    <li>Befehlszeilentool</li>
                </ul>

                <p>Zu den Entwicklungsartefakten, die Sie auf den Server hochladen, gehören Adapter und ihre Konfiguration, Sicherheitskonfigurationen für Ihre Apps, Zertifikate für Push-Benachrichtigungen und Protokollfilter.</p>

                <h3>In IBM Bluemix erstellte Anwendungen in der {{ site.data.keys.product }} ausführen</h3>
                <p>Entwickler können IBM Bluemix-Anwendungen für die Ausführung in der {{ site.data.keys.product }} umstellen. Dafür muss Ihre Clientanwendung geändert und an die APIs der {{ site.data.keys.product }} angeglichen werden.</p>

                <h3>{{ site.data.keys.product }} als Service in IBM Bluemix</h3>
                <p>Sie können jetzt den Service {{ site.data.keys.mf_bm_full }}  in IBM Bluemix verwenden, um Ihre mobilen Unternehmens-Apps zu erstellen und auszuführen.</p>

                <h3>Keine .wlapp-Dateien</h3>
                <p>In den Vorgängerversionen wurden Anwendungen implementiert, indem eine <b>.wlapp</b>-Datei auf den {{ site.data.keys.mf_server }} hochgeladen wurde. Die Datei enthielt beschreibende Daten für die Anwendung und im Falle von Hybridanwendungen auch die erforderlichen Webressourcen. In Version 8.0.0 verwenden Sie keine <b>.wlapp</b>-Datei. Stattdessen gehen Sie wie folgt vor:</p>

                <ul>
                    <li>Sie registrieren eine App bei {{ site.data.keys.mf_server }}, indem Sie eine JSON-Anwendungsdeskriptordatei implementieren.</li>
                    <li>Für die direkte Aktualisierung einer Cordova-Anewndung laden Sie eine Archivdatei (ZIP-Datei) mit den modifizierten Webressourcen auf den Server hoch. Die Archivdatei enthält nicht mehr die Webvorschaudateien oder Oberflächen, wie es in den Vorgängerversionen der {{ site.data.keys.product }} möglich war. Das Archiv enthält jetzt nur noch die Webressourcen, die an die Clients gesendet werden, sowie Kontrollsummen für die Validierung der direkten Aktualisierung.</li>
                </ul>

                <p>Wenn Sie für Cordova-Client-Apps, die auf Endbenutzergeräten installiert sind, die direkte Aktualisierung aktivieren möchten, müssen Sie die modifizierten Webressourcen jetzt als Archiv (.zip-Datei) im Server implementieren. Für eine sichere direkte Aktualisierung muss eine benutzerdefinierte Keystore-Datei in {{ site.data.keys.mf_server }} implementiert werden. Außerdem muss in die implementierte Clientanwendung eine Kopie des passenden öffentlichen Schlüssels aufgenommen werden.</p>

                <h3>Adapter</h3>
                <h4>Adapter sind Apache-Maven-Projekte.</h4>
                <p>Adapter werden jetzt als Maven-Projekte behandelt. Sie können Adapter mit Standardbefehlen der Maven-Befehlszeile erstellen und implementieren oder mit einer IDE, die Maven unterstützt, z. B. mit Eclipse oder IntelliJ.</p>

                <h4>Adapterkonfiguration und -entwicklung in DevOps-Umgebungen</h4>
                <ul>
                    <li>MobileFirst-Server-Administratoren können jetzt in der {{ site.data.keys.mf_console }} das Verhalten eines implementierten Adapters modifizieren. Nach einer Rekonfiguration werden die Änderungen sofort im Server wirksam, ohne dass der Adapter neu implementiert oder der Server neu gestartet werden muss.</li>
                    <li>Sie können Adapter jetzt bei laufendem Betrieb implementieren. Es ist also möglich, Adapter in der Laufzeit zu implementieren, zu deimplementieren und erneut zu implementieren, während {{ site.data.keys.mf_server }} weiter Datenverkehrsservices bereitstellt.</li>
                </ul>

                <h4>Änderungen in der Adapterdeskriptordatei</h4>
                <p>Die Deskriptordatei <b>adapter.xml</b> hat sich geringfügig geändert. Weitere Informationen zur Struktur der Deskriptordatei für Adapter enthalten die <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">Adapterlernprogramme</a>.</p>

                <h4>Integration der Swagger-Benutzerschnittstelle</h4>
                <p>In {{ site.data.keys.mf_server }} ist jetzt die Swagger-Benutzerschnittstelle integriert. Sie können für jeden Adapter die zugehörige API anzeigen, indem Sie in der {{ site.data.keys.mf_console }} auf der Registerkarte "Ressourcen" auf "Swagger-Dokumente anzeigen" klicken. Dieses Feature ist nur Entwicklungsumgebungen verfügbar.</p>

                <h4>Unterstützung für JavaScript-Adapter</h4>
                <p>Es werden nur JavaScript-Adapter mit dem Anschlusstyp HTTP oder SQL unterstützt.</p>

                <h4>Unterstützung für JAX-RS 2.0</h4>
                <p>JAX-RS 2.0 stellt neue serverseitige Funktionen bereit, zu denen asynchrones serverseitiges HTTP, Filter und Abfangprozesse gehören. Adapter können diese Features jetzt nutzen.</p>

                <h3>{{ site.data.keys.product }} für IBM Container</h3>
                <p>Die mit Version 8.0 freigegebene {{ site.data.keys.product }} für IBM Container ist auf der Website <a href="http://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage</a> verfügbar. Diese Version der {{ site.data.keys.product }} für IBM Container ist bereit für den Produktionseinsatz und unterstützt den dashDB™-Plan "Enterprise Transactional" von IBM Bluemix.</p>

                <p><b>Hinweis:</b> Informieren Sie sich über die Voraussetzungen für die Implementierung der {{ site.data.keys.product }} in IBM Containern.</p>

                <h3>{{ site.data.keys.mf_server }} in IBM PureApplication System implementieren</h3>
                <p>Sie können {{ site.data.keys.mf_server }} jetzt im unterstützten {{ site.data.keys.product }} System Pattern für IBM PureApplication System implementieren und konfigurieren.</p>

                <p>Alle unterstützten {{ site.data.keys.product }} System Patterns bieten jetzt Unterstützung für eine vorhandene IBM DB2®-Datenbank. Das {{ site.data.keys.mf_app_center_full }} wird jetzt in einem Muster für virtuelle Systeme unterstützt.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">Neuerungen bei {{ site.data.keys.mf_server }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} wurde überarbeitet, damit Sie bei der Entwicklung und Aktualisierung Ihrer Apps Zeit und Kosten sparen können. Neben der Neugestaltung von {{ site.data.keys.mf_server }} wurde die Anzahl der verfügbaren Installationsmethoden für die {{ site.data.keys.product }} erhöht.</p>

                <p>Mit dem neuen Design von {{ site.data.keys.mf_server }} gibt es zwei neue MobileFirst-Server-Komponenten, den Liveaktualisierungsservice und die MobileFirst-Server-Artefakte.</p>

                <p>Der Liveaktualisierungsservice von {{ site.data.keys.mf_server }} soll Ihnen helfen, bei den schrittweisen Aktualisierungen für Ihre Apps Zeit und Kosten zu sparen. Mit dem Service werden die serverseitigen Konfigurationsdaten von Apps und Adaptern verwaltet und gespeichert. Sie können verschiedene Abschnitte Ihrer Anwendung ändern oder aktualisieren, ohne dass Sie einen neuen App-Build erstellen oder die App reimplementieren müssen.</p>

                <ul>
                    <li>Sie können das App-Verhalten ausgehend von Benutzersegmenten, die Sie festlegen, dynamisch ändern oder aktualisieren.</li>
                    <li>Sie können die serverseitige Geschäftslogik dynamisch ändern oder aktualisieren.</li>
                    <li>Sie können die App-Sicherheit dynamisch ändern oder aktualisieren.</li>
                    <li>Sie können die App-Konfiguration auslagern und dynamisch ändern.</li>
                </ul>

                <p>MobileFirst-Server-Artefakte stellen Ressourcen für die {{ site.data.keys.mf_console }} bereit.</p>

                <p>Mit der Neugestaltung von {{ site.data.keys.mf_server }} stehen mehr Installationsoptionen zur Verfügung. Zusätzlich zur manuellen Installation gibt es in der {{ site.data.keys.product }}  zwei Installationsoptionen für die Installation von {{ site.data.keys.mf_server }} in einer Server-Farm. Sie können {{ site.data.keys.mf_server }} auch in einem Liberty-Verbund installieren.</p>

                <p>Sie können die Komponenten von {{ site.data.keys.mf_server }} jetzt mit Ant-Tasks oder dem Server Configuration Tool in einer Server-Farm installieren. Weitere Informationen finden Sie in den folgenden Artikeln:</p>

                <ul>
                    <li>Server-Farm installieren</li>
                    <li>Lernprogramme zur Installation von {{ site.data.keys.mf_server }}</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} unterstützt auch einen Liberty-Verbund. Weitere Informationen zur Servertopologie und zu den verschiedenen Installationsmethoden finden Sie in den folgenden Artikeln:</p>

                <ul>
                    <li>Topologie eines Liberty-Verbunds</li>
                    <li>Server Configuration Tool ausführen</li>
                    <li>Installation mit Ant-Tasks</li>
                    <li>Manuelle Installation in einem WebSphere-Application-Server-Liberty-Verbund</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">Neuerungen bei {{ site.data.keys.mf_analytics }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>Die Konsole von {{ site.data.keys.mf_analytics }} wurde überarbeitet und zeichnet sich jetzt durch eine bessere Informationsdarstellung und rollenbasierte Zugriffsteuerelemente aus. Die Konsole ist jetzt auch in mehreren Sprachen verfügbar.</p>

                <p>Bei der Neugestaltung der {{ site.data.keys.mf_analytics_console }} ging es darum, Informationen mehr intuitiv und aussagefähiger anzuzeigen. Für einige Ereignistypen werden in der Konsole zusammengefasste Daten verwendet.</p>

                <p>Sie können sich jetzt durch Klicken auf das Zahnradsymbol bei der {{ site.data.keys.mf_analytics_console }} abmelden.</p>

                <p>Die {{ site.data.keys.mf_analytics_console }} gibt es jetzt in folgenden Sprachen:</p>
                <ul>
                    <li>Deutsch</li>
                    <li>Spanisch</li>
                    <li>Französisch </li>
                    <li>Italienisch</li>
                    <li>Japanisch</li>
                    <li>Koreanisch</li>
                    <li>Brasilianisches Portugiesisch</li>
                    <li>Russisch</li>
                    <li>Vereinfachtes Chinesisch</li>
                    <li>Traditionelles Chinesisch</li>
                </ul>

                <p>Die in der {{ site.data.keys.mf_analytics_console }} angezeigten Inhalte hängen jetzt von der Sicherheitsrolle des angemeldeten Benutzers ab.<br/>
                Weitere Informationen finden Sie unter <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">Rollenbasierte Zugriffssteuerung</a>.</p>

                <p>{{ site.data.keys.mf_analytics_server }} verwendet Elasticsearch Version 1.7.5.</p>

                <p>In {{ site.data.keys.mf_analytics_short }} ist mit der neuen clientseitigen API für Webanalysen Analyseunterstützung für Webanwendungen hinzugekommen.</p>

                <p>Einige Ereignistypen haben sich in Version 8.0 gegenüber den älteren Versionen von {{ site.data.keys.mf_analytics_server }} geändert. Aufgrund dieser Änderung müssen alle JNDI-Eigenschaften, die bisher in Ihrer Serverkonfiguration definiert waren, auf den neuen Ereignistyp umgestellt werden.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">Neuerungen bei {{ site.data.keys.product_adj }}-Push-Benachrichtigungen</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>Der Push-Benachrichtigungsservice wird jetzt als eigenständiger Service von einer separaten Webanwendung bereitgestellt.</p>

                <p>In älteren Versionen der {{ site.data.keys.product }} war der Push-Benachrichtigungsservice in die Anwendungslaufzeit eingebettet.</p>

                <h3>Programmiermodell</h3>
                <p>Das Programmiermodell reicht vom Server bis zum Client. Wenn Ihre Clientanwendungen den Push-Benachrichtigungsservice nutzen können sollen, müssen Sie sie entsprechend konfigurieren. Zwei Arten von Clients können mit dem Push-Benachrichtigungsservice interagieren:</p>

                <ul>
                    <li>Mobile Clientanwendungen</li>
                    <li>Back-End-Serveranwendungen</li>
                </ul>

                <h3>Sicherheit für den Push-Benachrichtigungsservice</h3>
                <p>Der Autorisierungsserver der {{ site.data.keys.product }} setzt das OAuth-Protokoll zum Schutz des Push-Benachrichtigungsservice durch.</p>

                <h3>Modell des Push-Benachrichtigungsservice</h3>
                <p>Das auf Ereignisquellen basierende Modell wird nicht unterstützt. Die Push-Benachrichtigungsfunktion der {{ site.data.keys.product }} wird über das Push-Servicemodell realisiert.</p>

                <h3>Push-REST-API</h3>
                <p>Sie können außerhalb von {{ site.data.keys.mf_server }} implementierten Back-End-Serveranwendungen den Zugriff auf Push-Benachrichtigungsfunktionen ermöglichen. Verwenden Sie dazu die REST-API für Push in der Laufzeit der {{ site.data.keys.product }}.</p>

                <h3>Upgrade für vorhandenes, ereignisquellenbasiertes Benachrichtigungsmodell</h3>
                <p>Das auf Ereignisquellen basierende Modell wird nicht unterstützt. Die Push-Benachrichtigungsfunktion wird vollständig über das Push-Servicemodell realisiert. Alle vorhandenen, ereignisquellenbasierten anwendungen müssen auf das neue Push-Servicemodell umgestellt werden.</p>

                <h3>Push-Benachrichtigungen senden</h3>
                <p>Sie können vom Server eine auf Ereignisquellen basierende, eine tagbasierte oder eine Broadcast-Push-Benachrichtigung senden.</p>

                <p>Push-Benachrichtigungen können mit folgenden Methoden gesendet werden:</p>
                <ul>
                    <li>Von der {{ site.data.keys.mf_console }} aus können zwei Arten von Benachrichtigungen gesendet werden, tagbasierte Benachrichtigungen und Broadcastbenachrichtigungen (siehe "Push-Benachrichtigungen über die {{ site.data.keys.mf_console }} senden").</li>
                    <li>Mit der REST-API Push Message (POST) können alle Arten von Benachrichtigungen gesendet werden: tagbasierte Benachrichtigungen, Broadcastbenachrichtigungen und authentifizierte Benachrichtigungen.</li>
                    <li>Mit der REST-API für den MobileFirst-Server-Verwaltungsservice können alle Arten von Benachrichtigungen gesendet werden: tagbasierte Benachrichtigungen, Broadcastbenachrichtigungen und authentifizierte Benachrichtigungen.</li>
                </ul>

                <h3>SMS-Benachrichtigungen senden</h3>
                <p>Sie können den Push-Service für das Senden einer SMS-Benachrichtigung an Benutzergeräte konfigurieren.</p>

                <h3>Push-Benachrichtigungsservice installieren</h3>
                <p>Der Push-Benachrichtigungsservice wird als MobileFirst-Server-Komponente (MobileFirst-Server-Push-Service) bereitgestellt.</p>

                <h3>Unterstützung des Push-Servicemodells durch Windows-UWP-Apps</h3>
                <p>Sie können jetzt native Windows-UWP-Anwendungen (universelle Windows-Plattform) auf die Verwendung des Push-Servicemodells für das Senden von Push-Benachrichtigungen umstellen.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">Neuerungen bei {{ site.data.keys.mf_app_center }} </a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>Das {{ site.data.keys.mf_app_center }} wird jetzt über BYOL-Scripts in Bluemix (auf der Basis von Containern) unterstützt. </p>
            </div>
        </div>
    </div>
</div>
