---
layout: tutorial
title: Instalação e Configuração
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #installation-and-configuration }

Agora, é possível instalar o Digital App Builder nas plataformas MacOS e Windows. O processo também inclui o software obrigatório verificado e instalado durante a primeira instalação. É possível instalar Java, Xcode e Android Studio para a geração de adaptadores e a visualização do aplicativo durante o desenvolvimento.

### Instalando no MacOS
{: #installing-on-macos }

1. Faça download do .dmg (**IBM.Digital.App.Builder-n.n.n.dmg**, em que `n.n.n` é o número da versão) no [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou [aqui](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
2. Clique duas vezes no arquivo .dmg para montar o instalador.
3. Na janela que o instalador abre, arraste e solte o IBM Digital App Builder na pasta **Aplicativos**.
4. Clique duas vezes no ícone do IBM Digital App Builder ou no executável para abrir o Digital App Builder.
    >**Nota**: quando o Digital App Builder for instalado pela primeira vez, ele abrirá a interface para instalar o software obrigatório.
    
    ![Instalando o Digital App Builder](dab-install-startup.png)

5. Clique em **Iniciar a configuração**. Isso exibe a tela do contrato de licença.

    ![Tela do contrato de licença](dab-install-license.png)

6. Aceite o contrato de licença e clique em **Avançar (Next)**. Isso exibe a tela **Instalar pré-requisitos**. >**Nota**: é realizada uma verificação para descobrir se algum dos softwares obrigatórios já está instalado e o status é exibido para cada um deles.

    ![Tela Instalar pré-requisitos](dab-install-prereq.png)

7. Clique em **Instalar** para configurar o software obrigatório, se qualquer um dos pré-requisitos estiver com o status **A ser instalado**.

    ![Tela Instalar pré-requisitos](dab-install-prereq-tobeinstalled.png)

8. Depois de instalar o software obrigatório, a tela de inicialização do Digital App Builder será exibida. Clique em **Iniciar construção**.

    ![Inicialização do Digital App Builder](dab-install-startup-screen.png)

9. *Opcional* - Após a instalação do software obrigatório, o instalador verificará o JAVA, pois o Digital App Builder precisa dele para trabalhar com seus conjuntos de dados. >**Nota**: é necessário instalar o JAVA manualmente, se ele ainda não estiver instalado. Para instalar o Java, consulte [Instalando o Java](https://www.java.com/en/download/help/download_options.xml).
10. *Opcional* - O instalador também verificará a instalação opcional do Xcode (para visualizar seu aplicativo no simulador do iOS durante o desenvolvimento, somente para MacOS) e do Android Studio (para visualizar seu aplicativo Android, para MacOS e Windows). >**Nota**: é necessário instalar manualmente o Xcode e o Android Studio. Para a instalação de Cocoapods, consulte [Usando CocoaPods](https://guides.cocoapods.org/using/using-cocoapods). Para a instalação do Android Studio, consulte [Instalando o Android Studio](https://developer.android.com/studio/). 

>**Nota**: é possível executar uma [Verificação de pré-requisitos](#prerequisites-check) a qualquer momento para verificar se a instalação está adequada para o desenvolvimento do seu aplicativo. No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

### Instalando no Windows
{: #installing-on-windows }

Execute os comandos a seguir no prompt de comandos aberto no modo administrativo:

1. Faça download do arquivo .exe (**IBM.Digital.App.Builder.Setup.n.n.n.exe**, em que `n.n.n` é o número da versão)) no [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou [aqui](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
2. Dê um clique duplo no executável do Digital App Builder a ser instalado.

    ![Instalando o Digital App Builder](dab-install-startup.png)

3. Clique em **Iniciar a configuração**. Isso exibe a tela do contrato de licença.

    ![Tela do contrato de licença](dab-install-license.png)

4. Aceite o contrato de licença e clique em **Avançar (Next)**. Isso exibe a tela **Instalar pré-requisitos**. >**Nota**: é realizada uma verificação para descobrir se algum dos softwares obrigatórios já está instalado e o status é exibido para cada um deles.

    ![Tela Instalar pré-requisitos](dab-install-prereq.png)

5. Clique em **Instalar** para configurar o software obrigatório, se qualquer um dos pré-requisitos estiver com o status **A ser instalado**.

    ![Tela Instalar pré-requisitos](dab-install-prereq-tobeinstalled.png)

6. Depois de instalar o software obrigatório, a tela de inicialização do Digital App Builder será exibida. Clique em **Iniciar construção**.

    ![Inicialização do Digital App Builder](dab-install-startup-screen.png)

    >**Nota**: um atalho também será criado em **Iniciar > Programas** na área de trabalho. A pasta de instalação padrão será `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.2`.

7. *Opcional* - Após a instalação do software obrigatório, o instalador verificará o JAVA, pois o Digital App Builder precisa dele para trabalhar com seus conjuntos de dados. >**Nota**: é necessário instalar o JAVA manualmente, se ele ainda não estiver instalado. Para instalar o Java, consulte [Instalando o Java](https://www.java.com/en/download/help/download_options.xml).
8. *Opcional* - O instalador também verificará a instalação opcional do Xcode (para visualizar seu aplicativo no simulador do iOS durante o desenvolvimento, somente para MacOS) e do Android Studio (para visualizar seu aplicativo Android, para MacOS e Windows). >**Nota**: é necessário instalar manualmente o Android Studio. Para a instalação do Android Studio, consulte [Instalando o Android Studio](https://developer.android.com/studio/). 

>**Nota**: é possível executar uma [Verificação de pré-requisitos](#prerequisites-check) a qualquer momento para verificar se a instalação está adequada para o desenvolvimento do seu aplicativo. No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

### Verificação de pré-requisitos
{: #prerequisites-check }

É possível executar uma verificação de pré-requisitos selecionando **Ajuda > Verificação de pré-requisitos** antes de desenvolver um aplicativo.

![Verificação de pré-requisitos](dab-prerequsites-check.png)

No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

>**Nota**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) são necessários somente para MacOS.

