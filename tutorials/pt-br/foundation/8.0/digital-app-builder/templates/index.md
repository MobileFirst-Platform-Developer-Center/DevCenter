---
layout: tutorial
title: Modelos
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Usando modelos
{: #dab-templates }

É possível usar modelos para construir rapidamente seu aplicativo. Esses são modelos de aplicativo ativados para recursos específicos que o ajudarão a modificar e desenvolver rapidamente o aplicativo.

Por padrão, o Digital App Builder vem com dois modelos: Recursos de mod e Guias

* **Recursos de mod**: Este modelo fornece um aplicativo de amostra com o caso de uso de aplicativo de recursos. Ele contém o módulo de login, o módulo de bate-papo, o modo de feedback no aplicativo com os quais iniciar. Você deverá implementar o adaptador de Login e configurar suas próprias credenciais de robô de bate-papo.
* **Guias**: Este modelo fornece uma interface de aplicativo móvel com guias, que fornece Guias na parte inferior. Este modelo também inclui o módulo de login.

### Criando um modelo customizado
{: #create-custom-template }

Os modelos padrão são armazenados no seguinte local:
* Para MacOS: `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Crie um modelo customizado duplicando e editando um dos modelos padrão, como Recursos de mod.
Customize as mudanças necessárias no modelo copiado e compacte a pasta como zip.
Crie uma pasta para o modelo customizado criado em `\ionic_templates\` e copie o arquivo .zip para a nova pasta.
Edite o arquivo templates.json na pasta \ionic_templates\ e inclua uma nova entrada para incluir seu modelo.
Por exemplo, o novo modelo customizado pode ser incluído conforme mostrado abaixo:

```json
{
    "version": 12,
    "templates": [
        {
            "name": "Mod Resorts",
            "icon": "modresorts/modresortslogo.png",
            "templateFile": "modresorts/modresorts.zip"
        },
        {
            "name": "Tabs",
            "icon": "tabs/tabs.png",
            "templateFile": "tabs/tabs.zip"
        }
       {
            "name": "MyCustomTemplate",
            "icon": "mytemplate/customtemplate.png",
            "templateFile": "mytemplate/customtemplate.zip"
        }
     ]
}
```
>**Nota
**
>* Certifique-se de incrementar o número de `version`.
>* Quando houver uma inclusão de um modelo da equipe de liberação, a atualização substituirá a pasta `\ionic_templates\`. Portanto, certifique-se de fazer um backup de sua pasta de modelo customizado e reaplicar após as atualizações.
