---
layout: tutorial
title: Configurações do Digital App Builder
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Configurações do Digital App Builder
{: #dab-app-settings }

As configurações ajudam você a gerenciar as configurações do aplicativo e a retificar quaisquer erros durante o processo de construção. As configurações consistem nas guias **Detalhes do aplicativo**, **Servidor**, **Plug-ins**, **Tema** e **Projeto de reparo**.

### Detalhes do app
{: #app-details}

Os detalhes do aplicativo exibem informações sobre seu aplicativo: **Ícone do aplicativo**, **Nome**, **Local** em que os arquivos são armazenados, **ID do projeto/pacote configurável** fornecido no momento da criação do aplicativo, **Plataformas** (canais) selecionados, **Serviço** ativado.

![Configuração dos detalhes do aplicativo](dab-settings.png)

É possível mudar o **ícone do aplicativo** clicando no ícone e fazendo upload de um novo ícone.

É possível incluir/remover Plataformas adicionais marcando/desmarcando a caixa de seleção perto delas.

Clique em **Salvar** para atualizar as alterações.

### Servidor
{: #server }

As informações do Servidor exibem os **Detalhes do servidor** no qual você está trabalhando atualmente. É possível editar as informações clicando no link **Editar**. É possível incluir ou modificar a autorização do cliente confidencial.

![Configurações de detalhes do servidor](dab-settings-server.png)

A guia Servidor também exibe **Servidores recentes**.

>**Nota**: É possível excluir um servidor incluído anteriormente apenas no momento da criação de um aplicativo usando o Digital App Builder e se não for usado por nenhum de seus aplicativos criados pelo Digital App Builder.

Também é possível incluir um novo servidor clicando no botão **Conectar novo +**, fornecendo os detalhes no pop-up **Conectar-se a um novo servidor** e clicando em **Conectar**.

![Configurações do novo servidor](dab-settings-new-server.png)

### **Plug-ins**
{: #plugins}

Plug-ins exibe a lista de plug-ins disponíveis no Digital App Builder. As ações a seguir podem ser executadas:

![Configurações de plug-ins disponíveis](dab-settings-plugins.png)

* **Instalar novo** - É possível instalar novos plug-ins clicando nesse botão. Isso exibe o diálogo **Novo plug-in**. Insira o **Nome do plug-in**, a **Versão** (opcional) e, se for um **Plug-in local**, ative o comutador para ele, indique o local e clique em **Instalar**.

![Configurações de novos plug-ins](dab-settings-new-plugins.png)

* Na lista de Plug-ins já instalados, é possível editar a versão e reinstalar o plug-in ou desinstalar um plug-in selecionando o link para o respectivo plug-in.


### Tema
{: #dab-theme}

Customize a aparência de seu aplicativo especificando o tema para o aplicativo (Escuro ou claro). 

### Reparar projeto
{: #repair-project}

A guia Reparar projeto ajuda você a corrigir problemas clicando nas respectivas opções.

![Reparo de configurações](dab-settings-repair.png)

* **Reconstruir dependências** - Se o projeto estiver instável, é possível tentar recriar dependências.
* **Reconstruir plataformas** - Se você vir quaisquer erros relacionados à plataforma no console, tente reconstruir as plataformas. Se você tiver feito qualquer mudança nos canais ou incluído canais adicionais, use essa opção.
* **Reconfigurar as credenciais do IBM Cloud para o servidor Playground** - É possível reconfigurar as Credenciais do IBM Cloud usadas para efetuar login no Playground Server. A reconfiguração do cache de Credenciais também limpa todos os seus apps no servidor Playground. **ESTA OPERAÇÃO NÃO PODE SER REVERTIDA.**
