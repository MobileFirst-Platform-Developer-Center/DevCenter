---
layout: tutorial
title: Securing containers
relevantTo: [ios,android,windows,javascript]
weight: 2
---

## Configuring App Transport Security (ATS)
ATS configuration does not impact applications connecting from other, non-iOS, mobile operating systems. Other mobile operating systems do not mandate that servers communicate on the ATS level of security but can still communicate with ATS-configured servers. Before configuring your container image, have the generated certificates ready. The following steps assume that the keystore file **ssl_cert.p12** has the personal certificate and **ca.crt** is the signing certificate.

1. Copy the **ssl_cert.p12** file to the **mfpf-server/usr/security/** folder.
2. Modify the **mfpf-server/usr/config/keystore.xml** file similar to the following example configuration:

    ```bash
    <server>
        <featureManager>
            <feature>ssl-1.0</feature>
        </featureManager>
        <ssl id="defaultSSLConfig" sslProtocol="TLSv1.2" keyStoreRef="defaultKeyStore" enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" />
        <keyStore id="defaultKeyStore" location="ssl_cert.p12" password="*****" type="PKCS12"/>
    </server>
    ```
    - **ssl-1.0** is added as a feature in the feature manager to enable the server to work with SSL communication.
    - **sslProtocol="TLSv1.2"** is added in the ssl tag to mandate that the server communicates only on Transport Layer Security (TLS) version 1.2 protocol. More than one protocol can be added. For example, adding **sslProtocol="TLSv1+TLSv1.1+TLSv1.2"** would ensure that the server could communicate on TLS V1, V1.1, and V1.2. (TLS V1.2 is required for iOS 9 apps.)
    - **enabledCiphers="TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384"** is added in the ssl tag so that the server enforces communication using only that cipher.
    - The **keyStore** tag tells the server to use the new certificates that are created as per the above requirements.

The following specific ciphers require Java Cryptography Extension (JCE) policy settings and an additional JVM option:

* TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
* TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
* TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
* TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384

If you use these ciphers and use an IBM Java SDK, [you can download](https://www.ibm.com/marketing/iwm/iwm/web/preLogin.do?source=jcesdk) the policy files. There are two files: **US_export_policy.jar** and **local_policy.jar**. Add both the files to the **mfpf-server/usr/security** folder and then add the following JVM option to the **mfpf-server/usr/env/jvm.options file**: `Dcom.ibm.security.jurisdictionPolicyDir=/opt/ibm/wlp/usr/servers/worklight/resources/security/`.

For development-stage purposes only, you can disable ATS by adding following property to the info.plist file:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
        <true/>
</dict>
```
