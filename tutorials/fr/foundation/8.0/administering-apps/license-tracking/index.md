---
layout: tutorial
title: Suivi des licences
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Le suivi des licences est activé par défaut dans {{site.data.keys.product_full }}. Il assure le suivi des indicateurs relatifs aux règles de licence, tels que Terminal client actif, Terminal adressable et Application. Ces informations permettent de déterminer si l'utilisation actuelle de {{site.data.keys.product }} respecte les niveaux d'autorisation de licence et peuvent empêcher de potentielles violations de licence.

En outre, en assurant le suivi de l'utilisation des terminaux client et en déterminant si les terminaux sont actifs, les administrateurs {{site.data.keys.product_adj }} peuvent déclasser des terminaux qui n'accèdent plus au serveur {{site.data.keys.mf_server }}. Cette situation peut se produire si un employé quitte l'entreprise, par exemple.

#### Accéder à
{: #jump-to }

* [Définition des informations de licence d'application](#setting-the-application-license-information)
* [Rapport de suivi des licences](#license-tracking-report)
* [Validation de licence de jeton](#token-license-validation)
* [Intégration à IBM License Metric Tool](#integration-with-ibm-license-metric-tool)

## Définition des informations de licence d'application
{: #setting-the-application-license-information }
Apprenez à définir les informations de licence d'application des applications que vous enregistrez sur {{site.data.keys.mf_server }}.

Les termes de licence font la distinction entre {{site.data.keys.product_full }}, {{site.data.keys.product_full }} Consumer, {{site.data.keys.product_full }} Enterprise et IBM {{site.data.keys.product_adj }} Additional Brand Deployment. Définissez les informations de licence d'une application lorsque vous enregistrez cette dernière sur un serveur de sorte que les rapports de suivi de licence génèrent les informations de licence appropriées. Si votre serveur est configuré pour l'octroi de licence de jeton, les informations de licence sont utilisées pour réserver la fonction appropriée à partir du serveur de licences.

Vous définissez le type d'application et le type de licence de jeton.
Les valeurs possibles pour le type d'application sont les suivantes :  

* **B2C** : Utilisez ce type d'application si votre application s'utilise avec la licence {{site.data.keys.product_full }} Consumer.
* **B2E** : Utilisez ce type d'application si votre application s'utilise avec la licence {{site.data.keys.product_full }} Enterprise.
* **UNDEFINED** : Utilisez ce type d'application si vous n'avez pas besoin de mesurer la conformité à l'indicateur Terminal adressable.

Les valeurs possibles pour le type de licence de jeton sont les suivantes :

* **APPLICATION** : Utilisez APPLICATION pour la plupart des applications. Il s'agit de la valeur par défaut.
* **ADDITIONAL\_BRAND\_DEPLOYMENT** : Utilisez ADDITIONAL\_BRAND\_DEPLOYMENT si votre application s'utilise avec la licence IBM {{site.data.keys.product_adj }} Additional Brand Deployment.
* **NON_PRODUCTION** : Utilisez NON_PRODUCTION lorsque vous développez et testez l'application sur le serveur de production. Aucun jeton n'est réservé pour les applications dont le type de licence de jeton est NON_PRODUCTION.

> **Important :** Le fait d'utiliser NON_PRODUCTION pour une application de production constitue une violation des dispositions du contrat de licence.

**Remarque :** Si votre serveur est configuré pour l'octroi de licence de jeton et que vous prévoyez d'enregistrer une application avec un type de licence de jeton ADDITIONAL\_BRAND\_DEPLOYMENT ou NON_PRODUCTION, définissez les informations de licence d'application avant d'enregistrer la première version de l'application. Le programme mfpadm vous permet de définir les informations de licence d'une application avant qu'une version ne soit enregistrée. Une fois les informations de licence définies, le nombre approprié de jetons est réservé lorsque vous enregistrez la première version de l'application. Pour plus d'informations sur la validation de jeton, voir Validation de licence de jeton.

Pour définir le type de licence à l'aide de la console {{site.data.keys.mf_console }} :

1. Sélectionnez votre application
2. Sélectionnez **Paramètres**
3. Indiquez des valeurs dans les zones **Type d'application** et **Type de licence de jeton**
4. Cliquez sur **Sauvegarder**

Pour définir le type de licence à l'aide du programme mfpadm, utilisez `mfpadm app <appname> set license-config <application-type> <token license type>`

L'exemple suivant affecte aux informations de licence B2E / APPLICATION l'application nommée **my.test.application**

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## Rapport de suivi des licences
{: #license-tracking-report }
{{site.data.keys.product }} fournit un rapport de suivi des licences pour l'indicateur Terminal client, l'indicateur Terminal adressable et l'indicateur Application. Le rapport fournit également des données d'historique.

Le rapport de suivi des licences affiche les données suivantes :

* Nombre d'applications déployées sur le serveur {{site.data.keys.mf_server }}.
* Nombre de terminaux adressables dans le mois calendaire en cours.
* Nombre de terminaux client, actifs et déclassés.
* Nombre le plus élevé de terminaux client signalés au cours des n derniers jours, n étant le nombre de jours d'inactivité au terme duquel un terminal client est déclassé.

Vous souhaiterez peut-être analyser davantage vos données. Dans ce cas, vous pouvez recevoir par téléchargement un fichier CSV contenant les rapports de licence, ainsi qu'une liste historique des indicateurs de licence.

Pour accéder au rapport de suivi des licences :

1. Ouvrez {{site.data.keys.mf_console }}.
2. Cliquez sur le menu **Hello, your-Name**.
3. Sélectionnez **Licences**.

Pour obtenir un fichier CSV à partir du rapport de suivi des licences, cliquez sur **Actions/Télécharger le rapport
**.

## Validation de licence de jeton
{: #token-license-validation }
Si vous installez et configurez IBM {{site.data.keys.mf_server }} pour l'octroi de licence de jeton, le serveur valide des licences dans différents scénarios. Si votre configuration n'est pas correcte, la licence n'est pas validée lors de l'enregistrement ou de la suppression d'application.

### Scénarios de validation
{: #validation-scenarios }
Les licences sont validées dans différents scénarios :

#### Lors de l'enregistrement d'application
{: #on-application-registration }
L'enregistrement d'application échoue si le nombre de jetons disponibles pour le type de licence de jeton de votre application n'est pas suffisant.

> **Astuce :** Vous pouvez définir le type de licence de jeton avant d'enregistrer la première version de votre application.

Les licences ne sont réservées qu'une seule fois par application. Si vous enregistrez une nouvelle plateforme pour la même application, ou si vous enregistrez une nouvelle version pour une application et une plateforme existantes, aucun nouveau jeton n'est réclamé.

#### Lors de la modification du type de licence de jeton
{: #on-token-license-type-change }
Lorsque vous modifiez le type de licence de jeton pour une application, les jetons de l'application sont libérés, puis repris pour le nouveau type de licence.

#### Lors de la suppression d'application
{: #on-application-deletion }
Les licences sont restituées lorsque la dernière version d'une application est supprimée.

#### Lors du démarrage de serveur
{: #at-server-start }
La licence est réservée pour chaque application enregistrée. Le serveur désactive des applications si le nombre de jetons disponibles pour toutes les applications n'est pas suffisant.

> **Important :** Le serveur ne réactive pas automatiquement les applications. Lorsque vous augmentez le nombre de jetons disponibles, vous devez réactiver manuellement les applications. Pour plus d'informations sur la désactivation et l'activation d'applications, voir [Désactivation à distance de l'accès d'une application à des ressources protégées](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Lors de l'expiration de licence
{: #on-license-expiration }
Au bout d'un certain laps de temps, les licences arrivent à expiration et doivent être de nouveau réservées. Le serveur désactive des applications si le nombre de jetons disponibles pour toutes les applications n'est pas suffisant.

> **Important :** Le serveur ne réactive pas automatiquement les applications. Lorsque vous augmentez le nombre de jetons disponibles, vous devez réactiver manuellement les applications. Pour plus d'informations sur la désactivation et l'activation d'applications, voir [Désactivation à distance de l'accès d'une application à des ressources protégées](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Lors du démarrage de serveur
{: #at-server-shutdown }
La licence est restituée pour chaque application déployée au cours d'un arrêt de serveur. Les jetons ne sont libérés que lorsque le dernier serveur d'un cluster d'un parc de serveurs est arrêté.

### Causes des échecs de validation de licence
{: #causes-of-license-validation-failure }
Une validation de licence peut échouer lorsque l'application est enregistrée ou supprimée, dans les cas suivants :

* La bibliothèque native Rational Common Licensing n'est pas installée ni configurée.
* Le service d'administration n'est pas configuré pour l'octroi de licence de jeton. Pour plus d'informations, voir[Installation et configuration pour l'octroi de licence de jeton](../../installation-configuration/production/token-licensing).
* Rational License Key Server n'est pas accessible.
* Le nombre de jetons disponibles n'est pas suffisant.
* La licence a expiré.

### Nom de fonction IBM Rational License Key Server utilisé par {{site.data.keys.product_full }}
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
Selon le type de licence de jeton d'une application, les fonctions suivantes sont utilisées :

| Type de licence de jeton | Nom de fonction | 
|--------------------|--------------|
| APPLICATION        | 	ibmmfpfa    | 
| ADDITIONAL\_BRAND\_DEPLOYMENT |	ibmmfpabd | 
| NON_PRODUCTION	| (aucune fonction) | 

## Intégration à IBM License Metric Tool
{: #integration-with-ibm-license-metric-tool }
IBM License Metric Tool vous permet d'évaluer votre conformité à votre licence IBM.

Si vous n'avez pas installé une version d'IBM License Metric Tool prenant en charge les fichiers IBM Software License Metric Tag ou SWID (identification logicielle), vous pouvez examiner l'utilisation de licence avec les rapports de suivi des licences dans la console {{site.data.keys.mf_console }}. Pour plus d'informations, voir [Rapport de suivi des licences](#license-tracking-report).

### A propos de l'octroi de licence par unité de valeur par coeur de processeur à l'aide de fichiers SWID
{: #about-pvu-based-licensing-using-swid-files }
Si vous avez acquis une offre IBM MobileFirst Foundation Extension V8.0.0, elle est fournie sous licence par unité de valeur par coeur de processeur.

Le calcul de PVU est basé sur le support IBM License Metric Tool pour la norme ISO/IEC 19970-2 et les fichiers SWID. Les fichiers SWID sont écrits sur le serveur lorsque IBM Installation Manager installe {{site.data.keys.mf_server }} ou {{site.data.keys.mf_analytics_server }}. Lorsque IBM License Metric Tool détecte un fichier SWID non valide pour un produit par rapport au catalogue en cours, un signe d'avertissement s'affiche sur le widget Software Catalog. Pour plus d'informations sur le fonctionnement d'IBM License Metric Tool avec des fichiers SWID, voir [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html).

Le nombre d'installations Application Center n'est pas limité par l'octroi de licence par unité de valeur par coeur de processeur.

La licence d'unité de valeur par coeur de processeur pour Foundation Extension ne peut être achetée qu'avec les licences de produit suivantes : IBM WebSphere Application Server Network Deployment, IBM API Connect™ Professional ou IBM API Connect Enterprise. IBM Installation Manager ajoute ou met à jour le fichier SWID qui doit être utilisé par License Metric Tool.

> Pour plus d'informations sur {{site.data.keys.product_full }} Extension, voir [https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN).

> Pour plus d'informations sur l'octroi de licence par unité de valeur par coeur de processeur, voir [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html).

### Etiquettes SLMT
{: #slmt-tags }
IBM MobileFirst Foundation génère des fichiers SLMT (IBM Software License Metric Tag). Les versions d'IBM License
Metric Tool qui prennent en charge IBM Software License Metric Tag peuvent générer des rapports de consommation de licences. Lisez cette section afin d'interpréter ces rapports pour {{site.data.keys.mf_server }} et de configurer la génération des fichiers IBM Software License Metric Tag.

Chaque instance d'un environnement d'exécution MobileFirst actif génère un fichier IBM Software License Metric Tag. Les indicateurs surveillés sont`CLIENT_DEVICE`, `ADDRESSABLE_DEVICE` et `APPLICATION`. Leurs valeurs sont actualisées toutes les 24 heures.

#### A propos de l'indicateur CLIENT_DEVICE
{: #about-the-client_device-metric }
L'indicateur `CLIENT_DEVICE` peut posséder les sous-types suivants :

* Terminaux actifs

    Nombre de terminaux client qui utilisaient l'environnement d'exécution MobileFirst, ou toute autre instance d'exécution MobileFirst appartenant au même cluster ou parc de serveurs, et qui n'ont pas été déclassés. Pour plus d'informations sur les terminaux déclassés, voir[Configuration du suivi des licences pour un terminal client et un terminal adressable](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

* Terminaux inactifs

    Nombre de terminaux client qui utilisaient l'environnement d'exécution MobileFirst, ou toute autre instance d'exécution MobileFirst appartenant au même cluster ou parc de serveurs, et qui ont été déclassés. Pour plus d'informations sur les terminaux déclassés, voir[Configuration du suivi des licences pour un terminal client et un terminal adressable](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

Les cas suivants sont spécifiques :

* Si la période de déclassement du terminal est réduite, le sous-type "Terminaux inactifs" est remplacé par le sous-type "Terminaux actifs ou inactifs".
* Si le suivi des terminaux a été désactivé, une seule entrée est générée pour `CLIENT_DEVICE`, avec la valeur 0 et le sous-type d'indicateur "Suivi des terminaux désactivé".

#### A propos de l'indicateur APPLICATION
{: #about-the-application-metric }
L'indicateur APPLICATION ne comporte aucun sous-type sauf si l'environnement d'exécution MobileFirst s'exécute dans un serveur de développement.

La valeur signalée pour cet indicateur est le nombre d'applications déployées dans l'environnement d'exécution MobileFirst. Chaque application est comptabilisée comme une seule unité, qu'il s'agisse d'une nouvelle application, d'un déploiement de marque supplémentaire ou d'un type supplémentaire d'une application existante (par exemple, native, hybride ou Web).

#### A propos de l'indicateur ADDRESSABLE_DEVICE
{: #about-the-addressable_device-metric }
L'indicateur ADDRESSABLE_DEVICE comporte le sous-type suivant :

* Application : `<applicationName>`, Catégorie : `<application type>`

Le type d'application est **B2C**, **B2E** ou **UNDEFINED**. Pour définir le type d'application d'une application, voir [Définition des informations de licence d'application](#setting-the-application-license-information).

Les cas suivants sont spécifiques :

* Si la période de déclassement du service est inférieure à 30 jours, l'avertissement "Short decommissioning period" est ajouté au sous-type.
* Si le suivi des licences est désactivé, aucun rapport adressable n'est généré.

Pour plus d'informations sur la configuration du suivi des licences à l'aide d'indicateurs, voir

* [Configuration du suivi des licences pour un terminal client et un terminal adressable](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [Configuration de fichiers journaux IBM License Metric Tool](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
