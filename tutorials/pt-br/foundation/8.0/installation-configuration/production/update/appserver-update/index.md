---
layout: tutorial
title: Atualizando o servidor MobileFirst
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O IBM MobileFirst Platform Foundation fornece vários componentes que podem ter sido instalados.

A seguir está uma descrição de suas dependências para atualizá-las:

### O ambiente de tempo de execução do MobileFirst Server Administration Service, do MobileFirst Operations Console e do MobileFirst
{: #server-console }

Esses três componentes compõem o MobileFirst Server. Eles devem ser atualizados juntos.

### Application Center
{: #appenter}

A instalação desse componente é opcional. Esse componente é independente dos outros componentes. Ele pode ser executado em um nível de correção temporária diferente dos outros, se necessário.

### MobileFirst Operational Analytics
{: #analytics}

A instalação desse componente é opcional. Os componentes do MobileFirst enviam dados para o MobileFirst Operational Analytics por meio de uma API de REST. A preferência é que se execute o MobileFirst Operational Analytics com os outros componentes do MobileFirst Server do mesmo nível de correção temporária.


## Atualizando o ambiente de tempo de execução do MobileFirst Server Administration Service, do MobileFirst Operations Console e do MobileFirst
{: #updating-server}

É possível atualizar esses componentes de duas maneiras:
* Com a ferramenta de configuração do servidor
* Com as tarefas Ant

O procedimento de atualização depende do método usado na instalação inicial.

> **Observação:** o Installation Manager (IM) não suporta o retrocesso de uma atualização/iFix. No entanto, será possível retroceder usando o Ant e a ferramenta de configuração do servidor, se você tiver os arquivos WAR antigos.

### Aplicando um fix pack usando o Server Configuration Tool
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Se o {{ site.data.keys.mf_server }} for instalado com a ferramenta de configuração e o arquivo de configuração for mantido, será possível aplicar um fix pack ou uma correção temporária reutilizando o arquivo de configuração.

1. Inicie o Server Configuration Tool.
    * No Linux, em atalhos de aplicativo **Aplicativos → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No Windows, clique em **Iniciar → Programas → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No macOS, abra um console de shell. Acesse **mfp\_server\_install_dir/shortcuts** e digite **./configuration-tool.sh**.
    * O diretório **mfp\_server\_install\_dir** é onde foi instalado o {{ site.data.keys.mf_server }}.

2. Clique em **Configurações → Substituir os arquivos WAR implementados** e selecione uma configuração existente para aplicar o fix pack ou uma correção temporária.


### Aplicando um fix pack usando os arquivos Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Atualizando com o arquivo Ant de amostra
{: #updating-with-the-sample-ant-file }
Se você usar os arquivos Ant de amostra fornecidos no diretório **mfp\_install\_dir/MobileFirstServer/configuration-samples** para instalar o {{ site.data.keys.mf_server }}, será possível reutilizar uma cópia desse arquivo Ant para aplicar um fix pack. Para valores de senha, é possível inserir 12 estrelas (\*) em vez do valor real, a ser solicitado interativamente quando o arquivo Ant for executado.

1. Verifique o valor da propriedade **mfp.server.install.dir** no arquivo Ant. Ele deve apontar para o diretório que contém o produto com o fix pack aplicado. Esse valor é usado para obter os arquivos WAR do {{ site.data.keys.mf_server }} atualizados.
2. Execute o comando: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Atualizando com seu próprio arquivo Ant
{: #updating-with-own-ant-file }
Se você usar seu próprio arquivo Ant, certifique-se de que, para cada tarefa de instalação task (**installmobilefirstadmin**, **installmobilefirstruntime** e **installmobilefirstpush**), você tenha uma tarefa de atualização correspondente em seu arquivo Ant com os mesmos parâmetros. As tarefas de atualização correspondentes são **updatemobilefirstadmin**, **updatemobilefirstruntime** e **updatemobilefirstpush**.

1. Verifique o caminho da classe do elemento **taskdef** para o arquivo **mfp-ant-deployer.jar**. Ele deve apontar para o arquivo **mfp-ant-deployer.jar** em uma instalação do {{ site.data.keys.mf_server }} à qual o fix pack é aplicado. Por padrão, os arquivos WAR do {{ site.data.keys.mf_server }} atualizados são obtidos do local **mfp-ant-deployer.jar**.
2. Execute as tarefas de atualização (**updatemobilefirstadmin**, **updatemobilefirstruntime** e **updatemobilefirstpush**) de seu arquivo Ant.
