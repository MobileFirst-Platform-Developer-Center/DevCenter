---
layout: tutorial
title: MobileFirst Server
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão geral
{: #overview }
O {{ site.data.keys.mf_server }}
consiste em vários componentes. Uma visão geral da arquitetura do {{ site.data.keys.mf_server }} é fornecida para você entender as funções de cada componente.

Diferentemente do {{ site.data.keys.mf_server }} V7.1 ou anterior, o processo de instalação da V8.0.0 é separado do desenvolvimento e implementação de operações de aplicativos móveis. Na V8.0.0, após os componentes do servidor e o banco de dados serem instalados e configurados, o {{ site.data.keys.mf_server }} pode ser operado para a maioria das operações, sem a necessidade de acessar o servidor de aplicativos ou a configuração do banco de dados.

As operações de administração e implementação dos artefatos do {{ site.data.keys.product_adj }} são feitas por meio do
{{ site.data.keys.mf_console }} ou API REST do serviço de administração do {{ site.data.keys.mf_server }}. As operações também podem ser executadas usando algumas ferramentas de linha de comandos que agrupam essa API, como mfpdev ou mfpadm. Os usuários autorizados do {{ site.data.keys.mf_server }} podem modificar a configuração do lado do servidor dos aplicativos móveis, fazer upload ou configurar código do lado do servidor (os adaptadores), fazer upload de novos recursos da web para aplicativos móveis Cordova, executar operações de gerenciamento de aplicativo e muito mais.

{{ site.data.keys.mf_server }} oferece camadas extra de segurança, além de camadas de segurança da infraestrutura de rede ou do servidor de aplicativos. Os recursos de segurança incluem controle de autenticidade do aplicativo e controle de acesso para recursos do lado do servidor e adaptadores. Essas configurações de segurança também podem ser feitas pelos usuários autorizados do {{ site.data.keys.mf_console }} e serviço de administração. Você determina a autorização dos administradores do {{ site.data.keys.product_adj }} mapeando-os para funções de segurança, conforme descrito em [Configurando autenticação do usuário para administração do {{ site.data.keys.mf_server }}](../../../installation-configuration/production/server-configuration).

Uma versão simplificada do {{ site.data.keys.mf_server }}, que vem pré-configurada e não precisa de pré-requisitos de software, como banco de dados ou servidor de aplicativos, está disponível para desenvolvedores. Consulte [Configurando o {{ site.data.keys.product_adj }} Development Server](../../../installation-configuration/development).

## Componentes do {{ site.data.keys.mf_server }}
{: #mobilefirst-server-components }
A arquitetura dos componentes do {{ site.data.keys.mf_server }} é ilustrada como a seguir:

![Componentes que formam o {{ site.data.keys.mf_server }}](server_components.jpg)

### Componentes principais do {{ site.data.keys.mf_server }}
{: #core-components-of-mobilefirst-server }
{{ site.data.keys.mf_console }}, o serviço de administração do
{{ site.data.keys.mf_server }}, o serviço de atualização em tempo real do {{ site.data.keys.mf_server }}, os artefatos do {{ site.data.keys.mf_server }} e o tempo de execução do {{ site.data.keys.product_adj }} são o conjunto mínimo de componentes para instalar. 

* O tempo de execução fornece os serviços do {{ site.data.keys.product_adj }} para os aplicativos móveis que são executados em dispositivos móveis.
* O serviço de administração fornece recursos de configuração e administração. Você usa o serviço de administração por meio do {{ site.data.keys.mf_console }}, da API de REST do serviço de atualização em tempo real ou das ferramentas de linha de comandos, como mfpadm ou mfpdev. 
* O serviço de atualização em tempo real gerencia dados de configuração e é usado pelo serviço de administração.

Esses componentes requerem um banco de dados. O nome da tabela de banco de dados para cada componente não tem interseção. Dessa forma, é possível usar o mesmo banco de dados ou até o mesmo esquema para armazenar todas as tabelas desses componentes. Para obter mais informações, consulte [Configurando bancos de dados](../../../installation-configuration/production/server-configuration).

É possível instalar mais de uma instância do tempo de execução. Nesse caso, cada instância precisa de seu próprio banco de dados. O componente de artefatos fornece recursos para {{ site.data.keys.mf_console }}. Isso não requer um banco de dados.

### Componentes opcionais do {{ site.data.keys.mf_server }}
{: #optional-components-of-mobliefirst-server }
O serviço de push do {{ site.data.keys.mf_server }} fornece recursos de notificação push. Deve ser instalado para permitir que estes recursos de aplicativos móveis utilizem os recursos push do {{ site.data.keys.product_adj }}. A partir
da perspectiva dos aplicativos móveis, a URL do serviço de push é a mesma que a URL do tempo de execução, exceto que sua raiz de contexto
é `/imfpush`.

Se você pretende instalar o serviço de push em um servidor ou cluster diferente do tempo de execução, é
necessário configurar as regras de roteamento de seu servidor HTTP. A configuração é para assegurar que as solicitações para o serviço de push e o tempo de execução sejam roteadas corretamente. 

O serviço de push requer um banco de dados. As tabelas do serviço de push não têm interseção com as tabelas de tempo de execução, serviço de administração e serviço de atualização em tempo real. Assim, elas também podem ser instaladas no mesmo banco
de dados ou esquema.

O serviço {{ site.data.keys.mf_analytics }} e o {{ site.data.keys.mf_analytics_console }} fornecem informações de monitoramento e de análise de dados sobre o uso de aplicativos móveis. Aplicativos móveis podem fornecer mais insight usando o Logger SDK. O serviço {{ site.data.keys.mf_analytics }} não precisa de um banco de dados. Ele armazena seus dados localmente em disco usando Elasticsearch. Os dados são estruturados em shards que podem
ser replicados entre os membros de um cluster do serviço Analytics.

Para obter mais informações sobre os fluxos de rede e as restrições de topologia para esses componentes, consulte [Topologias e fluxos de rede](../../../installation-configuration/production/server-configuration).

### Processo de instalação
{: #installation-process }
A instalação do {{ site.data.keys.mf_server }} no local pode ser feita das seguintes maneiras:

* O Server Configuration Tool, um assistente gráfico
* Tarefas Ant por meio de ferramentas de linha de comandos
* Instalação manual

Para obter mais informações sobre a instalação do {{ site.data.keys.mf_server }} no local, consulte:

* Um [guia por uma instalação completa](../../../installation-configuration/production/) do {{ site.data.keys.mf_server }} farm no perfil Liberty do WebSphere Application Server. O guia é baseado em um cenário simples para você experimentar a instalação no modo gráfico ou no modo de linha de comandos.
* Uma [seção detalhada](../../../installation-configuration/production/) que contém detalhes sobre os pré-requisitos de instalação, a configuração do banco de dados, as topologias de servidor, a implementação dos componentes no servidor de aplicativos e a configuração do servidor.

