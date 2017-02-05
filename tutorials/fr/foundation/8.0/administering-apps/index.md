---
layout: tutorial
title: Administration d'applications
weight: 10
show_children: true
---
## Présentation
{: #overview }
{{site.data.keys.product_full }} permet d'administrer les applications
{{site.data.keys.product_adj }} en développement ou en production de
plusieurs façons. {{site.data.keys.mf_console }} est l'outil principal à
l'aide duquel vous pouvez surveiller toutes les applications
{{site.data.keys.product_adj }} déployées depuis une console Web centrale.

Les opérations principales que vous pouvez effectuer via
{{site.data.keys.mf_console }} sont les suivantes :

* Enregistrer et configurer des applications mobiles sur {{site.data.keys.mf_server }}.
* Déployer et configurer des adaptateurs sur {{site.data.keys.mf_server }}.
* Gérer les versions d'application afin de déployer de nouvelles versions ou de désactiver d'anciennes versions à distance.
* Gérer les terminaux mobiles et les utilisateurs afin de gérer l'accès à un terminal spécifique ou l'accès d'un utilisateur
spécifique à une application.
* Afficher des messages de notification au démarrage de l'application.
* Surveiller les services de notification push.
* Collecter des journaux côté client pour les applications spécifiques installées sur un terminal particulier.

## Rôles d'administration
{: #administration-roles }
Les administrateurs ne peuvent pas tous effectuer toutes les opérations d'administration. {{site.data.keys.mf_console }}
ainsi que tous les outils d'administration possèdent quatre rôles différents pour l'administration des applications
{{site.data.keys.product_adj }}. Voici 

les différents rôles d'administration {{site.data.keys.product_adj }} définis :

**Moniteur**  
Avec ce rôle, un utilisateur peut surveiller les projets
{{site.data.keys.product_adj }} déployés ainsi que les artefacts déployés. Il
est en lecture seule.

**Opérateur**  
Un opérateur peut effectuer toutes les opérations de gestion des applications mobiles mais ne peut pas ajouter ni supprimer des versions d'application
et des adaptateurs.

**Déployeur**  
Avec ce rôle, un utilisateur peut effectuer les mêmes opérations que l'opérateur, mais aussi déployer des applications et des adaptateurs.

**Administrateur**  
Avec ce rôle, un utilisateur peut effectuer toutes les opérations d'administration d'une application.

> Pour plus d'informations sur les rôles d'administration {{site.data.keys.product_adj }}, voir [Configuration de l'authentification d'utilisateur pour l'administration de {{site.data.keys.mf_server }}](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

## Outils d'administration
{: #administration-tools }
{{site.data.keys.mf_console }} ne constitue pas le seul moyen
d'administrer des applications {{site.data.keys.product_adj }}. {{site.data.keys.product }}
met également à disposition d'autres outils permettant d'incorporer des opérations d'administration à votre processus de génération et de déploiement.

Un ensemble de services REST est disponible pour l'exécution d'opérations d'administration. Pour obtenir la documentation de référence API de ces services, voir[API REST pour le service d'administration de {{site.data.keys.mf_server }}](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html#restservicesapi).

Avec cet ensemble de services REST, vous pouvez effectuer les mêmes opérations que dans {{site.data.keys.mf_console }}. Vous pouvez gérer des applications, des adaptateurs et, par exemple, télécharger une nouvelle version d'une application ou désactiver une ancienne version.

Les applications {{site.data.keys.product_adj }} peuvent également être administrées à l'aide de tâches Ant ou de l'outil de ligne de commande **mfpadm**. Voir[Administration des applications {{site.data.keys.product_adj }} via Ant](using-ant) ou [Administration des applications {{site.data.keys.product_adj }} via la ligne de commande](using-cli).

A l'instar de la console Web, les services REST, les tâches Ant et les outils de ligne de commande sont sécurisés et vous devez fournir vos données
d'identification d'administrateur pour pouvoir les utiliser.

### Sélectionnez un sujet :
{: #select-a-topic }

