---
layout: tutorial
title: Connexion aux microservices à l'aide du proxy d'API
weight: 15
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## Proxy d'API
{: #dab-api-proxy }

Lorsque vous vous connectez au système de back end de l'entreprise, il est possible de tirer parti de la sécurité et de l'analyse de la plateforme MobileFirst via le proxy d'API. Comme son nom le suggère, il s'agit d'un proxy qui peut être employé pour traiter les demandes envoyées au système de back end réel.

### Quelques avantages liés à l'utilisation du proxy d'API

* L'hôte de back end réel n'est pas exposé à l'application mobile et reste sécurisé dans le serveur MobileFirst.
* Vous bénéficiez de l'analyse des demandes envoyées au système de back end.

### Comment utiliser le proxy d'API ?

1. Téléchargez l'adaptateur Mobile API Proxy à partir de Mobile Foundation Console.

    ![Proxy d'API](dab-api-proxy.png)

2. Déployez l'adaptateur du proxy d'API sur le serveur Mobile Foundation.

3. Configurez l'URI du système de back end dans la configuration de l'adaptateur du proxy d'API. L'URI doit respecter le format `protocole:hôte:port/contexte`. Par exemple, `http://secure-backend/basecontext/`.
4. Effectuez les demandes au système de back end avec l'`API WLResourceRequest`. Utilisez le fragment de code de l'appel API de la section **COEUR MOBILE**. Modifiez l'objet des options pour définir la clé `useAPIProxy` sur true.

    Exemple :
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
