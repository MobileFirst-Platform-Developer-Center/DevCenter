---
layout: tutorial
title: Product Components
weight: 2
---
## Overview
IBM MobileFirst Foundation consists of the following components: MobileFirst CLI, MobileFirst Server, client-side runtime components, MobileFirst Operations Console, Application Center, and IBM MobileFirst Foundation System Pattern.

The following figure shows the components of IBM MobileFirst Foundation:

![Architecture of the MobileFirst Foundation solution](architecture.jpg)

### MobileFirst CLI
You can use the IBM MobileFirst Command Line Interface (CLI) to develop and manage applications, in addition to using the IBM MobileFirst Operations Console. Some aspects of the MobileFirst development process must be done with the CLI.

The commands, all prefaced with **mfpdev**, support the following types of tasks:

* Registering apps with the MobileFirst Server
* Configuring your app
* Creating, building, and deploying adapters
* Previewing and updating Cordova apps
* For more information, see the [Using CLI to manage MobileFirst artifacts](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) tutorial.

### MobileFirst Server
The MobileFirst Server provides secured backend connectivity, application management, push notification support and analytics capabilities and monitoring to MobileFirst applications. It is not an application server in the Java Platform, Enterprise Edition (Java EE) sense. It acts as a container for IBM MobileFirst Foundation application packages, and is in fact a collection of web applications, optionally packaged as an EAR (enterprise archive) file that run on top of traditional application servers.

MobileFirst Server integrates into your enterprise environment and uses existing resources and infrastructure. This integration is based on adapters that are server-side software components responsible for channeling back-end enterprise systems and cloud-based services to the user device. You can use adapters to retrieve and update data from information sources, and to allow users to perform transactions and start other services and applications.

[Learn more about the MobileFirst Server](server).

### Client-side runtime components
IBM MobileFirst Foundation provides client-side runtime code that embeds server functionality within the target environment of deployed apps. These runtime client APIs are libraries that are integrated into the locally stored app code. You use them to add MobileFirst features to your client apps. The APIs and libraries can be installed with the IBM MobileFirst Foundation Developer Kit or you can download them from repositories for your development platform.

### MobileFirst Operations Console
The MobileFirst Operations Console is used for the control and management of the mobile applications. The MobileFirst Operations Console is also an entry point to learn about IBM MobileFirst Foundation development. From the console, you can download code examples, tools, and SDKs.

You can use the MobileFirst Operations Console for the following tasks:

* Monitor and configure all deployed applications, adapters, and push notification rules from a centralized, web-based console.
* Remotely disable the ability to connect to MobileFirst Server by using preconfigured rules of app version and device type.
* Customize messages that are sent to users on application launch.
* Collect user statistics from all running applications.
* Generate built-in, pre-configured reports about user adoption and usage (number and frequency of users that are engaging with the server through the applications).
* Configure data collection rules for application-specific events.
* [Learn more about the MobileFirst Operations Console](console).

### IBM MobileFirst Analytics
IBM MobileFirst Foundation includes a scalable operational analytics feature that is accessible from the MobileFirst Operations Console. The analytics feature enables enterprises to search across logs and events that are collected from devices, apps, and servers for patterns, problems, and platform usage statistics.

The data for operational analytics includes the following sources:

* Crash events of an application on iOS and Android devices (crash events for native code and JavaScript errors).
* Interactions of any application-to-server activity (anything that is supported by the MobileFirst client/server protocol, including push notification).
* Server-side logs that are captured in traditional MobileFirst log files.

[Learn more about MobileFirst Operational Analytics](../../analytics).

### Application Center
With the Application Center, you can share mobile applications that are under development within your organization in a single repository of mobile applications. Development team members can use the Application Center to share applications with members of the team. This process facilitates collaboration between all the people who are involved in the development of an application.

Your company can typically use the Application Center as follows:

1. The development team creates a version of an application.
2. The development team uploads the application to the Application Center, enters its description, and asks the extended team to review and test it.
3. When the new version of the application is available, a tester runs the Application Center installer application, which is the mobile client. Then, the tester locates this new version of the application, installs it on their mobile device, and tests it.
4. After the tests, the tester rates the application and submits feedback, which is visible to the developer from the Application Center console.

The Application Center is aimed for private use within a company, and you can target some mobile applications to specific groups of users. You can use the Application Center as an enterprise application store.

### IBM MobileFirst Foundation System Pattern
With the MobileFirst Pattern, you can deploy MobileFirst Server on IBM PureApplication System or IBM PureApplication Service on SoftLayer. With these patterns, administrators and corporations can respond quickly to changes in the business environment by taking advantage of on-premises Cloud technologies. This approach simplifies the deployment process, and improves the operational efficiency to cope with increased mobile demand. The demand accelerates iteration of solutions that exceed traditional demand cycles. Using MobileFirst Pattern also gives access to best practices and built-in expertise, such as built-in scaling policies.

#### PureApplication System
IBM PureApplication System is an integrated, highly scalable system that is based on IBM X-Architecture, providing an application-centric computing model in a cloud environment.

An application-centric system is an efficient way to manage complex applications and the tasks and processes that are invoked by the application. The entire system implements a diverse virtual computing environment, in which different resource configurations are automatically tailored to different application workloads. The application management capabilities of the IBM PureApplication System platform make deployment of middleware and other application components quick, easy, and repeatable.

IBM PureApplication System provides virtualized workloads and a scalable infrastructure that is delivered in one integrated system.

#### Virtual System Patterns
Virtual system patterns are a logical representation of a recurring topology for a set of deployment requirements.

Virtual system patterns enable efficient and repeatable deployments of systems that include one or more virtual machine instances, and the applications that run on them. You can completely automate the deployment and eliminate the need to perform multiple time-consuming manual tasks. Such a deployment eliminates problems that are introduced by error-prone, manual configuration processes, especially in complex production topologies such as server farms, and accelerates solution deployment.