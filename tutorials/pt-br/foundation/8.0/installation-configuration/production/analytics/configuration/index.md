---
layout: tutorial
title: Guia de Configuração do MobileFirst Analytics Server
breadcrumb_title: Guia de Configuração
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Algumas configurações são necessárias para o {{ site.data.keys.mf_analytics_server }}. Alguns parâmetros de configuração aplicam-se a um único nó e alguns aplicam-se ao cluster inteiro, conforme indicado.

#### Ir para
{: #jump-to }

* [Propriedades de Configuração](#configuration-properties)
* [Fazendo backup de dados do Analytics](#backing-up-analytics-data)
* [Gerenciamento de cluster e Elasticsearch](#cluster-management-and-elasticsearch)

### Propriedades
{: #properties }
Para obter uma lista completa de propriedades de configuração e saber como defini-las em seu servidor de aplicativos, consulte [Propriedades de configuração](#configuration-properties).

* A propriedade **discovery.zen.minimum\_master\_nodes** deve ser configurada como **ceil((número de nós principais elegíveis no cluster / 2) + 1)** para evitar a síndrome de split-brain.
    * Nós Elasticsearch em um cluster que são elegíveis principais devem estabelecer um quorum para decidir qual nó elegível principal é o principal.
    * Se você incluir um nó elegível principal no cluster, o número de nós elegíveis principais mudará e, dessa forma, a configuração deverá mudar. Deve-se modificar a configuração se você introduzir novos nós elegíveis principais no cluster. Para obter informações adicionais sobre como gerenciar seu cluster, consulte [Gerenciamento de cluster e Elasticsearch](#cluster-management-and-elasticsearch).
* Dê ao cluster um nome configurando a propriedade **clustername** em todos os seus nós.
    * Nomeie o cluster para evitar que uma instância do desenvolvedor de Elasticsearch se associe acidentalmente a um cluster que está usando um nome padrão.
* Dê a cada nó um nome configurando a propriedade **nodename** em cada nó.
    * Por padrão, o Elasticsearch dá a cada nó um nome aleatório de um personagem da Marvel aleatório, e o nome do nó é diferente em cada reinicialização do nó.
* Declare explicitamente o caminho do sistema de arquivos para o diretório de dados configurando a propriedade **datapath** em cada nó.
* Declare explicitamente os nós principais dedicados configurando a propriedade **masternodes** em cada nó.

### Configurações de Recuperação de Cluster
{: #cluster-recovery-settings }
Após ter escalado para um cluster multinós, você pode achar que a reinicialização de um cluster integral ocasional é necessária. Quando a reinicialização de um cluster integral é necessária, você pode considerar configurações de recuperação. Se o cluster tiver 10 nós, e conforme o cluster for apresentado, um nó por vez, o nó principal assumirá que é necessário iniciar o balanceamento de dados imediatamente na chegada de cada nó no cluster. Se o principal tiver permissão para se comportar dessa maneira, um rebalanceamento desnecessário será requerido. Deve-se configurar as definições de cluster para aguardar um número mínimo de nós para associar ao cluster antes de o principal ter permissão para começar a instruir os nós para o rebalanceamento. Isso pode reduzir as reinicializações do cluster de horas para minutos.

* A propriedade **gateway.recover\_after\_nodes** deve ser configurada de acordo com sua preferência para evitar que o Elasticsearch inicie um rebalanceamento até que o número especificado de nós no cluster esteja ativo e associado. Se seu cluster tiver 10 nós, um valor de 8 para a propriedade **gateway.recover\_after\_nodes** pode ser uma configuração razoável.
* A propriedade **gateway.expected\_nodes** deve ser configurada como o número de nós que devem estar no cluster. Nesse exemplo, o valor para a propriedade **gateway.expected_nodes** é 10.
* A propriedade **gateway.recover\_after\_time** deve ser configurada para instruir o principal a esperar para enviar instruções rebalanceadas até após o tempo configurado decorrido desde o início do nó principal.

A combinação de configurações anteriores significa que o Elasticsearch espera que o valor de **gateway.recover\_after\_nodes** nós esteja presente. Em seguida, ele começa a recuperação após o valor de **gateway.recover\_after\_time** minutos ou após o valor de **gateway.expected\_nodes** nós associados ao cluster, o que vier primeiro.

### O que não fazer
{: #what-not-to-do }
* Não ignore seu cluster de produção.
    * Os clusters precisam de monitoramento e de cuidado. Estão disponíveis muitas boas ferramentas de monitoramento Elasticsearch que são dedicadas à tarefa.
* Não use o armazenamento conectado à rede (NAS) para a configuração de **datapath**. O NAS apresenta mais latência e um ponto único de falha. Sempre use os discos de hosts locais.
* Evite clusters que abrangem datacenters e definitivamente evite clusters que abrangem grandes distâncias geográficas. A latência entre os nós é um gargalo de desempenho grave.
* Ative sua própria solução de gerenciamento de configuração de cluster. Muitas boas soluções de gerenciamento de configuração, como Puppet, Chef e Ansible, estão disponíveis.

## Propriedades de Configuração
{: #configuration-properties }
O {{ site.data.keys.mf_analytics_server }} pode ser iniciado com sucesso sem nenhuma configuração adicional.

A configuração é feita por meio de propriedades JNDI no {{ site.data.keys.mf_server }} e no {{ site.data.keys.mf_analytics_server }}. Além disso, o {{ site.data.keys.mf_analytics_server }} suporta o uso de variáveis de ambiente para controlar a configuração. As variáveis de ambiente têm precedência sobre propriedades JNDI.

O aplicativo da web de tempo de execução do Analytics deve ser reiniciado para que as mudanças nessas propriedades entrem em vigor. Não é necessário reiniciar o servidor de aplicativos inteiro.

Para configurar uma propriedade JNDI no WebSphere Application Server Liberty, inclua uma tag no arquivo **server.xml**, conforme a seguir.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Para configurar uma propriedade JNDI no Tomcat, inclua uma tag no arquivo context.xml, conforme a seguir.

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

As propriedades JNDI no WebSphere Application Server estão disponíveis como variáveis de ambiente.

* No console do WebSphere Application Server, selecione **Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere**.
* Selecione o aplicativo **{{ site.data.keys.product_adj }}Administration Service**.
* Em **Propriedades do Módulo da Web**, clique em **Entradas de Ambiente para Módulos da Web** para exibir as propriedades de JNDI.

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
A tabela a seguir mostra as propriedades que podem ser configuradas no {{ site.data.keys.mf_server }}.

| Propriedade                           | Descrição (Description)                                           | Valor Padrão |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | Configure esta propriedade para a URL do {{ site.data.keys.mf_analytics_console }}. Por exemplo, http://hostname:port/analytics/console. Configurar essa propriedade ativa o ícone de análise de dados no {{ site.data.keys.mf_console }}. | Nenhuma |
| mfp.analytics.logs.forward         | Se essa propriedade for configurada como verdadeira, os logs do servidor que estão registrados no {{ site.data.keys.mf_server }} serão capturados no {{ site.data.keys.mf_analytics }}. | verdadeiro |
| mfp.analytics.url                  |Requerido. A URL exposta pelo {{ site.data.keys.mf_analytics_server }} que recebe dados de análise de dados recebidos. Por exemplo, http://hostname:port/analytics-service/rest/v2. | Nenhuma |
| analyticsconsole/mfp.analytics.url |	Opcional. URI completa dos serviços REST do Analytics. Em um cenário com um firewall ou um proxy reverso seguro, essa URI deve ser a URI externa, não a URI interna dentro da LAN local. Esse valor pode conter * no lugar do protocolo URI, do nome do host ou da porta, para denotar a parte correspondente da URL recebida.	*://*:*/analytics-service, com o protocolo, o nome do host e a porta determinados dinamicamente |
| mfp.analytics.username             | O nome do usuário que será usado se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |
| mfp.analytics.password             | A senha que será usada se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
A tabela a seguir mostra as propriedades que podem ser configuradas no {{ site.data.keys.mf_analytics_server }}.

| Propriedade                           | Descrição (Description)                                           | Valor Padrão |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Define o tipo de nó Elasticsearch. Os valores válidos são master e data. Se essa propriedade não for configurada, o nó agirá como um nó principal elegível e um nó de dados. | 	Nenhuma |
| analytics/shards | O número de shards por índice. Esse valor pode ser configurado somente pelo primeiro nó que é iniciado no cluster e não pode ser mudado. | 1 |
| analytics/replicas_per_shard | O número de réplicas para cada shard no cluster. Esse valor pode ser mudado dinamicamente em um cluster em execução. | 0 |
| analytics/masternodes | Uma sequência delimitada por vírgulas que contém o nome do host e as portas dos nós principais elegíveis. | Nenhuma |
| analytics/clustername | Nome do cluster. Configure esse valor se você planeja ter vários clusters que operam no mesmo subconjunto e precisa identificá-los exclusivamente. | Worklight |
| analytics/nodename | Nome de um nó no cluster. | Uma sequência gerada aleatoriamente
| analytics/datapath | O caminho no qual os dados de análise de dados são salvos no sistema de arquivos. | ./analyticsData |
| analytics/settingspath | O caminho para um arquivo de configurações Elasticsearch. Para obter informações adicionais, consulte Elasticsearch. | Nenhuma |
| analytics/transportport | A porta que é usada para comunicação de nó para nó. | 9600 |
| analytics/httpport | A porta que é usada para comunicação HTTP para Elasticsearch. | 9500 |
| analytics/http.enabled | Ativa ou desativa a comunicação HTTP para Elasticsearch. | falso |
| analytics/serviceProxyURL | O arquivo WAR de UI de análise o arquivo WAR de serviço de análise podem ser instalados em servidores de aplicativos separados. Se optar por fazer isso, você deve entender que o tempo de execução JavaScript no arquivo WAR da UI pode ser bloqueado por prevenção de cross-site scripting no navegador. Para efetuar bypass desse bloqueio, o arquivo WAR da UI inclui um código de proxy Java para que o tempo de execução JavaScript recupere respostas da API REST do servidor de origem. Mas o proxy está configurado para encaminhar solicitações de API REST para o arquivo WAR do serviço de análise de dados. Configure essa propriedade se você instalou seus arquivos WAR em servidores de aplicativos separados. | Nenhuma |
| analytics/bootstrap.mlockall | Essa propriedade evita que a memória Elasticsearch seja trocada no disco. | verdadeiro |
| analytics/multicast | Ativa ou desativa a descoberta de nó multicast. | falso |
| analytics/warmupFrequencyInSeconds | A frequência na qual as consultas warmup são executadas. As consultas warmup são executadas no segundo plano para forçar resultados da consulta na memória, o que melhora o desempenho do console da web. Valores negativos desativam as consultas warmup. | 600 |
| analytics/tenant | Nome do índice Elasticsearch principal.	Worklight |

Em todos os casos em que a chave não contém um ponto (como **httpport** mas não **http.enabled**), a configuração pode ser controlada por variáveis de ambiente do sistema, onde o nome da variável é prefixado com **ANALYTICS_**. Quando a propriedade JNDI e a variável de ambiente do sistema são configuradas, a variável de ambiente do sistema toma precedência. Por exemplo, se você tiver a propriedade JNDI **analytics/httpport** e a variável de ambiente do sistema **ANALTYICS_httpport** configuradas, o valor para **ANALYTICS_httpport** será usado.

#### Tempo de vida (TTL) do documento
{: #document-time-to-live-ttl }
O TTL é efetivamente como é possível estabelecer e manter uma política de retenção de dados. Suas decisões têm consequências dramáticas nas necessidades de recursos do sistema. Quanto maior for o tempo que você mantém os dados, maior será a quantidade de RAM, de disco e de ajuste de escala que provavelmente será necessária.

Cada tipo de documento tem seu próprio TTL. A configuração do TTL de um documento ativa a exclusão automática do documento após ele ter sido armazenado pelo período de tempo especificado.

Cada propriedade JNDI de TTL é chamada de **analytics/TTL_[document-type]**. Por exemplo, a configuração de TTL para **NetworkTransaction** é chamada de **analytics/TTL_NetworkTransaction**.

Esses valores podem ser configurados usando unidades de tempo básicas, conforme a seguir.

* 1Y = 1 ano
* 1M = 1 mês
* 1w = 1 semana
* 1d = 1 dia
* 1h = 1 hora
* 1m = 1 minuto
* 1s = 1 segundo
* 1ms = 1 milissegundo

A lista de tipos de documentos suportados é a seguinte:

* TTL_PushNotification
* TTL_PushSubscriptionSummarizedHourly
* TTL_ServerLog
* TTL_AppLog
* TTL_NetworkTransaction
* TTL_AppSession
* TTL_AppSessionSummarizedHourly
* TTL_NetworkTransactionSummarizedHourly
* TTL_CustomData
* TTL_AppPushAction
* TTL_AppPushActionSummarizedHourly
* TTL_PushSubscription


> **Nota:** se você estiver migrando de versões anteriores do {{ site.data.keys.mf_analytics_server }} e configurou anteriormente quaisquer propriedades JNDI de TTL, consulte [Migração de propriedades de servidor usadas por versões anteriores do {{ site.data.keys.mf_analytics_server }}](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server).

#### Elasticsearch
{: #elasticsearch }
A tecnologia subjacente de armazenamento e armazenamento em cluster que atende o {{ site.data.keys.mf_analytics_console }} é Elasticsearch.  
O Elasticsearch fornece muitas propriedades ajustáveis, a maioria para ajuste de desempenho. Muitas das propriedades JNDI são abstrações de propriedades que são fornecidas pelo Elasticsearch.

Todas as propriedades fornecidas pelo Elasticsearch também podem ser configuradas usando propriedades JNDI com **analytics/** pré-anexado antes do nome da propriedade. Por exemplo, **threadpool.search.queue_size** é uma propriedade fornecida pelo Elasticsearch. Ela pode ser configurada com a seguinte propriedade JNDI.

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

Essas propriedades normalmente são configuradas em um arquivo de configurações customizado. Se estiver familiarizado com o Elasticsearch e o formato de seus arquivos de propriedades, é possível especificar o caminho para o arquivo de configurações usando a propriedade JNDI **settingspath**, conforme a seguir.

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

A menos que você seja um gerente de TI especialista no Elasticsearch, tenha identificado uma necessidade específica ou tenha sido instruído pela equipe de serviços ou de suporte, não tente mexer nessas configurações.

## Fazendo backup de dados do Analytics
{: #backing-up-analytics-data }
Saiba como fazer backup de dados do {{ site.data.keys.mf_analytics }}.

Os dados do {{ site.data.keys.mf_analytics }} são armazenados como um conjunto de arquivos no sistema de arquivos do {{ site.data.keys.mf_analytics_server }}. O local dessa pasta é especificado pela propriedade JNDI datapath na configuração do {{ site.data.keys.mf_analytics_server }}. Para obter informações adicionais sobre as propriedades JNDI, consulte [Propriedades de configuração](#configuration-properties).

A configuração do {{ site.data.keys.mf_analytics_server }} também é armazenada no sistema de arquivos, e é chamada de server.xml.

É possível fazer backup desses arquivos usando procedimentos de backup do servidor existentes que você já pode ter disponíveis. Não é necessário nenhum procedimento especial ao fazer backup desses arquivos, além de assegurar que o {{ site.data.keys.mf_analytics_server }} seja interrompido. Caso contrário, os dados podem mudar enquanto estiver ocorrendo o backup, e os dados que estão armazenados na memória ainda podem não ter sido gravados no sistema de arquivos. Para evitar dados inconsistentes, pare o {{ site.data.keys.mf_analytics_server }} antes de iniciar seu backup.

## Gerenciamento de cluster e Elasticsearch
{: #cluster-management-and-elasticsearch }
Gerencie clusters e inclua nós para aliviar a tensão de memória e de capacidade.

### Incluir um nó no cluster
{: #add-a-node-to-the-cluster }
É possível incluir um novo nó no cluster instalando o {{ site.data.keys.mf_analytics_server }} ou executando uma instância do Elasticsearch independente.

Se você escolher a instância de Elasticsearch independente, alivia alguma tensão no cluster para requisitos de memória e capacidade, mas não alivia a tensão da ingestão de dados. Os relatórios de dados sempre devem passar pelo {{ site.data.keys.mf_analytics_server }} para preservação da integridade de dados e da otimização de dados antes de ir para o armazenamento persistente.

Você pode misturar e coincidir.

O armazenamento de dados do Elasticsearch subjacente espera que os nós sejam homogêneos, portanto, não misture um poderoso sistema de rack 8-core com 64 GB de RAM com um notebook excedente de sobras em seu cluster. Use hardware semelhante entre os nós.

#### Incluindo um {{ site.data.keys.mf_analytics_server }} no cluster
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
Saiba como incluir um {{ site.data.keys.mf_analytics_server }} no cluster.

Como o Elasticsearch está integrado no {{ site.data.keys.mf_analytics_server }}, use a configuração do Elasticsearch para definir o comportamento do cluster. Não crie, por exemplo, um farm do WebSphere Application Server Liberty e não use outras configurações de servidor de aplicativos.

Nas instruções de amostra a seguir, não configure o nó para ser um nó principal ou um nó de dados. Em vez disso, configure o nó como um "balanceador de carga de procura" cujo objetivo estar ativo temporariamente para que a API REST do Elasticsearch esteja exposta para monitoramento e configuração dinâmica.

**Notas:**

* Lembre-se de configurar o hardware e o sistema operacional desse nó de acordo com os [Requisitos do sistema](../installation/#system-requirements).
* A porta 9600 é a porta de transporte que é usada pelo Elasticsearch. Portanto, a porta 9600 deve estar aberta através de quaisquer firewalls entre os nós do cluster.

1. Instale o arquivo WAR do serviço de análise de dados e o arquivo WAR da UI de análise de dados (se desejar a UI) no servidor de aplicativos no sistema recém-alocado. Instale essa instância do {{ site.data.keys.mf_analytics_server }} em qualquer um dos servidores de aplicativos suportados.
    * [Instalando o {{ site.data.keys.mf_analytics }} no WebSphere Application Server Liberty](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [Instalando o {{ site.data.keys.mf_analytics }} no Tomcat](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [Instalando o {{ site.data.keys.mf_analytics }} no WebSphere Application Server](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. Edite o arquivo de configuração do servidor de aplicativos para propriedades JNDI (ou use variáveis de ambiente do sistema) para configurar pelo menos as seguintes sinalizações.

    | Flag | Valor (exemplo) | Padrão | Comunicado |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | Worklight | 	O cluster que você pretende associar a esse nó. |
    | discovery.zen.ping.multicast.enabled | 	falso | 	verdadeiro | 	Configure como false para evitar associação de cluster acidental. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Nenhuma | 	Lista de nós principais no cluster existente. Mude a porta padrão de 9600 se você especificou uma configuração de porta de transporte nos nós principais. |
    | node.master | 	falso | 	verdadeiro | 	Não permitir que esse nó seja um principal. |
    | node.data|	falso | 	verdadeiro | 	Não permitir que esse nó armazene dados. |
    | http.enabled | 	true	 | verdadeiro | 	Abrir porta HTTP 9200 não segura para a API REST Elasticsearch. |

3. Considere todas as sinalizações de configuração em cenários de produção. Talvez você queira que o Elasticsearch mantenha os plug-ins em um diretório do sistema de arquivos diferente dos dados, portanto, é preciso configurar a sinalização **path.plugins**.
4. Execute o servidor de aplicativos e inicie os aplicativos WAR, se necessário.
5. Confirme se esse novo nó se associou ao cluster observando a saída de console nesse novo nó, ou observando a contagem de nós na seção **Cluster e nó** da página **Administração** no {{ site.data.keys.mf_analytics_console }}.

#### Incluindo um nó Elasticsearch independente no cluster
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
Saiba como incluir um nó Elasticsearch independente no cluster.

É possível incluir um nó Elasticsearch independente no cluster {{ site.data.keys.mf_analytics }} existente com apenas algumas etapas simples. No entanto, você deve decidir a função desse nó. Ele será um nó principal elegível? Se sim, lembre-se de evitar o problema de split-brain. Ele será um nó de dados? Será um nó somente cliente? Talvez você queira um nó somente cliente para poder iniciar um nó temporariamente para expor a API REST do Elasticsearch diretamente para afetar as mudanças na configuração dinâmica para seu cluster em execução.

Nas instruções de amostra a seguir, não configure o nó para ser um nó principal ou um nó de dados. Em vez disso, configure o nó como um "balanceador de carga de procura" cujo objetivo estar ativo temporariamente para que a API REST do Elasticsearch esteja exposta para monitoramento e configuração dinâmica.

**Notas:**

* Lembre-se de configurar o hardware e o sistema operacional desse nó de acordo com os [Requisitos do sistema](../installation/#system-requirements).
* A porta 9600 é a porta de transporte que é usada pelo Elasticsearch. Portanto, a porta 9600 deve estar aberta através de quaisquer firewalls entre os nós do cluster.

1. Faça download do Elasticsearch de [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz).
2. Descompacte o arquivo.
3. Edite o arquivo **config/elasticsearch.yml** e configure pelo menos as seguintes sinalizações.

    | Flag | Valor (exemplo) | Padrão | Comunicado |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | Worklight | 	O cluster que você pretende associar a esse nó. |
    | discovery.zen.ping.multicast.enabled | 	falso | 	verdadeiro | 	Configure como false para evitar associação de cluster acidental. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Nenhuma | 	Lista de nós principais no cluster existente. Mude a porta padrão de 9600 se você especificou uma configuração de porta de transporte nos nós principais. |
    | node.master | 	falso | 	verdadeiro | 	Não permitir que esse nó seja um principal. |
    | node.data|	falso | 	verdadeiro | 	Não permitir que esse nó armazene dados. |
    | http.enabled | 	true	 | verdadeiro | 	Abrir porta HTTP 9200 não segura para a API REST Elasticsearch. |


4. Considere todas as sinalizações de configuração em cenários de produção. Talvez você queira que o Elasticsearch mantenha os plug-ins em um diretório do sistema de arquivos diferente dos dados, portanto, é necessário configurar a sinalização path.plugins.
5. Execute `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` para instalar o plug-in ICU.
6. Execute `./bin/elasticsearch`.
7. Confirme se esse novo nó se associou ao cluster observando a saída de console nesse novo nó, ou observando a contagem de nós na seção **Cluster e nó** da página **Administração** no {{ site.data.keys.mf_analytics_console }}.

#### Disjuntores
{: #circuit-breakers }
Saiba sobre disjuntores Elasticsearch.

O Elasticsearch contém vários disjuntores que são usados para impedir que as operações causem um **OutOfMemoryError**. Por exemplo, se uma consulta que entrega dados ao {{ site.data.keys.mf_console }} resultar no uso de 40% do heap da JVM, o disjuntor será acionado, uma exceção será gerada e o console receberá dados vazios.

O Elasticsearch também tem proteções para encher o disco. Se o disco no qual o armazenamento de dados do Elasticsearch está configurado para gravar ocupar 90% da capacidade, o nó Elasticsearch informará o nó principal no cluster. O nó principal então redireciona novas gravações de documentos para fora do nó quase cheio. Se você tiver somente um nó no cluster, nenhum nó secundário no qual os dados podem ser gravados estará disponível. Portanto, os dados não serão gravados e serão perdidos.
