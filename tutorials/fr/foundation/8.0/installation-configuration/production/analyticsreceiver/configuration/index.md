---
layout: tutorial
title: Guide de configuration de MobileFirst Analytics Receiver Server
breadcrumb_title: Guide de configuration
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Configuration de {{ site.data.keys.mf_analytics_receiver_server }}.

#### Aller à
{: #jump-to }

* [Propriétés de configuration](#configuration-properties)

### Propriétés
{: #properties }
Pour obtenir la liste complète des propriétés de configuration et savoir comment les configurer sur votre serveur d'applications, consultez la section [Propriétés de configuration](#configuration-properties).

## Propriétés de configuration
{: #configuration-properties }
{{ site.data.keys.mf_analytics_receiver_server }} peut démarrer à l'aide de la configuration supplémentaire ci-dessous.

Cette configuration est effectuée via des propriétés JNDI sur {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics_receiver_server }}. De plus, {{ site.data.keys.mf_analytics_receiver_server }} prend en charge l'utilisation de variables d'environnement pour contrôler la configuration. Les variables d'environnement ont priorité sur les propriétés JNDI.

L'application Web Analytics Receiver doit être redémarrée pour que les modifications apportées à ces propriétés soient appliquées. Il n'est pas nécessaire de redémarrer le serveur d'applications entier.

Pour définir une propriété JNDI sur WebSphere Application Server Liberty, ajoutez une balise dans le fichier `server.xml` comme suit :

```xml
<jndiEntry jndiName="{PROPERTY NAME}" value="{PROPERTY VALUE}}" />
```

Pour définir une propriété JNDI sur Tomcat, ajoutez une balise dans le fichier `context.xml` comme suit. 

```xml
<Environment name="{PROPERTY NAME}" value="{PROPERTY VALUE}" type="java.lang.String" override="false" />
```

Les propriétés JNDI sur WebSphere Application Server sont disponibles sous forme de variables d'environnement.

* Dans la console WebSphere Application Server, sélectionnez **Applications → Types d'application → Applications d'entreprise WebSphere**.
* Sélectionnez l'application de **service d'administration de {{ site.data.keys.product_adj }}**.
* Dans **Propriétés du module Web**, cliquez sur **Entrées d'environnement pour les modules Web** pour afficher les propriétés JNDI.

#### {{ site.data.keys.mf_analytics_receiver_server }}
{: #mobilefirst-receiver-server }
Le tableau ci-dessous répertorie les propriétés que vous pouvez définir sur {{ site.data.keys.mf_analytics_receiver_server }}.

| Propriété                           | Description                                           | Valeur par défaut |
|------------------------------------|-------------------------------------------------------|---------------|
| receiver.analytics.console.url          | Associez cette propriété à l'adresse URL de {{ site.data.keys.mf_analytics_console }}. Par exemple, `http://hostname:port/analytics/console`. La définition de cette propriété active l'icône d'analyse dans {{ site.data.keys.mf_console }}. | Aucune |
| receiver.analytics.url                  |Requise. Adresse URL exposée par {{ site.data.keys.mf_analytics_server }} et qui reçoit les données d'analyse entrantes. Par exemple, `http://hostname:port/analytics-service/rest`. | Aucune |
| receiver.analytics.username             | Nom d'utilisateur indiqué si le point d'entrée de données est protégé par l'authentification de base. | Aucune |
| receiver.analytics.password             | Mot de passe utilisé si le point d'entrée de données est protégé par l'authentification de base. | Aucune |
| receiver.analytics.event.qsize          |Taille de la file d'attente d'événements d'analyse. Celle-ci doit être ajoutée avec prudence en indiquant une taille de segment de mémoire de JVM suffisante. Taille de file d'attente par défaut 10000  | Aucune |

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Le tableau ci-dessous répertorie les propriétés que vous pouvez définir sur {{ site.data.keys.mf_server }}.

| Propriété                           | Description                                           | Valeur par défaut |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.receiver.url                  | Requise. URL exposée par {{ site.data.keys.mf_analytics_receiver_server }} qui reçoit les données d'analyse entrantes et les réachemine vers {{ site.data.keys.mf_analytics_server }}. Par exemple, `http://hostname:port/analytics-receiver/rest`. | Aucune |
| mfp.analytics.receiver.username             | Nom d'utilisateur indiqué si le point d'entrée de données est protégé par l'authentification de base. | Aucune |
| mfp.analytics.receiver.password             | Mot de passe utilisé si le point d'entrée de données est protégé par l'authentification de base. | Aucune |
