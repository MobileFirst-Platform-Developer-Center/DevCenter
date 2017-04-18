---
layout: tutorial
title: Подробная демонстрация для Android
breadcrumb_title: Android
relevantTo: [android]
weight: 3
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
* Android Studio
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
    * Выберите платформу **Android**
    * Введите **com.ibm.mfpstarterandroid** в качестве **идентификатора приложения**
    * Введите **1.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Регистрация приложения" src="register-an-application-android.png"/>
 
2. Щелкните на плитке **Получить начальный код** и выберите загрузку примера приложения Android.

    <img class="gifplayer" alt="Загрузка примера приложения" src="download-starter-code-android.png"/>

### 3. Изменение логики приложения
{: #3-editing-application-logic }
1. Откройте Android Studio и импортируйте проект.

2. В боковом меню **Проект** выберите файл **app → java → com.ibm.mfpstarterandroid → ServerConnectActivity.java** и выполните следующие действия:

* Добавьте следующие операторы импорта:

  ```java
  import java.net.URI;
  import java.net.URISyntaxException;
  import android.util.Log;
  ```
    
* Вставьте следующий фрагмент кода, заменив вызов `WLAuthorizationManager.getInstance().obtainAccessToken`:

  ```java
  WLAuthorizationManager.getInstance().obtainAccessToken("", new WLAccessTokenListener() {
                @Override
                public void onSuccess(AccessToken token) {
                    System.out.println("Received the following access token value: " + token);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Yay!");
                            connectionStatusLabel.setText("Connected to {{ site.data.keys.mf_server }}");
                        }
                    });

                    URI adapterPath = null;
                    try {
                        adapterPath = new URI("/adapters/javaAdapter/resource/greet");
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }

                    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
                    
                    request.setQueryParameter("name","world");
                    request.send(new WLResponseListener() {
                        @Override
                        public void onSuccess(WLResponse wlResponse) {
                            // Will print "Hello world" in LogCat.
                            Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
                        }

                        @Override
                        public void onFailure(WLFailResponse wlFailResponse) {
                            Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
                        }
                    });
                }

                @Override
                public void onFailure(WLFailResponse wlFailResponse) {
                    System.out.println("Did not receive an access token from server: " + wlFailResponse.getErrorMsg());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Bummer...");
                            connectionStatusLabel.setText("Failed to connect to {{ site.data.keys.mf_server }}");
                        }
                    });
                }
            });
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

<img src="androidQuickStart.png" alt="пример приложения" style="float:right"/>
### 5. Тестирование приложения
{: #5-testing-the-application }

1. В Android Studio в боковом меню  **Проект** выберите файл **app → src → main →assets → mfpclient.properties** и укажите значения свойств **protocol**, **host** и **port** с учетом параметров сервера {{ site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{ site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{ site.data.keys.mf_server }} (в Bluemix): **https**, **your-server-address** и **443**.

    Кроме того, если установлен {{ site.data.keys.mf_cli }}, перейдите в корневую папку проекта и выполните команду `mfpdev app register`. В случае применения удаленного экземпляра {{ site.data.keys.mf_server }} [выполните команду `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) для добавления сервера, а затем выполните команду, аналогичную следующей: `mfpdev app register myBluemixServer`.

2. Нажмите кнопку **Запустить приложение**.  

<br clear="all"/>
### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с {{ site.data.keys.mf_server }}** выдается сообщение **Установлено соединение с {{ site.data.keys.mf_server }}**.
* Если приложению удалось подключиться к {{ site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java.

Ответ адаптера отображается в представлении LogCat Android Studio.

![Изображение приложения, успешно вызвавшего ресурс из {{ site.data.keys.mf_server }}](success_response.png)

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{ site.data.keys.product_adj }} и других вопросах:

- Просмотреть учебники, посвященные [разработке приложений](../../application-development/)
- Просмотреть учебники, посвященные [разработке адаптеров](../../adapters/)
- Просмотреть учебники, посвященные [идентификации и защите](../../authentication-and-security/)
- Просмотреть учебники, посвященные [уведомлениям](../../notifications/)
- Просмотреть [все учебники](../../all-tutorials)
