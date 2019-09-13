---
layout: tutorial
title: Desenvolvendo um app
weight: 5
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #developing-an-app }

O desenvolvimento de um aplicativo inclui as etapas a seguir:

1. Criar um aplicativo. Consulte a seção [Criando um aplicativo](../getting-started/).
2. Projetar seu aplicativo, incluindo os controles necessários. Para obter mais informações, consulte [Interface do Digital App Builder](../dab-interface/).
3. Incluir os serviços necessários (Watson Chat, Watson Visual Recognition, Notificações Push, Conjunto de Dados) em seu aplicativo.
4. Incluir ou modificar as Plataformas, se necessário. Consulte a seção [Configurações > Detalhes do aplicativo](../dab-interface/).
5. Visualizar seu aplicativo. Consulte [Visualize o aplicativo usando o simulador](#preview-the-app-using-the-simulator).
6. Depois de visualizar seu aplicativo e se ele estiver pronto para construção, depois de corrigir quaisquer erros, execute as etapas a seguir para construir o aplicativo:

    * **Para aplicativo Android:**

        a. Navegue para o diretório que você especificou no momento da criação do aplicativo.

        b. Acesse a pasta ionic.

        c. Acesse **Plataforma >Android**.

        d. Abra o Android Studio e, em seguida, acesse **Arquivo >Abrir Projeto**>Escolha a pasta android mencionada na etapa c.

        e. Construa o projeto. 

        >**Nota**: para publicar e construir, siga as etapas do tutorial [https://developer.android.com/studio/publish/](https://developer.android.com/studio/publish/).

    * **Para aplicativo iOS**:
 
        a. Navegue para o diretório que você especificou no momento da criação do aplicativo.

        b. Acesse a pasta ionic.

        c. Acesse Plataforma > iOS.

        d. Abra **Xcode** e, em seguida, construa o projeto. 

        >**Nota**: para publicar e construir, siga as etapas do tutorial [https://developer.apple.com/ios/submit/](https://developer.apple.com/ios/submit/).


### Visualize o aplicativo usando o simulador
{: #preview-the-app-using-the-simulator }

É possível visualizar o aplicativo desenvolvido conectando-se à simulação no canal selecionado.

* Para visualizar o aplicativo no iOS, faça download e instale o **XCode** a partir da Apple App Store.
* Para visualizar o aplicativo no Android, 
    * Instale o Android Studio e siga a instrução. [https://developer.android.com/studio/](https://developer.android.com/studio/)
    * Configure uma Máquina Virtual Android. Siga as instruções [aqui](https://developer.android.com/studio/releases/emulator).

