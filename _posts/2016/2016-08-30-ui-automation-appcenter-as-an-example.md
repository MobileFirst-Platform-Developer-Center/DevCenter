---
title: Using Appium to automate UI testing
date: 2016-08-30
tags:
- MobileFirst_Foundation
- Application_Store
- Automation
- Mobile_Automation
- Automation_frameworks
version:
- 8.0
author:
  name: Vinod Appajanna
---
## Introduction
One of the most widely used Web and Mobile UI Automation framework is Appium/Selenium-Webdriver, in this blog I will touch upon on how we can use this for MFP AppCenter application. Appium/Selenium-Webdriver  provides a single, free and open protocol for testing without having to recompile or modify the app. I will not get into in-depth details of Appium and Selenium-Webdriver since there are plenty of examples and documentation around the same. For more details see the reference section.

I have taken up the the below use-case (AppCenter) for the automation

On the Web side:

* Login into AppCenter console using the browser
* Visit the Catalog page and upload an app

On the mobile side:

* Login into the AppCenter using the AppCenter mobile client app
* View the uploaded app

## Installation or the Prerequisites for the Automation
The installation is very simple and straight forward.

* From the development perspective we just need have the dependency

  ```xml
	     <dependency>
             <groupId>junit</groupId>							
             <artifactId>junit</artifactId>							
             <version>3.8.1</version>							
             <scope>test</scope>								
        </dependency>				
        <dependency>				
            <groupId>org.seleniumhq.selenium</groupId>			
            <artifactId>selenium-java</artifactId>		
            <version>2.45.0</version>
	      </dependency>		
        <dependency>				
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>6.8</version>								
            <scope>test</scope>
       </dependency>
       <dependency>
            <groupId>io.appium</groupId>
            <artifactId>java-client</artifactId>
            <version>3.0.0</version>
            <scope>test</scope>
        </dependency>
  ```

* Download the TestNg framework plugin into the development editor. If you are using Eclipse you can use Market place to install the same
* [chrome and firefox driver downloads] (http://www.seleniumhq.org/download/)
* [Install Appium (server + inspector)] (http://appium.io)

## DOM inspectors
Using inspector one can inspect the DOM elements of the Hybrid mobile App or the Web html. Here we use it for extracting the xpaths that is used in the code for setting and getting the values to or from the mobile or web elements.

<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/UcLxXexv3bI"></iframe>
  </div>
</div>
<p style="text-align: center;">Mobile app and Web inspectors</p>

## Running the tests from Eclipse studio
<div class="sizer">
  <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.youtube.com/embed/i_aFPaO2pq8"></iframe>
  </div>
</div>
<p style="text-align: center;">Running the TestNg tests from studio</p>

## Running the Automation using Jenkins (optional)
* Go to http://jenkins-ci.org/and download correct package for your OS. Install Jenkins
* Import the Maven project into Jenkins server
* Trigger the builds manually or schedule it

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
      <iframe src="https://www.youtube.com/embed/5sWLIvAcI5Y"></iframe>
    </div>
</div>
<p style="text-align: center;">Running the TestNg tests from eclipse studio</p>


## Sample
The sample runs the following tests:

* AppCenterClientLogin Class runs mobile login and list catalog test
* AppCenterWebLoginAndUpload Class runs weblogin, list catalog and upload the app tests
* [Download application center automation project (maven)](https://github.com/vinapp/UIAutomationAppCenter)
</br></br>
**Note:** Make sure you update datafile.properties file. If you have seen the above demos this file has the details of the hostname, port, context etc. So please update this before running the tests.

## Conclusion
By now you would have seen the ease and the power of using these defacto standard automation frameworks for running the UI tests. So now think of using this for your UI as well.

## References
1. [Appium] (http://appium.io/)
2. [Appium Getting Started] (http://appium.io/getting-started.html)
3. [iOS Device - Appium] (https://testobject.com/blog/2016/01/how-to-test-ios-apps-with-appium-on-os-x.html)
4. [iOS Simulator - Appium] (https://www.youtube.com/watch?v=d1u58t-ko6s)
5. [Maven, Jenkins and Selenium] (http://www.guru99.com/maven-jenkins-with-selenium-complete-tutorial.html)
