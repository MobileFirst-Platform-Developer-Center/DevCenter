---
layout: tutorial
title: Conectar-se a Microsserviços usando o Proxy da API
weight: 16
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Proxy de API
{: #dab-api-proxy }

Ao conectar-se ao back-end corporativo, é possível alavancar a segurança e a analítica da plataforma MobileFirst usando o Proxy da API. Como o nome sugere, é um proxy que pode ser usado para transmitir por proxy as solicitações para o back-end real.

### Algumas das vantagens de usar o Proxy da API

* O host de back-end real não é exposto para o aplicativo móvel e permanece seguro no servidor MobileFirst.
* Obter a analítica das solicitações feitas para o back-end

### Como usar o Proxy da API?

1. Faça download do adaptador de Proxy da API Móvel a partir do Mobile Foundation Console.

    ![Proxy da API](dab-api-proxy.png)

2. Implemente o adaptador de Proxy da API no servidor Mobile Foundation.

3. Configure o URI de back-end na configuração do adaptador de Proxy da API. O URI deve ter o formato `protocol:host:port/context`. Por exemplo, `http://secure-backend/basecontext/`.
4. Faça as solicitações para o back-end usando a `API WLResourceRequest`. Use o fragmento de código da chamada da API da seção **NÚCLEO MÓVEL**. Altere o objeto de opções para configurar a chave `useAPIProxy` como true.

    Amostra:
    ```
    var resourceRequest = new WLResourceRequest(
        "weather/city/Miami",
        WLResourceRequest.GET,
        { "useAPIProxy": true }
    );
    resourceRequest.send().then(
        function(response) {
            alert("Success: " + response.responseText);
        },
        function(response) {
            alert("Failure: " + JSON.stringify(response));
        }
    );
    ```
