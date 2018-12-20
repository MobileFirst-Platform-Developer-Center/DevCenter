---
layout: tutorial
title: Configurando o ambiente de desenvolvimento do Ionic
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O Ionic é uma estrutura construída no [AngularJS](https://angularjs.org/) e no [Apache Cordova](https://cordova.apache.org/), que ajuda você a construir rapidamente aplicativos móveis híbridos e da web usando tecnologias da web, como HTML, CSS e Javascript.

Se você for um desenvolvedor que escolheu o Ionic como a estrutura para desenvolver seu aplicativo móvel ou da web, as seções a seguir o ajudarão a começar a usar o SDK do [IBM Mobile Foundation](http://mobilefirstplatform.ibmcloud.com) em seu aplicativo Ionic.

É possível usar seu editor de código preferencial, como Atom.io, Visual Studio Code, Eclipse, IntelliJ e outros, para a composição de seus aplicativos.

**Pré-requisito:** ao configurar o ambiente de desenvolvimento do Ionic, certifique-se de também ler o tutorial [Configurando o ambiente de desenvolvimento MobileFirst](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst).

## Instalando a CLI do Ionic
{: #installing_cli }
Para começar a usar o desenvolvimento do Ionic, a primeira etapa necessária é instalar a [CLI do Ionic](https://ionicframework.com/docs/cli/).

**Para instalar a CLI do Cordova e do Ionic:**

* Faça download e instale o [NodeJS](https://nodejs.org/en/).
* Em uma janela da linha de comandos, execute o comando:
```bash  
  npm install -g ionic
```  

## Incluindo o SDK do Mobile Foundation em seu aplicativo Ionic
{: #adding_mfp_ionic_sdk }
Para continuar com o desenvolvimento do MobileFirst em aplicativos Ionic, o SDK do MobileFirst para Cordova ou plug-ins precisam ser incluídos no aplicativo Ionic.

Saiba como incluir o SDK do MobileFirst em aplicativos Cordova.
Para o desenvolvimento de aplicativos, consulte o tutorial [Incluindo o SDK do Mobile Foundation em aplicativos Ionic]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/ionic).
