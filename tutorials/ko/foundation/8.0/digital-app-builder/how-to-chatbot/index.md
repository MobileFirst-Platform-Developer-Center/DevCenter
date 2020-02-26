---
layout: tutorial
title: 챗봇 추가
weight: 10
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Watson Chatbot
{: #dab-chatbot }

챗봇은 IBM Cloud에서 Watson Assistant 서비스에 의해 작동됩니다. IBM Cloud에서 Watson Assistant 인스턴스를 작성하십시오. 자세한 정보는 [여기](https://cloud.ibm.com/catalog/services/watson-assistant-formerly-conversation)를 참조하십시오.

구성된 후에는 새 **작업공간**을 작성할 수 있습니다. 작업공간은 챗봇을 구성하는 대화 세트입니다. 작업공간을 작성한 후 대화 상자 작성을 시작하십시오. 의도에 대한 질문 세트 및 해당 의도에 대한 응답 세트를 제공하십시오. Watson Assistant는 사용자가 제공한 샘플 질문을 기반으로 의도를 해석하기 위해 자연어 이해(Natural Language Understand)를 사용합니다. 그런 다음 사용자가 다양한 스타일로 하는 질문을 해석하고 의도에 맵핑되도록 할 수 있습니다.

앱에서 챗봇을 사용으로 설정하려면 다음 단계를 수행하십시오.

1. **Watson**을 클릭한 후 **챗봇**을 클릭하십시오. **Watson Assistant로 작업** 화면이 표시됩니다.

    ![Watson 챗봇](dab-watson-chat.png)

2. Watson Assistance 인스턴스에 **연결**을 클릭하십시오.

    ![Watson 챗봇 인스턴스](dab-watson-chat-instance.png)

3. **API 키** 세부사항을 입력하고 Watson Assistance 인스턴스의 **URL**을 지정하십시오. 
4. 챗봇에 **이름**을 제공하고 **연결**을 클릭하십시오. 지정된 **이름**의 대화 서비스 대시보드가 표시됩니다.

    ![Watson 챗봇 작업공간](dab-watson-chat-workspace.png)

5. **새 모델 작성** 팝업을 표시하는 **작업공간 추가**를 클릭하여 작업공간을 추가하십시오.

    ![Watson 챗봇 작업공간 새 모델](dab-watson-chat-new-model.png)

6. **작업공간 이름** 및 **작업공간 설명**을 입력하고 **작성**을 클릭하십시오. 이는 세 **대화** 작업공간(시작, 일치를 찾을 수 없음, 새 대화)을 작성합니다.

    ![Watson 챗봇 기본 대화](dab-watson-chat-conversations.png)

7. 새 챗봇 모델을 교육하려면 **새 대화**를 클릭하십시오. 

    ![Watson 챗봇 Q&A](dab-watson-chat-questions.png)

8. csv 파일로 또는 개별 질문 및 응답으로 응답 및 질문을 추가하십시오. 예를 들어, 사용자가 요청하는 경우에 대해 **사용자 설명을 추가**한 후 **봇에서 다음과 같이 응답해야 합니다.**에 대해 **봇 응답을 추가**하십시오. 또는 봇이 응답할 수 있는 질문 및 응답을 업로드할 수 있습니다.
9. **저장**을 클릭하십시오.
10. 챗봇을 테스트하려면 오른쪽 옆에 있는 단추의 챗봇 아이콘을 클릭하십시오.

    ![챗봇 테스트](dab-watson-chat-testing.png)
