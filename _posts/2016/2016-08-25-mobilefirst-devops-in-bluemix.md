---
title: Build and Deploy MobileFirst Foundation 8.0 adapters using Bluemix DevOps services
date: 2016-08-25
tags:
- MobileFirst_Foundation
- Mobile_Foundation_Service
- Bluemix
- DevOps
version: 8.0
author:
  name: Jorge Gonzalez Orozco
---

### Introduction
Today's enterprises are using DevOps techniques as a way to speed up software delivery and improve time to market. IBM Bluemix provides a large set of DevOps services such as Active Deploy, Delivery Pipeline, Auto-Scaling, etc. Companies can use these services to rapidly build a cloud based DevOps infrastructure.

In this blog post we will show how we can build and deploy an IBM MobileFirst Foundation 8.0 Adapter using the IBM Bluemix Delivery Pipeline service. For readers not familiar with the concept of adapters, a MobileFirst Foundation adapter is basically an API that is optimized for mobile application consumption. In this delivery pipeline as soon as developers commit and push code into a Git repository in IBM Bluemix, a two stage pipeline (shown below) will automatically start to build and deploy the adapter code into a remote MobileFirst server.

![Bluemix Delivery Pipeline service]({{site.baseurl}}/assets/blog/2016-08-25-mobilefirst-devops-in-bluemix/devops.png)

### Prerequisites
For this exercise you will need a Bluemix account and a MobileFirst Foundation server v8.0 that can be reached from the Internet. You could use the new Bluemix [Mobile Foundation Tile](https://console.bluemix.net/catalog/services/mobile-foundation) to create this server. Regarding the adapter code we will leverage the sample code that is available with the MobileFirst Foundation documentation.

### Create your Git repository in Bluemix
Login into IBM Bluemix DevOps Services: [https://hub.jazz.net](https://hub.jazz.net)

Under the **My Projects** tab click on **Create project**.

1. Call the project **AdapterDevOps**
2. Select **Create a new repository**
3. Select **Create a Git repo on Bluemix**
4. Leave the check boxes as they are by default but make sure you check **Make this a Bluemix Project**.
5. Select the Bluemix Region, Organization and Space appropriate for your account.
6. Finally click on the **Create** button.

Now that you have an empty Git repository in Bluemix lets replicate that in your laptop.  
From a command window:

1. Create a folder called DevOps: `mkdir DevOps`
2. Change to this folder: `cd DevOps`
3. Clone the repo: `git clone --no-checkout https://hub.jazz.net/git/<your-bluemix-id-up-to-@>/AdapterDevOps`

Now that you have cloned your Bluemix Git repo locally you will see an AdapterDevOps folder

### Push the adapter code to your Git repository in Bluemix
Let's get some sample Adapter code that we can use for this DevOps pipeline. In the next steps we will use the sample code from this GitHub repo: [https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80)

1. In the same DevOps folder clone the repo: `git clone https://github.com/MobileFirst-Platform-Developer-Center/Adapters.git`
    At this point under the DevOps folder you should have two subfolders Adapters (the sample code we will use for the pipeline) and AdapterDevOps (the local clone of your Bluemix repo).
2. Copy the **Adapters/JavaAdapter** folder to the **AdapterDevOps** folder.
3. From the **AdapterDevOps** folder we need to push the new code to our repo in Bluemix. Again make sure you run the following commands from the AdapterDevOps folder:
  - `git add  *`
  - `git commit -m 'first commit'`
  - `git push -u origin master`

Let's verify that now you have the adapter code in your Bluemix Git repo. From the Bluemix DevOps console on the top right, click on the **Edit Code** button.   You should see the **JavaAdapter** folder. Disregard the other files and folders added by the DevOps service.

### Create the Bluemix Build &amp; Deploy pipeline
From the Bluemix DevOps console on the top right, click on the **Build &amp; Deploy** button.

Let's first create the **Build** stage:

1. Click on the **+ ADD STAGE** button.
2. Rename the stage from the default **MyStage** to **Adapter Build**. Just write over.
3. Under the **INPUT** tab note the settings. We will use the default settings.
4. Click on the JOBS tab and click on **ADD JOB**. Select job type as **Build**.
5. Under **Builder Type** select **npm**.
6. Under **Build Shell Command**
  - uncomment the following line: `#export PATH=/opt/IBM/node-v4.2/bin:$PATH`
  - remove the last line: **npm install**
  - add the following script at the very end:

```bash
echo "#### npm install -g mfpdev-cli"
npm install -g mfpdev-cli
echo "#### mfpdev --version"
mfpdev --version
cd JavaAdapter
echo "#### mfpdev adapter build"
mfpdev adapter build
```

The complete script should look like this:

```bash
#!/bin/bash
# The default Node.js version is 0.10.40
# To use Node.js 0.12.7, uncomment the following line:
# #export PATH=/opt/IBM/node-v0.12/bin:$PATH
# To use Node.js 4.2.2, uncomment the following line:
export PATH=/opt/IBM/node-v4.2/bin:$PATH

echo "#### npm install -g mfpdev-cli"
npm install -g mfpdev-cli
echo "#### mfpdev --version"
mfpdev --version
cd JavaAdapter
echo "#### mfpdev adapter build"
mfpdev adapter build
```

As you can see, the script is going to install the MobileFirst Command Line Interface (CLI) and build the adapter. Let's verify that the stage runs successfully.

1. Click on the play icon.
2. Click on the **View logs and history**
3. Verify that the logs finish with the line: **Finished: SUCCESS**
4. Click on the Artifacts tab. Expand the **JavaAdapter** folder and verify that there is a target folder. This folder was added by the CLI build process and will be used by the Deploy stage.

At any point, disregard the message **Your project workspace has outgoing changes. Go to the [Git page](https://hub.jazz.net/code/git/git-repository.html#/code/gitapi/clone/file/jorgego-OrionContent/jorgego%20%7C%20AdapterDevOps) to commit and push your changes if you want to include them in your deployed application**

Now let's create the **Deploy** stage:

1. Click on the **+ ADD STAGE** button.
2. Rename the stage from the default **MyStage** to **Adapter Deploy**. Just write over it.
3. Under the INPUT tab note the settings. We will use the default settings.
4. Click on the JOBS tab and click on **ADD JOB**. Select job type as **Build**. In this case the Deploy option is used for Cloud Foundry or Containers. Since in our Deploy stage we just need to run another script we will select the **Build** option again.
5. Under **Builder Type** select **npn**.
6. Under **Build Shell Command**
  - uncomment the following line
    - #export PATH=/opt/IBM/node-v4.2/bin:$PATH
  - remove the last line **npm install**
  - add the following script at the very end:

```bash
echo "#### npm install -g mfpdev-cli"
npm install -g mfpdev-cli
echo "#### mfpdev --version"
mfpdev --version
cd JavaAdapter
echo "#### adding server definition"
mfpdev server add server1 --url 'https://<mf-server-hostname>:443' --login '<username>' --password '<password>' --setdefault
echo "#### deploying adapter"
mfpdev adapter deploy
```


The complete script should look like this:

```bash
#!/bin/bash
# The default Node.js version is 0.10.40
# To use Node.js 0.12.7, uncomment the following line:
# #export PATH=/opt/IBM/node-v0.12/bin:$PATH
# To use Node.js 4.2.2, uncomment the following line:
export PATH=/opt/IBM/node-v4.2/bin:$PATH

echo "#### npm install -g mfpdev-cli"
npm install -g mfpdev-cli
echo "#### mfpdev --version"
mfpdev --version
cd JavaAdapter
echo "#### adding server definition"
mfpdev server add server1 --url 'https://<mf-server-hostname>:443' --login '<username>' --password '<password>' --setdefault
echo "#### deploying adapter"
mfpdev adapter deploy
```

As you can see the script is going to install again the MobileFirst CLI, add the MobileFirst Server as a new default server definition and deploy the adapter.   Let's verify that the pipeline runs successfully.

1. Click on the play icon on the first Adapter Build stage. This stage should finish successfully since we test it before. Note that the second stage AdapterDeploy starts.
2. Click on the **View logs and history** in the Adapter Deploy stage.
3. Verify that the logs finish with the line: **Finished: SUCCESS**

Login to the MobileFirst Operations Console and verify that a new adapter called **JavaAdapter** has been deployed.



### Final Thoughts
In this blog post we showed how easy is to use the delivery pipeline service in IBM Bluemix. As a next step, you could add additional steps to this pipeline.   For example you could add an Android build and deploy stage that could create the .apk binary file.

Feel free to explore and play with the other DevOps services in IBM Bluemix.
