---
layout: tutorial
title: Usando o MobileFirst Server para Eclipse
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Visão Geral
{: #overview }
O {{ site.data.keys.mf_server }} pode ser integrado no Eclipse IDE. Isso pode ajudar a criar uma experiência de desenvolvimento unificada.

* Também é possível expor a funcionalidade da CLI no Eclipse, consulte o tutorial [Usando o {{ site.data.keys.mf_server }} no Eclipse](../../../../application-development/using-mobilefirst-cli-in-eclipse).
* Além disso, é possível desenvolver adaptadores no Eclipse, consulte o tutorial [Desenvolvendo adaptadores no Eclipse](../../../../adapters/developing-adapters).

### Incluindo o servidor para Eclipse
{: #adding-the-server-to-eclipse }
1. Na visualização **Servidores** no Eclipse, selecione **Novo → Servidor**.
2. Se uma opção de pasta IBM não existir, clique em "Fazer download de adaptadores para servidor adicionais".
3. Selecione **WebSphere Application Server Liberty Tools** e siga as instruções na tela.
4. Na visualização **Servidores** no Eclipse, selecione **Novo → Servidor**.
5. Selecione **IBM → WebSphere Application Server Liberty**.
6. Forneça um **nome** de servidor e um **nome de host** e clique em **Avançar**.
7. Forneça o caminho para o diretório-raiz do servidor e selecione uma versão de JRE para usar. Ao usar o {{ site.data.keys.mf_dev_kit }}, o diretório-raiz é a pasta **[installation directory]/mfp-server**.
8. Clique em **Avançar** e, em seguida, clique em **Concluir**.

Agora é possível iniciar e parar o {{ site.data.keys.mf_server }} na visualização "servidores" do Eclipse IDE.
