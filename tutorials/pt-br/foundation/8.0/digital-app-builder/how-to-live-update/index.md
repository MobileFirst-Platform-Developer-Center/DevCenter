---
layout: tutorial
title: Alternância de recurso usando a Atualização Dinâmica
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Alternância de recurso usando a Atualização Dinâmica
{: #dab-feature-toggle-live-update }

Use a Atualização Dinâmica para tornar configuráveis os diferentes aspectos de seu aplicativo, para ativar ou desativar recursos remotamente. Controle também dinamicamente as propriedades do aplicativo, mudando os valores de variáveis diretamente do MobileFirst Operations Console.

* **Recurso** é um valor binário em on/off que é usado para ligar ou desligar um recurso do aplicativo.
* **Propriedades** são pares nome-valor que podem ser usados para controlar o comportamento do aplicativo.

>**Nota**: A Atualização Dinâmica estará disponível somente quando o aplicativo estiver pronto.

### Ativando o Live Update

É possível ativar o recurso Live Update pelo método a seguir:

1. Selecione **Engajamento**. Isso exibirá a lista de serviços disponíveis.

    ![Atualização Dinâmica de engajamento](dab-live-update.png)

2. Selecione **Atualização Dinâmica** e clique em **Ativar**. Isso irá configurar o Live Update no servidor Mobile Foundation. Ao ativar o Live Update com sucesso, um pop-up será exibido.

    ![Ativar Atualização Dinâmica](dab-live-update-enable.png)

3. Clique em **+ Novo recurso** para definir um novo recurso no servidor Mobile Foundation. Isso exibe a tela a seguir.

    ![nova propriedade](dab-live-update-feature-new.png)

4. Insira o **ID do recurso** e o **Nome do recurso** e configure a **Visibilidade** padrão.

    * **ID do recurso** - Um identificador exclusivo para seu recurso.
    * **Nome do recurso** - Dê um nome para descrever seu recurso

5. Clique em **Criar**.

6. De forma semelhante, defina uma propriedade de Atualização Dinâmica fornecendo os seguintes detalhes:

    * **ID da propriedade**
    * **Nome da Propriedade
**
    * **Valor da Propriedade
**

### Trabalhando com o Live Update no modo de design

No modo de design, após ativar a opção Live Update, será possível modificar o **Valor de texto**, a **Cor de texto** ou a **Cor do plano de fundo** para o controle selecionado e atualizar as mudanças em tempo real, definindo uma nova propriedade ou selecionando e editando uma propriedade existente. É possível modificar o valor da propriedade na tabela do Updates Live que lista a lista de recursos e propriedades associadas a eles.

#### Associar um controle a um recurso

Para associar um controle a um recurso:

1. Selecione um controle clicando nele. 
2. Defina um novo recurso clicando no sinal **+** para a opção **Selecionar um recurso** na seção **Controlar/Ocultar controles**. 
3. Para o novo recurso, forneça valores para **ID do recurso** e **Nome do recurso** e ative ou desative a visibilidade usando o comutador **on/off** de alternância de recurso.

#### Modificar a propriedade de um controle

Para modificar a propriedade de um controle:

Selecione um controle e digite **${property_name}** ou selecione a propriedade a ser associada na lista ou crie uma nova propriedade selecionando **Incluir nova propriedade** e forneça valores para **ID de propriedade**, **Nome da propriedade**, **Valor da propriedade**.
 
É possível usar os controles e propriedades a seguir com o Live Update:

* **Botão** - Valor do texto, Cor do texto, Cor do plano de fundo
* **Título** - Valor do texto, Cor do texto
* **Rótulo** - Valor do Texto, Color do Texto

### Incluindo a Atualização Dinâmica no modo de Código

Para incluir a Atualização Dinâmica em seu aplicativo:

**Método
1**

1. Abra o aplicativo no modo de código
2. Navegue para `projectname/ionic/src/app/app.component.ts`

    ![Incluindo o Live Update no modo de código - método 1](dab-live-update-new-feature-code.png)

3. Acesse para inicializar o método de atualização dinâmica.
4. Edite o código para mostrar/ocultar um controle e propriedade para configurar a propriedade do controle.

**Método 2**

1. Abra o aplicativo no modo de código.
2. Acesse e clique no fragmento de código **</>**.
3. Em **Live Update**, arraste e solte o fragmento de código **Recurso do Live Update** ou **Propriedade do Live Update**.

    ![Incluindo o Live Update no modo de código - método 2](dab-live-update-new-feature-code-snippet.png)

4. Edite o código para mostrar/ocultar um controle e propriedade para configurar a propriedade do controle.
