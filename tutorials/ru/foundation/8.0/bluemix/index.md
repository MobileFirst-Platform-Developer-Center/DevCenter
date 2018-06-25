---
layout: tutorial
breadcrumb_title: Mobile Foundation on IBM Cloud
title: IBM Mobile Foundation on IBM Cloud
relevantTo: [ios,android,windows,javascript]
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
<br/><br/>
> **Note:** *IBM Bluemix is now IBM Cloud. To know more, see [here](https://www.ibm.com/blogs/bluemix/2017/10/bluemix-is-now-ibm-cloud/).*

## Overview
{: #overview }
{{ site.data.keys.product_full }} can be hosted on IBM Cloud. Following is some basic information about IBM Cloud.

IBM Cloud is an implementation of IBM's Open Cloud Architecture. It leverages Cloud Foundry to enable developers to rapidly build, deploy, and manage their cloud applications, while tapping a growing ecosystem of available services and runtime frameworks.

> Learn more about the IBM Cloud architecture and IBM Cloud concepts [here](https://console.bluemix.net/docs/overview/ibm-cloud.html#overview).

### How does it work?
{: #how-does-it-work }
In a nutshell, there are two ways to run {{ site.data.keys.product }} on IBM Cloud, depending on the type of license entitlement.

> **Note:** *IBM Containers service is now deprecated hence Mobile Foundation on IBM Containers is not supported. [Learn more](https://www.ibm.com/blogs/bluemix/2017/07/deprecation-single-scalable-group-container-service-bluemix-public/).*

* IBM Cloud subscription or PayGo license: {{ site.data.keys.mf_bm_full }} service
* On Prem license: Use IBM provided scripts to set up an instance of {{ site.data.keys.product_full }} on Kubernetes Clusters or Liberty for Java runtime.

<!--To run {{ site.data.keys.product }} on Bluemix IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.-->

To run {{ site.data.keys.product}} on a IBM Cloud Liberty for Java runtime, the following components are used: an **Cloudfoundry app** that contains a **WebSphere Liberty installation**, with a **{{ site.data.keys.mf_server }} instance** deployed to it.

### Kubernetes Cluster on IBM Cloud
Kubernetes is an orchestration tool for scheduling app containers onto a cluster of compute machines. With Kubernetes, developers can rapidly develop highly available applications by leveraging the power and flexibility of containers.
You can use the Kubernetes CLI to create and manage your Kubernetes clusters.

[Learn more about Kubernetes Cluster on IBM Cloud](https://console.bluemix.net/docs/containers/cs_tutorials.html#cs_tutorials)

<!--### IBM Containers
{: #ibm-containers }
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).-->

### Liberty for Java runtime
{: #liberty-for-java-runtime }
The Liberty for Java runtime is powered by the liberty-for-java buildpack. The liberty-for-java buildpack provides a complete runtime environment for running applications on top of WebSphere Liberty profile. A command line interface is then used to manage your apps on IBM Cloud.

[Learn more about Liberty for Java](https://console.bluemix.net/docs/runtimes/liberty/index.html).


## Tutorials to follow next
{: #tutorials-to-follow-next }

* Create a {{ site.data.keys.mf_bm_short }} instance on Kubernetes Cluster in IBM Cloud [using IBM provided scripts](mobilefirst-server-using-kubernetes/).
* Create a {{ site.data.keys.mf_server }} instance using the tutorial [Setting up {{ site.data.keys.mf_bm }} service](using-mobile-foundation/).
<!--* Create a {{ site.data.keys.mf_server }} instance on Bluemix [using IBM provided scripts](mobilefirst-server-using-scripts/) using IBM Containers.-->
* Create a {{ site.data.keys.mf_server }} instance using Liberty for Java on IBM Cloud [using IBM provided scripts](mobilefirst-server-using-scripts-lbp/).
