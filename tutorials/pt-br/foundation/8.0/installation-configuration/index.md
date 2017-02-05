---
layout: tutorial
title: Instalação e configuração
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O {{site.data.keys.product_full }} fornece ferramentas de desenvolvimento e componentes do lado do servidor que podem ser instalados no local ou implementados em nuvem para uso de teste ou produção. Revise os tópicos de instalação apropriados para seu cenário de instalação.

### Instalando um ambiente de desenvolvimento
{: #installing-a-development-environment }
Se você desenvolver o lado do cliente ou o lado do servidor de aplicativos móveis, use o serviço [{{site.data.keys.mf_dev_kit }}](development/mobilefirst/) ou [{{site.data.keys.mf_bm }}](../bluemix/using-mobile-foundation) para iniciar. 

* [Configurar o ambiente de desenvolvimento do MobileFirst](development/mobilefirst/)
* [Configurar o ambiente de desenvolvimento do Cordova](development/cordova)
* [Configurar o ambiente de desenvolvimento do iOS](development/ios)
* [Configurar o ambiente de desenvolvimento do Android](development/android)
* [Configurar o ambiente de desenvolvimento do Windows](development/windows)
* [Configurar o ambiente de desenvolvimento do Xamarin](development/xamarin)
* [Configurar o ambiente de desenvolvimento da Web](development/web)

### Instalando um servidor de teste ou de produção no local
{: #installing-a-test-or-production-server-on-premises }
As instalações da IBM são baseadas em um produto IBM chamado IBM Installation Manager. Instale o IBM Installation Manager V1.8.4 ou mais recente separadamente antes de instalar o {{site.data.keys.product }}.

> **Importante:** Certifique-se de usar o IBM Installation Manager V1.8.4 ou mais recente. As versões mais antigas do Installation Manager não são capazes de instalar o {{site.data.keys.product }} {{site.data.keys.product_version }}, porque as operações de pós-instalação do produto requerem o Java 7. As versões mais antigas do Installation Manager vêm com o Java 6.

O instalador do {{site.data.keys.mf_server }} copia no seu computador todas as ferramentas e bibliotecas necessárias para a implementação de componentes do
{{site.data.keys.mf_server }} e, opcionalmente, {{site.data.keys.mf_app_center_full }} em seu servidor de aplicativos.

Se você instalar um servidor de teste ou de produção, comece com **Tutoriais sobre a instalação do {{site.data.keys.mf_server }}** abaixo para uma instalação simples e para saber sobre a instalação do {{site.data.keys.mf_server }}. Para obter informações adicionais sobre como preparar uma instalação para seu ambiente específico, consulte [Instalando o {{site.data.keys.mf_server }} para um ambiente de produção](production).

**Tutoriais sobre a instalação do {{site.data.keys.mf_server }}**  
Saiba sobre o processo de instalação do {{site.data.keys.mf_server }} lendo as instruções para criar um {{site.data.keys.mf_server }} funcional, um cluster com dois nós no perfil Liberty do WebSphere Application Server. A instalação pode ser feita de duas maneiras:

* [Usando o modo gráfico do IBM Installation Manager](production/tutorials/graphical-mode) e o Server Configuration Tool.
* [Usando a ferramenta de linha de comandos](production/tutorials/command-line).

Posteriormente, você terá um {{site.data.keys.mf_server }} em funcionamento. Entretanto, é necessário configurá-lo, principalmente para segurança, antes de usar o servidor. Para obter informações adicionais, consulte
[Configurando {{site.data.keys.mf_server }}](production/server-configuration).

**Adições
**  

* Para incluir o {{site.data.keys.mf_analytics_server }} em sua instalação, consulte o [guia de instalação do {{site.data.keys.mf_analytics_server }}](production/analytics/installation/).  
* Para instalar o {{site.data.keys.mf_app_center }}, consulte [Instalando e configurando o Application Center](production/appcenter).

### Implementando {{site.data.keys.mf_server }} na nuvem
{: #deploying-mobilefirst-server-to-the-cloud }
Se você planeja implementar o {{site.data.keys.mf_server }} na nuvem, consulte as seguintes opções:

* [Usando o {{site.data.keys.mf_server }} no IBM Bluemix](../bluemix).
* [Usando o {{site.data.keys.mf_server }} no IBM PureApplication](production/pure-application).

### Atualizando a Partir de Versões Anteriores
{: #upgrading-from-earlier-versions }
Para obter mais informações sobre como fazer upgrade de instalações e aplicativos existentes para uma versão mais nova, consulte
[Fazer upgrade para o {{site.data.keys.product_full }} {{site.data.keys.product_version }}](../all-tutorials/#upgrading_to_current_version).


