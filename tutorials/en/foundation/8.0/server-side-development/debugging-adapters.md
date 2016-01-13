---
layout: tutorial
title: Debugging Adapters
relevantTo: [ios,android,windowsphone8,windows8,cordova]
weight: 9
---
## Overview
You can debug Java code implemented for use in **Java** or **JavaScript adapters** via IDEs such as Eclipse, IntelliJ and alike.  
This tutorial demonstrates debugging a Java adapter using the Eclipse IDE.

### Debugging adapters in Eclipse
Before an adapter's Java code can be debugged, Eclipse needs to be configured as follows:

1. **Maven integration** - Starting Eclipse Kepler (v4.3), Maven support is built-in in Eclipse.  
If your Eclipse instance does not support Maven, [follow the m2e instructions](http://www.eclipse.org/m2e/) to add Maven support.

2. Once Maven is available in Eclipse, import the adapter Maven project:

    ![Image showing how to import an adapter Maven project to Eclipse](import-adapter-maven-project.png)

3. Provide debugging parameters:
    - Click **Run → Debug Configurations**.
    - Double-click on **Remote Java application**.
    - Provide a **Name** for this configuration.
    - Set the **Port** value to "10777".
    - Click **Browse** and select the Maven project.
    - Click **Debug**.

    ![Image showing how to set MobileFirst Server debug parameters](setting-debug-parameters.png)

4. Click on **Window → Show View → Debug** to enter *debug mode*. You can now debug the Java code normally as you would do a standard Java application. You need to issue a request to the adapter to make its code run and hit any set breakpoints. This can be accomplished by following the instructions on how to call an adapter resource in the [Testing adapters section](../creating-adapters/#testing-adapters).

    ![Image showing a being-debugged adapter](debugging.png)
