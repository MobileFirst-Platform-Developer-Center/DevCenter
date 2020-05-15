---
layout: tutorial
title: 템플리트
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 템플리트 사용
{: #dab-templates }

템플리트를 사용하여 애플리케이션을 빠르게 빌드할 수 있습니다. 이는 앱을 빠르게 수정하고 개발하도록 돕는 특정 기능 사용 앱 템플리트입니다.

기본적으로 Digital App Builder는 두 개의 템플리트(모조 리조트 및 탭)와 함께 제공됩니다.

* **모드 리조트**: 이 템플리트는 리조트 앱의 유스 케이스가 있는 샘플 앱을 제공합니다. 여기에는 로그인 모듈, 대화 모듈, 인앱 피드백 모듈이 우선적으로 포함됩니다. 로그인 어댑터를 배치하고 자체 챗봇 인증 정보를 구성해야 합니다.
* **탭**: 이 템플리트는 맨 아래에 탭을 제공하는 탭 모바일 앱 인터페이스를 제공합니다. 이 템플리트에는 로그인 모듈도 포함됩니다.

### 사용자 정의 템플리트 작성
{: #create-custom-template }

기본 템플리트는 다음 위치에 저장됩니다.
* MacOS: `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
모드 리조트와 같은 기본 템플리트 중 하나를 복제하고 편집하여 사용자 정의 템플리트를 작성하십시오.
복사된 템플리트에 필요한 변경사항을 사용자 정의하고 폴더를 zip으로 압축하십시오.
`\ionic_templates\` 아래에 작성한 사용자 정의 템플리트에 대한 폴더를 작성하고 .zip 파일을 새 폴더로 복사하십시오.
\ionic_templates\ 폴더의 templates.json 파일을 편집하여 템플리트를 추가하기 위한 새 항목을 추가하십시오.
예를 들어, 아래 표시된 대로 새 사용자 정의 템플리트를 추가할 수 있습니다.

```json
{
    "version": 12,
    "templates": [
        {
            "name": "Mod Resorts",
            "icon": "modresorts/modresortslogo.png",
            "templateFile": "modresorts/modresorts.zip"
        },
        {
            "name": "Tabs",
            "icon": "tabs/tabs.png",
            "templateFile": "tabs/tabs.zip"
        }
       {
            "name": "MyCustomTemplate",
            "icon": "mytemplate/customtemplate.png",
            "templateFile": "mytemplate/customtemplate.zip"
        }
     ]
}
```
>**주의**
>* `version` 번호를 증가시켜야 합니다.
>* 릴리스 팀에서 템플리트를 추가한 경우 업데이트 시 `\ionic_templates\` 폴더가 대체됩니다. 따라서 사용자 정의 템플리트 폴더를 백업하고 업데이트 후 다시 적용해야 합니다.
