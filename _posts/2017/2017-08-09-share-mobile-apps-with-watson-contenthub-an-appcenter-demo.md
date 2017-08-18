---
title: Sharing Mobile Apps with IBM Watson Content Hub – A Demo
date: 2017-08-09
tags:
- MobileFirst_Foundation
- Watson
- Watson_Content_Hub
- App_Store
- Application_Center
author:
  name: Vinod Appajanna
additional_authors:
 - Matthias Falkenberg

---
## Overview
IBM Watson Content Hub offers a rich set of powerful public APIs for the authoring and delivering of assets and content. In this post, we shall showcase how you can use the Content Hub for distributing the apps (like an App Center or App Store). The demo application combines several of the Content Hub APIs to allow users to upload and share mobile apps (.apk/.ipa) for installation on devices. The following sections explain how the sample leverages Watson Content Hub APIs and also gives information on where you can find the corresponding API documentation.


## Login service
**Purpose:**

To upload a mobile apps, we use the Watson Content Hub authoring APIs that require prior authentication. The login service allows the sample to log on to our Watson Content Hub tenant that stores the mobile apps.

[API documentation:](https://developer.ibm.com/api/view/id-618) > Documentation > Login service


## Authoring resources data service
**Purpose:**

When uploading a mobile app, the user selects an image and the application archive file. The authoring resources data service makes sure those files are safely stored in our Watson Content Hub tenant. The integrated MD5 checksum support helps the sample to detect and react to any data transfer issues.

[API documentation:](https://developer.ibm.com/api/view/id-618) > Documentation > Authoring resources


## Authoring assets data service
**Purpose:**

In Watson Content Hub, resources are binary data. Assets on the other hand describe resources. Therefore, an asset always references a specific resource. Among others, the authoring assets data service allows the sample to automatically tag an uploaded application archive file with "Android" or "iOS".

[API documentation:](https://developer.ibm.com/api/view/id-618) > Documentation > Authoring assets


## Authoring content data service
**Purpose:**

The sample stores mobile apps as content in Watson Content Hub. The content authoring data service is involved whenever a user uploads a mobile app. After creating the resources and the corresponding assets, the sample also creates new content. It brings the mobile app title, package name, version, image, and application archive file together in one managed entity. Using the content authoring data service again, the content is published.

[API documentation:](https://developer.ibm.com/api/view/id-618) > Documentation > Authoring content


## Watson Content Hub palette
**Purpose:**

The Watson Content Hub palette allows users to browse assets and content. It is a great way to integrate Watson Content Hub into other applications. The sample uses the palette to allow users to browse the available application archive files.

**More information:**
- [New GitHub sample for Watson Content Hub asset picker](https://developer.ibm.com/customer-engagement/2017/02/03/new-github-sample-for-watson-content-hub-asset-picker/)
- [WCH Asset Palette WordPress plugin](https://wordpress.org/plugins/wch-assetpicker/)


## Delivery search service
**Purpose:**

Once published, users can download mobile apps from an Application Catalog that is part of the sample. The sample uses the delivery search service to fetch all available mobile apps without the need to authenticate. The delivery search service returns the data required to present users a list of mobile apps and allow them to download the corresponding application archive files from Akamai.

[API documentation](https://developer.ibm.com/api/view/id-618) > Documentation > Delivery search


If you have questions about Watson Content Hub APIs, please check with the [community](https://developer.ibm.com/answers/topics/watsoncontenthub/) in the Watson Content Hub forum.



## Demo - Mobile App Sharing via Watson Content Hub
<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/j2ePOuwP7HI"></iframe>
    </div>
</div>


## Sample App
[Download](https://github.com/vinapp/AppShareWCH)

## Resources
- [API explorer](https://developer.ibm.com/api/view/id-618)
- [Developer center](https://developer.ibm.com/wch/)
- [Developer documentation](https://developer.ibm.com/customer-engagement/docs/wch/)
- [Forum](https://developer.ibm.com/answers/topics/watsoncontenthub/)
- [Knowledge Center](https://www.ibm.com/support/knowledgecenter/SS3UMF/dch/welcome/dch_welcome.html)
