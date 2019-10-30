---
layout: tutorial
title: Detecção de problemas
weight: 17
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #troubleshooting }

Localize respostas para alguns dos problemas que você pode encontrar ao usar o IBM Digital App Builder.

* No caso de qualquer erro, consulte:

    * Arquivo `log.log` para o respectivo caminho de pasta de plataforma:

        * No Mac OS: `~/Library/Logs/IBM Digital App Builder/log.log`.

        * No Windows: `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`.

    * `applog.log` para logs relacionados ao seu aplicativo, que podem ser localizados em `<APP LOCATION>/ibm/applog.log`.

* Falha ao criar um conjunto de dados para um Microsserviço usando um arquivo swagger.

    Para os usuários que estão usando o Builder pela primeira vez, a criação do microsserviço pode falhar devido à latência de rede.
    Para livrar-se disso, siga estas etapas:
    1. Abra o prompt de comandos e acesse o local instalado do aplicativo.
    2. `cd ibm\adapterGenerator`
    3. Execute o comando a seguir
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. Na execução bem-sucedida do comando acima, é possível começar a usar o microsserviço (arquivo swagger) do Digital App Builder.

* Falha ao visualizar o aplicativo no Windows.

    No Digital App Builder, acesse **Configurações > Reparar projeto** e clique em **Reconstruir dependências** e **Reconstruir plataformas**.

* O aplicativo Android não funciona após a inclusão do componente Lista no aplicativo.

    Isso é devido à versão do Android WebView ser menor que 68.X.XXXX.XX. Para resolver isso, faça upgrade da versão do Android WebView para 68.X.XXXX.XX ou superior.

* No MacOS, a visualização do aplicativo em um simulador Android falha com travamentos do aplicativo. Com o erro a seguir:

    `java.lang.RuntimeException: Não foi possível criar o aplicativo com.ibm.MFPApplication: java.lang.RuntimeException: Arquivo de configuração do cliente mfpclient.properties não localizado nos recursos do aplicativo. Use o comando da CLI MFP 'mfpdev app register' para criar o arquivo.`

    Para resolver isso, a partir do terminal, navegue para o diretório ionic do aplicativo e execute os comandos a seguir:

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    e visualize a partir do Digital App Builder novamente.

* Não é possível gerar o adaptador ao importar o arquivo swagger json/yaml.

    Erro ao importar o arquivo swagger json/yaml e o erro é devido à dependência do Maven.

    Idealmente, todas as dependências do Maven, se não existirem, são transferidas por download e instaladas em segundo plano. Mas há alguns casos em que o Maven falha devido a várias versões do Maven no sistema. Para resolver esse problema, siga estas etapas:

    a. Acesse o local Aa\pp e abra o arquivo execute.sh/execute.bat, dependendo do S.O. (`<APP_LOCATION>\ibm\adapterGenerator`)

    b. Edite todo o `call %MAVEN_HOME% clean install` para `call %MAVEN_HOME% -U clean install`.

        A inclusão de `-U` forçará o Maven a verificar quaisquer dependências externas que precisem ser atualizadas com base no arquivo POM.

* A verificação de pré-requisitos falha para o Android Studio, mesmo quando ele está instalado.

    Certifique-se de que tenha o executável do android (`<path to android sdk>/tools`) no caminho e verifique os pré-requisitos.

* Problema de criação e visualização do aplicativo no Windows 7

    É possível que um erro ocorra ao tentar criar um novo aplicativo em um local da unidade de disco diferente do `C:`.

    Certifique-se de criar seu projeto de aplicativo na unidade `C://<your folder name/app name>`.

* O Digital App Builder trava com uma tela vermelha.

    Se você vir um travamento com tela vermelha, verifique os logs neste local:
    * No MacOS - `/Users/<username>/Library/Logs/IBM Digital App Builder/log.log`
    * No Windows - `C:\\Users\<username>\AppData\Roming\IBM Digital App Builder\log.log`

    Se o erro for sobre um `getPath` de `rendered.js`, ele será um [erro de elétron](https://github.com/electron/electron/issues/8205) conhecido.

    Isso acontece aleatoriamente.

    Reinicie o Digital App Builder e seu cenário deve funcionar.
