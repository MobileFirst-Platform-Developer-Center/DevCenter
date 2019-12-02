---
layout: tutorial
title: Mock ReST API 사용
weight: 13
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Mock API
{: #dab-mock-api }

모바일 앱의 개발 중에는 일반적으로 데이터 페치가 필요한 실제 백엔드를 모바일 개발자가 바로 사용할 수 없습니다. 이 경우에 실제 백엔드와 동일한 데이터를 리턴하는 Mock 서버가 사용 가능하면 유용할 수 있습니다. Digital App Builder의 Mock API 기능은 이 경우에 도움이 됩니다. 모바일 앱 개발자는 단지 JSON 데이터를 제공하여 손쉽게 서버 Mocking을 수행할 수 있습니다.

>**참고**: 이 기능은 코드 모드에서만 사용 가능합니다.

백엔드 REST 서비스 Mocking을 수행하는 API를 작성 및 관리하려면 다음을 수행하십시오.

1. 코드 모드에서 앱 프로젝트를 여십시오. 
2. **API**를 선택하십시오. **API 추가**를 선택하십시오.
    ![Mock API](dab-mock-api.png)

3. 열리는 창에서 API의 이름을 입력하고 **추가**를 클릭하십시오.
    ![Mock API 추가](dab-new-mock-api.png)

4. 그러면 자동 생성된 URL의 작성된 API가 표시됩니다.
    ![Mock API jason](dab-new-mock-api-jason.png)

5. **편집**을 클릭하십시오. 이 API의 호출 시에 리턴할 데이터를 제공하고 **저장**을 클릭하십시오. 예를 들면, 다음과 같습니다. 

    ```
    [
      {
        "firstName": "John",
        "lastName": "Doe",
        "title": "Director of Marketing",
        "office": "D531"
      },
      {
        "firstName": "Don",
        "lastName": "Joe",
        "title": "Vice President,Sales",
        "office": "B2600"
      }
    ]
    ```

    ![Mock API jason 샘플](dab-exp-moc-api.png)

>**참고**: API를 빠르게 테스트하려면 **지금 시도**를 클릭하십시오. 그러면 API를 테스트할 수 있는 기본 브라우저에서 Swagger 문서가 열립니다.

### 앱에서 Mock API 이용
{: #dab-mock-api-consuming }

1. 코드 모드에서, **MOBILE CORE** 섹션으로부터 **API 호출** 코드 스니펫을 끌어서 놓으십시오.
2. 코드를 편집하여 URL을 수정하고 Mock API 엔드포인트를 지시하도록 하십시오. 예를 들면, 다음과 같습니다.

    ```
     var resourceRequest = new WLResourceRequest(
         "/adapters/APIProject/api/entity4",
         WLResourceRequest.GET,
         { "useAPIProxy": false }
     );
     resourceRequest.send().then(
         function(response) {
             alert("Success: " + response.responseText);
         },
         function(response) {
             alert("Failure: " + JSON.stringify(response));
         }
     );
    ```
 
