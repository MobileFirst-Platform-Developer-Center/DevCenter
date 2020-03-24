---
layout: tutorial
title: Incluindo Reconhecimento de imagem no aplicativo
weight: 11
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Watson Visual Recognition
{: #dab-watson-vr }

O recurso de reconhecimento de imagem é desenvolvido com o serviço do Watson Visual Recognition no IBM Cloud. Crie uma instância do Watson Visual Recognition no IBM Cloud. Para obter informações adicionais, consulte [aqui](https://cloud.ibm.com/catalog/services/visual-recognition).

Depois de configurado, agora é possível criar um novo Modelo e incluir classes nele. É possível arrastar e soltar imagens no Builder e, em seguida, treinar seu Modelo nessas imagens. Quando o treinamento estiver concluído, será possível fazer download do modelo CoreML ou usar o Modelo em um controle de IA em seu aplicativo.

Para ativar um Reconhecimento Visual em seu aplicativo, execute as etapas a seguir:

1. Clique em **Watson** e, em seguida, clique em **Reconhecimento de imagem**. Isso exibe a tela **Trabalhar com o Watson Visual Recognition**.

    ![Watson Visual Recognition](dab-watson-vr.png)

2. Clique em **Conectar** em sua instância do Watson Visual Recognition.

    ![Instância do Watson Visual Recognition](dab-watson-vr-instance.png)

3. Insira os detalhes da **Chave de API** e especifique a **URL** de sua instância do Watson Visual Recognition. 
4. Forneça um **Nome** para a instância de Reconhecimento de Imagem no aplicativo e clique em **Conectar**. Isso exibe o painel para seu modelo.

    ![Novo modelo do Watson VR](dab-watson-vr-new-model.png)

5. Clique em **Incluir novo modelo** para criar um novo modelo. Isso exibirá o pop-up **Criar um novo modelo**.

    ![Nome do modelo do Watson VR](dab-watson-vr-model-name.png)

6. Insira o **Nome do modelo** e clique em **Criar**. Isso exibirá as classes para esse modelo e uma classe **Negativa**.

    ![Classe de modelo do Watson VR](dab-watson-vr-model-class.png)

7. Clique em **Incluir nova classe**. Isso exibirá um pop-up para especificar um nome para a nova classe.

    ![Nome da classe de modelo do Watson VR](dab-watson-vr-model-class-name.png)

8. Insira o **Nome da Classe**para a nova classe e clique em **Criar**. Isso exibirá a área de trabalho para incluir suas imagens para treinamento do modelo.

    ![Treinamento de classe de modelo do Watson VR](dab-watson-vr-model-class-train.png)

9. Inclua as imagens no modelo, arraste e solte-as na área de trabalho ou use Procurar para acessar as imagens.

10. É possível voltar para sua área de trabalho após a inclusão das imagens e testar clicando em **Testar modelo**.

    ![Teste da classe de modelo do Watson VR](dab-watson-vr-model-class-train-test.png)

11. Na seção **Testar seu modelo**, inclua uma imagem e, em seguida, o resultado é exibido.

