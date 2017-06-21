---
title: Preparing iOS apps for App Store submission in IBM MobileFirst Foundation 8.0
date: 2017-06-21
tags:
- MobileFirst_Foundation
- iOS
version:
- 8.0
author: 
  name: Vittal R Pai
---
>**Update :** The steps provided below are applicable only if your Xcode version is 8.2.1 or below. Starting Xcode version 8.3, `i386` and `x86_64` architecture slices of dynamic frameworks are automatically removed by Xcode during IPA generation.

Starting IBM MobileFirst Foundation 8.0, the iOS Client SDK for Cordova and Native applications was modified to be a dynamic framework. When an archive/IPA files are generated using Test Flight or iTunes Connect for store submission/validation, this might cause a runtime crash/fail with following error:

![validation errors]({{site.baseurl}}/assets/blog/2016-10-17-prepare-ios-apps-for-app-store-submission/validation_fail.png)

This is because the `i386` and `x86_64` architecture slices are bundled within `IBMMobilefirstPlatformfoundation.framework`. These architecture slices are bundled so that an application with the SDK could run on simulators as well. iTunes Connect and TestFlight do not support applications which include unused binary slices, hence while publishing to the App Store or while using Archives for testing, the app crashes during runtime or fails during validation. This is a known [Xcode defect](http://www.openradar.me/23681704) for dynamic frameworks. 

The following steps mentioned by Daniel Kennett in his [blog post](http://ikennd.ac/blog/2015/02/stripping-unwanted-architectures-from-dynamic-libraries-in-xcode/) will help resolve the above issue by removing unused/unsupported architectures (`i386`/`x86_64`) from dynamic frameworks and will ensure that the application will work as expected without any crash/failures.

1. Select Build Phases tab in Xcode project settings

2. Add new Run Script Phase

3. Paste the following script inside Run Script tab

```shell
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
        echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
        lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
        EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
```
