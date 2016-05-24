---
layout: tutorial
title: Node.js Validator
breadcrumb_title: Node.js filter
relevantTo: [android,ios,windows,cordova]
weight: 3
---

## Overview
MobileFirst Platform Foundation provides a Node.js framework to enforce security capabilities on external resources.  
The Node.js framework is provided as an npm module (**passport-mfp-token-validation**).

This tutorial will show how to protect a simple Node.js resource, `GetBalance`, using a scope (`accessRestricted`).

**Prerequesites:**

* Make sure to read the [Using the MobileFirst Server to authenticate external resources](../) tutorial.
* Understanding of the [MobileFirst Platform Foundation security framework](../../).

## The passport-mfp-token-validation module
The passport-mfp-token-validation module provides passport validation strategy and a verification function to validate access tokens and ID tokens that are issued by the MobileFirst Server.

To install the module run:

```bash
npm install passport-mfp-token-validation
```

## Example
```js
var express = require('express');
var passport = require('passport-mfp-token-validation').Passport;
var mfpStrategy = require('passport-mfp-token-validation').Strategy;

passport.use(new mfpStrategy({
    //Specify the URL of the MobileFirst Server
    authServerUrl: 'http://localhost:9080/mfp/api/az/v1',
    //Specify the confidential client ID and password which should be defined in the MobileFirst Operations Console
    confClientID: 'testclient',
    confClientPass: 'testclient',
    // The analytics item is optional and only required if you wish to log analytics events to MFP
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
}));

var app = express();
app.use(passport.initialize());

app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
        session: false,
        scope: 'accessRestricted'
    }),
    function(req, res) {
        res.send('17364.9');
    });

app.listen(3000);
```
