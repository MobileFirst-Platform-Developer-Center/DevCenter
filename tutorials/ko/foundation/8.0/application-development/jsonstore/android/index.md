---
layout: tutorial
title: Android 애플리케이션의 JSONStore
breadcrumb_title: Android
relevantTo: [android]
weight: 3
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 전제조건
{: #prerequisites }

* [JSONStore 상위 학습서](../)를 읽으십시오.
* {{ site.data.keys.product_adj }} 네이티브 SDK가 Android Studio 프로젝트에 추가되었는지 확인하십시오. [Android 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/android/) 학습서에 따르십시오.

#### 다음으로 이동:
{: #jump-to }
* [JSONStore 추가](#adding-jsonstore)
* [기본 사용법](#basic-usage)
* [고급 사용법](#advanced-usage)
* [샘플 애플리케이션](#sample-application)

## JSONStore 추가
{: #adding-jsonstore }
1. **Android → Gradle 스크립트**에서 **build.gradle(모듈: 앱)** 파일을 선택하십시오.

2. 기존 `dependencies` 섹션에 다음을 추가하십시오.

```
compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0.+'
```
3. 다음을 build.gradle 파일의 "DefaultConfig" 섹션에 추가하십시오.
```
  ndk {
        abiFilters "armeabi", "armeabi-v7a", "x86", "mips"
      }
 ```     
 > **참고**: JSONStore가 포함된 앱을 위에 지정된 아키텍처에서 실행될 수 있도록 abiFilters를 추가합니다. JSONStore는 이러한 아키텍처만 지원하는 써드파티 라이브러리에 종속되므로 이러한 작업이 필요합니다.

## 기본 사용법
{: #basic-usage }
### 열기
{: #open }
`openCollections`를 사용하여 하나 이상의 JSONStore 콜렉션을 여십시오.

콜렉션 시작 또는 프로비저닝은 콜렉션 및 문서를 보관하는 지속적 스토리지가 없는 경우 이를 작성하는 것을 의미합니다. 지속적 스토리지가 암호화되어 있고 올바른 비밀번호가 전달되면 데이터에 액세스할 수 있게 하는 필수 보안 프로시저가 실행됩니다.

초기화 시 사용할 수 있는 선택적 기능은 이 학습서의 두 번째 파트에서 **보안, 다중 사용자 지원** 및 **{{ site.data.keys.product_adj }} 어댑터 통합**을 참조하십시오.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  WLJSONStore.getInstance(context).openCollections(collections);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 가져오기
{: #get }
`getCollectionByName`을 사용하여 콜렉션에 대한 액세서를 작성하십시오. `getCollectionByName`을 호출하기 전에 `openCollections`를 먼저 호출해야 합니다.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

이제 변수 `collection`을 사용하여 `people` 콜렉션에 대한 조작(예: `add`, `find` 및 `replace`)을 수행할 수 있습니다.

### 추가
{: #add }
`addData`를 사용하여 데이터를 콜렉션 내에 문서로 저장하십시오.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  //Add options.
  JSONStoreAddOptions options = new JSONStoreAddOptions();
  options.setMarkDirty(true);
  JSONObject data = new JSONObject("{age: 23, name: 'yoel'}")
  collection.addData(data, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 찾기
{: #find }
`findDocuments`를 사용하여 조회를 통해 콜렉션 내에서 문서를 찾으십시오. `findAllDocuments`를 사용하여 콜렉션 내의 모든 문서를 검색하십시오. `findDocumentById`를 사용하여 문서 고유 ID로 검색하십시오.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreQueryPart queryPart = new JSONStoreQueryPart();
  // fuzzy search LIKE
  queryPart.addLike("name", name);
  JSONStoreQueryParts query = new JSONStoreQueryParts();
  query.addQueryPart(queryPart);
  JSONStoreFindOptions options = new JSONStoreFindOptions();
  // returns a maximum of 10 documents, default: returns every document
  options.setLimit(10);
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> results = collection.findDocuments(query, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 대체
{: #replace }
`replaceDocument`를 사용하여 콜렉션 내의 문서를 수정하십시오. 대체 수행 시 사용하는 필드는 문서 고유 ID인 `_id,`입니다.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreReplaceOptions options = new JSONStoreReplaceOptions();
  // mark data as dirty
  options.setMarkDirty(true);
  JSONStore replacement = new JSONObject("{_id: 1, json: {age: 23, name: 'chevy'}}");
  collection.replaceDocument(replacement, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

이 예제에서는 `{_id: 1, json: {name: 'yoel', age: 23} }` 문서가 콜렉션에 있다고 가정합니다.

### 제거
{: #remove }
`removeDocumentById`를 사용하여 콜렉션에서 문서를 삭제하십시오.
`markDocumentClean`을 호출할 때까지 콜렉션에서 문서가 지워지지 않습니다. 자세한 정보는 이 학습서 뒤쪽에 있는 **{{ site.data.keys.product_adj }} 어댑터 통합** 절을 참조하십시오.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreRemoveOptions options = new JSONStoreRemoveOptions();
  // Mark data as dirty
  options.setMarkDirty(true);
  collection.removeDocumentById(1, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 콜렉션 제거
{: #remove-collection }
`removeCollection`을 사용하여 콜렉션 내에 저장된 모든 문서를 삭제하십시오. 이 조작은 데이터베이스 용어로 된 테이블을 삭제하는 것과 유사합니다.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  collection.removeCollection();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### 영구 삭제
{: #destroy }
`destroy`를 사용하여 다음 데이터를 제거합니다.

* 모든 문서
* 모든 콜렉션
* 모든 저장소 - 이 학습서 뒤쪽의 **다중 사용자 지원** 참조
* 모든 JSONStore 메타데이터 및 보안 아티팩트 - 이 학습서 뒤쪽의 **보안** 참조

```java
Context context = getContext();
try {
  WLJSONStore.getInstance(context).destroy();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

## 고급 사용법
{: #advanced-usage }
### 보안
{: #security }
비밀번호를 사용하여 `JSONStoreInitOptions` 오브젝트를 `openCollections` 함수에 전달함으로써 저장소의 모든 콜렉션을 보호할 수 있습니다. 비밀번호가 전달되지 않으면 저장소에 포함된 모든 콜렉션의 문서가 암호화되지 않습니다.

일부 보안 메타데이터는 공유 환경 설정(Android)에 저장됩니다.  
저장소는 256비트 AES(Advanced Encryption Standard) 키로 암호화됩니다. 모든 키는 PBKDF2(Password-Based Key Derivation Function 2)로 강화됩니다.

`openCollections`를 다시 호출할 때까지 `closeAll`을 사용하여 모든 콜렉션에 대한 액세스를 잠그십시오. `openCollections`를 로그인 함수로 고려하는 경우 `closeAll`을 해당 로그아웃 함수로 고려할 수 있습니다.

`changePassword`를 사용하여 비밀번호를 변경하십시오.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setPassword("123");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### 다중 사용자 지원
{: #multiple-user-support }
단일 {{ site.data.keys.product_adj }} 애플리케이션에 여러 콜렉션을 포함하는 다중 저장소를 작성할 수 있습니다. `openCollections` 함수는 사용자 이름을 사용하여 옵션 오브젝트를 가져올 수 있습니다. 사용자 이름이 없는 경우 기본 사용자 이름은 ""**jsonstore**""입니다.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setUsername("yoel");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### {{ site.data.keys.product_adj }} 어댑터 통합
{: #mobilefirst-adapter-integration }
이 절에서는 사용자가 어댑터에 익숙하다고 가정합니다. 어댑터 통합은 선택사항이며 콜렉션의 데이터를 어댑터로 전송하고 어댑터의 데이터를 콜렉션으로 가져오는 방법을 제공합니다.
보다 유연해야 하는 경우 `WLResourceRequest`와 같은 함수를 사용하거나 고유 `HttpClient` 인스턴스를 사용하여 해당 목표를 달성할 수 있습니다.

#### 어댑터 구현
{: #adapter-implementation }
어댑터를 작성하고 이름을 "**JSONStoreAdapter**"로 지정하십시오. 해당 프로시저 `addPerson`, `getPeople`, `pushPeople`, `removePerson` 및 `replacePerson`을 정의하십시오.

```javascript
function getPeople() {
	var data = { peopleList : [{name: 'chevy', age: 23}, {name: 'yoel', age: 23}] };
	WL.Logger.debug('Adapter: people, procedure: getPeople called.');
	WL.Logger.debug('Sending data: ' + JSON.stringify(data));
	return data;
}
function pushPeople(data) {
	WL.Logger.debug('Adapter: people, procedure: pushPeople called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function addPerson(data) {
	WL.Logger.debug('Adapter: people, procedure: addPerson called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function removePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: removePerson called.');
	WL.Logger.debug('Got data from JSONStore to REMOVE: ' + data);
	return;
}
function replacePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: replacePerson called.');
	WL.Logger.debug('Got data from JSONStore to REPLACE: ' + data);
	return;
}
```

#### {{ site.data.keys.product_adj }} 어댑터의 데이터 로드
{: #load-data-from-mobilefirst-adapter }
어댑터의 데이터를 로드하려면 `WLResourceRequest`를 사용하십시오.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    try {
      JSONArray loadedDocuments = response.getResponseJSON().getJSONArray("peopleList");
    } catch(Exception e) {
      // error decoding JSON data
    }
  }
};

try {
  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/getPeople"), WLResourceRequest.GET);
  request.send(responseListener);
} catch (URISyntaxException e) {
  // handle error
}
```

#### 푸시 가져오기 필요(더티 문서)
{: #get-push-required-dirty-documents }
`findAllDirtyDocuments`를 호출하면 백엔드 시스템에 존재하지 않는 로컬 수정이 포함된 문서인 "더티 문서" 배열이 리턴됩니다.

```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocs = collection.findAllDirtyDocuments();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

JSONStore에서 문서를 "더티"로 표시하지 않게 하려면 `options.setMarkDirty(false)` 옵션을 `add`, `replace` 및 `remove`에 전달하십시오.

#### 변경사항 푸시
{: #push-changes }
어댑터에 변경사항을 푸시하려면 `findAllDirtyDocuments`를 호출하여 수정된 문서 목록을 가져온 후 `WLResourceRequest`를 사용하십시오. 데이터가 전송되고 성공 응답을 수신하면 `markDocumentsClean`을 호출하십시오.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    // handle success
  }
};
Context context = getContext();

try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocuments = people.findAllDirtyDocuments();

  JSONObject payload = new JSONObject();
  payload.put("people", dirtyDocuments);

  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/pushPeople"), WLResourceRequest.POST);
  request.send(payload, responseListener);
} catch(JSONStoreException e) {
  // handle failure
} catch (URISyntaxException e) {
  // handle error
}
```

<img alt="샘플 애플리케이션 이미지" src="android-native-screen.jpg" style="float:right; width:240px;"/>
## 샘플 애플리케이션
{: #sample-application }
JSONStoreAndroid 프로젝트에는 JSONStore API 세트를 이용하는 네이티브 Android 애플리케이션이 있습니다.  
JavaScript 어댑터 Maven 프로젝트에서도 사용 가능합니다.

네이티브 Android 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid)하십시오.  
어댑터 Maven 프로젝트를 [다운로드하려면 클릭](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80)하십시오.  

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.
