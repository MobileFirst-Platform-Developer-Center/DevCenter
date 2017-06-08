---
layout: tutorial
title: Instalando o MobileFirst Server para um ambiente de produção
breadcrumb_title: ambiente de produção
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Essa seção fornece detalhes para ajudar no planejamento e na preparação de uma instalação para seu ambiente específico.  
Para obter informações adicionais sobre a configuração do {{ site.data.keys.mf_server }}, consulte [Configurando o {{ site.data.keys.mf_server }}](server-configuration).

#### Ir para
{: #jump-to }

* [Pré-requisito](#prerequisites)
* [O que vem a seguir](#whats-next)

## Pré-Requisitos
{: #prerequisites }
Para uma instalação suave do {{ site.data.keys.mf_server }}, assegure-se de preencher todos os pré-requisitos de software.

**Sistema de Gerenciamento de Banco de Dados (DBMS)**  
Um DBMS é necessário para armazenar os dados técnicos dos componentes do {{ site.data.keys.mf_server }}. Deve-se usar um dos DBMS suportados:

* IBM DB2 
* MySQL
* Oracle

Para obter mais informações sobre as versões de DBMS que são suportadas pelo produto, consulte [Requisitos do sistema](../../product-overview/requirements). Se usar um DBMS relacional (IBM DB2, Oracle ou MySQL), você precisará de um driver JDBC para esse banco de dados durante o processo de instalação. Os drivers JDBC não são fornecidos pelo instalador do {{ site.data.keys.mf_server }}. Certifique-se de ter o driver JDBC.

* Para DB2, use o driver JDBC DB2 V4.0 (db2jcc4.jar).
* Para MySQL, use o driver JDBC Connector/J.
* Para Oracle, use o driver JDBC Oracle thin JDBC.

**Servidor de Aplicativos Java**  
Um servidor de aplicativos Java é necessário para a execução de aplicativos {{ site.data.keys.mf_server }}. É possível usar qualquer um dos seguintes servidores de aplicativos:

* WebSphere Application Server Liberty Core
* WebSphere Application Server Liberty Network Deployment
* WebSphere Application Server
* Apache Tomcat

Para obter mais informações sobre as versões de servidores de aplicativos suportadas pelo produto, consulte [Requisitos do sistema](../../product-overview/requirements). O servidor de aplicativos deve ser executado com Java 7 ou posterior. Por padrão, algumas versões do WebSphere Application Server são executadas com Java 6. Com esse padrão, elas não podem executar o {{ site.data.keys.mf_server }}

**IBM Installation Manager V1.8.4 ou posterior**  
Installation Manager é usado para executar o instalador do {{ site.data.keys.mf_server }}. Deve-se instalar o Installation Manager V1.8.4 ou posterior. As versões mais antigas do Installation Manager não são capazes de instalar o {{ site.data.keys.product_full }} {{ site.data.keys.product_version }}, porque as operações de pós-instalação do produto requerem o Java 7. As versões mais antigas do Installation Manager vêm com o Java 6.

Faça download do instalador do IBM Installation Manager V1.8.4 ou a partir dos [links de download do Installation Manager e Packaging Utility](http://www.ibm.com/support/docview.wss?uid=swg27025142).

**Repositório do Installation Manager para {{ site.data.keys.mf_server }}**  
É possível fazer download do repositório do {{ site.data.keys.product }} eAssembly no [IBM Passport Advantage](http://www.ibm.com/software/passportadvantage/pao_customers.htm). O nome do pacote é arquivo .zip do **IBM MobileFirst Foundation V{{ site.data.keys.product_V_R }} do Installation Manager Repository para IBM MobileFirst Platform Server**.

Talvez você também queira aplicar o fix pack mais recente que pode ser transferido por download do [Portal de Suporte IBM](http://www.ibm.com/support/entry/portal/product/other_software/ibm_mobilefirst_platform_foundation). O fix pack não pode ser instalado sem o repositório da versão base nos repositórios do Installation Manager.

O {{ site.data.keys.product }} eAssembly inclui os seguintes instaladores:

* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Para Liberty, também é possível usar IBM WebSphere SDK Java Technology Edition com o suplemento IBM WebSphere Application Server Liberty Core.

## O que Vem a Seguir
{: #whats-next }

* [Executando o IBM Installation Manager](installation-manager)
* [Configurando Bancos de Dados](databases)
* [Topologias e fluxos de rede](topologies)
* [Instalando o {{ site.data.keys.mf_server }} em um servidor de aplicativos](appserver)
