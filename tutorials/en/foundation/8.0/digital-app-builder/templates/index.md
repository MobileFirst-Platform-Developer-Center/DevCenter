---
layout: tutorial
title: Templates
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Using templates
{: #dab-templates }

You can use templates to quickly build your application. These are specific feature enabled app templates that will help you to quickly modify and develop the app.

By default Digital App Builder comes with two templates: Mod Resorts and Tabs

* **Mod Resorts**: This template provides a sample app with the use case of resorts app. It contains the login module, chat module, in-app feedback module to start with. You will must deploy the Login adapter and configure your own chatbot credentials.
* **Tabs**: This template provides tabbed mobile app interface, which provides Tabs at the bottom. This templates also include the login module.

### Creating a custom template
{: #create-custom-template }

The default templates are stored at the following location:
* For MacOS: `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Create a custom template by duplicating and editing one of the default templates such as Mod Resorts.
Customize the changes that are required in the copied template and zip the folder.
Create a folder for the custom template that you have created under `\ionic_templates\` and copy the .zip file into the new folder.
Edit the templates.json file in \ionic_templates\ folder and add a new entry to add your template.
For example, the new custom template can be added as shown below:

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
>**Note**
>* Make sure you increment the `version` number.
>* When there is an addition of a template from the release team, the update will replace the `\ionic_templates\` folder. Hence, make sure you take a backup of your custom template folder and reapply after updates.
