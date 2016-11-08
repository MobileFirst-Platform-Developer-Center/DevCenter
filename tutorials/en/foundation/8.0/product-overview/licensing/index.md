---
layout: tutorial
title: Licensing in MobileFirst Server
weight: 4
---
## Overview
The IBM MobileFirst Server supports two different licensing methods based on what you have purchased.

If you have purchased Perpetual licenses, you can consume what you have purchased and verify your usage and compliance through the **License tracking page** in the MobileFirst Operations Console and through [License Tracking report](../../administering-apps/license-tracking/#license-tracking-report). If you have purchased Token licenses, configure your MobileFirst Server to communicate with a remote token license server.

### Application or Addressable Device licenses
If you have purchased Application or Addressable Device licenses, you can consume what you have purchased and verify your usage and compliance through the License tracking page in the MobileFirst Operations Console and through License Tracking report.

### Processor value unit (PVU) licensing
Processor value unit (PVU) licensing is available if you have purchased IBM MobileFirst Foundation Extension (see http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument), but only after the purchase of IBM  WebSphere  Application Server Network Deployment, IBM API Connect™ Professional, or IBM API Connect Enterprise.

The PVU license pricing structure is responsive to both the type and number of processors that are available to installed products. Entitlements can be full capacity or subcapacity. Under the processor value unit licensing structure, you license software based on the number of value units assigned to each processor core.

For example, processor type A is assigned 80 value units per core and processor type B is assigned 100 value units per core. If you license a product to run on two type A processors, you must acquire an entitlement for 160 value units per core. If the product is to run on two type B processors, the required entitlement is 200 value units per core.

> [Read more information](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html) on PVU licensing.

### Token Licensing
In a token environment, every product consumes a predefined token value per license, compared to a traditional floating environment where a predefined quantity per license is consumed. The license key has a pool of tokens from which the license server calculates the tokens that are checked in and checked out. Tokens are either consumed or released when a product checks in or checks out licenses from the license server.

Your licensing contract defines whether you might be able to use token licensing, the number of tokens available, and features that are validated by tokens. See Token license validation.

If you have purchased token-based licenses, install a version of the MobileFirst Server that supports token licenses and configure your application server so that your server can communicate with the remote token server. See Installing and configuring for token licensing.

With token licensing, you can specify the license app type in the application descriptor of each one of your apps before deploying them. The license app type can be either APPLICATION or ADDITIONAL_BRAND_DEPLOYMENT. For testing, you can set the value of the license app type to NON_PRODUCTION. For more information, see Setting the application license information.

The Rational  License Key Server Administration and Reporting tool that is released with Rational License Key Server 8.1.4.9 can administer and generate reports for the license consumed by IBM MobileFirst Foundation. You can identify the relevant parts of the report by the following display names: **MobileFirst Foundation Application** or **MobileFirst Platform Additional Brand Deployment**. These names refer to the license app type for which the tokens are consumed. For more information, see [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) and [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

For information on planning to use token licensing with MobileFirst Server, see Planning for the use of token licensing.

To obtain the license keys for IBM MobileFirst Foundation, you need to access IBM  Rational License Key Center. For more information about generating and managing your license keys, see [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).