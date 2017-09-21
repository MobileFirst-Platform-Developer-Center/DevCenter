---
layout: tutorial
title: Administración de aplicaciones
weight: 11
show_children: true
---
## Visión general
{: #overview }
{{ site.data.keys.product_full }} proporciona varias formas para administrar aplicaciones de {{ site.data.keys.product_adj }} que están en desarrollo o en producción.
{{ site.data.keys.mf_console }} es la herramienta principal con la que se supervisan todas las aplicaciones desplegadas de {{ site.data.keys.product_adj }} desde una consola centralizada y basada en web.


Las operaciones principales que puede realizar con {{ site.data.keys.mf_console }} son:

* Registrar y configurar aplicaciones móviles para {{ site.data.keys.mf_server }}.
* Desplegar y configurar adaptadores para {{ site.data.keys.mf_server }}.
* Gestionar versiones de aplicaciones para desplegar las nuevas versiones o inhabilitar las versiones antiguas de manera remota.
* Gestionar dispositivos móviles y usuarios para administrar el acceso a un dispositivo específico o el acceso de un usuario específico a una aplicación.
* Visualizar mensajes de notificación durante el inicio de la aplicación.
* Supervisar los servicios de notificación push.
* Recopilar registros del lado del cliente para aplicaciones específicas instaladas en un dispositivo específico.

## Roles de administración
{: #administration-roles }
No todos los tipos de usuarios de administración pueden realizar las operaciones de administración.
{{ site.data.keys.mf_console }} y todas las herramientas de administración tienen cuatro roles diferentes para definir la administración de las aplicaciones de {{ site.data.keys.product_adj }}.
Las siguientes

Roles de administración de {{ site.data.keys.product_adj }} definidos:


**Supervisor**  
En este rol, el usuario puede supervisar los proyectos desplegados de {{ site.data.keys.product_adj }} y los artefactos desplegados.
Este rol es de sólo lectura.

**Operador**  
El operador puede realizar todas las operaciones de gestión de aplicaciones móviles pero no puede añadir ni eliminar las versiones de las aplicaciones o adaptadores.


**Desplegador**  
En este rol, el usuario puede realizar las mismas operaciones que el operador pero también puede desplegar aplicaciones y adaptadores.


**Administrador**  
En este rol, el usuario puede realizar todas las operaciones de administración de las aplicaciones.

> Para obtener más información sobre los roles de administración de {{ site.data.keys.product_adj }}, consulte [Configuración de la autenticación de usuarios para la administración de {{ site.data.keys.mf_server }}](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
## Herramientas de administración 
{: #administration-tools }
{{ site.data.keys.mf_console }} no es la única manera que hay para administrar aplicaciones de {{ site.data.keys.product_adj }}.
{{ site.data.keys.product }} también proporciona otras herramientas para incorporar las operaciones de administración en el proceso de creación y despliegue.


Está disponible un conjunto de servicios REST para realizar operaciones de administración.
Para obtener la documentación de referencia de API de estos servicios, consulte [API REST REST API para el servicio de administración de {{ site.data.keys.mf_server }}](../api/rest/administration-service/).

Con este conjunto de servicios REST, puede realizar las mismas operaciones que hace en {{ site.data.keys.mf_console }}.
Puede gestionar aplicaciones, adaptadores, y, por ejemplo, subir una nueva versión de una aplicación o inhabilitar una versión antigua.


Las aplicaciones de {{ site.data.keys.product_adj }} también pueden administrarse utilizando tareas Ant o la herramienta de línea de mandatos **mfpadm**.
Consulte [Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de Ant](using-ant) o [Administración de aplicaciones de {{ site.data.keys.product_adj }} a través de la línea de mandatos](using-cli).

De forma parecida la consola basada en la web, los servicios REST, las tareas ANT y las herramientas de línea de mandatos están protegidas siendo necesario el utilizar sus credenciales de administrador.


### Seleccione un tema:

{: #select-a-topic }
