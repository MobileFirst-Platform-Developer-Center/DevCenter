---
title: 'HowTo: Set Up an Offline IBM MobileFirst 8.0 Development Environment'
date: 2016-03-31
tags:
- MobileFirst_Platform
- Offline
- Setup
- Development_Environment
version:
- 8.0
author:
  name: Danny Cao
---
## Overview
IBM MobileFirst Platform Foundation supports offline development, but requires modified installation steps as detailed below. For additional development tutorials and standard installation instructions refer to the [IBM MobileFirst Platform Foundation 8.0 Tutorials]({{site.baseurl}}/tutorials/en/foundation/8.0/). The following prerequisite programs will need an online connection to download before transferring to an offline development machine for installation.

## Prerequisites
* Cordova
    * [cordova-cli (6.0.0+)](https://www.apache.org/dist/cordova/tools/)
    * [Cordova Platforms](https://www.apache.org/dist/cordova/platforms/)
        * cordova-android (6.1.2+)
        * cordova-ios (4.1.1+)
        * cordova-windows (4.3.2+)
* [Java (JDK 1.7+)](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html): For running a local development server
* [Maven (3.3.9+)](https://maven.apache.org/download.cgi): For adapter development
* [MobileFirst Developer Kit (V8.0+)]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/#mobilefirst-developer-kit): Includes the MobileFirst Server & MobileFirst Operations Console, MobileFirst Developer Command-line Interface (CLI), MobileFirst client SDKs and MobileFirst adapter tooling.
* [Node.js (0.12.0+)](https://nodejs.org/en/download/releases/): For the MobileFirst CLI and Cordova

For additional offline platform specific development prerequisites see the [tutorial page]({{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/) for more instructions.

## Cordova Preparation
The downloaded cordova-x.y.z.tgz file has third party dependencies that are not packaged with the archive and requires an online connection to first cache those dependencies before it can be moved to an offline machine for installation. See [NPM issue #4210](https://github.com/npm/npm/issues/4210) for more information and suggested workarounds for offline npm installs or use [npmbox](https://github.com/arei/npmbox). We suggest the following workaround:

While still online

1. Install Node.js on the online machine
2. Change directory to where you downloaded cordova-x.y.z.tgz and run `npm --cache ./.cache install cordova-x.y.z.tgz` to generate and cache the dependencies needed
3. Zip the new generated .cache folder and move this file along with the cordova-x.y.z.tgz file to the offline machine

On the offline machine

1. Unzip the .cache folder
2. Run `npm install --cache ./.cache cordova-x.y.z.tgz -g` to install cordova globally using the previously generated cache (Note: this may take a while)

The cordova command is now available for use. For any other packages that you may run into issues installing on an offline machine, the above caching method is viable as well.

## Installation
Once all of the above files are downloaded, move them to an offline machine for installation. Cordova and the associated cordova platforms as well as the MobileFirst CLI will need to be installed after Node.js has been installed.

## MobileFirst Operations Console
The MobileFirst Development Kit installer includes snapshot downloads for various development artifacts (listed above in Prerequisites) downloadable via the MobileFirst Operations Console downloads page.

![downloads]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/downloads.png)

See the [MobileFirst Operations Console Tutorial]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/components/console/) for more information on accessing and navigating the console.

## MobileFirst CLI
The MobileFirst CLI may also require an online connection to prepare the third-party dependencies for offline install. We suggest the above workaround with Cordova. First download the mfpdev-cli.tgz file from the MobileFirst Operations Console via the instructions above.

While still online

1. Install Node.js on the online machine
2. Change directory to where you downloaded mfpdev-cli.tgz and run `npm --cache ./.cache install mfpdev-cli.tgz` to generate and cache the dependencies needed
3. Zip the new generated .cache folder and move this file along with the mfpdev-cli.tgz file to the offline machine (or download it again from the Console on the offline machine)

On the offline machine

1. Unzip the .cache folder
2. Run `npm install --cache ./.cache mfpdev-cli.tgz -g` to install mfpdev globally using the previously generated cache (Note: this may take a while)

If you run into any installation errors on Windows regarding node-gyp, rerun the command with the `--no-optional` flag as well.

## Cordova Plugins and Platforms
When adding the MobileFirst Cordova SDK plugins to a cordova project, the plugins must first be added before platforms to ensure that the plugin does not search online for additional platform resources. The MobileFirst Cordova SDK plugins can be downloaded from the MobileFirst Operations Console via the instructions above and added by running `cordova plugins add <path to unzipped mfp-cordova>/plugins/cordova-plugin-mfp`. Additionally the following plugins can be installed:

* cordova-plugin-mfp-fips
* cordova-plugin-mfp-jsonstore
* cordova-plugin-mfp-push

To add a platform to your cordova project, unzip the downloaded cordova-[android | ios | windows]-x.y.z.tgz platform archive and run `cordova platforms add <path to unzipped platform>/package`. You may want to set system environment variables for the plugins and platforms to avoid typing out the path each time (make sure where you download and unzip them to are permanent locations).

For additional tutorials on Cordova development, see the [IBM MobileFirst Platform Foundation 8.0 Cordova Tutorials]({{site.baseurl}}/tutorials/en/foundation/8.0/cordova-tutorials/) or refer to the official [Apache Cordova Documentation](http://cordova.apache.org/docs/en/latest/guide/overview/index.html).
