---
title: Running ibm-mobilefirst-starter container locally
date: 2015-10-25 14:05:45.000000000 +02:00
tags:
- Bluemix
- MobileFirst_Platform
- IBM_Containers
version:
- 7.1
author:
  name: Srinivasan Nanduri
---
<blockquote><b>Disclaimer: </b>The solution discussed herein is from my own personal experience as a developer using the MobileFirst platform and do not represent IBM's view nor IBM's interest in supporting this officially.</blockquote>

If you have tried an evaluation of MobileFirst Platform Foundation using the <a href="{{site.baseurl}}/tutorials/en/foundation/7.1/ibm-containers/evaluate">ibm-mobilefirst-starter</a> image on <a href="https://www.ng.bluemix.net/docs/">IBM Bluemix</a>, you might have wondered:

* How do I run the container locally on my computer?
* How do I add and run my own projects?

The purpose of this blog is to provide answers to these questions.

### Before you begin
When running the ibm-mobilefirst-starter image, you created a Docker container that was instantiated from the image. To run the container locally, complete the following steps:

1. Install <a href="https://docs.docker.com/installation/">Docker</a>.
2. Install Cloud Foundry CLI and the Cloud Foundry plugin for IBM Containers. Follow the instructions <a href="https://www.ng.bluemix.net/docs/containers/container_cli_ov.html#container_cli_cfic">here</a>.

Pull the image from the IBM Containers registry:

1. Open the terminal.
2. Login to the Bluemix and to the IBM Container Service / Registry to access the image. Detailed instructions <a href="https://www.ng.bluemix.net/docs/containers/container_cli_ov.html#container_cli_login">here</a>.

                    {% highlight bash %}
cf login
cf ic login
{% endhighlight %}

3. Pull the image.
{% highlight bash %}
docker pull registry.ng.bluemix.net/ibm-mobilefirst-starter
{% endhighlight %}

<b>Note:</b> The terminal referred to in this blog is the Docker terminal i.e., if you're using Docker Toolbox, the Docker Quickstart Terminal.

### Run the image
To run the image locally, run the following command from the terminal. Ensure the username and password for logging into the MobileFirst Operations console / MobileFirst Analytics console are provided within the command.

{% highlight bash %}
docker run -d -p 9080:9080 -e MFPF_ADMIN_USERNAME=<username> -e MFPF_ADMIN_PASSWORD=<password> registry.ng.bluemix.net/ibm-mobilefirst-starter
{% endhighlight %}

### Run the image with your projects
To add your own project(s) and optionally remove the MobileFirstStarter sample project, complete the following steps:

1. Create a directory on your machine with a name of your choice.
2. Create a Dockerfile (file named Dockerfile) in the directory and add the following to the Dockerfile.

        {% highlight bash %}
FROM registry.ng.bluemix.net/ibm-mobilefirst-starter:latest
{% endhighlight %}

3. Add your project to the directory (For example, HelloMFP.war)
4. Create an XML file using the same project name (for example, HelloMFP.xml), and add the following code snippet (modified with the correct project name):

<b>Contents of HelloMFP.xml</b>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<server description="new server">
    <application context-root="/HelloMFP" id="HelloMFP" location="HelloMFP.war" name="HelloMFP" type="war">
        <classloader delegation="parentLast">
            <privateLibrary id="worklightlib_HelloMFP">
                <fileset dir="${shared.resource.dir}" includes="worklight-jee-library.jar"/>.
                <fileset dir="${wlp.install.dir}/lib" includes="com.ibm.ws.crypto.passwordutil*.jar"/>
            </privateLibrary>
        </classloader>
    </application>
    <!-- Declare the IBM MobileFirst Server database. -->
    <dataSource jndiName="HelloMFP/jdbc/WorklightDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded createDatabase="create" databaseName="${shared.resource.dir}/derbyDB/HelloMFP/WRKLGHT" user="WORKLIGHT"/>
    </dataSource>
    <!-- Define any other IBM MobileFirst Server properties here -->
    <jndiEntry value="false" jndiName="HelloMFP/mfp.session.independent"/>
    <jndiEntry value="httpsession" jndiName="HelloMFP/mfp.attrStore.type"/>
 </server>
```

5. Add the following to the Dockerfile created in (2). Ensure to replace the 'HelloMFP' with the name of your project.

        {% highlight xml linenos %}
COPY HelloMFP.xml /opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides/
COPY HelloMFP.war /opt/ibm/wlp/usr/servers/defaultServer/apps/
{% endhighlight %}

<b>Note:</b> Repeat steps (3), (4) and (5) for every project you want to add to the image.

6. If you wish to remove the MobileFirstStarter project, add the following to the Dockerfile created in (2).

        {% highlight xml linenos %}
RUN rm /opt/ibm/wlp/usr/servers/defaultServer/configDropins/overrides/MobileFirstStarter.xml
RUN rm /opt/ibm/wlp/usr/servers/defaultServer/apps/MobileFirstStarter.war
{% endhighlight %}

7. Build the image with the new Dockerfile. Ensure you run the command from within the directory created in (1) and specify the name of the tag for tagging the image in the command.

        {% highlight bash %}
docker build -t <name of the tag>
{% endhighlight %}

8. Run the image using the following command (modified with your username and password for the MobileFirst Operations Console / MobileFirst Analytics Console and the correct tag name).

{% highlight bash %}
docker run -d -p 9080:9080 -e MFPF_ADMIN_USERNAME=<username> -e MFPF_ADMIN_PASSWORD=<password> <name of the tag>
{% endhighlight %}
