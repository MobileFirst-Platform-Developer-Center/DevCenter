---
title: Using IntelliJ to Develop MobileFirst Java Adapters
date: 2016-02-29
pinned: true
tags:
- MobileFirst_Platform
- Java
- IntelliJ
author:
  name: Lior Burg
---
In MobileFirst Platform Foundation 8.0 adapters are basically Maven projects. This means that you can easily create, develop, build, deploy and debug adapters using supported IDE, such as Eclipse or IntelliJ, like any other Maven project.  
This post demonstrates how to use IntelliJ to develop MobileFirst Java adapters.

## Creating a New Adapter Maven Project
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

5. click **Next**.

6. Provide project name and location and click **Finish**

    ![Name and location screen]({{site.baseurl}}/assets/blog/2016-02-29-debugging-adapters-using-intellij/select-project-name-and-location.png)

You are now ready to implement your Java adapter.

## Building and deploying an adapter Maven project
To quickly build and deploy your adapter use the **Maven Projects** view to run commands.  
Go to View → Tool Windows → Maven Projects:

* Build - click on **Lifecycle** and double click the **install** command.
* Deploy - click on **Plugins** → **adapter** and double click the **adapter:deploy** command.

**** build and deploy ??
