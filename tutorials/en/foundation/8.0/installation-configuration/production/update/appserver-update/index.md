---
layout: tutorial
title: Updating the MobileFirst server
breadcrumb_title: Updating the MobileFirst server
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
IBM MobileFirst Platform Foundation provides several components that you might have installed.

Here is a description of their dependencies to update them:

### MobileFirst Server Administration Service, MobileFirst Operations Console, and MobileFirst runtime environment
{: #server-console }

These three components compose as MobileFirst Server. They must be updated together.

### Application Center
{: #appenter}

The installation of this component is optional. This component is independent of the other components. It can be run at a different interim fix level than the others if needed.

### MobileFirst Operational Analytics
{: #analytics}

The installation of this component is optional. The MobileFirst components send data to MobileFirst Operational Analytics via a REST API. It is preferable to run MobileFirst Operational Analytics with the other components of MobileFirst Server of the same interim fix level.

### MobileFirst Operational Analytics Receiver
{: #analyticsreceiver}

The installation of this component is optional. The MobileFirst Applications send log data to MobileFirst Operational Analytics Receiver via a REST API. Install this component only if MobileFirst Operational Analytics installed. It is preferable to run MobileFirst Operational Analytics Receiver with the other components of MobileFirst Server of the same interim fix level.

## Updating MobileFirst Server Administration Service, MobileFirst Operations Console, and MobileFirst runtime environment
{: #updating-server}

You can update these components in two ways:
* With Server Configuration Tool
* With Ant tasks

The updating procedure depends on the method you used at the initial installation.

>**Note:**  It is recommended to back up the existing MFP installation directory before you update the MobileFirst server.
> No special procedure is required when you back up these files, except for ensuring that the MobileFirst server is stopped.  Otherwise, the data might change while the backup is occurring, and the data that is stored in memory might not yet be written to the file system. To avoid inconsistent data, stop the MobileFirst server before you start your backup.
>
MFP does not support rolling back of an update/iFix through IBM Installation Manager (IM). However, rollback is possible using the ANT Tasks or Server Configuration Tool (SCT) using the MFP related war files that are backed up before updating.
>

<!-- **Note:** Installation Manager(IM) does not support rolling back of an update/iFix. However, rollback is possible using Ant or Server Configuration Tool, if you have the old war files. -->

### Applying a fix pack by using the Server Configuration Tool
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
If {{ site.data.keys.mf_server }} is installed with the configuration tool and the configuration file is kept, you can apply a fix pack or an interim fix by reusing the configuration file.

1. Start the Server Configuration Tool.
    * On Linux, from application shortcuts **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On Windows, click **Start → Programs → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On macOS, open a shell console. Go to **mfp\_server\_install_dir/shortcuts** and type **./configuration-tool.sh**.
    * The **mfp\_server\_install\_dir** directory is where you installed {{ site.data.keys.mf_server }}.

2. Click **Configurations → Replace the deployed WAR files** and select an existing configuration to apply the fix pack or an interim fix.

### Rollback a fix pack by using the Server Configuration Tool
{: #rollback-a-fix-pack-by-using-the-server-configuration-tool }

If the MobileFirst server is installed using the Server Configuration Tool and the configuration file is retained, you can roll back a fix pack or an interim fix by reusing the configuration file.

1.  Start the Server Configuration Tool.
    * Manually replace the MFP related war files by copying them from the backed up location of MFP install directory  (`mfp_server_install_dir/MobileFirstServer`).
    * On Linux, from application shortcuts **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On Windows, click **Start → Programs → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * On MacOS, open a shell console. Go to `mfp_server_install_dir/shortcuts and type ./configuration-tool.sh`.
    * The `mfp_server_install_dir` directory is where you installed the MobileFirst Server.

2.  Select the configuration that has to be rolled back. Click **Configurations** and select the option - **Edit and redeploy configuration**.

3.  Click **Next** on each page, traverse till the end and click **Update**.


### Applying a fix pack by using the Ant files
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Updating with the sample Ant file
{: #updating-with-the-sample-ant-file }
If you use the sample Ant files that are provided in the **mfp\_install\_dir/MobileFirstServer/configuration-samples** directory to install {{ site.data.keys.mf_server }}, you can reuse a copy of this Ant file to apply a fix pack. For password values, you can enter 12 stars (\*) instead of the actual value, to be prompted interactively when the Ant file is run.

1. Verify the value of the **mfp.server.install.dir** property in the Ant file. It must point to the directory that contains the product with the fix pack applied. This value is used to take the updated {{ site.data.keys.mf_server }} WAR files.
2. Run the command: `mfp_install_dir/shortcuts/ant -f your_ant_file update`

#### Updating with own Ant file
{: #updating-with-own-ant-file }
If you use your own Ant file, make sure that for each installation task (**installmobilefirstadmin**, **installmobilefirstruntime**, and **installmobilefirstpush**), you have a corresponding update task in your Ant file with the same parameters. The corresponding update tasks are **updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**.

1. Verify the class path of the **taskdef** element for the **mfp-ant-deployer.jar** file. It must point to the **mfp-ant-deployer.jar** file in an {{ site.data.keys.mf_server }} installation that the fix pack is applied. By default, the updated {{ site.data.keys.mf_server }} WAR files are taken from the location of **mfp-ant-deployer.jar**.
2. Run the update tasks (**updatemobilefirstadmin**, **updatemobilefirstruntime**, and **updatemobilefirstpush**) of your Ant file.

### Rollback a fix pack by using the Ant files
{: #rollback-a-fix-pack-by-using-the-ant-files }

#### Rollback with the sample Ant file
{: #rollback-with-the-sample-ant-file }

If you use the sample Ant files that are provided in the `mfp_install_dir/MobileFirstServer/configuration-samples` directory to install MobileFirst server, you can reuse a copy of this Ant file to rollback a fix pack. For password values, you can enter 12 stars (`*`) instead of the actual value, which will be prompted for interactively when the Ant file is run.

1.  Manually replace the MFP related war files by copying them from the backed up location of MFP install directory (`mfp_server_install_dir/MobileFirstServer`).
2.  Verify the value of the **mfp.server.install.dir** property in the Ant file. This value is used to take the updated MobileFirst server WAR files.
3.  Run the following command:
    ```bash
    mfp_install_dir/shortcuts/ant -f <your_ant_file update>
    ```

#### Rollback with own Ant file
{: #rollback-with-own-ant-file }

If you use your own Ant file, make sure that for each update/rollback task (*installmobilefirstadmin*, *installmobilefirstruntime*, and *installmobilefirstpush*), you have a corresponding update task in your Ant file with the same parameters. The corresponding update tasks are *updatemobilefirstadmin*, *updatemobilefirstruntime*, and *updatemobilefirstpush*.

1.  Manually replace the MFP related war files by copying them from the backed up location of MFP install directory (`mfp_server_install_dir/MobileFirstServer`).
2.  Verify the class path of the **taskdef** element for the `mfp-ant-deployer.jar` file. It must point to the mfp-ant-deployer.jar file in an MobileFirst server installation that the fix pack is applied. By default, the updated MobileFirst server WAR files are taken from the location of mfp-ant-deployer.jar.
3.  Run the update tasks (*updatemobilefirstadmin*, *updatemobilefirstruntime*, and *updatemobilefirstpush*) of your Ant file.
