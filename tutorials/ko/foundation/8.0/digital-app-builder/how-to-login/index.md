---
layout: tutorial
title: 로그인 양식 추가
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 로그인 양식 추가
{: #dab-login-form }

### 디자인 모드에서 앱에 로그인 양식 추가
{: #add-login-form-design-mode }

앱에서 로그인 양식을 추가하려면 다음 단계를 수행하십시오.

1. Mobile Foundation 서버에서 다음 변경사항을 작성하십시오.
    * 사용자 이름 및 비밀번호를 입력하도록 하는 보안 검사 어댑터를 배치하십시오. [여기](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)에서 샘플 어댑터를 사용할 수 있습니다.
    * Mobile Foundation Operation 콘솔에서 앱의 보안 탭으로 이동하고 필수 애플리케이션 범위 아래에서 위의 작성된 보안 정의를 범위 요소로 추가하십시오.
2. 빌더를 사용하여 앱에서 다음 구성을 작성하십시오.
    * 캔버스에서 페이지에 **로그인 양식** 제어를 추가하십시오.
    * **특성** 탭에서 **보안 검사 이름** 및 페이지를 제공하여 **로그인 성공 시**로 이동하십시오.
    * 앱을 실행하십시오.
