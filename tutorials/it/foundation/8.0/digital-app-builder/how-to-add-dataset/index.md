---
layout: tutorial
title: Adding a Data Set
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Adding a Data set
{: #dab-login-form }

### Creating a new data set in Design mode
{: #data-set-design-mode }

1. From the landing page of the Digital App Builder, open any existing App or create one in Design mode.
2. Click **Data** on the left hand panel.

    ![Data](dab-list-menu.png)

3. Click **Add new data set**. This displays the Add a data set window.

    ![Add new data set](dab-list-add-data-set.png)

4. Create a data set. You can either create from an existing source (default) or create a data source for a microservice using an OpenAPI doc.
    * **Create from existing data source** (default) - This will populate the dropdown with all the Data sources (adapters) from the configured Mobile Foundation server instance. 
    * **Create Data source for a microservice using OpenAPI doc** - This option lets you create a Data Source from an Open API specification document (Swagger json/yml) file, and a Data Set from it.

#### Create a Data set from an existing Data Source

1. Select the Datasource for which you want to create the Dataset.
2. This will populate the available entities in the Data Source. Select the entity to be created.
3. Give a name to the dataset and click the **Add** button. This will add the dataset and you will be able to see the Attributes and Actions associated with that dataset.

    ![New dataset with attributes](dab-list-dataset-attributes.png)

4. You can Hide some of the attributes and Actions based on what you want to do with the data set.
5. You can also edit the **Display Labels** for the attributes
6. You can also Test any of the GET Actions by providing the required attributes and clicking on the **Run this action** which is part of the Action. Remember for this to work you should have specified the Confidential client name and password in the **Settings** tab.

#### Create a Data source for a Microservice using a swagger file

1. Select the **json/yml** file for which you want to create a datasource for and click **Generate**.
2. This will generate an Adapter, which is a configuration artifact on the MF server that you can re-use and deploy it to the Mobile Foundation server instance.
3. Select the entity for which you want to define the data source for.
4. Give a name to the dataset and click on **Add** button.
5. This will add the Dataset and you will be able to see the Attributes and Actions associated with that dataset.

You can now bind this data set to any of the data bound controls.

#### Binding the data set in your app

1. From your app in design mode, go to the page you want to add the list.
2. Click the **Show Controls** to view **DATABOUND**.
3. Click to expand **DATABOUND** and drag-and-drop the **List** to the canvas.
4. Updates the **Values** as required. 
5. Add the **List Title**.
6. Choose the **List Type** to work on.
7. Add content to the list item.
8. Connect to a dataset to use. 

### Creating a new data set in Code mode
{: #data-set-code-mode }

1. From the landing page of the Digital App Builder, open any existing App or create one in code mode.
2. Click **</>**  (**Show Code Snippets**).
3. Navigate to **IONIC** and add the required Code Snippet (Simple List, Card List, Header Button) and modify the code as required.


