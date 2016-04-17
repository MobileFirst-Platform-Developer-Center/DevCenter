---
title: Using IntelliJ to Develop MobileFirst Java Adapters
date: 2016-03-31
tags:
- MobileFirst_Platform
- Java
- IntelliJ
version:
- 8.0
author:
  name: Lior Burg
---
In MobileFirst Platform Foundation 8.0 adapters are Maven projects. This means that you can easily create, develop, build, deploy and debug adapters, like any other Maven project, using supported IDEs such as Eclipse or IntelliJ.

This post demonstrates how to use **IntelliJ** to develop MobileFirst Java adapters. For instructions how to use Eclipse see the [Developing Adapters in Eclipse]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters) tutorial.

## Creating a New Java Adapter Maven Project
1. Go to File → New → Project and select the Maven tab.

    ![New Maven project screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/new-project.png)

2. Select or add the MobileFirst adapter Archetype.
    * If you [installed the archetypes locally]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/creating-adapters/#install-maven) and they are not appearing in the list of archetypes, tick the **Create from archetype** checkbox, click the **Add Archetype** button and provide the following details:
        * **GroupId**: `com.ibm.mfp`
        * **ArtifactId**: `adapter-maven-archetype-java`
        * **Version**: `8.0.0`

    ![Add archetype screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/add-archetype.png)

3. Make sure the `adapter-maven-archetype-java` is marked and click **Next**.

4. Specify the required **GroupId**, **ArtifactId** and **Version** and click **Next**.

    ![Required parameters screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/project-parameters.png)

5. In the following page, click **Next**.

6. Provide project name and location and click **Finish**

    ![Name and location screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/select-project-name-and-location.png)

You are now ready to implement your Java adapter. To learn more about adapters visit the [Adapters Category]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters).

## Building and Deploying a Java Adapter Maven Project
To quickly build and deploy your adapter use the **Maven Projects** view to run commands.  
Go to View → Tool Windows → Maven Projects:

* Build - Click on **Lifecycle** and double click the **install** command.
* Deploy - Click on **Plugins** → **adapter** and double click the **adapter:deploy** command.

<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tip** You can also build and deploy the adapter using a single command:

1. Go to Run → Edit Configurations and click the **+** button to add new **Maven** configuration.
2. Provide a name, set the **Command line** value to `mvn install adapter:deploy` and click **OK**.

    ![Add run configuration screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/Build & Deploy command.png)

3. You can then find the configuration in the **Maven Projects** view under **Run Configurations**.

## Debugging a Java Adapter Maven Project
In order to debug adapter's Java code, follow this instructions:

1. Go to Run → Edit Configurations and click the **+** button to add new **Remote** configuration.
2. Provide a **Name**, set the **Port** value to "10777" and click **OK**.

    ![Add new remote screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/Remote screen.png)

3. Click on Run → Debug YOUR-REMOTE-NAME to enter *debug mode*. You can now debug the Java code normally as you would do in a standard Java application. You need to issue a request to the adapter to make the code run and hit any set breakpoints.
