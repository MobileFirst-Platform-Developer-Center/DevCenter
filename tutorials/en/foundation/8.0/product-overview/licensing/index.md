---
layout: tutorial
title: Licensing in MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
The IBM {{ site.data.keys.mf_server }} supports two different licensing methods based on what you have purchased.

If you have purchased Perpetual licenses, you can consume what you have purchased and verify your usage and compliance through the **License tracking page** in the {{ site.data.keys.mf_console }} and through [License Tracking report](../../administering-apps/license-tracking/#license-tracking-report). If you have purchased Token licenses, configure your {{ site.data.keys.mf_server }} to communicate with a remote token license server.

### Application or Addressable Device licenses
{: #application-or-addressable-device-licenses }
If you have purchased Application or Addressable Device licenses, you can consume what you have purchased and verify your usage and compliance through the License tracking page in the {{ site.data.keys.mf_console }} and through License Tracking report.

### Virtual Processor Cores (VPC Licensing)
{: #vpc-licensing}

Mobile Foundation is also available with capacity-based licensing called Virtual Processor Cores (VPC). VPC is a unit of measurement that is used to determine the licensing cost for Mobile Foundation and is based on the number of cores that are available. Currently, this metric is available only for Cloud Pak for Applications.

The features of this metric are as follows,

* Clients can run any number of applications and devices. Hence this form of license would be beneficial compared to Application license in scenarios where customers have many apps in their deployment.

* Aligned with other products in the portfolio and provide flexibility to clients for hybrid cloud deployments.


### Token Licensing
{: #token-licensing }
In a token environment, every product consumes a predefined token value per license, compared to a traditional floating environment where a predefined quantity per license is consumed. The license key has a pool of tokens from which the license server calculates the tokens that are checked in and checked out. Tokens are either consumed or released when a product checks in or checks out licenses from the license server.

Your licensing contract defines whether you might be able to use token licensing, the number of tokens available, and features that are validated by tokens. See Token license validation.

If you have purchased token-based licenses, install a version of the {{ site.data.keys.mf_server }} that supports token licenses and configure your application server so that your server can communicate with the remote token server. See Installing and configuring for token licensing.

With token licensing, you can specify the license app type in the application descriptor of each one of your apps before deploying them. The license app type can be either APPLICATION or ADDITIONAL_BRAND_DEPLOYMENT. For testing, you can set the value of the license app type to NON_PRODUCTION. For more information, see Setting the application license information.

The Rational License Key Server Administration and Reporting tool that is released with Rational License Key Server 8.1.4.9 can administer and generate reports for the license consumed by {{ site.data.keys.product }}. You can identify the relevant parts of the report by the following display names: **MobileFirst Platform Foundation Application** or **MobileFirst Platform Additional Brand Deployment**. These names refer to the license app type for which the tokens are consumed. For more information, see [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) and [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

For information on planning to use token licensing with {{ site.data.keys.mf_server }}, see Planning for the use of token licensing.

To obtain the license keys for {{ site.data.keys.product }}, you need to access IBM  Rational License Key Center. For more information about generating and managing your license keys, see [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).
