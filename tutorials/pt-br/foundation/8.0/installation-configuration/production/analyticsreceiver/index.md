---
layout: tutorial
title: Instalando e configurando o MobileFirst Analytics Receiver Server
breadcrumb_title: Instalando o MobileFirst Analytics Receiver Server
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O servidor Mobile Analytics Receiver é um servidor opcional que pode ser implementado para enviar Eventos do Mobile Foundation Analytics por meio de aplicativos clientes móveis em vez de para o tempo de execução do Mobile Foundation Server. Essa opção de implementação permite transferir o processamento de eventos analíticos por meio do tempo de execução do servidor Mobile Foundation, permitindo assim que os recursos sejam totalmente utilizados para funções de tempo de execução.  

O {{ site.data.keys.mf_analytics_receiver_server }} é entregue como um arquivo WAR único. É necessário instalá-lo em servidor separado. É possível instalá-lo com um dos seguintes métodos:

* Instalação com tarefas Ant
* Manual de Instalação

Depois que você instalou o {{ site.data.keys.mf_analytics_receiver_server }} no servidor de aplicativos da web de sua preferência, uma configuração adicional deve ser feita. Para obter mais informações, consulte Configurando o {{ site.data.keys.mf_analytics_receiver_server }} após a instalação abaixo. Se você escolher uma configuração manual no instalador, consulte a documentação para o servidor de aplicativos de sua preferência.

> **Nota:** Não instale mais de uma instância do {{ site.data.keys.mf_analytics_receiver_server }} em uma única máquina host.

O arquivo WAR do receptor de analítica é incluído com a instalação do MobileFirst Server. Para obter informações adicionais, consulte Estrutura de distribuição do MobileFirst Server.

* Para obter mais informações sobre como instalar o {{ site.data.keys.mf_analytics_receiver_server }}, consulte [Guia de instalação do {{ site.data.keys.mf_analytics_receiver_server }}](installation).
* Para obter mais informações sobre como configurar o IBM MobileFirst Analytics Receiver, consulte [Guia de configuração](configuration).
