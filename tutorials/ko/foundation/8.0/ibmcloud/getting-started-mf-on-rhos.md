---
layout: tutorial
breadcrumb_title: Get started with Foundation on OpenShift
title: OpenShift 클러스터에서 Mobile Foundation 시작하기
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->


> **참고:** 이 시작하기는 IBM Cloud Pak for Applications 또는 이와 별도로 설치된 OpenShift Container Platform에 적용됩니다.

* [소개](#introduction)
* [아키텍처](#architecture)
* [Mobile Foundation 설치](#install-mf)
* [애플리케이션 개발](#develop-apps)
* [애플리케이션 배치](#deploying-apps)

## 소개
IBM Mobile Foundation v8은 이제 Red Hat Openshift 3.11 이상에 설치하고 실행할 수 있습니다. Red Hat OpenShift는 프로덕션 시스템에서 컨테이너 오케스트레이션의 복합적 현실을 다루도록 디자인된 엔터프라이즈 Kubernetes 플랫폼입니다.

엔터프라이즈가 계속적으로 디지털로 해당 비즈니스를 변환시킨 것처럼, 컨테이너와 마이크로서비스 아키텍처를 포함하는 PaaS 애플리케이션 개발 환경은 엔터프라이즈가 기본 운영 체제와 인프라 관리에 덜 신경 쓰고 부가 가치 애플리케이션 기능을 작성하고 향상시키는 데 집중할 수 있도록 해줍니다. Red Hat OpenShift는 자동화된 설치, 패치 및 애플리케이션 서비스를 통한 운영 체제의 컨테이너 스택의 모든 계층에 대한 업그레이드를 통해 Kubernetes 환경에서 이를 더욱 용이하게 하도록 디자인되었습니다.

Mobile Foundation은 개발자가 모바일, 웨어러블, 대화, 웹 및 PWA를 포함하여 차세대 다중 채널 디지털 앱을 신속하게 빌드하고 배치할 수 있도록 업계 선두의 보안 플랫폼을 제공합니다. 다음을 통해 강력한 디지털 관련 앱의 개발 및 배치를 가속화합니다.
* 포괄적 보안, 애플리케이션 라이프사이클 관리, 오프라인 데이터 동기화 및 백엔드 통합을 포함하여 OpenShift Container Platform에 대한 집중화된 모바일 백엔드 서비스
* 디지털 앱 빌드에 필요한 하위 언어 스튜디오 및 원시 및 하이브리드 개발자 모두를 위해 광범위하게 사용되는 모바일 프레임워크용 SDK
* 사용자가 이용할 수 있도록 앱을 공개하기 위한 사설 앱 저장소
* 애플리케이션 인사이트, 앱 내 피드백을 사용하는 피드백, 푸시 알림, 기능 토글 및 A/B 테스트에 대한 분석 서비스를 사용한 사용자 개입

## 아키텍처
{: #architecture}

아래의 이미지는 Red Hat OpenShift 클러스터에 Mobile Foundation을 배치하는 상위 레벨의 아키텍처를 표시합니다.

![아키텍처](../architecture-mobile-services-openshift.png)

## Mobile Foundation 설치
{: #install-mf}

Mobile Foundation을 기존 OpenShift 클러스터에 설치하려면 [여기](../mobilefoundation-on-openshift)의 지시사항에 따르십시오.

>**참고:** IBM Cloud의 Red Hat OpenShift Container Platform에 Mobile Foundation을 설치하려면 [여기](../deploy-mf-on-ibmcloud-ocp)의 지시사항에 따르십시오.

## 애플리케이션 개발
{: #develop-apps}

IBM Digital App Builder(DAB) 도구를 사용하여 Mobile Foundation 라이프사이클 관리, 보안, 개입 및 분석을 사용하는 모바일 애플리케이션을 쉽고 빠르게 개발할 수 있습니다. 또한 DAB는 백엔드 마이크로서비스에 대한 보안 연결에 필요한 애플리케이션 가속기를 제공합니다.  

* 몇 분 내에 첫 번째 Mobile Foundation Application을 빌드하고 테스트할 수 있습니다. - [IBM Digital App Builder 시작하기](https://github.com/MobileFirst-Platform-Developer-Center/IBMDigitalAppBuilderGettingStarted)

## 애플리케이션 배치
{: #deploying-apps}
모든 Mobile Foundation 애플리케이션에는 두 개의 배치 방법이 있습니다.
* Mobile Foundation App Center 또는 기타 공용 앱 저장소에 배치될 수 있는 모바일 클라이언트 애플리케이션
* 애플리케이션 라이프사이클, 보안, 푸시 알림, LiveUpdate에 대한 Mobile Foundation 서비스 구성. 이러한 구성은 Mobile Foundation 개발 환경에서 내보내고 Mobile Foundation 스테이징 또는 프로덕션 환경으로 가져올 수 있습니다.  

여러 배치에 걸쳐 Mobile Foundation Service 구성을 내보내고 가져오는 방법에 대해서는 [Mobile Foundation 서버 아티팩트를 내보내고 가져오는 다양한 방법](http://mobilefirstplatform.ibmcloud.com/blog/2016/07/25/how-to-replicate-mobilefirst-environment/)을 참조하십시오.
