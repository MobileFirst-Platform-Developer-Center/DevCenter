---
layout: tutorial
title: Configurando o ambiente de desenvolvimento
breadcrumb_title: ambiente de desenvolvimento
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Antes de começar a desenvolver o código do cliente e do servidor usando o {{ site.data.keys.product_full }}, o ambiente de desenvolvimento precisa ser configurado primeiro. Isso inclui a instalação de vários softwares e ferramentas necessários. A seguir está uma lista de softwares que talvez precisem ser instalados na estação de trabalho do desenvolvedor, dependendo de suas necessidades.

Também é possível localizar instruções detalhadas passo a passo [nesse guia de instalação da estação de trabalho](mobilefirst/installation-guide/).

#### Ir para:

* [Servidor](#server)
* [Desenvolvimento de aplicativo](#application-development)
* [Desenvolvimento do adaptador](#adapter-development)
* [Instruções específicas da plataforma](#platform-specific-instructions)

### Servidor
{: #server }
É possível usar o {{ site.data.keys.mf_server }} por meio do [serviço Mobile Foundation Bluemix](../../bluemix/using-mobile-foundation), ou localmente usando o {{ site.data.keys.mf_dev_kit_full }} (usado para propósitos de desenvolvimento local). O {{ site.data.keys.mf_server }} requer o Java 7 ou 8 para ser executado.

Se você pretende usar o serviço Mobile Foundation Bluemix, será necessária uma conta no Bluemix.net.

### Desenvolvimento de aplicativos
{: #application-development }
No mínimo, o seguinte software é necessário:

* NodeJS (requisito para {{ site.data.keys.mf_cli }})
* {{ site.data.keys.mf_cli }}
* Cordova CLI
* IDEs:
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io / Visual Studio Code / WebStorm / IntelliJ / Eclipse / outros IDEs

### Desenvolvimento do adaptador
{: #adapter-development }
No mínimo, o seguinte software é necessário:

* NodeJS (requisito para {{ site.data.keys.mf_cli }})
* *opcional* {{ site.data.keys.mf_cli }}
* Maven (requer Java)
* IDEs:
    - IntelliJ / Eclipse / outros IDEs

### Instruções específicas da plataforma
{: #platform-specific-instructions }
