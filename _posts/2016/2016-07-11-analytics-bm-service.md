---
title: Configuring Mobile Analytics and Mobile Foundation Bluemix services
date: 2018-05-17
tags:
- MobileFirst_Foundation
- Mobile_Foundation
- Mobile_Analytics
- Analytics
- Bluemix
- IBM_Cloud
- IBM_Cloud_Private

version:
- 8.0
author:
  name: Ajay Chebbi
additional_authors:
- John Gerken
---
> **Note:** Updated for changes after Mobile Analytics service went GA.
>
> **Note:** Updated May 15, 2018 for changes to the {{ site.data.keys.prod_ic }} and {{ site.data.keys.mf_analytics_service }} service user interfaces.

## Overview

{: #overview }
When {{ site.data.keys.product_full }} {{ site.data.keys.product_V_R }} was released, it supported deployment as a service in IBM Cloud in addition to it's traditional on-premises deployment model.  The simplest way to provision an instance of [{{ site.data.keys.product }}](https://console.bluemix.net/catalog/services/mobile-foundation) by far is to use the new service that is available in the IBM Cloud catalog, which can be deployed to both [{{ site.data.keys.prod_ic }}](https://console.bluemix.net/) and [{{ site.data.keys.prod_icp }}](https://www.ibm.com/cloud/private) environments. This service provides all the capabilities that you need to build secure mobile apps using any technology you choose to run on all of the popular mobile operating systems.

However a new IBM Cloud service called [{{ site.data.keys.mf_analytics_service }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/04/30/mobile-analytics-for-bluemix-service/) was launched in April and has since been released for production use.  {{ site.data.keys.mf_analytics_service }} provides organizations valuable insights beyond the the {{ site.data.keys.mf_analytics_short }} functionality packaged with {{ site.data.keys.product }}.  It provides a 360 degree view of mobile applications running on customer devices, including developer statistics and application analytics such as how many devices have connected, the distribution of operating systems used, crash reports, and much more.  My personal favourite?  Client side developer logs. This is how I get to know if the code is falling into catch blocks where "you should never be here!" messages tend to occur -- especially when the application is running on a user's phone!  We know all too well the app performs at its best when running on the developers device! ;-)

Though the {{ site.data.keys.mf_analytics_service }} service is advertised (and [documented](https://new-console.ng.bluemix.net/docs/services/mobileanalytics/index.html)) to be used only with its own client side SDKs, you can also connect it to a {{ site.data.keys.mf_server }} (either running on-premises or in the Cloud) so that analytics data collected by {{ site.data.keys.product }} is pumped to this service! The {{ site.data.keys.product }} SDK that you install as part of integrating an application with {{ site.data.keys.product }} is enough to generate the analytics data - no additional SDK is required.

If you are familiar with the analytics features of {{ site.data.keys.product }}, you will see the similiarities. Let's see how you can configure a {{ site.data.keys.product }} server to send analytics data to the IBM Cloud {{ site.data.keys.mf_analytics_service }} service.


## Create an instance of the {{ site.data.keys.mf_analytics_service }} service

{: #create-analytics-instance }
Login to your [IBM Cloud](https://console.bluemix.net/) account and click on **Catalog** in the upper right of the menu bar.  Then in the left hand menu under **Platform**, click **Mobile**.  In this section of the catalog you should see an entry for the "{{ site.data.keys.mf_analytics_service }}" service. ![Mobile Analytics Tile]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/MobileAnalyticsServiceTile.png "Mobile Analytics Tile") Click on it, then give it a name (if you wish).  Select a pricing plan (the "Lite" version is free) and click the **Create** button to build your new instance.  A **Getting started** page will then be displayed describing the steps required to use the service with the {{ site.data.keys.mf_analytics_service }} service's SDK.  We'll skip that for now, since we are attaching this service to {{ site.data.keys.product }}.

To continue configuring your service, first click **Manage** then **CONFIGURE**.  Slide the **Demo Mode** button on the right to off.
![Disable Demo Mode]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/DisableDemoMode.png "Disable Demo Mode")
Now we need to create secure credentails for your service.  So in the left hand menu select **Service Credentials**, then press the **New credential** button.
![Create New Credentials]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/CreateNewCredentials.png "Create New Credentials")
On the resulting dialog just click the **Add** button to complete the process and you'll be returned to the Service credentials page where a new line now exists in your Service credentials table. ![New Credentials]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/NewCredentials.png "New Credentials")

To display the credentials, click the **View credentials** down arrow.  You'll see some JSON text that contains your API Key and secret.  Copy this text to a safe place because you will need this later.

```json
{
  "apiKey": "your API key",
  "secret": "your super secret"
}
```

## Create an instance of {{ site.data.keys.mf_bm }}

{: #create-foundation-instance }
If you don't already have an on-premises installation of {{ site.data.keys.product }}, you can create a free instance on IBM Cloud.  To do so, go back to the catalog and in the "Mobile" section locate the "{{ site.data.keys.product }}" service tile.  ![Mobile Foundation Tile]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/MobileFoundationServiceTile.png "Mobile Foundation Tile")

As before, click on the tile, change the name if you wish, pick a plan (Developer is free), and click **Create** at the bottom of the page.  Once the server has started the {{ site.data.keys.mf_console }} is displayed.  ![Mobile Foundation Console]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/MobileFoundationConsole.png "Mobile Foundation Console")

The next step is to configure your {{ site.data.keys.product }} instance.  To do so, return to your dashboard by clicking the **{{ site.data.keys.prod_ic }}** graphic in the upper left of the screen.  Then under **Cloud Foundry Applications**, locate the row containing your {{ site.data.keys.product }} instance.  It will have the string **-Server** appended to the name.  This application is the runtime environment (Liberty server and Java BuildPack) that the {{ site.data.keys.product }} Server requires to run.  Therefore, it is here that you configure the {{ site.data.keys.prod_was_liberty_short }} server.
![Mobile Foundation Cloud Foundry App]({{site.baseurl}}/assets/blog/2018-05-17-analytics-bm-service/MobileFoundationCFApp.png "Mobile Foundation Cloud Foundry App")

Click the {{ site.data.keys.product }} instance under Cloud Foundry Applications to display the Overview page, then click **Runtime**.  On the Runtime page, select the **Environment variables** tab and scroll down to the **User defined** section at the bottom of the page.  Here is where we set the variables that will tell Mobile Foundation to send analytics data to our {{ site.data.keys.mf_analytics_service }} service.

Change the following variable values:

1. Change the value of `BMS.ANALYTICS.APIKEY` to be the apiKey parameter from the {{ site.data.keys.mf_analytics_service }} service credentials JSON text that you copied earlier.

2. Change the value of `MFP.ANALYTICS.URL` to be `https://mobile-analytics-dashboard.ng.bluemix.net/analytics-service/rest`.

3. Optionally change the value of `MFP.ANALYTICS.CONSOLE.URL` to be `https://console.ng.bluemix.net/mobile/analytics/users?instanceId=<\your-instance-id-here>` Be sure to replace the `<\your-instance-id-here>` with the instance ID of your {{ site.data.keys.mf_analytics_service }} service. To find the instance ID, open your {{ site.data.keys.mf_analytics_service_console }}, then look at the URL in your browser.  The instance ID is the part of the URL between `mobile-analytics-prod/` and the `?`(`https://console.ng.bluemix.net/services/mobile-analytics-prod/<your-instance-id>?<more stuff>`)  - This is needed only if you want a direct link from the {{ site.data.keys.product }} {{ site.data.keys.mf_console_short }} to the {{ site.data.keys.mf_analytics_service_console }}.

## Configure an on-premises instance of the {{ site.data.keys.product }} Server

{: #configure-on-prem-instance }

If your {{ site.data.keys.product }} instance is running on-premises, then you need to make similar changes to the JNDI properties in that environment.  If your {{ site.data.keys.product }} Server is running {{ site.data.keys.prod_was_liberty_short }}, then the JNDI properties need to be set in the server.xml file.

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value=" https://mobile.ng.bluemix.net/imfanalyticsdashboard?instanceId=your-instance-id-here"/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value="https://mobile-analytics-dashboard.ng.bluemix.net/analytics-service/rest"/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/bms.analytics.apikey" value="your analytics api key"/>
```

If the server is running on {{ site.data.keys.prod_was_nd }}, then the JNDI properties need to be set in the {{ site.data.keys.product }} Runtime web application.  To set these open the {{ site.data.keys.prod_was_nd }} administration console.  Then go to **Applications → Application Types → WebSphere enterprise applications → MobileFirst Runtime → Environment entries for Web modules**.  Then set the following properties as follows:

```text
mfp.analytics.console.url = https://mobile.ng.bluemix.net/imfanalyticsdashboard?instanceId=your-instance-id-here
mfp.analytics.url = https://mobile-analytics-dashboard.ng.bluemix.net/analytics-service/rest
bms.analytics.apikey = <your analytics api key>
```

Now restart your {{ site.data.keys.product }} server and once it restarts, it should begin sending data to your {{ site.data.keys.mf_analytics_service }} service.

## Deploy {{ site.data.keys.product }} Server to {{ site.data.keys.prod_ic }} preconfigured to use the {{ site.data.keys.mf_analytics_service }} service using IBM provided scripts

{: #preconfigure-foundation }
{{ site.data.keys.product }}, deployed using scripts, can also be connected to an {{ site.data.keys.mf_analytics_service }} service by adding the JNDI properties present in the `mfpf-server-libertyapp/usr/config/mfpfproperties.xml`.

Add the following JNDI properties in the above mentioned xml file:

```xml
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.console.url" value=" https://mobile.ng.bluemix.net/imfanalyticsdashboard?instanceId=your-instance-id-here"/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/mfp.analytics.url" value="https://mobile-analytics-dashboard.ng.bluemix.net/analytics-service/rest"/>
<jndiEntry jndiName="${env.MFPF_RUNTIME_ROOT}/bms.analytics.apikey" value="your analytics api key"/>
```

After adding the properties deploy the {{ site.data.keys.product }} server using the scripts.
In order to deploy the {{ site.data.keys.product }} server follow the steps given [here](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-using-scripts-lbp/#mobilefirst-server).

## Gathering Analytics data

{: #gather-analytics }
Once you start using applications connected to the {{ site.data.keys.product }} server instance - the analytics data starts getting published to the {{ site.data.keys.mf_analytics_service }} service. If you want to see more in the analytics service - please leave a comment at the bottom of the [analytics announcement article](https://mobilefirstplatform.ibmcloud.com/blog/2016/04/30/mobile-analytics-for-bluemix-service/) .

## Troubleshooting

{: #troubleshooting }
<div class="panel panel-default">
  <div class="panel-heading"><h4>"CWPKI0022E: SSL HANDSHAKE FAILURE" displayed in server console or log files.</h4></div>
  <div class="panel-body">
    <p>If your {{ site.data.keys.product }} Server's keystore does not include the intermediate or root certificate for {{ site.data.keys.prod_ic }}, you may see the following error message in either the server's console or in the server's log files:</p>
    <blockquote>
    [ERROR   ] CWPKI0022E: SSL HANDSHAKE FAILURE:  A signer with SubjectDN CN=*.ng.bluemix.net, O=International Business Machines Corporation, L=Armonk, ST=New York, C=US was sent from the target host.  The signer might need to be added to local trust store /Users/john_gerken/MobileFirst-8.0.0.0/mfp-server/usr/servers/mfp/resources/security/key.jks, located in SSL configuration alias defaultSSLConfig.  The extended error message from the SSL handshake exception is: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
    </blockquote>

    <p>this indicates that the {{ site.data.keys.prod_ic }} root or intermediate certificate needs to be added to the [{{ site.data.keys.product }} Server's keystore](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/configuring-the-mobilefirst-server-keystore/).  To add the two certificates, do the following:</p>

    <ol>
      <li>Retrieve the intermediate and root certificates from {{ site.data.keys.prod_ic }} using the browser of your choice.  Before proceeding you should have two files on your filesystem: DigiCertSHA2SecureServerCA.crt and DigiCertGlobalRootCA.crt.</li>
      <li>Locate your keystore.  By default the keystore is named "key.jks" and can be found in your deployed server's "./mfp/resources/security" directory.</li>
      <li>Use the keytool (or similar utility) to add the intermediate and root certificate to your keystore.  For example: <blockquote>keytool -importcert -alias &lt;Certificate Name&gt; -file &lt;path to certificate file&gt; -trustcacerts -storetype JKS -keystore &lt;path to key.jks file&gt; -storepass &lt;key.jks password&gt;</blockquote></li>
    </ol>
  </div>
</div>