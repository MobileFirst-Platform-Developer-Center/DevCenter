---
title: 'Beacon Support in IBM MobileFirst Foundation Bluemix Service'
date: 2017-05-09
tags:
- MobileFirst_Foundation
- Bluemix
- Beacons
version:
- 8.0
author:
  name: Parvathy Unnikrishnan
additional_authors:
 - Shiva Kumar H R
---

## Beacon support in IBM MobileFirst 7.1

IBM MobileFirst Platform Foundation (MFP) 7.1 has the in-built support for beacons and the beacon objects and the triggers were stored in the MFP database. MobileFirst Administration Service REST APIs were made available to register the beacons, trigger, and establish the association between them.

Details of the same can found at [Working with Beacons in 7.1](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/7.1/advanced-topics/working-with-beacons/)

## Enabling Beacon Support in MobileFirst 8.0

### Overview

IBM MobileFirst Platform Foundation (MFP) 8.0 does not have the built-in support for beacon and MobileFirst Administration service does not expose any REST API which can be used to register the beacons, triggers etc., in the MobileFirst database.

This section covers on how customer can extend MobileFirst Platform for beacon support.
In IBM MobileFirst Foundation 8.0, the beacon capability can be made available through a MobileFirst adapter which can be connected to any backend service, which stores the beacon data.  The adapter connects to the chosen backend database to retrieve the beacons, triggers and associations.

The following topics are covered for extending beacon support in MFP 8.0

1.	Backend service for beacon data store.
2.	Create Mobile Foundation service on Bluemix.
3.	Beacon Adapter
4.	Connecting adapter to beacon data store.
5.	Client side API

### Backend service for beacon data store

Any database can be chosen by the customer for enabling beacon data persistence. This blog demonstrates IBM Cloudant NoSQL service on Bluemix as the beacon database. When the user opens the app, in the background it connects to MobileFirst server and makes the adapter calls to retrieve the beacon data and makes it available in the mobile device.

The following section explains how to create the Cloudant service in Bluemix, and the documents for beacons, triggers and associations. 
The example demonstrates beacon placement inside branches of a bank.

 Log-in to [Bluemix](https://console.bluemix.net).

#### Create Cloudant service on Bluemix

Beacon definitions are stored in DB in the following format, of which *_id* field is auto populated by Cloudant service.

```
{
"_id": "<Cloudant document id>",
"uuid": "<your_beacon_uuid>",
"major": <your_major_id>,
"minor": <your_minor_id>,
"customData": {
  "name": "value"
  }
}
```

- Click on **Catalog**
- Search for and select **Cloudant NoSQL DB**
- Click on **Create**
- Click on **Launch** to open Cloudant Dashboard

##### Create database for storing beacon data

- Click on **Databases**
- Click on **Create Database**
- Name it *beacons*
- Click on **+** icon and select **New Doc**

A sample new document looks as below which has an *_id* field.

```
{
  "_id": "da8df0a4ffa062ce8749db5d883c7c7b"
}
```

- Add following data corresponding to beacon-1 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 57388,
  "minor": 50057,
  "customData": {
   "branchName": "Indiranagar, Bangalore"
  }
```
- Change UUID, major and minor numbers to correspond to your beacon
- Click on **Create document**
- Click on **+** icon
- Add following data corresponding to beacon-2 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 56179,
  "minor": 406,
  "customData": {
   "branchName": "Koramangala, Bangalore"
   }
```

- Change UUID, major and minor numbers to correspond to your beacon
- Click on **Create document**

##### Create database for storing trigger information

- Click on **Databases**
- Click on **Create Database**
- Name it *triggers*
- Click on **+** icon and select **New Doc**
- Add the following data corresponding to trigger-1 after *_id*

```
, "triggerName": "entryIntoBranch",
  "triggerType": "Enter",
  "proximityState": "Near",
  "actionPayload": {
   "alert": "Welcome to $branchName branch of IMF Bank"
  }
```
- Change triggerName, triggerType, proximityState and alert to suit your needs
- Click on **Create document**
- Click on **+** icon
- Add the following data corresponding to trigger-2 after *_id*

```
, "triggerName": "exitFromBranch",
  "triggerType": "Exit",
  "proximityState": "Far",
  "actionPayload": {
   "alert": "Thank you for visiting our $branchName branch. Have a nice day!"
  }

```
- Change triggerName, triggerType, proximityState and alert to suit your needs
- Click on **Create document**

##### Create database for storing mapping between beacons and triggers

- Click on **Databases**
- Click on **Create Database**
- Name it *beacon-trigger-associations*
- Click on *+* icon and select **New Doc**
- Add the following data corresponding to mapping between beacon-1 and trigger-1 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 57388,
  "minor": 50057,
  "triggerName": "entryIntoBranch"
```

- Change uuid, major & minor numbers and triggerName to suit your needs
- Click on **Create document**
- Click on **+** icon
- Add the following data corresponding to mapping between beacon-1 and trigger-2 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 57388,
  "minor": 50057,
  "triggerName": "exitFromBranch"
```

- Change uuid, major & minor numbers and triggerName to suit your needs
- Click on **Create document**
- Click on **+** icon and select **New Doc**
- Add the following data corresponding to mapping between beacon-2 and trigger-1 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 56179,
  "minor": 406,
  "triggerName": "entryIntoBranch"
```

- Change uuid, major & minor numbers and triggerName to suit your needs
- Click on **Create document**
- Click on **+** icon
- Add following data corresponding to mapping between beacon-2 and trigger-2 after *_id*

```
, "uuid": "F75D6DF0-9B95-9EF1-A1BA-AE2765DE0987",
  "major": 56179,
  "minor": 406,
  "triggerName": "exitFromBranch"
```
- Change uuid, major & minor numbers and triggerName to suit your needs
- Click on **Create document**

### Create IBM Mobile Foundation service on Bluemix

- Click on **Catalog**
- Search for and select **Mobile Foundation**
- Click on **Create**
- Click on **Settings**
- Click on **Security** tab
- Specify the Console Login Password (user-id would be admin)
- Click on **Next**
- Click on **Start Advanced Server** to create Mobile backend server
- Click on **Launch** Console
- Login with username as admin and the password you have specified before
- Note down the server URL (just the domain - example: mobilefoundation-4w-server.eu-gb.mybluemix.net)

#### Install mfpdev cli

While the server is being started (normally it takes around 10mins to start the server), install mfpdev cli (command line for working with Mobile Foundation) on your local machine as follows:
```bash
npm install -g mfpdev-cli
mfpdev --version
It should be 8.0.0-*
```
Add server information for mfpdev-cli
```bash
$ mfpdev server add
? Enter the name of the new server profile: MyMobileBackend
? Enter the fully qualified URL of this server: https://mobilefoundation-4w-server.eu-gb.mybluemix.net:443
? Enter the MobileFirst Server administrator login ID: admin
? Enter the MobileFirst Server administrator password: ********
? Save the administrator password for this server?: Yes
? Enter the context root of the MobileFirst administration services: mfpadmin
? Enter the MobileFirst Server connection timeout in seconds: 30
Verifying server configuration...
The following runtimes are currently installed on this server: mfp
Server profile 'MyMobileBackend' added successfully.
Note:
•	Specify an appropriate name for new server profile.
•	Specify port (like :443) at the end of server domain URL
•	Leave default for administrator login ID as admin
•	Specify the password you created before
•	Leave default for context root
•	Leave default for connection timeout
```

## Beacon Adapter

To provide the beacon support, the MobileFirst adapter must be created with the basic beacons, triggers and associations data model as POJOs. The adapter connects to the beacon database that has been chosen. The adapter exposes a REST endpoint which retrieves beacon data on request from the client.

IBM MobileFirst Foundation service on Bluemix provides a sample beacon adapter which can be deployed for getting quick beacon support, which uses IBM Cloudant service on Bluemix as the backend for storing beacon data. Download the sample beacon adapter at [Beacon Adapter](https://github.com/mfpdev/mobilefirst-beacons-adapter).

The following section gives a brief on the beacon adapter internals.

### Beacon

Beacons are identified by universally unique identifiers (UUID), major and minor values. The UUID in its canonical form is represented by 32 lowercase hexadecimal digits. The major and minor values are positive numbers in the range of 0-65535 (inclusive).
Beacon objects also contain a customData field which is a JSON payload that specified customer-specific data representing the beacon; for example, the store or location where the beacon is deployed. The code snippet shows the beacon model.

```java
public class Beacon {
	public String uuid;
	public int major;
	public int minor;
	public double latitude;
	public double longitude;
	public Map<String, String> customData = null;

	public void normalizeUuid() {
		uuid = uuid.toLowerCase();
	}
}
```

### Trigger

Beacon triggers are identified by the following parameters: triggerName, triggerType, proximityState, dwellingTime (optional), and actionPayload.

#### Trigger Type

Beacon triggers are identified by the following parameters: triggerName, triggerType, proximityState, dwellingTime (optional), and actionPayload.

- The *triggerType* parameter determines when the trigger is activated, depending on the device location. The trigger types are `Enter`, `Exit`, `DwellInside` and `DwellOutside`.

- The value of the *proximityState* parameter indicates when the trigger is activated, depending on the distance between the device and the beacon region. The proximity states are `Immediate`, `Near` and `Far`.The default value is `Far`.

- The *dwellingTime* parameter applies only to the trigger types DwellInside and DwellOutside and is mandatory for those types. It is specified in milliseconds and defines how long the device must be inside or outside a beacon region before the dwellInside or dwellOutside trigger is activated.
- The *actionPayload* parameter represents the details of the action to be taken when the trigger is activated.

```java
public class Trigger {
	public enum WLTriggerType {
		Enter, Exit, DwellInside, DwellOutside
	}

	public enum WLProximity {
		Immediate, Near, Far, Unseen
	}
...
```

## Adapter REST endpoint

The adapter exposes a REST end point to retrieve the beacon data from the beacon database. The REST end point is detailed below for reference. This service must be invoked by the client application.

```java
@GET
@Path("/getBeaconsTriggersAndAssociations")
@Produces("application/json")
public Response getBeaconsTriggersAndAssociations() throws Exception {
  BeaconsTriggersAndAssociations beaconsTriggersAndAssociations = new BeaconsTriggersAndAssociations();
  beaconsTriggersAndAssociations.beacons = getBeaconsDB().getAllDocsRequestBuilder().includeDocs(true).build().getResponse()
      .getDocsAs(Beacon.class);
  for (Beacon beacon : beaconsTriggersAndAssociations.beacons) {
    beacon.normalizeUuid();
  }
  beaconsTriggersAndAssociations.triggers = getTriggersDB().getAllDocsRequestBuilder().includeDocs(true).build().getResponse()
      .getDocsAs(Trigger.class);
  beaconsTriggersAndAssociations.beaconTriggerAssociations = getAssociationsDB().getAllDocsRequestBuilder().includeDocs(true).build().getResponse()
      .getDocsAs(BeaconTriggerAssociation.class);
  for (BeaconTriggerAssociation beaconTriggerAssociation : beaconsTriggersAndAssociations.beaconTriggerAssociations) {
    beaconTriggerAssociation.normalizeUuid();
  }
  return Response.ok(beaconsTriggersAndAssociations).build();
}
```

## Connecting adapter to beacon data store

Download beacon adapter source code at [Beacon Adapter](https://github.com/mfpdev/mobilefirst-beacons-adapter) and change directory as below:

```bash
$ git clone https://github.com/mfpdev/mobilefirst-beacons-adapter.git
$ cd mobilefirst-beacons-adapter
```
### Edit adapter configuration to connect to Cloundant.
- Open pom.xml and change values for `mfpfUrl`, `mfpUser` and `mfpPassword`.
- Open `src/main/adapter-resources/adapter.xml` and specify correct values for account, key & password
- Open Bluemix console and go the list of all services
- Click on *Cloudant NoSQL DB- service*
- Click on **Service Credentials** tab and click on **View Credentials**
- Copy value for *username* from above to property name account in adapter.xml under defaultValue
- Copy value for *username* from above to property name key in adapter.xml under defaultValue
- Copy value for *password* from above to property name password in adapter.xml under defaultValue
- Build and deploy the adapter to Mobile Foundation service on Bluemix.

### Test Adapter REST APIs

- Go to Mobile Foundation dashboard
- Under *Adapters*, you should see the *MobileFirstBeaconsAdapter* that you just deployed
- Create a temporary username and password to test Adapter REST APIs
  * Click on **Runtime Settings**
  * Click on **Confidential Clients**
  * Click on **New**
  * Specify Display Name of choice - example: *Test*
  * Specify an id - example: *testuser*
  * Specify a *password*
  * Specify *Allowed Scope* as **
  * Click on **Add** and then click **Save**
- Under **Adapters** click on **MobileFirstBeaconsAdapter**
- Go to *Resources* tab
- Click on **View Swagger Docs**
- In the Swagger documentation page, click on **List Operations**
- Click on *Off* button, select *DEFAULT_SCOPE* and click *Authorize*
- Specify the temporary `username` and `password` that you just created under *Confidential Clients*
- Test GET APIs for beacons, triggers, associations and `getBeaconsTriggersAndAssociations` by clicking on **Try it out!**

## Client Side API

The client side APIs for beacon support remains the same as in 7.1. Beacon support is available for native android. The client SDK comes as part of the sample application as of now. It provides the capability to load, store and monitor beacon data by invoking the beacon adapter.

If android client SDK files alone are required, copy the below listed files and update `AndroidManifest.xml` as required.

![Android Client SDK]({{site.baseurl}}/assets/blog/2017-05-09-beacon-support-in-mobilefirst-foundation-service/client-sdk.png)

### Sample Android App
Download source code from [Sample Android App](https://github.com/mfpdev/beacons-sample-app-android) and register the app under MobileFirst server.

```bash
$ git clone https://github.com/mfpdev/beacons-sample-app-android.git
$ cd beacons-sample-app-android
$ mfpdev app register
```
#### Build/Run the app
- Open the app in Android Studio.
- Build/Run the app on your phone.
- Test the various beacon-use cases as per triggers added in database.
