---
title: Performance of JSONStore sync
date: 2018-12-04
version:
- 8.0
tags:
- MobileFirst_Foundation
- JSONStore
- Mobile_Foundation
author:
  name: Srutha Keerthi
---

The feature of automated sync in JSONStore is available in native iOS, native Android, Cordova iOS and Cordova Android platforms. Details on enabling this feature can be found [here](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/) and in [this](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/) post. This blog post provides details regarding the performance of the JSONStore automated sync feature on Android and iOS devices.

### Factors and assumptions involved in the performance analysis
The devices used for testing are Apple iPhone 6 plus running iOS 8.0 and Mi A2 running Android 8.1.0 OS. The Cloudant DB is located in the Dallas region.
The WiFi network used for the testing has a download bandwidth of 38 Mbps and upload speed of 8 Mbps. The 4G connections are on a moderate strength network.
The time measurements have been calculated in seconds using a javascript stopwatch and the time considered is from the button click on the client app(for initialization/add/update or delete) to when the client app receives a response from Cloudant DB on the same network on which the request has been made.

>**Note:** It has been observed that the time difference captured on both iOS and Android devices is approximately < 2 secs in case of < 100 KB data size and is ~5 secs in case of ~1 MB of data size. Hence the readings below are an average of the times captured on both the iOS and Android devices.

### Downstream and upstream sync on different networks

The readings are provided for for encrypted and unencrypted data on JSONStore.

#### Downstream Sync

Downstream sync is when data on Cloudant DB is fetched and added to the local JSONStore collection. Observations have been made for the time taken for 1, 5 and 10 records of size close to 1 MB each and another data set of 1, 10, 100 and 1000 records of size 1KB and 100KB each. It is to be noted that on a 4G network, when the Cloudant DB has around 1000 records each of size close to 100 KB, the downstream sync does happen successfully, but on the JSONStore of the device, there might be a memory error while loading all this data into the JSONStore collections.

![Downstream 1MB]({{site.baseurl}}/assets/blog/2018-12-04-jsonstore-sync-performance/Downstream 1MB.png)
![Downstream 100KB]({{site.baseurl}}/assets/blog/2018-12-04-jsonstore-sync-performance/Downstream 100KB.png)
![Downstream 1KB]({{site.baseurl}}/assets/blog/2018-12-04-jsonstore-sync-performance/Downstream 1KB.png)


#### Upstream Sync

Upstream sync is when the data added, updated or deleted in the local JSONStore is reflected in the Cloudant DB. Observations have been made for 1 record of size 1 KB, 1 record of size 100 KB and for 1 record of size close to 1 MB.  It is to be noted that on a 4G network, the records of size 100 KB and 1 MB are not added to the Cloudant DB as the request times out and the sync fails. In this scenario, *replace* and *remove* features for this record of size 1 MB is not applicable for observation.


![Upstream]({{site.baseurl}}/assets/blog/2018-12-04-jsonstore-sync-performance/Upstream.png)


Based on the above tests, the best performance for both upstream and downstream sync has been observed when the records are of small size (less than 10 KB). In case of downstream sync, records of size 100 KB have been observed to perform successful sync operations, if the number of records is 500 or less. Even in this case, the time taken for downstream sync for records of 100 KB size increases drastically if the number of records is more than 200.

For upstream sync on poor mobile data networks, failure has been observed even for a record of size 100 KB. For large documents of size nearly 1 MB, for both upstream and downstream, the sync has been successful when on WiFi networks and the sync success rate is poor on 4G mobile data networks. Hence in conclusion, the best performance for both upstream and downstream sync is observed when the device is connected to a stable WiFi network and when record sizes are small (less than 100 KB). The chances of failures is high when record size is large (nearly 1 MB) and the device is connected to a poor mobile network.

### Downstream and upstream sync behviours in different scenarios

#### Downstream sync

<u>Scenario 1</u> : <i> App pushed to background when sync in progress -  </i> When the app is pushed to the background, the adapter call fails and the sync does not complete.

<u>Scenario 2</u> : <i>App killed when sync in progress - </i> On a real device and simulator, if the app is killed, before the response is received, then the app's jsonstore does not store any records and works as expected. But when the received data is being added to the app's local jsonstore and the app is killed midway, the new docs are added.

<u>Scenario 3</u> : <i> Network disconnected mid sync - </i> if the disconnection happens before the response reaches the client, an error saying "Request Timed out" is thrown. If the disconnection happens after the response is received, the data is correctly added/deleted/modified in the local jsonstore. This holds true on simulator and actual device.

#### Upstream sync

<u>Scenario 1</u> : <i> App pushed to background when sync in progress -  </i> When the app is pushed to the background, the adapter call fails and the sync does not complete.

<u>Scenario 2</u> : <i> App killed when sync in progress - </i> It has been observed that this scenario needs careful consideration as if the app is killed before the adapter call is triggered, then there is no anomaly. If the app is killed after the response from the adapter call and the response is updated in the local JSONStore collection, then there is no anomaly observed. But if the app is killed before the response of the request reaches the client app or if the app is killed before the response is updated in the JSONStore collection on the client, then there will be a mismatch of data in Cloudant and local JSONStore.

<u>Scenario 3</u> : <i> Network disconnected mid sync - </i> The upload fails with an error saying `No internet connection`.
