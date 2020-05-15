---
layout: tutorial
title: Añadir un formulario de inicio de sesión 
weight: 9
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Añadir un formulario de inicio de sesión 
{: #dab-login-form }

### Añadir un formulario de inicio de sesión a la aplicación en modalidad de diseño
{: #add-login-form-design-mode }

Para añadir un formulario de inicio de sesión a la aplicación, realice los pasos siguientes:

1. Realice los siguientes cambios en Mobile Foundation Server
    * Despliegue un adaptador de comprobación de seguridad que tomará el nombre de usuario y la contraseña como entrada. Puede utilizar el adaptador de ejemplo de [aquí](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80).
    * En Mobile Foundation Operation Console, vaya al separador de seguridad de la aplicación y bajo Ámbito de aplicación obligatorio, añada la definición de seguridad creada anteriormente como elemento de ámbito.
2. Realice la configuración siguiente en la aplicación utilizando el constructor.
    * Añada el control **Formulario de inicio de sesión** a una página en el lienzo. 
    * En el separador **Propiedades**, proporcione el **Nombre de comprobación de seguridad** y la página a la que ir **Al iniciar sesión con éxito**.
    * Ejecute la aplicación. 
