---
layout: tutorial
title: Creating Java and JavaScript Adapters
relevantTo: [ios,android,windowsphone8,windows8,cordova]
show_children: true
---

### Overview
This tutorial demonstrates how to create either Java or JavaScript adapter using the Maven Archetype "adapter-maven-archetype".

The "adapter-maven-archetype" is based on the [Maven archetype toolkit](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html) in order to create the adapter as a Maven project.

**Prerequisite:** <span style="color:red"> Make sure that you read the --- tutorial first.</span>

### Install Maven
In order to create an adapter, you first need to download and install Maven. Go to the [Apache Maven website](https://maven.apache.org/) and follow the instructions how to download and install Maven.

<h2>Creating a Java Adapter</h2>
To create a Java adapter Maven project, use the `archetype:generate` command.
You can choose to run the command interactively or directly.
<h3>In Interactive Mode</h3>
<ul>
<li>
Run:
[code lang="xml" gutter="false"]
$ mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=maven-adapter-archetype -DarchetypeVersion=7.2.0.0
[/code]
The Archetype Group Id, Archetype Artifact Id, and Archetype Version are required parameters to identify the archetype.
</li>
	<li>You will be asked to enter the Group Id and the Artifact Id of the Maven project to be build:
[code lang="xml" gutter="false"]
Define value for property 'groupId': : sample.group.id
Define value for property 'artifactId': : SampleProject
[/code]
</li>
	<li>You will be asked to enter the Maven project version (the default is `1.0-SNAPSHOT`):
[code lang="xml" gutter="false"]
Define value for property 'version':  1.0-SNAPSHOT: : 1.0
[/code]
</li>
	<li>You will be asked to enter the Java adapter package name (the default is the `groupId`):
[code lang="xml" gutter="false"]
Define value for property 'package':  sample.group.id: : com.sample.adapter
[/code]
</li>
	<li>You will be asked to enter the Java adapter name (the default is the `artifactId`):
[code lang="xml" gutter="false"]
Define value for property 'adapter-name':  Sample: : TestAdapter
[/code]
</li>
	<li>Enter `y` to confirm:
[code lang="xml" gutter="false"]
[INFO] Using property: archetypeVersion = 7.2.0.0
Confirm properties configuration:
groupId: sample.group.id
artifactId: Sample
version: 1.0
package: com.sample.adapter
adapter-name: TestAdapter
archetypeVersion: 7.2.0.0
 Y: : y
[/code]
</li>
</ul>

<h3>In Direct Mode</h3>
<li>Replace the placeholders with the actual values and run:
[code lang="xml" gutter="false"]
$ mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=maven-adapter-archetype -DarchetypeVersion=7.2.0.0 -DgroupId=<maven_project_groupid> -DartifactId=<maven_project_artifactid> -Dversion=<maven_project_version> -Dpackage=<java_adapter_package_name> -Dadapter-name=<adapter_name>
[/code]

<br clear="all"/>
<blockquote>For more information about the `archetype:generate` command see the Maven documentation.</blockquote>

The result will be a Maven project containing a `src` folder and a `pom.xml` file:

<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/09/Screen-Shot-2015-09-07-at-15.26.58.png"><img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/09/Screen-Shot-2015-09-07-at-15.26.58.png" alt="Screen Shot 2015-09-07 at 15.26.58" width="1564" height="888" class="aligncenter size-full wp-image-17151" /></a>

<h2>Building and Deploying a Java Adapter</h2>
<h3>Build</h3>
There are three ways you can build your adapter:
<ul>
	<li>One way is to edit the `pom.xml` to include the `build` `goal` (the default option). This means that the adapter will be built every time you run the `mvn install` command to build your Maven project.
</li>
	<li>The other way is to run the `mvn adapter` command:
[code lang="xml" gutter="false"]
$ mvn adapter:build
[/code]
</li>
</ul>

The end result is the `.adapter` file in the project `target` folder:
<a href="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/09/Screen-Shot-2015-09-07-at-17.11.48.png"><img src="https://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2015/09/Screen-Shot-2015-09-07-at-17.11.48.png" alt="Screen Shot 2015-09-07 at 17.11.48" width="1306" height="782" class="aligncenter size-full wp-image-17191" /></a>

<h3>Deploy</h3>
**NOTE:** The deploy command is available only during development.  
<ul>
	<li>Edit the `pom.xml` file with the following `configuration` parameters:
[code lang="xml" gutter="true"]
<configuration>
    ...
    <!-- parameters for deploy adapter -->
    <serverUrl>http://<IP>:<PORT>/worklightadmin</serverUrl>
    <user>ADMIN_USER</user>
    <password>ADMIN_PASSWORD</password>
    <projectName>CONTEXT_ROOT</projectName>
</configuration>
[/code]
Replace the `IP` and `PORT` with the MobileFirst Server IP and port.
Replace the `ADMIN_USER` and `ADMIN_PASSWORD` with the MobileFirst admin user and password.
Replace the `CONTEXT_ROOT` with the MobileFirst project name.
</li>
	<li>There are two ways you can deploy your adapter:
<ul>
	<li>One way is to edit the `pom.xml` to include the `deploy` `goal`. This means that the adapter will be deployed every time you run the `mvn install` command to build your Maven project.
[code lang="xml" gutter="true"]
<goals>
    <goal>deploy</goal>
</goals>
[/code]
</li>
	<li>The other way is to run the `mvn:adapter` command:
[code lang="xml" gutter="false"]
$ mvn adapter:deploy
[/code]
</li>
	<li>You can also deploy the Java adapter using Ant tasks.
For more information see the topic about Deploying applications and adapters in the user documentation.
</li>
</ul>
</li>
</ul>

<h2 id="dependencies">Dependencies</h2>
Unlike using the Studio or the CLI `lib` folder to put your dependencies, in the Java adapter Maven project you'll put them under the `dependencies` element in the Maven project pom.xml file.

<blockquote>For more information about `dependencies` see the Maven documentation.</blockquote></li>

<h2>Migrating an Existing Java Adapter</h2>
In order to migrate an existing Java adapter to Java adapter Maven project you need to:
<ul>
	<li>Create a new Maven project using the existing adapter name and adapter package name.</li>
	<li>Overwrite the adapter .xml file (under src/main/resources) with the existing Java adapter .xml file.</li>
	<li>Overwrite the adapter application and resource Java files (under src/main/java/adapter_package_name) with the existing Java adapter application and resource Java files.</li>
	<li>To add dependencies from the existing Java adapter `lib` folder see the <a href="#dependencies">Dependencies</a> section.</li>

</ul>
