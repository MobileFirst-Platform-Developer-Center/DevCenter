---
layout: tutorial
title: Сквозная демонстрация для React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Обзор
{: #overview }
В этой демонстрации рассматриваются все этапы потока. 

1. Пример приложения, поставляемый вместе с SDK клиента {{ site.data.keys.product_adj }}, регистрируется и загружается с помощью {{ site.data.keys.mf_console }}.
2. В {{ site.data.keys.mf_console }} развертывается новый или предоставленный адаптер.  
3. В логику приложения вносятся изменения для запроса ресурса.

**Конечный результат**:

* Успешная проверка связи с {{ site.data.keys.mf_server }}. 
* Успешное извлечение данных с помощью адаптера. 

### Предварительные требования:
{: #prerequisites }
* Xcode для iOS, Android Studio для Android
* React Native CLI
* *Необязательно*. {{ site.data.keys.mf_cli }} ([загрузить]({{site.baseurl}}/downloads))
* *Необязательно*. Автономный экземпляр {{ site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads))

### Шаг 1. Запуск {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation), либо в случае применения [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) перейдите в папку сервера и выполните следующую команду: `./run.sh` (Mac и Linux) или `run.cmd` (Windows). 

### Шаг 2. Создание и регистрация приложения
{: #2-creating-and-registering-an-application }
В браузере откройте {{ site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. Если сервер работает в локальном режиме, введите следующий адрес: `http://localhost:9080/mfpconsole`. *Идентификационные данные пользователя*: **admin/admin**. 

1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу: **Android, iOS**
    * Введите **com.ibm.mfpstarter.reactnative** в качестве **идентификатора приложения**
    * Введите **1.0.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Зарегистрировать приложение" src="register-an-application-reactnative.png"/>

2. Загрузите пример приложения React Native с веб-сайта [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative). 

### Шаг 3. Изменение логики приложения
{: #3-editing-application-logic }
1. Откройте проект React Native в предпочитаемом редакторе кода. 

2. Выберите файл **app.js**, расположенный в корневой папке проекта, и вставьте следующий фрагмент кода, заменив существующую функцию `WLAuthorizationManager.obtainAccessToken()`:

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
        resourceRequest.send().then(
          (response) => {
            // Will display "Hello world" in an alert dialog.
            alert("Success: " + response.responseText);
          },
          (error) => {
            alert("Failure: " + JSON.stringify(error));
          }
        );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        alert("Failed to connect to MobileFirst Server");
      });
```

### Шаг 4. Развертывание адаптера
{: #4-deploy-an-adapter }
Загрузите [артефакт .adapter](../javaAdapter.adapter) и разверните его в {{ site.data.keys.mf_console }}, выбрав в меню **Действия → Развернуть адаптер**. 

Кроме того, можно нажать кнопку **Создать** рядом с разделом **Адаптеры**.  

1. Выберите **Действия → Загрузить пример**. Загрузите пример адаптера **Java** *Hello World*. 

    Если Maven и {{ site.data.keys.mf_cli }} не установлены, выполните инструкции по **настройке среды разработки**.

2. В окне **Командная строка** перейдите в корневую папку проекта Maven адаптера и выполните следующую команду:

    ```bash
    mfpdev adapter build
    ```

3. После завершения компоновки разверните адаптер с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**. Адаптер расположен в папке **[adapter]/target**.

    <img class="gifplayer" alt="Развертывание адаптера" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="пример приложения" style="float:right"/>

### Шаг 5. Тестирование приложения
{: #5-testing-the-application }
1.  Убедитесь, что установлен {{ site.data.keys.mf_cli }}, затем перейдите в корневую папку платформы (iOS или Android) и выполните команду `mfpdev app register`. В случае применения удаленного экземпляра {{ site.data.keys.mf_server }} [выполните команду](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) для добавления сервера,
```bash
mfpdev server add
```
после его зарегистрируйте приложение с помощью следующей команды:
```bash
mfpdev app register myIBMCloudServer
```
2. Запустите приложение с помощью следующей команды:
```bash
react-native run-ios|run-android
```

Если устройство подключено, приложение устанавливается и запускается на устройстве. В противном случае применяется симулятор или эмулятор. 

<br clear="all"/>
### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с {{ site.data.keys.mf_server }}** выдается сообщение **Установлено соединение с {{ site.data.keys.mf_server }}**. 
* Если приложению удалось подключиться к {{ site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java. Ответ адаптера отображается в предупреждении.

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{ site.data.keys.product_adj }} и других вопросах:

- Просмотреть учебники, посвященные [разработке приложений](../../application-development/)
- Просмотреть учебники, посвященные [разработке адаптеров](../../adapters/)
- Просмотреть учебники, посвященные [идентификации и защите](../../authentication-and-security/)
- Просмотреть учебники, посвященные [уведомлениям](../../notifications/)
- Просмотреть [все учебники](../../all-tutorials)
