---
layout: tutorial
title: MobileFirst Analytics
breadcrumb_title: Analytics
show_children: true
relevantTo: [ios,android,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics_full }}는 {{ site.data.keys.mf_server }} 및 클라이언트 디바이스의 앱 대 서버 활동, 클라이언트 로그, 클라이언트 충돌 및 서버 측 로그에서 데이터를 수집합니다. 수집된 데이터는 모바일 환경 및 서버 인프라에 대한 풍부한 정보를 제공합니다. 여기에는 사용자 보존의 기본 보고서, 충돌 보고서, 디바이스 유형 및 운영 체제 내역, 사용자 정의 데이터 및 사용자 정의 차트, 네트워크 사용, 푸시 알림 결과, 인앱 동작, 디버그 로그 콜렉션 등이 포함됩니다. 

{{ site.data.keys.mf_server }}는 네트워크 인프라 보고를 통해 미리 인스트루먼테이션되어 있습니다. 클라이언트와 서버가 모두 네트워크 사용을 보고하면 데이터가 집계되므로 네트워크, 서버 또는 백엔드 시스템이 성능 저하의 원인이 될 수 있습니다. 또한 클라이언트 측과 {{ site.data.keys.mf_analytics_server }}에서 모두 필터를 정의하여 Analytics에서 액세스하고 사용하는 로거 데이터를 제어할 수 있습니다. 보고된 이벤트의 상세도 및 데이터 보존 정책을 선택하고 조건부 경보를 설정하고 사용자 정의 차트를 빌드하고 새 데이터를 활용합니다. 

#### 플랫폼 지원
{: #platform-support }

{{ site.data.keys.mf_analytics }}는 다음을 지원합니다. 

* 고유 iOS 및 Android 클라이언트
* Cordova 애플리케이션(iOS, Android)
* 웹 애플리케이션
* Windows 8.1 Universal 또는 Windows 10 UWP의 경우 지원을 **사용할 수 없습니다**. 

IBM {{ site.data.keys.mf_server }}는 네트워크 인프라 보고를 통해 미리 인스트루먼테이션되어 있습니다. 클라이언트와 서버가 모두 네트워크 사용을 보고하면 데이터가 집계되므로 네트워크, 서버 또는 백엔드 시스템이 성능 저하의 원인이 될 수 있습니다. 

## 클라이언트 개발
{: #client-development }

Logger 클래스와 Analytics 클래스라는 두 개의 클라이언트 클래스가 함께 작업하여 원시 데이터를 서버에 전송합니다. 

### Analytics API
{: #the-analytics-api }

Analytics 클라이언트 API는 광범위한 이벤트에 대한 데이터를 수집하여 {{ site.data.keys.mf_analytics_server }}에 전송합니다. 
> [Analytics 클라이언트 개발](analytics-api) 학습서에서 자세히 학습하십시오.

### Logger API
{: #the-logger-api }

Logger는 표준 로거로서 작동합니다. 클라이언트로부터 로거 데이터를 모든 로깅 레벨로 {{ site.data.keys.mf_analytics_server }}에 전송할 수도 있습니다. 하지만 서버 구성에서 허용되는 로깅 요청 레벨을 제어합니다. 이 임계값 미만으로 전송된 요청은 무시됩니다. 

정보를 수집해야 하는 요구와 데이터 수량을 제한된 스토리지 용량에 맞게 제한해야 하는 요구 사이에서 균형을 맞추기 위해 로깅 레벨을 제어해야 합니다. 

> [클라이언트 로깅](../application-development/client-side-log-collection/) 학습서에서 자세히 학습하십시오. 

또한 클라이언트 측과 {{ site.data.keys.mf_analytics_server }}에서 모두 필터를 정의하여 Analytics에서 액세스하고 사용하는 로거 데이터를 제어할 수 있습니다. 

## Analytics Console 및 Operations Console
{: #the-analytics-and-operations-consoles }

{{ site.data.keys.product_full }}은 Analytics Console 및 Operations Console을 제공합니다. {{ site.data.keys.mf_console_full }}은 Analytics Server가 클라이언트 애플리케이션에 대해 작업하는 방식을 구성합니다. {{ site.data.keys.mf_analytics_console_full }}은 다양한 Analytics 보고서를 구성하고 표시합니다. 

> [Operations Console](console) 학습서에서 자세히 학습하십시오. 

> [사용자 정의 차트](console/custom-charts) 학습서에서 Analytics Console을 사용하여 사용자 정의 차트를 작성하는 것에 대해 자세히 학습하십시오. 

## Analytics Server
{: #the-analytics-server }

Analytics Server는 개발 환경과 프로덕션 환경에서 모두 사용할 수 있습니다. 

개발의 경우 Analytics Server는 {{ site.data.keys.mf_dev_kit }}과 함께 설치됩니다. 자세한 정보는 [{{ site.data.keys.product_adj }} 개발 환경 설정](../installation-configuration/development/mobilefirst/)을 참조하십시오. 이 킷이 설치되면 개발 요구에 맞게 {{ site.data.keys.mf_analytics_console_short }}을 사용할 수 있습니다. 

프로덕션의 경우에는 사용 가능한 인프라, 비즈니스 요구, 시스템 디자인 등에 따라 다양한 설치 및 구성 옵션이 있습니다. 자세한 정보는 [{{ site.data.keys.product_adj }} 개발 환경 설정](../installation-configuration/production/analytics/)을 참조하십시오. 

{{ site.data.keys.mf_analytics }}는 Elasticsearch를 사용합니다. {{ site.data.keys.product }}에서 [Elasticsearch 사용 방법에 대해 학습](elasticsearch)하십시오. 

## 문제점 해결
{: #troubleshotting }

{{ site.data.keys.mf_analytics }}의 문제점 해결에 대한 정보는 [Analytics 문제점 해결](../troubleshooting/analytics/)을 참조하십시오. 

## 다음에 읽을 내용
{: #what-to-read-next }
