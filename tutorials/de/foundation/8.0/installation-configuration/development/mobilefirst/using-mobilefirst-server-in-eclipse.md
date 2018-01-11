---
layout: tutorial
title: MobileFirst Server in Eclipse
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
{{ site.data.keys.mf_server }} kann in die Eclipse-IDE integriert werden, um eine einheitlichere Entwicklungsumgebung zu schaffen.

* Sie können auch CLI-Funktionalität in Eclipse zugänglich machen.
Sehen Sie sich dazu das Lernprogramm [{{ site.data.keys.mf_server }} in Eclipse verwenden](../../../../application-development/using-mobilefirst-cli-in-eclipse) an.
* Darüber hinaus können Sie Adapter in Eclipse entwickeln (siehe Lernprogramm
[Adapter in Eclipse entwickeln](../../../../adapters/developing-adapters)).

### Server zu Eclipse hinzufügen
{: #adding-the-server-to-eclipse }
1. Wählen Sie in Eclipse in der Ansicht **Server** die Optionen **Neu → Server** aus.
2. Wenn es keine IBM Ordneroption gibt, klicken Sie auf "Zusätzliche Serveradapter herunterladen".
3. Wählen Sie **WebSphere Application Server Liberty Tools** aus und folgen Sie den angezeigten Anweisungen.
4. Wählen Sie in Eclipse in der Ansicht **Server** die Optionen **Neu → Server** aus.
5. Wählen Sie **IBM → WebSphere Application Server Liberty** aus.
6. Geben Sie einen Namen und einen Hostnamen für den Server ein und klicken Sie auf **Weiter**.
7. Geben Sie den Pfad zum Serverstammverzeichnis an und wählen Sie die zu verwendende JRE-Version aus. Wenn Sie das
{{ site.data.keys.mf_dev_kit }} verwenden, ist der Ordner **[Installationsverzeichnis]/mfp-server** das Stammverzeichnis.
8. Klicken Sie auf **Weiter** und dann auf **Fertigstellen**.

Jetzt können Sie {{ site.data.keys.mf_server }} in der Eclipse-Ansicht "Server" starten und stoppen.
