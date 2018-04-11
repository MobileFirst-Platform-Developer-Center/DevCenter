---
layout: tutorial
title: Instalação e configuração
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O {{ site.data.keys.product_full }} fornece ferramentas de desenvolvimento e componentes do lado do servidor que podem ser instalados no local ou implementados em nuvem para uso de teste ou produção. Revise os tópicos de instalação apropriados para seu cenário de instalação.

### Configurando um Ambiente de Desenvolvimento
{: #installing-a-development-environment }
Se você desenvolver o lado do cliente ou o lado do servidor de aplicativos móveis, use os serviços [{{ site.data.keys.mf_dev_kit }}](development/mobilefirst/) ou [{{ site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation) para começar.

**Usando o {{ site.data.keys.mf_dev_kit }}**
{: #using-the-dev-kit }

O {{ site.data.keys.mf_dev_kit }} inclui tudo o que é necessário para executar e depurar aplicativos móveis em uma estação de trabalho pessoal. Para desenvolver um aplicativo usando o {{ site.data.keys.mf_dev_kit }}, siga as instruções do tutorial [Configurando o ambiente de desenvolvimento do MobileFirst](development/mobilefirst).

**Usando o {{ site.data.keys.mf_bm }}**
{: #using-mf-bluemix }

O serviço {{ site.data.keys.mf_bm }} fornece uma funcionalidade semelhante à do {{ site.data.keys.mf_dev_kit }}, no entanto, o serviço é executado no IBM Cloud.

**Configurando o ambiente de desenvolvimento para aplicativos {{ site.data.keys.product }}**
{: #setting-dev-env-mf-apps }

O {{ site.data.keys.product }} fornece uma grande flexibilidade a respeito das plataformas e ferramentas que podem ser usadas para desenvolver aplicativos {{ site.data.keys.product }}. No entanto, algumas configurações básicas são necessárias para permitir que as ferramentas escolhidas interajam com o {{ site.data.keys.product }}.  

Selecione a partir dos seguintes links para configurar o ambiente de desenvolvimento correspondente à abordagem de desenvolvimento que será usada pelo aplicativo:

* [Configurar o ambiente de desenvolvimento do Cordova](development/cordova)
* [Configurar o ambiente de desenvolvimento do iOS](development/ios)
* [Configurar o ambiente de desenvolvimento do Android](development/android)
* [Configurar o ambiente de desenvolvimento do Windows](development/windows)
* [Configurar o ambiente de desenvolvimento do Xamarin](development/xamarin)
* [Configurar o ambiente de desenvolvimento da Web](development/web)

### Configurando localmente um servidor de teste ou de produção
{: #installing-a-test-or-production-server-on-premises }

A primeira parte da instalação do servidor {{ site.data.keys.product }} usa um produto IBM chamado IBM Installation Manager. O IBM Installation Manager v1.8.4 ou posterior deve ser instalado antes da instalação dos componentes do servidor {{ site.data.keys.product }}.

> **Importante:** Certifique-se de usar o IBM Installation Manager V1.8.4 ou mais recente. As versões mais antigas do Installation Manager não são capazes de instalar o {{ site.data.keys.product }} {{ site.data.keys.product_version }}, porque as operações de pós-instalação do produto requerem o Java 7. As versões mais antigas do Installation Manager vêm com o Java 6.

O assistente de instalação do {{ site.data.keys.mf_server }} usa o IBM Installation Manager para inserir todos os componentes do servidor no servidor.  As ferramentas e bibliotecas necessárias para implementar os componentes do servidor {{ site.data.keys.product }} para o uso do servidor de aplicativos também são instaladas.  Como uma melhor prática, não instale todos os componetes na mesma instância do servidor de aplicativos, exceto em casos de um servidor de desenvolvimento. As ferramentas de implementação permitem a seleção dos componentes a serem instalados.  Consulte os [Fluxos de redes e topologias](production/prod-env/topologies) para conferir pontos a serem considerados antes de instalar o servidor.

Leia abaixo para obter informações sobre como preparar e instalar o {{site.data.keys.mf_server }} e serviços opcionais em seu ambiente específico. Para uma configuração simples, leia o tutorial [Configurando um ambiente de teste ou produção](production).

* [Verificando Pré-requisitos](production/prod-env/prereqs)
* [Visão geral dos componentes dos {{ site.data.keys.mf_server }}](production/prod-env/topologies)
* Fatores a serem considerados antes de carregar ferramentas e bibliotecas para implementar componentes do servidor MobileFirst e, opcionalmente, do Centro de Aplicativos
  * Licença de Token
  * Centro de Aplicativos do MobileFirst Foundation
  * Modo de administrador versus modo de usuário
* Estrutura de distribuição do servidor MobileFirst após o carregamento de arquivos
* Carregando arquivos
  * usando o assistente de instalação do IBM Installation Manager
  * executando o IBM Installation Manager na linha de comandos
  * usando arquivos de reposta XML - instalação silenciosa
* [Configurando bancos de dados de backend para componetes do servidor MobileFirst Foundation](production/prod-env/databases)
* [Instalando o servidor MobileFirst em um servidor de aplicativos](production/prod-env/appserver)
* [Configurando o servidor MobileFirst](production/server-configuration)
* [Instalando o servidor MobileFirst Analytics](production/analytics/installation)
* [Instalando o Application Center](production/appcenter)
* [Implementando o servidor MobileFirst no IBM PureApplication System](production/pure-application)

### Configurando um ambiente de teste ou de produção
{: #setting-up-test-or-production-server}

Saiba mais sobre o processo de instalação do {{ site.data.keys.mf_server }} analisando as instruções para a criação de um cluster {{ site.data.keys.mf_server }} funcional com dois nós no perfil do WebSphere Application Server Liberty. A instalação pode ser concluída usando as ferramentas gráficas (GUI) ou através da linha de comandos.

* [Instalação do modo GUI com o IBM Installation Manager e o Server Configuration Tool](production/simple-install/tutorials/graphical-mode).
* [Instalação da linha de comandos com a ferramenta de linha de comandos](production/simple-install/tutorials/command-line).

Após concluir a instalação usando um dos dois métodos acima, [configurações](production/server-configuration) adicionais podem ser necessárias para concluir a configuração, dependendo dos requisitos.

### Configurando recursos opcionais em seu ambiente de teste ou de produção
{: #setting-up-optional-features-test-or-production-server}

O {{ site.data.keys.product }} inclui componentes opcionais que podem ser usados para aumentar seu ambiente de teste ou de produção.  Consulte os seguintes tutoriais para obter mais informações:

* [Instalando e configurando o {{ site.data.keys.mf_analytics_server }}](production/analytics/installation/)
* [Instalando e configurando o {{ site.data.keys.mf_app_center }}](production/appcenter)

### Implementando um ambiente de teste ou de produção do {{ site.data.keys.mf_server }} na nuvem.
{: #deploying-mobilefirst-server-test-or-production-on-the-cloud }

Se você planeja implementar o {{ site.data.keys.mf_server }} na nuvem, consulte as seguintes opções:

* [Usando o {{ site.data.keys.mf_server }} no IBM Cloud](../bluemix).
* [Usando o {{ site.data.keys.mf_server }} no IBM PureApplication](production/pure-application).

### Atualizando a Partir de Versões Anteriores
{: #upgrading-from-earlier-versions }
Para obter mais informações sobre como fazer upgrade de instalações e aplicativos existentes para uma versão mais nova, consulte
[Fazer upgrade para o {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).
