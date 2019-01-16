---
layout: tutorial
title: React Native 애플리케이션의 JSONStore
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## 전제조건
{: #prerequisites }
* [JSONStore 상위 학습서](../)를 읽으십시오.
* {{ site.data.keys.product_adj }} React Native Core SDK가 프로젝트에 추가되었는지 확인하십시오. [React-Native 애플리케이션에 Mobile Foundation SDK 추가](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/) 학습서에 따르십시오.

#### 다음으로 이동:
{: #jump-to}
* [JSONStore 추가](#adding-jsonstore)
* [기본 사용법](#basic-usage)
* [샘플 애플리케이션](#sample_app_for_jsonstore)

## JSONStore 추가
{: #adding-jsonstore }
React Native 애플리케이션에 JSONStore 플러그인을 추가하려면 다음을 수행하십시오.

1. **명령행** 창을 열고 React Native 프로젝트 폴더로 이동하십시오.
2. 다음 명령을 실행하십시오.
    ```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## 기본 사용법
{: #basic-usage }
### 새 JSONStore 콜렉션 작성
{: #create_new_jsonstore_collection}
1.  `JSONStoreCollection` 클래스를 사용하여 JSONStore의 인스턴스를 작성합니다. 이 새로 작성된 JSONStore 콜렉션에 추가 구성을 설정할 수도 있습니다(예: 검색 필드 설정).
2.  기존 JSONStore 콜렉션과의 상호작용(예: 데이터 추가 또는 제거)을 시작하려면 콜렉션을 *열어야* 합니다. `openCollections()` API를 사용하여 이를 수행합니다.
    ```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// handle success
    }).catch(err => {
    	// handle failure
});
    ```

### 추가
{: #add}
`addData()` API를 사용하여 콜렉션에 JSON 데이터를 저장하십시오.

```javascript
var data = { "name": "John", age: 28 };
var collection = new JSONStoreCollection('people');
collection.addData(data)
.then(res => {
  // handle success
}).catch(err => {
  // handle failure
});
```

> 이 API를 사용하여 단일 JSON 오브젝트 또는 JSON 오브젝트 배열을 추가할 수 있습니다.

### 찾기
{: #find}
1.  `find`를 사용하여 조회를 통해 콜렉션 내에서 문서를 찾으십시오.
2.  콜렉션 내의 모든 문서를 검색하려면 `findAllDocuments()` API를 사용하십시오.
3.  문서 고유 ID를 사용하여 검색하려면 `findDocumentById()` 및 `findDocumentsById()` API를 사용하십시오.
4.  콜렉션을 조회하려면 `findDocuments()` API를 사용하십시오. 조회 시 `JSONStoreQueryPart` 클래스 오브젝트를 사용하여 데이터를 필터링할 수 있습니다.

> `JSONStoreQueryPart` 오브젝트 배열을 매개변수로서 `findDocuments` API에 전달하십시오.

```javascript
var collection = new JSONStoreCollection('people');
var query = new JSONStoreQueryPart();
query.addEqual("name", "John");
collection.findDocuments([query])
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

### 제거
{: #remove}
`remove`를 사용하여 콜렉션에서 문서를 삭제하십시오.

```javascript
var id = 1; // for example
var collection = new JSONStoreCollection('people');
collection.removeDocumentById(id)
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

### 콜렉션 제거
{: #removecollection}
`removeCollection`을 사용하여 콜렉션 내에 저장된 모든 문서를 삭제하십시오. 이 조작은 데이터베이스 용어로 된 테이블을 삭제하는 것과 유사합니다.

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

## IBM MobileFirst JSONStore용 샘플 앱
{: #sample_app_for_jsonstore}
[여기](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative)에서 샘플을 다운로드하십시오.

### 샘플 실행
{: #running_sample}
샘플의 루트 디렉토리에서 다음 명령을 실행하면 모든 프로젝트 종속 항목이 설치됩니다.

```bash
npm install
```

>**참고:**   *mfpclient.properties* 및 *mfpclient.plist*가 올바른 MobileFirst Server를 가리키는지 확인하십시오.

1. 앱 등록. `android` 디렉토리로 이동하여 다음 명령을 실행하십시오.
    ```bash
    mfpdev app register
    ```

2. 앱 구성.
    (Android에만 해당)
   *  React Native 프로젝트 루트 디렉토리에서 `android/app/src/main/AndroidManifest.xml` 파일을 여십시오.<br/>
    	 다음 행을 `<manifest>` 태그에 추가하십시오.<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 다음 행을 `<application>` 태그에 추가하십시오.<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 이 단계는 *react-native-ibm-mobilefirst* 라이브러리에서 필요합니다.<br/>

	 *  React Native 프로젝트 루트 디렉토리에서 `android/app/build.gradle` 파일을 여십시오.<br/>
      *android {}* 내에 다음 코드를 추가하십시오.<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      이 단계는 *react-native-ibm-mobilefirst-jsonstore* 라이브러리에서 필요합니다.

3. 앱 실행. 루트 디렉토리로 돌아가고 `iOS` 디렉토리로 이동하여 다음 명령을 실행하십시오.
    `mfpdev app register`

이제 앱을 실행할 준비가 되었습니다.
Android를 실행하려면 다음 명령을 실행하십시오.
```bash
react-native run-android
```
