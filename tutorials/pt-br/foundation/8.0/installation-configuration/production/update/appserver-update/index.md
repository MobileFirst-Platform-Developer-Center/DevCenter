---
layout: tutorial
title: Atualizando o servidor MobileFirst
breadcrumb_title: Atualizando o servidor MobileFirst
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

### MobileFirst Operational Analytics Receiver
{: #analyticsreceiver}

A instalação desse componente é opcional. Os aplicativos MobileFirst enviam dados de log para o MobileFirst Operational Analytics Receiver por meio de uma API de REST. Instale esse componente somente se o MobileFirst Operational Analytics estiver instalado. É preferível executar o MobileFirst Operational Analytics Receiver com os outros componentes do MobileFirst Server do mesmo nível de correção temporária (iFix).

## Atualizando o ambiente de tempo de execução do MobileFirst Server Administration Service, do MobileFirst Operations Console e do MobileFirst
{: #updating-server}

É possível atualizar esses componentes de duas maneiras:
* Com a ferramenta de configuração do servidor
* Com as tarefas Ant

O procedimento de atualização depende do método usado na instalação inicial.

>**Nota:**  é recomendável fazer backup do diretório de instalação do MFP existente antes de atualizar o servidor MobileFirst.
> Não é necessário nenhum procedimento especial ao fazer backup desses arquivos, além de assegurar que o servidor MobileFirst esteja parado.  Caso contrário, os dados podem mudar enquanto estiver ocorrendo o backup, e os dados que estão armazenados na memória ainda podem não ter sido gravados no sistema de arquivos. Para evitar a inconsistência de dados, pare o servidor MobileFirst antes de iniciar o backup.
>
O MFP não suporta a recuperação de uma atualização/um iFix por meio do IBM Installation Manager (IM). No entanto, a recuperação é possível por meio de Tarefas ANT ou a Server Configuration Tool (SCT), utilizando os arquivos war relacionados ao MFP que são salvos em backup antes da atualização.
>

<!-- **Note:** Installation Manager(IM) does not support rolling back of an update/iFix. However, rollback is possible using Ant or Server Configuration Tool, if you have the old war files. -->

### Aplicando um fix pack usando o Server Configuration Tool
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Se o {{ site.data.keys.mf_server }} for instalado com a ferramenta de configuração e o arquivo de configuração for mantido, será possível aplicar um fix pack ou uma correção temporária reutilizando o arquivo de configuração.

1. Inicie o Server Configuration Tool.
    * No Linux, em atalhos de aplicativo **Aplicativos → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No Windows, clique em **Iniciar → Programas → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No macOS, abra um console de shell. Acesse **mfp\_server\_install_dir/shortcuts** e digite **./configuration-tool.sh**.
    * O diretório **mfp\_server\_install\_dir** é onde foi instalado o {{ site.data.keys.mf_server }}.

2. Clique em **Configurações → Substituir os arquivos WAR implementados** e selecione uma configuração existente para aplicar o fix pack ou uma correção temporária.

### Recuperar um fix pack usando a Server Configuration Tool
{: #rollback-a-fix-pack-by-using-the-server-configuration-tool }

Caso o MobileFirst seja instalado usando a Server Configuration Tool e o arquivo de configuração seja retido, será possível recuperar um fix pack ou uma correção temporária reutilizando o arquivo de configuração.

1.  Inicie o Server Configuration Tool.
    * Substitua manualmente os arquivos war relacionados ao MFP, copiando-os a partir do local de backup do diretório de instalação do MFP (`mfp_server_install_dir/MobileFirstServer`).
    * No Linux, em atalhos de aplicativo **Aplicativos → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No Windows, clique em **Iniciar → Programas → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * No MacOS, abra um console de shell. Acesse `mfp_server_install_dir/shortcuts e digite ./configuration-tool.sh`.
    * O diretório `mfp_server_install_dir` é o local em que o MobileFirst Server foi instalado.

2.  Selecione a configuração a ser recuperada. Clique em **Configurações** e selecione a opção - **Editar e reimplementar a configuração**.

3.  Clique em **Avançar** em cada página, vá para o final e clique em **Atualizar**.


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

### Recuperar um fix pack usando os arquivos Ant
{: #rollback-a-fix-pack-by-using-the-ant-files }

#### Recuperar com o arquivo Ant de amostra
{: #rollback-with-the-sample-ant-file }

Ao usar os arquivos Ant de amostra fornecidos no diretório `mfp_install_dir/MobileFirstServer/configuration-samples` para instalar o servidor MobileFirst, é possível reutilizar uma cópia desse arquivo Ant para recuperar um fix pack. Para os valores de senha, é possível inserir 12 estrelas (`*`), em vez do valor real, a ser solicitado interativamente quando o arquivo Ant for executado.

1.  Substitua manualmente os arquivos war relacionados ao MFP, copiando-os a partir do local de backup do diretório de instalação do MFP (`mfp_server_install_dir/MobileFirstServer`).
2.  Verifique o valor da propriedade **mfp.server.install.dir** no arquivo Ant. Esse valor é usado para obter os arquivos WAR do servidor MobileFirst atualizados.
3.  Execute o seguinte comando:
    ```bash
    mfp_install_dir/shortcuts/ant -f <your_ant_file update>
    ```

#### Recuperar com o próprio arquivo Ant
{: #rollback-with-own-ant-file }

Ao usar seu próprio arquivo Ant, certifique-se de que para cada tarefa de atualização/recuperação (*installmobilefirstadmin*, *installmobilefirstruntime* e *installmobilefirstpush*), há uma tarefa de atualização correspondente em seu arquivo Ant com os mesmos parâmetros. As tarefas de atualização correspondentes são *updatemobilefirstadmin*, *updatemobilefirstruntime* e *updatemobilefirstpush*.

1.  Substitua manualmente os arquivos war relacionados ao MFP, copiando-os a partir do local de backup do diretório de instalação do MFP (`mfp_server_install_dir/MobileFirstServer`).
2.  Verifique o caminho da classe do elemento **taskdef** para o arquivo `mfp-ant-deployer.jar`. Ele deve apontar para o arquivo mfp-ant-deployer.jar na instalação de um servidor MobileFirst no qual o fix pack seja aplicado. Por padrão, os arquivos WAR do servidor MobileFirst atualizado são obtidos a partir do local do mfp-ant-deployer.jar.
3.  Execute as tarefas de atualização (*updatemobilefirstadmin*, *updatemobilefirstruntime* e *updatemobilefirstpush*) de seu arquivo Ant.
