---
layout: tutorial
title: License tracking
weight: 6
---
## Overview
License tracking is enabled by default in IBM MobileFirst Foundation, which tracks metrics relevant to the licensing policy such as active client device, addressable devices, and installed apps. This information helps determine if the current usage of IBM MobileFirst Foundation is within the license entitlement levels and can prevent potential license violations.

Also, by tracking the usage of client devices, and determining whether the devices are active, MobileFirst administrators can decommission devices that are no longer accessing the IBM MobileFirst Platform. This situation might arise if an employee leaves the company, for example.

#### Jump to

* [Setting the application license information](#setting-the-application-license-information)
* [License Tracking report](#license-tracking-report)
* [Token license validation](#token-license-validation)
* [Integration with IBM License Metric Tool](#integration-with-ibm-license-metric-tool)

## Setting the application license information
Learn how to set the application license information for the apps you register to MobileFirst Server.

License terms distinguish IBM MobileFirst Foundation, IBM MobileFirst Foundation Consumer, IBM MobileFirst Foundation Enterprise, and IBM MobileFirst Additional Brand Deployment. Set the license information of an application when you register it to a server so that license tracking reports generate the right license information. If your server is configured for token licensing, the license information is used to check out the right feature from the license server.

You set the Application Type and the Token License Type.
The possible values for Application Type are:  

* **B2C**: Use this application type if your application is licensed as IBM MobileFirst Foundation Consumer.
* **B2E**: Use this application type if your application is licensed as IBM MobileFirst Foundation Enterprise.
* **UNDEFINED**: Use this application type if you don't need to track compliance against the Addressable Device metric.

The possible values for Token License Type are:

* **APPLICATION**: Use APPLICATION for most applications. This is the default.
* **ADDITIONAL\_BRAND\_DEPLOYMENT**: Use this ADDITIONAL\_BRAND\_DEPLOYMENT if your application is licensed as IBM MobileFirst Platform Additional Brand Deployment.
* **NON_PRODUCTION**: Use NON_PRODUCTION while you are developing and testing the application on the production server. No token is checked out for applications that have a NON_PRODUCTION token license type.

> **Important:** Using NON_PRODUCTION for a production app is a breach of the license terms.

**Note:** If your server is configured for token licensing and if you plan to register an application with Token License Type ADDITIONAL_BRAND_DEPLOYMENT or NON_PRODUCTION, set the application license information before you register the first version of the application. With mfpadm program, you can set the license information for an application before any version is registered. After the license information is set, the right number of tokens is checked out when you register the first version of the app. For more information about token validation, see Token license validation.

To set the license type with IBM MobileFirst Platform Operations Console

1. Select your application
2. Select **Settings**
3. Set the **Application Type** and the **Token License Type**
4. Click **Save**

To set the license type with the mfpadm program,
Use `mfpadm app <appname> set license-config <application-type> <token license type>`

The following example sets the license information B2E / APPLICATION to the application named **my.test.application**

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## License Tracking report
IBM MobileFirst Foundation provides a license tracking report for the Client Device metric, the Addressable Device metric, and the Application metric. The report also provides historical data.

The License Tracking report shows the following data:

* The number of applications deployed in the IBM MobileFirst Platform Server.
* The number of addressable devices in the current calendar month.
* The number of client devices, both active and decommissioned.
* The highest number of client devices reported over the last n days, where n is the number of days of inactivity after which a client device is decommissioned.

You might want to analyze data further. For this purpose, you can download a CSV file that includes the license reports as well as a historical listing of license metrics.

To access the License Tracking report,

1. Open IBM MobileFirst Operations Console.
2. Click the **Hello, your-Name** menu.
3. Select **Licenses**.

To obtain a CSV file from the License Tracking report, click **Actions/Download report**.

## Token license validation
If you install and configure IBM MobileFirst Server for token licensing, the server validates licenses in various scenarios. If your configuration is not correct, the license is not validated at application registration or deletion.

### Validation scenarios
Licenses are validated in various scenarios:

#### On application registration
Application registration fails if not enough tokens are available for the token license type of your application.

> **Tip:** You can set the token license type before you register the first version of your app.

Licenses are checked only once per application. If you register a new platform for the same application, or if you register a new version for an existing application and platform, no new token is claimed.

#### On Token License Type change
When you change the Token License Type for an application, the tokens for the application are released and then taken back for the new license type.

#### On application deletion
Licenses are checked in when the last version of an application is deleted.

#### At server start
The license is checked out for every registered application. The server deactivates applications if not enough tokens are available for all applications.

> **Important:** The server does not reactivate the applications automatically. After you increase the number of available tokens, you must reactivate the applications manually. For more information about disabling and enabling applications, see [Remotely disabling application access to protected resources](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### On license expiration
After a certain amount of time, the licenses expire and must be checked out again. The server deactivates applications if not enough tokens are available for all applications.

> **Important:** The server does not reactivate the applications automatically. After you augment the number of available tokens, you must reactivate the applications manually. For more information about disabling and enabling applications, see [Remotely disabling application access to protected resources](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### At server shutdown
The license is checked in for every deployed application, during a server shutdown. The tokens are released only when the last server of a cluster of farm is shut down.

### Causes of license validation failure
License validation might fail when the application is registered or deleted, in the following cases:

* The Rational® Common Licensing native library is not installed and configured.
* The administration service is not configured for token licensing. For more information, see [Installing and configuring for token licensing](../../../installation-configuration/production/token-licensing).
* Rational License Key Server is not accessible.
* Sufficient tokens are not available.
* The license expired.

### IBM® Rational License Key Server feature name used by IBM MobileFirst Foundation
Depending on the token license type of an application, the following features are used.

| Token License Type | Feature name | 
|--------------------|--------------|
| APPLICATION        | 	ibmmfpfa    | 
| ADDITIONAL\_BRAND\_DEPLOYMENT |	ibmmfpabd | 
| NON_PRODUCTION	| (no feature) | 

## Integration with IBM License Metric Tool
The IBM® License Metric Tool allows you to evaluate your compliance with your IBM license.

If you have not installed a version of IBM License Metric Tool that supports IBM Software License Metric Tag or SWID (software identification) files, you can review the license usage with the License Tracking reports in MobileFirst Operations Console. For more information, see [License Tracking report](#license-tracking-report).

### About PVU-based licensing using SWID files
If you have purchased IBM MobileFirst Foundation Extension V8.0.0 offering, it is licensed under the Processor Value Unit (PVU) metric.

The PVU calculation is based on IBM License Metric Tool's support for ISO/IEC 19970-2 and SWID files. The SWID files are written to the server when the IBM Installation Manager installls MobileFirst or MobileFirst Analytics Server. When the IBM License Metric Tool discovers an invalid SWID file for a product according to the current catalog, a warning sign is displayed on the Software Catalog widget. For more information on how the IBM License Metric Tool works with SWID files, see [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html).

The number of Application Center installations is not limited by PVU-based licensing.

The PVU license for Foundation Extension can only be purchased together with these product licenses: IBM WebSphere® Application Server Network Deployment, IBM API Connect™ Professional, or IBM API Connect Enterprise. IBM Installation Manager adds or updates the SWID file to be used by the License Metric Tool. For more information on IBM MobileFirst Foundation Extension, see [https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN).

For more information on PVU licensing see [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html).

### SLMT tags
IBM MobileFirst Foundation generates IBM Software License Metric Tag (SLMT) files. Versions of IBM License Metric Tool that support IBM Software License Metric Tag can generate License Consumption Reports. Read this section to interpret these reports for MobileFirst Server, and to configure the generation of the IBM Software License Metric Tag files.

Each instance of a running MobileFirst runtime environment generates an IBM Software License Metric Tag file. The metrics monitored are `CLIENT_DEVICE`, `ADDRESSABLE_DEVICE`, and `APPLICATION`. Their values are refreshed every 24 hours.

#### About the CLIENT_DEVICE metric
The `CLIENT_DEVICE` metric can have the following subtypes:

* Active Devices

    The number of client devices that used the MobileFirst runtime environment, or another MobileFirst runtime instance belonging to the same cluster or server farm, and that were not decommissioned. For more information about decommissioned devices, see [Configuring license tracking for client device and addressable device](../../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

* Inactive Devices

    The number of client devices that used the MobileFirst runtime environment, or another MobileFirst runtime instance belonging to the same cluster or server farm, and that were decommissioned. For more information about decommissioned devices, see [Configuring license tracking for client device and addressable device](../../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

The following cases are specific:

* If the decommissioning period of the device is set to a small period, the subtype "Inactive Devices" is replaced by the subtype "Active or Inactive Devices".
* If device tracking was disabled, only one entry is generated for `CLIENT_DEVICE`, with the value 0, and the metric subtype "Device Tracking Disabled".

#### About the APPLICATION metric
The APPLICATION metric has no subtype unless the MobileFirst runtime environment is running in a development server.

The value reported for this metric is the number of applications that are deployed in the MobileFirst runtime environment. Each application is counted as one unit, whether it is a new application, an additional brand deployment, or an additional type of an existing application (for example native, hybrid, or web).

#### About the ADDRESSABLE_DEVICE metric
The ADDRESSABLE_DEVICE metric has the following subtype:

* Application: `<applicationName>`, Category: `<application type>`

The application type is **B2C**, **B2E**, or **UNDEFINED**. To define the application type of an application, see [Setting the application license information](#setting-the-application-license-information).

The following cases are specific:

* If the decommissioning period of the device is set to less than 30 days, the warning "Short decommissioning period" is appended to the subtype.
* If license tracking was disabled, no addressable report is generated.

For more information about configuring license tracking using metrics, see

* [Configuring license tracking for client device and addressable device](../../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [Configuring IBM License Metric Tool log files](../../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
