---
layout: tutorial
title: Instalando e configurando o MobileFirst Analytics Server	
breadcrumb_title: Instalando o MobileFirst Analytics Server
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O {{ site.data.keys.mf_analytics_server }} é entregue como dois arquivos WAR separados. Por conveniência na implementação no WebSphere Application Server ou no WebSphere Application Server Liberty, o {{ site.data.keys.mf_analytics_server }} também é entregue como um arquivo EAR que contém os dois arquivos WAR.

> **Nota:** Não instale mais de uma instância do {{ site.data.keys.mf_analytics_server }} em uma única máquina host. Para obter informações adicionais sobre como gerenciar seu cluster, consulte a documentação do Elasticsearch.

Os arquivos WAR e EAR de análise de dados são incluídos com a instalação do MobileFirst Server. Para obter informações adicionais, consulte Estrutura de distribuição do MobileFirst Server. Quando você implementar o arquivo WAR, o MobileFirst Analytics Console ficará disponível em: `http://<hostname>:<port>/analytics/console`, por exemplo: `http://localhost:9080/analytics/console`.

* Para obter informações adicionais sobre como instalar o {{ site.data.keys.mf_analytics_server }}, consulte [Guia de instalação do {{ site.data.keys.mf_analytics_server }}](installation).
* Para obter informações adicionais sobre como configurar o IBM MobileFirst Analytics, consulte [Guia de configuração](configuration).
