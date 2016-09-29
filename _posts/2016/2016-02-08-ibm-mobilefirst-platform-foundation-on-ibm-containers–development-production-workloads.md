---
title: 'IBM MobileFirst Platform Foundation on IBM Containers – development, production workloads'
date: 2016-02-08
tags:
- MobileFirst_Platform
- Bluemix
- IBM_Containers
version:
- 7.1
author:
  name: S.A.Norton Stanley
---

**What's new in MobileFirst platform v7.1?**  
The MobileFirst platform v7.1 can now be deployed and run on IBM Bluemix.

**MobileFirst platform Starter**  
The ibm-mobilefirst-starter image is a fast way to evaluate IBM MobileFirst Platform Foundation. Use this offering when you want to explore the MobileFirst platform product features without the complexity of configuring any underlying IT infrastructure.  
Know/Learn more about Starter Image here: <a href="https://www.ng.bluemix.net/docs/images/mobilefirst/index.html" target="_blank">https://www.ng.bluemix.net/docs/images/mobilefirst/index.html</a>

**MobileFirst Platform on IBM Containers**

* **Evaluation deployment?**
In case you are a developer and would like to evaluate the offering you could use the the evaluation version which can be downloaded using the following url:<a href="http://www14.software.ibm.com/cgi-bin/weblap/lap.pl?popup=Y&amp;li_formnum=L-BVID-9XEQG7&amp;accepted_url=http://public.dhe.ibm.com/ibmdl/export/pub/software/products/en/MobileFirstPlatform/mfpfcontainers/ibm-mfpf-container-7.1.0.0-eval.zip">http://www14.software.ibm.com/cgi-bin/weblap/lap.pl?popup=Y&amp;li_formnum=L-BVID-9XEQG7&amp;accepted_url=http://public.dhe.ibm.com/ibmdl/export/pub/software/products/en/MobileFirstPlatform/mfpfcontainers/ibm-mfpf-container-7.1.0.0-eval.zip</a>

Alternatively you could use the <a href="https://developer.ibm.com/mobilefirstplatform/2015/10/02/ibm-mobilefirst-platform-foundation-containers-app/">wizard based intuitive approach</a> to try the evaluation version
* **Production deployment (limited scope)?**
The production version can be downloaded from the <a href="https://www-01.ibm.com/software/passportadvantage/">IBM passport advantage</a> site.
This is a limited production support which allows to build and deploy the MFP foundation on a **<u>single instance</u>** of IBM containers. With this offering users can easily deploy their Mobile First projects onto the cloud.
* **Production deployment (broader scope)?**
The interim fix for APAR PI55391 on <a href="http://www-933.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm~Other%2Bsoftware&amp;product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&amp;release=7.1.0.0&amp;platform=All&amp;function=aparId&amp;apars=PI55391">Fix Central</a>, applied to IBM MobileFirst Platform Foundation on IBM Containers V7.1 (available from <a href="https://www-01.ibm.com/software/passportadvantage/">IBM Passport Advantage</a> site) supports IBM MobileFirst Platform Foundation to be deployed on **<u>container groups</u>**. This interim fix provides the required support for HA, security and the necessary stability needed for running production workloads for enterprises.

For details on applying the interim fix refer to <a href="https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/t_apply_interim_fix.dita?lang=en">Applying IBM MobileFirst Platform Foundation interim fixes in an IBM Containers environment</a>.

Note: The updated Prerequisites section in <a href="https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/c_advanced_user_container.html%23prereq?lang=en">IBM MobileFirst Platform Foundation on IBM Containers</a> is applicable for IBM MobileFirst Platform Foundation on IBM Containers with the interim fix for APAR PI55391. The interim fix minimizes the pre-requisite software that is required to run the MobileFirst on Bluemix, there are few pre-requisites like the ICE and MFP CLI have now been removed.

Learn more about <a href="https://www-01.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.deploy.doc/deploy/c_deploy_cloud_container.html?lang=en-us">Deploying to the cloud in an IBM Container</a>