---
layout: tutorial
title: Componentes do produto
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão geral
{: #overview }
O {{ site.data.keys.product_full }} consiste nos componentes a seguir: {{ site.data.keys.mf_cli }}, {{ site.data.keys.mf_server }}, componentes de tempo de execução do lado do cliente, {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_app_center }} e {{ site.data.keys.mf_system_pattern }}.

A figura a seguir mostra os componentes do {{ site.data.keys.product }}:

![Arquitetura da solução {{ site.data.keys.product }} ](architecture.jpg)

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
É possível usar o {{ site.data.keys.mf_cli_full }} para desenvolver e gerenciar aplicativos, além de usar o IBM {{ site.data.keys.mf_console }}. Alguns aspectos do processo de desenvolvimento do {{ site.data.keys.product_adj }} devem ser executado com CLI.

Os comandos, todos prefaciados com **mfpdev**, suportam os seguintes tipos de tarefas:

* Registrar aplicativos com {{ site.data.keys.mf_server }}
* Configurar seu aplicativo
* Criar, construir e implementar adaptadores
* Visualizar e atualizar aplicativos Cordova
* Para obter mais informações, consulte o tutorial [Usando a CLI para gerenciar artefatos do {{ site.data.keys.product_adj }}](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
O {{ site.data.keys.mf_server }} fornece conectividade backend segura, gerenciamento de aplicativo, suporte à notificação push e recursos de análise de dados, além de monitoramento para aplicativos {{ site.data.keys.product_adj }}. Não é um servidor de aplicativos no sentido de Java Platform, Enterprise Edition (Java EE). Ele age como um contêiner para pacotes de aplicativos do {{ site.data.keys.product }} e é, de fato, uma coleção de aplicativos da web, empacotados opcionalmente como um arquivo EAR (enterprise archive) que é executado em cima de servidores de aplicativos tradicionais.

O {{ site.data.keys.mf_server }} integra-se a seu ambiente corporativo e usa recursos e infraestrutura existentes. Essa integração baseia-se em adaptadores que são componentes de software do lado do servidor responsáveis pelo direcionamento de sistemas corporativos de backend e serviços baseados em nuvem para o dispositivo do usuário. É possível usar adaptadores para recuperar e atualizar dados de origens de informações, e para permitir que os usuários executem transações e iniciem outros serviços e aplicativos.

[Saiba mais sobre o {{ site.data.keys.mf_server }}](server).

### Componentes de Tempo de Execução do Lado do Cliente
{: #client-side-runtime-components }
{{ site.data.keys.product }} O fornece o código de tempo de execução do lado do cliente que integra a funcionalidade do servidor dentro do ambiente de destino de aplicativos implementados. Essas APIs do cliente de tempo de execução são bibliotecas que estão integradas ao código de aplicativo armazenado localmente. Você as usa para incluir recursos do {{ site.data.keys.product_adj }} em seus aplicativos clientes. As APIs e bibliotecas podem ser instaladas com o {{ site.data.keys.mf_dev_kit_full }} ou é possível fazer seu download a partir dos repositórios para sua plataforma de desenvolvimento.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
O {{ site.data.keys.mf_console }} é usado para o controle e gerenciamento dos aplicativos móveis. O {{ site.data.keys.mf_console }} também é um ponto de entrada para aprender sobre o desenvolvimento do {{ site.data.keys.product }}. No console, é possível fazer download dos exemplos de código, ferramentas e SDKs.

Você pode utilizar o {{ site.data.keys.mf_console }} para executar as seguintes tarefas:

* Monitorar e configurar todos os aplicativos implementados, adaptadores e regras de notificação push a partir de um console baseado na Web centralizado.
* Desativar remotamente a capacidade de se conectar ao {{ site.data.keys.mf_server }} usando regras pré-configuradas de versão do aplicativo e tipo de dispositivo.
* Customizar mensagens que são enviadas aos usuários na ativação do aplicativo.
* Coletar estatísticas do usuário a partir de todos os aplicativos em execução.
* Gerar relatórios integrados, pré-configurados sobre a adoção de usuário e o uso (número e frequência de usuários que estão engajados com o servidor por meio dos  aplicativos).
* Configurar regras de coleta de dados para eventos específicos do aplicativo.
* [Saiba mais sobre o {{ site.data.keys.mf_console }}](console).

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.product }} O inclui um recurso operacional escalável {{ site.data.keys.mf_analytics_short }} que está acessível a partir do {{ site.data.keys.mf_console }}. O recurso {{ site.data.keys.mf_analytics_short }} permite que as empresas procurem padrões, problemas e estatísticas de uso da plataforma em logs e eventos que são coletados de dispositivos, aplicativos e servidores.

Os dados para {{ site.data.keys.mf_analytics }} incluem as origens a seguir:

* Eventos de travamento de um aplicativo em dispositivos iOS e Android (eventos de travamento para código nativo e erros de JavaScript).
* Interações de qualquer atividade de aplicativo para servidor (qualquer coisa que seja suportada pelo protocolo cliente/servidor {{ site.data.keys.mf_cli }}, incluindo notificação push).
* Logs do lado do servidor que são capturados em arquivos de log do {{ site.data.keys.product_adj }} tradicionais.

[Saiba mais sobre {{ site.data.keys.mf_analytics }}](../../analytics).

### Centro de aplicativos
{: #application-center }
Com o Application Center, é possível compartilhar aplicativos remotos que estão em desenvolvimento na organização em um único repositório de aplicativos remotos. Os membros da equipe de desenvolvimento podem usar o Application Center para compartilhar aplicativos com membros da equipe. Este processo facilita a colaboração entre todas as pessoas envolvidas no desenvolvimento de um aplicativo.

Em geral, sua empresa pode usar o Application Center, conforme a seguir:

1. A equipe de desenvolvimento cria uma versão de um aplicativo.
2. A equipe de desenvolvimento faz upload do aplicativo para o Application Center, insere sua descrição e solicita à equipe estendida para revisá-la e testá-la.
3. Quando a nova versão do aplicativo está disponível, um testador executa o aplicativo instalador do Application Center, que é o cliente remoto. Em seguida, o testador localiza essa nova versão do aplicativo, instala-a no dispositivo móvel e testa-a.
4. Após os testes, o testador classifica o aplicativo e envia o feedback, que fica visível para o desenvolvedor no console do Application Center.

O Application Center é destinado para uso privado dentro de uma empresa e você pode destinar alguns aplicativos remotos para grupos específicos de usuários. É possível usar o Application Center como um armazenamento de aplicativo corporativo.

### {{ site.data.keys.mf_system_pattern }}
{: #mobilefirst-system-pattern }
Com o {{ site.data.keys.mf_system_pattern_full }}, é possível implementar o {{ site.data.keys.mf_server }} no IBM PureApplication System ou o IBM PureApplication Service no SoftLayer. Com estes padrões, administradores e corporações podem responder rapidamente a mudanças no ambiente de negócios tirando vantagem de tecnologias de Nuvem no local. Essa abordagem simplifica o processo de implementação e melhora a eficiência operacional para lidar com uma maior demanda móvel. A demanda acelera a iteração de soluções que excedem os ciclos de demanda tradicionais. Usar o {{ site.data.keys.mf_server }} Pattern também fornece acesso a melhores práticas e conhecimento integrado, como políticas de ajuste de escala integradas.

#### PureApplication System
{: #pureapplication-system }
O IBM PureApplication System é um sistema integrado altamente escalável que é baseado no IBM X-Architecture, fornecendo um modelo de computação centralizado no aplicativo em um ambiente de nuvem.

Um sistema centralizado em aplicativos é uma maneira eficiente de gerenciar aplicativos complexos e as tarefas e processos que são chamados pelo aplicativo. Todo o sistema implementa um ambiente de computação virtual diferente, no qual diferentes configurações de recursos são customizadas automaticamente para diferentes cargas de trabalho de aplicativos. Os recursos de gerenciamento de aplicativo da plataforma IBM PureApplication System tornam a implementação de middleware e de outros componentes de aplicativo rápida, fácil e repetida.

O IBM PureApplication System fornece cargas de trabalho virtualizadas e uma infraestrutura escalável que são entregues em um sistema integrado.

#### Padrões de Sistema Virtual
{: #virtual-system-patterns }
Padrões de sistema virtual são uma representação lógica de uma topologia recorrente para um conjunto de requisitos de implementação.

Padrões do sistema virtual permitem implementações repetidas e eficientes de sistemas que incluem uma ou mais instâncias de máquina virtual e dos aplicativos que são executados nelas. É possível automatizar completamente a implementação e eliminar a necessidade de executar várias tarefas manuais demoradas. Uma implementação desse tipo elimina problemas que são introduzidos por processos de configuração manuais propensos a erro, especialmente em topologias de produção complexas como server farms, e acelera a implementação da solução.
