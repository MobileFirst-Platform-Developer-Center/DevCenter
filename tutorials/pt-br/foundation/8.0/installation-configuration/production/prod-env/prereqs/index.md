---
layout: tutorial
title: Pré-requisitos de Instalação
breadcrumb_title: Prerequisites
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Para obter uma instalação mais fácil do MobileFirst Server, assegure-se de preencher todos os pré-requisitos de software.

Antes de instalar o MobileFirst Server, é necessário ter o software a seguir.

* **Sistema de gerenciamento de banco de dados (DBMS)**
  Um DBMS é necessário para armazenar os dados técnicos dos componentes do MobileFirst Server. Deve-se usar um dos DBMS suportados:

  * IBM DB2
  * MySQL
  * Oracle

  Para obter mais informações sobre as versões de DBMS que são suportadas pelo produto, consulte [Requisitos do sistema](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). Se usar um DBMS relacional (IBM DB2, Oracle ou MySQL), você precisará de um driver JDBC para esse banco de dados durante o processo de instalação. Os drivers JDBC não são fornecidos pelo instalador do MobileFirst Server. Certifique-se de ter o driver JDBC.

  * Para DB2, use o driver JDBC DB2 V4.0 (db2jcc4.jar).
  * Para MySQL, use o driver JDBC Connector/J.
  * Para Oracle, use o driver JDBC Oracle thin JDBC.

* **Servidor de aplicativos Java™**
  Um servidor de aplicativos Java é necessário para executar os aplicativos MobileFirst Server. É possível usar qualquer um dos seguintes servidores de aplicativos:

  * WebSphere® Application Server Liberty Core
  * WebSphere Application Server Liberty Network Deployment
  * WebSphere Application Server
  * Apache Tomcat

  Para obter mais informações sobre as versões de servidores de aplicativos suportadas pelo produto, consulte [Requisitos do sistema](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.getstart.doc/start/r_supported_operating_systems_an.html). O servidor de aplicativos deve ser executado com Java 7 ou posterior. Por padrão, algumas versões do WebSphere Application Server são executadas com Java 6. Com esse padrão, elas não podem executar o MobileFirst Server.

* **IBM Installation Manager V1.8.4 ou mais recente**
  O Installation Manager é usado para executar o instalador do MobileFirst Server. Deve-se instalar o Installation Manager V1.8.4 ou posterior. As versões mais antigas do Installation Manager não são capazes de instalar o IBM MobileFirst Platform Foundation V8.0 porque as operações pós-instalação do produto requerem Java 7. As versões mais antigas do Installation Manager vêm com Java 6.

  Faça download do instalador do IBM Installation Manager V1.8.4 ou a partir dos [links de download do Installation Manager e Packaging Utility](http://www-01.ibm.com/support/docview.wss?uid=swg27025142).

* **Repositório do Installation Manager para o MobileFirst Server**
  É possível fazer download do repositório do IBM MobileFirst Platform Foundation eAssembly no [IBM Passport Advantage](https://www-01.ibm.com/software/passportadvantage/pao_customers.htm). O nome do pacote é o arquivo `IBM MobileFirst Platform Foundation V8.0.zip` do Installation Manager Repository para o IBM MobileFirst Platform Server.

  Talvez você também queira aplicar o fix pack mais recente que pode ser transferido por download do [Portal de Suporte IBM](https://www.ibm.com/support/home/product/N651135V62596I83/IBM_MobileFirst_Platform_Foundation). O fix pack não pode ser instalado sem o repositório da versão base nos repositórios do Installation Manager.

O IBM MobileFirst Platform Foundation eAssembly inclui os instaladores a seguir:
* IBM DB2 Workgroup Server Edition
* IBM WebSphere Application Server Liberty Core

Para Liberty, também é possível usar IBM WebSphere SDK Java Technology Edition com o suplemento IBM WebSphere Application Server Liberty Core.

## Tópico pai
{: #parent-topic }

* [Instalando o MobileFirst Server em um ambiente de produção](../).
