---
layout: tutorial
title: JSONStore 콜렉션에서 데이터 조회
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
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

## JSONStore 콜렉션에서 데이터 조회
콜렉션의 모든 문서를 동시에 가져오려는 경우는 거의 없을 것입니다. 일반적으로 콜렉션의 기존 데이터를 조회하는 기능이 필요합니다.

`App.js` 내에 다음 패키지를 가져와야 합니다.

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

다음 두 단계를 통해 JSONStore 콜렉션에서 데이터를 조회합니다.

1. 콜렉션 열기. 콜렉션을 열면 콜렉션과 상호작용할 수 있습니다.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. 콜렉션에서 데이터 페치. 콜렉션을 열었으면 지정된 조회를 기반으로 문서를 페치할 수 있습니다. JSONStore를 조회하기 위해 `JSONStoreQuery` 및 `JSONStoreQueryPart`와 연동하는 두 개의 클래스가 제공됩니다.<br/>
    하나의 배열에서 각 JSONStoreQueryPart 오브젝트를 전달하여 동일한 호출에 다중 JSONStoreQueryPart 오브젝트를 사용할 수 있습니다.
    다중 JSONStoreQueryPart 오브젝트는 OR 문으로 결합됩니다.
    하나의 JSONStoreQueryPart에 대한 다중 조건은 AND 문으로 결합됩니다.

    다음 코드를 참조하십시오.

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    // 복잡한 조회를 빌드하기 위해 다중 JSONStoreQueryPart 오브젝트가 하나의 배열에서 어떻게 전달되는지에 주의하십시오.
    // 다음 호출은 "성(gender)"이 "여성(female)"으로 설정되었거나 "나이(age)"가 21 - 50 사이인
    // 모든 문서를 리턴합니다.

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
