---
layout: tutorial
title: 라이브 업데이트 서비스
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.product }}의 라이브 업데이트 기능을 사용하여 애플리케이션 사용자에 대한 서로 다른 구성을 간단하게 정의하고 제공할 수 있습니다. 해당 {{ site.data.keys.mf_console }}에는 구성의 값 및 해당 구성의 구조를 정의하는 데 필요한 컴포넌트가 포함되어 있습니다. 구성을 이용하는 데 필요한 클라이언트 SDK(Android 및 iOS **네이티브** 애플리케이션 및 Cordova 애플리케이션에 사용 가능)도 제공됩니다.

>**참고**: 기존 온프레미스 {{ site.data.keys.mf_server }}가 포함된 라이브 업데이트를 사용하는 데 관한 세부사항은 [여기](live-update/)의 문서를 참조하십시오. 


### 공통 유스 케이스
{: #common-use-cases }
라이브 업데이트는 구성의 정의 및 이용을 지원하여 애플리케이션에 대해 사용자 정의를 쉽게 작성할 수 있도록 합니다. 공통 유스 케이스의 예제는 다음과 같습니다. 

* 릴리스 트레인 및 기능 플립핑

향후 릴리스에서 다음 유스 케이스가 지원됩니다. 

* A/B 테스트
* 컨텍스트 기반 애플리케이션 사용자 정의(예: 지리적 세그먼트화)

### 다음으로 이동:
{: #jump-to }
* [개념](#concept)
* [라이브 업데이트 아키텍처](#live-update-architecture)
* [{{ site.data.keys.mf_server }}에 라이브 업데이트 추가](#adding-live-update-to-mobilefirst-server)
* [애플리케이션 보안 구성](#configuring-application-security)
* [애플리케이션에 라이브 업데이트 SDK 추가](#adding-live-update-sdk-to-applications)
* [라이브 업데이트 SDK 사용](#using-the-live-update-sdk)
* [고급 주제](#advanced-topics)

## 개념
{: #concept }

라이브 업데이트 서비스는 다음 기능을 각 애플리케이션에 추가합니다. 

1. **기능** - 기능을 사용하면 구성 가능한 애플리케이션 기능을 정의하고 해당 기본값을 설정할 수 있습니다. 
2. **특성** - 특성을 사용하면 구성 가능한 애플리케이션 특성을 정의하고 해당 기본값을 설정할 수 있습니다. 

개발자나 애플리케이션 관리 팀은 다음 사항을 결정해야 합니다. 
* 라이브 업데이트를 사용할 수 있는 기능과 해당 기본 상태 세트. 
* 구성 가능한 문자열 특성과 해당 기본값 세트. 

매개변수를 결정하면 라이브 업데이트 섹션을 통해 앱에 기능과 특성을 추가합니다. 

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="schema">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSchema" aria-expanded="false" aria-controls="collapseSchema">용어를 검토하려면 클릭</a>하십시오.
            </h4>
        </div>

        <div id="collapseSchema" class="panel-collapse collapse" role="tabpanel" aria-labelledby="schema">
            <div class="panel-body">
                <ul>
                    <li><b>기능:</b> 기능은 애플리케이션 기능의 일부 파트가 사용되는지, 또는 사용되지 않는지 여부를 판별합니다. 애플리케이션의 기능을 정의할 때 다음 요소를 제공해야 합니다.
                        <ul>
                            <li><i>ID</i> - 기능의 고유 ID입니다. 문자열이며 편집할 수 없습니다.</li>
                            <li><i>이름</i> - 기능의 구체적인 이름입니다. 문자열이며 편집 가능합니다.</li>
                            <li><i>설명</i> - 기능에 대한 간략한 설명입니다. 문자열이며 편집 가능합니다.</li>
                            <li><i>기본값</i> - 세그먼트 내에서 대체되지 않은 경우 제공되는 기능의 기본값입니다(아래의 세그먼트 참조). 부울이며 편집 가능합니다.</li>
                        </ul>
                    </li>
                    <li><b>특성:</b> 특성은 애플리케이션을 사용자 정의할 때 사용할 수 있는 키:값 엔티티입니다. 특성을 정의할 때 다음 요소를 제공해야 합니다.
                        <ul>
                            <li><i>ID</i> - 특성의 고유 ID입니다. 문자열이며 편집할 수 없습니다.</li>
                            <li><i>이름</i> - 특성의 구체적인 이름입니다. 문자열이며 편집 가능합니다.</li>
                            <li><i>설명</i> - 특성에 대한 간략한 설명입니다. 문자열이며 편집 가능합니다.</li>
                            <li><i>기본값</i> - 세그먼트 내에서 대체되지 않은 경우 제공되는 특성의 기본값입니다(아래의 세그먼트 참조). 문자열이며 편집 가능합니다.</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>


## 라이브 업데이트 아키텍처
{: #live-update-architecture }
다음 시스템 컴포넌트가 함께 작동하여 라이브 업데이트 기능을 제공합니다.

![아키텍처 개요](LU-arch.png)

* **라이브 업데이트 서비스:** 다음 사항을 제공하는 독립 서비스입니다.
   - 애플리케이션 관리
   - 애플리케이션에 구성 제공
* **클라이언트 측 SDK:** 라이브 업데이트 SDK는 {{ site.data.keys.mf_server }}의 구성요소(예: 기능 및 특성)를 검색하고 액세스하는 데 사용됩니다.
* **{{ site.data.keys.mf_console }}:** 라이브 업데이트 어댑터 및 설정을 구성하는 데 사용됩니다.

## {{ site.data.keys.mf_server }}에 라이브 업데이트 추가
{: #adding-live-update-to-mobilefirst-server }
기본적으로, 라이브 업데이트 서비스는 Mobile Foundation DevKit에 번들로 제공됩니다. 

> OpenShift Container Platform(OCP) 설치 시 [여기](../../ibmcloud/mobilefoundation-on-openshift/)의 문서를 따르십시오.  

라이브 업데이트 서비스가 실행되면 등록된 각 애플리케이션에 대한 **라이브 업데이트 설정** 페이지가 표시됩니다.

## 애플리케이션 보안 구성
{: #configuring-application-security }
라이브 업데이트와 통합을 허용하려면 범위 요소가 필요합니다. 범위 요소가 없으면 서비스에서 클라이언트 애플리케이션의 요청을 거부합니다.   

1. {{ site.data.keys.mf_console }}을 로드하십시오.
2. **[애플리케이션] → 보안 탭 → 범위 요소 맵핑**을 클릭합니다.
3. **새로 작성**을 클릭하고 범위 요소 `liveupdate.mobileclient`를 입력하십시오. 
4. **추가**를 클릭하십시오.

또한 애플리케이션에서 보안 검사를 사용 중인 경우 해당 보안 검사에 범위 요소를 맵핑할 수도 있습니다.

> [{{ site.data.keys.product_adj }} 보안 프레임워크에 대해 자세히 알아보십시오.](../../authentication-and-security/)

<img class="gifplayer" alt="범위 맵핑 추가" src="liveupdate-scopemapping.gif"/>
<br/>

## 값을 사용하여 스키마 및 특성 정의
{: #define-features-and-properties-with-values }

다음 데모를 참조하여 값으로 기능과 특성을 정의합니다. 

<img class="gifplayer" alt="기능 및 특성 추가" src="add-feature-property.png"/>

## 애플리케이션에 라이브 업데이트 SDK 추가
{: #adding-live-update-sdk-to-applications}
라이브 업데이트 SDK는 {{ site.data.keys.mf_console }}에 등록된 애플리케이션의 라이브 업데이트 설정 화면에서 이전에 정의된 런타임 구성 기능 및 특성을 조회하는 API를 개발자에게 제공합니다.

**Cordova**의 경우, SDK 버전 *8.0.202003051505* 또는 그 이전 버전을 사용합니다. 
* [Cordova 플러그인 문서](https://github.com/mfpdev/mfp-live-update-cordova-plugin)

**Android**의 경우, SDK 버전 *8.0.202003051505*를 사용합니다. 
* [Android SDK 문서](https://github.com/mfpdev/mfp-live-update-android-sdk)

**iOS**의 경우, SDK 버전 *8.0.202003051505* 또는 그 이전 버전을 사용합니다. 
* [iOS Swift SDK 문서](https://github.com/mfpdev/mfp-live-update-ios-sdk)

### Cordova 플러그인 추가
{: #adding-the-cordova-plugin }

Cordova 애플리케이션 폴더에서 다음 명령을 실행하십시오.

```bash
cordova plugin add cordova-plugin-mfp-liveupdate
```

### iOS SDK 추가
{: #adding-the-ios-sdk }
1. `IBMMobileFirstPlatformFoundationLiveUpdate` 팟(Pod)을 추가하여 애플리케이션의 Podfile을 편집하십시오.  
 예:

   ```xml
   use_frameworks!

   target 'your-Xcode-project-target' do
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationLiveUpdate'
   end
   ```

2. **명령행** 창에서 Xcode 프로젝트의 루트 폴더로 이동하여 다음 명령을 실행하십시오. 
  ```bash
  pod install
  ```

### Android SDK 추가
{: #adding-the-android-sdk }
1. Android Studio에서 **Android → Gradle 스크립트**를 선택한 후 **build.gradle(모듈: 앱)** 파일을 선택하십시오.
2. `dependencies` 내에 `ibmmobilefirstplatformfoundationliveupdate`를 다음과 같이 추가하십시오.

   ```xml
   dependencies {
        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundation',
        version: '8.0.+',
        ext: 'aar',
        transitive: true

        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundationliveupdate',
        version: '8.0.0',
        ext: 'aar',
        transitive: true
   }   
   ```

## 라이브 업데이트 SDK 사용
{: #using-the-live-update-sdk }
여러 가지 방식으로 라이브 업데이트를 사용할 수 있습니다.

### 구성 가져오기
{: #obtain-config }
구성을 검색하는 로직을 구현하십시오.  
`property-name`과 `feature-name`을 사용자 값으로 대체하십시오. 

#### Cordova
{: #cordova }
```javascript
    var input = { };
    LiveUpdateManager.obtainConfiguration({useClientCache :false },function(configuration) {
        // do something with configration (JSON) object, for example,
        // if you defined in the server a feature named 'feature-name':
        // if (configuration.features.feature-name) {
        //   console.log(configuration.properties.property-name);
	// }
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });

```

#### iOS
{: #ios }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})

```

#### Android
{: #android }
```java
LiveUpdateManager.getInstance().obtainConfiguration(new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});

```

라이브 업데이트 구성이 검색된 경우 애플리케이션 로직 및 애플리케이션 플로우는 기능과 특성 상태에 따라 다를 수 있습니다. 예를 들어 오늘이 국경일인 경우 애플리케이션에 새 마케팅 프로모션을 도입하십시오.

## 고급 주제
{: #advanced-topics }

### 캐싱
{: #caching }
캐싱은 기본적으로 사용되어 네트워크 대기 시간이 발생하지 않도록 합니다. 즉 업데이트가 즉시 수행되지 않을 수 있습니다.  
자주 업데이트해야 하는 경우 캐싱을 사용 안함으로 설정할 수 있습니다.

#### Cordova
{: #cordova-caching }
선택적 _useClientCache_ 부울 플래그를 사용하여 클라이언트 측 캐시 제어: 

```javascript
var input = {useClientCache : false };
      LiveUpdateManager.getConfiguration(input,function(configuration) {
              // do something with resulting configuration, for example:
                // console.log(configuration.data.properties.property-name);  
                // console.log(configuration.data.features.feature-name);
        } ,
        function(err) {
              if (err) {
                 alert('liveupdate error:'+err);
                }
});

```

#### iOS
{: #ios-caching }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(useCache: false, completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})

```

#### Android
{: #android-caching }
```java
LiveUpdateManager.getInstance().obtainConfiguration(false, new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
      Log.i("LiveUpdateSample", configuration.getProperty("property-name"));
      Log.i("LiveUpdateSample", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateSample", wlFailResponse.getErrorMsg());
    }
});

```

### 캐시 만기
{: #cache-expiration }
`expirationPeriod` 값은 30분이며 이는 캐싱이 만료될 때까지의 기간입니다. 
