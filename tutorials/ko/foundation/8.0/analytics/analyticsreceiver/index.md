---
layout: tutorial
title: Analytics Receiver
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.mf_analytics_receiver_short }}는 인메모리 이벤트 큐를 사용하여 단계별로 모바일 애플리케이션에서 이벤트 로그를 수신해서 {{ site.data.keys.mf_analytics_short }}에 전달하는 설정을 제공하는 선택적 서비스입니다.

{{ site.data.keys.mf_analytics_receiver_short }}는 인메모리 이벤트 큐를 설정하여 {{ site.data.keys.mf_analytics }}에 보내기 전에 로그를 저장합니다. 

모바일 Analytics의 기본 설정과 구성은 {{ site.data.keys.mf_server }}에서 모든 모바일 클라이언트 이벤트 로그를 수신하여 {{ site.data.keys.mf_analytics }}에 전달하는 것입니다. 디바이스가 너무 많은 경우, 모바일 클라이언트 애플리케이션의 사용량이 높고 클라이언트 애플리케이션에서 기록되고 전송되는 분석 데이터가 많아서 {{ site.data.keys.mf_server }} 성능에 영향을 줄 수 있습니다. {{ site.data.keys.mf_analytics_receiver_short }}를 사용하면 {{ site.data.keys.mf_server }}의 분석 이벤트 처리 부담이 없어지므로 {{ site.data.keys.mf_server }} 자원을 런타임 기능에 완전히 활용할 수 있습니다. 

{{ site.data.keys.mf_analytics_receiver_short }}는 언제든 설치하여 구성할 수 있습니다. 모바일 클라이언트 애플리케이션을 최신 Mobile Foundation 클라이언트 SDK로 업데이트합니다. 애플리케이션 코드는 변경하지 않아도 됩니다. {{ site.data.keys.mf_server }} JNDI 특성을 {{ site.data.keys.mf_analytics_receiver_short }} 구성으로 업데이트하여 {{ site.data.keys.mf_analytics_receiver_short }} 엔드포인트를 클라이언트 애플리케이션에 제공해서 분석 이벤트를 전송할 수 있게 합니다. 

![Analytics Receiver 토폴로지](AnalyticsTopology.png)

## {{ site.data.keys.mf_analytics_receiver_short }} 구성
{: #analytics-receiver-configuration }

Analytics Receiver의 WAR 파일은 {{ site.data.keys.mf_server }} 설치에 포함되어 있습니다. 자세한 정보는 {{ site.data.keys.mf_server }}의 배포 구조를 참조하십시오. 

* {{ site.data.keys.mf_analytics_receiver_server }} 설치 방법은 [{{ site.data.keys.mf_analytics_receiver_server }} 설치 안내서](../../installation-configuration/production/analyticsreceiver/installation)를 참조하십시오.
* IBM MobileFirst Analytics Receiver의 자세한 구성 방법은 [구성 안내서](../../installation-configuration/production/analyticsreceiver/configuration)를 참조하십시오. 

* {{ site.data.keys.mf_analytics_receiver_short }} 설치 후 구성 검사를 빠르게 수행하기 위해 다음 JNDI 특성은 {{ site.data.keys.mf_analytics }}를 지정합니다. 

  | 특성                               |설명                                           | 기본값 |
  |------------------------------------|-------------------------------------------------------|---------------|
  | receiver.analytics.url                  | 필수. 수신 분석 데이터를 수신하는 {{ site.data.keys.mf_analytics_server }}에서 공개한 URL. 예: http://hostname:port/analytics-service/rest. | 없음 |
  | receiver.analytics.username             | 데이터 시작점을 기본 인증으로 보호하는 경우 사용되는 사용자 이름입니다. | 없음 |
  | receiver.analytics.password             | 데이터 시작점을 기본 인증으로 보호하는 경우 사용되는 비밀번호입니다. | 없음 |
  | receiver.analytics.event.qsize          | 선택사항. 분석 이벤트 큐 크기입니다. 샘플 JVM 힙 크기를 제공하여 주의해서 추가해야 합니다. 기본 큐 크기 10000.  | 없음 |

* 수신기를 *loguploader*로 사용하려면 다음 JNDI 특성을 {{ site.data.keys.mf_server }}에 설정해야 합니다. 이러한 JNDI 특성은 {{ site.data.keys.mf_analytics_receiver_server }}를 지정해야 합니다. 

  | 특성                               |설명                                           | 기본값 |
  |------------------------------------|-------------------------------------------------------|---------------|
  | mfp.analytics.receiver.url                  | 필수. 수신 분석 데이터를 수신하는 {{ site.data.keys.mf_analytics_receiver_server }}에서 공개한 URL. 예: http://hostname:port/analytics-receiver/rest. | 없음 |
  | mfp.analytics.receiver.username             | 데이터 시작점을 기본 인증으로 보호하는 경우 사용되는 사용자 이름입니다. | 없음 |
  | mfp.analytics.receiver.password             | 데이터 시작점을 기본 인증으로 보호하는 경우 사용되는 비밀번호입니다. | 없음 |

* 서버 로그를 계속 {{ site.data.keys.mf_server }}에서 {{ site.data.keys.mf_analytics_server }}로 직접 전송하므로 {{ site.data.keys.mf_analytics_short }} 설정이 {{ site.data.keys.mf_server }}에서 중단되지 않도록 하십시오. 

## 문제점 해결
{: #troubleshooting }

{{ site.data.keys.mf_analytics_receiver }}의 문제점 해결에 대한 정보는 [Analytics Receiver 문제점 해결](../../troubleshooting/analyticsreceiver/)을 참조하십시오.
