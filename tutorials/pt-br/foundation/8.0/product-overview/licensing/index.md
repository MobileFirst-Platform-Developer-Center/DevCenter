---
layout: tutorial
title: Licenciamento no MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão geral
{: #overview }
O IBM {{ site.data.keys.mf_server }} suporta dois métodos de licenciamento diferentes com base no que você comprou.

Se você tiver adquirido licenças Perpétuas, será possível consumir o que você comprou e verificar seu uso e conformidade por meio da **página Rastreamento de licença** no {{ site.data.keys.mf_console }} e por meio do [relatório Rastreamento de licença](../../administering-apps/license-tracking/#license-tracking-report). Se você tiver comprado licenças de token, configure o {{ site.data.keys.mf_server }} para se comunicar com um servidor de licença de token remoto.

### Licenças de aplicativo ou de dispositivo endereçável
{: #application-or-addressable-device-licenses }
Se você tiver comprado licenças de aplicativo ou de dispositivo endereçável, será possível consumir o que comprou e verificar seu uso e conformidade por meio da página Rastreamento de licença no {{ site.data.keys.mf_console }} e por meio do relatório Rastreamento de licença.

### Licenciamento da unidade de valor do processador (PVU)
{: #processor-value-unit-pvu-licensing }
O licenciamento da unidade de valor do processador (PVU) estará disponível se você tiver comprado o IBM {{ site.data.keys.product }} Extension (consulte [documentos de Informações de Licença](http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument)), mas somente após a compra do IBM WebSphere Application Server Network Deployment, IBM API Connect™ Professional ou IBM API Connect Enterprise.

A estrutura de precificação de licença de PVU é responsiva ao tipo e número de processadores que estão disponíveis para os produtos instalados. As autorizações podem ser de capacidade total ou de subcapacidade. Sob a estrutura de licenciamento da
unidade de valor do processador, o software é licenciado com base no número de unidades de valor designadas
para cada núcleo de processador.

Por exemplo, o processador tipo A tem 80 unidades de valor atribuídas por núcleo e o processador tipo B tem 100 unidades de valor atribuídas por núcleo. Se você licenciar um produto para ser executado em dois processadores tipo A, deverá adquirir uma autorização para 160 unidades de valor por núcleo. Se o produto for executado em dois processadores tipo B, a autorização necessária será de 200 unidades de valor por núcleo.

> [Leia mais informações](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html) sobre o licenciamento por PVU.

### Licenciamento de token
{: #token-licensing }
Em um ambiente de token,
cada produto consome um valor de token predefinido por licença, em comparação
com um ambiente flutuante tradicional em que uma quantidade predefinida
por licença é consumida. A chave de licença tem um conjunto de tokens do
qual o servidor de licença calcula os tokens que são registrados
e retirados. Os tokens são consumidos ou liberados quando um produto
registra ou retira licenças do servidor de licença.

Seu contrato
de licenciamento define se você pode conseguir usar o licenciamento de
token, o número de tokens disponível e os recursos que são validados
pelos tokens. Consulte Validação de licença de token.

Se você tiver comprado licenças
baseadas em token, instale uma versão do
{{ site.data.keys.mf_server }}
que suporta licenças de token e configure seu servidor de aplicativos
para que seu servidor possa se comunicar com o servidor de token
remoto. Consulte Instalando e configurando para licenciamento de token.

Com o
licenciamento de token, é possível especificar o tipo de aplicativo de licença no descritor
de aplicativo de cada um de seus aplicativos antes de implementá-los. O tipo de aplicativo da licença pode ser APPLICATION ou ADDITIONAL_BRAND_DEPLOYMENT. Para teste, é possível configurar o valor do tipo do aplicativo de licença para NON_PRODUCTION. Para obter mais informações, consulte Configurando as informações de licença do aplicativo.

A ferramenta Rational License Key Server Administration and Reporting que é liberada com o Rational License Key Server 8.1.4.9 pode administrar e gerar relatórios para a licença consumida pelo {{ site.data.keys.product }}. É possível identificar as partes relevantes do relatório pelos nomes de exibição a seguir: **MobileFirst Platform Foundation Application** ou **MobileFirst Platform Additional Brand Deployment**. Esses nomes referem-se
ao tipo de aplicativo de licença para o qual os tokens são consumidos. Para obter mais informações, consulte [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) e [Visão geral da ferramenta de relatório e Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

Para obter informações sobre o planejamento para usar o licenciamento de token com o {{ site.data.keys.mf_server }}, consulte Planejamento para o uso de licenças de token.

Para obter as chaves de licença para o {{ site.data.keys.product }}, você precisa acessar o IBM Rational License Key Center. Para obter mais informações sobre como gerar e gerenciar suas chaves de licenças, consulte [Suporte IBM - Licenciamento](http://www.ibm.com/software/rational/support/licensing/).
