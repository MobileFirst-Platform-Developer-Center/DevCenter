---
title: Migrating Applications from Parse to IBM Bluemix
date: 2016-02-05
tags:
- MobileFirst_Platform
- Bluemix
- Parse
- Migration
author:
  name: Andrew Trice
---
<img src="https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/02/curves_ahead.jpeg" style="float:right; margin-left: 10px" alt="temp_image" /> 

This week [Parse.com](http://parse.com), Facebook’s Mobile Backend as a Service offering, shocked both their customers and the development community by announcing that they are [sunsetting](http://blog.parse.com/announcements/moving-on/) the service to “focus resources elsewhere.” Luckily, they’re not leaving current customers high and dry – they are giving developers a year’s notice before the service is shut down, providing [data migration tools to MongoDB](http://blog.parse.com/announcements/introducing-parse-server-and-the-database-migration-tool/), and open-sourcing [parse-server](https://github.com/ParsePlatform/parse-server), a Parse.com API-compatible router package for Express.js on top of Node.js.
<br clear="all"/>
If you’re a Parse customer looking to move your app infrastructure to someplace secure, then you’re in luck.  Bluemix is the place for you.  In this post, I spell out the process of migrating an application from Parse.com to Bluemix. Let’s get started!

## Create your Parse-on-Bluemix application 
The first thing you need to do is create an app on [Bluemix](http://bluemix.net/?cm_mmc=developerWorks-_-dWdevcenter-_-bluemix-_-lp). If you don’t already have a Bluemix account, you can [sign up here](https://console.ng.bluemix.net/registration/?cm_mmc=developerWorks-_-dWdevcenter-_-bluemix-_-lp) (it’s free to try!).
Once you’re logged in, it’s time to create a new Node.js app on Bluemix to host the Parse server.  Click the CREATE APP button on your dashboard.

![Create app](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/01-Create-App1.jpg)

Then, when prompted, select the WEB application option. This doesn’t mean that you can’t connect a mobile app to it; this option just sets up the backend application server, without provisioning any Bluemix mobile services like [Mobile Client Access](https://www.ng.bluemix.net/docs/services/mobileaccess/index.html). The web option is used to deliver REST API calls, but does not support any enhanced mobile security or analytics features.

![Web application](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/02-web-app1.jpg)

Next you need to specify the type of application you want to create.  
Bluemix supports a variety of server-side processing options; in this case you want to select “SDK for Node.js” and then CONTINUE.

![SDK for Node.js](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/03-select-platform1_edited.jpg)

Next you are prompted to enter an application name.  Go ahead and enter one. (Application names must be unique across Bluemix.)

![Application Name](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/04-App-Name1.jpg)

When you click FINISH, the app is staged, and you are presented with instructions and next steps.  At this point, click “Overview” to go back to the app’s dashboard.

### Add the MongoDB service to your Bluemix application 
The next step is to create a MongoDB instance to migrate the data from Parse.com.  From the app’s dashboard select ADD A SERVICE OR API.

![Add a service or API](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/05-node-created1.jpg)

Scroll down to the “Data and Analytics” section and select “MongoDB by Compose” to add a MongoDB instance to your application.

![Add MongoDB by Compose](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/06-add-mongo1.jpg)

You are then presented with details for configuring a MongoDB instance.

![Mongo service](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/06.1-mongo-service1.jpg)

Open up a new browser window for the next step – leave Bluemix open, because you’re going to need to come back here to finalize the MongoDB configuration.

### Create and configure the MongoDB instance on Compose.io 
The MongoDB instance on Bluemix is available through Compose.io, a recent IBM acquisition. 

To create and configure the MongoDB instance, click on this [Compose](https://compose.io/) link and navigate to compose.io.  
If you don’t already have a Compose account, you need to create one (they’re free for 30 days!).

Once you’re logged in, click on the deployments icon (top icon on the left side) and select the MongoDB option to create a new MongoDB deployment.

![Compose new Mongo](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/07-compose-new-mongo1.jpg)

You need to specify a deployment name and region, then click “Add deployment” to create the MongoDB instance.  
For this example I created a deployment called “parse-migration”.

Next you need to create a database instance.  Once the deployment is created, click on “Add Database” and create a new database.  
In this sample I created a database called “myDatabase”.

Once the database is created, you need to add a user account to access the database.  On the database screen, select the “Users” menu option on the left side, and then click “Add User” to create a new user.

![Add user](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/08.1-add-user.jpg)

Next click on the “Admin” (gear) link on the left side to view the connection info for your database instance – you’re going to need this in the next step.

![Connection info](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/09-connection-info1.jpg)

Go back to the Bluemix MongoDB screen and specify the MongoDB host string, port, and login credentials, then click CREATE to finalize the MongoDB configuration within your Bluemix app.

![Mongo connection](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/10-mongo-connection1.jpg)

The host string is in this format: <code>server.domain:port/databaseName</code>  
For this sample app, it is: <code>candidate.63.mongolayer.com:10373/myDatabase</code>  

The port is <code>10373</code>, and the username and password are the ones for the account that was just created.

## Migrating data from Parse.com to your MongoDB instance 
At this point you’re ready to migrate data out of Parse.com, and into the MongoDB instance you just created.  Detailed instructions are available in the [Parse.com](https://parse.com/docs/server/guide#migrating) migration guide.

Log into Parse.com and select the app that you want to migrate.  Go into “App Settings”, then select “General”, and click the “Migrate” button to begin the process.

**Note:** You *must* be in the new/beta view to see this option.

![Migrate step 1](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/11-migrate1.jpg)

To begin the migration process, a modal dialog asks you to specify your database connection string. The connection string is in the format: <code>mongodb://:@server.domain:port/databaseName</code>

So, in the example app, it is: <code>mongodb://user1:password1@candidate.63.mongolayer.com:10373/myDatabase</code>

![Migrate step 2](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/12-migration21.jpg)

Click “Begin the migration”. In a few minutes the migration will complete, and you can return to your MongoDB database on Compose.io to see the migrated data.

**Note:** Migration times vary depending upon the amount of data you need to migrate.

![Compose migrate data](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/13-compose-mongo-data1.jpg)

## Configuring your Bluemix application 
Next, let’s configure some environment variables to use in the Node.js application.  
On the Bluemix app’s dashboard select the “Environment Variables” option on the left menu, then select USER-DEFINED.

![Environment variables](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/14-environment-vars1.jpg)

Add environment variables for <code>APP_ID</code>, <code>MASTER_KEY</code>, and <code>REST_KEY</code> that correspond with the App Keys from Parse.com.  Also add a <code>PARSE_MOUNT</code> key that contains the path where the services will be exposed on Node.js. For this last one, just use the value <code>/parse</code>.

On Parse.com, you can access the ID and Key values by going to the app, selecting “App Settings”, and then selecting “Security &amp; Keys”.

![Parse app keys](https://developer.ibm.com/bluemix/wp-content/uploads/sites/20/2016/01/14-parse-app-keys1.jpg)

Save these environment variables. Now we’re ready to deploy the Node.js application.

## Deploy your Bluemix application 
The [parse-server](https://github.com/ParsePlatform/parse-server) API is a router for Express.js (an application framework for Node.js).  It can be easily leveraged in a new Node.js/Express.js app, or dropped into an existing Express.js app to expose the Parse.com API. There is a [sample application](https://github.com/ParsePlatform/parse-server) in the parse-server repository that you can copy to get started.
Or, you can take the easy route. IBM Cloud Data Services Developer Advocate Mike Elsmore has put together [a base Node.js application that can be quickly deployed](https://developer.ibm.com/clouddataservices/2016/01/29/parse-on-ibm-bluemix/) that already supports the Bluemix environment configuration.

You can click the “Deploy to Bluemix” button below to deploy this project directly to Bluemix in a single click, or head over to [github.com/ibm-cds-labs/parse-on-bluemix](https://github.com/ibm-cds-labs/parse-on-bluemix) to view the source code.

![https://hub.jazz.net/deploy?repository=https://github.com/ibm-cds-labs/parse-on-bluemix](https://camo.githubusercontent.com/46f2f9aa54a26e36a277d9706cf9432297817d65/68747470733a2f2f626c75656d69782e6e65742f6465706c6f792f627574746f6e2e706e67)


If you want to deploy the application manually, then [clone](https://github.com/ibm-cds-labs/parse-on-bluemix) it to your local machine and use the [Cloud Foundry API <code>cf push</code> command](https://docs.cloudfoundry.org/devguide/installcf/whats-new-v6.html#push) to push it to Bluemix.

```bash
git clone https://github.com/ibm-cds-labs/parse-on-bluemix.git
cf push Your-App-Name-On-Bluemix
```

You application will be deployed and staged, and it’s now ready for consumption.

### Testing the deployment 
You should now test the deployment using <code>curl</code> commands from the command line to verify that the migration and deployment were successful.

```bash
curl -X GET \
  -H "X-Parse-Application-Id: PARSE_API_KEY_GOES_HERE" \
  -H "X-Parse-Master-Key: PARSE_MASTER_KEY_GOES_HERE" \
  http://parse-on-bluemix.mybluemix.net/parse/classes/GameScore
```

**Note:** the actual URL depends on your data model.

If things were successful, you should see data returned from your parse server instance:

```bash
{"results":[{"objectId":"jCtOiC18nc","createdAt":"2016-01-29T21:27:21.567Z","updatedAt":"2016-01-29T21:27:31.139Z","playerName":"Andy","score":0,"cheatMode":true}]}
```

Or you can post data to the server to test write ability:

```bash
curl -X POST \
  -H "X-Parse-Application-Id: PARSE_API_KEY_GOES_HERE" \
  -H "Content-Type: application/json" \
  -d '{"score":1337,"playerName":"Andy Trice","cheatMode":false}' \
  http://localhost:1337/parse/classes/GameScore
```

## What Next? 
If you are using Parse Cloud Code, then you can copy your Cloud Code files into the Node.js project.  (See the “cloud” directory in the git project.)

For additional details, be sure to check Parse.com’s migration guide.

### Configure the client apps 
Once you’ve stood up the new back-end system for your app(s), you’re ready to point the mobile client applications to the new back-end infrastructure. The most recent version of the [Parse.com SDK](https://parse.com/docs/downloads) introduced the ability to change the server URL (at least version 1.12 for iOS, 1.13.0 for Android, 1.6.14 for JS, 1.7.0 for .NET).

### Limitations and warnings 
Parse.com has done a great job providing you with tools to migrate your apps off their platform, but be warned – not all features of the Parse.com platform are available in the open-source parse-server.

Push notifications are not implemented. Luckily, the push notification implementation can be modified to support [IBM Bluemix’s Push notification service](https://console.ng.bluemix.net/catalog/services/ibm-push-notifications/?cm_mmc=developerWorks-_-dWdevcenter-_-bluemix-_-lp), so your app does not have to suffer loss of functionality.

In addition, Parse.com’s App Links do not have a direct replacement in the parse-server.  Many of these offerings have separate Node.js npm modules that can be leveraged, but each requires additional development effort; they are not drop-in ready.  
App settings are impacted by this transition. This includes social logins, user authentication and sessions.  App analytics, the client dashboard, in-app purchases, and jobs are also not supported.

Luckily, the [Bluemix catalog](https://console.ng.bluemix.net/catalog/?cm_mmc=developerWorks-_-dWdevcenter-_-bluemix-_-lp) has many of these features covered, plus a whole lot more.  
If you run into any cases where the parse-server seems to just “do nothing”, meaning services don’t seem to exist or they fail silently, then double-check your <code>PARSE_MOUNT</code> environment variable and MongoDB connection/host string to make sure they are in the proper formats mentioned above.

For more details on transitioning away from Parse.com, be sure to read the [sunset announcement](http://blog.parse.com/announcements/moving-on/), the [database migration tool](http://blog.parse.com/announcements/introducing-parse-server-and-the-database-migration-tool/), and [the parse-server migration guide](https://parse.com/docs/server/guide#migrating).