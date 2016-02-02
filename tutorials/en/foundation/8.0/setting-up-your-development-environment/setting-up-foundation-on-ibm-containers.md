---
layout: tutorial
title: Setting Up MobileFirst Platform Foundation on IBM Containers - Beta
breadcrumb_title: Foundation on IBM Containers
relevantTo: [ios,android,windows,cordova]
weight: 6
---
## Overview
This tutorial provides step-by-step instructions to set-up a MobileFirst Server instance on IBM Containers using **MobileFirst Platform Foundation Tile** *beta*.

IBM MobileFirst Platform Foundation Tile is a **Bluemix service** that enables quick and easy stand-up of scaleable Developer or Production environments of MobileFirst Platform Foundation v8.0 Beta.

## Using MobileFirst Platform Foundation Tile

1. Load [bluemix.net](http://bluemix.net) and visit the **Catalog** page, search for "MobileFirst Platform Foundation".

    ![Image of the MobileFirst Platform Foundation Tile setup](search-for-foundation.png)
    
2. Optionally set a **Service name** and click **Create**.

    ![Image of the MobileFirst Platform Foundation Tile setup](set-service-name.png)
    
3. Optionally update the server configuration in the [Configuration tab](#configuring-the-server-instance).

4. Click in **Start Basic Server** to start the server.

    ![Image of the MobileFirst Platform Foundation Tile setup](overview-page.png)

5. After starting the server you are presented with the MobileFirst Platform Operations Console.

    ![Image of the MobileFirst Platform Foundation Tile setup](console.png)

## Basic Server
The created server instance baseline is made of:

* Single node
* 512MB memory
* 32GB storage capacity

## Configuring the server instance
It can be further customized with varying node, memory and storage combinations.

The server instance can be further configured through the Configuration tab:

* console username &amp; password
* security keys
* JNDI confiration
* user registration
* MobileFirst Platform Foundation Analytics configuration
* Database selection
* VPN

> **Note:** The beta release does not support all mentioned features. These will be added with time until the GA release.

## Further reading
Now that the MobileFirst Server instance is up &amp; running, you can learn more about the MobileFirst Operations Console, and how to create applications and adapters by [reading through the tutorials](../../all-tutorials/).