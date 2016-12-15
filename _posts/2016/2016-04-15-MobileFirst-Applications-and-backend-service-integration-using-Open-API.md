---
title: MobileFirst Applications and enterprise backend service integration using Open API
date: 2016-04-15
tags:
- MobileFirst_Platform
- Adapters
- Open_API
- Swagger_Codegen
version:
- 8.0
author:
  name: S Venkatakrishnan
---
## Overview
The MobileFirst Java Adapter is a simple and secure extension point on the MobileFirst Platform using which you can quickly and seamlessly integrate your Mobile Applications with enterprise backend data / functions.  To accelerate this integration the MobileFirst platform provides an approach and an adapter extension to support the approach.

## Integration Approach - using Open API
Most often there is a subset of backend data or function that needs to be quickly and securely exposed as public services that can then be exploited by mobile applications.  The MobileFirst platform proposes the following approach to achieve this goal and also provides tools to accelerate the integration via this approach.

### Define ReST APIs for the backend data / function using Open API Specs
For the backend data or function that you want to integrate with design ReST APIs which you could then describe using the [Open API Specification (fka Swagger Specifications)](https://github.com/OAI/OpenAPI-Specification) standard.  You may choose either YAML or JSON as the notation to describe the APIs.  You could use the online [Swagger Editor](http://editor.swagger.io) as a convenience tool to compose you API definitions according to the Open API specs.

Designing and describing the ReST APIs lays the foundation to opening up your backend data / functions for use by your mobile applications.  The next steps will be implementing these ReST APIs to connect to your backend data / functions and then hosting the APIs as a service that can be exploited by your mobile applications.

> **NOTE:** You can secure access to your ReST APIs with OAuth.  Add the security attribute to the API methods specifying the required access scopes.

Here is a sample API specification - [Customer API](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/samples/factory-customer-adapter/src/main/resources/customer.yaml)

### Generate JAXRS resources for the ReST API integrated with MobileFirst Java Adapter
Here is where the MobileFirst platform steps in to accelerate the hosting of these ReST APIs as a service through MobileFirst Java Adapters.  It takes advantage of the fact that the APIs are defined using the Open API specifications and employs [Swagger Codegen](http://swagger.io/swagger-codegen/) tools to expedite this.  

The MobileFirst Platform provides a codegen extension that customizes the Swagger Codegen for JAXRS servers to suit the specific requirements of the MobileFirst Java Adapters.  This is provided as a language extension to the Swagger Codegen and is identified by the name "MFPAdapter".  

The Swagger-Codegen maven plugin is added to the Java Adapter maven project.  This plug in when executed with your ReST API descriptions (in yaml or json) calls out to the "MFPAdapter" language extension and generates the corresponding ReST resources that the MobleFirst Java Adapter will use to route requests to.  

Here is how we go about this step-by-step to achieve this:

* Create a *MobileFirst Java Adapter* maven project.  Refer to [Creating Java and JavaScript Adapters]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/creating-adapters/#creating-adapters-using-maven-archetype-adapter-maven-archetype)
* In the project directory create a subdirectory *src/main/resources*
* Copy the ReST API descriptions (yaml or json) file to the subdirectory *src/main/resources*
* Open the project's pom.xml and add the following fragment under the plugins element - this is the swagger-codegen maven plugin  

  ```xml
  <plugin>
      <groupId>io.swagger</groupId>
      <artifactId>swagger-codegen-maven-plugin</artifactId>
      <version>2.1.6-SNAPSHOT</version>
      <configuration>
          <inputSpec>yourServiceAPI.yaml</inputSpec>
          <language>MFPAdapter</language>
          <output>target/generated</output>
          <configurationFile>yourCodegenConfig.json</configurationFile>
      </configuration>
      <dependencies>
          <dependency>
          	<groupId>com.github.mfpdev</groupId>
          	<artifactId>mfp-adapters-swagger-codegen</artifactId>
          	<version>1.0.0</version>
      	</dependency>
      </dependencies>
      <executions>
          <execution>
              <goals>
                  <goal>generate</goal>
              </goals>
          </execution>
      </executions>
  </plugin>  
  ```
      
  Here is a sample pom.xml - [CustomerAdapter pom.xml](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/samples/factory-customer-adapter/pom.xml)    

* Configure the swagger-codegen plugin as follows :

    - *inputSpec*: This is the location of your API specification file represented either in yaml or in json
    - *language*: This is an input to swagger-codegen.  The MobileFirst customizations are added under the name 'MFPAdapter'. DO NOT change this to any other	value
    - *output*: This is the destination directory for all the code that will be generated like the JAXRS service resources, data models, exceptions.
    - *configurationFile*: This is the name and location of a json file that will contain your specific customizations to the codegen.  More details about this in the following point.
* Customize the code generation specific to your project, it's Java package structure, choice of service implementation.  The plugin configurations descrbied above are for specifying higher level inputs such as input and output locations.  Some specific configurations to 'how' the code should be generated is to be specified in a separate codegen configuration json file.  This is the file whose location and name is specified in the plugin configuration
property named *configurationFile* (see above). Here is what the contents of this file should be :  

  ```json
  {
     "modelPackage"    : "<name of the Java package for the service data model classes>",
     "apiPackage"      : "<name of the Java package for the service API interfaces and classes>" ,
     "additionalProperties" : {
         "serviceFactoryClassname" : "<fully qualified name of the service factory class that will
                                      implement the generated service factory interface.  
                                      You should not provide this property if you do not intend to
                                      implement the service factory and would instead 'inject' the
                                      service implementation by other means such as Spring
                                      dependency injection>",
         "autowiredSpringService"  : "<set to "true" if you want to autowire a spring bean for the
                                      service implementation.  You should not provide this property
                                      if you are going to use spring dependency injection to provide
                                      the service implementation>"
       }
  }
  ```  
  
  Here is a [sample codegen configuration json file](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/samples/factory-customer-adapter/src/main/resources/codegenConfig.json)  
    
  > **NOTE:** When specifying for *apiPackage* in the above json ensure that this package is in the resource scan list of `AdapterJaxrsApplication` class. For example if you have generated a Java Adapter using Maven archetype and have specified a package name for the Adapter classes then use this same package name for *apiPackage*.  This is because `AdapterJaxrsApplication` scans it's package for JAXRS resources and generating API resources in the same package facilitates the scanning.  

  #### Service Implementation Options
  Swagger-codegen will generate the JAXRS resources, data model classes and then the service interfaces.  The service interfaces should be implemented with code that connects and calls out to the backend systems to wire in the relevant backend data / functions.  There are two options to providing this service implementation :-  
      - provide a factory implementation that will inturn provide an appropriate service implementation instance.  If you choose this then you must provide the fully qualified name of the class that will implement the factory as value for the _serviceFactoryClassname_ property in the codegen configuration json file.
  
      - provide a Spring bean implementation for the service interface and resolve this implementation via Spring dependency injection.  If you choose this then you must set the _autowiredSpringService_ property to true in the codegen configuration json file.

* Generate the JAXRS resources by running the maven swagger-codegen plugin as follows:-

  ```
  mvn io.swagger:swagger-codegen-maven-plugin:2.1.6-SNAPSHOT:generate
  ```
    
  After this you would have generated the JAXRS resources and the data model classes it requires.  Also will be generated the service interfaces that should be implemented for the backend connectivity.  If you have specified the security attribute for your API methods then you will observe that the generated JAXRS resources are annotated appropriately with the com.ibm.mfp.adapter.api.OAuthSecurity annotations with the appropriate attributes.

### Provide backend integration implementation
If you lookup the outbput directory that you had configured in the maven swagger-codegen plugin (like target/generated subdirectory) you will notice that besides the JAXRS resources and model classes there is also a API service Java interface that is generated.  You must implement this interface's methods to process the API specified inputs, connect and callout to the backend systems to wire in the relevant backend data / functions and produce the API specified outputs.  

* If you had provided the _serviceFactoryClassname_ property in the codegen configuration json then you will observe that the generated code wires in the factory implementation class name that was provided there.  You must now provide a concrete implementation of this class implementing the generated service factory interface.  
    
 Here is a code snippet from a generated sample FactoryFinder class that wires in a specified service factory implementation.  

  ```java
  public class CustomersApiServiceFactoryFinder {

      public static CustomersApiServiceFactoryIfc findFactoryImpl() throws ServiceFactoryFinderException {
        String svcFactoryClassname = "com.github.mfpdev.samples.swaggercodegen.factory.customer.api.CustomerFactoryImpl";

        if ( svcFactoryClassname != null && svcFactoryClassname.length() > 0 ) {
          try {
            return (CustomersApiServiceFactoryIfc)Class.forName(svcFactoryClassname).newInstance();
          } catch ( Exception e ) {
            throw new ServiceFactoryFinderException(e);
          }
        } else {
            throw new ServiceFactoryFinderException("CustomersApiServiceFactoryIfc" + " implementation class name not defined in codegen configuration");
        }
      }
  }
  ```  

  Here is the complete generated sample service factory interface and implementation - [CusomterServiceFactory](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/samples/factory-customer-adapter/src/main/java/com/github/mfpdev/samples/swaggercodegen/factory/customer/api/CustomerFactoryImpl.java)

* If you had set _autowiredSpringService_ property in the codegen configuration json to true then you will observe that the generated code adds a 'spring autowire' annotation for the service instance varibale in the JAXRS resource.  You must now provide a Spring bean implementation for the generated service interface.  
  
  Here is a code snippet from a generate sample JAXRS resource.  

  ```java
  @Component
  public class CustomersApi  {
  @Autowired
  private CustomersApiService delegate = null;
  ...
  ```
    
When you have completed the service interface implementations your JAXRS resources are complete and ready to be built and deploy.

### Build and deploy the Adapter
Before building the Adatper archive for deployment add the following to the pom.xml

Add the following dependency

```xml
<dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-annotations</artifactId>
        <version>2.7.3</version>
</dependency>
```

Add the following plugin

```xml
<plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>build-helper-maven-plugin</artifactId>
        <executions>
                <execution>
                        <phase>generate-sources</phase>
                        <goals><goal>add-source</goal></goals>
                        <configuration>
                                <sources>
                                        <source>target/generated</source>
                                </sources>
                        </configuration>
                </execution>
        </executions>
</plugin>
```
Here is a sample pom.xml - [CustomerAdapter pom.xml](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/samples/factory-customer-adapter/pom.xml)

Now build the Adapter and deploy it on MobileFirst Server !!!

> **NOTE:** If you have secured your ReST API methods then the Java Adapter will enforce the security as specified.  Hence ensure that any client that accesses the ReST APIs carry a valid OAuth access token with the required access scopes.

## Conclusion
If you have backend data and functions that you want to exploit in your MobileFirst applications then the MobileFirst Java Adapter extensions for swagger-codegen provide a quick and easy means to:

* Host the backend data / functions as MobileFirst Java Adapter ReST services if you could describe the desired ReST APIs using Open API specs  
* Secure the exposed ReST APIs with OAuth2 with virtually 'no additional coding' since the MobileFirst Java Adapter will enforce the configured security constraints  
* Implement the connectivity and integration logic to your backend systems in a isolated and well maintainable design constructs  
* Continue to use MobileFirst client SDKs and programming model to now seamlessly access the backend data / functions which is now exposed as any other MobileFirst Java Adapter services

## Samples
To further understand the mfp-adaper-swagger-codegen extension, assimilate and try all of what has been mentioned in this blog post refer to the two the following two samples :-

* [factory-customer-adapter](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/samples/factory-customer-adapter) sample which uses the service factory implementation approach to providing the service implementation  
* [spring-customer-adapter](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/samples/spring-customer-adapter) sample which uses Spring dependency injection to provide implementation for the service.
