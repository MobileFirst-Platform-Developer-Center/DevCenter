---
layout: tutorial
title: Häufig gestellte Fragen
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

In diesem Abschnitt finden Sie eine Auflistung häufig gestellter Fragen im Zusammenhang mit {{site.data.keys.mf_analytics_server }}. 

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	Wie lege ich die Anzahl de Shards und Replikate für meinen Analytics-Cluster fest?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>In einem Elasticsearch-Cluster mit mehreren Indizes ist es wichtig, Folgendes zu definieren:
                <ul><li>Die Mindestanzahl der Shards muss auf die Anzahl der Knoten im Cluster gesetzt werden.</li><li>Pro Shard müssen mindestens zwei Replikate festgelegt werden.</li></ul><br/>MobileFirst Analytics Version 8.0 verwendet mehrere Indizes, um die Ereignisdaten zu speichern.</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. In MobileFirst Analytics Version 8.0 enthält die Konfiguration in der Datei <code>server.xml</code> 3 festgelegte Shards. Auf der Verwaltungsseite der Analytics Console werden jedoch mehr als 15 Shards angezeigt.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>In MobileFirst Analytics Version 8.0 hat der Elasticsearch-Datenspeicher mehrere Indizes. Es handelt sich nicht um einen Datenspeicher, der auf nur einem Index basiert. Je nach Art der Ereignisse, die in die Analyse einfließen, werden dynamisch Indizes erstellt. Die Endbenutzer müssen also nicht wegen der zahlreichen Indizes besorgt sein. Jeder Index innerhalb von Elasticsearch wird gemäß der in der Konfigurationsdatei festgelegten Anzahl von Shards aufgeteilt. </p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. Warum erfolgt die Wiedergabe in der Analytics Console so langsam?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p>Sie müssen mit dem <a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">Hardware Sizing Calculator</a> überprüfen, ob die Hardware für die Daten und Anforderungen des Kunden ausreichend ist. Die Leistung des Systems wird durch verschiedene Faktoren beeinflusst, zu denen die Hardware gehört sosie der Typ oder die Größe von Datenereignissen, die zum Analyseserver gelangen, und der Umfang dieser Ereignisse.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. Kann ich gelöschte Daten wiederherstellen?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>Nein. Wenn die Daten gelöscht sind, können sie nicht wiederhergestellt werden.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. Daten werden unabhängig von der Festlegung von TTL-Werten nicht ordnungsgemäß gelöscht.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>Die TTL-Eigenschaften werden nicht auf Daten der Analytics-Plattform angewendet. Sie müssen die TTL-Eigenschaften festlegen, bevor Sie Daten hinzufügen.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. In der Analytics Console werden keine Daten angezeigt.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>Stellen Sie sicher, dass mit den JNDI-Eigenschaften von MobileFirst Server die richtigen Analytics-Endpunkte konfiguriert wurden. Vergewissern Sie sich, dass der Datumsfilter für die anzuzeigenden Daten ordnungsgemäß definiert ist.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. Die REST-APIs des Elasticsearch-Clusters können nicht aufgerufen werden.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>Zum Aufrufen der REST-APIs von Elasticsearch muss die Eigenschaft <b>analytics/http.enabled</b> in der Datei <code>server.xml</code> von Analytics Server auf <b>true</b> gesetzt sein. </p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	Kann ich für Analytics OpenJDK mit IBM WebSphere Application Server ND (oder Full Profile) verwenden?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>Nein. Wenn Sie IBM WebSphere Application Server Full Profile oder Network Deployment (ND) verwenden, müssen Sie das IBM JDK verwenden, das zusammen mit WebSphere Application Server bereitgestellt wird.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	Wann erhöht sich die Anzahl der <b>App-Sitzungen</b>?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>Wenn die Anwendung zum ersten Mal geöffnet wird, gibt es null <b>App-Sitzungen</b>. Wenn der Endbenutzer die mobile App in den Hintergrund stellt und dann wieder in den Vordergrund holt, erhöht diese Aktion die Anzahl der <b>App-Sitzungen</b> auf 1. Bei jeder Wiederholung dieser Aktion erhöht sich die Anzahl der <b>App-Sitzungen</b> weiter.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	Was bedeutet es, wenn für den Zustand des Analytics-Clusters GELB angezeigt wird?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>Die Anzeige von GELB für den Clusterzustand muss kein Problem sein. Meistens gibt es nicht zugeordnete Shards, wenn für den Clusterzustand GELB angezeigt wird. Wenn neue Knoten in den Cluster aufgenommen werden, ordnet Elasticsearch nicht zugeordnete Shards den neuen Knoten zu. Dadurch wechselt der Clusterzustand zu GRÜN. Wenn es zu viele Shards gibt, kann es vorkommen, dass einige der Shards keinem Knoten zugeordnet werden. In dem Fall wird GELB für den Clusterzustand angezeigt. Stellen Sie sicher, dass alle Knoten im Cluster aktiv sind und ordnungsgemäß funktionieren und dass die Shards den Zustand "gestartet/aktiv" haben. </p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	Was bedeuten App-Sitzungen für Web-Apps?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>Bei Web-Apps wird die Anzahl der App-Sitzungen ausgehend von den Browsersitzungen erhöht und basiert auf der Verbindung vom Browser (d. h. von der App) zu MFP Server.</p>

                  <p>Wenn der Browser das allgemeine Fenster bzw. die allgemeine Registerkarte verwendet und eine Verbindung zum Server herstellt, wird die Anzahl der App-Sitzungen um eins erhöht. Wenn der Benutzer die App in demselben Browser auf einer anderen Registerkarte öffnet und die Verbindung herstellt, erhöht sich die Anzahl der Sitzungen nicht. Die Sitzung bleibt für 30 Minuten inaktiv. Wenn Sie versuchen, die Verbindung erneut herzustellen, wird die Anzahl um eins erhöht.</p>

                  <p>Wenn der Benutzer den Browser-Cache löscht und dann versucht, eine Verbindung herzustellen, wird das Gerät als neues Gerät angesehen, sodass sich die Geräteanzal erhöht. Da Browser keine reale Geräte-ID haben, wird eine ID für die Browser-App generiert, bis die Offlinedateien bzw. die Cache-Inhalte gelöscht werden. </p>

                  <p>Dies gilt auch für ein privates Browserfenster. Wenn Sie ein privates Browserfenster verwenden und versuchen, eine Verbindung herzustellen, wird jede App, die von einer Registerkarte aus eine Verbindung herstellt, als eine neue Sitzung betrachtet und somit die Sitzungsanzahl erhöht. Wenn der Benutzer zwei verschiedene Browser verwendet und auf die App zugreift, um eine Verbindung zu MFP Server herzustellen, wird der Gerätezähler um zwei erhöht.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	Was bedeutet <i>Aktive Benutzer</i> im Analytics-Dashboard?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>Aktive Benutzer</i> sind die Benutzer, die die App verwenden. Jeder eindeutige Benutzer wird als ein Benutzer, der die App verwendet, gezählt. Die Geräte-ID ist standardmäßig die Benutzer-ID. Der App-Entwickler kann allerdings die API <code>setUserContext(userid)</code> verwenden, um die Benutzer-ID durch den von ihm festgelegten Wert zu ersetzen. </p>

                  <p>Eine Lösung bzw. ein Ansatz ist, eine eindeutige ID vom Computer zu generieren, wenn der Benutzer auf die Web-App zugreift und der Computer dies als customData sendet. Diese Daten können genutzt werden, um die Statistik für die tatsächlichen Maschinen (oder Computer/Browser) zu berechnen, von denen aus der Benutzer auf die App zugreift und <code>setUserContext</code> verwendet, um die Benutzer-ID festzulegen. Mithilfe dieser Daten können auch kundenspezifische Diagramme generiert werden.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	Was bedeuten App-Sitzungen für native Apps bzw. Cordova-Apps?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>In Analytics 8.0 erfolgt die Berechnung von App-Sitzungen grundsätzlich anders als in den Vorgängerversionen von MFP Analytics.</p>

                  <p>Die Anzahl der App-Sitzungen wird um eins erhöht, wenn die App vom Hintergrund in den Vordergrund gebracht wird. Um dies für Cordova-Apps zu ermöglichen, müssen Ereignisse vom Typ CLIENT APP LIFECYCLE aktiviert werden. Weitere Informationen finden Sie <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">hier</a>. </p>
            </div>
        </div>      
    </div>
</div>       
