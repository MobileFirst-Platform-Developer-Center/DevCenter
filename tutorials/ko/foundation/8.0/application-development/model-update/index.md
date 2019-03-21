---
layout: tutorial
title: 애플리케이션에서 모델 업데이트 사용
breadcrumb_title: Model Update
relevantTo: [iOS]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
CoreML 및 TensorFlow Lite와 같은 온디바이스 기계 학습(ML)의 도입으로 모바일 앱은 이제 디바이스가 오프라인 상태인 경우에도 디바이스에서 ML 오퍼레이션(예: 이미지 인식, 음성-문자 변환)을 수행할 수 있습니다. 기계 학습 모델의 중요한 특성은 계속해서 진화한다는 것입니다. 디바이스에서 이 모델을 최신 버전으로 업데이트하는 것은 모바일 앱의 성공을 위해 매우 중요합니다. 

이 요구사항에 맞추어 IBM Mobile Foundation에 모델 업데이트 기능이 도입되었습니다. Mobile Foundation 애플리케이션은 이제 ML 모델을 임베드할 수 있으며 "방송을 통해" 새 버전으로 업데이트될 수 있습니다. 그러므로 조직은 일반 사용자가 항상 업데이트된 AI 모델을 사용하는지 확인할 수 있습니다.

모델 버전을 애플리케이션에 전송하려면 최신 모델을 zip 형식으로 압축하십시오. 이 `.zip`은 MobileFirst 오퍼레이션 콘솔의 **기계 학습** 탭에서 업로드될 수 있습니다. 그러면 모델 업데이트는 애플리케이션이 `downloadModelUpdate` API를 호출할 때마다 활성화됩니다. 

>**지원되는 플랫폼:** 현재 모델 업데이트는 iOS에만 지원됩니다.  

### 중요 사항
{: #notes }
* 모델 업데이트는 Apple의 CoreML Model 또는 Google의 TensorFlow Model과 같이 인공 지능(AI) 모델만 업데이트합니다.

#### 다음으로 이동:
{: #jump-to}

- [모델 업데이트의 작업 방식](#how-model-update-works)
- [모델 패키지 작성 및 배치](#creating-and-deploying-model-packages)
- [업데이트 호출](#invoking-an-update)

## 모델 업데이트의 작업 방식
{: #how-model-update-works }
모델은 오프라인에서 우선 사용할 수 있도록 초기에 애플리케이션과 함께 패키지되어 있습니다. 그런 다음 애플리케이션은 `downloadModelUpdate` API가 호출될 때마다 {{ site.data.keys.mf_server }}에 대한 업데이트 항목이 있는지 확인합니다.

모델 업데이트 후 `downloadModelUpdate` API는 다운로드된 모델의 위치를 리턴하고 이 위치는 업데이트가 수행될 때마다 업데이트됩니다. 

### 버전화
{: #versioning }
모델 업데이트는 특정 애플리케이션 버전에만 적용됩니다. 즉 특정 애플리케이션 버전 2.0에 대해 생성된 업데이트를 동일한 애플리케이션의 다른 버전에 적용할 수 없습니다.

## 모델 패키지 작성 및 배치
{: #creating-and-deploying-model-packages }
모델의 최신 버전 또는 업데이트 버전이 사용 가능한 경우 모델 파일을 {{ site.data.keys.mf_server }}에 업로드하려면 다음 단계를 따르십시오.

### 단계:

 1. 하나 이상의 기계 학습 모델 파일(예: `.mlmodel`)의 `.zip` 아카이브를 작성하십시오. 
 2. {{ site.data.keys.mf_console }}을 열고 왼쪽 패널의 애플리케이션 항목을 클릭하십시오. 
 3. **기계 학습** 탭으로 이동하고 **모델 아카이브 업로드**를 클릭하여 패키지된 모델을 업로드하십시오. 

## 업데이트 호출
{: #invoking-an-update }
애플리케이션의 모델 업데이트는 다음 API를 호출하여 확인할 수 있습니다. 

### iOS

```
 WLClient.sharedInstance().downloadModelUpdate(completionHandler: CompletionHandler, showProgressBar: Boolean);
```

>**참고:** 이 API는 `ObtainAccessToken` 또는 `WLResourceRequest` API를 사용하여 동시에 호출될 수 없습니다. 

일반적으로 애플리케이션 개발자는 애플리케이션 시작 중에 이 API를 호출해야 합니다. 

다운로드에 성공하거나 이전에 다운로드된 패키지에 대한 경로가 리턴된 경우 `downloadModelUpdate` API는 다음 상태 코드 중 하나와 다운로드된 패키지에 대한 링크를 리턴합니다. 

마지막 상태는 다음 코드 중 하나입니다. 

| 상태 코드 |설명 |
|-------------|-------------|
| `SUCCESS` | 모델 업데이트가 오류 없이 완료되었습니다. |
| `CANCELED` | 모델 업데이트가 취소되었습니다. |
| `FAILURE_NETWORK_PROBLEM` | 업데이트 중에 네트워크 연결에 문제점이 발생했습니다. |
| `FAILURE_DOWNLOADING` | 파일이 완전히 다운로드되지 않았습니다. |
| `FAILURE_NOT_ENOUGH_SPACE` | 디바이스에 업데이트 파일을 다운로드하고 언팩할 공간이 충분하지 않습니다. |
| `FAILURE_UNZIPPING` | 업데이트 파일을 언팩하는 중에 문제점이 발생했습니다. |
| `FAILURE_ALREADY_IN_PROGRESS` | 업데이트를 이미 진행하는 중에 업데이트가 요청되었습니다. |
| `FAILURE_INTEGRITY` | 업데이트 파일의 신뢰성을 확인할 수 없습니다. |
| `FAILURE_UNKNOWN` | 예기치 않은 내부 오류가 발생했습니다. |


## 보안 모델 업데이트
{: #secure-model-update }
기본적으로 사용 안함으로 설정되는 보안 모델 업데이트를 사용하는 경우 써드파티 공격자가 {{ site.data.keys.mf_server }} 또는 CDN(Content Delivery Network)에서 클라이언트 애플리케이션으로 전송되는 모델을 변경하는 것을 방지합니다.

### 모델 업데이트 신뢰성을 사용으로 설정하려면 다음을 수행하십시오.
선호하는 도구를 사용하여 {{ site.data.keys.mf_server }} 키 저장소에서 공개 키를 추출하고 base64로 변환하십시오.  
이렇게 하여 생성되는 값은 다음과 같이 사용되어야 합니다.

1. 클라이언트 애플리케이션에서 mobilefirst 구성 파일(즉, iOS용 `mfpclient.plist` 및 Android용 `mfpclient.properties`)을 여십시오.
2. `wlSecureModelUpdatePublicKey`라고 하는 새 키 값을 추가하십시오.
3. 해당 키에 적합한 공개 키를 제공하고 저장하십시오. 

향후 클라이언트 애플리케이션에 대한 모델 업데이트 전달이 모델 업데이트 신뢰성에 의해 보호됩니다.

> 업데이트된 키 저장소 파일로 애플리케이션 서버를 구성하려면 [보안 모델 업데이트 구현](secure-model-update/)을 참조하십시오.

### 개발, 테스트 및 프로덕션에서 모델 업데이트
개발 및 테스트 용도의 경우 개발자는 일반적으로 단순히 개발 서버에 아카이브를 업로드하여 모델 업데이트를 사용합니다. 이 프로세스는 쉽게 구현할 수 있지만 모델이 전송 중에 또는 디바이스에 다운로드된 후에 변조될 수 있으므로 그다지 안전하지는 않습니다. 

프로덕션 또는 프리프로덕션 테스트 단계(Phase)의 경우에는 애플리케이션을 앱 스토어에 공개하기 전에 보안 모델 업데이트를 구현할 것을 적극 권장합니다. 보안 모델 업데이트를 사용하려면 CA 서명 서버 인증서에서 추출된 RSA 키 쌍이 필요합니다.

>**참고:** 애플리케이션이 공개된 후에 키 저장소 구성을 수정하지 않도록 주의하십시오. 새 공개 키로 애플리케이션을 재구성하고 애플리케이션을 다시 공개하지 않는 경우 다운로드된 업데이트는 더 이상 인증될 수 없습니다. 이 단계를 수행하지 않으면 클라이언트에서 모델 업데이트가 실패합니다.

> [보안 모델 업데이트](secure-model-update/)에서 자세히 알아보십시오.

### 모델 업데이트 데이터 전송률
최적의 조건에서 단일 {{ site.data.keys.mf_server }}는 초당 250MB의 속도로 데이터를 클라이언트에 푸시할 수 있습니다. 더 빠른 속도가 필요한 경우 클러스터 또는 CDN 서비스를 고려하십시오.
