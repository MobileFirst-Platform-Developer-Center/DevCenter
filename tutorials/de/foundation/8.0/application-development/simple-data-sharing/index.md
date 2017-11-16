---
layout: tutorial
title: Gemeinsame Nutzung einfacher Daten
relevantTo: [ios,android,cordova]
weight: 12
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Mithilfe der gemeinsamen Nutzung einfacher Daten ist es möglich, dass die Anwendungen einer Anwendungsfamilie auf einem einzelnen Gerät
einfache Informationen auf sicherem Wege gemeinsam nutzen können. Dieses Feature stellt mithilfe der in den verschiedenen mobilen
SDKs bereits vorhandenen nativen APIs eine einheitliche Entwickler-API bereit. Diese {{ site.data.keys.product_adj }}-API abstrahiert
die Komplexität der verschiedenen Plattformen und erleichtert Entwicklern die schnelle Implementierung von Code für die
Kommunikation zwischen Anwendungen.

Dieses Feature wird unter iOS und Android sowohl für Cordova-Anwendungen als auch für native Anwendungen unterstützt.  

Nach der Aktivierung der gemeinsamen Nutzung einfacher Daten können Sie die bereitgestellten
Cordova-APIs und nativen APIs nutzen, um zwischen den Anwendungen einer Anwendungsfamilie auf einem Gerät einfache
Zeichenfolgetoken auszutauschen.  

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [Terminologie](#terminology)
* [Feature für gemeinsame Nutzung einfacher Daten aktivieren](#enabling-the-simple-data-sharing-feature)
* [Konzepte der API für gemeinsame Nutzung einfacher Daten](#simple-data-sharing-api-concepts)
* [Beschränkungen und Hinweise](#limitations-and-considerations)

## Terminologie
{: #terminology }
### {{ site.data.keys.product_adj }}-Anwendungsfamilie
{: #mobilefirst-application-family }
Eine Anwendungsfamilie ist eine Möglichkeit, Anwendungen mit derselben Vertrauensebene
zu einer Gruppe zusammenzufassen. Anwendungen einer Familie können untereinander sicher und geschützt Informationen austauschen.

Alle Anwendungen müssen den folgenden Anforderungen genügen, um als
Teil derselben {{ site.data.keys.product_adj }}-Anwendungsfamilie betrachtet zu werden:

* Sie geben im Anwendungsdeskriptor denselben Wert für den Anwendungsdeskriptor an.
	* Für iOS-Anwendungen bezieht sich diese Anforderung auf den Wert für die Zugriffsgruppenberechtigung. 
	* Für Android-Anwendungen bezieht sich diese Anforderung auf den Wert für **sharedUserId**
in der Datei **AndroidManifest.xml**. 

    > **Hinweis:** Unter Android muss der Name das Format **x.y** haben.

* Anwendungen müssen mit derselben Unterzeichnungsidentität signiert sein. Diese Anforderung bedeutet, dass nur Anwendungen derselben Organisation
dieses Feature verwenden können.
    * Für iOS-Anwendungen bezieht sich diese Anforderung auf dasselbe Anwendungs-ID-Präfix und dasselbe Bereitstellungsprofil sowie darauf, dass
die Anwendung mit derselben Unterzeichnungsidentität signiert wurde.
	* Für Android-Anwendungen bedeutet diese Anforderung die Verwendung desselben Signierzertifikats und -schlüssels.

Anwendungen einer
{{ site.data.keys.product_adj }}-Anwendungsfamilie verwenden neben den von der {{ site.data.keys.product }} bereitgestellten
APIs die APIs für gemeinsame Datennutzung in den jeweiligen nativen SDKs für mobile Anwendungen.

### Zeichenfolgetoken
{: #string-tokens }
Die gemeinsame Nutzung von Zeichenfolgetoken durch Anwendungen derselben {{ site.data.keys.product_adj }}-Anwendungsfamilie ist jetzt
über das Feature für die gemeinsame Nutzung einfacher Daten für
iOS-Hybridanwendungen und native iOS-Anwendungen sowie für Android-Hybridanwendungen und native Android-Anwendungen möglich.  

Zeichenfolgetoken werden als einfache Zeichenfolgen
wie Kennwörter oder Cookies angesehen. Die Verwendung langer Zeichenfolgen führt zu erheblichen Leistungseinbußen.

Wenn Sie die APIs verwenden, sollten Sie für zusätzliche Sicherheit
die Verschlüsselung von Token in Erwägung ziehen. 

> Weitere Informationen finden Sie unter [JSONStore-Sicherheitsdienstprogramme](../jsonstore/security-utilities/).

## Feature für gemeinsame Nutzung einfacher Daten aktivieren
{: #enabling-the-simple-data-sharing-feature }
Die folgenden Anweisungen gelten sowohl für native Apps als auch für Cordova-basierte Apps.   
Öffnen Sie Ihre Anwendung in Xcode oder Android Studio und gehen Sie wie folgt vor: 

### iOS
{: #ios }
1. Fügen Sie in Xcode eine Keychain Access Group hinzu, in der alle Apps, die zur selben Anwendungsfamilie gehören sollen, einen eindeutigen Namen haben. Die berechtigte Anwendungs-ID muss für alle Anwendungen der Familie dieselbe sein.
2. Vergewissern Sie sich, dass alle Anwendungen, die zur selben Anwendungsfamilie gehören,
ein gemeinsames Anwendungs-ID-Präfix verwenden. Weitere Informationen finden Sie unter
"3. Managing Multiple App ID Prefixes" in der iOS
Developer Library.
4. Speichern und signieren Sie die Anwendungen. Stellen Sie sicher, dass zum Signieren aller Anwendungen in dieser Gruppe dasselbe iOS-Zertifikat und dieselben Bereitstellungsprofile verwendet werden.
5. Wiederholen Sie die Schritte für alle Anwendungen, die Teil einer Anwendungsfamilie sein sollen.

Jetzt können Sie die nativen APIs für die gemeinsame Nutzung einfacher Daten verwenden, um
den Anwendungen einer Familie die gemeinsame Nutzung einfacher Zeichenfolgen zu ermöglichen.


### Android
{: #android }
1. Aktivieren Sie die Option für die gemeinsame Nutzung einfacher Daten, indem Sie in Ihrer Datei **AndroidManifest.xml**
im Tag "manifest" den Namen der Anwendungsfamilie mit dem Element **android:sharedUserId** angeben. Beispiel:

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.myApp1"
        android:versionCode="1"
        android:versionName="1.0"
        android:sharedUserId="com.myGroup1">
   ```

2. Vergewissern Sie sich, dass alle Anwendungen, die zur selben Anwendungsfamilie gehören,
mit denselben Signing Credentials signiert wurden.
3. Deinstallieren Sie alle früheren Versionen der Anwendungen, die keine **sharedUserId** angegeben oder eine andere
**sharedUserId** verwendet haben.
4. Installieren Sie die Anwendung auf dem Gerät.
5. Wiederholen Sie die Schritte für alle Anwendungen, die Teil einer Anwendungsfamilie sein sollen.

Jetzt können Sie die bereitgestellten nativen APIs für die gemeinsame Nutzung einfacher Daten verwenden, um
den Anwendungen einer Familie die gemeinsame Nutzung einfacher Zeichenfolgen zu ermöglichen. 

## Konzepte der API für gemeinsame Nutzung einfacher Daten
{: #simple-data-sharing-api-concepts }
Mit den APIs für die gemeinsame Nutzung einfacher Daten können Anwendungen einer Familie
Schlüssel-Wert-Paare an einer allgemeinen Position setzen oder löschen und von dieser Position abrufen.
Die APIs für die gemeinsame Nutzung einfacher Daten sind für alle Plattformen ähnlich und stellen eine Abstraktionsschicht bereit, durch die die Komplexität der einzelnen APIs der nativen SDKs verborgen bleibt.
Dadurch sind diese APIs einfach in der Verwendung.

Die folgenden Beispiele zeigen, wie Sie Token im gemeinsamen Speicher für Berechtigungsnachweise für verschiedene Umgebungen definieren, abrufen und löschen können.

### JavaScript
{: #javascript }
```javascript
WL.Client.setSharedToken({key: myName, value: myValue})
WL.Client.getSharedToken({key: myName})
WL.Client.clearSharedToken({key: myName})
```

> Weitere Hinweise zu den Cordova-APIs finden Sie in der Beschreibung der Funktionen [getSharedToken](../../api/client-side-api/javascript/client/), [setSharedToken](../../api/client-side-api/javascript/client/) und [clearSharedToken](../../api/client-side-api/javascript/client/) in den Referenzinformationen zur API `WL.Client`.



### Objective-C
{: #objective-c }
```objc
[WLSimpleDataSharing setSharedToken: myName value: myValue];
NSString* token = [WLSimpleDataSharing getSharedToken: myName]];
[WLSimpleDataSharing clearSharedToken: myName];
```

> Weitere Hinweise zu den Objective-C-APIs finden Sie in der Beschreibung der Klasse [WLSimpleDataSharing](../../api/client-side-api/objc/client/) in den API-Referenzinformationen.



### Java
{: #java }
```java
WLSimpleSharedData.setSharedToken(myName, myValue);
String token = WLSimpleSharedData.getSharedToken(myName);
WLSimpleSharedData.clearSharedToken(myName);
```

> Weitere Hinweise zu den Java-APIs finden Sie in der Beschreibung der Klasse [WLSimpleDataSharing](../../api/client-side-api/java/client/) in den API-Referenzinformationen.



## Beschränkungen und Hinweise
{: #limitations-and-considerations }
### Sicherheitsaspekte
{: #security-considerations }
Da diese Funktion den Datenzugriff für eine Gruppe von Anwendungen ermöglicht,
muss das Gerät besonders sorgfältig vor dem Zugriff unbefugter Benutzer geschützt werden.
Beachten Sie die folgenden Sicherheitsaspekte:

#### Gerätesperre
{: #device-lock }
Gewährleisten Sie im Interesse einer höheren Sicherheit, dass Geräte mit einem Kennwort, einem Kenncode oder einer PIN gesichert sind, sodass das Gerät bei einem Verlust oder Diebstahl
geschützt ist.

#### Jailbreak-Erkennung
{: #jailbreak-detection }
Ziehen Sie eine Managementlösung für mobile Endgeräte in Erwägung, um die Geräte in Ihrem Unternehmen vor Jailbreaks oder Rooterkennung
zu schützen.

#### Verschlüsselung
{: #encryption }
Erwägen Sie im Interesse einer erhöhten Sicherheit die Verschlüsselung aller Token, bevor sie freigegeben werden. Weitere Informationen finden Sie unter
"JSONStore-Sicherheitsdienstprogramme". 

### Größenbeschränkung
{: #size-limit }
Dieses Feature ist für die gemeinsame Nutzung
kleiner Zeichenfolgen, wie Kennwörter oder Cookies, bestimmt. Es wäre unklug, dieses Feature zu missbrauchen, denn der Versuch,
große Datenwerte zu ver- und entschlüsseln oder zu lesen und zu schreiben, beeinträchtigt die Leistung.

### Wartungsherausforderungen
{: #maintenance-challenges }
Android-Entwickler müssen sich darüber im Klaren sein, dass
die Aktivierung dieses Features oder das Ändern der Anwendungsfamilie dazu führt, dass für vorhandene Anwendungen, die unter einem anderen Familiennamen
installiert wurden, kein Upgrade mehr durchgeführt werden kann. Android erfordert aus Sicherheitsgründen, dass
Anwendungen deinstalliert werden müssen, bevor sie unter einem neuen Familiennamen installiert werden können.
