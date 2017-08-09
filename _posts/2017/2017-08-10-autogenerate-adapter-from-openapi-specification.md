---
title: 'Auto Generate Adapters for Microservices and backend systems from its OpenAPI Specification'
date: 2017-08-10
tags:
- MobileFirst_Foundation
- Adapter
version:
- 8.0
author: 
name: Shinoj Zacharias
additional_authors:
- Yathendra P Neela
---

## Auto-generation of Adapters

As a developer creating applications, you can significantly optimize the time you spend on backend coding by auto-generating adapters for your back-systems and Microservices. Use this feature of IBM Mobile Foundation to generate an MFP adapter from the OpenAPI specification of the Microservices/Back-end systems. By using this feature, you can now focus on the application logic instead of creating the Mobile Foundation adapter, which connects the application to the desired back-end service.

### Overview of Adapters

Adapters are Maven projects that contain server-side code implemented in either Java or JavaScript. Adapters are used to perform any necessary server-side logic, and to transfer and retrieve information from backend systems to client applications and cloud services. See more on [Developing Adapters](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters)

1. Challenges in developing Adapters

    An adapter can be created using either Maven commands or by using the MobileFirst CLI. The adapter code needs to be written by the developers using the IDE of their choice, such as Eclipse or IntelliJ. Developer writes the server-side code that often connects to a backend services to transfer or retrieve the information from backend systems that eventually be used by the client applications or cloud service. This means that developer needs to fully understand the backend service APIs and need to code all the logic by themseleves. Java adapters can use server-side Java APIs to perform operations that are related to MobileFirst Server, such as calling other adapters, logging to the server log, getting values of configuration properties, reporting activities to Analytics and getting the identity of the request issuer. It would be easy for developers if the an adapter code can be generated automatically for a backend system/service. See more on [Creating Adapters](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/creating-adapters)

2. OpenAPI specification

    The OpenAPI Specification, originally known as the Swagger Specification, is a specification for machine-readable interface files for describing, producing, consuming, and visualizing RESTful Web services. OpenAPI specification is adopted by many companies as the industry standard for defining REST APIs. OpenAPI specifications are the key to supporting a great toolchain for developers and is used for documentation of the REST APIs. One of the great benefits of using OpenAPI Specification is that it can be used to generate the client libraries in variety of languages and use the client APIs easily to transfer and retrieve information from the backend systems and services.

## Auto-generation of Adapter from OpenAPI Specification
IBM MobileFirst Foundation Platform provides an extension Adapter that can be used to auto-generate adapters from OpenAPI specification. The extension Adapter takes an OpenAPI specification json and generates the adapter from the Open API specification, using the client libaries generated from the OpenAPI specification, and downloads the generated adatpers. The adapter that is generated and downloaded can then be deployed to Mobile Foundation Server and directly be used by the client applications. This takes the pain out of developers who need to spend enormous time on developing the adapters, rather they can focus more on building the client applications.

***Note:**  Adapter Generation Feature is available on MFP Devkits only. To use the adapter generation feature, JDK must be installed on the machine where MFP is installed and **JAVA_HOME** environment varibale needs to be set to the installed JDK path.*

### Microservice Connector - Extension Adapter for generating adapter from OpenAPI Specification
IBM MobileFirst Foundation Platform ships an Extension Adapter, called Microservice Connector, that can be download from the Download Center of MobileFirst Operations Console. This adapter needs to be downloaded and deployed on to the Mobile Foundation Server. 

 The MobileFoundation Dashboard showing information on fast tracking app development using adapter autogeneration feature
    
![Navigate to Microservice Connector from Dashboard]({{site.baseurl}}/assets/blog/2017-08-10-autogenerate-adapter-from-openapi-specification/navigate-to-microservice-connector-from-dashboard.png)

 The Microservice Connector adapter, also known as Microservice Adapter Generator, can be downloaded from the Tools tab of Download Center

![Download Microservice Connector]({{site.baseurl}}/assets/blog/2017-08-10-autogenerate-adapter-from-openapi-specification/microservice-connector-in-downloadcenter-tools.png)

 Once deployed the Adapter will be appearing under the Extensions category in the left navigation pane of the MobileFirst Operations Console. Clicking on the Microservice Adapter Generator will open up the page where one can select the OpenAPI specification json of the microservice/backend system to generate the adapter. Once the adapter is generated, the generated adapter will be automatically downloaded. Note that the first request to generate the adapter can take a while as MFP needs to download a lot of maven dependencies that is requried for the adapter generation.  The subsequent generation will be faster as maven dependencies are already stored in Maven local repository.

![Microservice Connector]({{site.baseurl}}/assets/blog/2017-08-10-autogenerate-adapter-from-openapi-specification/microservice-adapter-generator-ui.png)

### How to get a functional and consumable adapter generated from OpenAPI specification
The correctness of the adapter generated depends on the OpenAPI specification. There may be cases where OpenAPI specification doesn't match with that of REST API of the backend service. In this case , even if the adapter generation is successful, the call from adapter to the backend will not work because of the mismatch in specification with that of REST API defined by the microservies/backend system. In the case, unless the specification is corrected, a fully functional adatper won't be generated.

1. Add Security in OpenAPI specification

    For Adapter to connect to backend systems, security definitions should be added to the OpenAPI specification. Adapter generator support **BASIC** authentication only. Authentication types such as **API Key** and **OAUTH2** is not supported currently for connecting to backend systems. For **BASIC** authentication, security definition specification needs to be added to the specification json

    ```
    "securityDefinitions": {
        "basicAuth": {
            "type": "basic",
            "description": "HTTP Basic Authentication."
        }   
    },
    "security": [
    {
        "basicAuth": []
    }
    ]

    ```

2. Add host and basepath in OpenAPI specification

    Make sure that the host with correct schemes is provided in the specification and also the basePath of the API

    ```
    "host": "gateway.watsonplatform.net",
    "schemes": [
        "https"
    ],
    "basePath": "/natural-language-understanding/api"

    ```

3. Add Custom Scope for Adapter REST Endpoints

    If there is no scope added in the OpenAPI specification, a **DEFAULT_SCOPE** is added to all the REST endpoints. A custom scope can either be added at the global level or at the operational level, here is an example of adding scope globally

    ```
    "securityDefinitions": {
        "basicAuth": {
            "type": "basic",
            "description": "HTTP Basic Authentication."
        },
        "OauthSecurity": {
            "type": "oauth2",
            "flow": "implicit",
            "scopes": {
                "adminauth": "Admin scope",
                "customauth": "custom scope"
            }
        }
    },
    "security": [
    {
        "basicAuth": []
    },
    {
        "OauthSecurity": [
            "customauth"
        ]
    }
    ]
    ```

    Here is an example of overriding the global scope at the operational level
    
    ```
    "paths": {
        "/v1/workspaces": {
            "parameters": [
            {
                "$ref": "#/parameters/VersionQueryParam"
            }
            ],
            "post": {
                "summary": "Create workspace",
                "description": "",
                "tags": [
                    "Workspaces"
                ],
            "security": [
            {
                "basicAuth": []
            },
            {
            "OauthSecurity": [
                "adminauth"
            ]
        }
    ],
    "consumes": [
        "application/json"
    ],
    "produces": [
        "application/json"
    ],
    ...
    ...

    ```
4. Empty Response Object

    If there is an empty reponse object in the specification, MFP has issue with generation of the adapter, so we recommend to remove the empty reponse object in openAPI specification

    Here is an example of empty response object :

    ```
    "responses": {
        "200": {
            "schema": {
            "$ref": "#/definitions/EmptyObject"
        },
        "description": "Successful request."
    },

    "EmptyObject": {
        "properties": {}
    }

    ```

    In the above example, EmptyObject don't have any properties defined and is empty. MFP will have issue with generation of adapter in such scenarios, in this case we recommend to remove the EmptyObject schema from the respose object, that means, the above specification should be changed to :

    ```
    "responses": {
        "200": {
            "description": "Successful request."
        }
    }

    ```

5. Missing Consumes and Produces Content-types in specification

    All the REST endpoints in the OpenAPI specification should have **Consumes** and **Produces** Content-types. The generated adapter can fail in calling the backend service if this is not specified or incorrectly given in the specification

    ```
    "consumes": [
        "application/json"
    ],
    "produces": [
        "application/json"
    ]
    ```

6. Mismatch in specification on request and response contents

    Many of the OpenAPI specification is not usually updated with the changes in the backend REST API. This can results in adapter call failures due to the content mismatch. Make sure that the request and response contents in the specification matches with what is defined by the backend REST API

