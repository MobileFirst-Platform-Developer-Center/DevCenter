---
title: Handling application configuration cloning for new application version deployment in MobileFirst Foundation 8.0
date: 2017-01-09
tags:
- MobileFirst_Foundation
- MobileFirst_CLI
version:
- 8.0
author:
  name: Jorge Iglesias
---
Using the {{ site.data.keys.mf_console_full }} you can clone an application configuration into a new application version, so you can register an identical copy of the application, but with a different version (same application id, environment, descriptor, and configuration).
But what if you want to achieve the same via command-line?

If you are an on-premise 8.0 customer or [Mobile Foundation service](https://console.bluemix.net/catalog/services/mobile-foundation) customer, then read further to learn how to clone an application configuration into a new application using cli.

The {{ site.data.keys.mf_cli }} does not currently have an application cloning functionality and if you want to automate all the deployment processes, for example using Jenkins, you have to implement your own cloning process.

For this purpose I've written a Nodejs-based program that takes care of the process of cloning an application's configuration.  
The program:

- Pulls the Application-Descriptor JSON File from the server
- Unzips the artifacts zip file
- Adds new version to the Application-Descriptor JSON File (applicationKey.version)
- Zips a new artifacts zip file
- Modifies the version in the configuracion file (config.xml)
- Registers an application
- Pushes the updated application configuration

## Example
`$ node cloneApp.js local mfp jif.example.hellocordova android 1.0.1 1.1.1`

## Check it out
Head over to [my GitHub repository page](https://github.com/jorgeiglesiasfernandez/CloneApp) and let me know if you have any questions!

*Jorge Iglesias is a Hybrid Cloud services consultant at IBM.*
