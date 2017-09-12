---
layout: tutorial
title: MobileFirst-Foundation-Entwicklung für Cordova-Anwendungen
breadcrumb_title: Cordova-Anwendungsentwicklung
relevantTo: [cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
[http://cordova.apache.org/](http://cordova.apache.org/):

> Apache Cordova ist ein Open-Source-Framework für mobile Entwicklung, das die Verwendung von Standardwebtechnologien wie HTML5, CSS3 und JavaScript
für die plattformübergreifende Entwicklung unter Vermeidung der nativen Entwicklungssprachen der einzelnen mobilen Plattformen
ermöglicht. Anwendungen werden innerhalb von Wrappern für die jeweilige Plattform ausgeführt und stützen sich auf standardkonforme API-Bindungen, um auf Sensoren, Daten und den Netzstatus der einzelnen Geräte zuzugreifen.

Die {{ site.data.keys.product_full }} stelt ein aus mehreren Cordova-Plug-ins bestehendes SDK bereit. Informieren Sie sich darüber, wie das [SDK der {{ site.data.keys.product }} zu Cordova-Anwendungen hinzugefügt wird](../../application-development/sdk/cordova).

> **Hinweis:** Archiv- bzw. IPA-Dateien, die für die Übergabe von iOS-Apps an einen Store oder für die Validierung von iOS-Apps mit Test Flight oder iTunes Connect generiert werden, können zu Laufzeitfehlern oder zu einem Laufzeitabsturz führen. Weitere Informationen hierzu finden Sie im Blog [Preparing iOS apps for App Store submission in {{ site.data.keys.product_full }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).
#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Cordova-Anwendungsentwicklung](#cordova-application-development)
* [{{ site.data.keys.product_adj }}-APIs](#mobilefirst-apis)
* [Startablauf für das {{ site.data.keys.product_adj }}-SDK](#mobilefirst-sdk-startup-flow)
* [Cordova-Anwendungssicherheit](#cordova-application-security)
* [Cordova-Anwendungsressourcen](#cordova-application-resources)
* [Webressourcen einer Anwendung voranzeigen](#previewing-an-applications-web-resources)
* [JavaScript-Code implementieren](#implementing-javascript-code)
* [CrossWalk-Unterstützung für Android](#crosswalk-support-for-android)
* [WKWebView-Unterstützung für iOS](#wkwebview-support-for-ios)
* [Weiterführende Informationen](#further-reading)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Cordova-Anwendungsentwicklung
{: #cordova-application-development }
Mit Cordova entwickelte Anwendungen können durch folgende Cordova-Entwicklungspfade und -Features erweitert werden:

### Hooks
{: #hooks }
Cordova-Hooks sind Scripts, mit denen Entwickler Cordova-Befehle anpassen und so beispielsweise angepasste Buildabläufe erstellen können.   
Mehr über Cordova-Hooks erfahren Sie [hier](http://cordova.apache.org/docs/en/dev/guide/appdev/hooks/index.html#Hooks%20Guide).

### Merges
{: #merges }
In den Ordner "merges" können plattformspezifische Webressourcen (HTML-, CSS- und JavaScript-Dateien) gestellt werden. Diese Webressourcen werden dann im Schritt `cordova prepare` im entsprechenden nativen Verzeichnis implementiert. In den Ordner **merges/** gestellte Dateien setzen die entsprechenden Dateien im Ordner **www/** der betreffenden Plattform außer Kraft. Mehr über den Ordner "merges" erfahren Sie [hier](https://github.com/apache/cordova-cli#merges).

### Cordova-Plug-ins
{: #cordova-plug-ins }
Wenn Sie Cordova-Plug-ins verwenden, stehen Funktionserweiterungen zur Verfügung. Sie können beispielsweise native Benutzerschnittstellenelemente (Dialoge, Registerleisten, Spinner usw.) hinzufügen. Zudem können Sie innovative Funktionen wie Karten und Geoortung nutzen, externe Inhalte laden, angepasste Tastaturen nutzen und Einheiten (wie Kameras, Berührungssensoren usw.) integrieren.

Sie finden Cordova-Plug-ins auf [GitHub.com](https://github.com) und auf bekannten Cordova-Plug-in-Websites wie [Plugreg](http://plugreg.com/) und [NPM](http://npmjs.org).

Beispiel-Plug-ins:

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

>**Hinweis:** Die Modifikation des Standardverhaltens einer Cordova-App (z. B. durch Außerkraftsetzen des Verhaltens der Schaltfläche "Back") beim Hinzufügen des {{ site.data.keys.product_adj }}-Cordova-SDK zum Projekt, kann dazu führen, dass die App bei Übergabe an den Google Play Store zurückgewiesen wird. Sollte die Übergabe an den Google Play Store aus anderen Gründen fehlschlagen, wenden Sie sich an den Google-Support.


### Frameworks anderer Anbieter
{: #3rd-party-frameworks }
Mit Frameworks wie [Ionic](http://ionicframework.com/), [AngularJS](https://angularjs.org/), [jQuery Mobile](http://jquerymobile.com/), [Backbone](http://backbonejs.org/) und vielen anderen kann die Cordova-Anwendungsentwicklung noch reicher gestaltet werden.

**Blogbeiträge zur Integration**

* [Best Practices for building AngularJS apps with MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/11/best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/)
* [{{ site.data.keys.product }} in Ionic-Apps integrieren]({{site.baseurl}}/blog/2016/07/19/integrating-mobilefirst-foundation-8-in-ionic-based-apps/)
* [{{ site.data.keys.product }} in Ionic-2-Apps integrieren]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

### Pakete anderer Anbieter
{: #3rd-party-packages }
Mit Paketen anderer Anbieter können Sie Anwendungen modifizieren und Ziele wie die Kompression und Verkettung der Anwendungswebressourcen erreichen. Gängige Pakete für solche Zwecke sind:

- [uglify-js](https://www.npmjs.com/package/uglify-js)
- [clean-css](https://www.npmjs.com/package/clean-css)

## {{ site.data.keys.product_adj }}-APIs
{: #mobilefirst-apis }
Nachdem Sie das [{{ site.data.keys.product_adj }}-Cordova-SDK zu einer Cordova-Anwendung hinzugefügt haben](../../application-development/sdk/cordova), stehen die {{ site.data.keys.product_adj }}-API-Methoden zur Verfügung.

> Eine vollständige Liste der verfügbaren API-Methoden finden Sie in den [API-Referenzinformationen](../../api).

## Startablauf für das {{ site.data.keys.product_adj }}-SDK
{: #mobilefirst-sdk-startup-flow }
<div class="panel-group accordion" id="startup-flows" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Android-Startablauf</b></a>
            </h4>
        </div>

        <div id="collapse-android-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-flow">
            <div class="panel-body">
                <p>In Android Studio können Sie den Startprozess der Cordova-App für Android mit {{ site.data.keys.product_adj }} überüfen. Das {{ site.data.keys.product_adj }}-Cordova-Plug-in <b>cordova-plugin-mfp</b> hat eine native asynchrone Bootstrap-Sequenz, die abgeschlossen sein muss, bevor die Cordova-Anwendung die HTML-Hauptdatei der Anwendung lädt.</p>

                <p>Wenn das Plug-in <b>cordova-plugin-mfp</b> zu einer Cordova-Anwendung hinzgefügt wird, wird der native Code in der Datei <b>AndroidManifest.xml</b> und der Datei <code>MainActivity</code> (die <code>CordovaActivity</code> erweitert) für die Durchführung der {{ site.data.keys.product_adj }}-Intialisierung instrumentiert.</p>

                <p>Die Instrumentierung des nativen Anwendungscodes umfasst Folgendes:</p>
                <ul>
                    <li>Es werden Aufrufe der API <code>com.worklight.androidgap.api.WL</code> für die {{ site.data.keys.product_adj }}-Initialisierung hinzugefügt.</li>
                    <li>Zur Datei <b>AndroidManifest.xml</b> wird Folgendes hinzgefügt: <ul>
                            <li>Eine Aktivität <code>MFPLoadUrlActivity</code> für eine ordnungsgemäße {{ site.data.keys.product_adj }}-Initialisierung für den Fall, dass <b>cordova-plugin-crosswalk-webview</b> installiert ist</li>
                            <li>Ein angepasstes Attribut <b>android:name="com.ibm.MFPApplication</b>" für das Element <code>application</code> (siehe unten)</li>
                        </ul>
                    </li>
                </ul>

                <h3>WLInitWebFrameworkListener implementieren und WL-Objekt erstellen</h3>
                <p>Die Datei <b>MainActivity.java</b> erstellt die <code>MainActivity</code>-Ausgangsklasse, die die Klasse <code>CordovaActivity</code> erweitert. Der <code>WLInitWebFrameworkListener</code> wird benachrichtigt, wenn das {{ site.data.keys.product_adj }}-Framework initialisiert ist.</p>

{% highlight java %}
public class MainActivity extends CordovaActivity implements WLInitWebFrameworkListener {
{% endhighlight %}

                <p>Die Klasse <code>MFPApplication</code> wird aus der Methode <code>onCreate</code> heraus aufgerufen und erstellt eine {{ site.data.keys.product_adj }}-Clientinstanz (<code>com.worklight.androidgap.api.WL</code>), die in der gesamten App verwendet wird. Die Methode <code>onCreate</code> initialisiert das <b>WebView-Framework</b>.</p>

{% highlight java %}
@Overridepublic void onCreate(Bundle savedInstanceState){
super.onCreate(savedInstanceState);

if (!((MFPApplication)this.getApplication()).hasCordovaSplashscreen()) {
           WL.getInstance().showSplashScreen(this);
       }
   init();
   WL.getInstance().initializeWebFramework(getApplicationContext(), this);
}
{% endhighlight %}

                <p>Die Klasse <code>MFPApplication</code> hat zwei Funktionen: </p>
                <ul>
                    <li>Sie definiert die Methode <code>showSplashScreen</code> für das Laden der Begrüßungsanzeige, sofern eine solche vorhanden ist.</li>
                    <li>Sie erstellt zwei Listener zum Aktivieren der Analyse. Wenn Sie diese Listener nicht benötigen, können Sie sie entfernen.</li>
                </ul>

                <h3>WebView laden</h3>
                <p>Das Plug-in <b>cordova-plugin-mfp</b> fügt eine Aktivität zur Datei <b>AndroidManifest.xml</b> hinzu, die für die Initialisierung von Crosswalk WebView erforderlich ist.</p>

{% highlight xml %}
<activity android:name="com.ibm.MFPLoadUrlActivity" />
{% endhighlight %}

                <p>Diese Aktivität wird verwendet, um die asynchrone Initialisierung von Crosswalk WebView sicherzustellen.</p>

                <p>Wenn das {{ site.data.keys.product_adj }}-Framework intialisiert und für das Laden in WebView bereit ist, stellt <code>onInitWebFrameworkComplete</code> eine Verbindung zu der URL her, sofern <code>WLInitWebFrameworkResult</code> einen Erfolg angibt.</p>

{% highlight java %}
public void onInitWebFrameworkComplete(WLInitWebFrameworkResult result){
if (result.getStatusCode() == WLInitWebFrameworkResult.SUCCESS) {
super.loadUrl(WL.getInstance().getMainHtmlFilePath());
   } else {
      handleWebFrameworkInitFailure(result);
   }
}
{% endhighlight %}

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>iOS-Startablauf</b></a>
            </h4>
        </div>

        <div id="collapse-ios-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-flow">
            <div class="panel-body">
                <p>Das {{ site.data.keys.product_adj }}-Framework wird auf der iOS-Plattform initialisiert, um ein WebView in der Cordova-App mit {{ site.data.keys.product_adj }} anzuzeigen.</p>

                <b>main.m</b>
                <p>In der Datei <code>main.m</code> ersetzt das {{ site.data.keys.product_adj }}-Plug-in den standardmäßigen Hauptanwendungsdelegaten <code>AppDelegate</code> durch <code>MFPAppDelegate</code>.</p>

{% highlight objc %}
#<UIKit/UIKit.h> importieren
int main(int argc, char *argv[]) {
 @autoreleasepool
    {    
        int retVal = UIApplicationMain(argc, argv, nil, @"MFPAppDelegate");   
        return retVal;
    }
}
{% endhighlight %}

                <b>MFPAppDelegate.m</b>
                <p>Die Datei <code>MFPAppDelegate.m</code> befindet sich im Ordner "plugins". Sie ersetzt die Cordova-Standarddatei <code>AppDelegate.m</code> und initialisiert das {{ site.data.keys.product_adj }}-Framework, bevor der Anzeigecontroller WebView lädt.</p>

                <p>Die Methode <code>didFinishLaunchingWithOptions</code> intialisiert das Framework. </p>

{% highlight objc %}
[[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
{% endhighlight %}

                <p>Nach erfolgreicher Initialisierung überprüft <code>wlInitWebFrameworkDidCompleteWithResult</code>, ob das {{ site.data.keys.product_adj }}-Framework geladen wurde, ruft <code>wlInitDidCompleteSuccessfully</code> auf und erstellt Listener für den Datenempfang. <code>wlInitDidCompleteSuccessfully</code> erstellt einen <code>cordovaViewController</code>, der eine Verbindung zur Standardseite <b>index.html</b> herstellt.</p>

                <p>Wenn die iOS-Cordova-App fehlerfrei in Xcode erstellt wurde, können Sie Features zur nativen Plattform und zu WebView hinzufügen.</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Windows-Startablauf</b></a>
            </h4>
        </div>

        <div id="collapse-windows-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows-flow">
            <div class="panel-body">
                <p>Das {{ site.data.keys.product_adj }}-Cordova-Plug-in <b>cordova-plugin-mfp</b> hat eine native asynchrone Bootstrap-Sequenz, die abgeschlossen sein muss, bevor die Cordova-Anwendung die HTML-Hauptdatei der Anwendung lädt.</p>

                <p>Wenn das Plug-in <b>cordova-plugin-mfp</b> zu einer Cordova-Anwendung hinzugefügt wird, wird die Datei <b>index.html</b> zur Datei <b>appxmanifest</b> der Anwendung hinzugefügt. Damit wird der native <code>CordovaActivity</code>-Code so erweitert, dass er die {{ site.data.keys.product_adj }}-Initialisierung ausführen kann.</p>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

## Cordova-Anwendungssicherheit
{: #cordova-application-security }
Die {{ site.data.keys.product_full }} stellt Sicherheitsfunktionen bereit, die Ihnen helfen, Ihre Cordova-Apps zu schützen.

Ein großer Teil des Inhalts einer plattformübergreifenden App kann einfacher als eine native App von einer unberechtigten Person modifiziert werden. Da viele allgemeine Inhalte einer plattformübergreifenden App in einem lesbaren Format vorliegen, stellt die IBM MobileFirst Foundation Features bereit, die ein höheres Maß an Sicherheit für Ihre plattformübergreifenden Cordova-Apps ermöglichen.

> Machen Sie sich mit dem [{{ site.data.keys.product_adj }}-Sicherheitsframework](../../authentication-and-security) vertraut.

Verwenden Sie die folgenden Funktionen, um die Sicherheit für Ihre Cordova-Apps zu verbessern:

* [Verschlüsselung der Webressourcen von Cordova-Paketen](securing-apps/#encrypting-the-web-resources-of-your-cordova-packages)  
    Verschlüsselt den Inhalt des Ordners "www" Ihrer Cordova-App und entschlüsselt ihn, wenn die App installiert und zum ersten Mal ausgeführt wird. Durch diese Verschlüsselung ist es schwieriger, den Inhalt dieses Ordners anzuzeigen oder zu modifizieren, während die App gepackt wird.
* [Kontrollsummenfeature für Webressourcen aktivieren](securing-apps/#enabling-the-web-resources-checksum-feature)  
    Stellt die Integrität der App beim Start sicher, indem der Inhalt mit dem Referenzkontrollsummenergebnis verglichen wird, das beim ersten Start der App erfasst wurde. Dieser Test hilft dabei, Modifizierungen einer App zu verhindern, die bereits installiert ist.
* [FIPS 140-2 aktivieren](../../administering-apps/federal/#enabling-fips-140-2)  
    Stellt sicher, dass die Verschlüsselungsalgorithmen zum Verschlüsseln ruhender und bewegter Daten mit dem Standard FIPS 140-2 (Federal Information Processing Standards) konform sind.
* [Certificate Pinning](../../authentication-and-security/certificate-pinning)  
    Hilft Man-in-the-Middle-Attacken zu verhindern, indem enem Host sein erwarteter öffentlicher Schlüssel zugeordnet wird.

## Cordova-Anwendungsressourcen
{: #cordova-application-resources }
Bestimmte Ressourcen müssen Bestandteil einer Cordova-Anwendung sein. In meisten Fällen werden diese für Sie generiert, wenn Sie Ihre Cordova-App mit Ihren bevorzugten Cordova-Entwicklungstools erstellen. Wenn Sie die Schablone der {{ site.data.keys.product }} verwenden, werden auch Begrüßungsanzeigen und Symbole bereitgestellt.

Sie können eine IBM Projektschablone für Cordova-Projekte verwenden, die {{ site.data.keys.product_adj }}-Features nutzen können. Wenn Sie die {{ site.data.keys.product_adj }}-Schablone verwenden, stehen Ihnen als Ausgangspunkt die folgenden Ressourcen zur Verfügung. Wenn Sie die {{ site.data.keys.product_adj }}-Schablone nicht verwenden, werden alle Ressourcen mit Ausnahme der Begrüßungsanzeigen und Symbole bereitgestellt. Sie können die Schablone hinzufügen, indem Sie bei der erstmaligen Erstellung Ihres Cordova-Projekts die Option `--template` und die {{ site.data.keys.product_adj }}-Schablone angeben.

Wenn Sie die Standarddateinamen und -pfade von Ressourcen ändern möchten,
müssen Sie diese Änderungen auch in der
Cordova-Konfigurationsdatei (config.xml) angeben. In einigen Fällen können Sie die Standardnamen und -pfade auch mit
dem Befehl mfpdev app config ändern. In solchen Fällen finden Sie
im Abschnitt zu den Ressourcen einen entsprechenden Hinweis.

### Cordova-Konfigurationsdatei (config.xml)
{: #cordova-configuration-file-configxml }
Die Cordova-Konfigurationsdatei ist eine erforderliche
XML-Datei, die Anwendungsmetadaten enthält und im Stammverzeichnis der App gespeichert wird. Die Datei wird automatisch generiert, wenn Sie
eine Cordova-Anwendung erstellen. Sie können sie modifizieren, um benutzerdefinierte Eigenschaften mit dem Befehl
mfpdev app config hinzuzufügen.

### Hauptdatei (index.html)
{: #main-file-indexhtml}
Diese Hauptdatei ist eine HTML-5-Datei, die das Anwendungsgerüst enthält. Diese Datei lädt alle Webressourcen
(Scripts und Style-Sheets), die erforderlich sind, um die allgemeinen Komponenten der Anwendung zu definieren und
Anbindungen an erforderliche Dokumentereignisse zu erstellen. Sie finden diese Datei im Verzeichnis
**Ihr_Projektname/www**. Sie können den Namen dieser Datei mit dem Befehl
`mfpdev app config` ändern.

### Piktogramm
{: #thumbnail-image }
Das Piktogramm ermöglicht eine grafisch orientierte Identifikation der Anwendung in der {{ site.data.keys.mf_console }}. Es muss sich um ein quadratisches Bild, bevorzugt mit einer Größe
von
90 x 90 Pixeln, handeln.   
Ein Standardpiktogramm wird bereitgestellt, wenn Sie die Schablone verwenden. Sie können das Standardbild
mit einem Ersatzbild
überschreiben (indem Sie denselben Dateinamen verwenden). Sie finden die Datei thumbnail.png im Ornder **Ihr_Projektname/www/img**. Sie können den Namen oder Pfad dieser Datei mit dem Befehl
`mfpdev app config` ändern.

### Begrüßungsbild
{: #splash-image }
Das Begrüßungsbild wird angezeigt, wenn die Anwendung
initialisiert wird. Wenn Sie die MobileFirst-Standardschablone verwenden, werden Begrüßungsbilder bereitgestellt. Diese Standardbilder sind in folgenden Verzeichnissen gespeichert:

* iOS: `<Ihr_Projektname>/res/screen/ios/`
* Android: `<Ihr_Projektname>/res/screen/android/`
* Windows: `<Ihr_Projektname>/res/screen/windows/`

Es stehen verschiedene Standardbegrüßungsbilder zur Verfügung, die für unterschiedliche Anzeigen und für
verschiedene Versionen der Betriebssysteme
iOS und Windows passen. Sie können das Standardbild der Schablone durch ein eigenes Begrüßungsbild ersetzen oder - falls Sie die Schablone nicht nutzen - ein Bild hinzufügen. Wenn Sie Ihre App für die Android-Plattform
mit der {{ site.data.keys.product_adj }}-Schablone erstellen,
ist das Plug-in **cordova-plugin-splashscreen** installiert. Wenn dieses Plug-in integriert ist, werden anstelle der von
{{ site.data.keys.product }} verwendeten Bilder die von Cordova verwendeten Begrüßungsbilder angezeigt.
Die Bilder im Ordner mit dem Bildformat screen.png sind die Cordova-Standardbegrüßungsbilder. Sie können angeben, welche Begrüßungsbilder angezeigt werden sollen, indem Sie die
Einstellungen in der Cordova-Datei
**config.xml** ändern.

Wenn Sie die
{{ site.data.keys.product_adj }}-Schablone nicht verwenden,
sind die angezeigten Standardbilder die vom
{{ site.data.keys.product }}-Plug-in verwendeten Bilder.
Die Dateinamen der standardmäßigen {{ site.data.keys.product_adj }}-Quellenbegrüßungsbilder haben das Format
**splash-Zeichenfolge.9.png**.

> Weitere Informationen zur Verwendung eigener
Begrüßungsbilder finden Sie unter
[Angepasste Begrüßungsanzeigen und Symbole zu Cordova-Apps hinzufügen](adding-images-and-icons).

### Anwendungssymbole
{: #application-icons }
Mit der Schablone werden Standardbilder für Anwendungssymbole bereitgestellt. Diese Standardbilder sind in folgenden Verzeichnissen gespeichert:

* iOS: `<Ihr_Projektname>/res/icon/ios/`
* Android: `<Ihr_Projektname>/res/icon/android/`
* Windows: `<Ihr_Projektname>/res/icon/windows/`

Sie können das Standardbild durch ein eigenes Bild ersetzen. Ihr angepasstes Anwendungssymbol muss dieselbe
Größe und denselben Dateinamen wie das zu ersetzende Standardanwendungssymbol
haben. Es stehen verschiedene Standardbilder zur Verfügung, die für verschiedene Anzeigen und Betriebssystemversionen
geeignet sind.

> Weitere Informationen zur Verwendung eigener
Begrüßungsbilder finden Sie unter
[Angepasste Begrüßungsanzeigen und Symbole zu Cordova-Apps hinzufügen](adding-images-and-icons).

### Style-Sheets
{: #stylesheets }
Der App-Code kann CSS-Dateien enthalten, um die Anwendungsansicht zu definieren.

Die Style-Sheet-Dateien befinden sich im Verzeichnis `<Ihr_Projektname>/www/css` und werden in die folgenden plattformspezifischen Ordner kopiert:

* iOS: `<Ihr_Projektname>/platforms/ios/www/css`
* Android: `<Ihr_Projektname>/platforms/android/assets/www/css`
* Windows: `<Ihr_Projektname>/platforms/windows/www/css`


### Scripts
{: #scripts }
Ihr App-Code kann JavaScript-Dateien umfassen, mit denen diverse Funktionen Ihrer App implementiert werden, z. B.
interaktive
Benutzerschnittstellenkomponenten, Geschäftslogik und die Integration von Back-End-Abfragen.

Die JavaScript-Datei index.js wird mit der Schablone bereitgestellt. Sie befindet sich im Ordner **Ihr_Projektname/www/js**.
Die Datei wird in die folgenden plattformspezifischen Ordner kopiert:

* iOS: `<Ihr_Projektname>/platforms/ios/www/js`
* Android: `<Ihr_Projektname>/platforms/android/assets/www/js`
* Windows: `<Ihr_Projektname>/platforms/windows/assets/www/js`

## Webressourcen einer Anwendung voranzeigen
{: #previewing-an-applications-web-resources }
Die Webressourcen einer Cordova-Anwendung können im iOS-Simulator, im Android-Emulator, im Windows-Emulator oder auf physischen Geräten vorangezeigt werden. In der
{{ site.data.keys.product }} stehen zudem zwei Optionen für eine Livevorschau zur Verfügung:
der {{ site.data.keys.mf_mbs_full }} und die einfache Darstellung in einem Browser.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Sicherheitseinschränkung:** Sie können
Ihre Webressourcen voranzeigen. Der Simulator unterstützt jedoch nicht alle {{ site.data.keys.product_adj }}-JavaScript-APIs. Insbesondere das OAuth-Protokoll wird nicht vollständig unterstützt.
Sie können jedoch Adapteraufrufe mit `WLResourceRequest` testen.
In diesem Fall gilt: >
> * Auf der Serverseite werden keine Sicherheitsüberprüfungen ausgeführt und an den im {{ site.data.keys.mf_mbs }} ausgeführten Client werden keine Sicherhetisabfragen gesendet.
> * Wenn Sie {{ site.data.keys.mf_server }} in einer Entwicklungsumgebung nicht verwenden,
registrieren Sie einen vertraulichen Client, in dessen Liste erlaubter Bereiche der Bereich des Adapters enthalten ist. Sie können einen
vertraulichen Client in der {{ site.data.keys.mf_console }} über das Menü
"Laufzeit -> Einstellungen" definieren. Weitere Informationen
zu vertraulichen Clients finden Sie unter
[Vertrauliche Clients](../../authentication-and-security/confidential-clients). >
> **Hinweis:** In einer Entwicklungsumgebung enthält der {{ site.data.keys.mf_server }}
einen vertraulichen Client mit dem Namen "test" und einem uneingeschränkten Bereich ("*"). Dieser vertrauliche Client wird standardmäßig von mfpdev app preview verwendet.

#### Einfacher Browser
{: #simple-browser }
Bei der einfachen Darstellung in einem Browser werden die Webressourcen der Anwendung im Desktop-Browser dargestellt, ohne als App betrachtet zu werden.
Auf diese Weise ist es möglich, nur die Webressourcen zu debuggen.   

#### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator }
Der {{ site.data.keys.mf_mbs }} ist eine Webanwendung zum Testen von Cordova-Anwendungen. Der Simulator
simuliert Gerätefeatures, ohne dass die App in einem Emulator oder auf einem physischen Gerät installiert werden muss.

**Unterstützte Browser:**

* Firefox ab Version 38
* Chrome ab Version 49
* Safari ab Version 9

### Vorschau
{: #previewing }
1. Führen Sie in einem **Befehlszeilenfenster** den folgenden Befehl aus:

    ```bash
    mfpdev app preview
    ```

2. Wählen Sie eine Vorschauoption aus:

    ```bash
    ? Select how to preview your app: (Use arrow keys)
    ❯ browser: Simple browser rendering
    mbs: Mobile Browser Simulator
    ```
3. Wählen Sie eine Plattform für die Vorschau aus (angezeigt werden nur hinzugefügte Plattformen):

    ```bash
    ❯◯ android
    ◯ ios
	```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Weitere Informationen zu den verschiedenen CLI-Befehlen enthält das Lernprogramm [{{ site.data.keys.product_adj }}-Artefakte über die CLI verwalten](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### Livevorschau
{: #live-preview }
Der applikative Code (HTML, CSS und JS) kann jetzt in Echtzeit in einer Livevorschau bearbeitet werden.    
Wenn Sie eine Ressource ändern und die Änderung speichern, spiegelt sie sich sofort im Browser wider.

### Live-Reload
{: #live-reload }
Wenn Sie für die Voranzeige auf physischen Geräten oder in Simulatoren/Emulatoren einen ähnlichen Effekt wünschen,
fügen Sie das Plug-in **cordova-plugin-livereload** hinzu. Anweisungen finden Sie auf der [GitHub-Seite für das Plug-in](https://github.com/omefire/cordova-plugin-livereload).

### Anwendung in einem Emulator oder auf einem phyischen Gerät ausführen
{: #running-the-application-on-emulator-or-on-a-physical-device }
Sie können die Anwendungsausführung mit dem Cordova-CLI-Befehl `cordova emulate ios|android|windows` emulieren. Beispiel:

```bash
cordova emulate ios
```

Wenn Sie die Anwendung auf einem mit der Entwicklungsworkstation verbundenen physischen Gerät ausführen möchten, führen
Sie den Cordova-CLI-Befehl `cordova run ios|android|windows` aus. Beispiel:

```bash
cordova run ios
```

## JavaScript-Code implementieren
{: #implementing-javascript-code }
WebView-Ressourcen lassen sich besser in einer
IDE mit automatischer Vervollständigung für JavaScript bearbeiten.

In Xcode, Android Studio und Visual Studio gibt es umfassende Bearbeitungsfunktionen für
Objective-C, Swift, C# und and  Java. Hinsichtlich der Unterstützung für die Bearbeitung von
JavaScript kann es jedoch Einschränkungen geben.
Zur Vereinfachung der JavaScript-Berabeitung enthält das
{{ site.data.keys.product_adj }}-Cordova-Projekt eine Definitionsdatei
für die automatische Vervollständigung
von {{ site.data.keys.product_adj }}-API-Elementen.

In jedem {{ site.data.keys.product_adj }}-Cordova-Plug-in gibt es eine
Konfigurationsdatei `d.ts` für jede
{{ site.data.keys.product_adj }}-JavaScript-Datei. Der Dateiname von
`d.ts` passt zum Namen der entsprechenden
JavaScript-Datei. Die Konfigurationsdatei befindet sich im
Plug-in-Ordner. Die Datei das
{{ site.data.keys.product_adj }}-Haupt-SDK
befindet sich beispielsweise an folgender Position: **[myapp]\plugins\cordova-plugin-mfp\typings\worklight.d.ts**.

Die Konfigurationsdatei `d.ts` stellt für alle IDEs mit TypeScript-Unterstützung
([TypeScript Playground](http://www.typescriptlang.org/Playground/), [Visual Studio Code](http://www.microsoft.com/visualstudio/eng),
[WebStorm](http://www.jetbrains.com/webstorm/),
[WebEssentials](http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f),
[Eclipse](https://github.com/palantir/eclipse-typescript)) die automatische Vervollständigung bereit.

Die Ressourcen (HTML- und JavaScript-Dateien)
für WebView befinden sich im Ordner **[myapp]\www**.
Wenn das Projekt mit dem Befehl cordova build erstellt oder der Befehl
cordova prepare ausgeführt wird, werden diese Ressourcen in den entsprechenden
Ordner **www**, d. h. in
**[myapp]\platforms\ios\www**, **[myapp]\platforms\android\assets\www**
oder **[myapp]\platforms\windows\www**, kopiert.

Wenn Sie den App-Hauptordner in einer der vorgenannten IDEs öffnen, bleibt der Kontext erhalten. Der
IDE-Editor ist jetzt mit den relevanten `d.ts`-Dateien verlinkt und kann die
{{ site.data.keys.product_adj }}-API-Elemente während Ihrer Eingabe
automatisch vervollständigen.

## CrossWalk-Unterstützung für Android
{: #crosswalk-support-for-android }
In Cordova-Anwendungen für die Android-Plattform kann das standardmäßig verwendete WebView durch [CrossWalk WebView](https://crosswalk-project.org/) ersetzt werden.  
Gehen Sie zum Hinzufügen von CrossWalk WebView wie folgt vor:

1. Führen Sie in einem **Befehlszeilenfenster** den folgenden Befehl aus:

   ```bash
   cordova plugin add cordova-plugin-crosswalk-webview
   ```

   Der Befehl fügt CrossWalk WebView zu der Anwendung hinzu.   
    Im Hintergrund passt das {{ site.data.keys.product_adj }}-Cordova-SDK die Android-Projektaktivitäten so an, dass CrossWalk WebView verwendet werden kann.

2. Erstellen Sie das Projekt mit folgendem Befehl:

   ```bash
   cordova build
   ```

## WKWebView-Unterstützung für iOS
{: #wkwebview-support-for-ios }
In Cordova-iOS-Anwendungen kann das standardmäßig verwendete UIWebView durch
[Apple WKWebView](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/) ersetzt werden.  
Füren Sie in einem Befehlszeilenfenster den folgenden Befehl aus, um WKWebView hinzuzufügen: `cordova plugin add cordova-plugin-wkwebview-engine`.

> Machen Sie sich mit dem [Cordova-WKWebView-Plug-in](https://github.com/apache/cordova-plugin-wkwebview-engine) vertraut.

## Weiterführende Informationen
{: #further-reading }
Auf den folgenden Seiten erfahren Sie mehr über Cordova:

- [Cordova Overview](https://cordova.apache.org/docs/en/latest/guide/overview/index.html)
- [Best Practices Cordova app development,
Testing Cordova apps, Debugging Cordova apps, Special Considerations, Keeping Up](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)
- [Get started fast](https://cordova.apache.org/#getstarted)

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Beginnen Sie mit dem [Hinzufügen des MobileFirst-SDK zu Ihrer Cordova-Anwendung](../../application-development/sdk/cordova).
Sehen Sie sich dann die {{ site.data.keys.product_adj }}-Features im Abschnitt [Alle Lernprogramme](../../all-tutorials/) an.
