---
layout: tutorial
title: JSONStore 콜렉션에서 데이터 페치
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
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

## JSONStore 콜렉션에서 데이터 페치
`App.js` 내에 다음 패키지를 가져와야 합니다.

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

다음 두 단계를 통해 JSONStore 콜렉션에서 데이터를 페치합니다.

1. 콜렉션 열기. 콜렉션을 열면 콜렉션과 상호작용할 수 있습니다.
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. 콜렉션에서 데이터 페치. 콜렉션을 열었으면 다음 API를 사용하여 모든 문서를 페치할 수 있습니다.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.findAllDocuments()
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
