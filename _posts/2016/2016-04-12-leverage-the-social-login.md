---
title: Leverage Social Login In IBM MobileFirst Platform Foundation 8.0
date: 2016-04-12
version:
- 8.0
tags:
- MobileFirst_Platform
- Authentication
- Adapters
author:
  name: Ishai Borovoy
---
## Introduction
This blog continues from my previous blog about [Social Login]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/), it is recommended to read that previous blog first.   

[Social Login](https://www.wikiwand.com/en/Social_login) by itself is good and gives values to app owners and users.  In addition, you can leverage social login and get more value from it.  Facebook, for example, lets you query their [Graph API](https://developers.facebook.com/docs/graph-api) to get more contents such as user feeds, user friends, pictures. Some of the API requires additional permissions from the user, but sometimes basic info like profile picture is enough from the app users.  

Imagine that you run a campaign for some new product in your app, and you need to target users by age and gender.  Assuming that you have the user's profile picture from the social login, you can use cognitive API to help you better identify your customers and improve the promotion of  your product.  Actually, if the user profile picture contains his real face, you can analyze it with some cognitive API and know the estimated age and  gender.  Moreover, if the user gives you permissions to get his feeds, then you can analyze his tone or his personality with a cognitive API.  

All these APIs are available in [Watson](http://www.ibm.com/smarterplanet/us/en/ibmwatson/).  The demo uses three services from Watson to analyze some data from the author's Facebook account.  Those services are based on [machine learning](https://www.wikiwand.com/en/Machine_learning) and are indeed very accurate:  

1. [Alchemy Vision API](http://www.alchemyapi.com/products/alchemyvision) - This service lets you analyze the image and get some data from it. For example, if the picture is recognized as a person, you can get the age and gender.  
![login flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/AlchemyVisionAPI.png)
2. [Personality Insight](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/personality-insights.html) - Uncover a deeper understanding of people's personality characteristics, needs, and values to drive personalization.
3. [Tone analyze](https://tone-analyzer-demo.mybluemix.net/) - This service enables people to discover, understand, and revise the impact of tone in their content. It uses linguistic analysis to detect and interpret emotional, social, and language cues found in the text.  

This blog post assumes that you have basic knowledge about *IBM MobileFirst Platform Foundation 8.0* authentication, security checks, and adapters. If it's not the case, refer to [the Authentication and Security tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/) and to the [Java Adapters tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/java-adapters/).

## See in action
Here is a short YouTube demo movie which shows an app that's analyzing some data from my personal Facebook account.  Because I'm not a native English speaker and most of my posts are not written in English, in the demo I explicitly add text to influence the results.
<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/XVceqBIXZnU"></iframe>
  </div>
</div>

## Running the demo
In order to run this demo, review the instructions in the [sample's repository.](https://github.com/mfpdev/leverage-social-login-sample)

## The big picture
Each of the two diagrams focuses on one flow:  

![OAuth token generation flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/token-flow.jpg)  

1. The user clicks the *ANALYZE MY FACEBOOK* button.   
2. The Client SDK sends a resource request to a protected REST adapter */analyze*, the adapter is protected with *socialLogin* OAuth scope.  
3. Because the adapter is protected the Authorization server API, check it to validate the OAuth token.  
4. The Authorization server API does not find any valid token with OAuth scope *socialLogin*.  
5. The response is then returned to the app with unauthorized status.  
6. The app calls the social login challenge handler.  
7. The challenge handler calls the Facebook SDK to get a valid token from Facebook.  
8. The Facebook SDK fetches a valid token after the user gave his permission.  
9. The valid token returns to the app callback.  
1. (Orange circle) The application sends the challenge response to the authorization server API.  
2. (Orange circle) The authorization server API executes the social-login security check to validate the credentials.  
3. (Orange circle) The social-login security check validates the Facebook token and also saves basic data, such as the user's profile picture and email address, and the Facebook token.  
4. (Orange circle) The security check informs the Authorization API that the validation passed.  
5. (Orange circle) The OAuth token flow is continued until a valid token is returned to the client.

![Adapter invocation flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/resource-flow.jpg)

1. After the token is returned to the client, the client again sends a resource request to a Protected REST adapter */analyze*.
2. Because the token is now valid, the adapter sends the request to the Facebook Graph API to get the user's feeds.  
3. The profile picture and user feeds are sent to Watson for analysis.
4. The adapter meshes the data and returns a JSON response to the client with the analysis.
5. The app displayes the results.

## Some insights about working with Java adapters

## Configuration
Configuring adapters in the MobileFirst Operations Console is great because you can modify adapters without redeploying them, and the changes take effect immediately.
![Configuration in console]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/Configuration.png)  
Adding configuration setting is easy with the Java adapter.
The code sample ues configuration to maintain the credentials for the Watson services:

* In your adapter.xml file you just need to add your properties, as follows:  

```xml
<property name="alchemyAPIKey" defaultValue="[Put here your AlchemyAPI Key]" description="See http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/alchemy-language.html"/>
```

* Then in the adapter, to get the property, you just need to inject the ConfigurationAPI, as follows:

```java
@Context
ConfigurationAPI configApi;
```

* Then call it:

```java
configApi.getPropertyValue(ALCHEMY_API_KEY)
```

## Integration
Integration with external services such as [Watson Java SDK](https://github.com/watson-developer-cloud/java-sdk) is also easy.
Now that the adapter is a [maven project](https://maven.apache.org/), adding such dependency is just a couple of lines to add in the pom.xml file:

* Just add a dependency:

```xml
<dependency>
      <groupId>com.ibm.watson.developer_cloud</groupId>
      <artifactId>java-sdk</artifactId>
      <version>2.9.0</version>
</dependency>
```

* And then use it in the adapter:

```java
private JSONArray getBig5(String feed) {
        PersonalityInsights service = new PersonalityInsights();
        service.setUsernameAndPassword(configApi.getPropertyValue(PERSONALITY_INSIGHT_USER), configApi.getPropertyValue(PERSONALITY_INSIGHT_PASSWORD));
        Profile profile = service.getProfile(feed);
        JSONArray traitsArray = new JSONArray();
        List<Trait> traits = profile.getTree().getChildren().get(0).getChildren().get(0).getChildren();
        for (Trait trait : traits) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put(NAME_KEY, trait.getName());
            jsonObject.put(SCORE_KEY, trait.getPercentage() * 100);
            traitsArray.add(jsonObject);
        }
        return traitsArray;
    }
```
## Security
Securiy is also mentioned in the [Social Login blog]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation), but in the context of a resource adapter, it means just adding Java annotations with the desired [OAuth](https://www.wikiwand.com/en/OAuth) scope:   

```java
@GET
@Produces(MediaType.APPLICATION_JSON)
@OAuthSecurity(scope = "socialLogin")
public JSONObject analyze() {
  ...
}
```
## Supported Versions
IBM MobileFirst Platform Foundation 8.0
