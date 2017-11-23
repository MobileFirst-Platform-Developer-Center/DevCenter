---
layout: tutorial
title: Cordova 애플리케이션의 JSONStore
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
downloads:
  - 이름: Cordova 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80
  - 이름: Adapter Maven 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 전제조건
{: #prerequisites }
* [JSONStore 상위 학습서](../)를 읽으십시오. 
* {{ site.data.keys.product_adj }} Cordova SDK가 프로젝트에 추가되었는지 확인하십시오. [Cordova 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/cordova/) 학습서에 따르십시오.  

#### 다음으로 이동:
{: #jump-to}
* [JSONStore 추가](#adding-jsonstore)
* [기본 사용법](#basic-usage)
* [고급 사용법](#advanced-usage)
* [샘플 애플리케이션](#sample-application)

## JSONStore 추가
{: #adding-jsonstore }
Cordova 애플리케이션에 JSONStore 플러그인을 추가하려면 다음을 수행하십시오. 

1. **명령행** 창을 열고 Cordova 프로젝트 폴더로 이동하십시오. 
2. `cordova plugin add cordova-plugin-mfp-jsonstore` 명령을 실행하십시오. 

![JSONStore 기능 추가](jsonstore-add-plugin.png)

## 기본 사용법
{: #basic-usage }
### 초기화
{: #initialize }
`init`를 사용하여 하나 이상의 JSONStore 콜렉션을 시작하십시오.   

콜렉션 시작 또는 프로비저닝은 콜렉션 및 문서를 보관하는 지속적 스토리지가 없는 경우 이를 작성하는 것을 의미합니다. 지속적 스토리지가 암호화되어 있고 올바른 비밀번호가 전달되면 데이터에 액세스할 수 있게 하는 필수 보안 프로시저가 실행됩니다. 

```javascript
var collections = {

  people : {
        searchFields: {name: 'string', age: 'integer'}
    }
};

WL.JSONStore.init(collections).then(function (collections) {
    // handle success - collection.people (people's collection)
}).fail(function (error) {
    // handle failure
});
```

> 초기화 시 사용할 수 있는 선택적 기능은 이 학습서의 두 번째 파트에서 **보안**, **다중 사용자 지원** 및 **{{ site.data.keys.product_adj }} 어댑터 통합**을 참조하십시오.



### 가져오기
{: #get }
`get`을 사용하여 콜렉션에 대한 액세서를 작성하십시오. get을 호출하기 전에 `init`를 호출해야 하며, 그렇지 않은 경우 `get`의 결과가 정의되지 않습니다. 

```javascript
var collectionName = 'people';
var people = WL.JSONStore.get(collectionName);
```

이제 변수 `people`을 사용하여 `people` 콜렉션에 대한 조작(예: `add`, `find` 및 `replace`)을 수행할 수 있습니다. 

### 추가
{: #add }
`add`를 사용하여 데이터를 콜렉션 내에 문서로 저장하십시오. 

```javascript
var collectionName = 'people';
var options = {};
var data = {name: 'yoel', age: 23};

WL.JSONStore.get(collectionName).add(data, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### 찾기
{: #find }
* `find`를 사용하여 조회를 통해 콜렉션 내에서 문서를 찾으십시오.   
* `findAll`을 사용하여 콜렉션 내의 모든 문서를 검색하십시오.   
* `findById`를 사용하여 문서 고유 ID로 검색하십시오.   

찾기의 기본 동작은 "퍼지" 검색 수행입니다. 

```javascript
var query = {name: 'yoel'};
var collectionName = 'people';
var options = {
  exact: false, //default
  limit: 10 // returns a maximum of 10 documents, default: return every document
};

WL.JSONStore.get(collectionName).find(query, options).then(function (results) {
    // handle success - results (array of documents found)
}).fail(function (error) {
    // handle failure
});
```

```javascript
var age = document.getElementById("findByAge").value || '';

if(age == "" || isNaN(age)){
  alert("Please enter a valid age to find");
}
else {
  query = {age: parseInt(age, 10)};
  var options = {
    exact: true,
    limit: 10 //returns a maximum of 10 documents
  };
  WL.JSONStore.get(collectionName).find(query, options).then(function (res) {
    // handle success - results (array of documents found)
}).fail(function (errorObject) {
    // handle failure
  });
}
```

### 대체
{: #replace }
`replace`를 사용하여 콜렉션 내의 문서를 수정하십시오. 대체 수행 시 사용하는 필드는 문서 고유 ID인 `_id`입니다. 

```javascript
var document = {
  _id: 1, json: {name: 'chevy', age: 23}
};
var collectionName = 'people';
var options = {};

WL.JSONStore.get(collectionName).replace(document, options).then(function (numberOfDocsReplaced) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

이 예제에서는 `{_id: 1, json: {name: 'yoel', age: 23} }` 문서가 콜렉션에 있다고 가정합니다. 

### 제거
{: #remove }
`remove`를 사용하여 콜렉션에서 문서를 삭제하십시오.   
push를 호출할 때까지 콜렉션에서 문서가 지워지지 않습니다.   

> 자세한 정보는 이 학습서 뒤쪽에 있는 **{{ site.data.keys.product_adj }} 어댑터 통합** 절을 참조하십시오. 

```javascript
var query = {_id: 1};
var collectionName = 'people';
var options = {exact: true};
WL.JSONStore.get(collectionName).remove(query, options).then(function (numberOfDocsRemoved) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### 콜렉션 제거
{: #remove-collection }
`removeCollection`을 사용하여 콜렉션 내에 저장된 모든 문서를 삭제하십시오. 이 조작은 데이터베이스 용어로 된 테이블을 삭제하는 것과 유사합니다. 

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).removeCollection().then(function (removeCollectionReturnCode) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

## 고급 사용법
{: #advanced-usage }
### 영구 삭제
{: #destory }
`destroy`를 사용하여 다음 데이터를 제거하십시오. 

* 모든 문서
* 모든 콜렉션
* 모든 저장소(이 학습서 뒤쪽의 "**다중 사용자 지원**" 참조)
* 모든 JSONStore 메타데이터 및 보안 아티팩트(이 학습서 뒤쪽의 **보안** 참조)

```javascript
var collectionName = 'people';
WL.JSONStore.destroy().then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### 보안
{: #security }
`init` 함수에 비밀번호를 전달하여 저장소에 있는 모든 콜렉션을 보호할 수 있습니다. 비밀번호가 전달되지 않으면 저장소에 포함된 모든 콜렉션의 문서가 암호화되지 않습니다. 

데이터 암호화는 Android, iOS, Windows 8.1 Universal 및 Windows 10 UWP 환경에서만 사용 가능합니다.   
일부 보안 메타데이터는 *키 체인*(iOS), *공유 환경 설정*(Android) 또는 *신임 정보 보관*(Windows 8.1)에 저장됩니다.   
저장소는 256비트 AES(Advanced Encryption Standard) 키로 암호화됩니다. 모든 키는 PBKDF2(Password-Based Key Derivation Function 2)로 강화됩니다. 

`init`를 다시 호출할 때까지 `closeAll`을 사용하여 모든 콜렉션에 대한 액세스를 잠그십시오. `init`를 로그인 함수로 고려하는 경우 `closeAll`을 해당 로그아웃 함수로 고려할 수 있습니다. `changePassword`를 사용하여 비밀번호를 변경하십시오. 

```javascript
var collections = {

  people: {
    searchFields: {name: 'string'}
  }
};
var options = {password: '123'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### 암호화
{: #encryption }
*iOS만 해당*됩니다. 기본적으로 iOS용 {{ site.data.keys.product_adj }} Cordova SDK는 암호화에 iOS 제공 API를 사용합니다. 이를 OpenSSL로 대체하려면 다음을 수행하십시오. 

1. cordova-plugin-mfp-encrypt-utils 플러그인을 다음과 같이 추가하십시오. `cordova plugin add cordova-plugin-mfp-encrypt-utils`
2. 애플리케이션 로직에서 `WL.SecurityUtils.enableNativeEncryption(false)`을 사용하여 OpenSSL 옵션을 사용하도록 설정하십시오. 

### 다중 사용자 지원
{: #multiple-user-support }
단일 {{ site.data.keys.product_adj }} 애플리케이션에 여러 콜렉션을 포함하는 다중 저장소를 작성할 수 있습니다. `init` 함수는 사용자 이름을 사용하여 옵션 오브젝트를 가져올 수 있습니다. 사용자 이름이 없는 경우 기본 사용자 이름은 **jsonstore**입니다. 

```javascript
var collections = {

  people: {
    searchFields: {name: 'string'}
  }
};
var options = {username: 'yoel'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### {{ site.data.keys.product_adj }} 어댑터 통합
{: #mobilefirst-adapter-integration }
이 절에서는 사용자가 어댑터에 익숙하다고 가정합니다.   

어댑터 통합은 선택사항이며 콜렉션의 데이터를 어댑터로 전송하고 어댑터의 데이터를 콜렉션으로 가져오는 방법을 제공합니다.   
보다 유연해야 하는 경우 `WLResourceRequest` 또는 `jQuery.ajax`를 사용하여 해당 목표를 달성할 수 있습니다. 

### 어댑터 구현
{: #adapter-implementation }
어댑터를 작성하고 이름을 "**People**"로 지정하십시오.   
해당 프로시저 `addPerson`, `getPeople`, `pushPeople`, `removePerson` 및 `replacePerson`을 정의하십시오. 

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

#### {{ site.data.keys.product_adj }} 어댑터에 링크된 콜렉션 초기화
{: #initialize-a-collection-linked-to-a-mobilefirst-adapter }
```javascript
var collections = {

  people : {
    searchFields : {name: 'string', age: 'integer'},
    adapter : {
      name: 'People',
      add: 'addPerson',
      remove: 'removePerson',
      replace: 'replacePerson',
      load: {
        procedure: 'getPeople',
        params: [],
        key: 'peopleList'
      }     
    }   
  }
}

var options = {};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### 어댑터의 데이터 로드
{: #load-data-from-an-adapter }
`load`가 호출되면 JSONStore는 이전에 `init`에 전달한 어댑터에 대한 일부 메타데이터(**이름** 및 **프로시저**)를 사용하여 어댑터에서 가져올 데이터를 판별한 후 해당 데이터를 저장합니다. 

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).load().then(function (loadedDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### 푸시 가져오기 필요(더티 문서)
{: #get-push-required-dirty-documents }
`getPushRequired`를 호출하면 백엔드 시스템에 존재하지 않는 로컬 수정이 포함된 문서인 *"더티 문서"* 배열이 리턴됩니다. 이러한 문서는 `push` 호출 시 어댑터에 전송됩니다. 

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).getPushRequired().then(function (dirtyDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

JSONStore에서 문서를 "더티"로 표시하지 않게 하려면 `{markDirty:false}` 옵션을 `add`, `replace` 및 `remove`에 전달하십시오. 

`getAllDirty` API를 사용하여 더티 문서를 검색할 수도 있습니다. 

```javascript
WL.JSONStore.get(collectionName).getAllDirty()
.then(function (dirtyDocuments) {
    // handle success
}).fail(function (errorObject) {
    // handle failure
});
```

#### 푸시
{: #push }
`push`는 변경된 문서를 올바른 어댑터 프로시저로 보냅니다(즉 로컬로 추가된 문서를 사용하여 `addPerson`이 호출됨). 이 메커니즘은 `init`에 전달된 어댑터 메타데이터 및 변경된 문서와 연관된 마지막 조작을 기반으로 합니다. 

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).push().then(function (response) {
    // handle success
    // response is an empty array if all documents reached the server
    // response is an array of error responses if some documents failed to reach the server
}).fail(function (error) {
    // handle failure
});
```

### 확장
{: #enhance }
`enhance`로 콜렉션 프로토타입에 함수를 추가하여 요구사항을 충족하도록 핵심 API를 확장하십시오.
다음 예제(아래의 코드 스니펫)는 `enhance`를 사용하여 `keyvalue` 콜렉션에서 작업하는 `getValue` 함수를 추가하는 방법을 보여줍니다. 이는 `key`(문자열)를 유일한 매개변수로 사용하고 하나의 결과를 리턴합니다. 

```javascript
var collectionName = 'keyvalue';
WL.JSONStore.get(collectionName).enhance('getValue', function (key) {
    var deferred = $.Deferred();
    var collection = this;
    //Do an exact search for the key
    collection.find({key: key}, {exact:true, limit: 1}).then(deferred.resolve, deferred.reject);
    return deferred.promise();
});

//Usage:
var key = 'myKey';
WL.JSONStore.get(collectionName).getValue(key).then(function (result) {
    // handle success
    // result contains an array of documents with the results from the find
}).fail(function () {
    // handle failure
});
```

> JSONStore에 대한 자세한 정보는 사용자 문서를 참조하십시오. 

<img alt="JSONStore 샘플 앱" src="jsonstore-cordova.png" style="float:right"/>
## 샘플 애플리케이션
{: #sample-application }
JSONStoreSwift 프로젝트에는 JSONStore API 세트를 이용하는 Cordova 애플리케이션이 있습니다.   
JavaScript 어댑터 Maven 프로젝트에서도 사용 가능합니다. 

Cordova 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80)하십시오.   
어댑터 Maven 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80)하십시오.   

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 
