---
layout: tutorial
title: O que há de novo em correções temporárias
breadcrumb_title: iFixes temporárias
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
As correções temporárias fornecem correções e atualizações para corrigir problemas e manter o {{site.data.keys.product_full }} atualizado para novas liberações de sistemas operacionais de dispositivo móvel.

As correções temporárias são acumulativas. Ao fazer download da correção temporária mais recente da v8.0, você obtém todas as correções das correções temporárias anteriores.

Faça download e instale a correção temporária mais recente para obter todas as correções descritas nas seções a seguir. Se você instalar correções anteriores, pode ser que não obtenha todas as correções descritas aqui.

> Para obter uma lista de liberações de iFix do {{site.data.keys.product }} 8.0, [consulte estas postagens do blog]({{site.baseurl}}/blog/tag/iFix_8.0/).

Quando um número de APAR estiver listado, será possível confirmar se uma correção temporária tem esse recurso procurando o número do APAR no arquivo LEIA-ME da correção temporária.

### Licença
{: #licensing }
#### Licenciamento de PVU
{: #pvu-licensing }
Uma nova oferta, {{site.data.keys.product }} Extension V8.0.0, está disponível por meio de licenciamento por PVU (unidade de valor do processador). Para obter mais informações sobre licenciamento por PVU para o {{site.data.keys.product }} Extension, consulte [Licenciamento do {{site.data.keys.product_adj }}](../../licensing).

### Aplicativos para Web
{: #web-applications }
#### Registrando aplicativos da web a partir do {{site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
Agora é possível registrar aplicativos da web clientes no {{site.data.keys.mf_server }} usando o {{site.data.keys.mf_cli }} (mfpdev) como alternativa ao registro a partir do {{site.data.keys.mf_console }}. Para obter mais informações, consulte Registrando aplicativos da web a partir do {{site.data.keys.mf_cli }}.

### aplicativos Cordova
{: #cordova-applications }
#### Abrindo o IDE nativo para um projeto Cordova a partir do Eclipse com o plug-in do Studio
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
Com o plug-in do Studio instalado em seu Eclipse IDE, é possível abrir um projeto Cordova existente no Android Studio ou no Xcode a partir da interface do Eclipse para construir e executar o projeto.

#### Incluído o diretório *projectName* como opção quando você usa a ferramenta de assistência de migração
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
É possível especificar um nome para seu diretório de projeto Cordova ao migrar projetos com a ferramenta de assistência de migração. Se você não fornecer um nome, o nome padrão é *app_name-app_id-version*.

#### Melhorias de usabilidade da ferramenta de assistência de migração
{: #usability-improvements-to-the-migration-assistance-tool }
As mudanças a seguir foram feitas para melhorar a usabilidade da ferramenta de assistência de migração:

* A ferramenta de assistência de migração varre arquivos HTML e arquivos JavaScript.
* O relatório de varredura se abrirá em seu navegador padrão automaticamente após a varredura ser concluída.
* A sinalização *--out* é opcional. O diretório ativo será usado se não for especificada.
* Quando a sinalização *--out* é especificada e o diretório não existe, ele será criado.

### Adaptadores
{: #adapters }
#### Comandos `mfpdev push` e `pull` incluídos para configurações de adaptador Java e JavaScript
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
É possível usar o {{site.data.keys.mf_cli }} para enviar configurações de adaptadores Java e JavaScript por push para o {{site.data.keys.mf_server }} e puxar configurações de adaptadores do {{site.data.keys.mf_server }}.
