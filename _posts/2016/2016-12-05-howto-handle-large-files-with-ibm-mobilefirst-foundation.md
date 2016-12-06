---
title: 'HowTo: Download or upload large files to endpoints protected with IBM MobileFirst Foundation security'
date: 2016-12-05
tags:
- MobileFirst_Platform
- Large_files
- Android
- iOS
- Swift3

version:
- 8.0
author:
  name: Arik Shifer
---
## Overview
As a mobile app developer you may be required to transfer very large files from a remote server to your app or from your app to the server.
Those can be media files such as video or audio files, large documents, or other forms of binary data. 

Here are some of the considerations when handling transfers of large files:
* File transfer should be streamed and sent in chunks. At no time the entire file should be loaded into memory in order to avoid excessive memory consumption and overflow.
* File transfer might be a long operation. It should be done using a background thread in order to free the main user interface thread to respond to user inputs.
* Network could be slow or instable. App could be designed to automatically resume partial transfers when connectivity is restored.
* App could be designed to allow large file transfers only when connected through WiFi to avoid exceeding mobile data Quota.
* App could intentionally or unintentionally moved to the background. File transfer could be designed to continue and complete in such case.
* App could be designed to show progress during file transfer, or allow the user to cancel the operation.

The IBM MobileFirst Foundation main client API used to communicate with the Foundation server is: `WLResourceRequest`.
It is designed to provide a simple API encapsulating the handling of MobileFirst security, for transferring small to medium JSON or Text content from or to the IBM MobileFirst Foundation server. It is not designed to comply with the large files transfer considerations discussed above. Behind the scenes the `WLResourceRequest` API request and response content is loaded entirely into memory.  

* `WLResourceRequest` API for iOS has a helper `WLResourceRequest.sendWithDelegate` API that allows downloading of large files.

This sample shows how a mobile application developer can download or upload large files to endpoints protected with IBM MobileFirst Foundation security. It focuses on the first consideration when handling transfers of large files - transfer the file content in chunks.
The other considerations for transferring of large files are tied to the mobile operating system APIs and guidelines, and to the application specific requirements. They should be handled by the application developer.

The approach shown in this sample is for the client application to obtain an IBM MobileFirst Foundation OAuth token and perform the file transfers using native Http request with the MobileFirst  security authorization header. This approach allows the developer full control over the file transfer process and can be applied to all client platforms supported by IBM MobileFirst Foundation. 
 
## GitHub Repository
[https://github.com/mfpdev/handling-large-files-sample](https://github.com/mfpdev/handling-large-files-sample)

