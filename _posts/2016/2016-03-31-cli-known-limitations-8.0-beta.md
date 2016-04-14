---
title: 'Known Limitations in the MobileFirst Development CLI 8.0 Beta'
date: 2016-03-31
tags:
- MobileFirst_Platform
- CLI
- Development
- Beta_Program
version:
- 8.0
author:
  name: Justin Berstler
---

The development CLI in the MobileFirst Platform Foundation 8.0 beta has the following known limitations and workarounds:

- When installing the development CLI (particularly on Windows systems) you may get installation errors that either require python to be installed, or that `node-gyp` has failed. These errors are actually harmless and do not affect the functionality of the CLI. However, you can avoid these error messages by using the `--no-optional` flag when installing the CLI, such as:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<code>$ npm install -g <b>--no-optional</b> mfpdev-cli</code>

- The `mfpdev app register` command does not work with remote servers using HTTPS. As a workaround, when specifying a remote server profile, be sure to use the `http://` protocol and the appropriate port (typically 80).

- When previewing Cordova applications using the `mfpdev app preview` command, your application will not be able to call JavaScript adapters under certain circumstances. Specifically, your app will be unable to call JavaScript adapters that are unprotected (`secure=false`), and your app will be unable to call JavaScript adapter procedures that take parameters. This limitation only extends to the preview environment, and your app will behave as expected when running on native device hardware, or your platform's native simulator.

- The IBM MobileFirst Platform Command Line Interface (CLI) commands that are used to define a MobileFirst Server do not currently support IPV6 internet addresses for Cordova applications.  These commands include `mfpdev app register`, `mfpdev server add`, and `mfpdev server edit`.
