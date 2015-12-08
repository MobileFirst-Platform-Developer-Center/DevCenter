---
layout: tutorial
title: Translation
relevantTo: [cordova]
downloads:
  - name: Download MobileFirst project
    url: https://github.com/MobileFirst-Platform-Developer-Center/Translation
---

## Overview
You can use the IBM MobileFirst Platform Foundation framework to add multilingual translation of Cordova applications into other languages. Items that can be translated are application strings and system messages.  
The platform can automatically translate application strings according to a designated file.
This tutorial covers the following topics:

* [Enabling translation of application strings](#enabling-translation-of-application-strings)
* [Enabling translation of system messages](#enabling-translation-of-system-messages)
* [Multilanguage translation](#multilanguage-translation)
* [Detecting the device locale and language](#detecting-the-device-locale-and-language)
* [Sample application](#sample-application)

## Enabling translation of application strings
You can find the `messages.js` file, which is intended for application strings, in the `common\js` folder.

```JavaScript
Messages = {
  headerText: "Default header",
  actionsLabel: "Default action label",
  sampleText: "Default sample text",
};
```

Application messages that are stored in the `messages.js` file can be referenced in two ways:

* As a JavaScript object property:  

```JavaScript
Messages.headerText
```

* As an ID of an HTML element with `class="translate"`:

```html
<h1 id="headerText" class="translate"></h1>
```

## Enabling translation of system messages
It is also possible to translate the system messages that the application displays, for example "Internet connection is not available" or "Invalid username or password".
System messages are stored in the `WL.ClientMessages` object.
You can find a full list of system messages in the `www\default\worklight\messages\messages.json` file, which is inside the generated projects (iOS, Android, Windows Phone 8, and so on,…).
To enable the translation of a system message, override it in your JavaScript application.
[code lang="javascript"]
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
[/code]</p>
<p>Override system messages at a global JavaScript level because some parts of the code are executed only after the application has successfully initialized.</p>

## Multilanguage translation
<p>Using JavaScript, you can implement multilanguage translation for your applications.</p>
<ol>
<li>Set up the default application strings in the `messages.js` file.
[code lang="javascript"]
Messages = {
  headerText: "Default header",
  actionsLabel: "Default action label",
  sampleText: "Default sample text",
  englishLanguage : "English",
  frenchLanguage : "French",
  russianLanguage : "Russian",
  hebrewLanguage : "Hebrew"
};
[/code]</p>
</li>
<li>Override specific strings when required.
[code lang="javascript"]
function setFrench(){
  Messages.headerText = "Traduction";
  Messages.actionsLabel = "Sélectionnez une langue:";
  Messages.sampleText = "Ceci est un exemple de texte en français.";
}
[/code]
</li>
<li>Update the GUI components with the new strings.
You can perform more tasks, such as setting the text direction for right-to-left languages such as Hebrew or Arabic.
Each time that an element is updated, it is updated with different strings according to the active language.</p>
<p>[code lang="javascript"]
function languageChanged(lang) {
  if (typeof(lang)!="string")
    lang = $("#languages").val();</p>
<p>    switch (lang){
      case "english":
        setEnglish();
        break;
      case "french":
        setFrench();
        break;
      case "russian":
        setRussian();
        break;
      case "hebrew":
        setHebrew();
        break;
    }</p>
<p>    if ($("#languages").val()=="hebrew")
      $("#wrapper").css({direction: 'rtl'});
    else
      $("#wrapper").css({direction: 'ltr'});</p>
<p>    $("#sampleText").html(Messages.sampleText);
    $("#headerText").html(Messages.headerText);
    $("#actionsLabel").html(Messages.actionsLabel);
}
[/code]
</li>
</ol>

## Detecting the device locale and language
<p>It is possible to detect the locale and the language of the device.
Use the `WL.App.getDeviceLocale()` and `WL.App.getDeviceLanguage()` functions to detect the current locale.
[code lang="javascript"]
var locale = WL.App.getDeviceLocale();
var lang = WL.App.getDeviceLanguage();
WL.Logger.debug(">> Detected locale: " + locale);
WL.Logger.debug(">> Detected language: " + lang);
[/code]
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/05_05_detected-logs.png"><img src="{{ site.baseurl }}/assets/backup/05_05_detected-logs.png" alt="05_05_detected-logs" width="505" height="65" class="alignnone size-full wp-image-1327" /></a></p>

## Sample application
<p><a href="https://github.com/MobileFirst-Platform-Developer-Center/Translation" target="_blank">Click to download</a> the MobileFirst project.</p>
