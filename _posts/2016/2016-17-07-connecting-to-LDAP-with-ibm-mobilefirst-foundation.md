---
title: Connecting to LDAP with IBM MobileFirst Foundation 8.0
date: 2016-07-17
tags:
- MobileFirst _Foundation
- Authentication
- Adapters
- Security_Checks
- LDAP
version:
- 8.0
author:
  name: Ishai Borovoy
---

## Introduction
[LDAP](https://www.wikiwand.com/en/Lightweight_Directory_Access_Protocol) is an essential protocol in the enterprise world, it provide a central place to store usernames and passwords and allowing many different applications and services to connect to the LDAP server to validate users.  

In my previous [blog]({{site.baseurl}}/blog/2016/04/21/using-ldap-as-user-registry) about LDAP and LTPA I talked about LDAP in the context of [LTPA](https://www.wikiwand.com/en/IBM_Lightweight_Third-Party_Authentication).  In this blog I want to introduce a new [LDAP Security Check sample](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/ldap) which let you connect directly to any LDAP server without using the LTPA token.

The [LDAP Security Check sample](https://github.com/mfpdev/mfp-advanced-adapters-samples/tree/development/custom-security-checks/ldap) acts mostly like the [User Authentication sample]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/user-authentication/security-check/). The difference is that `validateCredentials` function checks the credentials against configured LDAP server.

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {

    ...
                    ldapContext = new InitialLdapContext(env, null);
                    userId = (String) searchResult.getAttributes().get(config.getLdapUserAttribute()).get();
                    displayName = (String) searchResult.getAttributes().get(config.getLdapNameAttribute()).get();
                    return true;
    ...
}
```

## Running the Security Check sample
To run the sample follow the instructions in the README.md file [link](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/ldap/readme.md).

## Configuration
You can configure the LDAP connectivity either by editing the properties in the [adapter.xml](https://github.com/mfpdev/mfp-advanced-adapters-samples/blob/development/custom-security-checks/ldap/src/main/adapter-resources/adapter.xml) file followed by re-building and re-deploying the .adapter file, or by editing the adapter properties directly from MobileFirst Console.
![LDAP configuration]({{site.baseurl}}/assets/blog/2016-17-07-connecting-to-LDAP-with-ibm-mobilefirst-foundation/Configuration.png)
