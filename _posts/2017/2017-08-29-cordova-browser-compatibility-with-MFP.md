---
title: MobileFirst Platform on cordova browser platform
date: 2017-08-29
version:
- 8.0
tags:
- MobileFirst_Foundation
- cordova
author:
  name: Srutha K Kotta
---
---
title: MobileFirst Platform on cordova browser platform
date: 2017-08-29
version:
- 8.0
tags:
- MobileFirst_Foundation
- cordova
author:
  name: Srutha K Kotta
---

The MobileFirst Platform now supports the cordova browser platform along with the earlier supported platforms of cordova windows, cordova android, and cordova ios.

The usage is very similar to using MobileFirst Platform (MFP) with any of the other platforms. A simple sample to test this new feature is below.

Create a cordova application using the following command:
```bash
cordova create <your-appFolder-name> <package-name>
```
This will create a vanilla cordova app.

Add the MFP plugin using the following command:
```bash
cordova plugin add cordova-plugin-mfp
```
Add a button that can be used to ping your MFP server(the server could be your locally hosted server or server on Bluemix). Ping your MFP server on click of the button.
You can use the sample code below:

**index.html**

```html
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
  <meta name="format-detection" content="telephone=no">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">


  <link rel="stylesheet" type="text/css" href="css/index.css" />

  <!-- load script with wlCommonInit defined before loading cordova.js -->
  <script type="text/javascript" src="js/index.js"></script>
  <script type="text/javascript" src="cordova.js"></script>

  <title>MFP Starter - Cordova</title>
</head>

<body>

  <div id="main">
    <div id="main_title">Hello MobileFirst</div>
    <div id="main_status"></div>
    <div id="main_info"></div>
  </div>

  <div id="button_content">
    <button id="ping_button" style="display:none">Ping MobileFirst Server</button>
  </div>

</body>

</html>
```

**index.js**

```javascript

var Messages = {
  // Add here your messages for the default language.
  // Generate a similar file with a language suffix containing the translated messages.
  // key1 : message1,
};

var wlInitOptions = {
  // Options to initialize with the WL.Client object.
  // For initialization options please refer to IBM MobileFirst Platform Foundation Knowledge Center.
   mfpContextRoot : '/mfp', // "mfp" is the default context root in the MobileFirst Development server
    applicationId : 'io.cordova.hellocordova' // Replace with your own app id/package name.
};

function wlCommonInit() {
  app.init();
}

var app = {
  //initialize app
  "init": function init() {
    var buttonElement = document.getElementById("ping_button");
    buttonElement.style.display = "block";
    buttonElement.addEventListener('click', app.testServerConnection, false);
  },
  //test server connection
  "testServerConnection": function testServerConnection() {

    var titleText = document.getElementById("main_title");
    var statusText = document.getElementById("main_status");
    var infoText = document.getElementById("main_info");
    titleText.innerHTML = "Hello MobileFirst";
    statusText.innerHTML = "Connecting to Server...";
    infoText.innerHTML = "";

    WLAuthorizationManager.obtainAccessToken()
      .then(
        function (accessToken) {
          titleText.innerHTML = "Yay!";
          statusText.innerHTML = "Connected to MobileFirst Server";
        },
        function (error) {
          titleText.innerHTML = "Bummer...";
          statusText.innerHTML = "Failed to connect to MobileFirst Server";
        }
        );
    },
 }

```

>**Note:** It is important to mention the `mfpContextRoot` and `applicationId` in the **wlInitOptions** in index.js file.

**index.css**

```css
body {
    position: static;
    font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
    font-weight: 300;
    margin: 0px;
	padding: 0px;
}

#button_content {
  position: absolute;
  bottom: 10%;
  width: 100%;
}

#ping_button {
  display: block;
  margin: 0 auto;
  height: 50px;
  width: 240px;
  font-size: 20px;
  color: white;
  background-color: #325c80;
}

#main {
  top: 10%;
  position: absolute;
  text-align: center;
  width: 100%
}

#main_title {
  font-size: 40px;
}

#main_status {
  font-size: 20px;
  margin-top: 10px;
}

#main_info {
  font-size: 14px;
  margin-top: 10px;
}

```

<!--
Add the browser platform using the following command:
```bash
cordova platform add browser
```

 (Register the app to the MFP server. The **mfpdev-cli** from version -.-.- and above recognizes cordova browser applications as web platform applications. If you are using a lower version then you can either upgrade to the latest version or manually register your application. -->

> To manually register your application:
>
* Login to your MFP server's console.
* Click the **New** button next to the _*Applications*_ option.
* Provide a name to your application, select **Web** as the platform and provide your application's id (which was defined in the **wlInitOptions** function of your `index.js`).
>
>**Remember:** Add the server details to the `config.xml` of your application.

<!--If you are using **mfpdev-cli** (more about the `cli` commands can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSHSCD_8.0.0/com.ibm.worklight.dev.doc/dev/t_gs_cli.html)), add the MFP server using the following command:

```bash
mfpdev server add
```
Set it as the default server.

Register your application with the following command:

```bash
mfpdev app register
```
-->

 
 >Note: mfpdev-cli to register browser platform app will be released soon.

Then execute the following commands:

```bash
cordova prepare
cordova build
cordova run
```

<!--This will launch two browsers. One of the browser runs on cordova browser's proxy server (that runs on port `8000`, generally) which cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)). The other browser would be an MFP proxy server (this runs on port `9081`) that will serve MFP requests.

If you click the button to ping MFP on the browser running on port `8000`, the ping will fail whereas clicking the button that runs on localhost port `9081` will be successful. All the cordova browser compatible cordova plugins and MFP features can be used without issues.-->

This will launch a browser that runs on a proxy server (on port '9081') and connects to the MFP server. The cordova-browser's default proxy server(that runs on port '8000') has been suppressed as it cannot connect to the MFP server due to the [same-origin-policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)).

> The default browser to run is set to **Chrome**. Use the `--target` option to run on different browsers and can be used using the following command:
```bash
 cordova run --target=Firefox
 ```

The app can be previewed using the command:

```bash
mfpdev app preview
```

The only supported browser option is _*Simple Browser Rendering*_. The option _*Mobile Browser Support*_ is not supported for the browser platform.


### Adding the proxy MFP server to a Bluemix nodejs runtime

You can deploy your browser application on bluemix as a nodejs instance.
Steps to create this nodejs instance is as below:

* Create a nodejs instance (from the Bluemix **Catalog**, Select **SDK for Node.js** from under **Cloud Foundry Apps**) in Bluemix and download the sample application.
* Add the contents of the browser platform's `www` folder from your cordova project (i.e. `/rootFolderOfYourCordovaApp/platforms/browser/`) to the `public` folder. Ensure that the `index.js` and `index.css` are not within the `js` and `css` folders but are in the same folder level as the `index.html`.
* Change the reference of the `index.js` in `index.html` to point to where the `css` and `js` files are now located in the project.
* Next replace contents of the `app.js` with the contents of `proxy.js` (the `proxy.js` can be found in `<your cordova project's root folder>/plugins/cordova-plugin-mfp/src/browser/`) of your cordova project.


**Changes to `app.js`**

Add these lines at the top of the file

```javascript
var path = require('path');
var cfenv = require('cfenv');
```

Replace app.use('/' + appName, express.static(__dirname + '/../../../../www')); with below line

```javascript
app.use(express.static(path.join(__dirname, './public')));
```

Add the below lines in the end of the file

```javascript
// get the app environment from Cloud Foundry
var appEnv = cfenv.getAppEnv();

// start server on the specified port and binding host
app.listen(appEnv.port, '0.0.0.0', function() {
  // print a message when the server starts listening
  console.log("server starting on " + appEnv.url);
});
```
<br/>
Add the dependent node_module dependencies in the dependencies list in the `package.json` file in your nodejs sample's root folder like below :

```
"dependencies": {
//List of already existing dependencies ,
	 "body-parser": "^1.16.1",
    "cfenv": "^1.0.x",
    "cloudant": "^1.7.1",
    "cordova-serve": "^1.0.1",
    "dotenv": "^4.0.0",
     "express": "^4.13.3",
     "nopt":"4.0.1",
     "elementtree":"0.1.7",
    "npmlog":"4.0.2",
    "underscore":"1.8.3",
    "request": "^2.0.0"
	}
```

Copy the folders `sjcl` and `jssha` from `rootFolderOfNodeApp/public/plugins/cordova-plugin-mfp/worklight/node_modules` to its parent folder, i.e. `rootFolderOfNodeApp/public/plugins/cordova-plugin-mfp/worklight` and change the reference of these modules in the `ibmmfpf.js` file that can be found in `rootFolderOfNodeApp/public/plugins/cordova-plugin-mfp/worklight`, to point to the new location.

Replace

```javascript
WL.Utils.loadLibrary('.node_modules/sjcl/sjcl.js', function(sjcl){});
WL.Utils.loadLibrary('.node_modules/jssha/src/sha.js', function(sha){window.jsSHA = sha;});
```
with the below lines

```javascript
WL.Utils.loadLibrary('./sjcl/sjcl.js', function(sjcl){});
WL.Utils.loadLibrary('./jssha/src/sha.js', function(sha){window.jsSHA = sha;});
```


To verify, execute the following commands:

```bash
npm install
npm start
```
in the node app's root folder. There should be no errors and the build must succeed.

>**Note:** The app will not be visible running on `localhost:9081`.

The app can be pushed onto node on Bluemix with the help of cf cli (the installation options can be found <a href="https://www.ibm.com/watson/developercloud/doc/common/getting-started-cf.html">here</a>)
Now, execute the cf command:

```bash
cf api [api endpoint]
```
The list of api endpoints for each region are:

| Region  | API endpoint |
| ------------- | ------------- |
| US South  | https://api.ng.bluemix.net  |
| United Kingdom  | https://api.eu-gb.bluemix.net  |
| Germany  | https://api.eu-de.bluemix.net |
| Sydney  | https://api.au-syd.bluemix.net |


Execute `cf login`, enter your _*username*_ and _*password*_. Execute a `cf push [appName]`. After the push is completed, you can find your application successfully deployed on Bluemix.


### Using WebSphere Liberty to serve cordova browser resources

Follow the instruction to use WebSphere Liberty in <a href="http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/installation-configuration/development/web/">this</a> tutorial and make the below changes.

Add the entire contents of your browser project's `www` folder to `[MyWebApp] → src → Main → webapp ` as mentioned in Step 1 of "Building the Maven webapp with the web application’s resources" section of the above tutorial. Finally register your app on your Liberty server and test it by running it in the browser with the path `localhost:9080/MyWebApp`. Also add the `sjcl` and `jssha` folders to their parent folder and change their reference in the `ibmmfpf.js` file (this step can be found in more detail in the **Adding the proxy MFP server to a Bluemix nodejs runtime** section).
