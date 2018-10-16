---
layout: tutorial
title: 이벤트 소스 기반 알림에서 푸시 알림 마이그레이션
breadcrumb_title: Migrating push notifications
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }} v8.0에서 이벤트 소스 기반 모델은 지원되지 않으며, 푸시 알림 기능은 전적으로 푸시 서비스 모델에서 사용됩니다. {{ site.data.keys.product_adj }}의 이전 버전에서 기존 이벤트 소스 기반 애플리케이션을 v8.0으로 이동하려면 새 푸시 서비스 모델로 마이그레이션되어야 합니다.

마이그레이션은 다른 API 대신 특정 API를 사용하는 데 대한 것이 아니라 다른 모델/접근 방식 대비 특정 모델/접근 방식을 사용하는 데 대한 것임을 주의해야 합니다.

예를 들어, 이벤트 소스 기반 모델에서 특정 세그먼트에 알림을 전송하도록 모바일 애플리케이션 사용자를 세그먼트화하려는 경우 모든 세그먼트를 별도의 이벤트 소스로 모델링할 수 있습니다. 푸시 서비스 모델에서는 세그먼트를 나타내는 태그를 정의하고 각 태그에 사용자를 등록하여 동일하게 수행합니다. 태그 기반 알림은 이벤트 소스 기반 알림을 대체합니다.

#### 다음으로 이동
{: #jump-to }
* [마이그레이션 시나리오](#migration-scenarios)
* [마이그레이션 도구](#migration-tool)

<br/>

다음 표는 두 모델 사이의 비교를 제공합니다.

|사용자 요구사항 |이벤트 소스 모델 |푸시 서비스 모델 |
|------------------|--------------------|--------------------|
|애플리케이션에서 푸시 알림 사용 | {::nomarkdown}<ul><li>이벤트 소스 어댑터를 작성하고 해당 어댑터 내에 EventSource를 작성하십시오.</li><li>푸시 신임 정보를 사용하여 애플리케이션을 구성하거나 설정하십시오.</li></ul>{:/} |푸시 신임 정보를 사용하여 애플리케이션을 구성하거나 설정하십시오. |
|모바일 클라이언트 애플리케이션에서 푸시 알림 사용 | {::nomarkdown}<ul><li>WLClient 작성</li><li>{{ site.data.keys.mf_server }}에 연결</li><li>푸시 클라이언트 인스턴스 가져오기</li><li>이벤트 소스에 등록</li></ul>{:/} |{::nomarkdown}<ul><li>푸시 클라이언트 인스턴스화</li><li>푸시 클라이언트 초기화</li><li>모바일 디바이스 등록</li></ul>{:/} |
|특정 태그 기반의 알림에 모바일 클라이언트 애플리케이션 사용 |지원되지 않음. |태그 이름을 사용하여 관심있는 태그에 등록하십시오. |
|모바일 클라이언트 애플리케이션에서 알림 수신 및 처리 |리스너 구현을 등록하십시오. |리스너 구현을 등록하십시오. |
|모바일 클라이언트 애플리케이션에 푸시 알림 보내기 | {::nomarkdown}<ul><li>WL.Server API를 내부적으로 호출하여 푸시 알림을 보낼 어댑터 프로시저를 구현하십시오.</li><li>WL Server API는 알림을 보낼 방법을 제공합니다.<ul><li>사용자가 수행</li><li>디바이스로 수행</li><li><li>브로드캐스트(모든 디바이스)</li></ul></li><li>그런 다음 백엔드 서버 애플리케이션이 푸시 알림을 애플리케이션 로직의 일부로 트리거하는 어댑터 프로시저를 호출할 수 있습니다.</li></ul>{:/} |{::nomarkdown}<ul><li>백엔드 서버 애플리케이션은 messages REST API를 직접 호출할 수 있습니다. 그러나 이러한 애플리케이션은 {{ site.data.keys.mf_server }}에 기밀 클라이언트로 등록하고 REST API의 권한 부여 헤더에 전달되어야 하는 올바른 OAuth 액세스 토큰을 얻어야 합니다.</li><li>REST API는 알림을 보내는 옵션을 제공합니다.<ul><li>사용자가 수행</li><li>디바이스로 수행</li><li>플랫폼으로 수행</li><li>태그로 수행</li><li>브로드캐스트(모든 디바이스)</li></ul></li></ul>{:/} |
|정기적(폴링 간격)으로 푸시 알림 트리거 |이벤트 소스 어댑터 내에서 푸시 알림을 보내는 기능을 createEventSource 함수 호출의 일부로 구현합니다. |지원되지 않음. |
|이름, URL 및 이벤트 유형에 후크 등록 |푸시 알림에 대한 디바이스 등록 또는 등록 취소 경로에 후크를 구현합니다. |지원되지 않음. |

## 마이그레이션 시나리오
{: #migration-scenarios }
{{ site.data.keys.product }} v8.0부터 이벤트 소스 기반 모델은 지원되지 않으며 {{ site.data.keys.product }}에서 푸시 알림 기능은 전적으로 푸시 서비스 모델에 의해 사용될 수 있습니다. 푸시 서비스 모델은 이벤트 소스 모델을 대체하는 더 간단하고 빠른 방법입니다.

IBM MobileFirst Platform Foundation의 이전 버전에서 기존 이벤트 소스 기반 애플리케이션은 v8.0의 새 푸시 서비스 모델로 마이그레이션되어야 합니다.

#### 다음 섹션으로 이동
{: #jump-to-section }
* [하이브리드 애플리케이션](#hybrid-applications)
* [네이티브 Android 애플리케이션](#native-android-applications)
* [네이티브 iOS 애플리케이션](#native-ios-applications)
* [네이티브 Windows Universal 애플리케이션](#native-windows-universal-applications)

### 하이브리드 애플리케이션
{: #hybrid-applications }
이 마이그레이션 시나리오의 예제는 하나의 이벤트 소스 또는 여러 소스, 브로드캐스트 또는 유니캐스트 알림, 또는 태그 알림을 사용하는 애플리케이션을 다룹니다.

#### 시나리오 1: 애플리케이션에서 단일 이벤트 소스를 사용하는 기존 애플리케이션
{: #hybrid-scenario-1-existing-applications-using-single-event-source-in-their-application }
이전 버전의 {{ site.data.keys.product_adj }}에서는 이벤트 소스 기반 모델을 통해서만 푸시를 지원했으므로 애플리케이션은 해당 버전에서 단일 이벤트 소스를 사용했습니다.

##### 클라이언트
{: #client-hybrid-1 }
V8.0.0에서 마이그레이션하려면 이 모델을 Unicast 알림으로 변환하십시오.

1. 애플리케이션에서 {{ site.data.keys.product_adj }} 푸시 클라이언트 인스턴스를 초기화하고 성공 콜백에서 알림을 수신해야 하는 콜백 메소드를 등록하십시오.

   ```javascript
   MFPPush.initialize(function(successResponse){
   MFPPush.registerNotificationsCallback(notificationReceived); },
   function(failureResponse){alert("Failed to initialize");    
                              }  
   );
   ```

2. 알림 콜백 메소드를 구현하십시오.

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. WL.Client.Push.isPushSupported()가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```

6. 등록할 이벤트 소스가 없으므로 다음 `WL.Client.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

##### 서버
{: #server-hybrid-1 }
1. 어댑터에서 다음 WL.Server API가 사용된 경우 이를 제거하십시오.
    * `notifyAllDevices()`
    * `notifyDevice()`
    * `notifyDeviceSubscription()`
    * `createEventSource()`
2. 동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.
    1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

        또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
    2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
    3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
    4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
        * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
        * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

#### 시나리오 2: 애플리케이션에서 여러 이벤트 소스를 사용하는 기존 애플리케이션
{: #hybrid-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
여러 이벤트 소스를 사용하는 애플리케이션의 경우 등록을 기반으로 사용자를 세그먼트화해야 합니다.

##### 클라이언트
{: #client-hybrid-2 }
이는 관심 주제에 따라 사용자/디바이스를 세그먼트화하는 태그에 맵핑됩니다. 이를 마이그레이션하기 위해 이 모델을 태그 기반 알림으로 변환할 수 있습니다.

1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하고 성공 콜백에서 알림을 수신해야 할 콜백 메소드를 등록하십시오.

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 알림 콜백 메소드를 구현하십시오.

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. `WL.Client.Push.isPushSupported()`가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```

6. 등록할 이벤트 소스가 없으므로 다음 `WL.Client.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

7. 태그에 등록하십시오.

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. (선택사항) 태그에서 등록을 취소하십시오.

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### 서버
{: #server-hybrid-2 }
어댑터에서 다음 `WL.Server` API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

#### 시나리오 3: 애플리케이션에서 브로드캐스트/유니캐스트 알림을 사용하는 기존 애플리케이션
{: #hybrid-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 클라이언트
{: #client-hybrid-3 }
1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하고 성공 콜백에서 알림을 수신해야 할 콜백 메소드를 등록하십시오.

   ```javascript
   MFPPush.initialize(function(successResponse){
        MFPPush.registerNotificationsCallback(notificationReceived);              					},
        function(failureResponse){
            alert("Failed to initialize");
        }
   );
   ```

2. 알림 콜백 메소드를 구현하십시오.

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
        alert("Successfully registered");
        },
      function(failureResponse) {
        alert("Failed to register");
        }
   );
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
        alert("Successfully unregistered");
        },
      function(failureResponse) {
        alert("Failed to unregister");
        }
   );
   ```

5. WL.Client.Push.isPushSupported()가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
        alert(successResponse);
        },
      function(failureResponse) {
        alert("Failed to get the push suport status");
        }
   );
   ```

6. 다음 `WL.Client.Push` API를 제거하십시오.
    * `onReadyToSubscribe()`
    * `onMessage()`

##### 서버
{: #server-hybrid-3 }
어댑터에서 `WL.Server.sendMessage()`가 사용된 경우 이를 제거하십시오.  
동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

#### 시나리오 4: 애플리케이션에서 태그 알림을 사용하는 기존 애플리케이션
{: #hybrid-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 클라이언트
{: #client-hybrid-4 }
1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하고 성공 콜백에서 알림을 수신해야 할 콜백 메소드를 등록하십시오.

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					},
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. 알림 콜백 메소드를 구현하십시오.

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```

5. `WL.Client.Push.isPushSupported()`가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```

6. 다음 `WL.Client.Push` API를 제거하십시오.
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `onReadyToSubscribe()`
    * `onMessage()`

7. 태그에 등록하십시오.

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
		alert("Successfully subscribed");
	    },
	  function(failureResponse) {
		alert("Failed to subscribe");
	    }
   );
   ```

8. (선택사항) 태그에서 등록을 취소하십시오.

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### 서버
{: #server-hybrid-4 }
어댑터에서 `WL.Server.sendMessage()`가 사용된 경우 이를 제거하십시오.  
동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

### 네이티브 Android 애플리케이션
{: #native-android-applications }
이 마이그레이션 시나리오의 예제는 하나의 이벤트 소스 또는 여러 소스, 브로드캐스트 또는 유니캐스트 알림, 또는 태그 알림을 사용하는 애플리케이션을 다룹니다.

#### 시나리오 1: 애플리케이션에서 단일 이벤트 소스를 사용하는 기존 애플리케이션
{: #android-scenario-1-existing-applications-using-single-event-source-in-their-application }
이전 버전의 MobileFirst에서는 이벤트 소스 기반 모델을 통해서만 푸시를 지원했으므로 애플리케이션은 해당 버전에서 단일 이벤트 소스를 사용했습니다.

##### 클라이언트
{: #client-android-1 }
v8.0에서 마이그레이션하려면 이 모델을 Unicast 알림으로 변환하십시오.

1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하십시오.

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. MFPPushNotificationListener 인터페이스를 구현하고 onReceive()를 정의하십시오.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `push.isPushSupported();`를 사용하십시오.
6. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

##### 서버
{: #server-android-1 }
어댑터에서 다음 `WL.Server` API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

#### 시나리오 2: 애플리케이션에서 여러 이벤트 소스를 사용하는 기존 애플리케이션
{: #android-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
여러 이벤트 소스를 사용하는 애플리케이션의 경우 등록을 기반으로 사용자를 세그먼트화해야 합니다.

##### 클라이언트
{: #client-android-2 }
이는 관심 주제에 따라 사용자/디바이스를 세그먼트화하는 태그에 맵핑됩니다. {{ site.data.keys.product }} V8.0.0에서 마이그레이션하려면 이 모델을 태그 기반 알림으로 변환하십시오.

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```

2. MFPPushNotificationListener 인터페이스를 구현하고 onReceive()를 정의하십시오.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){   
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){   
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `push.isPushSupported();`를 사용하십시오.
6. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`

7. `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현
8. 태그에 등록하십시오.

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

9. (선택사항) 태그에서 등록을 취소하십시오.

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### 서버
{: #server-android-2 }
어댑터에서 다음 `WL.Server` API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.     

#### 시나리오 3: 애플리케이션에서 브로드캐스트/유니캐스트 알림을 사용하는 기존 애플리케이션
{: #android-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 클라이언트
{: #client-android-3 }

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```

2. `MFPPushNotificationListener` 인터페이스를 구현하고 `onReceive()`를 정의하십시오.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `push.isPushSupported();`를 사용하십시오.
6. 다음 WLClient.Push API를 제거하십시오.
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

##### 서버
{: #server-android-3 }
어댑터에서 WL.Server.sendMessage() API가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.    

#### 시나리오 4: 애플리케이션에서 태그 알림을 사용하는 기존 애플리케이션
{: #android-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 클라이언트
{: #client-android-4 }

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```

2. MFPPushNotificationListener 인터페이스를 구현하고 onReceive()를 정의하십시오.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `push.isPushSupported()`를 사용하십시오.
6. 다음 `WLClient.Push` API를 제거하십시오.
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

7. 태그에 등록하십시오.

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

8. (선택사항) 태그에서 등록을 취소하십시오.

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### 서버
{: #server-android-4 }
어댑터에서 `WL.Server.sendMessage()`가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

### 네이티브 iOS 애플리케이션
{: #native-ios-applications }
이 마이그레이션 시나리오의 예제는 하나의 이벤트 소스 또는 여러 소스, 브로드캐스트 또는 유니캐스트 알림, 또는 태그 알림을 사용하는 애플리케이션을 다룹니다.

#### 시나리오 1: 애플리케이션에서 단일 이벤트 소스를 사용하는 기존 애플리케이션
{: #ios-scenario-1-existing-applications-using-single-event-source-in-their-application }
이전 버전의 {{ site.data.keys.product_adj }}에서는 이벤트 소스 기반 모델을 통해서만 푸시를 지원했으므로 애플리케이션은 해당 버전에서 단일 이벤트 소스를 사용했습니다.

##### 클라이언트
{: #client-ios-1 }
v8.0에서 마이그레이션하려면 이 모델을 Unicast 알림으로 변환하십시오.

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. `didReceiveRemoteNotification()`에서 알림 처리를 구현하십시오.
3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
    	   NSLog(@"Failed to register");
        } else {
            NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        } else {
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 구현

7. `didRegisterForRemoteNotificationsWithDeviceToken`에서 `sendDeviceToken()`을 호출하십시오.

   ```objc
   [[MFPPush sharedInstance] sendDeviceToken:deviceToken];
   ```

##### 서버
{: #server-ios-1 }
어댑터에서 다음 WL.Server API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.

#### 시나리오 2: 애플리케이션에서 여러 이벤트 소스를 사용하는 기존 애플리케이션
{: #ios-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
여러 이벤트 소스를 사용하는 애플리케이션의 경우 등록을 기반으로 사용자를 세그먼트화해야 합니다.

##### 클라이언트
{: #client-ios-2}
이는 관심 주제에 따라 사용자/디바이스를 세그먼트화하는 태그에 맵핑됩니다. {{ site.data.keys.product_adj }} V8.0.0으로 마이그레이션하려면 이 모델을 태그 기반 알림으로 변환하십시오.

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. `didReceiveRemoteNotification()`에서 알림 처리를 구현하십시오.
3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 구현

7. `didRegisterForRemoteNotificationsWithDeviceToken`에서 `sendDeviceToken()`을 호출하십시오.
8. 태그에 등록하십시오.

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

9. (선택사항) 태그에서 등록을 취소하십시오.

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### 서버
:{: #server-ios-2 }
어댑터에서 `WL.Server`가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.    

#### 시나리오 3: 애플리케이션에서 브로드캐스트/유니캐스트 알림을 사용하는 기존 애플리케이션
{: #ios-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### 클라이언트
{: #client-ios-3 }
1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하십시오.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. `didReceiveRemoteNotification()`에서 알림 처리를 구현하십시오.
3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 다음을 사용하십시오.

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. 다음 `WLClient.Push` API를 제거하십시오.
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 구현

##### 서버
{: #server-ios-3 }
어댑터에서 `WL.Server.sendMessage`가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.  

#### 시나리오 4: 애플리케이션에서 태그 알림을 사용하는 기존 애플리케이션
{: #ios-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 클라이언트
{: #client-ios-4 }

1. 애플리케이션에서 MFPPush 클라이언트 인스턴스를 초기화하십시오.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. `didReceiveRemoteNotification()`에서 알림 처리를 구현하십시오.
3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```

5. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `[[MFPPush sharedInstance] isPushSupported]`를 사용하십시오.
6. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 구현

7. `didRegisterForRemoteNotificationsWithDeviceToken`에서 `sendDeviceToken()`을 호출하십시오.
8. 태그에 등록하십시오.

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{    
	       NSLog(@"Successfully unregistered");
       }
   }];
   ```

9. (선택사항) 태그에서 등록을 취소하십시오.

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### 서버
{: server-ios-4 }
어댑터에서 `WL.Server.sendMessage`가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}을 사용하여 신임 정보를 설정하십시오. [푸시 알림 설정 구성](../../notifications/sending-notifications)을 참조하십시오.

    또한 Android 애플리케이션에 대해서는 [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API를 사용하고 iOS 애플리케이션에 대해서는 [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API를 사용하여 신임 정보를 설정할 수도 있습니다.
2. **범위 요소 맵핑**에 `push.mobileclient` 범위를 추가하십시오.
3. 등록자에게 푸시 알림이 전송될 수 있도록 태그를 작성하십시오. 푸시 알림에 대해서는 [태그 정의](../../notifications/sending-notifications/#defining-tags)를 참조하십시오.
4. 다음 방법 중 하나를 사용하여 알림을 전송할 수 있습니다.
    * {{ site.data.keys.mf_console }}. [등록자에게 푸시 알림 전송](../../notifications/sending-notifications/#sending-notifications)을 참조하십시오.
    * [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`.  

### 네이티브 Windows Universal 애플리케이션
{: #native-windows-universal-applications }
이 마이그레이션 시나리오의 예제는 하나의 이벤트 소스 또는 여러 소스, 브로드캐스트 또는 유니캐스트 알림, 또는 태그 알림을 사용하는 애플리케이션을 다룹니다.

#### 시나리오 1: 애플리케이션에서 단일 이벤트 소스를 사용하는 기존 애플리케이션
{: #windows-scenario-1-existing-applications-using-single-event-source-in-their-application }
v8.0에서 마이그레이션하려면 이 모델을 Unicast 알림으로 변환하십시오.

##### 클라이언트
{: #windows-client-1}

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.IsPushSupported()`가 사용된 경우 이를 제거하고 `push.IsPushSupported();`를 사용하십시오.
5. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

##### 서버
{: #windows-server-1 }
어댑터에서 다음 `WL.Server` API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}의 **푸시 설정** 페이지에서 WNS 신임 정보를 설정하거나 WNS 설정 REST API를 사용하십시오.
2. {{ site.data.keys.mf_console }}의 보안 탭에서 **보안 검사에 범위 요소 맵핑** 섹션에 `push.mobileclient` 범위를 추가하십시오.
3. [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`를 사용하여 메시지를 보낼 수도 있습니다.

#### 시나리오 2: 애플리케이션에서 여러 이벤트 소스를 사용하는 기존 애플리케이션
{: #windows-scenario-2-existing-applications-using-multiple-event-sources-in-their-appliction }
여러 이벤트 소스를 사용하는 애플리케이션의 경우 등록을 기반으로 사용자를 세그먼트화해야 합니다.

##### 클라이언트
{: #windows-client-2 }
이는 관심 주제에 따라 사용자/디바이스를 세그먼트화하는 태그에 맵핑됩니다. {{ site.data.keys.product_adj }} V8.0.0에서 마이그레이션하려면 이 모델을 태그 기반 알림으로 변환하십시오.

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. IMFPUSH 서비스에 모바일 디바이스를 등록하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (선택사항) IMFPUSH 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.IsPushSupported()`가 사용된 경우 이를 제거하고 `push.IsPushSupported();`를 사용하십시오.
5. 등록할 이벤트 소스가 없으므로 다음 `WLClient.Push` API를 제거하고 알림 콜백을 등록하십시오.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

6. 태그에 등록하십시오.

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

7. (선택사항) 태그에서 등록을 취소하십시오.

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### 서버
{: #windows-server-2 }
어댑터에서 다음 `WL.Server` API가 사용된 경우 이를 제거하십시오.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}의 **푸시 설정** 페이지에서 WNS 신임 정보를 설정하거나 WNS 설정 REST API를 사용하십시오.
2. {{ site.data.keys.mf_console }}의 **보안** 탭에서 **보안 검사에 범위 요소 맵핑** 섹션에 `push.mobileclient` 범위를 추가하십시오.
3. {{ site.data.keys.mf_console }}의 **태그** 페이지에서 Push 태그를 작성하십시오.
4. [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`/`tagNames`를 대상으로 사용하여 메시지를 보낼 수도 있습니다.

#### 시나리오 3: 애플리케이션에서 브로드캐스트/유니캐스트 알림을 사용하는 기존 애플리케이션
{: #windows-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }

##### 클라이언트
{:# windows-client-3 }
1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. `WLClient.Push.isPushSupported()`가 사용된 경우 이를 제거하고 `push.IsPushSupported();`를 사용하십시오.
5. 다음 `WLClient.Push` API를 제거하십시오.
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

##### 서버
{: #windows-server-3 }
어댑터에서 `WL.Server.sendMessage()`가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}의 **푸시 설정** 페이지에서 WNS 신임 정보를 설정하거나 WNS 설정 REST API를 사용하십시오.
2. {{ site.data.keys.mf_console }}의 **보안** 탭에서 **보안 검사에 범위 요소 맵핑** 섹션에 `push.mobileclient` 범위를 추가하십시오.
3. {{ site.data.keys.mf_console }}의 **태그** 페이지에서 Push 태그를 작성하십시오.
4. [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`/`tagNames`를 대상으로 사용하여 메시지를 보낼 수도 있습니다.

#### 시나리오 4: 애플리케이션에서 태그 알림을 사용하는 기존 애플리케이션
{: #windows-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### 클라이언트
{: #windows-client-4 }

1. 애플리케이션에서 `MFPPush` 클라이언트 인스턴스를 초기화하십시오.

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   ```

2. MFPPushNotificationListener 인터페이스를 구현하고 onReceive()를 정의하십시오.

   ```csharp
class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        {
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

3. 푸시 알림 서비스에 모바일 디바이스를 등록하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

4. (선택사항) 푸시 알림 서비스에서 모바일 디바이스의 등록을 취소하십시오.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

5. `WLClient.Push.IsPushSupported()`가 사용된 경우 이를 제거하고 `push.IsPushSupported()`를 사용하십시오.
6. 다음 `WLClient.Push` API를 제거하십시오.
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` 및 `WLNotificationListener` 구현

7. 태그에 등록하십시오.

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```

8. (선택사항) 태그에서 등록을 취소하십시오.

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```

##### 서버
{: #windows-server-4 }
어댑터에서 `WL.Server.sendMessage()`가 사용된 경우 이를 제거하십시오.

동일한 이벤트 소스를 사용한 모든 애플리케이션에 대해 다음 단계를 완료하십시오.

1. {{ site.data.keys.mf_console }}의 **푸시 설정** 페이지에서 WNS 신임 정보를 설정하거나 WNS 설정 REST API를 사용하십시오.
2. {{ site.data.keys.mf_console }}의 **보안** 탭에서 **보안 검사에 범위 요소 맵핑** 섹션에 `push.mobileclient` 범위를 추가하십시오.
3. {{ site.data.keys.mf_console }}의 **태그** 페이지에서 Push 태그를 작성하십시오.
4. [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API와 `userId`/`deviceId`/`tagNames`를 대상으로 사용하여 메시지를 보낼 수도 있습니다.

## 마이그레이션 도구
{: #migration-tool }
마이그레이션 도구는 MobileFirst Platform Foundation 7.1 푸시 데이터(디바이스, 사용자 등록, 신임 정보 및 태그)를 {{ site.data.keys.product }} 8.0으로 마이그레이션하는 데 도움이 됩니다.  
마이그레이션 도구를 사용하면 다음 기능을 간단하게 처리할 수 있습니다.

1. MobileFirst Platform Foundation 7.1 데이터베이스에서 각 애플리케이션의 디바이스, 신임 정보, 태그 및 사용자 등록을 읽습니다.
2. 각 애플리케이션에 대해 {{ site.data.keys.product }} 8.0 데이터베이스의 각 테이블로 데이터를 복사합니다.
3. v8.0 애플리케이션의 환경에 관계 없이 모든 v7.1 환경의 모든 푸시 데이터를 마이그레이션합니다.

마이그레이션 도구는 사용자 등록, 애플리케이션 환경 또는 디바이스와 관련된 데이터를 수정하지 않습니다.  

마이그레이션 도구를 사용하기 전에 다음 정보를 파악하는 것이 중요합니다.

1. Java 버전 1.6 이상이 있어야 합니다.
2. MobileFirst Server 7.1과 {{ site.data.keys.mf_server }} 8.0이 둘 다 설치되고 준비되어 있는지 확인하십시오.
3. MobileFirst Server 7.1과 {{ site.data.keys.mf_server }} 8.0을 둘 다 백업하십시오.
4. {{ site.data.keys.mf_server }} 8.0에서 애플리케이션의 최신 버전을 등록하십시오.
	* 애플리케이션의 표시 이름은 MobileFirst Platform Foundation 7.1에서 각 애플리케이션과 일치해야 합니다.
	* PacakgeName/BundleID를 기억하고 애플리케이션에 동일한 값을 제공하십시오.
	* 애플리케이션이 {{ site.data.keys.mf_server }} 8.0에 등록되지 않은 경우 마이그레이션이 실패합니다.
5. 애플리케이션의 각 환경에 범위 요소 맵핑을 제공하십시오. [범위 맵핑에 대해 자세히 학습](../../notifications/sending-notifications/#scope-mapping)하십시오.

#### 프로시저
{: #procedure }
1. [다음 GitHub 저장소](https://github.com/mfpdev/push-migration-tool)에서 마이그레이션 도구를 다운로드하십시오.
2. 도구를 다운로드한 후 **migration.properties** 파일에서 다음 세부사항을 제공하십시오.

    |값                |설명  |샘플 값 |
    |----------------------|--------------|---------------|
    |w.db.type		       |고려 중인 데이터베이스의 유형	           |pw.db.type = db2 possible values DB2,Oracle,MySql,Derby |
    |pw.db.url			   |MobileFirst Platform Foundation 7.1 worklight DB URL  |jdbc:mysql://localhost:3306/WRKLGHT |
    |pw.db.adminurl	   |MobileFirst Platform Foundation 7.1 Admin DB URL      |jdbc:mysql://localhost:3306/ADMIN |
    |pw.db.username	   |MobileFirst Platform Foundation 7.1 Worklight DB 사용자 이름 |pw.db.username=root |
    |pw.db.password	   |MobileFirst Platform Foundation 7.1 Worklight DB 비밀번호 |pw.db.password=root |
    |pw.db.adminusername  |MobileFirst Platform Foundation 7.1 Admin DB 사용자 이름     |pw.db.adminusername=root |
    |pw.db.adminpassword  |MobileFirst Platform Foundation 7.1 Admin DB 비밀번호     |pw.db.adminpassword=root |
    |pw.db.urlTarget	   |MFP 8.0 DB URL						        |jdbc:mysql://localhost:3306/MFPDATA |
    |pw.db.usernameTarget |MFP 8.0 DB 사용자 이름						|pw.db.usernameTarget=root |
    |pw.db.passwordTarget |MFP 8.0 DB 비밀번호						|pw.db.passwordTarget=root |
    |pw.db.schema         |MobileFirst Platform Foundation 7.1 Worklight DB 스키마 |WRKLGT |
    |pw.db.adminschema    |MobileFirst Platform Foundation 7.1 Admin DB 스키마     |WLADMIN |
    |pw.db.targetschema   |{{ site.data.keys.product }} 8.0 worklight DB 스키마    |MFPDATA |
    |runtime			   |MobileFirst Platform Foundation 7.1 Runtime 이름		 |runtime=worklight |
    |applicationId	       |MobileFirst Platform Foundation 7.1에 등록된 애플리케이션의 쉼표(,)로 구분된 목록을 제공하십시오. |HybridTestApp,NativeiOSTestApp |
    |targetApplicationId  |{{ site.data.keys.product }} 8.0에 등록된 애플리케이션의 쉼표(,)로 구분된 목록을 제공하십시오.   |com.HybridTestApp,com.NativeiOSTestApp |

    * 적절한 순서로 **applicationID** 및 **targetApplicationId**의 값을 둘 다 제공했는지 확인하십시오. 맵핑은 일대일(또는 N대N) 방식으로 수행됩니다. 즉, **applicationId** 목록에서 첫 번째 애플리케이션의 데이터는 **targetApplicationId** 목록의 첫 번째 애플리케이션으로 마이그레이션됩니다.
	* **targetApplicationId** 목록에서 애플리케이션에 대해 packageName/BundleId를 제공하십시오. 즉, MobileFirst Platform Foundation 7.1에 있는 TestApp1의 경우 **targetApplicationId**는 com.TestApp1인 TestApp1의 packageName/BundleId가 됩니다. MobileFirst Platform Foundation 7.1 **applicationId**는 애플리케이션 이름이며 {{ site.data.keys.mf_server }} 8.0에서는 애플리케이션 환경 기반의 packageName/BundleId/packageIdentityName이기 때문입니다.

2. 다음 명령을 사용하여 도구를 실행하십시오.

   ```bash
   java -jar mfp-push-data-migration.jar path-to-migration.properties
   ```

   * 도구 .jar 파일 및 properties 파일이 다른 위치에 있는 경우 **path-to-migration.properties**를 **migration.properties**의 경로로 대체하십시오. 그렇지 않으면 명령에서 해당 경로를 제거하십시오.
   
    도구 .jar 파일과 동일한 위치의 필수 라이브러리가 포함된 라이브러리 폴더를 유지하십시오.
