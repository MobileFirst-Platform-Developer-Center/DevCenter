---
title: Web development using Ionic 2 and Mobile Foundation
date: 2016-12-26
tags:
- MobileFirst_Foundation
- Mobile_Foundation
- Ionic
- Bluemix
- Web
version: 8.0
author:
  name: Andrii Vasylchenko
---

## Overview:
We all know that **IBM MobileFirst Foundation** can be used to develop pure web applications. **Ionic**, which is one of most popular hybrid development frameworks, since version 2 also fully support web development. This blog post is targeted to show up how to setup web development environment combining **Ionic 2 Framework with CLI** and **Mobile Foundation Bluemix service with Web SDK**

## Prerequisites:  
While in general it is well known how to setup all of required components separately, i would highly recommend to read following materials:

* [Using Mobile Foundation on Bluemix Service](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/using-mobile-foundation/)

* [Setting up the Web development environment](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/)

* [Adding the MobileFirst Foundation SDK to Web Applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/web/)

* [Integrating MobileFirst Foundation 8.0 in Ionic 2 based apps](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

Additionally to follow our quick start sample you will need to have following packages installed: node, npm, maven, python, cordova, ionic. You also need to setup Mobile Foundation Bluemix service and mfpdev-cli before continue.

## Challenges:
After reading general setup guides for web development with **IBM MobileFirst Foundation** we can highlight several challenges that needs to be resolved in order to setup web development environment with **Ionic 2**

1. MobileFirst Foundation Web SDK installation will not lead to SDK appearance under www/build folder due to Ionic 2 build nature using npm scripts. We will need either manually copy ibm-mfp-web-sdk folder from node_modules and loose "npm update" benefits or design a better option

2. "mfpdev app preview" command won't work due to a "no mobile platforms" related error. So we will need to use "ionic serve" or setup our own live-reload server

3. We will face "Access-Control-Allow-Origin" error, cause our dev server will be on Bluemix and we will make cross-domain requests. We will need to handle redirect either manually with our live-reload server config or push ionic live-reload server to do it for us

## Quick start

> **Note:** In this blogpost we will be using Ionic 2 RC.4

Let's start with creating a simple ionic 2 (TypeScript) based project. Open terminal and type the following command:

```shell
ionic start websample blank --v2 --ts
```

Where `websample` is our project name, `blank` is the name of smallest ionic 2 project template and other 2 parameters specifies ionic version and typescript usage.

By default, depending on your operation system, you may have native platform installed automatically. In our demo case, cause we are on Mac OS, iOS platform was added. We can check what platforms are installed by using following commands:

```shell
cd websample
ionic platform list
```

![ionic-platform-list]({{site.baseurl}}/assets/blog/2016-12-26-web-development-using-ionic-2-and-mobile-foundation/1-platformlist.png)

We need to remove all installed platforms and then add "browser" to proceed with web development approach

```shell
ionic platform remove ios
ionic platform add browser
```

Now we can add MobileFirst Foundation Web SDK using NPM. For that type in terminal:

```shell
npm install ibm-mfp-web-sdk --save
```

`--save` will mean that this plugin will be saved to root node_modules folder with all dependencies and installation will touch package.json by adding it to dependencies list.

![web-sdk-install]({{site.baseurl}}/assets/blog/2016-12-26-web-development-using-ionic-2-and-mobile-foundation/2-websdkinstall.png)

We are going to solve our first challenge by using Ionic 2 app-scripts. You can learn about them more [here](https://github.com/driftyco/ionic-app-scripts). In particular we will need to modify ionic_copy script config, located under `node_modules/@ionic/app-scripts/config/copy.config.js`, that is responsible for copying any kind of files during ionic build process. Add the following code after last `copyPolyfills` task:

```js
  copyMFPcore: {
    src: ['{{ROOT}}/node_modules/ibm-mfp-web-sdk/*.js'],
    dest: '{{BUILD}}/mfp'
  },
  copyMFPmessages: {
    src: ['{{ROOT}}/node_modules/ibm-mfp-web-sdk/lib/messages/**/*.json'],
    dest: '{{BUILD}}/mfp/lib/messages'
  },
  copyMFPanalytics: {
    src: ['{{ROOT}}/node_modules/ibm-mfp-web-sdk/lib/analytics/*.js'],
    dest: '{{BUILD}}/mfp/lib/analytics'
  },
  copySJCL: {
    src: ['{{ROOT}}/node_modules/sjcl/*.js'],
    dest: '{{BUILD}}/mfp/node_modules/sjcl'
  },
  copyJSSHA: {
    src: ['{{ROOT}}/node_modules/jssha/src/*.js'],
    dest: '{{BUILD}}/mfp/node_modules/jssha/src'
  },
  copyPromiz: {
    src: ['{{ROOT}}/node_modules/promiz/*.js'],
    dest: '{{BUILD}}/mfp/node_modules/promiz'
  }
```

Where `copyMFPcore` responsible for copying ibmmfpf.js, `copyMFPanalytics` for ibmmfpfanalytics and other are their dependencies.

> **Note:** We are placing  sjcl,jssha and promiz under `node_modules` folder cause ibmmfpf.js script is looking for them using relative path.

The whole file now should look like this

![copy-config]({{site.baseurl}}/assets/blog/2016-12-26-web-development-using-ionic-2-and-mobile-foundation/3-copyconfig.png)

We will use "ionic serve" to overcome second challenge, but for that there is a need to setup url forwarding, similar to how it done [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/#using-nodejs). Ionic 2 cli has build-in proxy capabilities and we just need to configure them by editing ionic.config.json file in root folder of our project. Details about how to use proxy can be found [here](https://github.com/driftyco/ionic-cli#advanced-serve-options)

```json
"proxies": [
  {
    "path": "/mfp",
    "proxyUrl": "https://mobilefoundation-hello-world-web-sample.mybluemix.net:443/mfp"
  }
]
```

where `proxyUrl` is our path to Bluemix based Mobile Foundation instance and `mfp` is our runtime name. This will automatically forward all requests that comes to `/mfp` (for example `/mfp/api/adapters/javaAdapter/resource/unprotected`) to `https://mobilefoundation-hello-world-web-sample.mybluemix.net:443/mfp/api/adapters/javaAdapter/resource/unprotected` instead of calling it from localhost.

Next step for us will be to load our ibmmfpf.js inside index.html head section. For that open index.html from src folder and add the following line before end of <HEAD>

```html
<script type="text/javascript" src="build/mfp/ibmmfpf.js"></script>
```

> **Note:** Make sure you are adding it to src/index.html and not www/index.html, cause last one will be rewritten during build process.

To be able to use WL API we need to add typings reference. This can be done by opening file `src/declarations.d.ts` and adding the following line

```js
/// <reference path="../node_modules/ibm-mfp-web-sdk/lib/typings/ibmmfpf.d.ts" />
```

> **Note:** Make sure you put "///" before reference tag

Let's also add a client side code to verify server connectivity and simple adapter call. In out quick start sample we will do it in `src/pages/home/home.ts` file. We will add MfpInit function under HomePage class

```js
MfpInit() {
  console.debug('-- trying to init WL client');
  var wlInitOptions = {
      mfpContextRoot : '/mfp',
      applicationId : 'com.ibm.websample'
  };
  WL.Client.init(wlInitOptions).then(
      function() {
        console.debug('-- WL client init done');

          console.debug('-- trying to obtain authorization token');
          WLAuthorizationManager.obtainAccessToken().then(
            function(success){
              console.debug('-- succesfully got a token');
              console.debug('-- trying to call unprotected adapter');
              var resourceRequest = new WLResourceRequest(
                  "/adapters/javaAdapter/resource/unprotected/",
                  WLResourceRequest.GET
              );

              resourceRequest.send().then(
                  function(response) {
                      // Will display "Hello world" in an alert dialog.
                      console.debug("-- success: " + response.responseText);
                  },
                  function(response) {
                      console.error("-- failure: " + JSON.stringify(response));
                  }
              );
            },
            function(failure){
              console.error('-- failed to get a token');
            }
          );
       });
}
```

And then will make sure it is called from constructor

```js
this.MfpInit();
```

Whole file will look like this

![home-ts]({{site.baseurl}}/assets/blog/2016-12-26-web-development-using-ionic-2-and-mobile-foundation/4-homets.png)

Now we can deploy java adapter from samples (or pre-build version from [here](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/javaAdapter.adapter))

<img class="gifplayer" alt="deploy-adapter" src="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/web/create-an-adapter.png" />

Register our application with applicationID "com.ibm.websample" in MobileFirst Operations Console

<img class="gifplayer" alt="register-app" src="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/web/register-an-application-web.png" />

> **Note:** Make sure you set Application ID to "com.ibm.websample" during web application registration

And, finally, start our live reload server using Ionic CLI

```shell
ionic serve
```

You should now be able to see in Developer's console messages about successful WL client int, obtained token and adapter call.

![running-app]({{site.baseurl}}/assets/blog/2016-12-26-web-development-using-ionic-2-and-mobile-foundation/5-runningapp.png)

## Conclusion

We managed to prepare our web development environment and quick start client-side application with **Ionic 2** and **IBM MobileFirst Foundation**. By following this blog you will have everything you need to start creating you first web apps.
