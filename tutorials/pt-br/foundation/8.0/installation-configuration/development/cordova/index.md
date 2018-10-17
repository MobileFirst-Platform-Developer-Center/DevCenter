---
layout: tutorial
title: Configurando o ambiente de desenvolvimento do Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Para uma introdução ao [desenvolvimento do Cordova (PhoneGap)](https://cordova.apache.org/), a etapa muito básica necessária é instalar o Cordova CLI. O Cordova CLI é a ferramenta que permite criar aplicativos do Cordova. Esses aplicativos podem ser mais aprimorados usando várias estruturas e ferramentas de terceiros, como Ionic, AngularJS, jQuery Mobile e muito mais. 
Com aplicativos do Cordova, é possível usar seu editor de código preferencial, como o Atom.io, Visual Studio Code, Eclipse, IntelliJ e outros para implementar seus aplicativos e adaptadores.

**Pré-requisito:** Conforme você configura seu ambiente de desenvolvimento do Cordova, certifique-se também de ler o tutorial [Configurando o ambiente de desenvolvimento do {{ site.data.keys.product_adj }}](../mobilefirst/).

## Instalando o Cordova CLI
{: #installing-the-cordova-cli }
O {{ site.data.keys.product }} suporta o Apache [Cordova CLI 6.x](https://www.npmjs.com/package/cordova) ou superior.  
Para instalar:

1. Faça download e instale o [NodeJS](https://nodejs.org/en/).
2. Em uma janela **Linha de comandos**, execute o comando: `npm install -g cordova`.

## Etapas seguintes
{: #next-steps }
Para continuar com o desenvolvimento do {{ site.data.keys.product_adj }} em aplicativos do Cordova, o SDK/plug-ins do Cordova do {{ site.data.keys.product_adj }} precisam ser incluídos no aplicativo do Cordova.

* Saiba como incluir o SDK do [{{ site.data.keys.product_adj }} em aplicativos do Cordova](../../../application-development/sdk/cordova/).
* Para desenvolvimento de aplicativos, consulte os tutoriais [Usando o SDK do {{ site.data.keys.product }}](../../../application-development/).
* Para o desenvolvimento de adaptadores, consulte a categoria [Adaptadores](../../../adapters/).
