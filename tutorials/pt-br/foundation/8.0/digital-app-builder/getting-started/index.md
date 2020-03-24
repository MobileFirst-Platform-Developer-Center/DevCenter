---
layout: tutorial
title: Guia de Introdução
weight: 3
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #getting-started }

Ative o Digital App Builder a partir de:

* No **MacOS**, clique duas vezes no **ícone do IBM Digital App Builder** para abrir o Digital App Builder.
* No **Windows**, ative o Digital App Builder selecionando **Iniciar > Programas > IBM Digital App Builder**.

>**Nota**: Se o Digital App Builder for aberto pela primeira vez, **Aceite** a **Licença para usar o IBM Digital App Builder** na tela flash para avançar. Depois de aceitar o contrato de licença, a **Verificação de Pré-requisitos** é executada automaticamente pela primeira vez. Clique em **OK** para continuar, se nenhum erro for localizado, caso contrário, corrija os erros e, em seguida, reinicie o Digital App Builder.

![IBM Digital App Builder](dab-home-screen.png)

**Criar novo aplicativo** ou **Abrir um aplicativo** ou usar os modelos disponíveis para melhorar a construção do aplicativo.
>**Nota**: Os aplicativos criados recentemente serão exibidos na seção **Recente**. Para uma nova instalação, a seção **Recente** não será exibida.

### Criar novo aplicativo
{: #create-new-app }

>**Nota**: Criar novo aplicativo em dois modos: Modo de **Design** - ajuda a projetar o aplicativo pelo método arrastar e soltar e modo de **Código** - ajuda a projetar o aplicativo no modo do editor de código.

Criar um novo aplicativo clicando no ícone **Criar novo aplicativo** no painel do Builder.

1. Clique no ícone **Criar novo aplicativo**. Isso exibirá a janela **Selecionar Canal**.

    ![Selecionar Canal](dab-select-channel.png)

2. Selecione o canal para o qual você deseja desenvolver o aplicativo, clicando no respectivo ícone. Posteriormente, é possível incluir mais canais no mesmo aplicativo.

    * **Android**: selecione essa opção se você estiver criando um aplicativo Android.
    * **iOS**: selecione essa opção se você estiver criando um aplicativo iOS.
        >**Nota**: é possível construir e executar os aplicativos iOS somente no MacOS.
    * **Web**: selecione essa opção se você estiver criando o aplicativo para a Web.
    * **PWA**: selecione essa opção se você estiver criando um Progressive Web App.

3. Quando o servidor de desenvolvimento integrado estiver funcionando, os detalhes do servidor serão buscados automaticamente. Caso o servidor de desenvolvimento não esteja em execução, será possível conectar-se à sua própria instância do servidor IBM Mobile Foundation criada no IBM Cloud ou local.

    Na janela **Configurar instância do IBM Mobile Foundation**, é possível selecionar um servidor existente ou criar um novo servidor.

    >**Nota**: para obter uma instância do Mobile Foundation Server facilmente, basta provisioná-la no IBM Cloud. É possível consultar a documentação sobre como provisionar e usar o Mobile Foundation Server no IBM Cloud [aqui](https://cloud.ibm.com/docs/services/mobilefoundation?topic=mobilefoundation-getting-started).

    ![Configurar instância do IBM Mobile Foundation](dab-config-ibm-cloud-instance.png)
 
    A janela **Configurar instância do IBM Mobile Foundation** exibe a lista de instâncias do servidor Mobile Foundation definidas anteriormente. Ao selecionar o servidor, são exibidos a **URL do servidor**, o **Nome do usuário Admin** e a **senha Admin**. Para definir um novo servidor, é possível clicar no link **Criar novo servidor**. Isso exibirá a nova janela **Configurar instância do IBM Mobile Foundation**.

    ![Criar novo servidor](dab-custom-professional-server.png)

    * Insira os novos detalhes da instância do IBM Mobile Foundation, como **Nome do servidor**, **URL do servidor**, **Nome do usuário administrativo**, **Senha do administrador**.
        >**Nota**: é possível obter a URL do servidor e as credenciais de login no painel do servidor Mobile Foundation para a instância do servidor selecionada.
    * Opcionalmente, forneça um **Nome do usuário** (nome do usuário do cliente confidencial) e uma **Senha do administrador**, para visualizar os dados no visualizador de dados.
    * Clique em **Conectar**.

4. Ao efetuar login/conectar-se com êxito, a janela **Criar aplicativo** é exibida, na qual é possível selecionar uma definição de aplicativo existente que você possa ter criado ou criar uma nova, inserindo os detalhes. 
    * Para um novo aplicativo: 
        * Forneça o **Nome** do aplicativo, o **Local** em que os arquivos de projeto serão armazenados, o **ID do Projeto/Pacote configurável** e a **Versão** do aplicativo. 
 
            ![Shared Playground Server](dab-create-app.png)

        * Clique em **Criar** para criar o aplicativo. Isso exibe as janelas **Modo de seleção**.

            ![Modo de seleção](dab-select-mode.png)

        * Selecione o modo de Design ou de Código e clique em **Introdução**.
            * Modo de Design - Permite criar o aplicativo arrastando e soltando controles em uma tela.
            * Modo de Código - Permite criar o aplicativo gravando código ou usando os Fragmentos de código.
        * Se você selecionou o modo de Design, clicar em **Introdução** exibe a tela pop-up **Bem-vindo ao Ambiente de trabalho**.
            ![Welcome to workbench](dab-welcome.png)
        * Clique em **Vamos iniciar** para exibir a área de trabalho do Digital App Builder para criar um novo aplicativo no modo de Design.

            ![Área de trabalho do DAB](dab-workbench.png)

        * Se você selecionou o modo de Código, clicar em **Introdução** exibe a área de trabalho do Digital App Builder para criar um novo aplicativo no modo de Código.

            ![Área de trabalho do DAB](dab-create-code-mode.png)

### Abrir um aplicativo existente
{: #open-an-existing-app }
 
>**Nota**: é possível abrir um aplicativo existente desenvolvido usando o Digital App Builder apenas. Por padrão, o aplicativo é aberto no modo de design.

É possível abrir um aplicativo existente de uma das maneiras a seguir:

* Clicar em **Abrir um aplicativo** na página inicial abre o explorador de arquivos. Navegue para a pasta do projeto do aplicativo e clique em **OK**para abrir o aplicativo para edições adicionais.
* Opcionalmente, é possível abrir o aplicativo a partir da lista de aplicativos recentes, se listados, clicando duas vezes no nome do aplicativo.

    >**Nota**: Se você selecionou um projeto existente desenvolvido usando o modo de design, ele será aberto no modo de design. Se você tiver o projeto desenvolvido no modo de código, o projeto será aberto no modo de código. 

* Selecione um aplicativo existente e especifique o **Local** em que os arquivos de projeto serão armazenados, o **ID do Projeto/Pacote configurável** e a **Versão** do aplicativo.
* Clique em **Abrir**. Isso exibe as janelas **Modo de seleção**.

    ![Modo de seleção](dab-select-mode.png)

* Selecione o modo de Design ou de Código e clique em **Introdução**.
    * Modo de Design - Permite criar o aplicativo arrastando e soltando controles em uma tela.
    * Modo de Código - Permite criar o aplicativo gravando código ou usando os Fragmentos de código.
* Se você selecionou o modo de Design, clicar em **Introdução** exibe a área de trabalho do Digital App Builder para atualizar um aplicativo existente.

    ![Área de trabalho do DAB](dab-workbench.png)

* Se você selecionou o modo de Código, clicar em **Introdução** exibe a área de trabalho do Digital App Builder para atualizar um aplicativo existente.

    ![Área de trabalho do DAB](dab-create-code-mode.png)
