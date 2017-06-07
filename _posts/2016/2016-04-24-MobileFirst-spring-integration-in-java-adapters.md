---
title: Spring framework integration with Adapters in IBM MobileFirst Platform Foundation 8.0 Beta
date: 2016-04-24
version:
- 8.0
tags:
- MobileFirst_Platform
- Adapters
- Spring
- Dependency_injection
- Best_practices
author:
  name: Yotam Madem
---
## Introduction
Often when developing more advanced Java adapters (and JAX-RS services in general)
The need for writing more modular, testable and decoupled code is raising.

Leveraging dependency injection design pattern can be very helpful in those cases.
There are many dependency injection frameworks out there, the reason for choosing Spring
was that it is well known and mature DI framework and also it provides much more
than just DI.


## What is dependency injection
Dependency injection is a software design pattern in which an object always receives its dependencies from the outside (constructor/setters) instead of creating them using the new keyword or using some other way.

This way, it make sense to let classes to depend only on the interfaces of their dependencies so that the actual implementation of a dependency will be changeable without changing the code of the dependant class.


## Dependency injection in adapters
In this blog post I will explain how to integrate Spring into a MobileFirst Java adapter by using the [Spring framework integration for MobileFirst adapters](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/mfp-adapters-spring-integration) module, so that you will be able to write your adapter's code using dependency injection. Your code will become much more modular, clean and testable this way.

## Prerequisites
Make sure [Maven is installed](http://maven.apache.org/).

#### Install Spring framework integration for MobileFirst adapters in your local Maven repository
We will use the open source extension module [Spring framework integration for MobileFirst adapters](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/mfp-adapters-spring-integration) to make it easier to integrate spring into the adapter.

1. Clone the git repository: https://github.com/mfpdev/mfp-advanced-adapters-samples

    ```
    git clone https://github.com/mfpdev/mfp-advanced-adapters-samples.git
    ```

2. Navigate to the folder **mfp-adapters-spring-integration** under the root folder of this repo.

3. In the folder **mfp-adapters-spring-integration** type:

    ```
    mvn install
    ```

Now the spring extension module is installed on your local Maven repository.

## Creating a Spring based Java adapter
1. Start by creating a new MobileFirst Java adapter.  
    Here I use Maven commands, however the [MobileFirst CLI]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) can be used as well.

    ```
    mvn archetype:generate -DarchetypeGroupId=com.ibm.mfp -DarchetypeArtifactId=adapter-maven-archetype-java  -DgroupId=com.sample -DartifactId=my-spring-xml-adapter -Dpackage=com.sample
    ```

    The following file structure is created by executing the above command:

    ```
    ├── pom.xml
    └── src
        └── main
            ├── adapter-resources
            │   └── adapter.xml
            └── java
                └── com
                    └── sample
                        ├── MySpringXmlAdapterApplication.java
                        └── MySpringXmlAdapterResource.java
    ```

2. Remove the file **MySpringXmlAdapterApplication.java**:

    ```
    rm src/main/java/com/sample/MySpringXmlAdapterApplication.java
    ```

3. Edit the **pom.xml** file and add the following dependency:

    ```xml
    <dependency>
      <groupId>com.github.mfpdev</groupId>
      <artifactId>mfp-adapters-spring-integration</artifactId>
      <version>1.0.0</version>
    </dependency>
    ```

4. Edit the **adapter.xml** file ( **src/main/adapter-resources/adapter.xml** ), set the JAXRSApplicationClass element to be:

    ```xml
    <JAXRSApplicationClass>com.github.mfpdev.adapters.spring.integration.SpringXMLApplication</JAXRSApplicationClass>
    ```

5. Create the folder **src/main/resources**

6. Create the file **src/main/resources/applicationContext.xml** with the following content:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>

    <beans xmlns="http://www.springframework.org/schema/beans"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xmlns:aop="http://www.springframework.org/schema/aop"
           xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/aop
            http://www.springframework.org/schema/aop/spring-aop.xsd">


        <!-- Define your beans -->


        <!-- Define the list of JAX-RS resources to use: -->
        <bean class="com.github.mfpdev.adapters.spring.integration.JAXRSResourcesRegistryImpl">
            <property name="resources">
                <list>
                    <bean class="com.sample.MySpringXmlAdapterResource"/>
                </list>
            </property>
        </bean>

    </beans>
    ```

As you can see, you can use `JAXRSResourcesRegistryImpl` to specify list of JAX-RS resources (and providers) to be used in your adapter.  
In this case we took the resource we already have in the adapter (**com.sample.MySpringXmlAdapterResource**) and defined it as a spring bean in the list of resources.

At this point the adapter should be ready to run and it should behave exactly the same as the new Java adapter we created in the first step.  
You can go on and build &amp; deploy the adapter to see that it is working normally.

### The benefits of using Spring in our adapter
Now, let's see what are the benefits of this spring integration.

#### Loose coupling is now possible thanks to dependency injection
Perhaps you would like to architect the adapter in such a way that you separate the JAX-RS resources from the business logic.  
The resource gets the request and handles the path/content type mapping, but the service that actually does the work is another object.

This architecture gives you the flexibility to have a loose dependency between the JAX-RS resource and that service.
The JAX-RS resource will know the service only by it's interface, the actual implementation will be resolved at runtime. And here is where spring comes into the picture.

Let's define our simple "hello" service as a Java interface in our adapter:  

* Create a file named: **HelloService.java** in folder: **src/main/java/com/sample**

    ```java
    package com.sample;

    public interface HelloService {
        String getMessage();
    }
    ```

Now, let's create the implementation:

1. Create the folder: **src/main/java/com/sample/impl**.    

2. Create a file named: **HelloServiceImpl.java** in folder: **src/main/java/com/sample/impl**.

    ```java
    package com.sample.impl;

    import com.sample.HelloService;

    public class HelloServiceImpl implements HelloService{
        @Override
        public String getMessage() {
            return "hello!!!";
        }
    }
    ```

3. Add the hello service implementation to the **applicationContext.xml** file:

    ```xml
    ...
        <!-- Define your beans -->

        <bean class="com.sample.impl.HelloServiceImpl"/>
    ...
    ```

4. In order to use the new service in the adapter, we can go to our resource file: **MySpringXmlAdapterResource.java** and add the following code:

    ```java
    @Autowired
    HelloService helloService;

    @Path("/hello")
    @GET
    @OAuthSecurity(enabled = false)
    public String sayHello(){
        return helloService.getMessage();
    }
    ```

To test the new service, build &amp; deploy the adapter:

```bash
mvn clean install adapter:deploy
```

Call the new service:

```bash
curl -X GET --header "Accept: */*" "http://localhost:9080/mfp/api/adapters/mySpringXmlAdapter/resource/hello"
```

The result should be:

```bash
hello!!!
```

Important to notice that the resource class (**MySpringXmlAdapterResource.java**) knows the service only by the interface. Which implementation to use was decided 
in the **applicationContext.xml** file. Now we can seamlessly replace implementations of hello service without affecting the resources classes code.

#### Integration with MobileFirst server side configuration API
Another benefit of using this Spring integration module is that it seamlessly integrates MobileFirst adapter configuration feature with Spring's properties mechanism.

In the following example I will show how to make the hello service configurable by externalising the message it returns.  

1. Define the new property in the **adapter.xml** file:

    ```xml
    ...
    <JAXRSApplicationClass>com.github.mfpdev.adapters.spring.integration.SpringXMLApplication</JAXRSApplicationClass>

    <property name="helloServiceMessage"
              displayName="Hello message"
              defaultValue="hello!!!"
              type="string"
              description="The message returned by hello service"/>
    ...
    ```

2. Have **HelloServiceImpl.java** accept message as a property:

    ```java
    public class HelloServiceImpl implements HelloService{

        private String message;

        public void setMessage(String message){
            this.message = message;
        }

        @Override
        public String getMessage() {
            return message;
        }
    }
    ```

3. Inject the value of the adapter property `helloServiceMessage` into the **HelloServiceImpl** bean.
This is done from the **applicationContext.xml** file:

    ```xml
    ...
    <!-- Define your beans -->

    <bean class="com.sample.impl.HelloServiceImpl">
        <property name="message" value="${helloServiceMessage}"/>
    </bean>
    ...
    ```

To test the new behaviour we should rebuild &amp; deploy the adapter:

```bash
mvn clean install adapter:deploy
```

Call the hello service:

```bash
curl -X GET --header "Accept: */*" "http://localhost:9080/mfp/api/adapters/mySpringXmlAdapter/resource/hello"
```

The result should the following, because it is using the default value defined in the adapter.xml:

```bash
hello!!!
```

To change the value to something else, open the MobileFirst Oprations Console ([http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole)) and click on  **mySpringXmlAdapter** in the sidebar navigation. Then, in the **Configurations tab** change the value of "Hello message" field to something, "Hello World" else and click "Save".

Now try again:

```
curl -X GET --header "Accept: */*" "http://localhost:9080/mfp/api/adapters/mySpringXmlAdapter/resource/hello"
```

The result should be:

```
Hello World
```

## Sample application
Complete sample for this blog post [can be found on GitHub.com](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/samples/my-spring-xml-adapter).
