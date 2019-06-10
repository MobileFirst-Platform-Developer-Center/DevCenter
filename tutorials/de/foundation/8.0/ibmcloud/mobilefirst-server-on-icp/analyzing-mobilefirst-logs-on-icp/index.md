---
layout: tutorial
title: MobileFirst-Protokollnachrichten in IBM Cloud Private analysieren
breadcrumb_title: Analyzing MobileFirst log messages
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Wenn Sie in {{ site.data.keys.prod_adj }}-Implementierungen in {{ site.data.keys.prod_icp }} das zugrunde liegende Liberty mit Konsolenprotokollierung im JSON-Format ausführen, können Protokollereignisse in Felder aufgegliedert und in Elasticsearch gespeichert werden. Sie können Kibana verwenden, um mehrere Liberty-Pods mit Dashboards und Suchfunktionen zu überwachen. Eine große Anzahl von Protokolleinträgen können Sie auch mit Abfragen filtern. 

Eine Kubernetes-Implementierung besteht aus Pods, die sich aus Containern zusammensetzen. In {{ site.data.keys.prod_icp }} wird die Konsolenausgabe jedes Pods automatisch an den integrierten Elastic Stack für Protokolle weitergeleitet. Weitere Informationen zum Elastic Logging finden Sie unter [{{ site.data.keys.prod_icp }} logging](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_metrics/logging_elk.html).


## Vorgehensweise
{: #procedure}

Führen Sie die folgenden Schrite aus, um den IBM Cloud-Private-Katalog anzuzeigen und das entsprechende Helm-Chart auszuwählen, das Sie für die Implementierung von Anwendungen verwenden werden. 

1.  Aktivieren Sie die JSON-Protokollierung für Ihr Helm-Chart.

      a.  Klicken Sie in der IBM Cloud-Private-Konsole auf **Menu > Catalog**.<br/>
      b.  Wählen Sie im Abschnitt **Logs** das Helm-Chart **ibm-mfpfp-server-prod / ibm-mfpfp-analytics-prod / ibm-mfpf-appcenter-prod** aus. <br/>
          **Hinweis:** Wenn Sie auf die Konsole zugreifen und Ihr Helm-Katalog nicht dieses Helm-Chart enthält, wählen Sie **Manage > Helm Repositories** aus und klicken Sie auf die Schaltfläche für die Synchronisation der Repositorys, um die Kataloganzeige zu aktualisieren.


      c.  Setzen Sie die Protokollierungsfelder auf die folgenden Standardwerte. Alternativ können Sie die bisherigen Werte definieren, wenn Sie das {{ site.data.keys.prod_adj }}-Helm-Chart über die Befehlszeile unter Verwendung der Option `--set` implementieren. <br/>
      <p><b>Helm-Chart-Felder und -Werte für die JSON-Protokollierung</b></p>            
      <table class="table table-bordered" >
        <thead>
          <tr>
            <th>Feldname der GUI</th>
            <th> Feldname der Befehlszeile</th>
            <th>Feldwert</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Console logging format </td>
            <td>logs.consoleFormat</td>
            <td>json</td>
          </tr>
          <tr>
            <td>Console logging level</td>
            <td>logs.consoleLogLevel</td>
            <td>info</td>
          </tr>
          <tr>
            <td>Console logging source</td>
            <td>logs.consoleLogLevel</td>
            <td>message, trace, accessLog, ffdc<br/><br/>Unterstützte Quellentypen: messages, traces, accessLog und ffdc. <br/>Geben Sie die einzelnen Quellentypen im Feld "Console logging source" jeweils durch ein Komma getrennt an. <br/>Wenn Sie accessLog verwenden, sind zusätzliche Einstellungen in der Datei <code>server.xml</code> erforderlich. <br/>Weitere Informationen finden Sie unter <a href="https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/rwlp_http_accesslogs.html?view=kc">HTTP access logging</a>.</td>
          </tr>
        </tbody>
      </table>
2.  Implementieren Sie Kibana.<br/>
    Wenn Sie Liberty mit aktivierter JSON-Protokollierung implementiert haben, werden Protokolleinträge in Elasticsearch gespeichert. Sie können die Protokolleinträge mit Kibana anzeigen. <br/>

      a.  Klicken Sie zum Implementieren von Kibana in der Konsole auf **Catalog > Helm Charts**.<br/>
      b.  Wählen Sie das Helm-Chart **ibm-icplogging-kibana** aus und klicken Sie im Ziel-Namespace auf **kube-system**. <br/>
      c.  Klicken Sie auf **Install**.<br/>

3.  Öffnen Sie Kibana.<br/>

      a.  Klicken Sie in der Konsole auf **Network Access > Services**.<br/>
      b.  Wählen Sie in der Liste der Services **Kibana** aus.<br/>
      c.  Klicken Sie auf den Link im Feld **Node port**, um Kibana zu öffnen.<br/>

4.  Erstellen Sie in Kibana ein Indexmuster.<br/>

      a.  Klicken Sie in Kibana auf **Management > Index Patterns**. Geben Sie als Indexnamen oder -muster `logstash-*` ein.<br/>
      b.  Wählen Sie **ibm_datetime** als Namen für das Feld *Time Filter* aus.<br/>
      c.  Klicken Sie auf **Create**.<br/>

5. Sie können eigene Abfragen, Darstellungen oder Dashboards für die Analyse der Protokolldaten erstellen.

6. [Hier](https://github.com/WASdev/sample.dashboards) können Sie einige Beispieldashboards herunterladen. Wenn Sie Dashboards in Kibana importieren möchten, wählen Sie **Management > Saved Objects** aus und klicken Sie auf **Import**.

## Weiterführende Informationen
{: #further_reading}

* [Liberty logging in {{ site.data.keys.prod_icp }}](https://www.ibm.com/support/knowledgecenter/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_logging.html?view=kc)
