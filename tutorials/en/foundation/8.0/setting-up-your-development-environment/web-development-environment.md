---
layout: tutorial
title: Setting up the Web development environment
breadcrumb_title: Web environment
relevantTo: [web]
weight: 6
---
## Overview
Developing and testing web applications is as easy as previewing a local HTML file in your web browser of choice.  
Developers can use their IDE of choice, and a framework(s) that suits their needs.

However one thing may stand in the way of developing web applications. Web applications may encounter errors due to [Same Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) violation. Same Origin Policy is a restriction embosed on web browsers. For example, if an application is hosted on the domain **example.com**, it is not allowed for the same application to also access contect that is available on another server, or for that matter, from the MobileFirst Server.

[Web apps that are to use the MobileFirst Web SDK](../../adding-the-mfpf-sdk/web) should be handled in a supporting topology, for example by using a Reverse Proxy to internally redirect requests to the appropriate server while maintaining the same single origin.

During development, this restriction can be alleviated by:

- Serving the web application resources' from the same WebSphere Liberty profile application server that is used in the MobileFirst Developer Kit.
- Using Node.js as a proxy to redirect application requests to the MobileFirst Server.

<br/>
**Prerequisites:**  
The following requires either Apache Maven or Node.js installed on the developer's workstation.  
For instructions, refer to the [installation guide](../mobilefirst-development-environment/installation-guide/).

## Using WebSphere Liberty profile to serve the web application resources
In order to serve the web application's resources, these need to be stored in a Maven webapp (a **.war** file).

### Creating a Maven webapp archetype
1. From a **command-line** window, navigate to a location of your choosing.
2. Run the command:

    ```bash
    mvn archetype:generate -DgroupId=MyCompany -DartifactId=MyWebApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
    ```
    - Replace **MyCompany** and **MyWebApp** with your own values.
    - To enter the values one-by-one, remove the `-DinteractiveMode=false` flag.

### Building the Maven webapp with the web application's resources 
1. Place the web application's resources (such as the HTML, CSS, JavaScript and image files) inside the generated **[MyWebApp] → src → Main → webapp** folder.

    > From here on, consider the **webapp** folder as the your development location for the web application.

2. Run the command: `mvn clean install` to generate a .war file containing the application's web resources.  
   The generated .war file is available in the **[MyWebApp] → target** folder.

### Adding the Maven webapp to the application server
1. Edit the **server.xml file**, located in the [**MobileFirst Developer Kit] → mfp-server → user → servers → mfp** folder. Add the following entry:

    ```xml
    <application name="MyWebApp" location="path-to/MyWebApp.war" type="war"></application>
    ```
    - Replace **name** and **path-to/MyWebApp.war** with your own values.
    - The application server is automatically restarted after saving the changes to the **server.xml** file.  

### Testing the web application
Once you are ready to test your web application, visit the URL: **localhost:9080/MyWebApp**.
    - Replace **MyWebApp** with your own value.

## Using Node.js
ADD INSTRUCTIONS

## Next steps
To continue with MobileFirst development in Web applications, the MobileFirst Web SDK need to be added to the Web application.

* Learn how to add the [MobileFirst SDK to Web applications](../../adding-the-mfpf-sdk/web/).
* For applications development, refer to the [Using the MobileFirst Platform Foundation SDK](../../using-the-mfpf-sdk/) tutorials.
* For adapters develpment, refer to the [Adapters](../../adapters/) category.
