---
layout: tutorial
title: Setting Up the Development Environment
breadcrumb_title: Development Environment
show_children: true
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Before starting to develop client and server code using {{ site.data.keys.product_full }}, the development environment needs to be set-up first. This includes installing various required software and tools. The following is a list of software you may need to install on your developer workstation, depending on your needs.

You can also find detailed step-by-step instructions [in this workstation installation guide](mobilefirst/installation-guide/).

#### Jump to:

* [Server](#server)
* [Application development](#application-development)
* [Adapter development](#adapter-development)
* [Platform-specific instructions](#platform-specific-instructions)

### Server
{: #server }
You can use the {{ site.data.keys.mf_server }} either via the [Mobile Foundation IBM Cloud service](../../bluemix/using-mobile-foundation), or locally using the {{ site.data.keys.mf_dev_kit_full }} (used for local development purposes). The {{ site.data.keys.mf_server }} requires Java 7 or 8 to run.

If you intend on using the Mobile Foundation IBM Cloud service, an account on bluemix.net is required.

### Application development
{: #application-development }
At the very minimum, the following software is needed:

* NodeJS (requirement for {{ site.data.keys.mf_cli }})
* {{ site.data.keys.mf_cli }}
* Cordova CLI
* IDEs:
    - Xcode
    - Android Studio
    - Visual Studio
    - Atom.io / Visual Studio Code / WebStorm / IntelliJ / Eclipse / other IDEs

### Adapter development
{: #adapter-development }
At the very minimum, the following software is needed:

* NodeJS (requirement for {{ site.data.keys.mf_cli }})
* *optional* {{ site.data.keys.mf_cli }}
* Maven (requires Java)
* IDEs:
    - IntelliJ / Eclipse / other IDEs

### Platform-specific instructions
{: #platform-specific-instructions }
