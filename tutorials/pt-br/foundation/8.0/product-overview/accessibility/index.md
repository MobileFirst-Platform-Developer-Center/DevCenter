---
layout: tutorial
title: Recursos de acessibilidade para o IBM MobileFirst Foundation
breadcrumb_title: Accessibility features
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Os recursos de acessibilidade ajudam os usuários que têm uma deficiência, como mobilidade restrita ou visão limitada, a usar conteúdo de tecnologia da informação com sucesso.

### Recursos de Acessibilidade
{: #accessibility-features }
{{ site.data.keys.product_full }} inclui os principais recursos de acessibilidade a seguir:

* Operação somente por teclado
* Operações que suportam o uso de um leitor de tela

{{ site.data.keys.product }} usa o W3C Standard, [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/) mais recente para garantir a conformidade com a [US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards) e o [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/). Para aproveitar os recursos de acessibilidade, use a liberação mais recente do seu leitor de tela junto com o navegador da web mais recente suportado por este produto.

### Navegação pelo Teclado
{: #keyboard-navigation }
Esse produto usa as chaves de navegação padrão

### Informações de interface
{: #interface-informaton }
As interfaces com o usuário do {{ site.data.keys.product }} não possuem conteúdo que é atualizado de 2 a 55 vezes por segundo.

É possível usar um leitor de tela com um sintetizador de voz digital para ouvir o que é exibido em sua tela. Consulte a documentação sobre tecnologia assistiva para obter detalhes sobre como usá-la com este produto e sua documentação.

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
Por padrão, as mensagens de status que são exibidas pelo {{ site.data.keys.mf_cli }} usam várias cores para indicar sucesso, erros e avisos. É possível usar a opção `--no-color` em qualquer comando {{ site.data.keys.mf_cli }} para suprimir o uso dessas cores para aquele comando. Quando `--no-color` é especificado, a saída é exibida nas cores de exibição do texto configuradas para o console do sistema operacional.

### interface da Web 
{: #web-interface }
As interfaces com o usuário da web do {{ site.data.keys.product }} dependem das folhas de estilo em cascata para renderizar o conteúdo corretamente e fornecem uma experiência utilizável. O aplicativo fornece uma forma equivalente para usuários de baixa visão usarem configurações de exibição do sistema de usuários, incluindo o modo de alto contraste. É possível controlar o tamanho de fonte usando as configurações do dispositivo ou do navegador da web.

É possível navegar pelos diferentes ambientes do {{ site.data.keys.product_adj }} e sua documentação usando os atalhos de teclado. O Eclipse fornece os recursos de acessibilidade para os seus ambientes de desenvolvimento. Navegadores da Internet também fornecem recursos de acessibilidade para aplicativos da web, como o {{ site.data.keys.mf_console }}, o {{ site.data.keys.mf_analytics_console }}, o console do {{ site.data.keys.product }} Application Center e o cliente móvel do {{ site.data.keys.product }} Application Center.

A interface com o usuário da web do {{ site.data.keys.product }} inclui referências de navegação WAI-ARIA que você pode usar para navegar rapidamente para as áreas funcionais no aplicativo.

### Instalação e configuração
{: #installation-and-configuration }
Há duas maneiras de instalar e configurar o {{ site.data.keys.product }}: pela interface gráfica com o usuário (GUI) ou pela linha de comandos.

Embora a interface gráfica com o usuário (IBM Installation Manager no modo do assistente ou a Ferramenta de Configuração do Servidor) não forneça informações sobre objetos da interface com o usuário, uma função equivalente está disponível com a interface da linha de comandos. Todas as funções na GUI são suportadas por meio da linha de comandos e alguns recursos particulares de instalação e configuração estão disponíveis apenas com a linha de comandos. É possível ler sobre os recursos de acessibilidade do [IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) no IBM Knowledge Center.

Os tópicos a seguir fornecem informações sobre como a instalação e a configuração podem ser feitas sem a GUI:

* Trabalhando com arquivos de resposta de amostra para o IBM Installation Manager
Este método permite a instalação e a configuração silenciosas do {{ site.data.keys.mf_server }} e do Application Center. Você tem a possibilidade de não instalar o Application Center usando o arquivo de resposta denominado install-no-appcenter.xml. Você pode, então, usar a tarefa Ant
para instalá-lo posteriormente. Consulte Instalando o Application Center com tarefas Ant. Nesse caso, a instalação e o upgrade do Application Center podem ser feitos de forma independente.
* Instalando com tarefas Ant
* Instalando o Application Center com tarefas Ant

### Software do fornecedor
{: #vendor-software }
{{ site.data.keys.product }} inclui certos produtos de software de fornecedor que não estão cobertos no contrato de licença da IBM. A IBM não representa nenhum recurso de acessibilidade desses produtos. Entre em contato com o fornecedor para obter informações de acessibilidade sobre seus produtos.

### Informações Relacionadas à Acessibilidade
{: #related-accessibility-information }
Além do IBM help desk padrão e websites de suporte, a IBM estabeleceu um serviço de telefone TTY para uso por clientes com deficiência auditiva para acessar serviços de vendas e suporte:

Serviço TTY  
800-IBM-3383 (800-426-3383)  
(na América do Norte)

### IBM e acessibilidade
{: #ibm-and-accessibility }
Para obter mais informações sobre o compromisso da IBM com a acessibilidade, veja [Acessibilidade IBM](http://www.ibm.com/able).


