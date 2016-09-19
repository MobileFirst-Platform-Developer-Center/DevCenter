---
layout: tutorial
title: Administrating MobileFirst applications through the Command-line
weight: 4
---
## Overview
You can administer MobileFirst applications through the **mfpadm** program.

#### Jump to

* [Comparison with other facilities](#comparison-with-other-facilities)
* [Prerequisites](#prerequisites)

## Comparison with other facilities
You can run administration operations with IBM MobileFirst Foundation in the following ways:

* The MobileFirst Operations Console, which is interactive.
* The mfpadm Ant task.
* The **mfpadm** program.
* The MobileFirst administration REST services.

The **mfpadm** Ant task, mfpadm program, and REST services are useful for automated or unattended execution of operations, such as the following use cases:

* Eliminating operator errors in repetitive operations, or
* Operating outside the operator's normal working hours, or
* Configuring a production server with the same settings as a test or preproduction server.

The **mfpadm** program and the mfpadm Ant task are simpler to use and have better error reporting than the REST services. The advantage of the mfpadm program over the mfpadm Ant task is that it is easier to integrate when integration with operating system commands is already available. Moreover, it is more suitable to interactive use.

## Prerequisites
The **mfpadm** tool is installed with the MobileFirst Server installer. In the rest of this page, **product\_install\_dir** indicates the installation directory of the MobileFirst Server installer.

The **mfpadm** command is provided in the **product\_install\_dir/shortcuts/** directory as a set of scripts:

* mfpadm for UNIX / Linux
* mfpadm.bat for Windows

These scripts are ready to run, which means that they do not require specific environment variables. If the environment variable **JAVA_HOME** is set, the scripts accept it.  
To use the **mfpadm** program, either put the **product\_install\_dir/shortcuts/** directory into your PATH environment variable, or reference its absolute file name in each call.

For more information about running the MobileFirst Server installer, see [Running IBM Installation Manager](../../../installation-configuration/production/installation-manager/).

#### Jump to

* [Calling the **mfpadm** program](#calling-the-mfpadm-program)
* [Commands for general configuration](#commands-for-general-configuration)
* [Commands for adapters](#commands-for-adapters)
* [Commands for apps](#commands-for-apps)
* [Commands for devices](#commands-for-devices)
* [Commands for troubleshooting](#commands-for-troubleshooting)


### Calling the **mfpadm** program
### Commands for general configuration
### Commands for adapters
### Commands for apps
### Commands for devices
### Commands for troubleshooting



