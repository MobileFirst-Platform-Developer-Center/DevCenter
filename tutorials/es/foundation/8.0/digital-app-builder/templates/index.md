---
layout: tutorial
title: Plantillas 
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Utilización de plantillas
{: #dab-templates }

Puede utilizar plantillas para crear de forma rápida su aplicación. Estas son plantillas de aplicaciones habilitadas para funciones específicas que le ayudarán a modificar y desarrollar rápidamente la aplicación. 

De forma predeterminada Digital App Builder incluye dos plantillas: Mod Resorts y Tabs

* **Mod Resorts**: Esta plantilla proporciona una aplicación de ejemplo con los casos de uso de la aplicación Resorts. Contiene el módulo de inicio de sesión, el módulo de comentarios de la aplicación interna para comenzar. Tendrá que desplegar el adaptador de inicio de sesión y configurar sus propias credenciales de chatbot. 
* **Tabs**: Esta plantilla proporciona una interfaz de aplicación móvil con pestañas que proporciona pestañas en la parte inferior. Estas plantillas también incluyen el módulo de inicio de sesión. 

### Creación de una plantilla predeterminada 
{: #create-custom-template }

Las plantillas predeterminadas se almacenan en la ubicación siguiente: 
* Para MacOS: `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Cree una plantilla personalizada duplicando y editando una de las plantillas predeterminadas, tal como Mod Resorts.
Personalice los cambios que requiera la plantilla copia y comprima con zip la carpeta.
Cree una carpeta para la plantilla predeterminada que ha creado bajo `\ionic_templates\` y copie el archivo .zip en una nueva carpeta.
Edite el archivo templates.json en la carpeta \ionic_templates\ y añada una nueva entrada para añadir su plantilla.
Por ejemplo, la nueva plantilla personalizada se puede añadir como se muestra a continuación: 

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
>**Nota**
>* Asegúrese de que incrementa el número de `version`.
>* Cuando se añade una plantilla del equipo del release, la actualización se realiza en la carpeta `\ionic_templates\`. Por lo tanto, asegúrese de que realiza una copia de seguridad de la carpeta de la plantilla personalizada y que la vuelve a aplicar después de las actualizaciones. 
