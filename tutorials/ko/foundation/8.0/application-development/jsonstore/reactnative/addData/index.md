---
layout: tutorial
title: JSONStore 콜렉션에 데이터 추가
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## JSONStore 콜렉션에 데이터 추가

`App.js` 내에 다음 패키지를 가져와야 합니다.

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

다음 세 단계를 통해 JSONStore 콜렉션에 데이터를 추가합니다.

1. 새 콜렉션 작성. 아래 표시된 대로 `JSONStoreCollection` 생성자를 호출하여 새 콜렉션을 작성할 수 있습니다.
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  콜렉션 열기. 새로 작성한 콜렉션을 열지 않으면 아무것도 할 수 없습니다. 콜렉션을 열려면 WLJSONStore의 `openCollections` API를 호출하십시오. 아래의 샘플 코드를 참조하십시오.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. 콜렉션에 데이터 추가. 콜렉션을 열었으면 내부 또는 외부로의 데이터 트랜잭션을 시작하십시오. 다음 API를 사용하여 열린 콜렉션에 데이터를 추가할 수 있습니다.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
