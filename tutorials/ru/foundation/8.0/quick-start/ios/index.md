---
layout: tutorial
title: Подробная демонстрация для iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Обзор
{: #overview }
В этой демонстрации рассматриваются все этапы потока:

1. Пример приложения, поставляемый вместе с SDK клиента {{ site.data.keys.product_adj }}, регистрируется и загружается с помощью {{ site.data.keys.mf_console }}.
2. В {{ site.data.keys.mf_console }} развертывается новый или предоставленный адаптер.  
3. В логику приложения вносятся изменения для запроса ресурса.

**Конечный результат**:

* Проверка связи с {{ site.data.keys.mf_server }}.
* Успешное извлечение данных с помощью адаптера.

#### Предварительные требования:
{: #prerequisites }
* Xcode
* *Необязательно*. {{ site.data.keys.mf_cli }} ([загрузить]({{site.baseurl}}/downloads))
* *Необязательно*. Автономный экземпляр {{ site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads))

### 1. Запуск {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation) либо  
В случае применения [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) перейдите в папку сервера и выполните следующую команду: `./run.sh` (Mac и Linux) или `run.cmd` (Windows).

### 2. Создание приложения
{: #2-creating-an-application }
В браузере откройте {{ site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. В локальном режиме введите следующий адрес: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Идентификационные данные пользователя: *admin/admin*.
 
1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу **iOS**
    * Введите **com.ibm.mfpstarteriosobjectivec** или **com.ibm.mfpstarteriosswift** в качестве **идентификатора приложения** (в зависимости от заготовки приложения, которая будет загружена на следующем шаге)
    * Введите **1.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**
    
    <img class="gifplayer" alt="Зарегистрировать приложение" src="register-an-application-ios.png"/>
 
2. Щелкните на плитке **Получить начальный код** и выберите загрузку примера приложения iOS Objective-C или iOS Swift.

    <img class="gifplayer" alt="Загрузка примера приложения" src="download-starter-code-ios.png"/>
    
### 3. Изменение логики приложения
{: #3-editing-application-logic }
1. Откройте проект Xcode, дважды щелкнув на файле **.xcworkspace**.

2. Выберите файл **[каталог-проекта]/ViewController.m/swift** и вставьте следующий фрагмент кода, заменив существующую функцию `getAccessToken()`:
 
   Objective-C:

   ```objc
   - (IBAction)getAccessToken:(id)sender {
   _testServerButton.enabled = NO;
   NSURL *serverURL = [[WLClient sharedInstance] serverUrl];
   _connectionStatusLabel.text = [NSString stringWithFormat:@"Connecting to server...\n%@", serverURL];
    
   NSLog(@"Testing Server Connection");
   [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:@"" withCompletionHandler:^(AccessToken *token, NSError *error) {
        if (error != nil) {
            _titleLabel.text = @"Bummer...";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Failed to connect to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Did not receive an access token from server: %@", error.description);
        } else {
            _titleLabel.text = @"Yay!";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Connected to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Received the following access token value: %@", token.value);
            
            NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/resource/greet/"];
            WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
            
            [request setQueryParameterValue:@"world" forName:@"name"];
            [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                if (error != nil){
                    NSLog(@"Failure: %@",error.description);
                }
                else if (response != nil){
                    // Will print "Hello world" in the Xcode Console.
                    NSLog(@"Success: %@",response.responseText);
                }
            }];
        }

        _testServerButton.enabled = YES;
    }];
}
   ```
    
   Swift:
    
   ```swift
   @IBAction func getAccessToken(sender: AnyObject) {
        self.testServerButton.enabled = false
        
        let serverURL = WLClient.sharedInstance().serverUrl()
        
        connectionStatusLabel.text = "Connecting to server...\n\(serverURL)"
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in
            
            if (error != nil) {
                self.titleLabel.text = "Bummer..."
                self.connectionStatusLabel.text = "Failed to connect to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Did not recieve an access token from server: " + error.description)
            } else {
                self.titleLabel.text = "Yay!"
                self.connectionStatusLabel.text = "Connected to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Recieved the following access token value: " + token.value)
                
                let url = NSURL(string: "/adapters/javaAdapter/resource/greet/")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)
                
                request.setQueryParameterValue("world", forName: "name")
                request.sendWithCompletionHandler { (response, error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }
            
            self.testServerButton.enabled = true
        }
   }
   ```

### 4. Развертывание адаптера
{: #4-deploy-an-adapter }
Загрузите [этот подготовленный артефакт .adapter](../javaAdapter.adapter) и разверните его с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**.

Кроме того, можно нажать кнопку **Создать** рядом с разделом **Адаптеры**.  
        
1. Выберите **Действия → Загрузить пример**. Загрузите пример адаптера **Java** "Hello World".

   > Если Maven и {{ site.data.keys.mf_cli }} не установлены, выполните инструкции по **настройке среды разработки**.

2. В окне **Командная строка** перейдите в корневую папку проекта Maven адаптера и выполните следующую команду:

   ```bash
   mfpdev adapter build
   ```

3. После завершения компоновки разверните адаптер с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**. Адаптер расположен в папке **[adapter]/target**. 

    <img class="gifplayer" alt="Развертывание адаптера" src="create-an-adapter.png"/>   

<img src="iosQuickStart.png" alt="пример приложения" style="float:right"/>
### 5. Тестирование приложения
{: #5-testing-the-application }
1. В Xcode выберите файл **mfpclient.plist** и укажите значения свойств **protocol**, **host** и **port** с учетом параметров сервера {{ site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{ site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{ site.data.keys.mf_server }} (в Bluemix): **https**, **your-server-address** и **443**.
     
    Кроме того, если установлен {{ site.data.keys.mf_cli }}, перейдите в корневую папку проекта и выполните команду `mfpdev app register`. В случае применения удаленного экземпляра {{ site.data.keys.mf_server }} [выполните команду `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) для добавления сервера, а затем выполните команду, аналогичную следующей: `mfpdev app register myBluemixServer`.

2. Нажмите кнопку **Воспроизвести**.

<br clear="all"/>
### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с {{ site.data.keys.mf_server }}** выдается сообщение **Установлено соединение с {{ site.data.keys.mf_server }}**.
* Если приложению удалось подключиться к {{ site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java.

Ответ адаптера отображается в консоли Xcode.

![Изображение приложения, успешно вызвавшего ресурс из {{ site.data.keys.mf_server }} ](success_response.png)

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{ site.data.keys.product_adj }} и других вопросах:

- Просмотреть учебники, посвященные [разработке приложений](../../application-development/)
- Просмотреть учебники, посвященные [разработке адаптеров](../../adapters/)
- Просмотреть учебники, посвященные [идентификации и защите](../../authentication-and-security/)
- Просмотреть учебники, посвященные [уведомлениям](../../notifications/)
- Просмотреть [все учебники](../../all-tutorials)
