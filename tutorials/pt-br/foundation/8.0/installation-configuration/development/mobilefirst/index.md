---
layout: tutorial
title: Configurando o ambiente de desenvolvimento do MobileFirst
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
{{ site.data.keys.product_full }} O é composto de vários componentes: os SDKs do cliente, archetypes do adaptador, verificações de segurança e ferramentas de autenticação.

Esses componentes estão disponíveis nos repositórios on-line e podem ser instalados usando gerenciadores de pacotes. Esses repositórios on-line fornecem a liberação mais recente de cada componente. O mesmo componente também está disponível para download no {{ site.data.keys.mf_dev_kit }} para uso local. Observe que a versão que está disponível no {{ site.data.keys.mf_dev_kit_short }} representa a versão que estava disponível no momento em que a construção específica do {{ site.data.keys.mf_dev_kit_short }} foi liberada e que o download de uma nova construção do {{ site.data.keys.mf_dev_kit_short }} será necessário para usar a mais recente. 

Continue lendo para saber mais sobre os componentes do {{ site.data.keys.product }}.

> Para avaliar o {{ site.data.keys.product }}, tudo o que é necessário é girar uma instância do {{ site.data.keys.mf_server }} no Bluemix usando o serviço Mobile Foundation Bluemix. Consulte o tutorial [Usando o Mobile Foundation](../../../bluemix/using-mobile-foundation/) para obter instruções. Também é possível optar por instalar o {{ site.data.keys.mf_dev_kit_short }} para uma instalação local.

#### Ir para:
{: #jump-to }

* [Guia de Instalação ](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [Componentes do {{ site.data.keys.product }}](#mobilefirst-foundation-components)
* [Desenvolvimento de aplicativos e adaptadores](#applications-and-adapters-development)
* [Próximos tutoriais a serem seguidos](#tutorials-to-follow-next)

## Guia de instalação
{: #installation-guide }
[Leia o guia de instalação](installation-guide) para configurar rapidamente o MobileFirst Foundation em sua estação de trabalho.

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
O {{ site.data.keys.mf_dev_kit_short }} fornece um ambiente pronto para desenvolvimento com a configuração mínima necessária. O kit consiste nos seguintes componentes: {{ site.data.keys.mf_server }} e {{ site.data.keys.mf_console }}, MobileFirst Developer Command-line Interface (CLI), e também fornece opcionalmente SDKs do cliente e conjunto de ferramentas do adaptador para download.

> **Nota:** Se precisar configurar seu ambiente de desenvolvimento em um computador que não tem acesso à Internet, é possível instalar componentes off-line. Consulte [Como configurar um ambiente de desenvolvimento off-line do IBM MobileFirst]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment).

### {{ site.data.keys.mf_dev_kit_short }} Instalador do
{: #developer-kit-installer }
O Instalador empacota os componentes para instalação local em que a conectividade com a Internet não está disponível.  
Os componentes estão disponíveis por meio do Download Center do {{ site.data.keys.mf_console }}.

> Para fazer download do instalador, visite a página de [downloads]({{site.baseurl}}/downloads/).

## {{ site.data.keys.product }} os componentes do 
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Como parte do {{ site.data.keys.mf_dev_kit_short }}, o {{ site.data.keys.mf_server }} é fornecido pré-implementado em um servidor de aplicativos de perfil Liberty do WebSphere. O servidor é pré-configurado com um tempo de execução "mfp" e usa um banco de dados Apache Derby baseado em sistema de arquivos.

No diretório-raiz do {{ site.data.keys.mf_dev_kit_short }}, os seguintes scripts estão disponíveis para execução a partir de uma linha de comandos:

* `run.[sh|cmd]`: execute o {{ site.data.keys.mf_server }} com mensagens finais do Liberty Server
    * Inclua a sinalização `-bg` para executar o processo no plano de fundo
* `stop.[sh|cmd]`: pare a instância atual do {{ site.data.keys.mf_server }}
* `console.[sh|cmd]`: abra o {{ site.data.keys.mf_console }}

As extensões de arquivos `.sh` são para Mac e Linux, e as extensões de arquivos `.cmd` são para Windows.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
O {{ site.data.keys.mf_console }} expõe as seguintes funcionalidades.  
Um desenvolvedor pode:

- Registrar e implementar aplicativos e adaptadores
- Opcionalmente, fazer download de modelos de código de início de aplicativos e adaptadores nativos/Cordova 
- Configurar a autenticação e propriedades de segurança de um aplicativo
- Gerenciar aplicativos:
    - Autenticidade do Aplicativo
    - Atualização direta
    - Desativação/Notificação remotas
- Enviar notificações push para dispositivos iOS e Android
- Gerar scripts DevOps para fluxos de trabalho de integração contínua e ciclos de desenvolvimento mais rápidos

> Saiba mais sobre o {{ site.data.keys.mf_console }} no tutorial [Usando o MobilFirst Operations Console](../../../product-overview/components/console/).

### {{ site.data.keys.product }} Command-line Interface
{: #mobilefirst-foundation-command-line-interface }
É possível usar {{ site.data.keys.mf_cli }} para desenvolver e gerenciar aplicativos, além de usar {{ site.data.keys.mf_console }}. O comando de CLI é prefixado com `mfpdev` e suporta os seguintes tipos de tarefas:

* Registrar aplicativos com {{ site.data.keys.mf_server }}
* Configurar seu aplicativo
* Criar, construir e implementar adaptadores
* Visualizar e atualizar aplicativos Cordova

> Para fazer download e instalar o {{ site.data.keys.mf_cli }}, visite a página [downloads]({{site.baseurl}}/downloads/).  
> Saiba mais sobre os vários comandos de CLI no tutorial [Usando a CLI para gerenciar artefatos do MobileFirst](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### SDKs do cliente e conjunto de ferramentas do adaptador do {{ site.data.keys.product }}
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
O {{ site.data.keys.product }} fornece SDKs do cliente para aplicativos Cordova e também para plataformas Nativas (iOS, Android e Windows 8.1 Universal e Windows 10 UWP). O conjunto de ferramentas do adaptador para adaptadores e o desenvolvimento de verificações de segurança também estão disponíveis.

* Para usar os SDKs do cliente do {{ site.data.keys.product_adj }}, visite a categoria de tutoriais [Incluindo o {{ site.data.keys.product }}SDK](../../../application-development/sdk/).  
* Para desenvolver adaptadores, visite a categoria de tutoriais [Adaptadores](../../../adapters/).  
* Para desenvolver verificações de segurança, visite a categoria de tutoriais [Autenticação e segurança](../../../authentication-and-security/).  

## Desenvolvimento de aplicativos e adaptadores
{: #applications-and-adapters-development }

### Aplicações
{: #applications }
* Os aplicativos Cordova requerem NodeJS e a CLI Cordova. Leia mais sobre [Configurando o ambiente de desenvolvimento de Cordova](../cordova).

    É possível usar o editor de código preferencial, como Atom.io, Visual Studio Code, Eclipse, IntelliJ e outros, para implementar aplicativos e adaptadores.  
    
* Os aplicativos nativos requerem o Xcode, Android Studio ou Visual Studio. Leia mais sobre [Configurando o ambiente de desenvolvimento do iOS/Android/Windows](../).

### Adaptadores
{: #adapters }
Os adaptadores requerem que o Apache Maven esteja instalado. Consulte a categoria [Adaptadores](../../../adapters/) para saber mais sobre adaptadores e como criar, desenvolver e implementar

## Próximos tutoriais a serem seguidos
{: #tutorials-to-follow-next }
Visite a página [Todos os tutoriais](../../../all-tutorials/) e selecione uma categoria de próximos tutoriais a serem seguidos.

