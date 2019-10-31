---
layout: tutorial
title: Incluindo um Formulário de login
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Incluindo um Formulário de login
{: #dab-login-form }

### Incluindo um Formulário de login em seu aplicativo no modo de Design
{: #add-login-form-design-mode }

Para incluir um Formulário de login em seu aplicativo, execute as seguintes etapas:

1. Faça as seguintes mudanças no Mobile Foundation Server
    * Implemente um adaptador de verificação de segurança que aceitaria o nome de usuário e a senha como entrada. É possível usar o adaptador de amostra [aqui](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80).
    * No Mobile Foundation Operation console, acesse a guia de segurança do aplicativo e no Escopo de aplicativo obrigatório, inclua a definição de segurança criada acima como elemento do escopo.
2. Faça a seguinte configuração em seu aplicativo usando o Builder.
    * Inclua o controle **Formulário de Login** em uma página na tela.
    * Na guia **Propriedades**, forneça o **Nome da verificação de segurança** e a página para navegar em **Com êxito no login**.
    * Execute o aplicativo.
