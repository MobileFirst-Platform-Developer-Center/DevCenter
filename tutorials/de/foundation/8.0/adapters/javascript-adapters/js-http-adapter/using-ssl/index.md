---
layout: tutorial
title: SSL in JavaScript-HTTP-Adaptern verwenden
breadcrumb_title: Using SSL
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
In einem HTTP-Adapter können Sie für die Verbindung zu Back-End-Services SSL mit einfacher und gegenseitiger Authentifizierung verwenden.  
SSL steht für die Sicherheit auf Transportebene, die nicht von der Basisauthentifizierung abhängig ist. Die Basisauthentifizierung kann über HTTP oder HTTPS erfolgen.


1. Setzen Sie das URL-Protokoll des HTTP-Adapters in der Datei adapter.xml auf <b>https</b>.
2. Speichern Sie SSL-Zertifikate im Keystore von {{ site.data.keys.mf_server }} (siehe [Keystore von {{ site.data.keys.mf_server }} konfigurieren](../../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/)). 

### SSL mit gegenseitiger Authentifizierung
{:# ssl-with-mutual-authentication }

Wenn Sie SSL mit gegenseitiger Authentifizierung verwenden, müssen Sie zusätzlich die folgenden Schritte ausführen:

1. Generieren Sie Ihren eigenen privaten Schlüssel für den HTTP-Adapter oder verwenden Sie einen privaten Schlüssel von einer vertrauenswürdigen Stelle.
2. Wenn Sie einen eigenen privaten Schlüssel generiert haben, exportieren Sie das öffentliche Zertifikat dieses generierten Schlüssels und importieren Sie es in den Back-End-Truststore.
3. Definieren Sie im Element `connectionPolicy` der Datei **adapter.xml** einen Alias und ein Kennwort für den privaten Schlüssel.  
