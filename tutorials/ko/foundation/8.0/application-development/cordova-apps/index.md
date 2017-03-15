---
layout: tutorial
title: Cordova 애플리케이션에서 MobileFirst Foundation 개발
breadcrumb_title: Cordova 애플리케이션 개발
relevantTo: [cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
소스: [http://cordova.apache.org/](http://cordova.apache.org/)

> Apache Cordova는 개방형 소스 모바일 개발 프레임워크입니다. 이를 사용하여 각 모바일 플랫폼의 고유 개발 언어 대신 표준 웹 기술(예: HTML5, CSS3 및 JavaScript)을 크로스 플랫폼 개발에 사용할 수 있습니다. 애플리케이션은 각 플랫폼으로 대상 지정된 랩퍼 내에서 실행되며, 표준 준수 API 바인딩을 사용하여 각 디바이스의 센서, 데이터 및 네트워크 상태에 액세스합니다.

{{ site.data.keys.product_full }}은 여러 Cordova 플러그인 양식으로 SDK를 제공합니다. [Cordova 애플리케이션에 {{ site.data.keys.product }} SDK를 추가](../../application-development/sdk/cordova)하는 방법에 대해 알아보십시오. 

> **참고:** iOS 앱의 스토어 제출/유효성 검증 시 Test Flight 또는 iTunes Connect를 사용하여 생성된 아카이브/IPA 파일로 인해 런타임 충돌/실패가 발생할 수 있습니다. 자세히 알아보려면 [Preparing iOS apps for App Store submission in {{ site.data.keys.product_full }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/) 블로그를 읽으십시오.

#### 다음으로 이동:
{: #jump-to }

* [Cordova 애플리케이션 개발](#cordova-application-development)
* [{{ site.data.keys.product_adj }} API](#mobilefirst-apis)
* [{{ site.data.keys.product_adj }} SDK 시작 플로우](#mobilefirst-sdk-startup-flow)
* [Cordova 애플리케이션 보안](#cordova-application-security)
* [Cordova 애플리케이션 자원](#cordova-application-resources)
* [애플리케이션의 웹 자원 미리보기](#previewing-an-applications-web-resources)
* [JavaScript 코드 구현](#implementing-javascript-code)
* [Android에 대한 CrossWalk 지원](#crosswalk-support-for-android)
* [iOS에 대한 WKWebView 지원](#wkwebview-support-for-ios)
* [추가 참조](#further-reading)
* [다음 학습서](#tutorials-to-follow-next)

## Cordova 애플리케이션 개발
{: #cordova-application-development }
Cordova에서 제공하는 다음 개발 경로 및 기능을 사용하여 Cordova로 개발된 애플리케이션을 추가로 확장할 수 있습니다. 

### 후크
{: #hooks }
Cordova 후크는 개발자에게 Cordova 명령을 사용자 정의하는 기능을 제공하는 스크립트로, 예를 들어 사용자 정의 빌드 플로우를 작성할 수 있습니다.   
[Cordova 후크](http://cordova.apache.org/docs/en/dev/guide/appdev/hooks/index.html#Hooks%20Guide)에 대해 자세히 읽으십시오. 

### 병합
{: #merges }
병합 폴더는 플랫폼별 웹 자원(HTML, CSS 및 JavaScript 파일)을 포함하는 기능을 제공합니다. 이러한 웹 자원은 `cordova prepare` 단계 중에 적절한 고유 디렉토리에 배치됩니다. **merges/** 폴더 아래에 저장된 파일은 관련 플랫폼의 **www/** 폴더에 있는 해당 파일을 대체합니다. [병합 폴더](https://github.com/apache/cordova-cli#merges)에 대해 자세히 읽으십시오. 

### Cordova 플러그인
{: #cordova-plug-ins }
Cordova 플러그인을 사용하여 기본 UI 요소(대화 상자, tabBar, 스피너 등) 추가와 같은 향상된 기능과 맵핑 및 위치정보, 외부 컨텐츠 로드, 사용자 정의 키보드, 디바이스 통합(카메라, 렌즈, 센서 등)과 같은 추가 고급 기능을 제공할 수 있습니다. 

Cordova 플러그인은 [GitHub.com](https://github.com) 및 인기있는 Cordova 플러그인 웹 사이트(예: [Plugreg](http://plugreg.com/) 및 [NPM](http://npmjs.org))에서 확인할 수 있습니다. 

플러그인 예제:

- [cordova-plugin-dialogs](https://www.npmjs.com/package/cordova-plugin-dialogs)
- [cordova-plug-inprogress-indicator](https://www.npmjs.com/package/cordova-plugin-progress-indicator)
- [cordova-plugin-statusbar](https://www.npmjs.com/package/cordova-plugin-statusbar)

### 써드파티 프레임워크
{: #3rd-party-frameworks }
[Ionic](http://ionicframework.com/), [AngularJS](https://angularjs.org/), [jQuery Mobile](http://jquerymobile.com/), [Backbone](http://backbonejs.org/) 및 기타 여러 프레임워크를 사용하여 Cordova 애플리케이션 개발을 보다 확장할 수 있습니다. 

**통합 블로그 게시물**

* [Best Practices for building AngularJS apps with MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/08/11/best-practices-for-building-angularjs-apps-with-mobilefirst-foundation-8.0/)
* [Ionic 기반 앱에 {{ site.data.keys.product }} 통합]({{site.baseurl}}/blog/2016/07/19/integrating-mobilefirst-foundation-8-in-ionic-based-apps/)
* [Ionic 2 기반 앱에 {{ site.data.keys.product }} 통합]({{site.baseurl}}/blog/2016/10/17/integrating-mobilefirst-foundation-8-in-ionic2-based-apps/)

### 써드파티 패키지
{: #3rd-party-packages }
써드파티 패키지로 애플리케이션을 수정하여 애플리케이션 웹 자원 축소 및 병합 등과 같은 요구사항을 충족할 수 있습니다. 이를 수행하는 데 자주 사용되는 패키지는 다음과 같습니다. 

- [uglify-js](https://www.npmjs.com/package/uglify-js)
- [clean-css](https://www.npmjs.com/package/clean-css)

## {{ site.data.keys.product_adj }} API
{: #mobilefirst-apis }
Cordova 애플리케이션에 [{{ site.data.keys.product_adj }} Cordova SDK를 추가](../../application-development/sdk/cordova)하면 {{ site.data.keys.product_adj }} API 메소드 세트를 사용할 수 있습니다. 

> 사용 가능한 API 메소드의 전체 목록은 [API 참조서](../../api)를 참조하십시오. 

## {{ site.data.keys.product_adj }} SDK 시작 플로우
{: #mobilefirst-sdk-startup-flow }
<div class="panel-group accordion" id="startup-flows" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>Android 시작 플로우</b></a>
            </h4>
        </div>

        <div id="collapse-android-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-flow">
            <div class="panel-body">
                <p>Android Studio에서 {{ site.data.keys.product_adj }}를 사용하여 Android용 Cordova 앱의 시작 프로세스를 검토할 수 있습니다. {{ site.data.keys.product_adj }} Cordova 플러그인 <b>cordova-plugin-mfp</b>는 고유 비동기 부트스트랩 시퀀스를 사용합니다. 이 부트스트랩 시퀀스는 Cordova 애플리케이션이 애플리케이션의 기본 HTML 파일을 로드하기 전에 완료되어야 합니다. </p>
                
                <p><b>cordova-plugin-mfp</b> 플러그인을 Cordova 애플리케이션에 추가하면 {{ site.data.keys.product_adj }} 초기화를 수행하기 위해 애플리케이션의 <b>AndroidManifest.xml</b> 파일 및 <code>MainActivity</code> 파일(<code>CordovaActivity</code>를 확장함) 고유 코드가 인스트루먼테이션됩니다. </p>
        
                <p>애플리케이션 고유 코드 인스트루먼테이션은 다음과 같이 구성됩니다. </p>
                <ul>
                    <li>{{ site.data.keys.product_adj }} 초기화를 수행하는 <code>com.worklight.androidgap.api.WL</code> API 호출을 추가합니다. </li>
                    <li><b>AndroidManifest.xml</b> 파일에서 다음 사항을 추가합니다.
                        <ul>
                            <li><b>cordova-plugin-crosswalk-webview</b>가 설치된 경우 {{ site.data.keys.product_adj }} 초기화가 올바르게 수행되도록 하는 <code>MFPLoadUrlActivity</code> 활동 추가</li>
                            <li><code>application</code> 요소에 사용자 정의 속성 <b>android:name="com.ibm.MFPApplication</b>" 추가(아래 참조)</li>
                        </ul>
                    </li>
                </ul>
                
                <h3>WLInitWebFrameworkListener 구현 및 WL 오브젝트 작성</h3>
                <p><b>MainActivity.java</b> 파일은 초기 <code>MainActivity</code> 클래스를 작성하여 <code>CordovaActivity</code> 클래스를 확장합니다. {{ site.data.keys.product_adj }} 프레임워크가 초기화되는 경우 <code>WLInitWebFrameworkListener</code>에서 알림을 수신합니다. </p>
                
{% highlight java %}
public class MainActivity extends CordovaActivity implements WLInitWebFrameworkListener {
{% endhighlight %}

                <p><code>MFPApplication</code> 클래스는 <code>onCreate</code>에서 호출되어 앱 전체에서 사용되는 {{ site.data.keys.product_adj }} 클라이언트 인스턴스(<code>com.worklight.androidgap.api.WL</code>)를 작성합니다. <code>onCreate</code> 메소드는 <b>WebView 프레임워크</b>를 초기화합니다. </p>
                
{% highlight java %}
@Overridepublic void onCreate(Bundle savedInstanceState){
super.onCreate(savedInstanceState);

if (!((MFPApplication)this.getApplication()).hasCordovaSplashscreen()) {
           WL.getInstance().showSplashScreen(this);
       } 
   init();
   WL.getInstance().initializeWebFramework(getApplicationContext(), this);
}
{% endhighlight %}

                <p><code>MFPApplication</code> 클래스에는 다음 두 가지 기능이 있습니다. </p>
                <ul>
                    <li>스플래시 화면이 있는 경우 해당 화면을 로드하는 <code>showSplashScreen</code> 메소드를 정의합니다. </li>
                    <li>분석을 사용하는 데 필요한 두 개의 리스너를 작성합니다. 필요하지 않은 경우 이러한 리스너를 제거할 수 있습니다. </li>
                </ul>
                
                <h3>WebView 로드</h3>
                <p><b>cordova-plugin-mfp</b> 플러그인은 <b>AndroidManifest.xml</b> 파일에 Crosswalks WebView를 초기화하는 데 필요한 활동을 추가합니다. </p>

{% highlight xml %}
<activity android:name="com.ibm.MFPLoadUrlActivity" />
{% endhighlight %}

                <p>이 활동은 Crosswalk WebView의 비동기 초기화가 다음과 같이 수행되는지 확인하는 데 사용됩니다. </p>
                
                <p>{{ site.data.keys.product_adj }} 프레임워크가 초기화되고 WebView에 로드될 준비가 된 후 <code>WLInitWebFrameworkResult</code>가 성공하면 <code>onInitWebFrameworkComplete</code>가 URL에 연결됩니다. </p>
                
{% highlight java %}
public void onInitWebFrameworkComplete(WLInitWebFrameworkResult result){
if (result.getStatusCode() == WLInitWebFrameworkResult.SUCCESS) {
super.loadUrl(WL.getInstance().getMainHtmlFilePath());
   } else {
      handleWebFrameworkInitFailure(result);
   }
}
{% endhighlight %}


            
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-flow" data-target="#collapse-android-flow" aria-expanded="false" aria-controls="collapse-android-flow"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>iOS 시작 플로우</b></a>
            </h4>
        </div>

        <div id="collapse-ios-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-flow">
            <div class="panel-body">
                <p>iOS 플랫폼에서 {{ site.data.keys.product_adj }} 프레임워크가 초기화되어 {{ site.data.keys.product_adj }}를 사용하여 Cordova 앱에 WebView를 표시합니다. </p>

                <b>main.m</b>
                <p><code>main.m</code> 파일에서 {{ site.data.keys.product_adj }} 플러그인은 기본 주 애플리케이션 <code>AppDelegate</code>를 <code>MFPAppDelegate</code>로 대체합니다. </p>

{% highlight objc %}
#import <UIKit/UIKit.h>
int main(int argc, char *argv[]) {
 @autoreleasepool
    {    
        int retVal = UIApplicationMain(argc, argv, nil, @"MFPAppDelegate");   
        return retVal; 
    }
}
{% endhighlight %}

                <b>MFPAppDelegate.m</b>
                <p><code>MFPAppDelegate.m</code> 파일은 플러그인 폴더에 있습니다. 이는 기본 Cordova <code>AppDelegate.m</code> 파일을 대체하고 보기 제어기에서 WebView를 로드하기 전에 {{ site.data.keys.product_adj }} 프레임워크를 초기화합니다. </p>

                <p><code>didFinishLaunchingWithOptions</code> 메소드는 프레임워크를 초기화합니다. </p>

{% highlight objc %}
[[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
{% endhighlight %}

                <p>초기화에 성공하면 <code>wlInitWebFrameworkDidCompleteWithResult</code>는 {{ site.data.keys.product_adj }} 프레임워크가 로드되었는지 확인하고 <code>wlInitDidCompleteSuccessfully</code>를 호출하며 데이터 수신에 필요한 리스너를 작성합니다. <code>wlInitDidCompleteSuccessfully</code>는 기본 <b>index.html</b> 페이지에 연결되는 <code>cordovaViewController</code>를 작성합니다. </p>

                <p>iOS Cordova 앱이 오류 없이 Xcode에 빌드되면 고유 플랫폼과 WebView에 기능을 추가할 수 있습니다. </p>
            
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-flow" data-target="#collapse-ios-flow" aria-expanded="false" aria-controls="collapse-ios-flow"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="windows-flow">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>Windows 시작 플로우</b></a>
            </h4>
        </div>

        <div id="collapse-windows-flow" class="panel-collapse collapse" role="tabpanel" aria-labelledby="windows-flow">
            <div class="panel-body">
                <p>{{ site.data.keys.product_adj }} Cordova 플러그인 <b>cordova-plugin-mfp</b>는 고유 비동기 부트스트랩 시퀀스를 사용합니다. 이 부트스트랩 시퀀스는 Cordova 애플리케이션이 애플리케이션의 기본 HTML 파일을 로드하기 전에 완료되어야 합니다. </p>

                <p>Cordova 애플리케이션에 <b>cordova-plugin-mfp</b> 플러그인을 추가하면 애플리케이션의 <b>appxmanifest</b> 파일에 <b>index.html</b> 파일이 추가됩니다. 이렇게 하면 <code>CordovaActivity</code> 고유 코드를 확장하여 {{ site.data.keys.product_adj }} 초기화를 수행합니다. </p>
            
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#windows-flow" data-target="#collapse-windows-flow" aria-expanded="false" aria-controls="collapse-windows-flow"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

## Cordova 애플리케이션 보안
{: #cordova-application-security }
{{ site.data.keys.product_full }}은 Cordova 앱을 보호하는 데 도움이 되는 보안 기능을 제공합니다. 

크로스 플랫폼 앱에 포함된 대부분의 컨텐츠는 기본 앱의 컨텐츠보다 쉽게 권한 없는 사용자에 의해 수정될 수 있습니다. 크로스 플랫폼 앱에 포함된 대부분의 공통 컨텐츠가 읽을 수 있는 형식으로 되어 있으므로 IBM MobileFirst Foundation에는 크로스 플랫폼 Cordova 앱에 보다 높은 수준의 보안을 제공할 수 있는 기능이 포함되어 있습니다.  

> [{{ site.data.keys.product_adj }} 보안 프레임워크](../../authentication-and-security)에 대해 자세히 알아보십시오. 

다음 기능을 사용하여 Cordova 앱의 보안을 강화하십시오. 

* [Cordova 패키지 웹 자원 암호화](securing-apps/#encrypting-the-web-resources-of-your-cordova-packages)  
    Cordova 앱의 www 폴더에 포함된 컨텐츠를 암호화하고 앱이 설치되고 처음 실행될 때 해당 컨텐츠를 복호화합니다. 이 암호화를 통해 앱이 패키지된 동안 다른 사용자가 해당 폴더의 컨텐츠를 보거나 수정하기 어렵게 합니다. 
* [웹 자원 체크섬 기능 사용](securing-apps/#enabling-the-web-resources-checksum-feature)  
    앱이 처음 시작될 때 수집된 기준선 체크섬 결과와 컨텐츠를 비교하여 앱 시작 시에 앱의 무결성을 확인합니다. 이 테스트를 통해 이미 설치된 앱이 수정되는 것을 방지할 수 있습니다. 
* [FIPS 140-2 사용](../../administering-apps/federal/#enabling-fips-140-2)  
    움직이지 않는 데이터 및 움직이는 데이터를 암호화하는 데 사용되는 암호화 알고리즘이 FIPS(Federal Information Processing Standards) 140-2 표준을 준수하는지 확인합니다. 
* [인증서 고정](../../authentication-and-security/certificate-pinning)  
    호스트를 예상 공개 키와 연관시켜서 중간자 공격을 방지할 수 있습니다. 

## Cordova 애플리케이션 자원
{: #cordova-application-resources }
특정 자원이 Cordova 애플리케이션의 일부로 필요합니다. 일반적으로 이러한 자원은 선호하는 Cordova 개발 도구를 사용하여 Cordova 앱을 작성할 때 생성됩니다. {{ site.data.keys.product }} 템플리트를 사용하는 경우 스플래시 화면과 아이콘도 제공됩니다. 

{{ site.data.keys.product_adj }} 기능을 사용할 수 있는 Cordova 프로젝트에 사용하도록 IBM에서 제공하는 프로젝트 템플리트를 사용할 수 있습니다. 이 {{ site.data.keys.product_adj }} 템플리트를 사용하는 경우 다음 자원을 시작점으로 사용할 수 있습니다. {{ site.data.keys.product_adj }} 템플리트를 사용하지 않는 경우에는 스플래시 화면과 아이콘을 제외한 모든 자원이 제공됩니다. Cordova 프로젝트를 처음 작성할 때 `--template` 옵션 및 {{ site.data.keys.product_adj }} 템플리트를 지정하여 템플리트를 추가할 수 있습니다. 

자원의 기본 파일 이름 및 경로를 변경하는 경우 Cordova 구성 파일(config.xml)에서도 해당 변경사항을 지정해야 합니다. 또한 일부 경우에 mfpdev app config 명령을 사용하여 기본 이름 및 경로를 변경할 수 있습니다. mfpdev app config 명령을 사용하여 이름과 경로를 변경할 수 있는 경우 특정 자원에 대한 섹션에 설명되어 있습니다. 

### Cordova 구성 파일(config.xml)
{: #cordova-configuration-file-configxml }
Cordova 구성 파일은 애플리케이션 메타 데이터를 포함하고 앱의 루트 디렉토리에 저장되는 필수 XML 파일입니다. 이 파일은 Cordova 애플리케이션 작성 시 자동으로 생성됩니다. mfpdev app config 명령으로 이 파일을 수정하여 사용자 정의 특성을 추가할 수 있습니다.  

### 기본 파일(index.html)
{: #main-file-indexhtml}
이 기본 파일은 애플리케이션 스켈레톤이 포함된 HTML5 파일입니다. 이 파일은 애플리케이션의 일반 컴포넌트를 정의하고 필수 문서 이벤트에 후크하는 데 필요한 모든 웹 자원(스크립트 및 스타일시트)을 로드합니다. 이 파일은 **your-project-name/www** 디렉토리에 있습니다. `mfpdev app config` 명령을 사용하여 이 파일의 이름을 변경할 수 있습니다. 

### 작은 그림 이미지
{: #thumbnail-image }
작은 그림 이미지를 사용하여 {{ site.data.keys.mf_console }}에서 애플리케이션을 그래픽으로 식별할 수 있습니다. 이는 사각형 이미지여야 하며, 90 × 90 픽셀 크기가 적당합니다.   
템플리트를 사용할 때 기본 작은 그림 이미지가 제공됩니다. 대체 이미지와 동일한 파일 이름을 사용하여 기본 이미지를 대체할 수 있습니다. **your-project-name/www/img** 폴더에서 thumbnail.png를 찾을 수 있습니다. `mfpdev app config` 명령을 사용하여 이 파일의 이름 또는 경로를 변경할 수 있습니다. 

### 스플래시 이미지
{: #splash-image }
애플리케이션이 초기화되는 동안 스플래시 이미지가 표시됩니다. {{ site.data.keys.product_adj }} 기본 템플리트를 사용하는 경우 스플래시 이미지가 제공됩니다. 이러한 기본 이미지는 다음 디렉토리에 저장됩니다. 

* iOS: <프로젝트 이름>/res/screen/ios/
* Android: <프로젝트 이름>/res/screen/android/
* Windows: <프로젝트 이름>/res/screen/windows/

여러 디스플레이, iOS 및 Windows. 여러 운영 체제 버전에 적절한 여러 기본 스플래시 이미지가 제공됩니다. 템플리트에서 제공되는 기본 이미지를 고유 스플래시 이미지로 대체하거나, 템플리트를 사용하지 않는 경우 이미지를 추가할 수 있습니다.  {{ site.data.keys.product_adj }} 템플리트를 사용하여 Android 플랫폼용 앱을 빌드할 때 **cordova-plugin-splashscreen** 플러그인이 설치됩니다. 이 플러그인이 통합되면 {{ site.data.keys.product }}에서 사용하는 이미지 대신 Cordova에서 사용하는 스플래시 이미지가 표시됩니다. screen.png 형식으로 된 폴더 내 이미지가 Cordova 표준 스플래시 이미지입니다. Cordova의 **config.xml** 파일에서 설정을 변경하여 표시되는 스플래시 이미지를 지정할 수 있습니다. 

{{ site.data.keys.product_adj }} 템플리트를 사용하지 않는 경우 기본적으로 표시되는 스플래시 이미지는 {{ site.data.keys.product }} 플러그인에서 사용하는 이미지입니다. 기본 {{ site.data.keys.product_adj }} 소스 스플래시 이미지의 파일 이름은 **splash-string.9.png** 양식으로 되어 있습니다. 

> 고유 스플래시 이미지 사용에 대한 자세한 정보는 [Cordova 앱에 사용자 정의 스플래시 화면 및 아이콘 추가](adding-images-and-icons)를 참조하십시오.

### 애플리케이션 아이콘
{: #application-icons }
템플리트에는 애플리케이션 아이콘의 기본 이미지가 제공됩니다. 이러한 기본 이미지는 다음 디렉토리에 저장됩니다. 

* iOS: <프로젝트 이름>/res/icon/ios/
* Android: <프로젝트 이름>/res/icon/android/
* Windows: <프로젝트 이름>/res/icon/windows/

기본 이미지를 사용자 고유 이미지로 대체할 수 있습니다. 사용자 정의 애플리케이션 이미지는 대체할 기본 애플리케이션 이미지의 크기와 일치해야 하며 동일한 파일 이름을 사용해야 합니다. 여러 디스플레이 및 운영 체제 버전에 적합한 다양한 기본 이미지가 제공됩니다. 

> 고유 스플래시 이미지 사용에 대한 자세한 정보는 [Cordova 앱에 사용자 정의 스플래시 화면 및 아이콘 추가](adding-images-and-icons)를 참조하십시오.

### 스타일시트
{: #stylesheets }
앱 코드에 애플리케이션 보기를 정의하는 CSS 파일을 포함시킬 수 있습니다. 

스타일시트 파일은 <프로젝트 이름>/www/css 디렉토리에 있으며, 다음 플랫폼별 폴더에 복사됩니다. 

* iOS: <프로젝트 이름>/platforms/ios/www/css
* Android: <프로젝트 이름>/platforms/android/assets/www/css
* Windows: <프로젝트 이름>/platforms/windows/www/css

### 스크립트
{: #scripts }
앱 코드에는 대화식 사용자 인터페이스 컴포넌트, 비즈니스 로직 및 백엔드 조회 통합과 같은 앱의 다양한 기능을 구현하는 JavaScript 파일이 포함될 수 있습니다. 

템플리트에서 제공하는 JavaScript 파일 index.js는 **your-project-name/www/js** 폴더에 있습니다. 이 파일은 다음 플랫폼별 폴더에 복사됩니다. 

* iOS: <프로젝트 이름>/platforms/ios/www/js
* Android: <프로젝트 이름>/platforms/android/assets/www/js
* Windows: <프로젝트 이름>/platforms/windows/assets/www/js

## 애플리케이션 웹 자원 미리보기
{: #previewing-an-applications-web-resources }
iOS 시뮬레이터, Android 에뮬레이터, Windows 에뮬레이터 또는 물리적 디바이스에서 Cordova 애플리케이션의 웹 자원을 미리 볼 수 있습니다. {{ site.data.keys.product }}에서는 두 개의 추가 실시간 미리보기 옵션인 {{ site.data.keys.mf_mbs_full }} 및 Simple Browser 렌더링을 사용할 수 있습니다. 

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **보안 제한사항:** 웹 자원을 미리 볼 수는 있지만 시뮬레이터에서는 일부 {{ site.data.keys.product_adj }} JavaScript API가 지원되지 않습니다. 특히 OAuth 프로토콜은 제한적으로 지원됩니다. 그러나 `WLResourceRequest`를 사용하여 어댑터에 대한 호출을 테스트할 수 있습니다. 이 경우
> 
> * 서버 측에서 보안 검사가 실행되지 않으며 {{ site.data.keys.mf_mbs }}에서 실행되는 클라이언트에 보안 인증 확인이 전송되지 않습니다.
> * 개발 환경에서 {{ site.data.keys.mf_server }}를 사용하지 않는 경우 허용되는 범위 목록에 어댑터의 범위가 포함되어 있는 기밀 클라이언트를 등록하십시오. {{ site.data.keys.mf_console }}에서 런타임/설정 메뉴를 사용하여 기밀 클라이언트를 정의할 수 있습니다. 기밀 클라이언트에 대한 자세한 정보는 [기밀 클라이언트](../../authentication-and-security/confidential-clients)를 참조하십시오.
> 
> **참고:** 개발 환경의 {{ site.data.keys.mf_server }}에는 허용 범위가 무제한("*")인 기밀 클라이언트 "테스트"가 포함되어 있습니다. 기본적으로 mfpdev app preview는 이 기밀 클라이언트를 사용합니다.

#### Simple Browser
{: #simple-browser }
Simple Browser 미리보기에서는 애플리케이션의 웹 자원이 "앱"으로 처리되지 않고 데스크탑 브라우저에서 렌더링되므로 웹 자원만 쉽게 디버깅할 수 있습니다.   

#### {{ site.data.keys.mf_mbs }}
{: #mobile-browser-simulator }
{{ site.data.keys.mf_mbs }}는 에뮬레이터 또는 물리적 디바이스에 앱을 설치할 필요 없이 디바이스 기능을 시뮬레이션하여 Cordova 애플리케이션을 테스트할 수 있는 웹 애플리케이션입니다. 

**지원되는 브라우저:**

* Firefox 버전 38 이상
* Chrome 49 이상
* Safari 9 이상

### 미리보기
{: #previewing }
1. **명령행** 창에서 다음 명령을 실행하십시오. 

    ```bash
    mfpdev app preview
    ```

2. 미리보기 옵션을 선택하십시오. 

    ```bash
    ? Select how to preview your app: (Use arrow keys)
    ❯ browser: Simple browser rendering
    mbs: Mobile Browser Simulator
    ```
3. 다음과 같이 미리 볼 플랫폼을 선택하십시오(추가된 플랫폼만 표시됨).

    ```bash
    ❯◯ android
    ◯ ios
	```

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **팁:** [CLI를 사용하여 {{ site.data.keys.product_adj }} 아티팩트 관리](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/) 학습서에서 여러 CLI 명령에 대해 자세히 알아보십시오.

### 실시간 미리보기
{: #live-preview }
이제 실시간 미리보기를 사용하여 애플리케이션 코드(HTML, CSS 및 JS)를 실시간으로 편집할 수 있습니다.    
자원을 변경한 후에 변경사항을 저장하면 브라우저에 즉시 반영됩니다. 

### 실시간 다시 로드
{: #live-reload }
물리적 디바이스 또는 시뮬레이터/에뮬레이터에서 미리 보는 동안 유사한 효과를 얻으려면 **cordova-plugin-livereload** 플러그인을 추가하십시오. 사용법 지시사항은 [플러그인 GitHub 페이지를 참조](https://github.com/omefire/cordova-plugin-livereload)하십시오. 

### 에뮬레이터 또는 물리적 디바이스에서 애플리케이션 실행
{: #running-the-application-on-emulator-or-on-a-physical-device }
애플리케이션을 에뮬레이트하려면 Cordova CLI 명령 `cordova emulate ios|android|windows`를 실행하십시오. 예: 

```bash
cordova emulate ios
```

개발 워크스테이션에 연결된 물리적 디바이스에서 애플리케이션을 실행하려면 Cordova CLI 명령 `cordova run ios|android|windows`를 실행하십시오. 예: 

```bash
cordova run ios
```

## JavaScript 코드 구현
{: #implementing-javascript-code }
JavaScript에 대한 자동 완성 기능을 제공하는 IDE를 사용하여 보다 편리하게 WebView 자원을 편집할 수 있습니다. 

Xcode, Android Studio 및 Visual Studio는 Objective C, Swift, C# 및 Java 편집에 사용되는 완전한 편집 기능을 제공하지만 JavaScript 편집을 지원하는 방법에 제한사항이 있을 수 있습니다. {{ site.data.keys.product_adj }} Cordova 프로젝트에는 {{ site.data.keys.product_adj }} API 요소에 대한 자동 완성 기능을 제공하는 정의 파일이 포함되어 JavaScript 편집을 용이하게 합니다. 

각 {{ site.data.keys.product_adj }} Cordova 플러그인에서는 각 {{ site.data.keys.product_adj }} JavaScript 파일에 대한 `d.ts` 구성 파일을 제공합니다. `d.ts` 파일 이름은 해당 JavaScript 파일 이름과 일치하며 플러그인 폴더 내에 있습니다. 예를 들어 기본 {{ site.data.keys.product_adj }} SDK의 경우 파일 위치는 **[myapp]\plugins\cordova-plugin-mfp\typings\worklight.d.ts**입니다. 

`d.ts` 구성 파일은 TypeScript가 지원되는 모든 IDE([TypeScript Playground](http://www.typescriptlang.org/Playground/), [Visual Studio Code](http://www.microsoft.com/visualstudio/eng), [WebStorm](http://www.jetbrains.com/webstorm/), [WebEssentials](http://visualstudiogallery.msdn.microsoft.com/6ed4c78f-a23e-49ad-b5fd-369af0c2107f), [Eclipse](https://github.com/palantir/eclipse-typescript))에 자동 완성 기능을 제공합니다. 

WebView의 자원(HTML 및 JavaScript 파일)은 **[myapp]\www** 폴더에 있습니다. cordova build 명령으로 프로젝트가 빌드되거나 cordova prepare 명령이 실행되면 이러한 자원은 **[myapp]\platforms\ios\www**, **[myapp]\platforms\android\assets\www** 또는 **[myapp]\platforms\windows\www** 폴더 내의 해당 **www** 폴더에 복사됩니다. 

이전 IDE 중 하나를 사용하여 기본 앱 폴더를 여는 경우 컨텍스트가 유지됩니다. 이제 IDE 편집기가 관련 `d.ts` 파일에 링크되어 입력 시 {{ site.data.keys.product_adj }} API 요소를 자동 완성합니다. 

## Android에 대한 CrossWalk 지원
{: #crosswalk-support-for-android }
Android 플랫폼용 Cordova 애플리케이션은 기본 WebView를 [CrossWalk WebView](https://crosswalk-project.org/)로 대체할 수 있습니다.   
이를 추가하려면 다음을 수행하십시오. 

1. **명령행**에서 다음 명령을 실행하십시오. 

   ```bash
   cordova plugin add cordova-plugin-crosswalk-webview
   ```

   이 명령은 애플리케이션에 CrossWalk WebView를 추가합니다.   
    백그라운드에서 {{ site.data.keys.product_adj }} Cordova SDK는 CrossWalk WebView를 사용하도록 Android 프로젝트 활동을 조정합니다.

2. 다음 명령을 실행하여 프로젝트를 빌드하십시오. 

   ```bash
   cordova build
   ```

## iOS에 대한 WKWebView 지원
{: #wkwebview-support-for-ios }
Cordova iOS 애플리케이션에서 사용되는 기본 UIWebView를 [Apple의 WKWebView](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/)로 대체할 수 있습니다.   
추가하려면 명령행 창에서 `cordova plugin add cordova-plugin-wkwebview-engine` 명령을 실행하십시오. 

> [Cordova WKWebView 플러그인](https://github.com/apache/cordova-plugin-wkwebview-engine)에 대해 자세히 알아보십시오. 

## 추가 참조
{: #further-reading }
다음 항목에서 Cordova에 대해 자세히 알아보십시오. 

- [Cordova 개요](https://cordova.apache.org/docs/en/latest/guide/overview/index.html)
- [Cordova 우수 사례, 테스트, 디버깅, 고려사항 및 최신 상태 유지](https://cordova.apache.org/docs/en/latest/guide/next/index.html#link-testing-on-a-simulator-vs-on-a-real-device)
- [Cordova 애플리케이션 개발 시작하기](https://cordova.apache.org/#getstarted)

## 다음 학습서
{: #tutorials-to-follow-next }
[모든 학습서](../../all-tutorials/) 섹션의 [Cordova 애플리케이션에 MobileFirst SDK 추가](../../application-development/sdk/cordova)에서 시작하고 {{ site.data.keys.product_adj }}에서 제공하는 기능을 검토하십시오. 
