---
layout: tutorial
breadcrumb_title: IBM Containers
show_disqus: true
title: IBM MobileFirst Platform Foundation on IBM Containers
relevantTo: [ios,android,windows,cordova]
---
## Overview
Before talking about IBM MobileFirst Platform Foundation and IBM Containers, lets talk Bluemix.

**IBM Bluemix** is an implementation of IBM's Open Cloud Architecture. It leverages **Cloud Foundry** to enable developers to rapidly build, deploy, and manage their cloud applications, while tapping a growing ecosystem of available services and runtime frameworks.

> Learn more about the Bluemix architecture and Bluemix concepts [on the Bluemix website](https://www.ng.bluemix.net/docs/overview/overview.html).

In the context of IBM MobileFirst Platform Foundation, it is possible to take an existing Foundation-based project and run it on top of Bluemix: no need to maintain IT infrastructure and other traditional hurdles any more. This feature opens up the ability to implement and use various Bluemix-provided services to complete and enhance the feature set of a given application.

### How does it work?
In a nutshell: to run IBM MobileFirst Platform Foundation on IBM Containers, several components must interact with one another: the first component is an **image** that contains a **Linux distribution with a WebSphere Liberty installation**, with a **MobileFirst Server instance** deployed to it. The image is then stored inside an **IBM Container**, and the IBM Container is managed by **Bluemix**.

### IBM Containers
IBM Containers are objects that are used to run images in a hosted cloud environment. IBM Containers hold everything that an app needs to run.

The IBM Container infrastructure includes a private registry for your images, so that you can upload, store, and retrieve them. You can make those images available for Bluemix to manage them. A command line interface is then used to manage your containers on Bluemix - More on this in the following tutorials.

[Learn more about IBM Containers](https://www.ng.bluemix.net/docs/containers/container_index.html).

> To learn more about IBM MobileFirst Platform Foundation on IBM Containers, see the "IBM MobileFirst Platform Foundation 7.1.0.0 Evaluation on IBM Containers" topics, in the user documentation.

## What to follow next
The available tutorials provide two choices:

* [Evaluate](evaluate/): Experience the ease of creating a new IBM Container in Bluemix, launch a preconfigured IBM Container (with a MobileFirst Server instance) in it, and use an application that connects to the MobileFirst Server instance.
* [Run](run/): Learn how to set up a development environment for working with IBM Containers, create and update an image with changes done in your local Foundation development environment, and how to run it on Bluemix.
