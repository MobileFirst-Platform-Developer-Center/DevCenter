---
layout: tutorial
title: Guia de configuração do MobileFirst Analytics Receiver Server
breadcrumb_title: Guia de Configuração
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Configuração para o {{ site.data.keys.mf_analytics_receiver_server }}.

#### Ir para
{: #jump-to }

* [Propriedades de configuração](#configuration-properties)

### Propriedades
{: #properties }
Para obter uma lista completa de propriedades de configuração e como configurá-las em seu servidor de aplicativos, consulte a seção [Propriedades de configuração](#configuration-properties).

## Propriedades de Configuração
{: #configuration-properties }
O {{ site.data.keys.mf_analytics_receiver_server }} pode ser iniciado com êxito com a configuração adicional a seguir.

A configuração é feita por meio de propriedades JNDI no {{ site.data.keys.mf_server }} e no {{ site.data.keys.mf_analytics_receiver_server }}. Além disso, o {{ site.data.keys.mf_analytics_receiver_server }} suporta o uso de variáveis de ambiente para controlar a configuração. As variáveis de ambiente têm precedência sobre propriedades JNDI.

O aplicativo da web de tempo de execução do Analytics Receiver deve ser reiniciado para que quaisquer mudanças nessas propriedades entrem em vigor. Não é necessário reiniciar o servidor de aplicativos inteiro.

Para configurar uma propriedade JNDI no WebSphere Application Server Liberty, inclua uma tag no arquivo `server.xml`, conforme a seguir.

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Para configurar uma propriedade JNDI no Tomcat, inclua uma tag no arquivo `context.xml` conforme a seguir.

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

As propriedades JNDI no WebSphere Application Server estão disponíveis como variáveis de ambiente.

* No console do WebSphere Application Server, selecione **Aplicativos → Tipos de aplicativos → Aplicativos corporativos WebSphere**.
* Selecione o aplicativo **{{ site.data.keys.product_adj }}Administration Service**.
* Em **Propriedades do Módulo da Web**, clique em **Entradas de Ambiente para Módulos da Web** para exibir as propriedades de JNDI.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
A tabela a seguir mostra as propriedades que podem ser configuradas no {{ site.data.keys.mf_analytics_receiver_server }}.

| Propriedade                           | Descrição                                           | Valor Padrão |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | Configure esta propriedade para a URL do {{ site.data.keys.mf_analytics_console }}. Por exemplo, `http://hostname:port/analytics/console`. Configurar essa propriedade ativa o ícone de análise de dados no {{ site.data.keys.mf_console }}. | Nenhuma |
| receiver.analytics.url                  |Requerido. A URL exposta pelo {{ site.data.keys.mf_analytics_server }} que recebe dados de análise de dados recebidos. Por exemplo, `http://hostname:port/analytics-service/rest`. | Nenhuma |
| receiver.analytics.username             | O nome do usuário que será usado se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |
| receiver.analytics.password             | A senha que será usada se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |
| receiver.analytics.event.qsize          | Tamanho da fila de eventos analíticos. É necessário incluí-lo com cuidado, fornecendo um tamanho de heap da JVM amplo. Tamanho da fila padrão 10000  | Nenhuma |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
A tabela a seguir mostra as propriedades que podem ser configuradas no {{ site.data.keys.mf_server }}.

| Propriedade                           | Descrição                                           | Valor Padrão |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  | Requerido. A URL exposta pelo {{ site.data.keys.mf_analytics_receiver_server }} que recebe dados de analítica de entrada e os encaminha para o {{ site.data.keys.mf_analytics_server }}. Por exemplo, `http://hostname:port/analytics-receiver/rest`. | Nenhuma |
| mfp.analytics.receiver.username             | O nome do usuário que será usado se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |
| mfp.analytics.receiver.password             | A senha que será usada se o ponto de entrada de dados for protegido com autenticação básica. | Nenhuma |
