---
layout: tutorial
title: Licensing in MobileFirst Server
weight: 4
---
## Overview
The IBM MobileFirst Server supports two different licensing methods based on what you have purchased.

If you have purchased Perpetual licenses, you can consume what you have purchased and verify your usage and compliance through the **License tracking page** in the MobileFirst Operations Console and through [License Tracking report](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.admin.doc/admin/r_license_tracking_report.html?view=kc#r_license_tracking_report). If you have purchased Token licenses, configure your MobileFirst Server to communicate with a remote token license server.

### Token Licensing
In a token environment, every product consumes a predefined token value per license, compared to a traditional floating environment where a predefined quantity per license is consumed. The license key has a pool of tokens from which the license server calculates the tokens that are checked in and checked out. Tokens are either consumed or released when a product checks in or checks out licenses from the license server.

Your licensing contract defines whether you might be able to use token licensing, the number of tokens available, and features that are validated by tokens. See Token license validation.

If you have purchased token-based licenses, install a version of the MobileFirst Server that supports token licenses and configure your application server so that your server can communicate with the remote token server. See Installing and configuring for token licensing.

With token licensing, you can specify the license app type in the application descriptor of each one of your apps before deploying them. The license app type can be either APPLICATION or ADDITIONAL_BRAND_DEPLOYMENT. For testing, you can set the value of the license app type to NON_PRODUCTION. For more information, see Setting the application license information.

The Rational® License Key Server Administration and Reporting tool that is released with Rational License Key Server 8.1.4.9 can administer and generate reports for the license consumed by IBM MobileFirst Foundation. You can identify the relevant parts of the report by the following display names: **MobileFirst Foundation Application** or **MobileFirst Platform Additional Brand Deployment**. These names refer to the license app type for which the tokens are consumed. For more information, see [Rational License Key Server Administration](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html) and [Reporting Tool overview and Rational License Key Server Fix Pack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

For information on planning to use token licensing with MobileFirst Server, see Planning for the use of token licensing.

To obtain the license keys for IBM MobileFirst Foundation, you need to access IBM® Rational License Key Center. For more information about generating and managing your license keys, see [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).