---
layout: tutorial
title: Principais recursos do produto
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Com o {{site.data.keys.product_full }}, é possível usar recursos, como desenvolvimento, teste, conexões de backend, notificações push,
modo offline, atualização, segurança, análise de dados, monitoramento e publicação de aplicativo.

### Desenvolvimento
{: #deployment }
O {{site.data.keys.product }} fornece uma estrutura que permite o desenvolvimento, a otimização, a integração e o gerenciamento de aplicativos móveis seguros (aplicativos). O {{site.data.keys.product }} não introduz uma linguagem ou um modelo de programação proprietário que os usuários devem aprender.

É possível desenvolver aplicativos usando HTML5, CSS3 e JavaScript. Como opção, é possível escrever código nativo (Java ou Objective-C). O {{site.data.keys.product }} fornece um SDK que inclui bibliotecas que podem ser acessadas a partir do código nativo.

#### Plataformas
Suportadas
{: #supported-platforms }
Os SDKs do {{site.data.keys.product }} suportam as plataformas a seguir:

* iOS
* Android
* Windows Universal 8.1 e Windows 10 UWP
* Apps da web

> **Navegadores suportados para aplicativos da web:**
> 
> |      Navegador    | Chrome | Safari* | Internet Explorer | Firefox | Android Browser |
> |:-----------------:|:------:|:-------:|:-----------------:|:-------:|:---------------:|
> | Versão suportada |   43+  |    8+   |        10+        |   38+   |   Android 4.3+  |

* O modo de navegação privada funcionará somente com aplicativos de página única. Outros aplicativos podem ter comportamento inesperado.

### Conexões de Backend
{: #back-end-connections }
Alguns aplicativos remotos
são executados estritamente offline sem conexão com um sistema backend, mas a
maioria dos aplicativos remotos se conectam a serviços corporativos existentes para
fornecer as funções críticas relacionadas ao usuário. Por exemplo, os clientes
podem usar um aplicativo remoto para comprar em qualquer lugar, a qualquer momento, independentemente
do horário de operação da loja. Seus pedidos ainda devem ser processados,
usando-se a plataforma de e-commerce existente da loja. Para integrar
um aplicativo remoto a serviços corporativos, você deve usar um middleware,
como um gateway remoto. O {{site.data.keys.product }} pode atuar como essa solução de middleware e facilitar a comunicação com serviços de backend.

### Notificações Push
{: #push-notifications }
Com as notificações push,
os aplicativos corporativos podem enviar informações para os dispositivos móveis, mesmo
quando o aplicativo não estiver sendo usado. O {{site.data.keys.product }} inclui
uma estrutura de notificação unificada que fornece um mecanismo consistente
para essas notificações push. Com essa estrutura de notificação unificada, é possível enviar notificações push sem precisar saber os detalhes de cada dispositivo ou plataforma de destino porque cada plataforma móvel possui um mecanismo diferente para notificação push.

### Modo Offline
{: #offline-mode }
Em termos de conectividade, aplicativos
remotos podem operar offline, online ou em um modo misto. O {{site.data.keys.product }} usa uma arquitetura cliente/servidor que pode detectar se um dispositivo possui conectividade de rede, bem como a qualidade da conexão. Agindo como um cliente, os aplicativos remotos
tentam periodicamente conectar-se ao servidor e avaliar a força
da conexão. É possível usar um aplicativo remoto ativado para funcionar offline
quando um dispositivo móvel não possui conectividade, mas algumas funções podem ser
limitadas. Ao criar um aplicativo remoto ativado para funcionar offline, é
útil armazenar informações sobre o dispositivo móvel que podem ajudar a
preservar sua funcionalidade no modo offline. Essas informações geralmente
são provenientes de um sistema backend, e você deve considerar a sincronização de dados
com o backend como parte da arquitetura do aplicativo. O {{site.data.keys.product }} inclui um recurso que é chamado JSONStore para troca e armazenamento de dados. Com esse recurso, é possível
criar, ler, atualizar e excluir registros de dados de uma origem de dados. Cada operação
é enfileirada quando operando offline. Quando uma conexão estiver disponível,
a operação será transferida para o servidor e cada operação será então
executada em relação aos dados de origem.

### Atualização
{: #update }
O {{site.data.keys.product }} simplifica o gerenciamento de versão e a compatibilidade do aplicativo móvel. Sempre que um usuário inicia
um aplicativo remoto, o aplicativo se comunica com um servidor. Ao usar esse servidor, o {{site.data.keys.product }} pode determinar se uma versão mais recente do aplicativo está disponível e, em caso afirmativo, fornecer informações ao usuário sobre ela, ou enviar uma atualização do aplicativo para o dispositivo. O servidor também pode forçar um upgrade para a versão mais recente de um aplicativo
para evitar o uso contínuo de uma versão desatualizada.

### Security
{: #security }
Proteger informações confidenciais e
particulares é crítico para todos os aplicativos de uma empresa,
incluindo aplicativos remotos. A segurança remota se aplica em vários
níveis, como aplicativo remoto, serviços de aplicativo remoto ou
serviço de backend. Você deve assegurar a privacidade do cliente e proteger dados
confidenciais contra acesso por usuários não autorizados. Lidar com dispositivos móveis
de propriedade privada significa perder o controle em determinados níveis de segurança
mais baixos, como o sistema operacional de dispositivo móvel.

O {{site.data.keys.product }} fornece comunicação segura, de ponta a ponta, ao posicionar um servidor que supervisiona o fluxo de dados entre o aplicativo remoto e os sistemas backend. Com o {{site.data.keys.product }}, é possível definir manipuladores de segurança customizada para qualquer acesso a esse fluxo de dados. Como todo acesso aos dados de um aplicativo remoto precisa passar por
essa instância do servidor, é possível definir manipuladores de segurança diferentes para
aplicativos remotos, aplicativos da web e acesso de backend. Com este tipo de segurança granular, é possível definir níveis separados
de autenticação para diferentes funções de seu aplicativo móvel. Também é possível evitar que aplicativos móveis acessem informações
confidenciais.

### Analítico
{: #analytics }
O recurso {{site.data.keys.mf_analytics }} permite a procura entre aplicativos, serviços, dispositivos e outras fontes para coletar dados sobre uso ou para detectar problemas.

Além de
relatórios que resumem a atividade do app, o {{site.data.keys.product }} inclui uma plataforma de analítica operacional escalável que pode ser acessada no {{site.data.keys.mf_console }}. O recurso {{site.data.keys.mf_analytics_short }} permite que as empresas procurem padrões, problemas e estatísticas de uso da plataforma nos logs e eventos que são coletados a partir dos dispositivos, aplicativos e servidores. É possível ativar a analítica, relatórios, ou ambos, dependendo
de suas necessidades.

### Monitoração
{: #monitoring }
O {{site.data.keys.product }} inclui uma série de analítica operacional e mecanismos de relatório para coleta, visualização e análise de dados a partir de seus aplicativos e servidores do {{site.data.keys.product }} e para monitoramento de funcionamento do servidor.

### Publicação do Aplicativo
{: #application-publishing }
{{site.data.keys.product }} Application Center é um armazenamento de aplicativo corporativo. Com o Application Center,
é possível instalar, configurar e administrar um repositório de aplicativos
remotos para utilização por indivíduos e grupos de sua empresa. É possível controlar quem de sua organização pode acessar o Application Center e upload de aplicativos no repositório do Application Center, e quem pode fazer download e instalar esses aplicativos em um dispositivo remoto. Também é possível usar o Application Center para coletar feedback
de usuários e acessar informações sobre dispositivos nos quais os aplicativos
estão instalados.

O conceito do Application Center é semelhante
ao conceito do App Store público da Apple ou do Google Play store,
exceto que seu alvo é o processo de desenvolvimento.

O Application Center fornece um repositório para armazenar os arquivos do aplicativo remoto e um console baseado na para gerenciar esse repositório. O Application Center também fornece um aplicativo cliente móvel para permitir que os usuários naveguem pelo catálogo de aplicativos armazenados pelo Application Center, instalem aplicativos, deixem feedback para a equipe de desenvolvimento e exponham aplicativos de produção para o IBM Endpoint Manager. O acesso para
fazer o download e instalar aplicativos do Application Center é controlado
pelas listas de controle de acesso (ACLs).
