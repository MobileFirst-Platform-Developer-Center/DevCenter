---
layout: tutorial
title: JSONStore 콜렉션의 데이터를 Cloudant DB에 동기화
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  React Native 개발 환경 설정
React Native 개발을 위해 사용하는 시스템을 설정하려면 React Native [시작하기 페이지](https://facebook.github.io/react-native/docs/getting-started.html)에서 제공되는 지시사항을 따르십시오.

##  React Native 앱에 JSONStore SDK 추가
React Native용 JSONStore SDK는 [npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore)에서 React Native 모듈로서 제공됩니다.

### 새 React Native 프로젝트 시작하기
1. 새 React Native 프로젝트를 작성하십시오.
    ```bash
    react-native init MyReactApp
    ```

2. 앱에 MobileFirst SDK를 추가하십시오.
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  앱에 모든 네이티브 종속 항목을 링크하십시오.
    ```bash
    react-native link
    ```

## JSONStore 콜렉션의 데이터를 Cloudant DB에 동기화
모든 앱 데이터를 로컬에 둘 때의 단점은 앱을 설치 제거하는 경우 데이터가 유실된다는 것입니다. 이러한 문제점에 대처하기 위해 IBM JSONStore에서는 Cloudant DB와의 SYNC 기능을 제공합니다.

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

다음 두 단계를 통해 JSONStore 콜렉션의 데이터를 동기화할 수 있습니다.

1. 콜렉션 열기. 보통의 `JSONStoreCollection`과 동기화된 `JSONStoreCollection`의 유일한 차이점은 콜렉션이 열리는 방법에 있습니다. 동기화된 JSONStoreCollection은 해당 `JSONStoreInitOptions`로 열립니다. JSONStoreInitOptions는 동기화 정책과 데이터를 동기화할 어댑터를 결정하는 곳입니다. 이 어댑터는 기본적으로 Cloudant 동기화 어댑터입니다. 추가 정보는 [여기](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/)를 참조하십시오. JSONStoreInitOptions는 API `setSyncOptions(syncPolicy, adapterName)`를 제공합니다. JSONStoreSyncPolicy는 다음 값 중 하나여야 합니다. [‘SYNC_NONE’, ‘SYNC_DOWNSTREAM’, ‘SYNC_UPSTREAM’]. **adapterName**은 MobileFirst Server서버에 배치되고 Cloudant DB와 연동하는 어댑터의 이름입니다. 동기화가 작동하려면 Cloudant DB 세부사항을 올바르게 입력해야 합니다.

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. Sync API 호출. Sync로 열린 모든 JSONStoreCollection은 `openCollection()` API 성공 시 자동으로 동기화를 트리거합니다.<br/>
    JSONStoreCollection이 **JSONStoreSyncPolicy.SYNC_DOWNSTREAM** 정책으로 열리는 경우, `sync()` API를 명시적으로 호출하여 최신 풀을 페치할 수 있습니다.<br/>
    JSONStoreCollection이 **JSONStoreSyncPolicy.SYNC_UPSTREAM** 정책으로 열리는 경우, 콜렉션에서 문서를 추가, 업데이트 또는 제거하면 동기화 프로세스가 자동으로 트리거됩니다. 또한 `sync()` API를 호출하여 동기화를 명시적으로 트리거할 수도 있습니다.<br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
