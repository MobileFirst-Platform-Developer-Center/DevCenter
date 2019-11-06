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
3. Inclua os serviços necessários (Bate-papo do Watson, Reconhecimento Visual do Watson, Notificações de Push, Conjunto de Dados, Atualização Dinâmica) em seu aplicativo.
4. Incluir ou modificar as Plataformas, se necessário. Consulte a seção [Configurações > Detalhes do aplicativo](../settings/).
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


### Visualizando o aplicativo
{: #preview-the-app }

É possível visualizar o aplicativo desenvolvido conectando-se à simulação no canal selecionado.

* Para visualizar o aplicativo no iOS, faça download e instale o **XCode** a partir da Apple App Store.
* Para visualizar o aplicativo no Android, 
    * Instale o Android Studio e siga a instrução. [https://developer.android.com/studio/](https://developer.android.com/studio/)
    * Configure uma Máquina Virtual Android. Siga as instruções [aqui](https://developer.android.com/studio/releases/emulator).

>**Nota**: Para visualizar rapidamente seu aplicativo, selecione a opção Visualizar aplicativo e será aberta uma nova janela com seu aplicativo em execução. É possível configurá-lo para diferentes modelos de plataforma e mudar a orientação também. As mudanças feitas no aplicativo serão refletidas em tempo real nesta janela de visualização.

>**Nota**: Arquivo > Exportar para código exportará o projeto para o modo de código. (o código do aplicativo será salvo em uma nova pasta, não afetando, portanto, o modo de design.) Depois de exportar para o modo de código, não é possível abrir o projeto exportado no modo de design.
