---
layout: tutorial
title: Сквозная демонстрация для Windows 8.1 Universal и Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
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
* Настроенный экземпляр Visual Studio 2013/5
* *Необязательно*. {{ site.data.keys.mf_cli }} ([загрузить]({{site.baseurl}}/downloads))
* *Необязательно*. Автономный экземпляр {{ site.data.keys.mf_server }} ([загрузить]({{site.baseurl}}/downloads))

### 1. Запуск {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Убедитесь, что [создан экземпляр Mobile Foundation](../../bluemix/using-mobile-foundation) либо  
В случае применения [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst) перейдите в папку сервера и выполните следующую команду: `./run.cmd`.

### 2. Создание приложения
{: #2-creating-an-application }
В браузере откройте {{ site.data.keys.mf_console }} с помощью следующего URL: `http://your-server-host:server-port/mfpconsole`. В локальном режиме введите следующий адрес: [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). Идентификационные данные пользователя: *admin/admin*.

1. Нажмите кнопку **Создать** рядом с разделом **Приложения**
    * Выберите платформу **Windows**
    * В качестве **идентификатора приложения** введите **MFPStarterCSharp.Windows** (Windows) или **MFPStarterCSharp.WindowsPhone** (Windows Phone)
    * Введите **1.0.0** в качестве **версии**
    * Нажмите кнопку **Зарегистрировать приложение**

    <img class="gifplayer" alt="Регистрация приложения" src="register-an-application-windows.png"/>

2. Щелкните на плитке **Получить начальный код** и выберите загрузку примера приложения Windows 8.1 или Windows 10.

    <img class="gifplayer" alt="Загрузка примера приложения" src="download-starter-code-windows.png"/>

### 3. Изменение логики приложения
{: #3-editing-application-logic }
1. Откройте проект Visual Studio.

2. Выберите файл **MainPage.xaml.cs** решения и вставьте следующий фрагмент кода в метод GetAccessToken():

   ```csharp
   try
                   {
          IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken &&  accessToken.Value != null &&  accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. Развертывание адаптера
{: 4-deploy-an-adapter }
Загрузите [этот подготовленный артефакт .adapter](../javaAdapter.adapter) и разверните его с помощью {{ site.data.keys.mf_console }}. Для этого выберите **Действия → Развернуть адаптер**.

<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="пример приложения" style="float:right"/>
### 5. Тестирование приложения
{: 5-testing-the-application }
1. В Visual Studio выберите файл **mfpclient.resw** и укажите значения свойств **protocol**, **host** и **port** с учетом параметров сервера {{ site.data.keys.mf_server }}.
    * Обычные значения в случае применения локального экземпляра {{ site.data.keys.mf_server }}: **http**, **localhost** и **9080**.
    * Обычные значения в случае применения удаленного экземпляра {{ site.data.keys.mf_server }} (в IBM Cloud): **https**, **your-server-address** и **443**.
    * В случае применения кластера Kubernetes в IBM Cloud Private и развертывания с типом **NodePort** значением порта, как правило, будет значение **NodePort**, предоставляемое службой в кластере Kubernetes.

    Кроме того, если установлен {{ site.data.keys.mf_cli }}, перейдите в корневую папку проекта и выполните команду `mfpdev app register`. В случае применения удаленного экземпляра {{ site.data.keys.mf_server }} [выполните команду `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) для добавления сервера, а затем выполните команду, аналогичную следующей: `mfpdev app register myIBMCloudServer`.
    
2. Нажмите кнопку **Запустить приложение**.

### Результаты
{: #results }
* При нажатии кнопки **Проверить связь с {{ site.data.keys.mf_server }}** выдается сообщение **Установлено соединение с {{ site.data.keys.mf_server }}**.
* Если приложению удалось подключиться к {{ site.data.keys.mf_server }}, ресурс запрашивается с помощью развернутого адаптера Java.

Ответ адаптера отображается в консоли вывода Visual Studio.

![Приложение после успешного вызова ресурса из {{ site.data.keys.mf_server }}](success_response.png)

## Дальнейшие действия
{: #next-steps }
Узнайте больше об использовании адаптеров в приложениях, интеграции дополнительных служб, таких как Push-уведомления, с помощью среды защиты {{ site.data.keys.product_adj }} и других вопросах:

- Просмотреть учебники, посвященные [разработке приложений](../../application-development/)
- Просмотреть учебники, посвященные [разработке адаптеров](../../adapters/)
- Просмотреть учебники, посвященные [идентификации и защите](../../authentication-and-security/)
- Просмотреть учебники, посвященные [уведомлениям](../../notifications/)
- Просмотреть [все учебники](../../all-tutorials)
