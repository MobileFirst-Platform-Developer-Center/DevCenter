---
layout: tutorial
title: Guide de configuration de MobileFirst Analytics Server
breadcrumb_title: Guide de configuration
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous devez effectuer certaines étapes de configuration pour {{ site.data.keys.mf_analytics_server }}. Certains des paramètres de configuration sont valables pour un noeud unique alors que d'autres s'appliquent au cluster entier, comme indiqué.

#### Aller à
{: #jump-to }

* [Propriétés de configuration](#configuration-properties)
* [Sauvegarde des données d'analyse](#backing-up-analytics-data)
* [Gestion de cluster et Elasticsearch](#cluster-management-and-elasticsearch)

### Propriétés
{: #properties }
Pour la liste complète des propriétés de configuration et savoir comment les définir sur votre serveur d'applications, voir [Propriétés de configuration](#configuration-properties).

* La propriété **discovery.zen.minimum\_master\_nodes** doit avoir pour valeur **ceil((nombre de noeuds éligibles en tant que maître dans le cluster / 2) + 1)** afin d'éviter le syndrome de cerveau dédoublé (ou split-brain).
    * Les noeuds Elasticsearch dans un cluster qui sont éligibles en tant que maître doivent établir un quorum afin de décider quel noeud éligible en tant que maître sera le noeud maître.
    * Si vous ajoutez un noeud éligible en tant que maître au cluster, le nombre de noeuds éligibles en tant que maître change et par conséquent, le paramètre doit changer. Vous devez modifier le paramètre si vous ajoutez de nouveaux noeuds éligibles en tant que maître au cluster. Pour plus d'informations sur la gestion de votre cluster, voir [Gestion de cluster et Elasticsearch](#cluster-management-and-elasticsearch).
* Attribuez un nom à votre cluster en définissant la propriété **clustername** sur tous vos noeuds.
    * Nommez le cluster afin d'éviter que l'instance d'Elasticsearch d'un développeur ne soit accidentellement ajoutée à un cluster utilisant un nom par défaut.
* Attribuez un nom à chaque noeud en définissant la propriété **nodename** sur chaque noeud.
    * Par défaut, Elasticsearch nomme chaque noeud en fonction d'un caractère Marvel aléatoire, et le nom de noeud est différent à chaque redémarrage du noeud.
* Déclarez explicitement le chemin d'accès du système de fichiers au répertoire de données en définissant la propriété **datapath** sur chaque noeud.
* Déclarez explicitement les noeuds maîtres dédiés en définissant la propriété **masternodes** sur chaque noeud.

### Paramètres de reprise de cluster
{: #cluster-recovery-settings }
Si vous avez étendu votre système à un cluster multinoeud, vous constaterez peut-être qu'il est parfois nécessaire de redémarrer entièrement le cluster. Si un redémarrage complet du cluster est requis, vous devez examiner les paramètres de reprise. Si le cluster comporte dix noeuds, au cours du démarrage du cluster (un noeud à la fois), le noeud maître suppose qu'il doit équilibrer immédiatement les données à l'arrivée de chaque noeud dans le cluster. Si le maître est autorisé à se comporter ainsi, un rééquilibrage totalement inutile est requis. Vous devez configurer les paramètres de cluster de sorte que le système attende qu'un nombre minimal de noeuds soit ajouté au cluster avant que le maître ne soit autorisé à demander un rééquilibrage aux noeuds. Vous pouvez ainsi réduire les redémarrages de cluster qui duraient des heures en redémarrages durant quelques minutes seulement.

* Vous devez associer la propriété **gateway.recover\_after\_nodes** à la valeur de votre choix pour éviter qu'Elasticsearch n'initie un rééquilibrage tant que le nombre spécifié de noeuds dans le cluster n'a pas été démarré et ajouté. Si votre cluster comporte dix noeuds, il est raisonnable d'associer la propriété **gateway.recover\_after\_nodes** à la valeur 8.
* La propriété **gateway.expected\_nodes** doit avoir pour valeur le nombre de noeuds devant se trouver dans le cluster. Dans cet exemple, la valeur de la propriété **gateway.expected_nodes** est 10.
* La propriété **gateway.recover\_after\_time** doit être définie de sorte que le maître attende que le temps défini se soit écoulé après son démarrage avant d'envoyer des instructions de rééquilibrage.

Avec la combinaison des paramètres précédents, Elasticsearch attend que le nombre de noeuds **gateway.recover\_after\_nodes** défini soit atteint. Ensuite, il commence la reprise, une fois le nombre de minutes défini par **gateway.recover\_after\_time** écoulé ou une fois que le nombre de noeuds défini par **gateway.expected\_nodes** a été ajouté au cluster (selon la propriété qui se vérifie en premier).

### A ne pas faire
{: #what-not-to-do }
* N'ignorez pas votre cluster de production.
    * Les clusters doivent être surveillés et entretenus. De nombreux outils de surveillance Elasticsearch performants dédiés sont disponibles.
* N'utilisez pas le stockage en réseau NAS pour votre paramètre **datapath**. Il introduit un temps d'attente plus long et un seul point de défaillance. Utilisez toujours les disques des hôtes locaux.
* Evitez les clusters qui répartissent les centres de données et surtout ceux qui couvrent de grandes distances géographiques. Le temps d'attente entre les noeuds constitue un goulot d'étranglement des performances important.
* Déployez votre propre solution de gestion des configurations de cluster. De nombreuses solutions de gestion des configurations performantes, telles que Puppet, Chef et Ansible, sont disponibles.

## Propriétés de configuration
{: #configuration-properties }
{{ site.data.keys.mf_analytics_server }} peut démarrer sans configuration
supplémentaire.

La configuration est effectuée via des propriétés JNDI sur {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics_server }}. De plus, {{ site.data.keys.mf_analytics_server }} prend en charge l'utilisation de variables d'environnement pour contrôler la configuration. Les variables d'environnement ont priorité sur les propriétés JNDI.

L'application Web d'exécution d'Analytics doit être redémarrée pour que les modifications apportées à ces propriétés soient appliquées. Il n'est pas nécessaire de redémarrer le serveur d'applications entier.

Pour définir une propriété JNDI sur WebSphere Application Server Liberty, ajoutez une balise dans le fichier **server.xml** comme suit :

```xml
<jndiEntry jndiName="{NOM PROPRIETE}" value="{VALEUR PROPRIETE}}" />
```

Pour définir une propriété JNDI sur Tomcat, ajoutez une balise dans le fichier context.xml comme suit :

```xml
<Environment name="{NOM PROPRIETE}" value="{VALEUR PROPRIETE}"
type="java.lang.String" override="false" />
```

Les propriétés JNDI sur WebSphere Application Server sont disponibles sous forme de variables d'environnement.

* Dans la console WebSphere Application Server, sélectionnez **Applications → Types d'application → Applications d'entreprise WebSphere**.
* Sélectionnez l'application de **service d'administration de {{ site.data.keys.product_adj }}**.
* Dans **Propriétés du module Web**, cliquez sur **Entrées d'environnement pour les modules Web** pour afficher les propriétés JNDI.

#### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Le tableau ci-dessous répertorie les propriétés que vous pouvez définir sur {{ site.data.keys.mf_server }}.

| Propriété                           | Description                                           | Valeur par défaut |
|------------------------------------|-------------------------------------------------------|---------------|
| mfp.analytics.console.url          | Associez cette propriété à l'adresse URL de {{ site.data.keys.mf_analytics_console }}. Exemple : http://nomhôte:port/analytics/console. La définition de cette propriété active l'icône d'analyse dans {{ site.data.keys.mf_console }}. | Aucune |
| mfp.analytics.logs.forward         | Si cette propriété a pour valeur true, les journaux serveur qui sont enregistrés sur {{ site.data.keys.mf_server }} sont capturés dans {{ site.data.keys.mf_analytics }}. | true |
| mfp.analytics.url                  |Requise. Adresse URL exposée par {{ site.data.keys.mf_analytics_server }} et qui reçoit les données d'analyse entrantes. Exemple : http://nomhôte:port/analytics-service/rest/v2. | Aucune |
| analyticsconsole/mfp.analytics.url |	Facultative. URI complet des services REST d'analyse. Dans un scénario qui présente un pare-feu ou un proxy inverse sécurisé, il doit s'agir de l'URI externe et non de l'URI interne dans le réseau local. Cette valeur peut contenir * à la place du protocole d'URI, du nom d'hôte et du port afin de désigner la partie correspondante provenant de l'adresse URL entrante.	*://*:*/analytics-service, avec le protocole, le nom d'hôte et le port déterminés dynamiquement. |
| mfp.analytics.username             | Nom d'utilisateur indiqué si le point d'entrée de données est protégé par l'authentification de base. | Aucune |
| mfp.analytics.password             | Mot de passe utilisé si le point d'entrée de données est protégé par l'authentification de base. | Aucune |

#### {{ site.data.keys.mf_analytics_server }}
{: #mobilefirst-analytics-server }
Le tableau ci-dessous répertorie les propriétés que vous pouvez définir sur {{ site.data.keys.mf_analytics_server }}.

| Propriété                           | Description                                           | Valeur par défaut |
|------------------------------------|-------------------------------------------------------|---------------|
| analytics/nodetype | Définit le type de noeud Elasticsearch. Les valeurs valides sont maître et données. Si cette propriété n'est pas définie, le noeud agit en tant que noeud éligible comme maître et noeud de données. | 	Aucune |
| analytics/shards | Nombre de fragments par index. Cette valeur ne peut être définie que par le premier noeud qui est démarré dans le cluster et ne peut pas être changée. | 1 |
| analytics/replicas_per_shard | Nombre de répliques pour chaque fragment dans le cluster. Cette valeur peut être changée dynamiquement dans un cluster en cours d'exécution. | 0 |
| analytics/masternodes | Chaîne contenant le nom d'hôte et les ports délimités par une virgule des noeuds éligibles en tant que maître. | Aucune |
| analytics/clustername | Nom du cluster. Définissez cette valeur si vous prévoyez l'exécution de plusieurs clusters dans un même sous-ensemble et avez besoin d'identifier ces clusters de façon unique. | worklight |
| analytics/nodename | Nom d'un noeud dans le cluster. | Chaîne générée aléatoirement
| analytics/datapath | Chemin de sauvegarde des données d'analyse dans le système de fichiers. | ./analyticsData |
| analytics/settingspath | Chemin d'accès à un fichier de paramètres Elasticsearch. Pour plus d'informations, voir Elasticsearch. | Aucune |
| analytics/transportport | Port utilisé pour la communication entre deux noeuds. | 9600 |
| analytics/httpport | Port utilisé pour la communication HTTP avec Elasticsearch. | 9500 |
| analytics/http.enabled | Active ou désactive la communication HTTP avec Elasticsearch. | false |
| analytics/serviceProxyURL | Le fichier WAR de l'interface utilisateur d'analyse et le fichier WAR du service d'analyse peuvent être installés sur des serveurs d'applications distincts. Si vous décidez de les installer sur des serveurs d'applications distincts, sachez que l'environnement d'exécution JavaScript dans le fichier WAR de l'interface utilisateur peut être bloqué par une fonction de protection contre les attaques par script intersite (XSS) dans le navigateur. Afin d'éviter ce blocage, le fichier WAR de l'interface utilisateur inclut un code de proxy Java pour que l'environnement d'exécution JavaScript extraie les réponses d'API REST depuis le serveur d'origine. Toutefois, le proxy est configuré pour acheminer les demandes d'API REST au fichier WAR du service d'analyse. Configurez cette propriété si vous avez installé vos fichiers WAR sur des serveurs d'applications distincts. | Aucune |
| analytics/bootstrap.mlockall | Cette propriété empêche la mémoire Elasticsearch d'être permutée sur le disque. | true |
| analytics/multicast | Active ou désactive la reconnaissance des noeuds multidiffusion. | false |
| analytics/warmupFrequencyInSeconds | Fréquence à laquelle les requêtes d'échauffement sont exécutées. Elles s'exécutent en arrière-plan pour forcer l'enregistrement des résultats de requête dans la mémoire afin d'améliorer les performances de la console Web. Les valeurs négatives désactivent les requêtes d'échauffement. | 600 |
| analytics/tenant | Nom de l'index Elasticsearch principal.	worklight |

Dans tous les cas où la clé ne contient pas de point (par exemple **httpport** et non **http.enabled**), le paramètre peut être contrôlé par des variables d'environnement système où le nom de la variable est préfixé avec **ANALYTICS_**. Lorsque la propriété JNDI et la variable d'environnement système sont définies toutes les deux, la variable d'environnement système est prioritaire. Par exemple, si la propriété JNDI **analytics/httpport** et la variable d'environnement système **ANALTYICS_httpport** sont définies toutes les deux, la valeur de **ANALYTICS_httpport** est utilisée.

#### Durée de vie des documents
{: #document-time-to-live-ttl }
La durée de vie détermine l'établissement et la gestion d'une règle de conservation des données. Vos décisions ont des conséquences notables sur vos besoins en matière de ressources système. Plus vous conservez les données longtemps, plus vous aurez besoin de mémoire RAM et de disque, ainsi que de procéder à une mise à l'échelle.

Chaque type de document possède sa propre durée de vie. La définition de la durée de vie d'un document active la suppression automatique du document après son stockage pendant la durée spécifiée.

Chaque propriété JNDI de durée de vie s'appelle **analytics/TTL_[type-document]**. Par exemple, le paramètre de durée de vie pour **NetworkTransaction** s'appelle **analytics/TTL_NetworkTransaction**.

Ces valeurs peuvent être définies avec des unités de temps basiques, comme suit :

* 1Y = 1 an
* 1M = 1 mois
* 1w = 1 semaine
* 1d = 1 jour
* 1h = 1 heure
* 1m = 1 minute
* 1s = 1 seconde
* 1ms = 1 milliseconde

> Remarque : si vous procédez à la migration depuis des versions précédentes de {{ site.data.keys.mf_analytics_server }} et que vous avez déjà configuré des propriétés JNDI de durée de vie, voir [Migration des propriétés de serveur utilisées par des versions précédentes de {{ site.data.keys.mf_analytics_server }}](../installation/#migration-of-server-properties-used-by-previous-versions-of-mobilefirst-analytics-server).

#### Elasticsearch
{: #elasticsearch }
La technologie de mise en cluster et de stockage sous-jacente qu'utilise {{ site.data.keys.mf_analytics_console }} est Elasticsearch.  
Elasticsearch met à disposition de nombreuses propriétés réglables, principalement pour l'optimisation des performances. La plupart des propriétés JNDI sont des abstractions des propriétés fournies par Elasticsearch.

Vous pouvez également définir toutes les propriétés mises à disposition par Elasticsearch avec des propriétés JNDI en ajoutant **analytics/** devant le nom de propriété. Par exemple, **threadpool.search.queue_size** est une propriété mise à disposition par Elasticsearch. Elle peut être définie avec la propriété JNDI suivante :

```xml
<jndiEntry jndiName="analytics/threadpool.search.queue_size" value="100" />
```

Normalement, ces propriétés sont définies dans un fichier de paramètres personnalisé. Si vous connaissez bien Elasticsearch et le format de ses fichiers de propriétés, vous pouvez spécifier le chemin d'accès au fichier de paramètres à l'aide de la propriété JNDI **settingspath**, comme suit :

```xml
<jndiEntry jndiName="analytics/settingspath" value="/home/system/elasticsearch.yml" />
```

A moins que vous ne soyez un expert en gestion informatique Elasticsearch, que vous n'ayez identifié un besoin particulier ou que votre équipe de services ou de support vous l'ait demandé, ne modifiez pas ces paramètres.

## Sauvegarde des données d'analyse
{: #backing-up-analytics-data }
Apprenez à sauvegarder vos données {{ site.data.keys.mf_analytics }}.

Les données de {{ site.data.keys.mf_analytics }} sont stockées dans un ensemble de fichiers dans le système de fichiers de {{ site.data.keys.mf_analytics_server }}. L'emplacement de ce dossier est spécifié par la propriété JNDI datapath dans la configuration de {{ site.data.keys.mf_analytics_server }}. Pour plus d'informations sur les propriétés JNDI, voir [Propriétés de configuration](#configuration-properties).

La configuration de {{ site.data.keys.mf_analytics_server }} est également stockée dans le système de fichiers et est appelée server.xml.

Vous pouvez sauvegarder ces fichiers en suivant les procédures de sauvegarde de serveur existantes que vous avez peut-être déjà mises en place. Aucune procédure spéciale n'est requise lorsque vous sauvegardez ces fichiers ; il suffit de vous assurer que {{ site.data.keys.mf_analytics_server }} est arrêté. Si tel n'est pas le cas, les données peuvent être modifiées au cours de la sauvegarde et il se peut que les données stockées en mémoire ne soient pas encore écrites dans le système de fichiers. Pour éviter tout incohérence des données, arrêtez {{ site.data.keys.mf_analytics_server }} avant de lancer la sauvegarde.

## Gestion de cluster et Elasticsearch
{: #cluster-management-and-elasticsearch }
Gérez les clusters et ajoutez des noeuds pour alléger les contraintes de capacité et de mémoire.

### Ajout d'un noeud au cluster
{: #add-a-node-to-the-cluster }
Vous pouvez ajouter un nouveau noeud au cluster en installant {{ site.data.keys.mf_analytics_server }} ou en exécutant une instance Elasticsearch autonome.

Si vous optez pour l'instance Elasticsearch autonome, vous allégez certaines contraintes du cluster relatives aux exigences en matière de mémoire et de capacité, mais pas les contraintes relatives à l'ingestion de données. Les rapports de données doivent toujours passer par {{ site.data.keys.mf_analytics_server }} pour la préservation de l'intégration des données et l'optimisation des données avant d'être envoyés dans le stockage de persistance.

Vous pouvez combiner les éléments.

Le magasin de données Elasticsearch sous-jacent s'attend à ce que les noeuds soient homogènes ; par conséquent, n'associez pas un système d'armoires à 8 coeurs et 64 Go de mémoire RAM à un ordinateur portable excédentaire dans votre cluster. Utilisez un matériel similaire sur tous les noeuds.

#### Ajout d'un serveur {{ site.data.keys.mf_analytics_server }} au cluster
{: #adding-a-mobilefirst-analytics-server-to-the-cluster }
Apprenez à ajouter un serveur {{ site.data.keys.mf_analytics_server }} au cluster.

Etant donné qu'Elasticsearch est imbriqué dans {{ site.data.keys.mf_analytics_server }}, utilisez la configuration d'Elasticsearch pour définir le comportement du cluster. Par exemple, ne créez pas de parc de serveur WebSphere Application Server Liberty ou n'utilisez pas d'autres configurations de serveur d'applications.

Dans l'exemple d'instructions suivant, ne configurez pas le noeud en tant que noeud maître ou noeud de données. A la place, configurez le noeud comme "équilibreur de charge de recherche" dont le but est de s'exécuter provisoirement de sorte que l'API REST d'Elasticsearch soit exposée pour la surveillance et la configuration dynamique.

**Remarques :**

* Pensez à configurer le matériel et le système d'exploitation de ce noeud conformément à la [configuration système requise](../installation/#system-requirements).
* Le port 9600 est le port de transport utilisé par Elasticsearch. Par conséquent, il doit être accessible via tout pare-feu entre les noeuds de cluster.

1. Installez le fichier WAR du service d'analyse et le fichier WAR de l'interface utilisateur d'analyse (si vous voulez installer l'interface utilisateur) sur le serveur d'applications sur le nouveau système alloué. Installez cette instance de {{ site.data.keys.mf_analytics_server }} sur l'un des serveurs d'applications pris en charge.
    * [Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server Liberty](../installation/#installing-mobilefirst-analytics-on-websphere-application-server-liberty)
    * [Installation de {{ site.data.keys.mf_analytics }} sur Tomcat](../installation/#installing-mobilefirst-analytics-on-tomcat)
    * [Installation de {{ site.data.keys.mf_analytics }} sur WebSphere Application Server](../installation/#installing-mobilefirst-analytics-on-websphere-application-server)

2. Editez le fichier de configuration du serveur d'applications pour les propriétés JNDI (ou utilisez des variables d'environnement système) afin de configurer au moins les indicateurs suivants :

    | Indicateur | Valeur (exemple) | Valeur par défaut | Important |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	Cluster auquel ce noeud doit être ajouté. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Définissez la valeur false pour éviter tout ajout accidentel au cluster. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Aucune | 	Liste des noeuds maîtres dans le cluster existant. Changez le port par défaut 9600 si vous avez spécifié un paramètre de port de transport sur les noeuds maîtres. |
    | node.master | 	false | 	true | 	N'autorisez pas ce noeud à être un noeud maître. |
    | node.data|	false | 	true | 	N'autorisez pas ce noeud à stocker des données. |
    | http.enabled | 	true	 | true | 	Ouvrez le port HTTP non sécurisé 9200 pour l'API REST d'Elasticsearch. |

3. Examinez tous les indicateurs de configuration dans les scénarios de production. Il est préférable qu'Elasticsearch conserve les plug-in dans un répertoire de système de fichiers distinct de celui des données ; par conséquent, vous devez définir l'indicateur **path.plugins**.
4. Exécutez le serveur d'applications et démarrez les applications WAR si nécessaire.
5. Vérifiez que ce nouveau noeud a été ajouté au cluster en consultant la sortie de la console relative au nouveau noeud ou en observant le nombre de noeuds dans la section **Cluster et noeud** de la page **Administration** dans {{ site.data.keys.mf_analytics_console }}.

#### Ajout d'un noeud Elasticsearch autonome au cluster
{: #adding-a-stand-alone-elasticsearch-node-to-the-cluster }
Apprenez à ajouter un noeud Elasticsearch autonome au cluster.

Vous pouvez ajouter un noeud Elasticsearch autonome à votre cluster {{ site.data.keys.mf_analytics }} existant en quelques étapes simples. Vous devez toutefois choisir son rôle. S'agira-t-il d'un noeud éligible en tant que maître ? Si oui, pensez à éviter toute situation de cerveau dédoublé (ou split-brain). S'agira-t-il d'un noeud de données ? Ou d'un noeud de client seulement ? Avec un noeud de client seulement, vous pouvez démarrer un noeud temporairement afin d'exposer l'API REST d'Elasticsearch directement pour affecter les modifications de la configuration dynamique à votre cluster en cours d'exécution.

Dans l'exemple d'instructions suivant, ne configurez pas le noeud en tant que noeud maître ou noeud de données. A la place, configurez le noeud comme "équilibreur de charge de recherche" dont le but est de s'exécuter provisoirement de sorte que l'API REST d'Elasticsearch soit exposée pour la surveillance et la configuration dynamique.

**Remarques :**

* Pensez à configurer le matériel et le système d'exploitation de ce noeud conformément à la [configuration système requise](../installation/#system-requirements).
* Le port 9600 est le port de transport utilisé par Elasticsearch. Par conséquent, il doit être accessible via tout pare-feu entre les noeuds de cluster.

1. Téléchargez Elasticsearch depuis [https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz](https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz).
2. Décompressez le fichier.
3. Editez le fichier **config/elasticsearch.yml** et configurez au moins les indicateurs ci-dessous.

    | Indicateur | Valeur (exemple) | Valeur par défaut | Important |
    |------|-----------------|---------|------|
    | cluster.name | 	worklight	 | worklight | 	Cluster auquel ce noeud doit être ajouté. |
    | discovery.zen.ping.multicast.enabled | 	false | 	true | 	Définissez la valeur false pour éviter tout ajout accidentel au cluster. |
    | discovery.zen.ping.unicast.hosts | 	["9.8.7.6:9600"] | 	Aucune | 	Liste des noeuds maîtres dans le cluster existant. Changez le port par défaut 9600 si vous avez spécifié un paramètre de port de transport sur les noeuds maîtres. |
    | node.master | 	false | 	true | 	N'autorisez pas ce noeud à être un noeud maître. |
    | node.data|	false | 	true | 	N'autorisez pas ce noeud à stocker des données. |
    | http.enabled | 	true	 | true | 	Ouvrez le port HTTP non sécurisé 9200 pour l'API REST d'Elasticsearch. |


4. Examinez tous les indicateurs de configuration dans les scénarios de production. Il est préférable qu'Elasticsearch conserve les plug-in dans un répertoire de système de fichiers distinct de celui des données ; par conséquent, vous devez définir l'indicateur path.plugins.
5. Exécutez `./bin/plugin -i elasticsearch/elasticsearch-analytics-icu/2.7.0` pour installer le plug-in ICU.
6. Exécutez `./bin/elasticsearch`.
7. Vérifiez que ce nouveau noeud a été ajouté au cluster en consultant la sortie de la console relative au nouveau noeud ou en observant le nombre de noeuds dans la section **Cluster et noeud** de la page **Administration** dans {{ site.data.keys.mf_analytics_console }}.

#### Disjoncteurs
{: #circuit-breakers }
Découvrez les disjoncteurs Elasticsearch.

Elasticsearch contient plusieurs disjoncteurs qui sont utilisés pour empêcher les opérations de générer des **erreurs de mémoire insuffisante**). Par exemple, si une requête qui envoie des données à {{ site.data.keys.mf_console }} utilise 40 % du segment de mémoire de la machine virtuelle Java, le disjoncteur est déclenché, une exception est émise, et la console reçoit des données vides.

Elasticsearch dispose également de protections permettant d'éviter la saturation du disque. Si 90 % du disque sur lequel le magasin de données Elasticsearch écrit les données est rempli, le noeud Elasticsearch en informe le noeud maître dans le cluster. Le noeud maître dirige alors les nouvelles écritures de document ailleurs que vers le noeud presque plein. Si votre cluster ne comporte qu'un noeud, aucun noeud secondaire sur lequel les données peuvent être écrites n'est disponible. Par conséquent, les données ne sont pas écrites et sont perdues.
