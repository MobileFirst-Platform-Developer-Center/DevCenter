---
layout: tutorial
title: Licenciamento no MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O IBM {{ site.data.keys.mf_server }} suporta dois métodos de licenciamento diferentes com base no que você comprou.

Se você tiver adquirido licenças Perpétuas, será possível consumir o que você comprou e verificar seu uso e conformidade por meio da **página Rastreamento de licença** no {{ site.data.keys.mf_console }} e por meio do [relatório Rastreamento de licença](../../administering-apps/license-tracking/#license-tracking-report). Se você tiver comprado licenças de token, configure o {{ site.data.keys.mf_server }} para se comunicar com um servidor de licença de token remoto.

### Licenças de aplicativo ou de dispositivo endereçável
{: #application-or-addressable-device-licenses }
Se você tiver comprado licenças de aplicativo ou de dispositivo endereçável, será possível consumir o que comprou e verificar seu uso e conformidade por meio da página Rastreamento de licença no {{ site.data.keys.mf_console }} e por meio do relatório Rastreamento de licença.

### Virtual Processor Cores (licenciamento de VPC)
{: #vpc-licensing}

O Mobile Foundation também está disponível com licenciamento baseado em capacidade chamado Cores do Processador Virtual (VPC). VPC é uma unidade de medida que é usada para determinar o custo de licenciamento para o Mobile Foundation e é baseada no número de núcleos que estão disponíveis. Atualmente, essa métrica está disponível apenas para o Cloud Pak for Applications.

Os recursos desta métrica são os seguintes,

* Os clientes podem executar qualquer número de aplicativos e dispositivos. Consequentemente, essa forma de licença seria benéfica em comparação com a licença do aplicativo em cenários em que os clientes têm muitos aplicativos em sua implementação.

* Alinhado com outros produtos no portfólio e fornece flexibilidade aos clientes para implementações de nuvem híbrida.


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
