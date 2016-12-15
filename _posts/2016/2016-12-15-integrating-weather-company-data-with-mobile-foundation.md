---
title: 'Integrating Weather Company Data with Mobile Foundation'
date: 2016-12-15
tags:
- MobileFirst_Foundation
- Adapters
- Weather_Company
- Cloudant
version:
- 8.0
author:
  name: Ryan Berger
---

# Integrating Weather Company Data with Mobile Foundation

## Introduction

Connecting Bluemix services is a simple way to greatly extend the functions of an application. One way to do this is by using a Mobile Foundation adapter. Adapters can connect many services together, letting the developer focus on security and efficiency by simplifying the way an app accesses the cloud.

## Contents
1. [Benefits](#benefits)
2. [Scenario](#scenario)
3. [Prerequisites](#prerequisites)
4. [Viewing the API](#viewing-the-api)
5. [Designing the adapter](#designing-the-adapter)
6. [Writing the code](#writing-the-code)
7. [Conclusion](#conclusion)

## Benefits

There are several benefits to using a Mobile Foundation adapter:

1. **Reduce requests from the app** - The sample below uses Cloudant and Weather Company Data, and that means it has to make several http requests every time it wants to get the weather. Doing this from a device, such as a phone, means we have to rely on a possibly inconsistent internet connection. If any one of those requests fails we would have problems. Adapters let us make one request to an adapter and make the follow up requests from the cloud.
2. **Move logic to the cloud** - Mobile Foundation adapters allow the user to handle all the logic associated with an http request. Rather than make a phone run all of the code itself, we can offload some of the logic into the adapter itself to save battery life and increase efficiency.
3. **Easily handle security** - By enabling authentication on an adapter endpoint we can make sure that only users who have correctly logged in can make requests against our adapter. This prevents unauthorized or even malicious access and protects our data.
4. **Hide credentials from users** - Using Bluemix services sometimes requires passing in a username and password or an api key. Mobile Foundation adapters have an option to store those credentials without making them visible to the user, securing our backend services.

## Scenario

In this sample, we have a list of addresses stored in Cloudant and need to display alerts if there are dangerous weather conditions in the vicinity. To do this we'll be using **Mobile Foundation**, **Cloudant**, and **Weather Company Data**.

In the sections below we'll cover designing the flow, building the adapter, and testing it.

## Prerequisites

To fully understand this blog we need a basic understanding of adapters work. Start [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/creating-adapters/#creating-an-adapter) to learn about creating and deploying a Java adapter.

## Viewing the API

Before we view the API and design our flow let's go over what address information we have access to. Stored on Cloudant are documents consisting of the street name and number, city, state, and zip code. With that in mind, let's see what Weather Company Data has to offer.

### Swagger

The best place to start is the api reference that is available [here](https://twcservice.mybluemix.net/rest-api/). Right away we can see that there are several sections, one of which is fortunately titled `Weather Alerts`.

![weather]({{site.baseurl}}/assets/blog/2016-12-15-integrating-weather-company-data-with-mobile-foundation/swagger_alerts.png)

There are 5 options here:

1. alert details
2. latitude and longitude
3. country code
4. state code
5. area id

Diving into each one narrows down our choices. **Alert details** only gives us more information about a specific alert, so that doesn't help. **Country code** gives us all the alerts in a country, but that's too broad for a single work order. **State code** gives us all the alerts for a state, which is still too broad.

That leaves us with **area id** and **latitude and longitude**. Unfortunately we don't have either of those in our work order weather document, but the Weather Company Data api also has a section titled `Location Services`, which may be able to help.

![weather]({{site.baseurl}}/assets/blog/2016-12-15-integrating-weather-company-data-with-mobile-foundation/swagger_location.png)

Again we have 5 options for work with:

1. search
2. point
3. postal key
4. iata code
5. icao code

Let's narrow them down. **Point** takes in a latitude and longitude, which we still don't have. Both **IATA code** and **ICAO code** take in data we don't have. Our best options are search, which can take in a city or address and postal key which can take a zip code.

Testing the output for each query (through swagger) we can see that neither option seems to return an area id. This means that we'll have to search for weather alerts based on latitude and longitude. With that in mind, **postal key** seems like the obvious choice. It returns a single latitude and longitude, whereas **search** returns multiple coordinates, which would make it much more complicated.

## Designing the adapter

### Handling limitations

There is a fundamental drawback with only using free services on Bluemix: limits. The free version of the Weather Company Data service only allows us to call the api 10 times a minute. Unfortunately, it takes one call to geocode a zip code and another call to get the alerts for the new latitude and longitude. That means that we're limited to getting the weather for no more than five work orders at a time. If we have more than five active work orders we have a problem. However, finding a way around this only requires that we think about what we want to do in the context of these limits and what tools we have.

The best place to start would be to reduce the number of calls we make each time from two to one. Since we are searching based on zip codes and each zip code returns one latitude and longitude, we can save each zip code and latitude and longitude pair so that we only have to geocode each zip code once. The obvious solution for this is to use Cloudant.

This means we'll have to write a new document. Let's call it `ZipCode.java`. This should be easy as it'll follow the same format as the rest of the documents.

First we need the getters and setters.

```java
public class ZipCode {
    private String zip, latitude, longitude, _id, _rev;

    /**
     * Strings
     */
    public String getZip() {
        return zip;
    }
    public void setZip(String zip) {
        this.zip = zip;
    }
			    .
    			.
    			.
    /**
     * Cloudant IDs
     */
    public String get_id() {
    	return _id;
    }
    public void set_id(String _id) {
    	this._id = _id;
    }

    public String get_rev() {
    	return _rev;
    }
    public void set_rev(String _rev) {
    	this._rev = _rev;
    }
```

Then we need the validation.

```java
/**
 * Methods
 */
public boolean isValid() {
	if (nonNullAndEmpty(zip) && nonNullAndEmpty(latitude) && nonNullAndEmpty(longitude)) {
	    return true;
	}
	else {
		return false;
    }
}

public boolean nonNullAndEmpty(String element) {
    if (element!=null && !element.isEmpty()) {
        return true;
    }
    else {
        return false;
    }
}
```

Now we can use this to save the geocoded data and work within our limitations.

### Define the flow

Let's define our flow for getting weather alerts.

1. Get a list of zip codes we want to get alerts for.
2. Send those zip codes to an adapter.
3. The adapter sends the zip codes to Cloudant to get the coordinates.
4. If the zip codes isn't there, send it to the Weather Company Data api.
5. Get the coordinates and send them to Cloudant for future calls.
6. Take all the coordinates and send them to the Weather Company Data api.
7. Return the alerts.

## Writing the code

### Accessing the api

We should start by setting up our Weather Company Data variables. In order to access the api we need to have the username and password for our instance. Adding the following lines in `adapter.xml` adds them as fields in our server console.

```xml
<property name="weatherUsername" displayName="Weather Username" defaultValue=""/>
<property name="weatherPassword" displayName="Weather Password" defaultValue=""/>
```

Next we need to read them. We are already reading the Cloudant variables in `UtilitiesApplication.java` so we'll do it the same way.

```java
public String weatherUsername;
public String weatherPassword;
    
protected void init() throws Exception {
	logger.info("Adapter initialized!");
    weatherUsername = configurationAPI.getPropertyValue("weatherUsername");
	weatherPassword = configurationAPI.getPropertyValue("weatherPassword");
}
```

Before we can move on we still need to use those variables in our `UtilitiesResource.java` file. For our adapter calls we'll use the `okhttp3` library, so we need to set the weather username and password as our credentials.

```java
private String getCredentials() {
    UtilitiesApplication app = adaptersAPI.getJaxRsApplication(UtilitiesApplication.class);
    if (!app.weatherUsername.isEmpty() && !app.weatherPassword.isEmpty()) {
        return Credentials.basic(app.weatherUsername, app.weatherPassword);
    } else {
        return "";
    }
}
```

Now when we make a call to the api we include the credentials and it will handle authentication.

### Adding the zip code to Cloudant

This will take a zip code object and POST it to Cloudant. Take note that we will set the `_id` field to be the word "zip" and the zip code. This will make it easier to search for zip codes in the future.

```java
// POST a new zip code and coordinates to Cloudant
private Response addZipCode(ZipCode zipCode) throws Exception {
	if(zipCode!=null && zipCode.isValid()) {
        // Handle SSL issue
        fixSSL();

        // Set the id
		zipCode.set_id("zip" + zipCode.getZip());

		// Handle Cloudant
		String err = getDB().post(zipCode).getError();

		if (err != null) {
			return Response.status(500).entity(err).build();
		}
		else {
			return Response.status(201).entity(zipCode).build();
		}

	}
	else {
		return Response.status(400).entity("Invalid zip code document").build();
	}
}
```

### Geocoding with Weather Company Data

We also need a function to get the latitude and longitude from the Weather Company Data api. This is pretty easy. All we have to do is make a request to the api endpoint, provide the credentials, and parse the output.

```java
// GET latitude and longitude for a specific zip code
private JSONObject geocode(String zip) throws Exception {
    OkHttpClient client = new OkHttpClient();

    Request request = new Request.Builder()
        .url("https://twcservice.mybluemix.net/api/weather/v3/location/point?postalKey=" + zip + "%3AUS&language=en-US")
        .get()
        .addHeader("Authorization", getCredentials())
        .build();

    okhttp3.Response response = client.newCall(request).execute();
    String body = response.body().string();
    JSONObject json = JSONObject.parse(body);

    JSONObject output = new JSONObject();
    output.put("latitude", ((JSONObject)json.get("location")).get("latitude"));
    output.put("longitude", ((JSONObject)json.get("location")).get("longitude"));
    return output;
}
```

### Getting the alerts

Now that we have the latitude and longitude we can get the alerts. This is almost exactly the same as geocoding. In fact, it's even easier, since we don't have to parse the data at the end, we can just return it as is.

```java
// GET alerts for a specific latitude and longitude
private String alerts(String latitude, String longitude) throws Exception {
    OkHttpClient client = new OkHttpClient();

    Request request = new Request.Builder()
        .url("https://twcservice.mybluemix.net/api/weather/v1/geocode/" + latitude + "/" + longitude + "/alerts.json?language=en-US")
        .get()
        .addHeader("Authorization", getCredentials())
        .build();

    okhttp3.Response response = client.newCall(request).execute();
    return response.body().string();
}
```

### Writing the endpoint

We should start with the output. Starting from the bottom up, the Weather Company Data api returns alert details as a JSON object, so we'll use that as our lowest level. On top of that are multiple possible alerts for a single location, so we should have a JSON array for each zip code. And since there are multiple zip codes we're returning, the whole thing should be a JSON object.

Notice the line `@OAuthSecurity(scope = "user-restricted")`. That gives this endpoint a protected scope, so that only authorized users will be able to use it. This requires a challenge handler, which in our case would be supplied by a security adapter allowing a user to log in to authenticate. For the case of this blog, the protection can be removed just as easily by removing that line.

```java
// POST a zip code array to update the weather
@POST
@Produces(MediaType.APPLICATION_JSON)
@Consumes("application/json")
@Path("/weather")
@OAuthSecurity(scope = "user-restricted")
public Response getWeatherAlerts(String[] zipCodes) throws Exception {
    /*
     * Output structure
     *  - zipLevel: outer most object
     *  - alertLevel: inner array of alerts for each zip
     *  - detailLevel: inner most object for alert details
     */
    JSONObject zipLevel = new JSONObject();
```

Now we can work to reach our desired output. The first step is to send the zip code array to Cloudant to search for coordinates.

```java
String latitude;
String longitude;

// Handle SSL issue
fixSSL();

for (int i = 0; i < zipCodes.length; i++) {
    // Get lat/long for zips
    try {
		ZipCode dbZip = getDB().find(ZipCode.class, "zip" + zipCodes[i]);

        latitude = dbZip.getLatitude();
        longitude = dbZip.getLongitude();

	} 
```

We need to wrap our Cloudant search in a try-catch in case the document is missing. In that case we'll call our geocode method and add it to Cloudant.

```java
catch(NoDocumentException e){
    // Get the coordintes from the weather service
    JSONObject latLong = geocode(zipCodes[i]);
	
    // Add the zip code to Cloudant
    ZipCode newZip = new ZipCode();
    newZip.setZip(zipCodes[i]);
    newZip.setLatitude(latLong.get("latitude").toString());
    newZip.setLongitude(latLong.get("longitude").toString());
	
    Response cloudantRes = addZipCode(newZip);
	
    // Check for errors when adding the zip
    if (cloudantRes.getStatus() == 201) {
        latitude = newZip.getLatitude();
        longitude = newZip.getLongitude();
	
    } else {
        // Assume zip is invalid
        continue;
    }
}
```

Now we can use our alerts method to get the alerts for our new coordinates. Unfortunately the alerts return is always a 200, so we have to parse the alerts output to see if there are actually any alerts based on the response code inside. Then we combine it all and return the original JSON object we defined at the start.

```java
	// Get weather alerts from lat/long
    String weatherRes = alerts(latitude, longitude);

    // Java casting magic
    JSONObject weatherJSON = JSONObject.parse(weatherRes);
    int code = Integer.parseInt(((JSONObject)weatherJSON.get("metadata")).get("status_code").toString());

    if (code == 200) {
        JSONArray allInfo = (JSONArray)weatherJSON.get("alerts");
        JSONArray alertLevel = new JSONArray();

        // Grab the data for each alert
        for (int j = 0; j < allInfo.size(); j++) {
            JSONObject detailLevel = new JSONObject();
            detailLevel.put("severity", ((JSONObject)allInfo.get(j)).get("severity"));
            detailLevel.put("headline", ((JSONObject)allInfo.get(j)).get("headline_text"));

            alertLevel.add(detailLevel);
        }

        zipLevel.put(zipCodes[i], alertLevel);

    } else {
        // No alerts for zip code
        zipLevel.put(zipCodes[i], null);

    }
}
return Response.ok(zipLevel).build();
```

By combining all the above pieces together into an adapter we can now use the Mobile Foundation server, Cloudant, and Weather Company Data api to get alerts for individual work orders.

## Conclusion

IBM Mobile Foundation provides an easy way to connect multiple Bluemix services without worrying about app integration. It can improve app efficiency by moving logic to the backend and increase security by protecting endpoints with authentication.