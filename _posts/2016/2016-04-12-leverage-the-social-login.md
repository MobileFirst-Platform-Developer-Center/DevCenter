---
title: Leverage Social Login In IBM MobileFirst Platform Foundation 8.0 Beta
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
This blog continues to my previous blog about [Social Login]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/), it is recommended to read it first.   

[Social Login](https://www.wikiwand.com/en/Social_login) by itself is good and gives values to the app owners and users.  In addition, you can leverage the social login and get more value from it.  Facebook, for instance, let you queries their [Graph API](https://developers.facebook.com/docs/graph-api) to get things like user feeds, user friends, pictures. Some of the API requires additional permissions from the user, but sometimes basic info like profile picture is enough to from the app users.  

Imagine that you run a campaign for some new product in your app, and you need to target users by age and gender.  Assuming that you have the user's profile picture from the social login, you can use cognitive API to help you better identify your customers and improve the promotion of  your product.  Actually, if the user profile picture contains his real face you can analyze it with some cognitive API and know his estimated age and his gender.  More than that if the user gives you permissions to get his feeds, then you can analyze his tone or his personality with a cognitive API.  

All of these APIs are available in [Watson](http://www.ibm.com/smarterplanet/us/en/ibmwatson/).  In my demo, I used three services from Watson to analyze some data from my Facebook account.  Those services is based on [machine learning](https://www.wikiwand.com/en/Machine_learning), and indeed very accurate:  

1. [Alchemy Vision API](http://www.alchemyapi.com/products/alchemyvision) - This service lets you analyze the image and gets some data from it. For instance, if the picture recognized as a person then you will able to get the age and gender.  
![login flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/AlchemyVisionAPI.png)
2. [Personality Insight](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/personality-insights.html) - Uncover a deeper understanding of people's personality characteristics, needs, and values to drive personalization
3. [Tone analyze](https://tone-analyzer-demo.mybluemix.net/) - This service enables people to discover and understand and revise the impact of tone in their content. It uses linguistic analysis to detect and interpret emotional, social, and language cues found in the text.  

This blog post is taking into consideration that you have basic knowledge about *IBM MobileFirst Platform Foundation 8.0 Beta* authentication, Security Checks and Adapters. if not please refer to [the Authentication and Security tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/) and to the [Java Adapters tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/java-adapters/).

## See in action
Here is short YouTube demo movie which shows an app which analyzing some data from my personal Facebook account.  Since I'm not native English speaker and most of my posts are not written in English, in the demo I explicitly add text to influence the results.
<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/XVceqBIXZnU"></iframe>
  </div>
</div>

## Running the demo
In order to run this demo, review the instructions in the [sample's repository.](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/social-app-samples/AnalyzeFacebookWithWatsonSample/AnalyzeMyFacebookApp)

## The big picture
I will separate it into two diagrams so each will focus on one flow:  

![OAuth token generation flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/token-flow.jpg)  

1. User clicks on the *ANALYZE MY FACEBOOK* button.   
2. The Client SDK sends resource request to a protected REST Adapter */analyze*, the adapter is protected with *socialLogin* OAuth scope.  
3. Since the adapter is protected the Authorization server API check it for valid OAuth token.  
4. The Authorization server API does not find any valid token with OAuth scope *socialLogin*.  
5. The response is then returned to the app with unauthorized status.  
6. The app is calling the social login challenge handler.  
7. The challenge handler is calling the Facebook SDK to get a valid token from Facebook.  
8. The Facebook SDK is fetch valid token after user gave his permission.  
9. Valid token returns to the app callback.  
1. (Orange circle) The application send the challenge response to the authorization server API.  
2. (Orange circle) The authorization server API execute the social-login security check to validate the credentials.  
3. (Orange circle) The social-login security check validating the Facebook token and also save basic data like profile picture and email of the user.   attributes, as well as the Facebook token.  
4. (Orange circle) The security check inform the Authorization API that the validation passed.  
5. (Orange circle) OAuth token flow is continued until a valid token is returning to the client.

![Adapter invocation flow]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/resource-flow.jpg)

1. After token is returned to the client the client again sends resource request to a Protected REST Adapter */analyze*
2. Since now token is valid, the adapter sends the request to Facebook Graph API to get users feeds.  
3. Profile picture and user feeds send to analyze in Watson.
4. Adapter meshes the data and returns JSON response to the client with the analysis.
5. App displaying the results.

## Some insights I have about working with Java Adapters

## Configuration
Adapter configuration in console is great since you can change them without redeploying the adapter, and the changes affect immediately.
![Configuration in console]({{site.baseurl}}/assets/blog/2016-04-12-leverage-the-social-login/Configuration.png)  
Adding configuration is easy with the Java adapter.
In the code sample I used configuration to maintain the credentials for the Watson services:

* In your adapter.xml you just need to add your properties like the following:  

```xml
<property name="alchemyAPIKey" defaultValue="[Put here your AlchemyAPI Key]" description="See http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/alchemy-language.html"/>
```

* then in the adapter to get the property you just need to inject the ConfigurationAPI as follow

```java
@Context
ConfigurationAPI configApi;
```

* And call it  

```java
configApi.getPropertyValue(ALCHEMY_API_KEY)
```

## Integration
Integration with external services such [Warson Java SDK](https://github.com/watson-developer-cloud/java-sdk) is also easy.
Now that the adapter is a [maven project](https://maven.apache.org/) adding such dependency is just couple of lines in the pom.xml:

* Just add dependency  

```xml
<dependency>
      <groupId>com.ibm.watson.developer_cloud</groupId>
      <artifactId>java-sdk</artifactId>
      <version>2.9.0</version>
</dependency>
```

* And then use it in the adapter

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
I mention it also in the [Social Login blog](about [Social Login]({{site.baseurl}}/blog/2016/04/06/social-login-with-ibm-mobilefirst-platform-foundation/)), but in the context of a resource adapter it means just adding Java annotation with the desired [OAuth](https://www.wikiwand.com/en/OAuth) scope:   

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
