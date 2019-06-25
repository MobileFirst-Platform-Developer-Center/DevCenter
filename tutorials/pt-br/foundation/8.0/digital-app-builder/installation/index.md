---
layout: tutorial
title: Instalação e Configuração
weight: 2
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #installation-and-configuration }

É possível instalar o Digital App Builder na plataforma MacOS e Windows.

### Instalando no MacOS
{: #installing-on-macos }

1. Instale **Node.js** e **npm** fazendo o download da configuração a partir de [https://nodejs.org/en/download](https://nodejs.org/en/download) (Node.js 8.x ou superior). Para obter mais informações sobre instruções de instalação, consulte [aqui](https://nodejs.org/en/download/package-manager/). Verifique a versão do nó e do npm, conforme mostrado abaixomarcar:
    ```java
    $node -v
    v8.10.0
    $npm -v
    6.4.1
    ```
2. Instale o **Cordova**. É possível fazer download e instalar o pacote a partir do [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html).
    ```java
    $ npm install -g cordova
    $ cordova –version
    7.0.1
    ```

    >**Nota**: se você estiver enfrentando qualquer problema de permissão ao executar o comando `$ npm install -g cordova`, instale usando privilégios elevados (`$ sudo npm install -g cordova`).

3. Instale o **ionic**. É possível fazer download e instalar o pacote a partir do [ionic](https://ionicframework.com/docs/cli/).
    ```java
    $ npm install -g ionic
    $ ionic –version
    4.2.0
    ```

    >**Nota**: se você estiver enfrentando qualquer problema de permissão ao executar o comando `$ npm install -g ionic`, instale usando privilégios elevados (`$ sudo npm install -g ionic`).

4. Faça download do .dmg (**IBM.Digital.App.Builder-8.0.0.dmg**) a partir do [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou [aqui](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
5. Clique duas vezes no arquivo .dmg para montar o instalador.
6. Na janela que o instalador abre, arraste e solte o IBM Digital App Builder na pasta **Aplicativos**.
7. Clique duas vezes no ícone do IBM Digital App Builder ou no executável para abrir o Digital App Builder.
>**Nota**: quando o Digital App Builder é instalado pela primeira vez, o Digital App Builder abre a interface e executa uma [Verificação de pré-requisitos](#prerequisites-check). No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

### Instalando no Windows
{: #installing-on-windows }

Execute os comandos a seguir no prompt de comandos aberto no modo administrativo:

1. Instale **Node.js** e **npm** fazendo o download da configuração a partir de [https://nodejs.org/en/download](https://nodejs.org/en/download) (Node.js 8.x ou superior). Para obter mais informações sobre instruções de instalação, consulte [aqui](https://nodejs.org/en/download/package-manager/). Verifique a versão do nó e do npm, conforme mostrado abaixo: 

    ```java
    C:\>node -v
    v8.10.0
    C:\>npm -v
    6.4.1
    ```

2. Instale o **Cordova**. É possível fazer download e instalar o pacote a partir do [Cordova](https://cordova.apache.org/docs/en/latest/guide/cli/index.html).

    ```java
    C:\>npm install -g cordova
    C:\>cordova –v
    7.0.1
    ```

3. Instale o **ionic**. É possível fazer download e instalar o pacote a partir do [ionic](https://ionicframework.com/docs/cli/).

    ```java
    C:\>npm install -g ionic
    C:\> ionic –version
    4.2.0
    ``` 

4. Faça download do .exe (**IBM.Digital.App.Builder.Setup.8.0.0.exe**) a partir do [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/) ou [aqui](https://github.com/MobileFirst-Platform-Developer-Center/Digital-App-Builder/releases).
5. Dê um clique duplo no executável do Digital App Builder a ser instalado. Um atalho também é criado em **Iniciar > Programas** na área de trabalho. A pasta de instalação padrão é `<AppData>\Local\IBMDigitalAppBuilder\app-8.0.0`.
>**Nota**: quando o Digital App Builder é instalado pela primeira vez, o Digital App Builder abre a interface e executa uma [Verificação de pré-requisitos](#prerequisites-check). No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

### Verificação de pré-requisitos
{: #prerequisites-check }

É possível executar uma verificação de pré-requisitos selecionando **Ajuda > Verificação de pré-requisitos** antes de desenvolver um aplicativo.

![Verificação de pré-requisitos](dab-prerequsites-check.png)

No caso de qualquer erro, corrija o erro e reinicie o Digital App Builder antes de criar um aplicativo.

>**Nota**: [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods) são necessários somente para MacOS.

