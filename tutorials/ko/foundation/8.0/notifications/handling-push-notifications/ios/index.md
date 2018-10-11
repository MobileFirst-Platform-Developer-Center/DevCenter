---
layout: tutorial
title: iOS에서 푸시 알림 처리
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }
디바이스를 등록 및 등록 취소하고 태그에 등록 및 등록 취소하기 위해 {{ site.data.keys.product_adj }} 제공 알림 API를 사용할 수 있습니다. 이 학습서에서는 Swift를 사용하여 iOS 애플리케이션에서 푸시 알림을 처리하는 방법에 대해 학습합니다.

자동 또는 대화식 알림에 대한 정보는 다음을 참조하십시오.

* [자동 알림](../silent)
* [대화식 알림](../interactive)

**전제조건:**

* 다음과 같은 학습서를 읽어야 합니다.
	* [푸시 알림 개요](../../)
    * [{{ site.data.keys.product_adj }} 개발 환경 설정](../../../installation-configuration/#installing-a-development-environment)
    * [iOS 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/ios)
* {{ site.data.keys.mf_server }}가 로컬로 실행되거나 {{ site.data.keys.mf_server }}가 원격으로 실행 중입니다.
* {{ site.data.keys.mf_cli }}가 개발자 워크스테이션에 설치되어 있습니다.


### 다음으로 이동:
{: #jump-to }
* [알림 구성](#notifications-configuration)
* [알림 API](#notifications-api)
* [푸시 알림 처리](#handling-a-push-notification)


### 알림 구성
{: #notifications-configuration }
새 Xcode 프로젝트를 작성하거나 기존 프로젝트를 사용하십시오.
{{ site.data.keys.product_adj }} 네이티브 iOS SDK가 아직 프로젝트에 없는 경우 [iOS 애플리케이션에 {{ site.data.keys.product }} SDK 추가](../../../application-development/sdk/ios) 학습서의 지시사항을 따르십시오.


### 푸시 SDK 추가
{: #adding-the-push-sdk }
1. 프로젝트의 기존 **podfile**을 열고 다음 행을 추가하십시오.

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - **Xcode-project-target**을 Xcode 프로젝트의 대상 이름으로 대체하십시오.

2. **podfile**을 저장한 후 닫으십시오.
3. **명령행** 창에서 프로젝트의 루트 폴더로 이동하십시오.
4. `pod install` 명령을 실행하십시오.
5. **.xcworkspace** 파일을 사용하여 프로젝트를 여십시오.

## 알림 API
{: #notifications-api }
### MFPPush 인스턴스
{: #mfppush-instance }
모든 API 호출은 `MFPPush`의 인스턴스에서 호출되어야 합니다.  이는 보기 제어기에서 `var`을 사용한 후(예: `var push = MFPPush.sharedInstance();`) 보기 제어기 전체에서 `push.methodName()`을 호출하여 수행될 수 있습니다.

또는 푸시 API 메소드에 액세스해야 하는 각 인스턴스에 대해 `MFPPush.sharedInstance().methodName()`을 호출할 수 있습니다.

### 인증 확인 핸들러
{: #challenge-handlers }
`push.mobileclient` 범위가 **보안 검사**에 맵핑되는 경우에는 푸시 API를 사용하기 전에 일치하는 **인증 확인 핸들러**가 존재하며 등록되어 있는지 확인해야 합니다.

> [신임 정보 유효성 검증](../../../authentication-and-security/credentials-validation/ios) 학습서에서 인증 확인 핸들러에 대해 자세히 학습하십시오.

### 클라이언트 측
{: #client-side }

|Swift 메소드 |설명  |
|---------------|--------------|
|[`initialize()`](#initialization) |제공된 컨텍스트에 대해 MFPPush를 초기화합니다. |
|[`isPushSupported()`](#is-push-supported) |디바이스가 푸시 알림을 지원하는지 확인합니다. |
|[`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token) |디바이스를 푸시 알림 서비스에 등록합니다.|
|[`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token) |디바이스 토큰을 서버에 전송합니다. |
|[`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags) |푸시 알림 서비스 인스턴스에서 사용 가능한 태그를 검색합니다. |
|[`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe) |디바이스를 지정된 태그에 등록합니다. |
|[`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)  |디바이스가 현재 등록된 모든 태그를 검색합니다. |
|[`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) |특정 태그에서 등록 취소합니다. |
|[`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister) |푸시 알림 서비스에서 디바이스를 등록 취소합니다.              |

#### 초기화
{: #initialization }
클라이언트 애플리케이션이 MFPPush 서비스에 연결하려면 초기화가 필요합니다.

* 다른 MFPPush API를 사용하기 전에 먼저 `initialize` 메소드를 호출해야 합니다.
* 이는 수신된 푸시 알림을 처리하도록 콜백 함수를 등록합니다.

```swift
MFPPush.sharedInstance().initialize();
```

#### 푸시가 지원되는지 여부
{: #is-push-supported }
디바이스가 푸시 알림을 지원하는지 확인합니다.

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push is supported
} else {
    // Push is not supported
}
```

#### 디바이스 등록 및 디바이스 토큰 전송
{: #register-device--send-device-token }
디바이스를 푸시 알림 서비스에 등록합니다.

```swift
MFPPush.sharedInstance().registerDevice(nil) { (response, error) -> Void in
    if error == nil {
        self.enableButtons()
        self.showAlert("Registered successfully")
        print(response?.description ?? "")
    } else {
        self.showAlert("Registrations failed.  Error \(error?.localizedDescription)")
        print(error?.localizedDescription ?? "")
    }
}
```

<!--`options` = `[NSObject : AnyObject]` which is an optional parameter that is a dictionary of options to be passed with your register request, sends the device token to the server to register the device with its unique identifier.-->

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **참고:** 이는 일반적으로 `didRegisterForRemoteNotificationsWithDeviceToken` 메소드의 **AppDelegate**에서 호출됩니다.

#### 태그 가져오기
{: #get-tags }
푸시 알림 서비스에서 사용 가능한 모든 태그를 검색합니다.

```swift
MFPPush.sharedInstance().getTags { (response, error) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response?.responseText)")
        if response?.availableTags().isEmpty == true {
            self.tagsArray = []
            self.showAlert("There are no available tags")
        } else {
            self.tagsArray = response!.availableTags() as! [String]
            self.showAlert(String(describing: self.tagsArray))
            print("Tags response: \(response)")
        }
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### 등록
{: #subscribe }
원하는 태그에 등록합니다.

```swift
var tagsArray: [String] = ["Tag 1", "Tag 2"]

MFPPush.sharedInstance().subscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Subscribed successfully")
        print("Subscribed successfully response: \(response)")
    } else {
        self.showAlert("Failed to subscribe")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### 등록 가져오기
{: #get-subscriptions }
디바이스가 현재 등록된 태그를 검색합니다.

```swift
MFPPush.sharedInstance().getSubscriptions { (response, error) -> Void in
   if error == nil {
       var tags = [String]()
       let json = (response?.responseJSON)! as [AnyHashable: Any]
       let subscriptions = json["subscriptions"] as? [[String: AnyObject]]
       for tag in subscriptions! {
           if let tagName = tag["tagName"] as? String {
               print("tagName: \(tagName)")
               tags.append(tagName)
           }
       }
       self.showAlert(String(describing: tags))
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```


#### 등록 취소
{: #unsubscribe }
태그에서 등록 취소합니다.

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Unsubscribe from tags
MFPPush.sharedInstance().unsubscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Unsubscribed successfully")
        print(String(describing: response?.description))
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```

#### 등록 취소
{: #unregister }
푸시 알림 서비스 인스턴스에서 디바이스를 등록 취소합니다.

```swift
MFPPush.sharedInstance().unregisterDevice { (response, error)  -> Void in
   if error == nil {
       // Disable buttons
       self.disableButtons()
       self.showAlert("Unregistered successfully")
       print("Subscribed successfully response: \(response)")
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```

## 푸시 알림 처리
{: #handling-a-push-notification }

푸시 알림은 네이티브 iOS 프레임워크에 의해 직접 처리됩니다. 애플리케이션 라이프사이클에 따라 iOS 프레임워크에 의해 다양한 메소드가 호출됩니다.

예를 들어, 애플리케이션이 실행 중인 동안 단순 알림이 수신되는 경우 **AppDelegate**의 `didReceiveRemoteNotification`이 트리거됩니다.

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")
    // display the alert body
      if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
          showAlert(body)
        }
}
```

> 다음 Apple 문서에서 iOS에서의 알림 처리에 대해 자세히 학습하십시오. http://bit.ly/1ESSGdQ

<img alt="샘플 애플리케이션의 이미지" src="notifications-app.png" style="float:right"/>

## 샘플 애플리케이션
{: #sample-application }
Xcode 프로젝트를 [클릭하여 다운로드](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80)하십시오.

### 샘플 사용법
{: #sample-usage }
샘플의 README.md 파일에 있는 지시사항을 따르십시오.
