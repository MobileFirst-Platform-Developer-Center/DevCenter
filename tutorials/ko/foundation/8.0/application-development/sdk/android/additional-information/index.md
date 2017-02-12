---
layout: tutorial
title: 추가 정보
breadcrumb_title: 추가 정보
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Android Studio Gradle 프로젝트에 Javadoc 등록
{: #registering-javadocs-to-an-android-studio-gradle-project }
{{ site.data.keys.product_adj }} Android Javadoc은 Gradle로 가져온 *.aar 파일에 포함되어 있습니다. 그러나 해당 Javadoc을 Android Studio의 관련 라이브러리에 링크해야 합니다. 

1. Android Studio에서 **프로젝트** 보기에 있는지 확인하십시오. 
2. **외부 라이브러리** 노드 아래에서 라이브러리 이름을 찾으십시오(Javadoc 파일이 아래에 표시됨). 
3. 라이브러리 이름을 마우스 오른쪽 단추로 클릭하고 **라이브러리 특성**을 선택하십시오. 
4. 라이브러리 특성 대화 상자에서 "+" 단추를 선택하십시오. 
5. **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** 아래에서 다운로드된 Javadoc JAR 파일(**ibmmobilefirstplatformfoundation-javadoc.jar**)로 이동하고 선택하십시오. 
6. **확인**을 클릭하십시오. 이제 프로젝트 내에서 Javadoc을 사용할 수 있습니다. 

### 참고
{: #notes }

* {{ site.data.keys.product_adj }} API는 Android 서비스 내에서 활성화될 수 없습니다. 
