---
layout: tutorial
title: Certificate Pinning
relevantTo: [ios,android,cordova]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
When communicating over public networks it is essential to send and receive information securely. The protocol widely used to secure these communications is SSL/TLS. (SSL/TLS refers to Secure Sockets Layer or to its successor, TLS, or Transport Layer Security). SSL/TLS uses digital certificates to provide authentication and encryption. To trust that a certificate is genuine and valid, it is digitally signed by a root certificate belonging to a trusted certificate authority (CA). Operating systems and browsers maintain lists of trusted CA root certificates so that they can easily verify certificates that the CAs have issued and signed.

Protocols that rely on certificate chain verification, such as SSL/TLS, are vulnerable to a number of dangerous attacks, including man-in-the-middle attacks, which occur when an unauthorized party is able to view and modify all traffic passing between the mobile device and the backend systems.

{{ site.data.keys.product_full }} provides an API to enable **certificate pinning**. It is supported in native iOS, native Android, and cross-platform Cordova {{ site.data.keys.product_adj }} applications.

## Certificate pinning process
{: #certificate-pinning-process }
Certificate pinning is the process of associating a host with its expected public key. Because you own both the server-side code and the client-side code, you can configure your client code to accept only a specific certificate for your domain name, instead of any certificate that corresponds to a trusted CA root certificate recognized by the operating system or browser.
A copy of the certificate is placed in your client application. During the SSL handshake (first request to the server), the {{ site.data.keys.product_adj }} client SDK verifies that the public key of the server certificate matches the public key of the certificate that is stored in the app.

You can also pin multiple certificates with your client application. A copy of the all the certificates should be placed in your client application. During the SSL handshake (first request to the server), the {{ site.data.keys.product_adj }} for client SDK verifies that the public key of the server certificate matches to the public key of one of the certificate that is stored in the app.

#### Important
{: #important }
* Some mobile operating systems might cache the certificate validation check result. Therefore, your code should call the certificate pinning API method **before** making a secured request. Otherwise, any subsequent request might skip the certificate validation and pinning check.
* Make sure to use only {{ site.data.keys.product }} APIs for all communications with the related host, even after the certificate pinning. Using third-party APIs to interact with the same host might lead to unexpected behavior, such as caching of a non-verified certificate by the mobile operating system.
* Calling the certificate pinning API method a second time overrides the previous pinning operation.

If the pinning process is successful, the public key inside the provided certificate is used to verify the integrity of the {{ site.data.keys.mf_server }} certificate during the secured request SSL/TLS handshake. If the pinning process fails, all SSL/TLS requests to the server are rejected by the client application.

## Certificate setup
{: #certificate-setup }
You must use a certificate purchased from a certificate authority. Self-signed certificates are **not supported**. For compatibility with the supported environments, make sure to use a certificate that is encoded in **DER** (Distinguished Encoding Rules, as defined in the International Telecommunications Union X.690 standard) format.

The certificate must be placed in both the {{ site.data.keys.mf_server }} and in your application. Place the certificate as follows:

* In the {{ site.data.keys.mf_server }} (WebSphere  Application Server, WebSphere Application Server Liberty, or Apache Tomcat): Consult the documentation for your specific application server for information about how to configure SSL/TLS and certificates.
* In your application:
    - Native iOS: add the certificate to the application **bundle**
    - Native Android: place the certificate in the **assets** folder
    - Cordova: place the certificate in the **app-name\www\certificates** folder (if the folder is not already there, create it)

## Certificate pinning API
{: #certificate-pinning-api }
Certificate pinning consists of the following overloaded API method, where one method has a parameter `certificateFilename`, where `certificateFilename` is the name of the certificate file, and the second method has a parameter `certificateFilenames`, where `certificateFilenames` is an array of names of the certificate files.

### Android
{: #android }
Single certificate:
Syntax:
pinTrustedCertificatePublicKeyFromFile(String certificateFilename);
Example:
```java
WLClient.getInstance().pinTrustedCertificatePublicKey("myCertificate.cer");
```
Multiple certificates:

Syntax:
pinTrustedCertificatePublicKeyFromFile(String[] certificateFilename);
Example:
```java
String[] certificates={"myCertificate.cer","myCertificate1.cer"};
WLClient.getInstance().pinTrustedCertificatePublicKey(certificates);
```
The certificate pinning method will raise an exception in two cases:
* The file does not exist
* The file is in the wrong format


### iOS
{: #ios }
Single certificate Pinning syntax:
pinTrustedCertificatePublicKeyFromFile:(NSString*) certificateFilename;

The certificate pinning method will raise an exception in two cases:
* The file does not exist
* The file is in the wrong format

Multiple certificate pinning syntax:
pinTrustedCertificatePublicKeyFromFiles:(NSArray*) certificateFilenames;

The certificate pinning method will raise an exception in two cases:
* None of the certificate file exist
* None of the certificate file in correct format

**In Objective-C:**
Example:
Single certificate:
```objc
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFile:@"myCertificate.cer"];

```
Multiple certificate:
Example:
```objc
NSArray *arrayOfCerts = [NSArray arrayWithObjects:@“Cert1”,@“Cert2”,@“Cert3",nil];
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFiles:arrayOfCerts];
```

**In Swift:**

Single certfiicate:
Example:
```swift
WLClient.sharedInstance().pinTrustedCertificatePublicKeyFromFile("myCertificate.cer")
```
Multiple certificate:
Example:
```swift
let arrayOfCerts : [Any] = ["Cert1", "Cert2”, "Cert3”];
WLClient.sharedInstance().pinTrustedCertificatePublicKey( fromFiles: arrayOfCerts)
```

The certificate pinning method will raise an exception in two cases:

* The file does not exist
* The file is in the wrong format

### Cordova
{: #cordova }
```javascript
WL.Client.pinTrustedCertificatePublicKey('myCertificate.cer').then(onSuccess,onFailure);

```

The certificate pinning method returns a promise:

* The certificate pinning method will call the onSuccess method in case of successful pinning.
* The certificate pinning method will trigger the onFailure callback in two cases:
* The file does not exist
* The file is in the wrong format

Later, if a secured request is made to a server whose certificate is not pinned, the `onFailure` callback of the specific request (for example, `obtainAccessToken` or `WLResourceRequest`) is called.

> Learn more about the certificate pinning API method in the [API Reference](../../api/client-side-api/)
