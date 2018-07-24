---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Log and trace collection
#relevantTo: [ios,android,windows,javascript]
#weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
IBM Containers for IBM Cloud에서는 컨테이너 CPU, 메모리, 네트워크에 대한 몇몇 기본 제공 로깅 및 모니터링 기능을 제공합니다. 선택적으로 {{ site.data.keys.product_adj }} 컨테이너의 로그 레벨을 변경할 수 있습니다.

{{ site.data.keys.mf_server }}, {{ site.data.keys.mf_analytics }} 및 {{ site.data.keys.mf_app_center }} 컨테이너의 로그 파일을 작성하는 옵션은 기본적으로 사용으로 설정되어 있습니다(`*=info` 레벨 사용). 수동으로 코드 대체를 추가하거나 제공된 스크립트 파일을 사용해서 코드를 삽입하여 로그 레벨을 변경할 수 있습니다. Kibana 시각화 도구를 사용하여 IBM Cloud logmet 콘솔에서 컨테이너 로그와 서버 또는 런타임 로그를 모두 볼 수 있습니다. 개방형 소스 메트릭 대시보드이며 그래프 편집기인 Grafana를 사용하여 IBM Cloud logmet 콘솔에서 모니터링을 수행할 수 있습니다.

{{ site.data.keys.product_adj }} 컨테이너가 SSH(Secure Shell) 키를 사용하여 작성되고 공용 IP 주소에 바인드된 경우 적절한 개인 키를 사용해서 컨테이너 인스턴스의 로그를 안전하게 볼 수 있습니다.

### 로깅 대체
{: #logging-overrides }
수동으로 코드 대체를 추가하거나 제공된 스크립트 파일을 사용해서 코드를 삽입하여 로그 레벨을 변경할 수 있습니다. 로그 레벨을 변경하기 위해 수동으로 코드 대체를 추가하는 작업은 이미지를 처음 준비할 때 수행되어야 합니다. 새 로깅 구성을 **package\_root/mfpf-[analytics|server]/usr/config** 폴더 및 **package_root/mfp-appcenter/usr/config** 폴더에 별도의 구성 스니펫으로 추가해야 하며 이는 Liberty 서버의 configDropins/overrides 폴더에 복사됩니다.

V8.0.0 패키지에서 제공되는 start\*.sh 스크립트 파일(**startserver.sh**, **startanalytics.sh**, **startservergroup.sh**, **startanalyticsgroup.sh**, **startappcenter.sh**, **startappcentergroup.sh**)을 실행할 때 특정 명령행 인수를 사용하여 로그 레벨을 변경하기 위해 주어진 스크립트 파일을 사용해서 코드를 삽입할 수 있습니다. 다음 선택적 명령행 인수를 적용할 수 있습니다.

* `[-tr|--trace]` trace_specification
* `[-ml|--maxlog]` maximum\_number\_of\_log\_files
* `[-ms|--maxlogsize]` maximum\_size\_of\_log\_files

## 컨테이너 로그 파일
{: #container-log-files }
각 컨테이너 인스턴스의 Liberty Profile 런타임 활동과 {{ site.data.keys.mf_server }}에 대한 로그 파일이 생성되며 로그 파일은 다음 위치에 있습니다.

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

각 컨테이너 인스턴스의 Liberty Profile 런타임 활동과 {{ site.data.keys.mf_app_center }} 서버에 대한 로그 파일이 생성되며 로그 파일은 다음 위치에 있습니다.

* /opt/ibm/wlp/usr/servers/appcenter/logs/messages.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/console.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/trace.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/ffdc/*

로그 파일 액세스 단계를 수행하여 컨테이너에 로그인하고 로그 파일에 액세스할 수 있습니다.

컨테이너가 더 이상 존재하지 않는 경우에도 로그 파일을 유지하려면 볼륨을 사용으로 설정하십시오. (기본적으로 볼륨은 사용되지 않습니다.) 볼륨을 사용으로 설정하면 logmet 인터페이스(예: https://logmet.ng.bluemix.net/kibana) 를 사용해서 IBM Cloud에서 로그를 볼 수도 있습니다.

**볼륨 사용**
볼륨을 사용하면 컨테이너에서 로그 파일을 유지할 수 있습니다. {{ site.data.keys.mf_server }} 로그와 {{ site.data.keys.mf_analyics }} 컨테이너 로그의 볼륨은 기본적으로 사용으로 설정되어 있지 않습니다.

`ENABLE_VOLUME [-v | --volume]`을 `Y`로 설정하여 **start*.sh** 스크립트를 실행하는 동안 볼륨을 사용으로 설정할 수 있습니다. 스크립트를 대화식으로 실행하는 동안 **args/startserver.properties** 파일과 **args/startanalytics.properties** 파일에서 이와 같이 구성할 수도 있습니다.

유지되는 로그 파일은 컨테이너의 **/var/log/rsyslog** 폴더와 **/opt/ibm/wlp/usr/servers/mfp/logs** 폴더에 저장됩니다.  
컨테이너에 SSH 요청을 발행하여 로그에 액세스할 수 있습니다.

## 로그 파일 액세스
{: #accessing-log-files }
각 컨테이너 인스턴스에 대한 로그가 작성됩니다. `cf ic` 명령을 사용하거나 IBM Cloud logmet 콘솔을 사용하여 IBM Container Cloud Service REST API를 통해 로그 파일에 액세스할 수 있습니다.

### IBM Container Cloud Service REST API
{: #ibm-container-cloud-service-rest-api }
컨테이너 인스턴스의 경우 [IBM Cloud logmet 서비스](https://logmet.ng.bluemix.net/kibana/)를 사용해서 **docker.log**와 **/var/log/rsyslog/syslog**를 볼 수 있습니다. 동일한 Kibana 대시보드를 사용하여 로그 활동을 볼 수 있습니다.

IBM Containers CLI 명령(`cf ic exec`)을 사용하여 실행 중인 컨테이너 인스턴스에 대한 액세스 권한을 얻을 수 있습니다. 또는 SSH(Secure Shell)를 통해 컨테이너 로그 파일을 얻을 수 있습니다.

### SSH 사용
{: #enabling-ssh}
SSH를 사용하려면 **prepareserver.sh** 또는 **prepareanalytics.sh** 스크립트를 실행하기 전에 **package_root/[mfpf-server 또는 mfpf-analytics]/usr/ssh** 폴더에 SSH 공개 키를 복사하십시오. 그러면 SSH가 사용되는 이미지를 빌드합니다. 해당 특정 이미지에서 작성된 컨테이너에서는 SSH가 사용됩니다.

SSH가 이미지 사용자 정의의 일부로 사용되지 않는 경우 **startserver.sh** 또는 **startanalytics.sh** 스크립트를 실행할 때 SSH\_ENABLE 인수와 SSH\_KEY 인수를 사용하여 컨테이너에 대해 SSH를 사용할 수 있습니다. 선택적으로 주요 컨텐츠를 포함하도록 관련 스크립트 .properties 파일을 사용자 정의할 수 있습니다.

컨테이너 로그 엔드포인트는 컨테이너 인스턴스의 지정된 ID를 사용하여 stdout 로그를 가져옵니다.

예: `GET /containers/{container_id}/logs`

#### 명령행에서 컨테이너에 액세스
{: #accessing-containers-from-the-command-line }
명령행에서 실행 중인 {{ site.data.keys.mf_server }} 컨테이너 인스턴스와 {{ site.data.keys.mf_analytics }} 컨테이너 인스턴스에 액세스하여 로그와 추적을 얻을 수 있습니다.

1. 다음 명령을 실행하여 컨테이너 인스턴스에 대화식 터미널을 작성하십시오. `cf ic exec -it container_instance_id "bash"`.
2. 로그 파일 또는 추적을 찾으려면 다음 예제 명령을 사용하십시오.

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
   container_instance@root# vi messages.log
   ```

3. 로그를 로컬 워크스테이션에 복사하려면 다음 예제 명령을 사용하십시오.

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### SSH를 사용하여 컨테이너에 액세스
{: #accessing-containers-using-ssh }
SSH(Secure Shell)를 사용해서 {{ site.data.keys.mf_server }} 컨테이너와 {{ site.data.keys.mf_analytics }} 컨테이너에 액세스하여 Syslog와 Liberty 로그를 가져올 수 있습니다.

컨테이너 그룹을 실행 중인 경우 공용 IP 주소를 각 인스턴스에 바인드하고 SSH를 사용하여 안전하게 로그를 볼 수 있습니다. SSH를 사용하려면 **startservergroup.sh** 스크립트를 실행하기 전에 SSH 공개 키를 **mfp-server\server\ssh** 폴더에 복사하십시오.

1. 컨테이너에 대한 SSH 요청을 작성하십시오. 예: `mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. 로그 파일 위치를 아카이브하십시오. 예:

```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

로그 아카이브를 로컬 워크스테이션에 다운로드하십시오. 예:

```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
