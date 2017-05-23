---
layout: tutorial
title: Подробная демонстрация для веб-приложения
breadcrumb_title: Веб-приложение
relevantTo: [javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Обзор
{: #overview }
В этой демонстрации рассматриваются все этапы потока:

1. Пример приложения, поставляемый вместе с SDK клиента {{site.data.keys.product_adj }}, регистрируется и загружается с помощью {{site.data.keys.mf_console }}.
2. В {{site.data.keys.mf_console }} развертывается новый или предоставленный адаптер.  
3. В логику приложения вносятся изменения для запроса ресурса.

**Конечный результат**:

* Проверка связи с {{site.data.keys.mf_server }}.
* Успешное извлечение данных с помощью адаптера.

#### Предварительные требования:
{: #prerequisites }
* Современный веб-браузер
* *Необязательно*. {{site.data.keys.mf_cli }} ([загрузить]({{site.baseurl}}/downloads))
* *Необязательно*. Автономный экземпляр {{site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads))

### 1. Запуск {{site.data.keys.mf_server }}
{: #starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation) либо  
В случае применения [{{site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) перейдите в папку сервера и выполните следующую команду: `./run.sh` (Mac и Linux) или `run.cmd` (Windows).

### 2. Создание и регистрация приложения
{: #creating-and-registering-an-application }
В браузере откройте {{site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. В локальном режиме введите следующий адрес: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Идентификационные данные пользователя: *admin/admin*.
 
1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу **Веб-приложение**
    * Введите **com.ibm.mfpstarterweb** в качестве **идентификатора приложения**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Регистрация приложения" src="register-an-application-web.png"/>
 
2. Щелкните на плитке **Получить начальный код** и выберите загрузку примера веб-приложения.

    <img class="gifplayer" alt="Загрузка примера приложения" src="download-starter-code-web.png"/>
 
### 3. Изменение логики приложения
{: #editing-application-logic }
1. Откройте проект в предпочитаемом редакторе исходного кода.

2. Выберите файл **client/js/index.js** и вставьте следующий фрагмент кода, заменив существующую функцию `WLAuthorizationManager.obtainAccessToken()`:

   ```javascript
WLAuthorizationManager.obtainAccessToken()
        .then(
        function(accessToken) {
                titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
                
                var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );
                
                resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                        // Will display "Hello world" in an alert dialog.
                        alert("Success: " + response.responseText);
                },
                function(response) {
                        alert("Failure: " + JSON.stringify(response));
                }
                );
            },

            function(error) {
                titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
        );
   ```
    
### 4. Развертывание адаптера
{: #deploy-an-adapter }
Загрузите [этот подготовленный артефакт .adapter](../javaAdapter.adapter) и разверните его с помощью {{site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**.

Кроме того, можно нажать кнопку **Создать** рядом с разделом **Адаптеры**.  
        
1. Выберите **Действия → Загрузить пример**. Загрузите пример адаптера **Java** "Hello World".

   > Если Maven и {{site.data.keys.mf_cli }} не установлены, выполните инструкции по **настройке среды разработки**.

2. В окне **Командная строка** перейдите в корневую папку проекта Maven адаптера и выполните следующую команду:

   ```bash
   mfpdev adapter build
   ```

3. После завершения компоновки разверните адаптер с помощью {{site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**. Адаптер расположен в папке **[adapter]/target**.
    
    <img class="gifplayer" alt="Развертывание адаптера" src="create-an-adapter.png"/>   


<img src="web-success.png" alt="пример приложения" style="float:right"/>
### 5. Тестирование приложения
{: #testing-the-application }
1. В окне **Командная строка** перейдите в папку **[корневой каталог проекта] → node-server**.
2. Выполните команду `npm start`, чтобы установить конфигурацию Node.js и запустить сервер Node.js.
3. Откройте файл **[коревой каталог проекта] → node-server → server.js** и укажите значения свойств **host** и **port** с учетом параметров сервера {{site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{site.data.keys.mf_server }} (в Bluemix): **https**, **your-server-address** и **443**. 

   Пример:  
    
   ```javascript
   var host = 'https://mobilefoundation-xxxx.mybluemix.net'; // Адрес сервера Mobile Foundation
   var port = 9081; // Локальный порт
   var mfpURL = host + ':443'; // Порт сервера Mobile Foundation
   ```
   
4. В браузере откройте следующий URL: [http://localhost:9081/home](http://localhost:9081/home).

<br>
#### Стратегия безопасных источников
{: #secure-origins-policy }
В процессе разработки браузер Chrome может запретить загрузку приложения, если применяются протокол HTTP и хост, **отличный** от "localhost". Это связано со стратегией безопасных источников, которая реализована и применяется в этом браузере по умолчанию.

Для обхода этого ограничения запустите браузер Chrome со следующим параметром:

```bash
--unsafely-treat-insecure-origin-as-secure="http://replace-with-ip-address-or-host:port-number" --user-data-dir=/test-to-new-user-profile/myprofile
```

- Вместо "test-to-new-user-profile/myprofile" укажите расположение папки, которая будет выполнять роль нового пользовательского профайла Chrome.

<br clear="all"/>
### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с {{site.data.keys.mf_server }}** выдается сообщение **Установлено соединение с {{site.data.keys.mf_server }}**.
* Если приложению удалось подключиться к {{site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java.

Ответ адаптера отображается в предупреждении.

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{site.data.keys.product_adj }} и других вопросах:

- Просмотреть учебники, посвященные [разработке приложений](../../application-development/)
- Просмотреть учебники, посвященные [разработке адаптеров](../../adapters/)
- Просмотреть учебники, посвященные [идентификации и защите](../../authentication-and-security/)
- Просмотреть [все учебники](../../all-tutorials)
