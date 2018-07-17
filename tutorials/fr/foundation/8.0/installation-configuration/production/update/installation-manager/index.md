---
layout: tutorial
title: Running the IBM Installation Manager for update
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Running Installation Manager in graphical mode
{: #graphical-mode}

* Run Installation Manager from the user account that is used at the initial installation.
  To apply an update, Installation Manager must run with the same list of registry files that are used at the initial installation. The list of Software that is installed and the options that are used during the installation time are stored in those registry files. If you run Installation Manager in administrator mode, the registry files are installed at the system level. In `/var` folder on UNIX or Linux. In `c:\ProgramData` folder on Windows. The location is independent from the user who runs Installation Manager (although root is needed on UNIX and Linux). However, if you run Installation Manager in single user mode, the registry files are stored by default in the user's home directory.

* Select **File > Preferences**.
  If you plan to update an existing IBM MobileFirst Platform Foundation V8.0.0 (apply a fix pack or interim fix), the repository of product is not needed.

* Click **OK** to close the **Preferences** display.

* Click **Update** and select the package that you need to update. Installation Manager displays a list of packages. By default, the package to  update is named as IBM MobileFirst Platform Server.

* Accept the license terms, and click **Next**.

* In the **Thank You** panel, click **Next**. A summary is displayed.

* Click **Update** to start the update procedure.

## Running Installation Manager in command-line mode
{: #cli-mode}

1. Download the silent install files from   [here](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip).

2. Decompress the file, and select `8.0/upgrade-initially-mfpserver.xml` file.
  - If you initially installed the product in V6.0.0, V6.1.0 or V6.2.0, select the `8.0/upgrade-initially-worklightv6.xmlfile` instead.
  - If you initially installed the product in V5.x, select this `8.0/upgrade-initially-worklightv5.xml` file instead.
  The file contains the profile identity of the product. The default value of this identity changes over the releases of the product. In V5.x, it is Worklight. In V6.0.0, V6.1.0, and V6.2.0, it is IBM Worklight. In V6.3.0, V7.0.0, V7.1.0 and V8.0.0, it is IBM MobileFirst Platform Server.

3. Make a copy of the file you selected.

4. Open the copied XML file with a text editor or XML editor. Modify the following elements:

   a. The repository element that defines the repository list. Since you plan to update an existing IBM MobileFirst Platform Foundation V8.0.0 (apply a fix pack or interim fix), the repository of product is not needed.

   b. **Optional:** Update the passwords for the database and the application server.
      If Application Center is installed at the initial installation with Installation Manager, and the passwords for the database or the application server are changed, you can modify the value in the XML file. These passwords are used to validate that the database has the right schema version, and to upgrade it if it is in a version older than V8.0.0. They are also used to run **wsadmin** for an installation of Application Center on WebSphere Application Server full profile. Uncomment the appropriate lines in the XML file:
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. If you have not made a choice before to activate token licensing that is released with an interim fix on 15 September 2015 or later,   uncomment the line `<data key=’user.licensed.by.tokens’ value=’false’/>`. Set the value to **true** if you have a contract to use token   licensing with the Rational License Key Server. Otherwise, set the value to **false**.
      If you activate token licensing, make sure that the Rational License Key Server is configured, and enough tokens can be obtained to run MobileFirst Server and the applications it serves. Otherwise, the MobileFirst Server administration application and the runtime environment cannot be run.
      > **Restriction:** After the decision is made to activate token licensing or not, it cannot be modified. If you run an upgrade with the value **true**, and later another upgrade with the value **false**, the second upgrade fails.

    d. Review the profile identity and the installation location. The profile identity and the installation location must match what is installed:
      * This line: `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * And this line: `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * To review the profile identity and the installation directories that are known to Installation Manager, you can type the command:
    ```bash
      installation_manager_path/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. Update the version attribute to and set it to the version of the interim fix.
       For example, if you install the interim fix (8.0.0.0-MFPF-IF20171006-1725), replace

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      by

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager does not only use the repositories that are listed in the installation file, but also the repositories that are installed in its preferences. Specifying the version attribute in the offering element is optional. However, by specifying it, you ensure that the interim fix that is defined is the version that you intend to install. This specification overrides the other repositories with interim fixes that are listed in the Installation Manager preferences.

5. Open a session with the user account that is used at the initial installation.
    To apply an update, Installation Manager must run with the same list of registry files that are used at the initial installation. The list of Software that is installed and the options that are used during the installation time are stored in those registry files. If you run Installation Manager in administrator mode, the registry files are installed at the system level. In `/var` folder on UNIX or Linux. In `c:\ProgramData` folder on Windows. The location is independent from the user who runs Installation Manager (although root is needed on UNIX and
    Linux). However, if you run Installation Manager in single user mode, the registry files are stored by default in the user's home directory.

6. Run the command
  ```bash
   installation_manager_path/eclipse/tools/imcl input <responseFile> -log /tmp/installwl.log -acceptLicense
  ```
   where,
   * <responseFile> is the XML file that you edit in step 4.
   * *-log /tmp/installwl.log* is optional. It specifies a log file for the output of Installation Manager.
   * *-acceptLicense* is mandatory. It means that you accept the license terms of IBM MobileFirst Platform Foundation V8.0.0. Without that option, Installation Manager cannot proceed with the update.

## Next steps
{: #next-steps }

[Updating the application server](../appserver-update)
