---
layout: tutorial
title: Guia de Instalação da Estação de Trabalho
breadcrumb_title: Guia de Instalação
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
Siga esse guia de instalação para configurar sua estação de trabalho para desenvolvimento usando o {{ site.data.keys.product }}.

## DevKit Installer
{: #devkit-installer }
O [{{ site.data.keys.mf_dev_kit }} Installer]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst) irá instalar um {{ site.data.keys.mf_server }}, banco de dados e tempo de execução prontos para uso na máquina do desenvolvedor.  

**Pré-requisito: **  
O instalador requer o Java instalado.

1. [Instalar JRE do Oracle](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).

2. Inclua uma variável `JAVA_HOME`, apontando para o JRE

    *Mac e Linux:* Edite seu **~/.bash_profile**:

    ```bash
    #### ORACLE JAVA
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
    ```

    *Windows:*  
    [Siga esse guia](https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html).

### Tarefas de Instalação
{: #installation }
Obtenha o DevKit Installer na [página Downloads]({{site.baseurl}}/downloads/) e siga as instruções na tela.

![devkit installer](devkit-installer.png)

### Iniciando e Parando o Servidor
{: #starting-and-stopping-the-server }
Abra uma janela de linha de comandos e navegue para o local da pasta extraída.

*Mac e Linux:*  

* Para iniciar o servidor: `./run.sh -bg`
* Para parar o servidor: `./stop.sh`

*Windows:*  

* Para iniciar o servidor: `./run.cmd -bg`
* Para parar o servidor: `./stop.cmd`

### Acessando o {{ site.data.keys.mf_console }}
{: #accessing-the-mobilefirst-operations-console }
É possível acessar o [{{ site.data.keys.mf_console }}]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) das seguintes maneiras:

* Na linha de comandos, execute: `mfpdev server console`
* Em um navegador, visite: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)

![console]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/dashboard.png)

## {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
O [{{ site.data.keys.mf_cli }}]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) é uma interface da linha de comandos que permite registrar aplicativos no {{ site.data.keys.mf_server }}, aplicativo pull/push de/para o {{ site.data.keys.mf_server }}, criar adaptadores Java e JavaScript, gerenciar vários servidores locais e remotos, atualizar aplicativos em tempo real usando o Direct Update etc

**Pré-requisito: **  
1. NodeJS é um requisito antes da instalação do {{ site.data.keys.mf_cli }}.  
 Faça download e instale o [NodeJS v4.4.3 LTS](https://nodejs.org/en/).

 Para verificar a instalação, abra uma janela de linha de comandos e execute: `node -v`.

2. Alguns comandos da CLI, como criar, construir e implementar adaptadores requerem o Maven. Consulte a próxima seção para obter instruções de instalação.

### Instalação do {{ site.data.keys.mf_cli }}
{: #installation-cli }
Abra Terminal e execute: `npm install -g mfpdev-cli`.  

*Mac e Linux:* Observe que pode ser necessário executar o comando usando `sudo`.  
Leia mais sobre [corrigindo permissões de NPM](https://docs.npmjs.com/getting-started/fixing-npm-permissions).

Para verificar a instalação, abra uma janela de linha de comandos e execute: `mfpdev -v` ou `mfpdev help`.

![console](mfpdev-cli.png)

## Adaptadores e verificações de segurança
{: #adapters-and-security-checks }
[Adaptadores]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters) e [Verificações de segurança]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security) são sua entrada para introduzir autenticação e outras camadas de segurança em seu aplicativo.

**Pré-requisito: **  
O Apache Maven é necessário para configuração antes da criação de adaptadores e verificações de segurança.  

1. [Faça download do .zip do Apache Maven](https://maven.apache.org/download.cgi)
2. Inclua uma variável `MVN_PATH`, apontando para a pasta Maven

    *Mac e Linux:* Edite seu **~/.bash_profile**:

    ```bash
    #### Apache Maven
    export MVN_PATH="/usr/local/bin"
    ```

    *Windows:*  
    [Siga esse guia](http://crunchify.com/how-to-setupinstall-maven-classpath-variable-on-windows-7/).
Verifique a instalação executando: `mvn -v`.

### USO
{: #usage }
Com o Apache Maven instalado, agora é possível criar adaptadores por meio de comandos da linha de comandos do Maven ou usando o {{ site.data.keys.mf_cli }}.  
Para obter informações adicionais, revise os [tutoriais Adaptadores]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).
