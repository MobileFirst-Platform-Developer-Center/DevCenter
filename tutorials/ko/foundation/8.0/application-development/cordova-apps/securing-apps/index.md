---
layout: tutorial
title: Cordova 애플리케이션 보안
breadcrumb_title: 애플리케이션 보안
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Cordova 패키지 웹 자원 암호화
{: #encrypting-the-web-resources-of-your-cordova-packages }
웹 자원이 .apk 또는 .ipa 패키지에 포함된 경우 {{ site.data.keys.mf_cli }} `mfpdev app webencrypt` 명령 또는 `mfpwebencrypt` 플래그로 정보를 암호화하여 다른 사용자가 해당 웹 자원을 보거나 수정할 위험성을 최소화할 수 있습니다. 이 프로시저에서는 해독 불가능한 암호화를 제공하지는 않지만 기본적인 수준의 난독화를 제공합니다. 

**전제조건:**

* Cordova 개발 도구가 설치되어 있어야 합니다. 이 예제에서는 Apache Cordova CLI를 사용합니다. 다른 Cordova 개발 도구를 사용하는 경우 일부 단계가 다릅니다. 지시사항은 Cordova 도구 문서를 참조하십시오. 
* {{ site.data.keys.mf_cli }}가 설치되어 있어야 합니다. 
* { site.data.keys.product_adj }} Cordova 플러그인이 설치되어 있어야 합니다. 

앱 개발을 완료한 후 앱을 배치할 준비가 되었을 때 이 프로시저를 완료하는 것이 가장 좋습니다. 웹 자원 암호화 프로시저를 완료한 후에 다음 명령을 실행하면 암호화된 컨텐츠가 복호화됩니다. 

* cordova prepare
* cordova build
* cordova run
* cordova emulate
* mfpdev app webupdate
* mfpdev app preview

웹 자원을 암호화한 후에 나열된 명령 중 하나를 실행하는 경우 웹 자원을 암호화하려면 이 프로시저를 다시 완료해야 합니다. 

1. 터미널 창을 열고 암호화할 Cordova 앱의 루트 디렉토리로 이동하십시오. 
2. 다음 명령 중 하나를 입력하여 앱을 준비하십시오. 
    - cordova prepare
    - mfpdev app webupdate
3. 다음 프로시저 중 하나를 완료하여 컨텐츠를 암호화하십시오. 
    - `mfpdev app webencrypt` 명령을 입력하십시오. **팁:** `mfpdev help app webencrypt`를 입력하여 `mfpdev app webencrypt` 명령에 대한 정보를 볼 수 있습니다. 
    - 패키지 빌드 시에 `cordova compile` 또는 `cordova build` 명령에 `mfpwebencrypt` 플래그를 추가하여 Cordova 패키지의 웹 자원을 암호화할 수도 있습니다. 
        - `cordova compile -- --mfpwebencrypt` | `cordova build -- --mfpwebencrypt`
    <br/>
    **www** 폴더의 운영 체제 정보는 암호화된 컨텐츠를 포함하는 **resources.zip** 파일로 대체됩니다.   
Android 운영 체제용 앱이고 **resources.zip** 파일 크기가 1MB를 초과하는 경우 **resources.zip** 파일은 이름이 **resources.zip.nnn**이고 크기가 768KB로 줄어든 여러 개의 .zip 파일로 분할됩니다. nnn 변수는 001에서 999 사이의 숫자입니다. 
4. 플랫폼별 도구와 함께 제공되는 에뮬레이터를 사용하여 암호화된 자원이 있는 애플리케이션을 테스트합니다. 예를 들어 Android에는 Android Studio를 사용하고 iOS에는 Xcode를 사용할 수 있습니다. 

**참고:** 암호화되어 있는 애플리케이션을 테스트하는 경우 다음 Cordova 명령을 사용하지 마십시오. 

* `cordova run`
* `cordova emulate`

이러한 명령은 WWW 폴더 내의 암호화된 컨텐츠를 새로 고치고 복호화된 컨텐츠로 다시 저장합니다. 이러한 명령을 사용하는 경우 앱을 공개하기 전에 앱을 암호화하는 프로시저를 다시 완료해야 합니다. 

### 웹 자원 체크섬 기능 사용
{: #enabling-the-web-resources-checksum-feature }
웹 자원 체크섬 기능을 사용하면 앱 시작 시에 앱의 원래 웹 자원을 앱이 처음 시작될 때 캡처된 저장된 기준선과 비교합니다. 이는 앱이 수정되었음을 나타낼 수 있는 차이점을 앱에서 식별하는 좋은 방법입니다. 이 프로시저는 직접 업데이트 기능과 호환 가능합니다. 

**전제조건:**

* Cordova 개발 도구가 설치되어 있어야 합니다. 이 예제에서는 Apache Cordova CLI를 사용합니다. 다른 Cordova 개발 도구를 사용하는 경우 일부 단계가 다릅니다. 지시사항은 Cordova 도구 문서를 참조하십시오. 
* {{ site.data.keys.mf_cli }}가 설치되어 있어야 합니다.  
* { site.data.keys.product_adj }} 플러그인이 설치되어 있어야 합니다. 
* 운영 체제에 웹 자원 체크섬 기능을 사용할 수 있으려면 먼저 `cordova platform add [android|ios|windows|browser]` 명령을 입력하여 Cordova 프로젝트에 해당 플랫폼을 추가해야 합니다. 

Cordova 앱에 웹 자원 체크섬 기능을 사용하려면 다음 단계를 완료하십시오. 

1. 터미널 창에서 대상 앱의 루트 디렉토리로 이동하십시오. 
2. 다음 명령을 입력하여 Cordova 앱의 운영 체제 환경에 웹 자원 체크섬 기능을 사용하도록 설정하십시오. 

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_test_web_resources_checksum true
   ```

   예:   
    
   ```bash
   mfpdev app config android_security_test_web_resources_checksum true
   ```

   명령에서 **true**를 **false**로 바꾸면 기능을 사용 안함으로 설정할 수 있습니다. 
   
   > **팁:** `mfpdev help app config`를 입력하여 `mfpdev app config` 명령에 대한 정보를 볼 수 있습니다. 
    
3. 다음 명령을 입력하여 체크섬 테스트 중에 무시할 파일 유형을 식별하십시오. 

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_ignore_file_extensions [ file_extension1,file_extension2 ]
   ```
    
   확장자가 여러 개인 경우 공백 없이 쉼표로 구분해야 합니다. 예: 
    
   ```bash
   mfpdev app config android_security_ignore_file_extensions jpg,png,pdf
   ```
    
**중요:** 이 명령을 실행하면 설정된 값을 겹쳐씁니다. 

테스트 시 웹 자원 체크섬이 스캔하는 파일 수가 많을수록 앱을 여는 데 걸리는 시간이 길어집니다. 건너뛸 파일 유형의 확장자를 지정하여 앱이 시작되는 속도를 빠르게 할 수 있습니다. 

앱에서 웹 자원 체크섬 기능을 사용하도록 설정되었습니다. 

1. `cordova prepare` 명령을 실행하여 앱에 변경사항을 통합하십시오. 
2. `cordova build` 명령을 입력하여 앱을 빌드하십시오. 
3. `cordova run` 명령을 입력하여 앱을 실행하십시오. 
