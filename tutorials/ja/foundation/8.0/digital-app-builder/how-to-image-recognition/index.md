---
layout: tutorial
title: Adding Image Recognition to the App
weight: 10
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Watson Visual Recognition
{: #dab-watson-vr }

Image recognition capability is powered by Watson Visual recognition service on IBM Cloud. Create a Watson Visual Recognition instance on IBM Cloud. For more information, see [here](https://cloud.ibm.com/catalog/services/visual-recognition).

Once configured, you can now create a new Mobel and add classes to it. You can drag and drop images in to the Builder and then train your Model on those images. Once the training is complete, you can either download the CoreML model or use the Model in a AI control in your app.

To enable a Visual Recognition in your app, perform the following steps:

1. Click **Watson** and then click **Image Recognition**. This displays the **Work with Watson Visual Recognition** screen.

    ![Watson Visual Recognition](dab-watson-vr.png)

2. Click **Connect** to your Watson Visual Recognition instance.

    ![Watson Visual Recognition Instance](dab-watson-vr-instance.png)

3. Enter the **API key** details and specify the **URL** of your Watson Visual Recognition instance. 
4. Provide a **Name** to your Image Recognition instance in the app and click **Connect**. This displays the dashboard for your model.

    ![Watson VR new model](dab-watson-vr-new-model.png)

5. Click **Add new model** to create a new model. This will display **Create a new Model** popup.

    ![Watson VR model name](dab-watson-vr-model-name.png)

6. Enter the **Model name** and click **Create**. This will display the classes for that model and a **Negative** class.

    ![Watson VR Model Class](dab-watson-vr-model-class.png)

7. Click **Add new class**. This will display a popup to specify a name for the new class.

    ![Watson VR Model Class Name](dab-watson-vr-model-class-name.png)

8. Enter the **Class name** for the new class and click **Create**. This will display the workspace to add your images for training the model.

    ![Watson VR Model Class training](dab-watson-vr-model-class-train.png)

9. Add the images to the model either by drag and drop them into the workspace or use Browse to access the images.

10. You can go back to your workspace after adding the images and test by clicking **Test Model**.

    ![Watson VR Model Class testing](dab-watson-vr-model-class-train-test.png)

11. In the **Try your model** section, add an image and then result is displayed.

