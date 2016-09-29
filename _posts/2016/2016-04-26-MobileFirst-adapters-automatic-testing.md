---
title: Automatic testing of Adapters in IBM MobileFirst Platform Foundation 8.0 Beta (Part 1)
date: 2016-04-26
version:
- 8.0
tags:
- MobileFirst_Platform
- Adapters
- Best_practices
- Automation
- Testing
- JUnit
author:
  name: Yotam Madem
---
## Introduction
Software testing is an important aspect in software development. It is so critical, that most organizations won't even publish a new release without properly testing it.

The problem with manual testing is the slowness of the process. Developers must wait for testers to test before a new version can be released, and testers must wait for developers to fix the defects they found before they can verify the fixes.

Automated tests aim to solve this by replacing most of the manual test with a set of automated tests which are running automatically as part of the delivery process of the development organisation.

Having high coverage in automated tests as well as reliable tools and infrastructure that will run those can make it much easier for the organisation to release frequently and with confidence that existing functionality was not broken due to release of new features.

## Automated tests in MobileFirst adapters
Automatically testing MobileFirst adapters became very easy as soon as we released our Adapters Maven plug-in, which enables to develop adapters using Maven. Maven makes it simple to integrate with open source libraries such as JUnit and Spring testing framework, so that it becomes really straightforward to put together the infrastructure for developing automated tests for adapters.

## Creating adapter with automated test

In this blog post you will learn how to create an adapter and cover its functionality by a set of automated tests. We are going to use JUnit and Spring testing framework to achieve this goal.

### Prerequisites

* Make sure Maven is installed
* Make sure that MobileFirst 8.0 DevKit is installed

### Create the adapter

Create a Java adapter using the command:

```
mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=adapter-maven-archetype-java  -DgroupId=net.mfpdev.sample -DartifactId=adapter-with-auto-tests -Dpackage=net.mfpdev
```

Replace the sample content of **AdapterWithAutoTestsResource.java** with the following content:

```java
package net.mfpdev;

import com.ibm.mfp.adapter.api.OAuthSecurity;
import io.swagger.annotations.Api;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Api(value = "Sample Adapter Resource")
@Path("/resource")
public class AdapterWithAutoTestsResource {

  @Path("/protected/{p}")
  @GET
  public String protectedResource(@PathParam("p") String param){
    return "Hello: "+param;
  }

  @Path("/unprotected/{p}")
  @GET
  @OAuthSecurity(enabled = false)
  public String unprotected(@PathParam("p") String param){
    return "Hello: "+param;
  }
}
```

As you can see we have two resources in this adapter: one is protected: /resource/protected/{p}, and the second is unprotected: /resource/unprotected/{p}.

First, lets write an automated test for the unprotected resource (since this is simpler to start with).

### Change the pom.xml

#### Add dependencies for tests
In order to use JUnit we need to add the following dependency to the adapter's **pom.xml**:

```xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>

```

In addition to JUnit, we need to add the following dependencies in order to use the Spring testing framework:

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-web</artifactId>
    <version>4.2.5.RELEASE</version>
    <scope>test</scope>
</dependency>

<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>4.1.8.RELEASE</version>
    <scope>test</scope>
</dependency>

<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.6.5</version>
    <scope>test</scope>
</dependency>

<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-core</artifactId>
    <version>2.6.5</version>
    <scope>test</scope>
</dependency>
```

### Write your first test

Create the folder "test/java" under the "src" folder of the adapter project.

```
mkdir src/test
mkdir src/test/java
```

The folder you just created is considered the Maven standard location for unit tests and integration tests.
In the folder src/test/java create the file net/mfpdev/MyAdapterIT.java with the following content:

```java
package net.mfpdev;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.web.client.RestTemplate;

public class MyAdapterIT {

    @Test
    public void testUnprotectedResource(){
        RestTemplate restTemplate = new RestTemplate();

        String response = restTemplate.getForObject(
                "http://localhost:9080/mfp/api/adapters/adapterWithAutoTests/resource/unprotected/name", String.class);

        Assert.assertEquals("Hello: name", response);
    }
}

```

That's it, your first test is ready to run, now let's run it to make sure it works:

Make sure that the MobileFirst 8.0 development server is running

First, we need to deploy the adapter:

```
mvn clean install adapter:deploy
```

Then we can run the integration tests:

```
mvn failsafe:integration-test failsafe:verify
```

Maven should now run the test and we should get the following output:


```

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running net.mfpdev.MyAdapterIT
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.327 sec - in net.mfpdev.MyAdapterIT

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent! The file encoding for reports output files should be provided by the POM property ${project.reporting.outputEncoding}.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.901 s
[INFO] Finished at: 2016-04-25T00:47:03+03:00
[INFO] Final Memory: 11M/309M
[INFO] ------------------------------------------------------------------------

```
### Enhance your test - externalize MFP server URL

This test was very nice and simple, however, it is using hard coded MFP server URL ("http://localhost:9080/mfp/api/adapters/adapterWithAutoTests/resource/unprotected/name")
This is not a good development practice. Reasons:

* Code and configuration coupling: If we will want to run the same test against different MFP server (not dev server on localhost) we will have a problem, it will require code change.
* Code duplication: The common prefix http://localhost:9080/mfp/api/adapters/adapterWithAutoTests. appears in many places in the tests code.

So we agreed that the base URL of the adapter must be externalized. In order to externalize it, we will use the spring testing framework ability to inject properties values into the test.

First, let's change the code of MyAdapterIT.java to take the server URL from external configuration:

Edit **MyAdapterIT.java** to be:

```java
package net.mfpdev;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = MyAdapterIT.class)
@Configuration
@PropertySource("classpath:/defaults.properties")
public class MyAdapterIT {

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
        return new PropertySourcesPlaceholderConfigurer();
    }

    @Value("${mfp-runtime-url}/api/adapters/adapterWithAutoTests")
    String adapterURL;

    @Test
    public void testUnprotectedResource(){
        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.getForObject(adapterURL+"/resource/unprotected/name", String.class);
        Assert.assertEquals("Hello: name", response);
    }
}
```

In addition, in order to give default value for this property, create the file: **src/test/resources/defaults.properties** with the following content:

```
mfp-runtime-url=http://localhost:9080/mfp
```

Now, it should be possible to run the test again and make sure it is still working with the development server as a default.

```
mvn failsafe:integration-test failsafe:verify
```

In order to run it using a different server URL, you can now use the command:

```
mvn failsafe:integration-test failsafe:verify -Dmfp-runtime-url=<URL>
```

####Understanding what we did here
In order to externalize the server base URL to an external configuration property,
we decided to use SpringJUnit4ClassRunner as our JUnit test runner, hence we've added:

```java
@RunWith(SpringJUnit4ClassRunner.class)
```

This runner loads a spring context which in our case it is the test class itself.
Therefore we instructed it to load the test class as the spring context:

```java
@ContextConfiguration(classes = MyAdapterIT.class)
```
Additionally we had to annotate MyAdapterIT class with **@Configuration** in order for spring to recognize it as a spring context.

We added the **@PropertySource("classpath:/defaults.properties")** annotation to the class in order to take default values from our defaults.properties file

The way to inject this URL to the test instance is simple. We used the **@Value** annotation like this:

```java
@Value("${mfp-runtime-url}/api/adapters/adapterWithAutoTests")
String adapterURL;
```

But in order for the **@Value** annotation to work, we had to add the bean **PropertySourcesPlaceholderConfigurer** to our context:

```java
@Bean
public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
    return new PropertySourcesPlaceholderConfigurer();
}
```

Looks like a little bit of overkill for something as simple as using values from property files. We didn't really have to use Spring.
It was decided to use spring because this is the foundation of our test infrastructure for this adapter and later, when we will add more
complications to it, we will see how easy spring makes it and that it really affects the modularity and cleanness of the code even when
it is simply test code.

An example for non spring way to achieve the same result would be:

```java
package net.mfpdev;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.web.client.RestTemplate;

public class MyAdapterIT {

    String adapterURL = getServerURL()+"/api/adapters/adapterWithAutoTests";

    private static String getServerURL() {
        String value = System.getProperty("mfp-server-url");
        if (value == null){
            return "http://localhost:9080/mfp";
        }
        return value;
    }

    @Test
    public void testUnprotectedResource(){
        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.getForObject(adapterURL+"/resource/unprotected/name", String.class);
        Assert.assertEquals("Hello: name", response);
    }
}
```

In the above case, the file defaults.properties is not used - the default value is hard coded instead

Sample code for this blog post: [Adapter with automatic tests sample](https://github.com/mfpdev/adapter-with-auto-tests)