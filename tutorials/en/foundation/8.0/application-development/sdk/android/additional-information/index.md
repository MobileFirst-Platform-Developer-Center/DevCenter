---
layout: tutorial
title: Additional Information
breadcrumb_title: Additional info
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Registering Javadocs to an Android Studio Gradle project
The {{ site.data.keys.product_adj }} Android Javadocs are included in the *.aar files imported by Gradle. However you need to link them to their relevant library in Android Studio.

1. In Android Studio make sure you are in the **Project** view.
2. Find the library name under the **External Libraries** node (the Javadoc file appears below it).
3. Right-click on the library name and select **Library Properties**.
4. From the Library Properties dialog select the "+" button
5. Navigate to the downloaded Javadoc JAR file (**ibmmobilefirstplatformfoundation-javadoc.jar**) under **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** and select it.
6. Click **OK**. The Javadocs will now be available within your project.

### Notes

* The {{ site.data.keys.product_adj }} APIs cannot be activated from within an Android Service.