---
layout: tutorial
title: Composants du produit
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.product_full }} comprend les composants suivants : l'interface de ligne de commande {{ site.data.keys.mf_cli }}, le serveur {{ site.data.keys.mf_server }}, les composants d'exécution côté client, la console {{ site.data.keys.mf_console }}, {{ site.data.keys.mf_app_center }} et le canevas {{ site.data.keys.mf_system_pattern }}.

La figure suivante représente les composants de {{ site.data.keys.product }} :

![Architecture de la solution {{ site.data.keys.product }} ](architecture.jpg)

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
Vous pouvez utiliser l'interface de ligne de commande {{ site.data.keys.mf_cli_full }} pour développer et gérer des applications, en plus d'utiliser la console IBM {{ site.data.keys.mf_console }}. Certaines tâches du processus de développement {{ site.data.keys.product_adj }} doivent être effectuées dans l'interface de ligne de commande.  Les commandes, qui commencent toutes par **mfpdev**, prennent en charge les types de tâche suivants :

* Enregistrement des applications sur le serveur {{ site.data.keys.mf_server }}
* Configuration de votre application
* Création, génération et déploiement des adaptateurs
* Aperçu et mise à jour des applications Cordova
* Pour plus d'informations, voir le tutoriel [Using CLI to manage {{ site.data.keys.product_adj }}](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/).

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Le serveur {{ site.data.keys.mf_server }} fournit une connectivité de back end sécurisée, la gestion d'applications, la prise en charge de la notification push et des fonctions d'analyse, ainsi que la surveillance des applications {{ site.data.keys.product_adj }}. Il ne s'agit pas d'un serveur d'applications au sens de Java Platform, Enterprise Edition (Java EE). Il agit comme un conteneur pour les packages d'applications {{ site.data.keys.product }} et est en réalité un ensemble d'applications Web, éventuellement fournies sous la forme d'un fichier d'archive d'entreprise (EAR) qui s'exécutent par-dessus les serveurs d'applications traditionnels.

Le serveur {{ site.data.keys.mf_server }} s'intègre à votre environnement d'entreprise et utilise des ressources et une infrastructure existantes. Cette intégration est basée sur des adaptateurs, qui sont des composants logiciels côté serveur chargés d'acheminer des systèmes d'entreprise expéditeurs et des services reposant sur le cloud jusqu'à l'unité utilisateur. Vous pouvez utiliser des adaptateurs pour extraire et mettre à jour des données à partir de sources d'information et pour autoriser des utilisateurs à effectuer des transactions et à démarrer d'autres services et applications.

[En savoir plus sur {{ site.data.keys.mf_server }}](server).

### Composants d'exécution côté client
{: #client-side-runtime-components }
{{ site.data.keys.product }} fournit un code d'exécution côté client qui imbrique la fonctionnalité du serveur dans l'environnement cible des applications déployées. Ces API client d'exécution sont des bibliothèques intégrées dans le code d'application stocké en local. Vous les utilisez pour ajouter des fonctionnalités de {{ site.data.keys.product_adj }} à vos applications client. Les API et les bibliothèques peuvent être installées à l'aide d'{{ site.data.keys.mf_dev_kit_full }} ou vous pouvez les télécharger à partir de référentiels pour votre plateforme de développement.

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
La console {{ site.data.keys.mf_console }} est utilisée pour le contrôle et la gestion des applications mobiles. {{ site.data.keys.mf_console }} est également un point d'entrée pour en apprendre davantage sur le développement de {{ site.data.keys.product }}. Depuis la console, vous pouvez télécharger des exemples de code, des outils et des SDK.

Vous pouvez utiliser {{ site.data.keys.mf_console }} pour les tâches suivantes :

* Surveiller et configurer toutes les applications, tous les adaptateurs et toutes les règles de notification push déployés à partir d'une console Web centralisée.
* Désactiver à distance la possibilité de se connecter à {{ site.data.keys.mf_server }} en utilisant des règles préconfigurées de version d'application et de type d'appareil.
* Personnaliser les messages envoyés aux utilisateurs au lancement des applications.
* Collecter des statistiques d'utilisateur à partir de toutes les applications en cours d'exécution.
* Générer des rapports préconfigurés intégrés sur l'adoption et l'utilisation par les utilisateurs (nombre et fréquence d'utilisateurs qui s'engagent avec le serveur par le biais des applications).
* Configurer des règles de collecte de données pour des événements propres aux applications.
* [En savoir plus sur {{ site.data.keys.mf_console }}](console).

### {{ site.data.keys.mf_analytics }}
{: #mobilefirst-analytics }
{{ site.data.keys.product }} comprend une fonction {{ site.data.keys.mf_analytics_short }} opérationnelle évolutive accessible depuis la console {{ site.data.keys.mf_console }}. La fonction {{ site.data.keys.mf_analytics_short }} permet aux entreprises de rechercher dans les journaux et les événements collectés à partir d'appareils, d'applications et de serveurs des canevas, des problèmes et des statistiques d'utilisation de plateforme.

Les données pour {{ site.data.keys.mf_analytics }} incluent les sources suivantes :

* Evénements de panne d'une application sur des appareils iOS et Android (événements de panne pour du code natif et des erreurs JavaScript).
* Interactions des activités application-serveur (tout ce qui est pris en charge par le protocole client/serveur, y compris la notification push).
* Journaux côté serveur qui sont capturés dans des fichiers journaux {{ site.data.keys.product_adj }} traditionnels.

[En savoir plus sur {{ site.data.keys.mf_analytics }}](../../analytics).

### Application Center
{: #application-center }
Avec Application Center, vous pouvez partager des applications mobiles en cours de développement au sein de votre organisation dans un unique référentiel d'applications mobiles. Les membres de l'équipe de développement peuvent utiliser Application Center pour partager des applications avec des membres de l'équipe. Ce processus facilite la collaboration entre les personnes impliquées dans le développement d'une application.

Votre société peut généralement utiliser Application Center comme suit :

1. L'équipe de développement crée une version d'une application.
2. L'équipe de développement télécharge l'application dans Application Center, entre sa description et demande aux membres de l'équipe étendue de la réviser et de la tester.
3. Lorsque la nouvelle version de l'application est disponible, un testeur exécute le programme d'installation d'Application Center, c'est-à-dire le client mobile. Ensuite, le testeur localise cette nouvelle version de l'application, l'installe sur son appareil mobile et la teste.
4. Une fois les tests terminés, le testeur évalue l'application et soumet ses commentaires en retour, que le développeur peut consulter à partir de la console d'Application Center.

Application Center est destiné à une utilisation privée au sein de l'entreprise et vous pouvez destiner certaines applications mobiles à des groupes d'utilisateurs spécifiques. Vous pouvez utiliser Application Center comme magasin d'applications d'entreprise.

### {{ site.data.keys.mf_system_pattern }}
{: #mobilefirst-system-pattern }
Avec {{ site.data.keys.mf_system_pattern_full }}, vous pouvez déployer {{ site.data.keys.mf_server }} sur IBM PureApplication System ou IBM PureApplication Service on SoftLayer. Avec ces canevas, les administrateurs et les entreprises peuvent répondre rapidement aux changements de l'environnement métier en tirant profit des technologies de cloud sur site. Cette approche simplifie le processus de déploiement et augmente l'efficacité opérationnelle de manière à répondre à la demande croissante en matière de technologies mobiles. La demande accélère l'itération de solutions qui excèdent les cycles de demande traditionnels. L'utilisation de {{ site.data.keys.mf_server }} Pattern vous permet également d'accéder aux meilleures pratiques et à une expertise intégrée, comme les règles de mise à l'échelle intégrées.

#### PureApplication System
{: #pureapplication-system }
IBM PureApplication System est un système intégré hautement évolutif qui s'appuie sur l'architecture IBM X et qui fournit un modèle de traitement centré sur les applications dans un environnement de cloud.

Un système centré sur les applications constitue un moyen efficace de gérer les applications complexes ainsi que les tâches et les processus qui sont appelés par l'application. Le système entier implémente un environnement de traitement virtuel riche dans lequel différentes configurations de ressources sont ajustées automatiquement à différentes charges de travail applicatives. Les capacités de gestion des applications de la plateforme IBM PureApplication System permettent de déployer des composants middleware et d'autres composants d'application rapidement, facilement, et de façon répétée.

IBM PureApplication System fournit des charges de travail virtualisées ainsi qu'une infrastructure évolutive distribuée dans un système intégré.

#### Canevas de système virtuel
{: #virtual-system-patterns }
Les canevas de système virtuel sont une représentation logique d'une topologie récurrente pour un ensemble d'exigences de déploiement.

Les canevas de système virtuel permettent des déploiements efficaces et reproductibles de systèmes qui incluent une ou plusieurs instances de machine virtuelle et les applications qui s'exécutent dans ces instances. Vous pouvez automatiser intégralement le déploiement afin de ne plus avoir à effectuer plusieurs longues tâches manuelles. Ce type de déploiement élimine les problèmes qui sont introduits par les processus de configuration manuelle sujets aux erreurs, notamment dans les topologies de production complexes telles que les parcs de serveurs, et accélère le déploiement d'une solution.
