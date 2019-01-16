---
layout: tutorial
title: Сквозная демонстрация для Ionic
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Обзор
{: #overview }
В этой демонстрации рассматриваются все этапы потока. Поток включает в себя следующие шаги:

1. Пример приложения, поставляемый вместе с SDK клиента {{ site.data.keys.product_adj }}, регистрируется и загружается с помощью {{ site.data.keys.mf_console }}.
2. В {{ site.data.keys.mf_console }} развертывается новый или предоставленный адаптер.  
3. В логику приложения вносятся изменения для запроса ресурса.

**Конечный результат**:

* Успешная проверка связи с {{ site.data.keys.mf_server }}.
* Успешное извлечение данных с помощью адаптера.

### Предварительные требования:
{: #prerequisites }
* Xcode для iOS, Android Studio для Android или Visual Studio 2015 или поздней версии для Windows 10 UWP
* Ionic CLI
* *Необязательно*. {{ site.data.keys.mf_cli }} ([загрузить]({{site.baseurl}}/downloads)).
* *Необязательно*. Автономный экземпляр {{ site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads)).

### Шаг 1. Запуск {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation), либо в случае применения [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) перейдите в папку сервера и выполните следующую команду: `./run.sh` (Mac и Linux) или `run.cmd` (Windows).

### Шаг 2. Создание и регистрация приложения
{: #2-creating-and-registering-an-application }
В браузере откройте {{ site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. Если сервер работает в локальном режиме, введите следующий адрес: `http://localhost:9080/mfpconsole`. *Идентификационные данные пользователя*: **admin/admin**.

1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу в списке: **Android, iOS, Windows, браузер**
    * Введите **com.ibm.mfpstarterionic** в качестве **идентификатора приложения**
    * Введите **1.0.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Зарегистрировать приложение" src="register-an-application-ionic.png"/>

2. Загрузите пример приложения Ionic с веб-сайта [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic).

### Шаг 3: Добавление SDK MobileFirst в приложение Ionic
{: #adding_mfp_ionic_sdk}

Следуя инструкциям ниже, добавьте SDK MobileFirst в загруженный пример приложения Ionic.

1. Перейдите в корневую папку существующего проекта Ionic и добавьте {{ site.data.keys.product_adj }} базовый модуль Ionic Cordova.

2. Перейдите в корневой каталог проекта Ionic: `cd MFPStarterIonic`

3. Добавьте модули MobileFirst с помощью следующей команды CLI Ionic: `ionic cordova plugin add название-модуля-cordova`
Пример:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > Указанная выше команда добавляет базовый модуль SDK MobileFirst в проект Ionic.

4. Добавьте одну или несколько поддерживаемых платформ в проект Cordova с помощью следующей команды CLI Ionic: `ionic cordova platform add ios|android|windows|browser`. Пример:

   ```bash
   cordova platform add ios
   ```

5. Подготовьте ресурсы приложения с помощью `команды ionic cordova prepare`:

   ```bash
   ionic cordova prepare
   ```

### Шаг 4. Изменение логики приложения
{: #3-editing-application-logic }
1. Откройте проект Ionic в предпочитаемом редакторе кода.

2. Выберите файл **src/js/index.js** и вставьте следующий фрагмент кода, заменив существующую функцию `WLAuthorizationManager.obtainAccessToken()`:

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
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
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### Шаг 5. Развертывание адаптера
{: #4-deploy-an-adapter }
Загрузите этот [артефакт .adapter](../javaAdapter.adapter) и разверните его в {{ site.data.keys.mf_console }}, выбрав в меню **Действия → Развернуть адаптер**.

Кроме того, можно нажать кнопку **Создать** рядом с разделом **Адаптеры**.  

1. Выберите **Действия → Загрузить пример**. Загрузите пример адаптера **Java** *Hello World*.

    Если Maven и {{ site.data.keys.mf_cli }} не установлены, выполните инструкции по **настройке среды разработки**.

2. В окне **Командная строка** перейдите в корневую папку проекта Maven адаптера и выполните следующую команду:

    ```bash
    mfpdev adapter build
    ```

3. После завершения компоновки разверните адаптер с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**. Адаптер расположен в папке **[adapter]/target**.

    <img class="gifplayer" alt="Развертывание адаптера" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="пример приложения" style="float:right"/>

### Шаг 6. Тестирование приложения
{: #5-testing-the-application }
1. В окне **Командная строка** перейдите в корневую папку проекта Cordova.
2. Выполните команду: `ionic cordova platform add ios|android|windows|browser` для добавления платформы.
3. В проекте Ionic выберите файл **config.xml** и измените `<mfp:server ... url=" "/>` значения свойств **protocol**, **host** и **port** с учетом параметров {{ site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{ site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{ site.data.keys.mf_server }} (в IBM Cloud): **https**, **адрес-сервера** и **443**.
    * В случае применения кластера Kubernetes в IBM Cloud Private и развертывания с типом **NodePort** значением порта, как правило, будет значение **NodePort**, предоставляемое службой в кластере Kubernetes.

    Кроме того, если установлен {{ site.data.keys.mf_cli }}, перейдите в корневую папку проекта и выполните команду `mfpdev app register`. В случае применения удаленного экземпляра {{ site.data.keys.mf_server }} [выполните команду](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)
    ```bash
    mfpdev server add
    ```
     для добавления сервера, после чего зарегистрируйте приложение с помощью следующей команды:
    ```bash
    mfpdev app register myIBMCloudServer
    ```

Если устройство подключено, приложение устанавливается и запускается на устройстве.
В противном случае применяется симулятор или эмулятор.

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
