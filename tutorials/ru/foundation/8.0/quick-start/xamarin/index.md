---
layout: tutorial
title: Сквозная демонстрация для Xamarin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Обзор
{: #overview }
В этой демонстрации рассматриваются все этапы потока:

1. Пример приложения, поставляемый вместе с SDK клиента Xamarin {{ site.data.keys.product_adj }}, регистрируется с помощью {{ site.data.keys.mf_console }}.
2. В {{ site.data.keys.mf_console }} развертывается новый или предоставленный адаптер.  
3. В логику приложения вносятся изменения для запроса ресурса.

**Конечный результат**:

* Проверка связи с {{ site.data.keys.mf_server }}.

#### Предварительные требования:
{: #prerequisites }
* Xamarin Studio
* *Необязательно*. Автономный экземпляр {{ site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads))

### 1. Запуск {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation) либо  
В случае применения [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/) перейдите в папку сервера и выполните следующую команду: `./run.sh` (Mac и Linux) или `run.cmd` (Windows).

### 2. Создание приложения
{: #2-creating-an-application }
В браузере откройте {{ site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. В локальном режиме введите следующий адрес: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Идентификационные данные пользователя: *admin/admin*.

1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу **Android**
    * Введите **com.ibm.mfpstarterxamarin** в качестве **идентификатора приложения** (в зависимости от заготовки приложения, которая будет загружена на следующем шаге)
    * Введите **1.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Регистрация приложения" src="register-an-application-xamarin.gif"/>

### 3. Изменение логики приложения
{: #3-editing-application-logic }
* Создайте проект Xamarin.
* Добавьте SDK Xamarin в соответствии с инструкциями из учебника [Добавление SDK](../../application-development/sdk/xamarin/).
* Добавьте свойство типа `IWorklightClient` во все файлы классов.

   ```csharp
   /// <summary>
   /// Получает или задает пример клиента worklight.
   /// </summary>
   /// <value>Клиент worklight.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* В случае разработки для iOS вставьте следующий код в метод **FinishedLaunching** из файла **AppDelegate.cs**:

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance();
  ```
  >Вместо `<ClassName>` укажите имя класса.
* В случае разработки для Android добавьте следующую строку в метод **OnCreate** из файла **MainActivity.cs**:

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance(this);
  ```
  >Вместо `<ClassName>` укажите имя класса.
* Создайте метод для получения маркера доступа и запроса ресурса на сервере MFP.

    ```csharp
    public async void ObtainToken()
           {
            try
                   {

                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");

                       if (accessToken.Value != null &&  accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");

                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();

                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```

* Вызовите метод **ObtainToken** из конструктора класса или при нажатии кнопки.

### 4. Развертывание адаптера
{: #4-deploy-an-adapter }
Загрузите [подготовленный артефакт .adapter](../javaAdapter.adapter) и разверните его с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**.

Кроме того, можно нажать кнопку **Создать** рядом с разделом **Адаптеры**.  

1. Выберите **Действия → загрузить пример**. Загрузите пример адаптера **Java** "Hello World".

   > Если Maven и {{ site.data.keys.mf_cli }} не установлены, выполните инструкции по **настройке среды разработки**.

2. В окне **Командная строка** перейдите в корневую папку проекта Maven адаптера и выполните следующую команду:

   ```bash
   mfpdev adapter build
   ```

3. После завершения компоновки разверните адаптер с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**. Адаптер расположен в папке **[adapter]/target**.

   <img class="gifplayer" alt="Развертывание адаптера" src="create-an-adapter.png"/>
<!-- <img src="device-screen.png" alt="пример приложения" style="float:right"/>-->
### 5. Тестирование приложения
{: #5-testing-the-application }
1. В Xamarin Studio выберите файл `mfpclient.properties` и укажите значения свойств **protocol**, **host** и **port** с учетом параметров {{ site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{ site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{ site.data.keys.mf_server }} (в IBM Cloud): **https**, **your-server-address** и **443**.
    * В случае применения кластера Kubernetes в IBM Cloud Private и развертывания с типом **NodePort** значением порта, как правило, будет значение **NodePort**, предоставляемое службой в кластере Kubernetes.
2. Нажмите кнопку **Воспроизвести**.

<br clear="all"/>
### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с MobileFirst Server** выдается сообщение **Установлено соединение с MobileFirst Server**.
* Если приложению удалось подключиться к {{ site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java.

Ответ адаптера отображается в консоли Xamarin Studio.

![Изображение приложения, успешно вызвавшего ресурс из {{ site.data.keys.mf_server }}](console-output.png)

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{ site.data.keys.product_adj }} и других вопросах:

- Просмотрите учебники [Разработка адаптеров](../../adapters/)
- Просмотрите [учебники Идентификация и защита](../../authentication-and-security/)
- Просмотрите [Все учебники](../../all-tutorials)
