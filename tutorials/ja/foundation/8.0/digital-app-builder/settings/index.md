---
layout: tutorial
title: Digital App Builder Settings
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Digital App Builder Settings
{: #dab-app-settings }

Settings helps you to manage the app settings and rectify any errors during the build process. Settings consists of **App details**, **Server**, **Plugins**, **Theme** and **Repair Project** tabs.

### App details
{: #app-details}

App details displays information about your app: **App Icon**, **Name**, **Location** where the files are stored, **Project/Bundle Id** provided at the time of creating the app, **Platforms** (channels) selected, **Service** enabled.

![Setting App details](dab-settings.png)

You can change the **App icon** by clicking the icon and uploading a new icon.

You can add/remove additional Platforms by checking/unchecking the checkbox near them.

Click **Save** to update the changes.

### Server
{: #server }

The Server info displays the **Server details** you are currently working on. You can edit the information by clicking the **Edit** link. You can add or modify the confidential client authorization.

![Settings server details](dab-settings-server.png)

The Server tab also displays **Recent servers**.

>**Note**: You can only able to delete a server added earlier at the time of creating an app using Digital App Builder and if not used by any of your app created by Digital App Builder.

You can also add new server by clicking **Connect new +** button and provide the details in the **Connect to a new server** popup and click **Connect**.

![Settings new server](dab-settings-new-server.png)

### **Plugins**
{: #plugins}

Plugins displays list of plugins available in the Digital App Builder. Following actions can be performed:

![Settings Plugins available](dab-settings-plugins.png)

* **Install new** - You can install new plugins by clicking this button. This displays the **New plugin** dialog. Enter the **Plugin name**, **Version** (optional), and if it is a **Local plugin**, enable the switch for the same and point to the location and click **Install**.

![Settings New Plugins](dab-settings-new-plugins.png)

* From the list of Plugins already installed, you can edit the version and reinstall the plugin or uninstall a plugin by selecting the link for the respective plugin.


### Theme
{: #dab-theme}

Customize the look and feel of your app by specifying the theme for your app (Dark or Light). 

### Repair project
{: #repair-project}

Repair project tab helps you to fix issues by clicking the respective options.

![Settings Repair](dab-settings-repair.png)

* **Rebuild dependencies** - If the project is unstable, you can try re-building dependencies.
* **Rebuild platforms** - If you see any platform related errors in console, try rebuilding the platforms. if you have made any changes to the channels or added additional channels, use this option.
* **Reset IBM Cloud credentials for Playground server** - You can reset the IBM Cloud Credentials used to login to the Playground Server. Resetting the Credentials cache will also clear out all your apps on the Playground server. **THIS OPERATION CANNOT BE REVERSED.**
