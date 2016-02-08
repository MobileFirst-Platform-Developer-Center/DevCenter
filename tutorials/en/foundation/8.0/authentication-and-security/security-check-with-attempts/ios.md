---
layout: tutorial
title: Implementing Security Check with Attempts in iOS applications
breadcrumb_title: Security Check with Attempts in iOS applications
relevantTo: [ios]
---
## Overview
When trying to access a protected resource, the server (the `SecurityCheck`) will send back the client one or more **challenges** for the client to handle.

This list is received as a JSON object, listing the `SecurityCheck` name with an optional JSON of additional data:

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

The client must then register a **challenge handler** for each `SecurityCheck`, which will know how to handle the challenge (eg. show a login screen).

## Creating the challenge handler

A **challenge handler** is a class responsible for handling challenges sent by the MobileFirst server, such as collecting credentials and submitting them back to the `SecurityCheck`.

In this example, the `SecurityCheck` is the one defined in 
