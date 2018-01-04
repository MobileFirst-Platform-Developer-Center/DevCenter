---
title: Obfuscating Android code using Proguard in MobileFirst Foundation 8.0
date: 2016-09-19
tags:
- MobileFirst_Foundation
- Android
- Obfuscation
- Proguard
version:
- 8.0
author:
  name: S.A.Norton Stanley
---
Obfuscation helps protecting your application against reverse engineering by others.  

You can use the Android ProGuard tool to obfuscate, shrink, and optimize your code. ProGuard renames classes, fields, and methods with semantically obscure names and removes unused code. [Learn more about Proguard](https://developer.android.com/studio/build/shrink-code.html).

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/rYoHK5JsMjs"></iframe>
    </div>
</div>

### Obfuscating a Cordova-based Android application

Create a hybrid application as described [in the Cordova Quick Start tutorial](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/cordova/). The application created will have the structure as seen below

![Hybrid Project Structure]({{site.baseurl}}/assets/blog/2016-09-19-mobilefirst-foundation-80-obfuscating- android-code-with-proguard/hybridappstructure.png)

Import the Android application into Android Studio 

![Hybrid Project Android Studio Structure]({{site.baseurl}}/assets/blog/2016-09-19-mobilefirst-foundation-80-obfuscating- android-code-with-proguard/androidstudiostructure.png)

### Enabling proguard and obfuscating the apk
The application contains a file name **proguard-project.txt** or **proguard-rules.pro**. This file contains the optimal rules required to obfuscate an Android application. This file can be further modified to include more rules if one requires further obfuscation. 

In the rules provided comment out the following.
These are not required since the default proguard configuration already handles this.

```xml
#-injars      bin/classes
#-injars      libs
#-outjars     bin/classes-processed.jar
```

MobileFirst Foundation 8.0 uses OkHttp library, so we will need to inform Proguard not to warn us about the files not being present directly. To do this include the following into **proguard-project.txt** file.

```
-dontwarn okio.**
-dontwarn com.squareup.okhttp.**
```

The final **proguard-project.txt** should look as below:

```
# To enable ProGuard in your project, edit project.properties
# to define the proguard.config property as described in that file.
# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in ${sdk.dir}/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the ProGuard
# include property in project.properties.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

#-injars      bin/classes
#-injars      libs
#-outjars     bin/classes-processed.jar

# Using Google's License Verification Library 
-keep class com.android.vending.licensing.ILicensingService

# Specifies to write out some more information during processing. 
# If the program terminates with an exception, this option will print out the entire stack trace, instead of just the exception message.
-verbose

####################################################################################################
##############################  IBM MobileFirst Platform configuration  ############################
####################################################################################################
# Annotations are represented by attributes that have no direct effect on the execution of the code. 
-keepattributes *Annotation*

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keepattributes InnerClasses
-keep class **.R
-keep class **.R$* {
    <fields>;
}

# These options let obfuscated applications or libraries produce stack traces that can still be deciphered later on 
-renamesourcefileattribute SourceFile    
-keepattributes SourceFile,LineNumberTable

# Enable proguard with Cordova
-keep class org.apache.cordova.** { *; }
-keep public class * extends org.apache.cordova.CordovaPlugin

-keep class com.worklight.androidgap.push.** { *; }
-keep class com.worklight.wlclient.push.** { *; }
-keep class com.worklight.common.security.AppAuthenticityToken { *; }

# Enable proguard with Google libs
-keep class com.google.** { *;}
-dontwarn com.google.common.**
-dontwarn com.google.ads.**

# apache.http
-keep class org.apache.http.** { *; }
-dontwarn org.apache.http.**
-optimizations !class/merging/vertical*,!class/merging/horizontal*,!code/simplification/arithmetic,!field/*,!code/allocation/variable

-keep class net.sqlcipher.** { *; }
-dontwarn net.sqlcipher.**

-keep class org.codehaus.** { *; }
-keepattributes *Annotation*,EnclosingMethod

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keepclassmembers class * implements javax.net.ssl.SSLSocketFactory {
   private  javax.net.ssl.SSLSocketFactory delegate;
}

# Remove debug logs in release build
-assumenosideeffects class android.util.Log {
    public static *** d(...);
}

# These classes contain references to external jars which are not included in the default MobileFirst project.
-dontwarn com.worklight.common.internal.WLTrusteerInternal*
-dontwarn com.worklight.jsonstore.**
-dontwarn org.codehaus.jackson.map.ext.*
-dontwarn com.worklight.androidgap.push.GCMIntentService
-dontwarn com.worklight.androidgap.plugin.WLInitializationPlugin
-dontwarn com.worklight.wlclient.push.GCMIntentService
-dontwarn org.bouncycastle.**
-dontwarn com.worklight.androidgap.jsonstore.security.SecurityManager

-dontwarn com.worklight.wlclient.push.WLBroadcastReceiver
-dontwarn com.worklight.wlclient.push.common.*
-dontwarn com.worklight.wlclient.api.WLPush
-dontwarn com.worklight.wlclient.api.SecurityUtils

-dontwarn android.support.v4.**
-dontwarn android.net.SSLCertificateSocketFactory
-dontwarn android.net.http.*
-dontwarn okio.**
-dontwarn com.squareup.okhttp.**
################################################################################
```

The next step is to enable Proguard in the **build.gradle** file of the app module. To enable Proguard include the following within the `android {}` tag of the **build.gradle** file

```
buildTypes {
    release {
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-project.txt'
    }
}
```

This indicates that Proguard is to be enabled in release mode, and the rules to be used are the default Android rules as well as those mentioned above.

The final step is to disable the missing translation check in Lint.  
Tne Lint tool checks your Android project source files for potential bugs and optimization improvements for correctness, security, performance, usability, accessibility, and internationalization. More information [in the Lint page](https://developer.android.com/studio/write/lint.html).

The default Cordova project does not contain certain tranlation text for all languages, hence we will need to inform Lint to disable the check for missing translation. To do this, in the **build.gradle** file of the app module look for **lintoptions**. The default setting would be as below:

```
lintOptions {
    abortOnError false;
}
```

Modify this to disable the missing transaltions as below:

```
lintOptions {
    abortOnError false;
    disable 'MissingTranslation'
}
```

In case the **lintOptions** tag is not present, include this within the `android{}` tag.

Now clean and re-build the project and generate a signed .apk. The generated .apk file should be obfuscated with the rules provided. The obfuscated apk contents will be as shown here:

![Obfuscated Structure]({{site.baseurl}}/assets/blog/2016-09-19-mobilefirst-foundation-80-obfuscating- android-code-with-proguard/obfuscated.png)


### Obfuscating a native Android application

Create a native Android application as described [in the Android Quick Start tutorial](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/android/). 

Import the Android application created into Android Studio. The project structure will look as below.

![Android Studio Structure]({{site.baseurl}}/assets/blog/2016-09-19-mobilefirst-foundation-80-obfuscating- android-code-with-proguard/androidstudionativestructure.png)

The default project generated will not contain the default rules for obfuscation. Copy the obfuscation rules mentioned above into **proguard-rules.pro**. 

Follow all steps mentioned in **Enabling proguard and obfuscating the apk** section above to generate an obfuscated apk.

### Restoring an obfuscated stack trace

The ProGuard obfuscation process results in an obfuscated stack trace, this would lead to ambiguity in identifying errors while debugging the application stack trace. To debug application stack trace it is important to keep a copy of the mapping.txt file, which is generated as a part of the obfuscation process. The mapping.txt file contains all details on how the obfuscation was performed to the apk file. This file is can be located under build/outputs/mapping/release folder of the project.

> **Note:** For each build for which you might need to restore a stack trace, copy the **mapping.txt** file or save it under a new name because subsequent builds will overwrite the file.

#### Procedure
* Navigate to the directory where ProGuard is installed. (Usually `sdk_root/tools/proguard/bin/`).
* Run the following command, as appropriate to your operating system:

```bash
retrace.bat|retrace.sh [-verbose] mapping.txt [stacktrace_file] > stacktrace_out.txt
```

Where:

* **stacktrace_file** is the name of the stack trace file that you want to restore to readable form.
* **mapping.txt** file is the instance of this file that you saved for the specific release build.
* **stacktrace_out.txt** is the file that contains the unobfuscated stack trace.

#### Results
A readable stack trace is written to **stacktrace_out.txt**.

Another approach is to use the **proguardgui.jar** tool present usually under `sdk_root/tools/proguard/bin/`. 

![Restore Obfuscated Structure]({{site.baseurl}}/assets/blog/2016-09-19-mobilefirst-foundation-80-obfuscating- android-code-with-proguard/restoreobfuscatedstacktrace.png)
