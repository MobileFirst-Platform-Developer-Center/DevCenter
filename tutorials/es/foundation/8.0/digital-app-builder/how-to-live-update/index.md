---
layout: tutorial
title: Conmutar características utilizando Live Update
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Conmutar características utilizando Live Update
{: #dab-feature-toggle-live-update }

Utilice Live Update para que los diferentes aspectos de su aplicación sean configurables, para activar o desactivar características de forma remota. Asimismo, controle dinámicamente las propiedades de la aplicación cambiando los valores de las variables directamente desde
MobileFirst Operations Console. 

La característica es un valor binario on/off que se utiliza para activar o desactivar una característica de aplicación. 

Las propiedades son los pares de nombre y valor que se pueden utilizar para controlar el comportamiento de la aplicación. 

>**Nota**: Live Update solo estará disponible cuando la aplicación esté lista. 


### Añadir Live Update en modalidad de diseño 

Para añadir Live Update a su aplicación: 

1. Seleccione **Compromiso**. Esto mostrará la lista de servicios disponibles. 

    ![Compromiso Live Update](dab-live-update.png)

2. Seleccione **Live Update** y pulse **Habilitar**. Esto configurará Live Update en el servidor de Mobile Foundation. Una vez se ha configurado correctamente Live Update, se muestra una ventana emergente. 

    ![Habilitar Live Update](dab-live-update-enable.png)

3. Pulse **+ Nueva característica** para definir una nueva característica en el servidor de Mobile Foundation. Esto muestra la pantalla siguiente. 

    ![nueva característica](dab-live-update-new-feature.png)

4. Escriba el **ID de característica** y el **Nombre de característica**, y establece la **Visibilidad** predeterminada.

    * **ID de característica** - Un identificador único para su característica. 
    * **Nombre de característica** - Asigne un nombre para describir su característica  

    ![nueva propiedad](dab-live-update-feature-new.png)

5. Pulse **Crear**.

6. Del mismo modo, defina la propiedad de Update proporcionando los detalles siguientes: 

    * **ID de propiedad**
    * **Nombre de propiedad**
    * **Valor de propiedad**

### Añadir Live Update en modalidad de código 

Para añadir Live Update a su aplicación: 

**Método 1**

1. Abra la aplicación en modalidad de código 
2. Vaya a `projectname/ionic/src/app/app.component.ts`

    ![método 1 de nueva propiedad](dab-live-update-new-feature-code.png)

3. Vaya a inicializar método live update. 
4. Edite el código para mostrar/ocultar un control y propiedad para establecer la propiedad del control. 

**Método 2**

1. Abra la aplicación en modalidad de código. 
2. Vaya al fragmento de código y púlselo **</>**.
3. bajo Live Update > Configuración de Live Update. 

    ![método 2 de nueva propiedad](dab-live-update-new-feature-code-snippet.png)

4. Arrastre y suelte el fragmento de código **Configuración de LiveUpdate**.
5. Edite el código para mostrar/ocultar un control y propiedad para establecer la propiedad del control. 

