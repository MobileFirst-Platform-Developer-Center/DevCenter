---
title: 'Building charts for Adapter analytics using IBM Bluemix Mobile Analytics service and IBM Mobile Foundation Service'
date: 2017-04-26
tags:
- MobileFirst_Foundation
- Bluemix
- Analytics
version:
- 8.0
author:
  name: Parvathy Unnikrishnan
---

# Overview

IBM Mobile Foundation Service can be configured to connect to IBM® Mobile Analytics for Bluemix® service to pump the analytics events and logs. Currently the Mobile Analytics service doesn’t support out-of-the-box Mobile Foundation Service specific features like custom charts and adapter analytics.  However, there is an approach where you can exploit the ’Db2 Warehouse export’ option of the Mobile Analytics service and achieve the building and viewing of Custom charts or analytics for Mobile Foundation Adapters.

This blog details this approach of building adapter analytics using Mobile Analytics service and Mobile Foundation leveraging the Db2 Warehouse on Cloud service capabilities for charting. You can use the Mobile Foundation server installed on your on-premises environment or quickly configure a Foundation server on Bluemix using the IBM Mobile Foundation service. We will use the Mobile Foundation service on Bluemix in this blog.

### Prerequisite:
Log in to IBM Bluemix and create a Mobile Foundation service.

## Create BMS Analytics service in IBM Bluemix and configure Mobile Foundation service instance with it.
[See Details](https://mobilefirstplatform.ibmcloud.com/blog/2016/07/11/analytics-bm-service/)

## Exporting analytics data from Mobile Analytics service to ‘Db2 Warehouse on Cloud’ service.

- Launch Console from Mobile foundation service and open Analytics service console from there.
- On the left side click on **Db2 Warehouse** under Export.
- This enables the analytics data export to Db2 Warehouse.
- Follow the steps as listed there and click on **Create Db2 Warehouse**. This takes you to the Bluemix Db2 Warehouse service creation page; choose the **IBM Db2 Warehouse on Cloud Entry** plan and create the instance.

  ![Db2 Warehouse Export page]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/db2-warehouse-export-page.png)
- Go to Service Credentials tab and click on **New credential**. Click on Add to create a new credential for Db2 Warehouse.
- Under Actions, click on View credentials and copy the credential details to clipboard (use the copy to clipboard button on the right.)
- Go back to Mobile Analytics console, select Db2 Warehouse under Export and go to the second step in "Set Up Export" page.  Here paste the Db2 Warehouse credentials that you had copied earlier into the clipboard and click on Submit.
- On submission, the view displays the export enabled page which details the DB schema and tables that would be created in Db2 Warehouse.

  ![Db2 Warehouse Export schema]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/db2-warehouse-export-schema.png)
- Add some adapter calls in a mobile app using the Mobile First SDK. A sample code snippet for the same from android is given below.


  ```
  private void callAdapter(){
        URI adapterPath = null;
        try {
            adapterPath = new URI("/adapters/javaAdapter/resource/unprotected");
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }

        WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);

        request.send(new WLResponseListener() {
            @Override
            public void onSuccess(WLResponse wlResponse) {
                // Will print "Hello world" in LogCat.
                Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
            }

            @Override
            public void onFailure(WLFailResponse wlFailResponse) {
                Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
            }
        });
    }
    ```
- Register the app to connect to the Mobile foundation service and trigger the custom events from mobile application. Check the analytics screens in the Mobile Analytics console. See the custom data sent under Troubleshooting > App Log Search.
- Now from Bluemix Dashboard, select the Db2 Warehouse on Cloud service which will open its service console.  On the console, click on Open. This opens the Db2 Warehouse with the DB schema that has been created for Mobile Analytics.
- Click on Explore on the top of the page. The DB schema name can be found from the Db2 Warehouse credentials which is used for Mobile Analytics. Click on the DB schema name. Here all tables should get listed as shown below. Click on a table to see the table description.

  ![Db2 Warehouse Tables]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/db2-warehouse-tables.png)

- Click of View Data below the table description to see the table contents.

  ![Db2 Warehouse Table Contents]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/db2-warehouse-table-content.png)

## Creating and running R script to plot adapter analytics charts in Db2 Warehouse on Cloud

Now that we have successfully exported the analytics data to DB2 Warehouse we shall now chart them.

- Choose NETWORKTRANSACTION table and click on Browse Data tab to see that all the adapter calls sent from Mobile Analytics is available here in columns like ADAPTERNAME, PROCEDURENAME etc.
- Db2 Warehouse on cloud comes with R studio where the R scripts can be run to create charts.
- Click on **Analyze > Launch R studio**. The login credentials for R studio is the `<username>` and `<password>` in the service credentials of Db2 Warehouse which was created above.
- R studio has a mainly four windows. Click on + on the top left and choose R script.
- Under the Script area add your R script and Save the same as below.

  ![R script]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/r-script-screen.png)

## R Script to plot number of adapter requests

- R-script below can be used to plot number of adapter requests. Change the Db2 Warehouse schema name with yours.

  ```
  ########### R script for displaying MFP number of adapter calls made. ###############

  library(ibmdbR)

  con <- idaConnect("BLUDB","","")
  idaInit(con)

  df <- as.data.frame(ida.data.frame('DASH6690.NETWORKTRANSACTION')[,c("ADAPTERNAME")])

  nrow(df)
  ncol(df)
  dfrm <-table(df[,c(1)])
  jpeg(type='cairo',"adapter-requests.jpg",width=700,height=500)
  sink('/dev/null')
  barplot(dfrm, main="Bar chart of adapter requests",legend = rownames(dfrm), beside=TRUE,col=rainbow(7))
  dev.off()
  sink()

  idaClose(con)
  ```
- To run the complete script, in the scripting window select all the content and click Run.
- Once run successfully, it creates the chart image as _'adapter-requests.jpg'_ under Files tab in the bottom right window as shown in the above screenshot.
- Click on the picture to see the chart.
- See the Console window for any errors.
- Further details of R studio usage can be found in R studio Help.

  ![Adapter Requests]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/adapter-requests.png)

## R script to plot the response time of adapter calls

- R-script below can be used to plot adapter response time. Change the Db2 Warehouse schema name with yours.

  ```
  ########### R script for displaying MFP adapter response time ###############

  library(ibmdbR)
  library(ggplot2)

  con <- idaConnect("BLUDB","","")
  idaInit(con)

  df <- idaQuery("SELECT  t1.TIMESTAMP,t1.SERVERPROCESSINGTIME,t1.ADAPTERNAME FROM DASH6690.NETWORKTRANSACTION t1 where t1.ADAPTERNAME is not null order by t1.TIMESTAMP",as.is=F)

  jpeg(type='cairo',"adapter-response-time.jpg",width=700,height=500)
  sink('/dev/null')

  ggplot(df, aes(x=TIMESTAMP, y=SERVERPROCESSINGTIME)) +
  geom_point(aes(col=ADAPTERNAME), size=3) +
  labs(title="Adapter Response Time", y="Server Processing Time (ms)", x="Adapter request time")

  dev.off()
  sink()
  idaClose(con)
  ```
- Once run successfully, it creates the chart image as _'adapter-requests.jpg'_ under Files tab in the bottom right window as shown in the above screenshot.

  ![Adapter Response Time]({{site.baseurl}}/assets/blog/2017-04-26-adapter-analytics-using-analytics-and-dashdb-analytics-service/adapter-response-time.png)
