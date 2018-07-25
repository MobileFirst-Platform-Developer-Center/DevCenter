---
layout: tutorial
title: JSONStore 문제점 해결
breadcrumb_title: JSONStore
relevantTo: [ios,android,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
JSONStore API를 사용할 때 발생할 수 있는 문제를 해결하는 데 도움을 주는 정보를 찾아보십시오.

## 도움을 요청할 때 정보 제공
{: #provide-information-when-you-ask-for-help }
충분하지 않은 정보를 제공하는 것보다는 자세한 정보를 제공하는 것이 좋습니다. JSONStore 문제에 대해 도움을 주기 위해서는 다음 목록과 같은 정보를 먼저 제공하는 것이 좋습니다.

* 운영 체제 및 버전. 예를 들면, Windows XP SP3 Virtual Machine 또는 Mac OSX 10.8.3과 같습니다.
* Eclipse 버전. 예를 들면, Eclipse Indigo 3.7 Java EE와 같습니다.
* JDK 버전. 예를 들면, Java SE Runtime Environment(빌드 1.7)와 같습니다.
* {{ site.data.keys.product }} 버전. 예를 들면, IBM Worklight V5.0.6 Developer Edition과 같습니다.
* iOS 버전. 예를 들면, iOS Simulator 6.1 또는 iPhone 4S iOS 6.0(더 이상 사용되지 않음, 더 이상 사용되지 않는 기능 및 API 요소 참고)과 같습니다.
* Android 버전. 예를 들면, Android Emulator 4.1.1 또는 Samsung Galaxy Android 4.0 API 레벨 14와 같습니다.
* Windows 버전. 예를 들면, Windows 8, Windows 8.1 또는 Windows Phone 8.1과 같습니다.
* adb 버전. 예를 들면, Android Debug Bridge 버전 1.0.31과 같습니다.
* iOS의 Xcode 출력이나 Android의 logcat 출력과 같은 로그.

## 문제 격리
{: #try-to-isolate-the-issue }
문제점을 더 정확하게 보고하기 위해 문제를 격리하려면 다음 단계를 따르십시오.

1. 에뮬레이터(Android) 또는 시뮬레이터(iOS)를 재설정하고 destroy API를 호출하여 시스템을 정리된 상태로 시작하십시오.
2. 지원되는 프로덕션 환경에서 실행 중인지 확인하십시오.
    * Android >= 2.3 ARM v7/ARM v8/x86 에뮬레이터 또는 디바이스
    * iOS >= 6.0 시뮬레이터 또는 디바이스(더 이상 사용되지 않음)
    * Windows 8.1/10 ARM/x86/x64 시뮬레이터 또는 디바이스
3. init 또는 open API에 비밀번호를 전달하지 않음으로써 암호화를 끄십시오.
4. JSONStore에 의해 생성된 SQLite 데이터베이스 파일을 살펴보십시오. 암호화가 꺼져 있어야 합니다.

   * Android 에뮬레이터:

   ```bash
   $ adb shell
   $ cd /data/data/com.<app-name>/databases/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * iOS 시뮬레이터:

   ```bash
   $ cd ~/Library/Application Support/iPhone Simulator/7.1/Applications/<id>/Documents/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```  

   * Windows 8.1 Universal / Windows 10 UWP 시뮬레이터:

   ```bash
   $ cd C:\Users\<username>\AppData\Local\Packages\<id>\LocalState\wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * **참고:** 웹 브라우저(Firefox, Chrome, Safari, Internet Explorer)에서 실행되는 JavaScript 전용 구현은 SQLite 데이터베이스를 사용하지 않습니다. 이 파일은 HTML5 LocalStorage에 저장됩니다.
   * `.schema`를 포함하는 `searchFields`를 살펴보고 `SELECT * FROM <collection-name>;`으로 데이터를 선택하십시오. sqlite3를 종료하려면 `.exit`를 입력하십시오. init 메소드에 사용자 이름을 전달하는 경우 이 파일의 이름은 **the-username.sqlite**입니다. 사용자 이름을 전달하지 않는 경우 이 파일의 이름은 기본적으로 **jsonstore.sqlite**입니다.
5. (Android 한정) 상세 JSONStore를 사용으로 설정하십시오.

   ```bash
   adb shell setprop log.tag.jsonstore-core VERBOSE
   adb shell getprop log.tag.jsonstore-core
   ```

6. 디버거를 사용하십시오.

## 일반적인 문제
{: #common-issues }
다음 JSONStore 특성을 이해하면 발생할 수 있는 일반적인 문제 중 일부를 해결하는 데 도움이 됩니다.  

* 2진 데이터를 JSONStore에 저장하는 유일한 방법은 이를 먼저 base64로 인코딩하는 것입니다. 실제 파일 대신 파일 이름 또는 경로를 JSONStore에 저장하십시오.
* 네이티브 코드에서 JSONStore 데이터에 액세스하는 것은 {{ site.data.keys.v62_product_full }} V6.2.0에서만 가능합니다.
* JSONStore에는 모바일 운영 체제에서 제한하는 한계를 초과하여 무제한으로 데이터를 저장할 수 있습니다.
* JSONStore는 지속적 데이터 스토리지를 제공합니다. 이는 메모리에만 저장되지 않습니다.
* 콜렉션 이름이 숫자 또는 기호로 시작하는 경우 init API가 실패합니다. IBM Worklight V5.0.6.1 이상에서는 적절한 오류(`4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING`)를 리턴합니다.
* 검색 필드에서 숫자와 정수 사이에 차이가 있습니다. `1` 및 `2`와 같은 숫자 값은 유형이 `number`인 경우 `1.0` 및 `2.0`으로 저장됩니다. 유형이 `integer`인 경우에는 `1` 및 `2`로 저장됩니다.
* 애플리케이션이 강제 중지되거나 충돌한 경우, 애플리케이션이 다시 시작된 후 `init` 또는 `open` API가 호출되면 항상 오류 코드 -1이 발생하며 실패합니다. 이 문제점이 발생하면 먼저 `closeAll` API를 호출하십시오.
* JSONStore의 JavaScript 구현에서는 코드가 연속으로 호출될 것을 예상합니다. 다음 조작을 호출하기 전에 조작이 완료되기를 기다리십시오.
* Android 2.3.x에서는 Cordova 애플리케이션에 대해 트랜잭션이 지원되지 않습니다.
* 64비트 디바이스에서 JSONStore를 사용하는 경우에는 오류 `java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit`가 표시될 수 있습니다.
* 이 오류는 Android 프로젝트에 64비트 기본 라이브러리가 있으며 이러한 라이브러리를 사용하는 경우 JSONStore가 현재 작동하지 않음을 의미합니다. 확인하려면 Android 프로젝트의 **src/main/libs** 또는 **src/main/jniLibs**로 이동하여 x86_64 또는 arm64-v8a 폴더가 있는지 확인하십시오. 있는 경우에는 이러한 폴더를 삭제하면 JSONStore가 다시 작동합니다.
* 일부 경우(또는 환경)에는 JSONStore 플러그인이 초기화되기 전에 플로우가 `wlCommonInit()`로 들어갑니다. 이렇게 되면 JSONStore 관련 API 호출이 실패합니다. `cordova-plugin-mfp` 부트스트랩은 `WL.Client.init`를 자동으로 호출하며 이는 완료되면 `wlCommonInit` 함수를 트리거합니다. 이 초기화 프로세스는 JSONStore 플러그인의 경우 다릅니다. JSONStore 플러그인에는 `WL.Client.init` 호출을 _정지_시킬 수단이 없습니다. 다양한 환경에서, `mfpjsonjslloaded`가 완료되기 전에 플로우가 `wlCommonInit()`로 들어가는 경우가 있습니다.
개발자는 `mfpjsonjsloaded` 및 `mfpjsloaded` 이벤트의 순서를 지정하기 위해 `WL.CLient.init`를
수동으로 호출할 수 있습니다. 이렇게 하면 플랫폼별 코드를 갖출 필요가 없습니다.

  `WL.CLient.init`의 수동 호출을 구성하려면 아래 단계를 따르십시오.                             

  1. `config.xml`에서 `clientCustomInit` 특성을 **true**로 변경하십시오.

  + `index.js` 파일에서 다음 작업을 수행하십시오.                                   
    * 파일의 시작 부분에 다음 행을 추가하십시오.                
      ```javascript
      document.addEventListener('mfpjsonjsloaded', initWL, false);
      ```           
    * `wlCommonInit()`에 `WL.JSONStore.init` 호출을 남겨 두십시오.                    

    * 다음 함수를 추가하십시오.  
    ```javascript                                         
function initWL(){                                                     
var options = typeof wlInitOptions !== 'undefined' ? wlInitOptions
        : {};                                                                
        WL.Client.init(options);                                           
}                                                                      
```                                                                       

이는 `mfpjsonjsloaded` 이벤트(`wlCommonInit` 외부)를 기다려
스크립트가 로드되었는지 확인한 후 `WL.Client.init`를 호출하고, 이는 `wlCommonInit`를 트리거하며, 이는 그 후 `WL.JSONStore.init`를 호출합니다.

## 저장소 내부
{: #store-internals }
JSONStore 데이터가 저장되는 방식에 대한 예를 보십시오.

이 단순 예의 주요 요소는 다음과 같습니다.

* `_id`는 고유 ID입니다(예: AUTO INCREMENT PRIMARY KEY).
* `json`은 저장되는 JSON 오브젝트의 정확한 표현을 포함합니다.
* `name` 및 `age`는 검색 필드입니다.
* `key`는 추가 검색 필드입니다.

| _id | key | name | age | JSON |
|-----|-----|------|-----|------|
| 1   | c   | carlos | 99 | {name: 'carlos', age: 99} |
| 2   | t   | tim   | 100 | {name: 'tim', age: 100} |

`{_id : 1}, {name: 'carlos'}`, `{age: 99}, {key: 'c'}`와 같은 조회 중 하나 또는 이러한 조회의 조합을 사용하여 검색하는 경우 리턴되는 문서는 `{_id: 1, json: {name: 'carlos', age: 99} }`입니다.

다른 내부 JSONStore 필드는 다음과 같습니다.

* `_dirty`: 문서의 더티 상태 표시 여부를 나타냅니다. 이 필드는 문서의 변경사항을 추적하는 데 유용합니다.
* `_deleted`: 문서의 삭제 여부를 표시합니다. 이 필드는 콜렉션에서 오브젝트를 제거한 후, 나중에 이러한 항목을 사용하여 백엔드에서 변경사항을 추적하고 해당 항목의 제거 여부를 결정하는 데 유용합니다.
* `_operation`: 문서에 수행되는 마지막 조작을 나타내는 문자열입니다(예: replace).

## JSONStore 오류
{: #jsonstore-errors }
### JavaScript
{: #javascript }
JSONStore는 error 오브젝트를 사용하여 실패 원인에 대한 메시지를 리턴합니다.

JSONStore 조작(`JSONStoreInstance` 클래스의 `find` 및 `add` 메소드) 중에 오류가 발생하면 error 오브젝트가 리턴됩니다. 이는 실패 원인에 대한 정보를 제공합니다.

```javascript
var errorObject = {
  src: 'find', // Operation that failed.
  err: -50, // Error code.
  msg: 'PERSISTENT\_STORE\_FAILURE', // Error message.
  col: 'people', // Collection name.
  usr: 'jsonstore', // User name.
  doc: {_id: 1, {name: 'carlos', age: 99}}, // Document that is related to the failure.
  res: {...} // Response from the server.
}
```

모든 키/값 쌍이 모든 error 오브젝트의 일부인 것은 아닙니다. 예를 들어, doc 값은 문서(예: `JSONStoreInstance` 클래스의 `remove` 메소드)가 문서를 제거하는 데 실패하여 조작이 실패한 경우에만 사용 가능합니다.

### Objective-C
{: #objective-c }
실패할 수 있는 모든 API는 NSError 오브젝트의 주소를 취하는 error 매개변수를 갖습니다. 오류에 대한 알림을 받지 않으려는 경우에는 `nil`을 전달할 수 있습니다. 조작이 실패하면 주소가 오류 및 몇 가지 잠재적 `userInfo`를 포함하는 NSError로 채워집니다. `userInfo`는 추가 세부사항(예: 실패를 발생시킨 문서)을 포함할 수 있습니다.

```objc
// This NSError points to an error if one occurs.
NSError* error = nil;

// Perform the destroy.
[JSONStore destroyDataAndReturnError:&error];
```

### Java
{: #java }
모든 Java API 호출은 발생한 오류에 따라 특정 예외 처리(throw)를 수행합니다. 사용자는 각 예외를 개별적으로 처리하거나, 모든 JSONStore 예외에 대한 엄브렐라로서 `JSONStoreException`을 예외 처리(catch)할 수 있습니다.

```java
try {
  WL.JSONStore.closeAll();
}

catch(JSONStoreException e) {
  // Handle error condition.
}
```

### 오류 코드 목록
{: #list-of-error-codes }
일반적인 오류 코드와 해당 설명의 목록입니다.

|오류 코드       | 설명        |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | 인식되지 않은 오류입니다. |
| -75 OS\_SECURITY\_FAILURE | 이 오류 코드는 requireOperatingSystemSecurity 플래그와 관련되어 있습니다. 이는 destroy API가 운영 체제 보안(패스코드 대체를 사용하는 Touch ID)으로 보호되는 보안 메타데이터를 제거하는 데 실패하거나, init 또는 open API가 보안 메타데이터를 찾을 수 없는 경우 발생할 수 있습니다. 이는 디바이스가 운영 체제 보안을 지원하지 않지만 운영 체제 보안 사용이 요청된 경우에도 실패할 수 있습니다. |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore가 닫혀 있습니다. 먼저 JSONStore 클래스에 있는 open 메소드를 호출하여 저장소에 액세스할 수 있도록 설정하십시오. |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | 트랜잭션 롤백 중에 문제점이 발생했습니다. |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION | 트랜잭션이 진행 중인 동안에는 removeCollection을 호출할 수 없습니다. |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | 트랜잭션이 진행 중인 동안에는 destroy를 호출할 수 없습니다. |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | 트랜잭션이 진행 중인 동안에는 closeAll을 호출할 수 없습니다. |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | 트랜잭션이 진행 중인 동안에는 저장소를 초기화할 수 없습니다. |
| -43 TRANSACTION_FAILURE | 트랜잭션에서 문제점이 발생했습니다. |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | 트랜잭션이 진행 중이지 않은 경우에는 트랜잭션 롤백을 커미트할 수 없습니다. |
| -41 TRANSACTION\_IN\_POGRESS | 다른 트랜잭션이 진행 중인 동안에는 새 트랜잭션을 시작할 수 없습니다. |
| -40 FIPS\_ENABLEMENT\_FAILURE | FIPS에 문제점이 있습니다. |
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | 파일 시스템에서 파일 정보를 가져오는 데 문제점이 있습니다. |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | 콜렉션에서 문서를 바꾸는 데 문제점이 있습니다. |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | 콜렉션에서 문서를 제거하는 데 문제점이 있습니다. |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | 데이터 보호 키(DPK)를 저장하는 데 문제점이 있습니다. |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | 입력 데이터를 색인화하는 데 문제점이 있습니다. |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | searchFields에 전달하는 유형이 string, integer, number 또는 boolean인지 확인하십시오. |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | 특정 문서에 대해서는 작동하는 조작이 문서 배열에 대해서는 실패할 수 있습니다(예: replace 메소드). 실패가 발생한 문서가 리턴되었으며 트랜잭션이 롤백되었습니다. Android에서는 지원되지 않는 아키텍처에서 JSONStore를 사용하려고 시도하는 경우에도 이 오류가 발생합니다. |
| -10 ACCEPT\_CONDITION\_FAILED | 사용자가 제공한 accept 함수가 false를 리턴했습니다. |
| -9 OFFSET\_WITHOUT\_LIMIT | 오프셋을 사용하려면 한계를 지정해야 합니다. |
| -8 INVALID\_LIMIT\_OR\_OFFSET | 유효성 검증 오류입니다. 이는 양의 정수여야 합니다. |
| -7 INVALID_USERNAME | 유효성 검증 오류가 발생했습니다([A-Z] 또는 [a-z] 또는 [0-9]여야 함). |
| -6 USERNAME\_MISMATCH\_DETECTED | JSONStore 사용자는 로그아웃하려면 먼저 closeAll 메소드를 호출해야 합니다. 한 번에 한 명의 사용자만 있을 수 있습니다. |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED | destroy 메소드가 저장소의 컨텐츠를 포함하는 파일을 삭제하려고 하는 중에 destroy 메소드에서 문제점이 발생했습니다. |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | destroy 메소드가 키체인(iOS) 또는 공유 사용자 환경 설정(Android)을 지우려고 하는 중에 destroy 메소드에서 문제점이 발생했습니다. |
| -3 INVALID\_KEY\_ON\_PROVISION | 암호화된 저장소에 잘못된 비밀번호를 전달했습니다. |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | 검색 필드는 동적이지 않습니다. 새 검색 필드를 사용하여 init 또는 open 메소드를 호출하기 전에 destroy 또는 removeCollection 메소드를 호출하지 않고 검색 필드를 변경할 수는 없습니다. 이 오류는 검색 필드의 이름 또는 유형을 변경하는 경우 발생할 수 있습니다. 예를 들면, {key: 'string'}을 {key: 'number'}로, 또는 {myKey: 'string'}을 {theKey: 'string'}으로 변경하는 경우가 있습니다. |
| -1 PERSISTENT\_STORE\_FAILURE | 일반 오류입니다. 네이티브 코드에 문제가 있으며, init 메소드 호출이 관련되어 있을 가능성이 가장 높습니다. |
| 0 SUCCESS | 일부 경우, JSONStore 네이티브 코드는 성공을 표시하기 위해 0을 리턴합니다. |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | 유효성 검증 오류입니다. |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | 유효성 검증 오류입니다. |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | 유효성 검증 오류입니다. |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | 유효성 검증 오류입니다. |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | 유효성 검증 오류입니다. |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | 유효성 검증 오류입니다. |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | 유효성 검증 오류입니다. |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB | 더티 상태로 표시된 모든 문서를 선택하는 조회가 실패했습니다. 이 조회의 SQL 예는 SELECT * FROM [collection] WHERE _dirty > 0과 같습니다. |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | JSONStoreCollection 클래스의 push 및 load 메소드와 같은 함수를 사용하려면 init 메소드에 어댑터를 전달해야 합니다. |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | 유효성 검증 오류입니다. |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | 유효성 검증 오류입니다. |
| 12 ADAPTER_FAILURE | WL.Client.invokeProcedure 호출에서 문제점이 발생했습니다(구체적으로는 어댑터 연결 문제). 이 오류는 백엔드를 호출하려고 시도하는 어댑터의 실패와는 다릅니다. |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | 유효성 검증 오류입니다.  |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | 기존 함수(find 및 add)를 대체하기 위해 JSONStoreCollection 클래스의 enhance 메소드를 호출하는 것은 허용되지 않습니다. |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | 푸시가 문서를 어댑터에 전송하지만 JSONStore가 문서가 더티 상태가 아님을 표시하는 데 실패합니다. |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | 비밀번호를 사용하는 콜렉션을 시작하려면 '무작위 보안 토큰'을 반환받기 위해 {{ site.data.keys.mf_server }}와의 연결이 필요합니다. IBM Worklight V5.0.6 이상에서는 개발자가 options 오브젝트를 통해 {localKeyGen: true}를 init 메소드에 전달하여 무작위 보안 토큰을 로컬로 생성하는 것을 허용합니다. |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | WL.Client.invokeProcedure가 실패 콜백을 호출하여 데이터를 로드하지 못했습니다. |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | init 메소드에 전달된 load 오브젝트가 유효성 검증을 통과하지 못했습니다. |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | add 메소드를 호출할 때 load 오브젝트에서 사용된 키에 문제점이 있습니다. |
| 20 UNDEFINED\_PUSH\_OPERATION | 더티 상태의 문서를 서버에 푸시하기 위한 프로시저가 정의되지 않았습니다. 예: init 메소드(새 문서가 더티 상태임, 조작 = 'add') 및 push 메소드(조작 = 'add'로 새 문서를 찾음)가 호출되었지만, add 프로시저를 포함하는 add 키가 콜렉션에 링크된 어댑터에 없습니다. 어댑터 링크는 init 메소드 내에서 수행됩니다. |
| 21 INVALID\_ADD\_INDEX\_KEY | 추가 검색 필드에 문제점이 있습니다. |
| 22 INVALID\_SEARCH\_FIELD | 검색 필드 중 하나가 올바르지 않습니다. 전달된 검색 필드 중에 _id, json, _deleted 또는 _operation이 있지 않은지 확인하십시오. |
| 23 ERROR\_CLOSING\_ALL | 일반 오류입니다. 네이티브 코드에서 closeAll 메소드를 호출할 때 오류가 발생했습니다. |
| 24 ERROR\_CHANGING\_PASSWORD | 비밀번호를 변경할 수 없습니다. 예를 들면, 전달된 이전  비밀번호가 잘못된 경우 등이 있습니다. |
| 25 ERROR\_DURING\_DESTROY | 일반 오류입니다. 네이티브 코드에서 destroy 메소드를 호출할 때 오류가 발생했습니다. |
| 26 ERROR\_CLEARING\_COLLECTION | 일반 오류입니다. 네이티브 코드에서 removeCollection 메소드를 호출할 때 오류가 발생했습니다. |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | 유효성 검증 오류입니다. |
| 28 INVALID\_SORT\_OBJECT | JSON 오브젝트 중 하나가 올바르지 않아 정렬을 위해 제공된 배열이 올바르지 않습니다. 올바른 구문은 JSON 오브젝트의 배열이며, 여기서 각 오브젝트는 하나의 특성만을 포함합니다. 이 특성은 정렬 기준이 되는 필드와 오름차순 또는 내림차순 여부를 검색합니다. 예: {searchField1 : "ASC"}. |
| 29 INVALID\_FILTER\_ARRAY | 결과 필터링을 위해 제공된 배열이 올바르지 않습니다. 이 배열의 올바른 구문은 문자열 배열이며, 각 문자열은 검색 필드 또는 내부 JSONStore 필드입니다. 자세한 정보는 "저장소 내부"를 참조하십시오. |
| 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | 배열이 JSON 오브젝트만의 배열이 아닌 경우 유효성 검증 오류입니다. |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | 유효성 검증 오류입니다. |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | 유효성 검증 오류입니다. |
