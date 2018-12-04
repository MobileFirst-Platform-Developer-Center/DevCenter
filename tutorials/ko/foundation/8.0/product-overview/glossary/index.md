---
layout: tutorial
title: 용어집
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{ site.data.keys.mf_console }}" for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>
이 용어집에서는 {{ site.data.keys.product }} 소프트웨어 및 제품에 대한 용어 및 정의를 제공합니다.

이 용어집에서는 다음과 같은 상호 참조가 사용됩니다.

* **참조하십시오**는 비권장 용어를 권장 용어로 나타내거나 약어를 본딧말로 나타냅니다.
* **도 참조하십시오**는 관련된 용어 또는 대조되는 용어를 참조하라는 의미입니다.

기타 용어 및 정의에 대해서는 [IBM 용어 웹 사이트](http://www.ibm.com/software/globalization/terminology/)를 참조하십시오.


## 가
{: #가 }

### 개인 키(private key)
{: #private-key }
보안 통신에서 해당 공개 키만 복호화할 수 있는 메시지를 암호화하는 데 사용하는 알고리즘 패턴입니다. 또한 개인 키는 상응하는 공개 키로 암호화된 메시지를 복호화하는 데 사용됩니다. 개인 키는 사용자 시스템에서 유지되며 비밀번호로 보호됩니다. 키(key), 공개 키(public key)도 참조하십시오.

### 게이트웨이(gateway)
{: #gateway }
네트워크 또는 시스템을 다른 네트워크 아키텍처와 연결하는 데 사용되는 디바이스 또는 프로그램입니다.

### 공개 키(public key)
{: #public-key }
보안 통신에서, 해당 공개 키로 암호화된 메시지를 복호화하는 데 사용되는 알고리즘 패턴입니다. 또한 공개 키는 해당 개인 키로만 암호 해독할 수 있는 메시지를 암호화하는 데도 사용됩니다. 사용자는 암호화된 메시지를 교환해야 하는 모든 사용자에게 자신의 공개 키를 브로드캐스트합니다. 키(key), 개인 키(private key)도 참조하십시오.

### 관리 데이터베이스(administration database)
{: #administration-database }
{{ site.data.keys.mf_console }} 및 관리 서비스의 데이터베이스입니다. 데이터베이스 테이블은 요소(예: 애플리케이션, 어댑터 및 설명과 규모 순서가 있는 프로젝트)를 정의합니다.

### 관리 서비스(Administration Services)
{: #administration-services }
REST 서비스와 관리 태스크를 호스트하는 애플리케이션입니다. 관리 서비스 애플리케이션은 이 애플리케이션의 WAR 파일로 패키징됩니다.

### 구문(syntax)
{: #syntax }
명령 또는 명령문의 구성에 대한 규칙입니다.

## 나
{: #나 }


### 네이티브 앱(native app)
{: #native-app }
디바이스의 모바일 운영 체제에서 사용하도록 2진 코드로 컴파일되는 앱입니다.

### 노드(node)
{: #node }
관리 서버의 논리 그룹입니다.

## 다
{: #다 }


### 데이터 소스(data source)
{: #data-source }
애플리케이션이 데이터베이스에서 데이터에 액세스하는 데 사용하는 수단입니다.

### 동종 서버 팜(homogeneous server farm)
{: #homogeneous-server-farm }
모든 애플리케이션 서버가 동일한 유형, 레벨 및 버전인 서버 팜입니다.

### 등록(subscription)
{: #subscription }
등록자가 받아보려는 발행물에 대해 설명하기 위해 로컬 브로커 또는 서버에 전달하는 정보가 포함된 레코드입니다.

### 디바이스 등록(device enrollment)
{: #device-enrollment }
디바이스 소유자가 자체 디바이스를 "신뢰"로 등록하는 프로세스입니다.

### 디바이스 컨텍스트(device context)
{: #device-context }
디바이스의 위치를 식별하는 데 사용되는 데이터입니다. 이 데이터에는 지리적 좌표, WiFi 액세스 지점, 시간소인 세부사항이 포함될 수 있습니다. 트리거(trigger)도 참조하십시오.

### 디바이스(device)
{: #device }
[모바일 디바이스(mobile device)](#mobile-device)를 참조하십시오.


## 라
{: #라 }

### 라이브러리(library)
{: #library }
기타 오브젝트에 대해 디렉토리 역할을 하는 시스템 오브젝트입니다. 라이브러리는 관련 오브젝트들을 그룹화하므로 사용자는 이름으로 오브젝트를 찾을 수 있습니다.
비즈니스 항목, 프로세스, 태스크, 자원 및 조직을 포함한 모델 요소의 콜렉션입니다.

### 랩퍼(wrapper)
{: #wrapper }
컴파일러에서 해석할 수 없는 코드가 포함된 코드 섹션입니다. 랩퍼는 컴파일러와 랩핑된 코드 사이의 인터페이스 역할을 담당합니다.

### 로드 밸런싱(load balancing)
{: #load-balancing }
여러 컴퓨터나 컴퓨터 클러스터, 네트워크 링크, 중앙 처리 장치, 디스크 드라이브 또는 기타 자원에 워크로드를 분배하기 위한 컴퓨터 네트워킹 방법입니다. 로드 밸런싱이 성공적으로 이루어지면 자원 사용이 최적화되고, 처리량이 극대화되며, 응답 시간이 최소화되고, 과부하가 방지됩니다.

### 로컬 저장소(local store)
{: #local-store }
네트워크에 연결하지 않아도 애플리케이션이 데이터를 로컬로 저장하고 검색할 수 있는 디바이스의 영역입니다.

### 루트(root)
{: #root }
시스템에서 기타 모든 디렉토리가 포함된 디렉토리입니다.


## 마
{: #마 }

### 모바일 디바이스(mobile device)
{: #mobile-device }
라디오 네트워크에서 작동되는 전화, 태블릿 또는 개인용 디지털 보조장치입니다. Android도 참조하십시오.

### 모바일 클라이언트(mobile client)
{: #mobile-client }
[Application Center 설치 프로그램(Application Center installer)](#application-center-installer)을 참조하십시오.

### 모바일(mobile)
{: #mobile }
[모바일 디바이스(mobile device)](#mobile-device)를 참조하십시오.


## 바
{: #바 }

### 배치(deployment)
{: #deployment }
소프트웨어 애플리케이션 및 그의 모든 구성요소를 설치 및 구성하는 프로세스입니다.

### 별명(alias)
{: #alias }
두 개의 데이터 엔티티 간 또는 데이터 엔티티와 포인터 간 가정 또는 실제 연관입니다.

### 보기(view)
{: #view }
워크벤치에서 자원을 보거나 자원에 대해 작업하는 데 사용할 수 있는 편집기 영역 외부의 분할창입니다.

### 보안 테스트(security test)
{: #security-test }
어댑터 프로시저, 애플리케이션 또는 정적 URL과 같은 자원을 보호하기 위해 사용되는 인증 영역의 정렬된 세트입니다.

### 복제(clone)
{: #clone }
새로운 고유 컴포넌트 ID가 있는 승인된 최신 버전의 컴포넌트에 대한 동일한 사본입니다.

### 브로드캐스트 알림(broadcast notification)
{: #broadcast-notification }
특정 {{ site.data.keys.product_adj }} 애플리케이션의 모든 사용자로 대상화되는 알림입니다. 태그 기반 알림(tag-based notification)도 참조하십시오.

### 빌드 정의(build definition)
{: #build-definition }
빌드(예를 들어, 프로젝트 전체의 주간 통합 빌드)를 정의하는 오브젝트입니다.

## 사
{: #사 }

### 사내 애플리케이션(in-house application)
{: #in-house-application }
[회사 애플리케이션(company application)](#company-application)을 참조하십시오.

### 서명(sign)
{: #sign }
문서를 메일로 보낼 때 송신자의 사용자 ID에서 파생된 고유 전자 서명을 문서 또는 필드에 첨부하는 것입니다. 메일에 서명하면 인증되지 않은 사용자가 사용자 ID 사본을 새로 작성하는 경우 사본에서 서명을 위조할 수 없도록 합니다. 또한 서명은 메시지가 이동 중일 때 아무도 데이터를 조작하지 않았음을 확인합니다.

### 서버 팜(server farm)
{: #server-farm }
네트워킹된 서버 그룹입니다.

### 서비스(service)
{: #service }
서버 또는 관련 소프트웨어에서 기본 기능을 수행하는 프로그램입니다.

### 세션(session)
{: #sessions }
세션이 지속되는 동안 두 요소가 서로 데이터를 전달하고 교환하도록 허용하는 네트워크에 있는 두 스테이션, 소프트웨어 프로그램 또는 디바이스 간 논리 또는 가상 연결입니다.

### 수집 정책(acquisition policy)
{: #acquisition-policy }
모바일 디바이스의 센서에서 데이터를 수집하는 방법을 제어하는 정책입니다. 이 정책은 애플리케이션 코드에 의해 정의됩니다.

### 스킨(skin)
{: #skin }
기능에 영향을 주지 않고 인터페이스 모양을 바꾸기 위해 변경할 수 있는 그래픽 사용자 인터페이스의 요소입니다.

### 슬라이드(slide)
{: #slide }
터치스크린에서 슬라이더 인터페이스 항목을 가로로 이동하는 것입니다. 일반적으로 앱은 슬라이드 움직임을 사용하여 전화를 잠그고 잠금 해제하거나 옵션을 전환합니다.

### 시뮬레이터(simulator)
{: #simulator }
다른 플랫폼용으로 작성된 코드의 스테이징을 위한 환경입니다. 시뮬레이터를 사용하여 동일한 IDE에서 코드를 개발하고 테스트하지만 특정 플랫폼에 해당 코드를 배치합니다. 예를 들어, 컴퓨터에서 Android 디바이스용 코드를 개발한 후 해당 컴퓨터에서 시뮬레이터를 사용하여 이를 테스트할 수 있습니다.

### 시스템 메시지(system message)
{: #system-message }
예를 들어, 연결 성공 여부와 같은 운영 상태 또는 경보를 제공하는 모바일 디바이스의 자동화된 메시지입니다.

### 신임 정보(credential)
{: #credential }
사용자에게 권한을 부여하거나 특정 액세스 권한을 처리하는 정보 세트입니다.

### 실행(fire)
{: #fire }
객체 지향 프로그래밍에서 상태 전이를 실행하는 것입니다.

## 아
{: #아 }

### 알림(notification)
{: #notification }
조치를 트리거할 수 있는 프로세스 내의 발생입니다. 알림을 사용하면 송신자로부터 관심있는 상대(수신자) 세트(일반적으로 알 수 없음)로 전송할 관심있는 조건을 모델링할 수 있습니다.

### 암호화(encryption)
{: #encryption }
컴퓨터 보안에서 원래 데이터를 확보할 수 없거나 복호화 프로세스를 사용해서만 확보할 수 있는 방법으로 데이터를 이해할 수 없는 형식으로 변환하는 프로세스입니다.

### 애플리케이션 디스크립터 파일(application descriptor file)
{: #application-descriptor-file }
애플리케이션의 다양한 측면을 정의하는 메타데이터 파일입니다.

### 앱(app)
{: #app }
웹 또는 모바일 디바이스 애플리케이션입니다. 웹 애플리케이션(web application)도 참조하십시오.

### 어댑터(adapter)
{: #adapter }
{{ site.data.keys.product_adj }} 애플리케이션의 서버 측 코드입니다. 어댑터는 엔터프라이즈 애플리케이션에 연결하고 모바일 애플리케이션과 데이터를 주고 받고 보낸 데이터에서 필요한 서버 측 로직을 수행합니다.

### 에뮬레이터(emulator)
{: emulator }
현재 플랫폼이 아닌 다른 플랫폼용의 애플리케이션을 실행하는 데 사용할 수 있는 애플리케이션입니다.

### 엔터프라이즈 애플리케이션(enterprise application)
{: #enterprise-application }
회사 애플리케이션(company application)을 참조하십시오.

### 엔티티(entity)
{: #entity }
보안 서비스에 대해 정의되는 사용자, 그룹 또는 자원입니다.

### 역방향 프록시(reverse proxy)
{: #reverse-proxy }
프록시가 백엔드 HTTP 서버를 대신하는 IP 전달 토폴로지입니다. HTTP를 사용하는 서버의 애플리케이션 프록시입니다.

### 웹 애플리케이션 서버(web application server)
{: #web-application-server }
동적 웹 애플리케이션의 런타임 환경입니다. Java EE 웹 애플리케이션 서버는 Java EE 표준 서비스를 구현합니다.

### 웹 앱/애플리케이션(web app / application)
{: #web-app--application }
웹 브라우저를 통해 액세스할 수 있고 정적으로 정보를 표시하는 기능뿐 아니라 데이터베이스를 조회하는 등의 기능을 사용자에게 제공하는 애플리케이션입니다. 웹 애플리케이션의 공통 컴포넌트에는 HTML 페이지, JSP 페이지, 서블릿이 포함됩니다. [앱(app)](#A)도 참조하십시오.

### 웹 자원(web resource)
{: #web-resource }
웹 애플리케이션 개발 중에 작성되는 자원(예: 웹 프로젝트, HTML 페이지, JSP(JavaServer Page) 파일, 서블릿, 사용자 정의 태그 라이브러리, 아카이브 파일) 중 하나입니다.

### 위젯(widget)
{: #widget }
웹 페이지에 배치하고 입력을 수신하며, 애플리케이션 또는 다른 위젯과 통신할 수 있는 재사용 가능한 이동식 애플리케이션 또는 동적 컨텐츠입니다.

### 위치정보(geolocation)
{: #geolocation }
다양한 유형의 신호 평가에 기반하여 위치를 정확히 찾아내는 프로세스입니다. 모바일 컴퓨팅에서는 주로 WLAN 액세스 지점 및 셀 타워를 사용하여 위치를 대략적으로 찾아냅니다. 지오코딩(geocoding), 위치 서비스(location services)도 참조하십시오.

### 이벤트 소스(event source)
{: #event-source }
단일 Java™ 가상 머신 내에서 비동기 알림 서버를 지원하는 오브젝트입니다. 이벤트 소스를 사용하면 이벤트 리스너 오브젝트를 등록한 다음 인터페이스를 구현하는 데 사용할 수 있습니다.

### 이벤트(event)
{: #event }
태스크 또는 시스템에 대한 중요한 발생사항입니다. 이벤트에는 조작 완료나 실패, 사용자 조치 또는 프로세스 상태 변경이 포함될 수 있습니다.

### 인증 기관 엔터프라이즈 애플리케이션(certificate authority enterprise application)
{: #certificate-authority-enterprise-application }
클라이언트 애플리케이션에 관한 인증서 및 개인 키를 제공하는 회사 애플리케이션입니다.

### 인증 확인 핸들러(challenge handler)
{: #challenge-handler }
서버 측에서 일련의 인증 확인을 발행하고 클라이언트 측에서 응답하는 클라이언트 측 컴포넌트입니다.

### 인증 확인(challenge)
{: #challenge }
시스템에 대한 특정 정보 요청입니다. 이 요청에 대한 응답으로 서버에 다시 보내는 정보가 클라이언트 인증에 필요합니다.

### 인증(authentication)
{: #authentication }
컴퓨터 시스템의 사용자가 본인임을 증명하는 증거를 제공하는 보안 서비스입니다. 이 서비스를 구현하기 위한 공통 메커니즘은 비밀번호 및 디지털 서명입니다.

### 인증서(certificate)
{: #certificate }
컴퓨터 보안에서 공개 키를 인증서 소유자의 ID에 바인드하여 인증서 소유자를 인증할 수 있게 해주는 디지털 문서입니다. 인증은 인증 기관에서 발행되며 이러한 기관에서 디지털로 서명됩니다. [인증 기관(CA, Certificate Authority)](#ca--certificate-authority-ca)도 참조하십시오.

### 인코딩된 DER(DER encoded)
{: #der-encoded }
ASCII PEM 형식 인증서의 2진 양식과 관련됩니다. Base64, 인코딩된 PEM(PEM encoded)도 참조하십시오.

### 인코딩된 PEM(PEM encoded)
{: #pem-encoded }
Base64 인코드 인증서와 관련됩니다. Base64, 인코딩된 DER(DER encoded)도 참조하십시오.

## 자
{: #자 }

### 지오코딩(geocoding)
{: #geocoding }
더 많은 전통적인 지리적 마커(주소, 우편번호 등)를 통해 지오코드를 식별하는 프로세스입니다. 예를 들어, 랜드마크는 두 가로의 교차점에 위치할 수 있지만 이 랜드마크의 지오코드는 일련의 번호로 구성됩니다.

## 차
{: #차 }

### 차단(block)
{: #block }
여러 특성(예: 어댑터, 프로시저 또는 매개변수)의 콜렉션입니다.

## 카
{: #카 }

### 카탈로그(catalog)
{: #catalog }
앱 콜렉션입니다.

### 컴포넌트(component)
{: #component }
특정 기능을 수행하며 다른 컴포넌트 및 애플리케이션과 함께 작동하는 재사용 가능한 오브젝트 또는 프로그램입니다.

### 콜백 기능(callback function)
{: #callback-function }
하위 레벨 소프트웨어 계층이 상위 레벨 계층에 정의된 함수를 호출할 수 있도록 하는 실행 코드입니다.

### 클라이언트 측 인증 컴포넌트(client-side authentication component)
{: #client-side-authentication-componnet }
클라이언트 정보를 수집한 후 로그인 모듈을 사용하여 이 정보를 확인하는 컴포넌트입니다.

### 클라이언트(client)
{: #client }
서버에서 서비스를 요청하는 소프트웨어 프로그램 또는 컴퓨터입니다.

### 클러스터(cluster)
{: #cluster }
단일의 통합된 컴퓨팅 기능을 제공하기 위해 함께 작업되는 완전한 시스템 콜렉션입니다.

### 키 쌍(key pair)
{: #key-pair }
컴퓨터 보안에서 공개 키 및 개인 키입니다. 키 쌍을 암호화에 사용하는 경우 송신자는 수신자의 공개 키를 사용하여 메시지를 암호화하고 수신자는 수신자의 개인 키를 사용하여 메시지를 복호화합니다. 키 쌍을 사용하여 서명하는 경우 서명자는 서명자의 개인 키를 사용하여 메시지 표시를 암호화하고 수신자는 서명 확인을 위해 송신자의 공개 키를 사용하여 메시지 표시를 복호화합니다.

### 키 체인(keychain)
{: #keychain }
Apple 소프트웨어용 비밀번호 관리 시스템입니다. 키 체인은 여러 애플리케이션 및 서비스에서 사용되는 비밀번호를 위한 보안 스토리지 컨테이너로서 작동합니다.

### 키(key)
{: #key }
메시지를 디지털 방식으로 부호화, 확인, 암호화 또는 암호 해독하는 데 사용하는 수학적 암호화 값입니다. 개인 키(private key), 공개 키(public key)도 참조하십시오.
레코드를 고유하게 식별하고 다른 레코드와 관련하여 해당 순서를 설정하는 데 사용되는 데이터의 품목에 있는 하나 이상의 문자입니다.

## 타
{: #타 }

### 태그 기반 알림(tag-based notification)
{: #tag-based-notification }
특정 태그로 등록된 디바이스를 대상으로 하는 알림입니다. 태그는 사용자가 관심 있는 주제를 나타내는 데 사용됩니다. 브로드캐스트 알림(broadcast notification)도 참조하십시오.

### 탭(tap)
{: #tap }
터치스크린을 짧게 두드리는 것입니다. 일반적으로 앱은 탭 움직임을 사용하여 항목을 선택합니다(마우스 왼쪽 단추 클릭과 비슷함).

### 템플리트(template)
{: #template }
공통 특성을 공유하는 요소 그룹입니다. 이러한 특성은 템플리트 레벨에 한 번만 정의될 수 있고, 템플리트를 사용하는 모든 요소에 의해 상속됩니다.

### 트리거(trigger)
{: #trigger }
발생을 발견하고 응답으로 추가 처리를 발생시킬 수 있는 메커니즘입니다. 디바이스 컨텍스트에서 변경이 발생하면 트리거가 활성화될 수 있습니다. 디바이스 컨텍스트(device context)도 참조하십시오.

## 파
{: #파 }

### 팜 노드(farm node)
{: #farm-node }
서버 팜에 있는 네트워킹된 서버입니다.

### 패싯(facet)
{: #facet }
XML 데이터 유형을 제한하는 XML 엔티티입니다.

### 페이지 탐색(page navigation)
{: #page-navigation }
브라우저에서 사용자가 앞뒤로 탐색할 수 있도록 지원하는 브라우저 기능입니다.

### 폴링(poll)
{: #poll }
서버에서 데이터를 반복적으로 요청하는 것입니다.

### 푸시 알림(push notification)
{: #push-notification }
모바일 앱 아이콘에 나타나는 변경 또는 업데이트를 표시하는 경보입니다.

### 푸시(push)
{: #push }
서버에서 클라이언트로 정보는 보내는 것입니다. 서버가 컨텐츠를 푸시할 때 클라이언트의 요청이 아닌 트랜잭션을 시작하는 서버입니다.

### 프로비저닝(provision)
{: #provisin }
서비스, 컴포넌트, 애플리케이션 또는 자원을 제공하고 배치하고 추적하는 것입니다.

### 프로젝트 WAR 파일(project WAR file)
{: #project-war-file }
{{ site.data.keys.product_adj }} 런타임 환경에 대한 구성을 포함하고 애플리케이션 서버에 배치된 웹 아카이브(WAR) 파일입니다.

### 프로젝트(project)
{: #project }
애플리케이션, 어댑터, 구성 파일, 사용자 정의 Java 코드, 라이브러리와 같은 다양한 컴포넌트의 개발 환경입니다.

### 프록시(proxy)
{: #proxy }
Telnet 또는 FTP와 같은 특정 네트워크 애플리케이션을 위해 두 네트워크를 연결하는 애플리케이션 게이트웨이입니다. 예를 들어, 방화벽의 프록시 Telnet 서버에서는 사용자에 대한 인증이 수행되며 그 이후의 트래픽은 프록시가 없는 것처럼 프록시를 통해 플로우됩니다. 클라이언트 워크스테이션이 아닌 방화벽에서 기능이 수행되므로 방화벽의 로드가 높습니다.

## 하
{: #하 }

### 하위 요소(subelement)
{: #subelement }
UN/EDIFACT EDI 표준에서 EDI 컴포지트 데이터 요소의 일부분인 EDI 데이터 요소입니다. 예를 들어, EDI 데이터 요소 및 규정자가 EDI 컴포지트 데이터 요소의 하위 요소입니다.

### 하이브리드 애플리케이션(hybrid application)
{: #hybrid-application }
주로 웹 지향 언어(HTML5, CSS 및 JS)로 작성되었지만 앱이 고유 앱처럼 작동하여 사용자에게 고유 앱의 모든 기능을 제공하도록 고유 쉘에서 랩핑된 애플리케이션입니다.

### 환경(environment)
{: #environment }
하드웨어 및 소프트웨어 구성의 특정 인스턴스입니다.

### 회사 애플리케이션(company application)
{: #company-application }
회사의 내부 사용 목적으로 고안된 애플리케이션입니다.

### 회사 허브(Company Hub)
{: #company-hub }
다른 특정 애플리케이션이 모바일 디바이스에 설치되도록 배포할 수 있는 애플리케이션입니다. 예를 들어, Application Center는 회사 허브입니다. [Application Center](#application-center)도 참조하십시오.

## 숫자
{: #숫자 }

### 2진(binary)
{: #binary }
컴파일되거나 실행 가능한 것과 관련됩니다.

## A
{: #a }

### Android
{: #android }
Google에서 작성한 모바일 운영 체제이며 대부분은 Apache 2.0 및 GPLv2 개방형 소스 라이센스 하에 릴리스됩니다. 모바일 디바이스(mobile device)도 참조하십시오.

### API / API(Application Programming Interface)
{: #api-application-programming-interfacae-api }
고급 언어로 작성된 애플리케이션 프로그램에서 해당 운영 체제 또는 다른 프로그램의 특정 데이터 또는 기능을 사용할 수 있도록 하는 인터페이스입니다.

### Application Center
{: #application-center }
모바일 애플리케이션의 단일 저장소에서 팀 구성원 간에 애플리케이션을 공유하고 협업을 이용하는 데 사용할 수 있는 {{ site.data.keys.product_adj }} 컴포넌트입니다.

### Application Center 설치 프로그램(Application Center installer)
{: #application-center-installer }
Application Center에서 사용 가능한 애플리케이션의 카탈로그를 나열하는 애플리케이션입니다. 사용자가 개인용 애플리케이션 저장소에서 애플리케이션을 설치할 수 있도록 하려면 디바이스에 Application Center 설치 프로그램이 있어야 합니다.

## B
{: #b }
### Base64
{: #base64 }
2진 데이터를 인코딩하는 데 사용되는 일반 텍스트 형식입니다. Base64 인코딩은 X.509 인증, X.509 CSR 및 X.509 CRL을 인코딩하는 사용자 인증서 인증(User Certificate Authentication)에 공통적으로 사용됩니다. 인코딩된 DER(DER encoded), 인코딩된 PEM(PEM encoded)도 참조하십시오.

## C
{: #c }

### CA / 인증 기관(CA, Certificate Authority)
{: #ca--certificate-authority-ca }
디지털 인증서를 발행하는 신뢰할 수 있는 써드파티 조직 또는 회사입니다. 일반적으로 인증 기관은 고유 인증서를 부여받은 개인의 ID를 확인합니다. [인증서(certificate)](#certificate)도 참조하십시오.

### CRL / 인증서 취소 목록(CRL, Certificate Revocation List)
{: #crl-certificate-revocation-list-crl }
스케줄된 만기 날짜 이전에 해지된 인증서의 목록입니다. 인증서 취소 목록은 관련된 인증이 취소되지 않았는지 확인하기 위해 SSL(Secure Sockets Layer) 데이터 교환 중에 사용하고 인증 기관에서 유지보수합니다.

## D
{: #d }

### documentify
{: #documentify }
문서를 작성하는 데 사용되는 JSONStore 명령입니다.

## J
{: #j }

### JMX / JMX(Java Management Extensions)
{: #jmx--java-management-extensions-jmx }
Java 기술을 통한 Java 기술 관리 수단입니다. JMX는 관리가 필요한 모든 산업에 배치할 수 있는 기술로 관리를 위한 Java 프로그래밍 언어의 보편적인 개방형 확장입니다.

## M
{: #m }

### MBean / MBean(Managed Bean)
{: #mbean--managed-bean-mbean}
JMX(Java Management Extensions) 스펙에서, 자원 및 인스트루먼테이션을 구현하는 Java 오브젝트입니다.

### MobileFirst Data Proxy
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{ site.data.keys.product }} OAuth 보안 기능을 사용하여 Cloudant에 대한 모바일 애플리케이션 호출을 보안하는 데 사용될 수 있는 IMFData SDK에 대한 서버 측 컴포넌트입니다. {{ site.data.keys.product_adj }} Data Proxy는 신뢰 연관 인터셉터를 통해 인증을 필요로 합니다.

### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{ site.data.keys.mf_server }}에 배치된 {{ site.data.keys.product_adj }} 런타임 환경을 제어 및 관리하고 사용자 통계를 수집 및 분석하는 데 사용되는 웹 기반 인터페이스입니다.

### MobileFirst Server
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
보안, 백엔드 연결, 푸시 알림, 모바일 애플리케이션 관리 및 분석을 처리하는 {{ site.data.keys.product_adj }} 컴포넌트입니다. {{ site.data.keys.mf_server }}는 애플리케이션 서버에서 실행되는 앱의 콜렉션이며, {{ site.data.keys.product_adj }} 런타임 환경에 대한 런타임 컨테이너의 역할을 합니다.

### MobileFirst 런타임 환경(MobileFirst runtime environment)
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
서버 측 모바일 애플리케이션(백엔드 통합, 버전 관리, 보안, 통합된 푸시 알림)을 실행하는 모바일 최적화된 서버 측 컴포넌트입니다. 각 런타임 환경은 웹 애플리케이션(WAR 파일)으로 패키징됩니다.

### MobileFirst 어댑터(MobileFirst adapter)
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
[어댑터(adapter)](#adapter)를 참조하십시오.

## O
{: #o }

### OAuth
{: #oauth }
자원 소유자, 클라이언트 및 자원 서버 간에 승인 상호작용을 작성하여 자원 소유자 대신 애플리케이션 범위에서 보호된 자원에 액세스할 수 있는 권한을 제공하는 HTTP 기반 인증 프로토콜입니다.

## P
{: #p }

### PKI / PKI(Public Key Infrastructure)
{: #pki--public-key-infrastructure-pki }
네트워크 트랜잭션에 관련된 각 당사자의 유효성을 확인하고 인증하는 디지털 인증서, 인증 기관 및 기타 등록대행 기관으로 구성된 시스템입니다.

### PKI 브릿지(PKI bridge)
{: #pki-bridge }
PKI와 통신하는 데 사용자 인증서 인증(User Certificate Authentication) 프레임워크를 사용하는 {{ site.data.keys.mf_server }} 개념입니다.

## S
{: #s}

### SALT
{: #salt }
비밀번호 또는 비밀번호 문구 해시에 삽입되어 무작위로 생성되는 데이터로 비밀번호를 평범하지 않도록(해킹하기 더 어렵도록) 만들어 줍니다.

### SDK / SDK(Software Development Kit)
{: #sdk--software-development-kit-sdk }
특정 운영 환경에 대해 또는 특정 컴퓨터 언어로 소프트웨어의 개발을 지원하기 위한 도구, API 및 문서 세트입니다.

## T
{: #t}

### TAI / TAI(Trust Association Interceptor)
{: #tai--trust-association-interceptor-tai }
프록시 서버가 받은 모든 요청에 대해 제품 환경에서 신뢰를 유효성 검증하는 메커니즘입니다. 유효성 검증 방법은 프록시 서버와 인터셉터에서 동의됩니다.

## X
{: #x }

### X.509 인증서(X.509 certificate)
{: #x509-certificate }
X.509 표준으로 정의된 정보를 포함하는 인증서입니다.
