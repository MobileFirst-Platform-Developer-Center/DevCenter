---
layout: tutorial
title: JavaScript(Cordova, 웹) 애플리케이션의 다국어 변환
breadcrumb_title: 다국어 변환
relevantTo: [javascript]
weight: 9
downloads:
  - 이름: Cordova 프로젝트 다운로드
    URL: https://github.com/MobileFirst-Platform-Developer-Center/Translation/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
{{ site.data.keys.product_full }} 프레임워크를 사용하여 JavaScript(Cordova, 웹) 애플리케이션에서 다른 언어로의 다국어 변환을 추가할 수 있습니다.   
변환될 수 있는 항목은 애플리케이션 문자열과 시스템 메시지입니다.  

#### 다음으로 이동:
{: #jump-to }
* [애플리케이션 문자열 변환](#translating-application-strings)
* [시스템 메시지 변환](#translating-system-messages)
* [다국어 변환](#multilanguage-translation)
* [디바이스 로케일 및 언어 발견](#detecting-the-device-locale-and-language)
* [샘플 애플리케이션](#sample-application)

## 애플리케이션 문자열 변환
{: #translating-application-strings }
변환될 예정인 문자열은 "메시지"라는 `JSON` 오브젝트에 저장됩니다.  

- {{ site.data.keys.product_adj }} SDK를 사용하는 Cordova 애플리케이션에서는 Cordova 애플리케이션의 **index.js** 파일(**[cordova-project-root-directory]/www/js/index.js**)에 있습니다. 
- 웹 애플리케이션에서는 이를 추가해야 합니다. 

### JSON 오브젝트 구조 예제
{: #json-object-structure-example }

```javascript
var Messages = {
    headerText: "Default header",
    actionsLabel: "Default action label",
    sampleText: "Default sample text",
};
```

메시지 `JSON` 오브젝트에 저장된 문자열은 애플리케이션 로직에서 다음 두 가지 방법으로 참조될 수 있습니다. 

**JavaScript 오브젝트 특성으로:**

```javascript
Messages.headerText
```

**클래스가 "translate"인 HTML 요소의 ID로:**

```html
<h1 id="headerText" class="translate"></h1>
```

## 시스템 메시지 변환
{: #translating-system-messages }
애플리케이션에서 표시하는 시스템 메시지(예: "인터넷 연결을 사용할 수 없음" 또는 "잘못된 사용자 이름 또는 비밀번호")를 변환할 수도 있습니다. 시스템 메시지는 `WL.ClientMessages` 오브젝트에 저장되어 있습니다. 

**참고:** 코드의 일부 파트는 애플리케이션이 올바르게 초기화된 후에만 실행되므로 글로벌 JavaScript 레벨에서 시스템 메시지를 대체하십시오. 

### 웹 애플리케이션
{: #web-applications }
전체 시스템 메시지 목록은 **[project root folder]\node_modules\ibm-mfp-web-sdk\lib\messages\ folder**의 `messages.json` 파일에 있습니다. 

### Cordova 애플리케이션
{: #cordova-applications }
전체 시스템 메시지 목록은 생성된 프로젝트 내의 `messages.json` 파일에 있습니다. 

- Android: `[Cordova-project]\platforms\android\assets\www\plugins\cordova-plugin-mfp\worklight\messages`
- iOS, Windows: `[Cordova-project]\platforms\[ios or windows]\www\plugins\cordova-plugin-mfp\worklight\messages`

시스템 메시지를 변환하려면 애플리케이션 코드에서 대체하십시오. 

```javascript
WL.ClienMessages.loading = "Application HelloWorld is loading... please wait.";
```

## 다국어 변환
{: #multilanguage-translation }
JavaScript를 사용하여 애플리케이션에 대해 다국어 변환을 구현할 수 있습니다.   
아래 단계에서는 이 학습서의 샘플 애플리케이션 구현에 대해 설명합니다. 

1. `index.js` 파일에서 기본 애플리케이션 문자열을 설정하십시오. 

   ```javascript
   var Messages = {
        headerText: "Default header",
        actionsLabel: "Default action label",
        sampleText: "Default sample text",
        englishLanguage: "English",
        frenchLanguage: "French",
        russianLanguage: "Russian",
        hebrewLanguage: "Hebrew"
   };
   ```

2. 필요한 경우 특정 문자열을 대체하십시오. 

   ```javascript
   function setFrench(){
        Messages.headerText = "Traduction";
        Messages.actionsLabel = "Sélectionnez une langue:";
        Messages.sampleText = "Ceci est un exemple de texte en français.";
   }
   ```

3. 새 문자열로 GUI 컴포넌트를 업데이트하십시오. 히브리어 또는 아랍어와 같이 오른쪽에서 왼쪽으로 쓰는 언어에 대해 텍스트 방향을 설정하는 것과 같은 추가 태스크를 수행할 수 있습니다. 요소가 업데이트될 때마다 활성 언어에 따라 다른 문자열로 업데이트됩니다. 

   ```javascript
   function languageChanged(lang) {
        if (typeof(lang)!="string") 
            lang = $("#languages").val();
        
        switch (lang) {
            case "english":
                setEnglish();
                break;
            case "french":
                setFrench();
                break;
            case "russian":
                setRussian();
                break;
            case "hebrew":
                setHebrew();
                break;
        }
               
        if ($("#languages").val()=="hebrew")
            $("#wrapper").css({direction: 'rtl'});
        else
            $("#wrapper").css({direction: 'ltr'});
      
        $("#sampleText").html(Messages.sampleText);
        $("#headerText").html(Messages.headerText);
        $("#actionsLabel").html(Messages.actionsLabel);
   }
   ```

## 디바이스 로케일 및 언어 발견
{: #detecting-the-device-locale-and-language }
디바이스 또는 브라우저에서 사용되는 언어를 발견하려면 다음을 수행하십시오. 

### 웹 애플리케이션
{: #web-applications-locale}
`navigator.language` 또는 사용 가능한 프레임워크 및 솔루션을 사용하여 브라우저 언어를 발견하십시오. 

### Cordova 애플리케이션
{: #cordova-applications-locale }
Cordova의 다국어 지원 플러그인 `cordova-plugin-globalization`을 사용하여 디바이스의 로케일 및 언어를 발견하십시오.   
다국어 지원 플러그인은 Cordova 애플리케이션에 플랫폼을 추가할 때 자동으로 설치됩니다. 

로케일 및 언어를 발견하려면 `navigator.globalization.getLocaleName` 및 `navigator.globalization.getPreferredLanguage` 함수를 각각 사용하십시오. 

```javascript
navigator.globalization.getLocaleName(
	function (localeValue) {
		WL.Logger.debug(">> Detected locale: " + localeValue);
		
        ...
        ...
        ...
	},
	function() {
		WL.Logger.debug(">> Unable to detect locale.");
	}
);

navigator.globalization.getPreferredLanguage(
	function (langValue) {
		lang = langValue.value;
		WL.Logger.debug(">> Detected language: " + lang);
	},
	function() {
		WL.Logger.debug(">> Unable to detect language.");
	}
);
```

결과가 디바이스 로그(예: Android Studio의 LogCat)에 표시됩니다.   
![디바이스 로케일 및 언어 가져오기](DeviceLocaleLangugae.png)

## 샘플 애플리케이션
{: #sample-application }
Cordova 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/Translation)하십시오.   

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오. 

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** 애플리케이션이 실행되는 동안 Android Studio의 LogCat 콘솔에서 Android LogCat을 검사할 수 있습니다.
