---
layout: tutorial
title: Añadir un Chatbot
weight: 10
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Chatbot de Watson 
{: #dab-chatbot }

Los chatbots están basados en el servicio de Watson Assistant en IBM Cloud. Cree una instancia de Watson Assistant en IBM Cloud. Para obtener más información, consulte [aquí](https://cloud.ibm.com/catalog/services/watson-assistant-formerly-conversation).

Una vez configurado, puede crear un nuevo **Espacio de trabajo**. El espacio de trabajo es un conjunto de conversaciones que forman el chatbot. Después de crear un espacio de trabajo, inicie la creación de los diálogos. Proporcione un conjunto de preguntas para una intención y un conjunto de respuestas de dicha intención. Watson Assistant utiliza Natural Language Understand para interpretar la intención en base a las preguntas de ejemplo que ha proporcionado. Puede entonces intentar interpretar la pregunta que el usuario realiza en distintos estilos y correlacionarla con la intención. 

Para habilitar una chatbot en la aplicación, realice los pasos siguientes:

1. Pulse **Watson** y, a continuación, pulse **Chatbot**. Se visualizará la pantalla **Trabajar con Watson Assistant**. 

    ![Chatbot de Watson](dab-watson-chat.png)

2. Pulse **Conectar** a su instancia de Watson Assistance. 

    ![Instancia de chat de Watson](dab-watson-chat-instance.png)

3. Especifique los detalles de la **clave de API** y especifique el **URL** de su instancia de Watson Assistance.  
4. Proporcione un **Nombre** al chatbot y pulse **Conectar**. Visualizará el panel de control del servicio del **Nombre** dado. 

    ![Espacio de trabajo del chatbot de Watson](dab-watson-chat-workspace.png)

5. Añada un espacio de trabajo pulsando **Añadir un espacio de trabajo** que muestra la ventana emergente **Crear un modelo nuevo**. 

    ![Nuevo modelo de espacio de trabajo del chatbot de Watson](dab-watson-chat-new-model.png)

6. Especifique el **Nombre de espacio de trabajo** y la **Descripción del espacio de trabajo** y pulse **Crear**. Esto crea tres espacios de trabajo de **Conversación** (Bienvenido, No se ha encontrado ninguna coincidencia y Nueva conversación).

    ![Conversación predeterminada del chatbot de Watson](dab-watson-chat-conversations.png)

7. Pulse **Nueva conversación** para educar el nuevo modelo de chatbot. 

    ![Respuestas y preguntas del chatbot de Watson](dab-watson-chat-questions.png)

8. Añada preguntas y sus respuestas como un archivo csv o como preguntas y respuestas individuales. Por ejemplo, **Añadir una sentencia de usuario** para Si el usuario tiene la intención de preguntar, y a continuación **Añadir una respuesta de bot** para **Entonces, el bot debería responder con**. También puede subir preguntas y las respuestas para que responda el bot. 
9. Pulse **Guardar**.
10. Pulse el icono de Chatbot en la parte derecha del botón para probar el chatbot. 

    ![Realización de pruebas con el chatbot](dab-watson-chat-testing.png)
