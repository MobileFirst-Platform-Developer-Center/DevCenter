---
title: How to enable TLS1.2 on a MobileFirst app for Android 4.1
date: 2016-06-09
tags:
- MobileFirst_Platform
- Android
version:
- 8.0
- 7.1
- 7.0
- 6.3
- 6.2
author:
  name: S.A.Norton Stanley
---
Ever run into an javax.net.ssl.SSLException or an SSL handshake exception when connecting an MobileFirst Platform Android application to an TLS 1.2 enabled MobileFirst Platform server?

Well the good news is that you have landed at the right place!!!

The cause for this error is TLS 1.2 protocol is not supported by the device!! But wait according to Android's documentation for [SSLSocket](https://developer.android.com/reference/javax/net/ssl/SSLSocket.html?hl=zh-cn) it says that TLS 1.2 is supported within Android starting API level 16+ (Android 4.1, Jelly Bean). Then why does it not work on 4.4.1 when it is supported by the OS. Confusing isn't it? 

Well the reason for this is by default this protocol is enabled only on devices with API level above 20. So inorder to enable this include TlsSniSocketFactory.java, SelfSignedTrustManager.java classes from the package [here](https://github.com/erickok/transdroid/tree/master/app/src/main/java/org/transdroid/daemon/util) into your project. 

In the file TlsSniSocketFactory.java there is a section of code which reads...

```java
if (acceptAllCertificates) {
            sslSocketFactory.setTrustManagers(new TrustManager[]{new IgnoreSSLTrustManager()});
        } else if (selfSignedCertificateKey != null) {
            sslSocketFactory.setTrustManagers(new TrustManager[]{new SelfSignedTrustManager(selfSignedCertificateKey)});
}
```

Replace the above code with the following:

```java
if (selfSignedCertificateKey != null) {
            sslSocketFactory.setTrustManagers(new TrustManager[]{new SelfSignedTrustManager(selfSignedCertificateKey)});
}
```

> We do this to avoid bypassing all certificates as ignoring SSL certificate error in the production application can compromise security.

In your MFP application include this method in your <ApplicationName>.java and make a call to this method after calling the 
WLClient.createInstance method.


```java
private void replaceSocketFactory(LayeredSocketFactory tlsSocketFactory) {
        HttpClientManager manager = HttpClientManager.getInstance();
        HttpClient client=  manager.getHttpClient();
        SchemeRegistry schemeRegistry = client.getConnectionManager().getSchemeRegistry();   
        Scheme httpsScheme = schemeRegistry.getScheme("https");
        schemeRegistry.unregister("https");
        Scheme newScheme = new Scheme("https", tlsSocketFactory, httpsScheme.getDefaultPort());
        schemeRegistry.register(newScheme);
}
```

So the method invocation would look like this:

```java
WL.createInstance(this);
replaceSocketFactory(new TlsSniSocketFactory());
```

That's it.!! Your application will now connect to your TLS 1.2 enabled server without any errors.