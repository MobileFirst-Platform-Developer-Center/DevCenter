---
title: IBM MobileFirst Studio 8.0 Plug-in for Eclipse Now Available
date: 2016-06-17
tags:
- MobileFirst_Platform
- Cordova
- MobileFirst_Studio
- Eclipse
version:
- 8.0
author:
  name: Edna Morales
---

The IBM MobileFirst Studio 8.0 Plug-in for Eclipse is now available in the Eclipse Marketplace!  
Use this plug-in to manage your Cordova projects in the Eclipse development environment.

### Installing and Using IBM MobileFirst Studio 8.0 and THyM plug-ins
To install, you must be running Eclipse Mars or later. In Eclipse go to **Help -> Eclipse Marketplace** and search for IBM MobileFirst Studio and install the 8.0 version. You also need to install Eclipse Thym 2.0.0 through the Eclipse Marketplace.

* Thym will allow you to import, create, and manage your Cordova projects, platforms and plugins. 
* The MobileFirst Studio plug-in exposes the various MobileFirst commands in Eclipse IDE. Specifically, it provides the following commands: Open Server Console, Preview App, Register App, Encrypt App, Pull App, Push App, Update App.

**Prerequisites:**  
Make sure you have the MobileFirst CLI installed, as the Eclipse plug-in is dependent on it to run its commands.  
You also need to have a MobileFirst Server running, either locally in the developer machine or on Bluemix.

### Creating a New Cordova Project in Eclipse
1. Click **File -> New -> Other...**
2. Select **Hybrid Mobile (Cordova) Application Project** in the **Mobile** directory and click **Next**
3. Name the project and click **Next**.
4. Add the desired platform for your project and click **Finish**

### Importing an Existing Cordova Project
1. Click **File -> Import...**
2. Select **Import Cordova Project** in the **Mobile** directory and click **Next**
3. Click **Browse...** and select the root directory of the existing Cordova project
4. Ensure the project is checked in the "Projects:" section and click **Finish**

### Adding the MobileFirst Foundation Cordova SDK to your Cordova Project
1. In the Project Explorer expand your cordova project, right-click the **plugins** directory, and select **Install Cordova Plug-in**
2. In the Registry tab of the dialog box, search **mfp** and select **cordova-plugin-mfp**
3. Click **Finish**

### Using the MobileFirst Commands
To access MobileFirst Foundation's shortcuts, right-click the root project directory and navigate to **IBM MobileFirst Foundation**. Here you will be able to select the available MobileFirst commands for your project:

| Menu option         | Action                                                                                                                                       | MobileFirst command-line interface equivalent |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| Open Server Console | When the server definition exists, opens the console so you can view the actions of the specified server.                                    | mfpdev server console                         |
| Preview App         | Opens the app in the browser preview mode.                                                                                                   | Opens the app in the browser preview mode.    |
| Register App        | Registers the app with the server that is specified in your server definitions.                                                              | mfpdev app register                           |
| Encrypt App         | Runs the web resource encryption tool on your app.                                                                                           | mfpdev app webencrypt                         |
| Pull App            | Retrieves the existing app configuration from the server that is specified in the server definition.                                         | mfpdev app pull                               |
| Push App            | Sends the app configuration of your current app to the server that is specified in the build definition so you can reuse it for another app. | mfpdev app push                               |
| Updated App         | Packages the contents of the www folder in a .zip file, and replaces the version on the server with the package.                             | mfpdev app webupdate                          |

### Detailed instructions
Learn more in the [Using the MobileFirst CLI in Eclipse]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/) tutorial.

### Demo Video

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/yRe2AprnUeg"></iframe>
    </div>
</div>