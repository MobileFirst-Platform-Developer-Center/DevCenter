---
title: Installing and Configuring IBM Mobile Foundation server on RHEL for Power System, Big Endian
date: 2019-04-08
tags:
- Mobile_Foundation
version:
- 8.0
author:
  name: Soumya Y Shanthimohan
---

IBM Mobile Foundation v8 is now supported on Red Hat Enterprise Linux (RHEL) 7.1 for Power, [Big Endian](https://mobilefirstplatform.ibmcloud.com/blog/2019/01/28/IBM-MobileFirst-Foundation-is-now-supported-on-RHEL-Power-System-Big-Endian/) .

Below are some points worth sharing on installing Mobile Foundation server v8 on RHEL 7.1 for Power, Big Endian and configuring the same on IBM WebSphere Application Server Network Deployment (WAS ND) 8.5.5:

1.  Note that WAS ND 8.5.5 is supported on RHEL 7.1 Power System, Big Endian only from WAS ND version 8.5.5.3 onwards.  
However, while installing WAS the IM recommends you to install the latest version of WAS, which is v8.5.5.14.
2.  The Server Configuration Tool (SCT) is not supported on RHEL 7.1 for Power, Big Endian. You will have to run the [ANT tasks to configure MFP](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/production/prod-env/appserver/#installing-with-ant-tasks) .
3.  We were able to successfully deploy Mobile Foundation on WAS. However, the following error was noticed upon starting the Mobile Foundation console:

    ```
    FWLSE3030E: The runtime "mfp" does not exist in the MobileFirst administration database. The datab-ase may be corrupted 
    ```

    This issue is due to a WAS ND specific feature change in the fix packs from version 8.5.5.12 and upwards for handling SOAP    connections during communications. Following the steps in the blog and  [adding the required custom properties](https://mobilefirstplatform.ibmcloud.com/blog/2018/01/12/mfp-custom-property-setting-for-wasnd-85512/) resolved the issue.



