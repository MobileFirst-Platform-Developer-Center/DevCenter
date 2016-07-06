---
title: How to update the JRE related security files on IBM MobileFirst Foundation on Bluemix
date: 2016-03-21
tags:
- MobileFirst_Platform
- Bluemix
- IBM_Containers
version:
- 7.1
author:
  name: Srikanth K Murali
---

This post provides the steps to follow if you are facing JRE security related errors while using the IBM MobileFirst Platform Foundation on Bluemix.

The common error messages that you might encounter are as below:

* java.lang.SecurityException: SHA1 digest error for default_local.policy
* javax.net.ssl.SSLKeyException: RSA premaster secret error
* Illegal key size or default parameters

The JRE is normally bundled with the default JCE security policy files and you need to update the JRE with the unrestricted policy files to fix the above errors.

Follow the below steps to update the JRE security policy files on IBM MobileFirst Platform Foundation on Bluemix:

* Download the Unrestricted SDK JCE policy files for Java 7 [from here](https://www-01.ibm.com/marketing/iwm/iwm/web/preLogin.do?source=jcesdk&lang=en_US). The zip file contains 2 jar files – local_policy.jar and US_export_policy.jar

* If you are using the [IBM MobileFirst Foundation on Bluemix offering](https://developer.ibm.com/mobilefirstplatform/documentation/getting-started-7-1/bluemix/run-foundation-on-bluemix/), then copy the policy jar files into the mfpf-server/usr/jre-security folder and build the image using the prepareserver.sh script file. The image will be updated with the unrestricted JCE policy file.

* If you are using the ibm-mobilefirst-starter image from IBM Containers registry, follow the next steps. Copy the jar files to a file sharing location so that it can be accessed from with the mobilefirst-starter container.

* Install the [Cloudfoundry command line tool](https://github.com/cloudfoundry/cli/releases) (cf) and the [cf ic](https://console.ng.bluemix.net/docs/containers/container_cli_cfic.html) plug-in.

* Login to the IBM containers using cf login and cf ic login commands.

* Login to the container using the command `cf ic exec -it <container_id> bash`. You can find the container id using the `cf ic ps` command.

* Once you are inside the container’s terminal, you can download the policy files from the file-sharing location using the `curl` commands.

* Copy the policy jar files to the following location : /opt/ibm/java/jre/lib/security/. You might want to backup the existing jar files before performing the copy.

* Restart the container for the new security policy to take effect.