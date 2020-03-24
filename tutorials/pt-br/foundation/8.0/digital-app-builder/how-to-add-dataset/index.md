---
layout: tutorial
title: Incluindo um conjunto de dados
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Incluindo um conjunto de dados
{: #dab-login-form }

### Criando um novo conjunto de dados no modo de Design
{: #data-set-design-mode }

1. Na página de entrada do Digital App Builder, abra qualquer aplicativo existente ou crie um no modo de Design.
2. Clique em **Dados** no painel à esquerda.

    ![Dados](dab-list-menu.png)

3. Clique em **Incluir novo conjunto de dados**. Isso exibe a janela Incluir um conjunto de dados.

    ![Incluir novo conjunto de dados](dab-list-add-data-set.png)

4. Criar um conjunto de dados. É possível criar a partir de uma origem existente (padrão) ou criar uma origem de dados para um microsserviço usando um doc OpenAPI.
    * **Criar a partir da origem de dados existente** (padrão) - Isso irá preencher a lista suspensa com todas as Origens de dados (adaptadores) da instância do servidor Mobile Foundation configurada. 
    * **Criar origem de dados para um microsserviço usando o doc OpenAPI** - Essa opção permite criar uma Origem de Dados a partir de um arquivo do documento de especificação Open API (json/yml swagger) e um Conjunto de Dados a partir dele.

#### Criar um conjunto de dados a partir de uma Origem de Dados existente

1. Selecione a Origem de Dados para a qual você deseja criar o Conjunto de Dados.
2. Isso preencherá as entidades disponíveis na Origem de Dados. Selecione a entidade a ser criada.
3. Forneça um nome para o conjunto de dados e clique no botão **Incluir**. Isso incluirá o Conjunto de Dados e será possível ver os Atributos e Ações associados a esse conjunto de dados.

    ![Novo conjunto de dados com atributos](dab-list-dataset-attributes.png)

4. É possível Ocultar alguns dos atributos e Ações com base no que você deseja fazer com o conjunto de dados.
5. Também é possível editar os **Rótulos de exibição** para os atributos
6. Também é possível Testar qualquer uma das Ações GET fornecendo os atributos necessários e clicando em **Executar esta ação**, que faz parte da Ação. Lembre-se que, para que isso funcione, é necessário ter especificado o nome do cliente Confidencial e a senha na guia **Configurações**.

#### Criar uma origem de dados para um microsserviço usando um arquivo swagger

1. Selecione o arquivo **json/yml** para o qual você deseja criar uma origem de dados e clique em **Gerar**.
2. Isso gerará um Adaptador, que é um artefato de configuração no servidor MF que você pode reutilizar e implementá-lo para a instância do servidor Mobile Foundation.
3. Selecione a entidade para a qual você deseja definir a origem de dados.
4. Forneça um nome para o conjunto de dados e clique no botão **Incluir**.
5. Isso incluirá o Conjunto de Dados e será possível ver os Atributos e Ações associados a esse conjunto de dados.

Agora é possível ligar esse conjunto de dados a qualquer um dos controles de limite de dados.

#### Ligando o conjunto de dados em seu aplicativo

1. Em seu aplicativo no modo de design, acesse a página na qual você deseja a lista.
2. Clique em **Mostrar controles** para visualizar **LIMITE DE DADOS**.
3. Clique para expandir **LIMITE DE DADOS** e arraste e solte a **Lista** na tela.
4. Atualiza os **Valores** conforme necessário. 
5. Inclua o **Título da lista**.
6. Escolha o **Tipo de lista** no qual trabalhar.
7. Inclua conteúdo no item da lista.
8. Conecte-se a um conjunto de dados a ser usado. 

### Criando um novo conjunto de dados no modo de Código
{: #data-set-code-mode }

1. Na página de entrada do Digital App Builder, abra qualquer aplicativo existente ou crie um no modo de código.
2. Clique em **</>**  (**Mostrar fragmentos de código**).
3. Navegue para **IONIC** e inclua o fragmento de código necessário (Lista simples, Lista de cartões, Botão de cabeçalho) e modifique o código conforme necessário.


