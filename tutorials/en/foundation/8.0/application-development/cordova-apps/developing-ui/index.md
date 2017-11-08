---
layout: tutorial
title: Developing UI for Cordova Applications
breadcrumb_title: Developing UI
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Designing and implementing the UI of an application is an important part of the development process. {{ site.data.keys.product_adj }} Eclipse plugin along with Thym plugin assists with the development of cordova applications.
Writing custom CSS style for each component from scratch can deliver a high level of customisation, but doing this also requires a large amount of resources.
Sometimes it is better to use the existing JavaScript UI frameworks.
This topic describes how to develop {{ site.data.keys.product_adj }} applications with two UI frameworks jQuery Mobile and a WYSIWYG editor provided in {{ site.data.keys.product_adj }} Studio’s Eclipse.


## WYSIWYG Editor
{: #wysiwyg-editor }
A basic WYSIWYG editor is provided for Mobile widgets for developer convenience.
This editor provides the basic palette for the user to drag and drop a simple button or a text box and other HTML widgets. This is a Rapid Mobile Application Development tool that enables the user to develop a basic cordova application quickly.

![WYSIWYG Editor](wysiwyg-editor.png)

## jQuery Mobile
{: #jquery-mobile }
jQuery is a fast and concise JavaScript framework that simplifies HTML document flow, event handling, animations, and Ajax interactions for rapid web development. jQuery Mobile is a touch-optimized web framework for smartphones and tablets. jQuery Mobile requires jQuery to run.

To add jQuery mobile to your application, do the following:

1. Download Eclipse and install [Thym](http://marketplace.eclipse.org/content/eclipse-thym) and [MobileFirst platform plugin](http://marketplace.eclipse.org/content/ibm-mobilefirst-foundation-studio) from the market place.
2. Create a Thym project in eclipse by clicking **File -> New -> new Hybrid Mobile (Cordova) application project**.
3. [Download jQuery mobile package](http://jquerymobile.com/download/).
4. Copy the downloaded jQuery Mobile package into the `www` directory of your hybrid application, as shown in the image below
  ![www directory](www-dir.png)
5. Open the main `index.html` as shown in the screenshot and add the jQuery references (shown in the snippet) to the project:
    ![Add JQuery references](add-jquery-refs.png)

    ```html
      <!DOCTYPE HTML>
      <html>
          	<head>
          		<meta charset="UTF-8">
          		<title>appName</title>
          		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
          		<!--
          			<link rel="shortcut icon" href="images/favicon.png">
          			<link rel="apple-touch-icon" href="images/apple-touch-icon.png">
          		-->
          		<link href="jqueryMobile/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.structure-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.theme-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.theme-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.external-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-png-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.inline-svg-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.external-png-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.inline-png-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/theme-classic.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-svg-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.structure-1.4.5.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/jquery.mobile.inline-svg-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.theme-1.4.5.min.css" rel="stylesheet">
          		<link href="jqueryMobile/demos/css/jquery.mobile.external-png-1.4.5.min.css" rel="stylesheet">
          		<link rel="stylesheet" href="css/main.css">
          		<script>window.$ = window.jQuery = WLJQ;</script>
          		<script src="jqueryMobile/demos/jquery.js"></script>
          		<script src="jqueryMobile/demos/jquery.mobile-1.4.5.js"></script>
          	</head>
          	<body style="display: none;">
          		<div data-role="page" id="page">
          			<div data-role="content" style="padding: 15px">
          				<!--application UI goes here-->
          				Hello MobileFirst
          			</div>
          		</div>
          		<script src="js/initOptions.js"></script>
          		<script src="js/main.js"></script>
          		<script src="js/messages.js"></script>
          	</body>
      </html>
    ```
