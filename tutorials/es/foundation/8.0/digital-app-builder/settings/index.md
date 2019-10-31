---
layout: tutorial
title: Valores de Digital App Builder 
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Valores de Digital App Builder 
{: #dab-app-settings }

Los parámetros sirven para gestionar la aplicación y rectificar los errores que se produzcan durante el proceso su creación. Los valores están formados por los separadores **Detalles de aplicación**, **Servidor**, **Plugins**, **Tema** y **Reparar proyecto**. 

### Detalles de la aplicación 
{: #app-details}

Los detalles de la aplicación muestran información sobre la aplicación: **Icono de aplicación**, **Nombre**, **Ubicación** donde se almacenan los archivos, **ID de proyecto/paquete** proporcionado al crear la aplicación, **Plataformas** (canales) seleccionados, **Servicio** habilitado. 

![Detalles de valores de aplicación](dab-settings.png)

Puede cambiar el **Icono de aplicación** pulsando el icono y subiendo un icono nuevo.

Puede añadir/eliminar plataformas adicionales seleccionado/deseleccionando el recuadro de selección junto a cada una de las mismas. 

Pulse **Guardar** para actualizar los cambios.

### Servidor 
{: #server }

La información del servidor muestra los **Detalles del servidor** en los que está trabajando actualmente. Puede editar la información pulsando el enlace **Editar**. Puede añadir o modificar la autorización de cliente confidencial.

![Detalles de los valores de servidor](dab-settings-server.png)

El separador Servidor también muestra **Servidores recientes**.

>**Nota**: solo puede suprimir un servidor añadido antes de crear una app mediante Digital App Builder si no lo utiliza ninguna de las apps creadas por Digital App Builder.

También puede añadir un nuevo servidor pulsando el botón **Conectar nuevo +** y proporcionando los detalles en la ventana emergente **Conectar a un nuevo servidor** y pulsando **Conectar**. 

![Valores de nuevo servidor](dab-settings-new-server.png)

### **Plugins**
{: #plugins}

Plugins muestra la lista de plugins disponibles en Digital App Builder. Se pueden realizar las siguientes acciones:

![Valores de plugins disponibles](dab-settings-plugins.png)

* **Instalar nuevo** - Instale nuevos plugins pulsando este botón. Esto visualiza el diálogo **Nuevo plugin**. Especifique **Nombre de plugin**, **Versión** (opcional), y si se trata de un **plugin local**, habilite el conmutador para el mismo y apunte a la ubicación y pulse **Instalar**. 

![Valores de nuevos plugins](dab-settings-new-plugins.png)

* Desde la lista de plugins ya instalados, puede editar la versión y volver a instalar el plugin o desinstalar un plugin seleccionando el enlace para el respectivo plugin. 


### Tema
{: #dab-theme}

Personalice el aspecto de la aplicación especificando el tema para su aplicación (Oscuro o Ligero). 

### Reparar proyecto 
{: #repair-project}

El separador Reparar proyecto ayuda a solucionar problemas pulsando las opciones respectivas. 

![Valores de reparar](dab-settings-repair.png)

* **Reconstruir dependencias** - Si el proyecto es inestable, puede intentar reconstruir las dependencias. 
* **Reconstruir plataformas** - Si ve en la consola errores relacionados con la plataforma, intente reconstruir las plataformas. Si ha realizado algún cambio en los canales o ha añadido canales adicionales, utilice esta opción. 
* **Restablecer las credenciales de IBM Cloud para el servidor de Playground** - Puede restablecer las credenciales de IBM Cloud utilizas para iniciar una sesión en el servidor Playground. Si restablece el caché de credenciales, también borrará todas sus aplicaciones en el servidor de Playground. **ESTA OPERACIÓN NO SE PUEDE REVERTIR.**
