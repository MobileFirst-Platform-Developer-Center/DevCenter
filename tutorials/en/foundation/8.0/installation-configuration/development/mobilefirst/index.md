---
layout: tutorial
title: Setting up the MobileFirst development environment
breadcrumb_title: MobileFirst
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
{{ site.data.keys.product_full }} is made up of several components: the client SDKs, adapter archetypes, security checks, and authentication tools.

These components are available from online repositories and can be installed using package managers. These online repositories provide the latest release of each component. The same component is also available to download from the {{ site.data.keys.mf_dev_kit }} for local use. Note that the version that is available from the {{ site.data.keys.mf_dev_kit_short }} represents the version that was available at the time the specific {{ site.data.keys.mf_dev_kit_short }} build was released, and that downloading a new {{ site.data.keys.mf_dev_kit_short }} build will be required in order to use the latest. 

Continue reading to learn more about the components of {{ site.data.keys.product }}.

> To evalute {{ site.data.keys.product }} all that is needed is to spin an instance of {{ site.data.keys.mf_server }} on Bluemix using the Mobile Foundation Bluemix service. See the [Using Mobile Foundation](../../../bluemix/using-mobile-foundation/) tutorial for instructions. You may also choose to install the {{ site.data.keys.mf_dev_kit_short }} for a local installation.

#### Jump to:
{: #jump-to }

* [Installation guide](#installation-guide)
* [{{ site.data.keys.mf_dev_kit }}](#mobilefirst-developer-kit)
* [{{ site.data.keys.product }} components](#mobilefirst-foundation-components)
* [Applications and Adapters development](#applications-and-adapters-development)
* [Tutorials to follow next](#tutorials-to-follow-next)

## Installation guide
{: #installation-guide }
[Read the installation guide](installation-guide) to quickly setup MobileFirst Foundation in your workstation.

## {{ site.data.keys.mf_dev_kit }}
{: #mobilefirst-developer-kit }
The {{ site.data.keys.mf_dev_kit_short }} provides a ready-for-development environment with minimal configuration needed. The kit consists of the following components: {{ site.data.keys.mf_server }} &amp; {{ site.data.keys.mf_console }}, MobileFirst Developer Command-line Interface (CLI), as well as optionally provides client SDKs and adapter tooling for download.

> **Note:** If you need to set up your development environment on a computer that has no internet access, you can install components offline. See [How to set up an offline IBM MobileFirst development environment]({{site.baseurl}}/blog/2016/03/31/howto-set-up-an-offline-ibm-mobilefirst-8-0-development-environment).

### {{ site.data.keys.mf_dev_kit_short }} Installer
{: #developer-kit-installer }
The Installer packages the components for local installation where Internet connectivity is not available.  
The components are available through the Download Center of the {{ site.data.keys.mf_console }}.

> To download the installer, visit the [downloads]({{site.baseurl}}/downloads/) page.

## {{ site.data.keys.product }} components
{: #mobilefirst-foundation-components }

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
As part of the {{ site.data.keys.mf_dev_kit_short }}, the {{ site.data.keys.mf_server }} is provided pre-deployed on a WebSphere Liberty profile application server. The server is pre-configured with an "mfp" runtime and uses a filesystem-based Apache Derby database.

In the {{ site.data.keys.mf_dev_kit_short }} root directory, the following scripts are available to run from a command-line:

* `run.[sh|cmd]`: Run the {{ site.data.keys.mf_server }} with trailing Liberty Server messages
    * Add the `-bg` flag to run the process in the background
* `stop.[sh|cmd]`: Stop the current {{ site.data.keys.mf_server }} instance
* `console.[sh|cmd]`: Open the {{ site.data.keys.mf_console }}

`.sh` file extensions are for Mac and Linux, and `.cmd` file extensions are for Windows.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
The {{ site.data.keys.mf_console }} exposes the following functionalities.  
A developer can:

- Register and deploy applications and adapters
- Optionally download native/Cordova application and adapter starter code templates 
- Configure an application's authentication and security properties
- Manage applications:
    - Application Authenticity
    - Direct Update
    - Remote Disable/Notify
- Send Push Notifications to iOS and Android devices
- Generate DevOps scripts for continuous integration workflows and faster development cycles

> Learn more about the {{ site.data.keys.mf_console }} in the [Using the MobilFirst Operations Console](../../../product-overview/components/console/) tutorial.

### {{ site.data.keys.product }} Command-line Interface
{: #mobilefirst-foundation-command-line-interface }
You can use the {{ site.data.keys.mf_cli }} to develop and manage applications, in addition to using the {{ site.data.keys.mf_console }}. The CLI command are prefixed with `mfpdev` and support the following types of tasks:

* Registering apps with the {{ site.data.keys.mf_server }}
* Configuring your app
* Creating, building, and deploying adapters
* Previewing and updating Cordova apps

> To download and install the {{ site.data.keys.mf_cli }}, visit the [downloads]({{site.baseurl}}/downloads/) page.  
> Learn more about the various CLI commands in the [Using CLI to manage MobileFirst artifacts](../../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) tutorial.

### {{ site.data.keys.product }} client SDKs and adapter tooling
{: #mobilefirst-foundation-client-sdks-and-adapter-tooling }
{{ site.data.keys.product }} provides client SDKs for Cordova applications as well as for Native platforms (iOS, Android and Windows 8.1 Universal &amp; Windows 10 UWP). Adapter tooling for adapters and security checks development is available as well.

* To use the {{ site.data.keys.product_adj }} client SDKs, visit the [Adding the {{ site.data.keys.product }}SDK](../../../application-development/sdk/) tutorials category.  
* To develop adapters, visit the [Adapters](../../../adapters/) tutorials category.  
* To develop security checks, visit the [Authentication and security](../../../authentication-and-security/) tutorials category.  

## Applications and adapters development
{: #applications-and-adapters-development }

### Applications
{: #applications }
* Cordova applications require NodeJS and the Cordova CLI. Read more about [setting up the Cordova development environment](../cordova).

    You can use your preferred code editor, such as Atom.io, Visual Studio Code, Eclipse, IntelliJ and others, to implement applications and adapters.  
    
* Native applications require either Xcode, Android Studio or Visual Studio. Read more about [setting up the iOS/Android/Windows development environment](../).

### Adapters
{: #adapters }
Adapters require Apache Maven to be installed. Refer to the [Adapters](../../../adapters/) category to learn more about adapters and how to create, develop and deploy.

## Tutorials to follow next
{: #tutorials-to-follow-next }
Visit the [All Tutorials](../../../all-tutorials/) page and select a tutorials category to follow next.

