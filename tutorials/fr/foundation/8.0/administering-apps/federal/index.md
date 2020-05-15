---
layout: tutorial
title: Prise en charge de normes fédérales dans MobileFirst Foundation
breadcrumb_title: Prise en charge de normes fédérales
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
{{ site.data.keys.product_full }} prend en charge les spécifications FDCC (Federal Desktop Core Configuration) et USGCB (United States Government Configuration Baseline). {{ site.data.keys.product }} prend également en charge la norme de sécurité FIPS (Federal Information Processing Standards) 140-2, utilisée pour accréditer des modules cryptographiques.

#### Accéder à
{: #jump-to }

* [Prise en charge des spécifications FDCC et USGCB](#fdcc-and-usgcb-support)
* [Prise en charge de la norme FIPS 140-2](#fips-140-2-support)
* [Activation de la norme FIPS 140-2](#enabling-fips-140-2)
* [Configuration du mode FIPS 140-2 pour le chiffrement HTTPS et JSONStore](#configure-fips-140-2-mode-for-https-and-jsonstore-encryption)
* [Configuration de FIPS 140-2 pour des applications existantes](#configuring-fips-140-2-for-existing-applications)

## Prise en charge des spécifications FDCC et USGCB
{: #fdcc-and-usgcb-support }
Le gouvernement fédéral des États-Unis stipule que les bureaux d'agence fédérale qui s'exécutent sur des plateformes Microsoft Windows doivent adopter la spécification FDCC (Federal Desktop Core Configuration) ou les paramètres de sécurité plus récents USGCB (United States Government Configuration Baseline).

IBM Worklight V5.0.6 a été testé à l'aide des paramètres de sécurité USGCB et FDCC via un processus d'auto-certification. Ce processus prévoit un niveau raisonnable de tests visant à s'assurer que l'installation et les fonctions de base fonctionnent sur cette configuration.

#### Références
{: #references }
Pour plus d'informations, voir [USGCB](http://usgcb.nist.gov/).

## Prise en charge de la norme FIPS 140-2
{: #fips-140-2-support }
Les normes FIPS (Federal Information Processing Standards) sont des instructions publiées par le NIST (National Institute of Standards and Technology) des Etats-Unis pour les systèmes informatiques du gouvernement fédéral. La publication FIPS 140-2 est une norme de sécurité utilisée pour accréditer des modules cryptographiques. {{ site.data.keys.product }} fournit la prise en charge de la norme FIPS 140-2 pour les applications Android et iOS Cordova.

### Norme FIPS 140-2 sur le serveur {{ site.data.keys.mf_server }} et communications SSL avec le serveur {{ site.data.keys.mf_server }}
{: #fips-140-2-on-the-mobilefirst-server-and-ssl-communications-with-the-mobilefirst-server }
{{ site.data.keys.mf_server }} s'exécute dans un serveur d'applications, tel que WebSphere Application Server. WebSphere Application Server peut être configuré pour imposer l'utilisation de modules cryptographiques validés par la norme FIPS 140-2 pour les connexions SSL (Secure Socket Layer) entrantes et sortantes. Les modules cryptographiques sont également utilisés pour les opérations de chiffrement effectuées par les applications à l'aide de JCE (Java Cryptography Extension). Etant donné que {{ site.data.keys.mf_server }} est une application qui s'exécute sur le serveur d'applications, il utilise les modules cryptographiques validés par FIPS 140-2 pour les connexions SSL entrantes et sortantes.

Lorsqu'un client {{ site.data.keys.product_adj }} négocie une connexion SSL (Secure Socket Layer) avec un serveur {{ site.data.keys.mf_server }}, qui s'exécute sur un serveur d'applications utilisant le mode FIPS 140-2, il en résulte une utilisation réussie de la suite de chiffrement approuvée par FIPS 140-2. Si la plateforme client ne prend pas en charge l'une des suites de chiffrement approuvées par FIPS 140-2, la transaction SSL échoue et le client ne peut pas établir de connexion SSL au serveur. Dans le cas contraire, le client utilise une suite de chiffrement approuvée par FIPS 140-2.

> **Remarque :** Les instances de module cryptographique utilisées sur le client ne sont pas nécessairement validées par FIPS 140-2. Pour connaître les options permettant d'utiliser les bibliothèques validées par FIPS 140-2 sur des appareils client, voir les informations décrites ci-après.

Précisément, le client et le serveur utilisent la même suite de chiffrement (SSL_RSA_WITH_AES_128_CBC_SHA par exemple), mais il se peut que le module cryptographique côté client n'ait pas réussi le processus de validation FIPS 140-2, alors que le côté serveur utilise des modules certifiés par FIPS 140-2.

### Norme FIPS 140-2 sur l'appareil client {{ site.data.keys.product_adj }} pour assurer la protection des données inactives dans JSONStore et des données dynamiques lors de l'utilisation de communications HTTPS
{: #fips-140-2-on-the-mobilefirst-client-device-for-protection-of-data-at-rest-in-jsonstore-and-data-in-motion-when-using-https-communications }
La protection des données inactives sur l'appareil client est assurée par la fonction JSONStore de {{ site.data.keys.product }}. La protection des données dynamiques est assurée par l'utilisation d'une communication HTTPS entre le client {{ site.data.keys.product_adj }} et le serveur{{ site.data.keys.mf_server }}.

Sur les appareils iOS, la prise en charge de la norme FIPS 140-2 est activée par défaut pour les données inactives et les données dynamiques.

Les appareils Android utilisent par défaut des bibliothèques validées par une norme non FIPS 140-2. Il existe une option permettant d'utiliser des bibliothèques validées par la norme FIPS 140-2 pour la protection (chiffrement et déchiffrement) des données locales stockées par JSONStore et pour la communication HTTPS avec le serveur {{ site.data.keys.mf_server }}. Cette prise en charge est obtenue via l'utilisation d'une bibliothèque OpenSSL conforme à la validation par FIPS 140-2 (certification n° 1747). Pour activer cette option dans un projet client {{ site.data.keys.product_adj }}, ajoutez le plug-in Android FIPS 140-2 facultatif.

**Remarque :** Certaines restrictions doivent être prises en compte :

* Le mode validé FIPS 140-2 ne s'applique qu'à la protection (chiffrement) des données locales qui sont stockées par la fonction JSONStore et à la protection des communications HTTPS entre le client {{ site.data.keys.product_adj }} et le serveur {{ site.data.keys.mf_server }}.
* Cette fonction n'est prise en charge que sur les plateformes iOS et Android.
    * Sous Android, cette fonction n'est prise en charge que sur des appareils ou des simulateurs utilisant l'architecture x86 ou armeabi. Elle n'est pas prise en charge sous Android avec une architecture armv5 ou armv6. C'est parce que la bibliothèque OpenSSL utilisée n'a pas obtenu la validation FIPS 140-2 pour armv5 ou armv6 sous Android. La norme FIPS 140-2 n'est pas encore prise en charge dans l'architecture 64 bits, même si la bibliothèque {{ site.data.keys.product_adj }} prend en charge l'architecture 64 bits. La norme FIPS 140-2 peut être exécutée sur des appareils 64 bits s'il n'existe que des bibliothèques NDK natives 32 bits dans le projet.
    * Sous iOS, elle est prise en charge dans les architectures i386, x86_64, armv7, armv7s et arm64.
* Cette fonction n'est opérationnelle qu'avec des applications hybrides (non natives).
* Pour l'iOS natif, FIPS est activé à travers les bibliothèques FIPS iOS et est activé par défaut. Aucune action n'est nécessaire pour activer FIPS 140-2.
* Pour les communications HTTPS :
    * Pour les appareils Android, seules les communications entre le client {{ site.data.keys.product_adj }} et le serveur {{ site.data.keys.mf_server }} utilisent les bibliothèques FIPS 140-2 sur le client. Les connexions directes aux autres serveurs ou services n'utilisent pas de bibliothèques FIPS 140-2.
    * Le client {{ site.data.keys.product_adj }} peut uniquement communiquer avec un serveur {{ site.data.keys.mf_server }} qui s'exécute dans des environnements pris en charge et répertoriés dans [Configuration requise](http://www-01.ibm.com/support/docview.wss?uid=swg27024838). Si le serveur {{ site.data.keys.mf_server }} s'exécute dans un environnement non pris en charge, la connexion HTTPS peut échouer avec une erreur de taille de clé trop petite. Cette erreur ne se produit pas avec les communications HTTP.
* Le client {{ site.data.keys.mf_app_center_full }} ne prend pas en charge la fonction FIPS 140-2.

Si vous avez déjà effectué les modifications décrites dans le tutoriel, vous devez d'abord sauvegarder les autres modifications propres à l'environnement que vous avez éventuellement apportées, puis supprimer et recréer vos environnements Android ou iOS.

![Diagramme FIPS](FIPS.jpg)

> Pour plus d'informations sur JSONStore, voir [Présentation de JSONStore](../../application-development/jsonstore).

## Références
{: #references-1 }
Pour savoir comment activer le mode FIPS 140-2 dans WebSphere Application Server, voir [Support FIPS (Federal Information Processing Standard)](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/rovr_fips.html).

Pour le profil WebSphere Application Server Liberty, aucune option n'est disponible dans la console d'administration pour activer le mode FIPS 140-2. Mais, vous pouvez activer le mode FIPS 140-2 en configurant l'environnement d'exécution Java™ de manière à utiliser les modules validés par la norme FIPS 140-2. Pour plus d'informations, voir le document Java Secure Socket Extension (JSSE) IBMJSSE2 Provider Reference Guide.

## Activation de la norme FIPS 140-2
{: #enabling-fips-140-2 }
Sur les appareils iOS, la prise en charge de la norme FIPS 140-2 est activée par défaut pour les données inactives et les données dynamiques.  
Pour les appareils Android, ajoutez le plug-in Cordova `cordova-plugin-mfp-fips`.

Une fois ajoutée, la fonction s'applique aux mécanismes de chiffrement de données HTTPS et JSONStore.

**Remarques :** 

* La norme FIPS 140-2 est prise en charge uniquement sous Android et iOS. Les architectures iOS qui prennent en charge la norme FIPS 140-2 sont i386, armv7, armv7s, x86_64 et arm64. Les architectures Android qui prennent en charge la norme FIPS 140-2 sont x86 et armeambi.
* Sous Android, la norme FIPS 140-2 n'est pas prise en charge sur l'architecture 64 bits même si la bibliothèque {{ site.data.keys.product_adj }} prend effectivement en charge l'architecture 64 bits. Lorsque vous utilisez la norme FIPS 140-2 sur un appareil 64 bits, l'erreur suivante peut se produire : 
        
```bash
java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit
```

Cette erreur signifie que vous avez des bibliothèques natives 64 bits dans votre projet Android et que la norme FIPS 140-2 ne fonctionne pas actuellement lorsque vous utilisez ces bibliothèques. Pour confirmation, accédez au répertoire src/main/libs ou src/main/jniLibs sous votre projet Android et vérifiez l'existence des dossiers x86_64 ou arm64-v8a. Si ces dossiers existent, supprimez-les. La norme FIPS 140-2 fonctionnera de nouveau.

## Configuration du mode FIPS 140-2 pour le chiffrement HTTPS et JSONStore
{: #configure-fips-140-2-mode-for-https-and-jsonstore-encryption }
Pour les applications iOS, la norme FIPS 140-2 est activée via les bibliothèques FIPS iOS. Elle est activée par défaut et aucune action n'est nécessaire pour l'activer ou la configurer.

Le fragment de code suivant est rempli dans une nouvelle application {{ site.data.keys.product_adj }} dans l'objet initOptions du fichier index.js pour le système d'exploitation Android afin de configurer la norme FIPS 140-2 :

```javascript
var wlInitOptions = {
  ...
  // # Enable FIPS 140-2 for data-in-motion (network) and data-at-rest (JSONStore) on Android.
  //   Requires the FIPS 140-2 optional feature to be enabled also.
  // enableFIPS : false
  ...
};
```

La valeur par défaut de **enableFIPS** est `false` pour le système d'exploitation Android. Pour activer la norme FIPS 140-2 pour les mécanismes de chiffrement de données HTTPS et JSONStore, supprimez la mise en commentaire et affectez à l'option la valeur `true`. Après avoir affecté la valeur `true` à **enableFIPS**, il est recommandé d'écouter l'événement JavaScript prêt pour FIPS en créant un événement d'écoute similaire à l'exemple suivant :

```javascript
document.addEventListener('WL/FIPS/READY', 
    this.onFipsReady, false);

onFipsReady: function() {
  // FIPS SDK is loaded and ready
}
```

Après avoir défini la valeur de la propriété **enableFIPS**, régénérez la plateforme Android.

**Remarque : **Vous devez installer le plug-in FIPS Cordova avant d'affecter la valeur true à la propriété enableFIP. Sinon, un message d'avertissement est consigné pour indiquer que la valeur initOption est définie, mais que la fonction facultative est introuvable. Les fonctions FIPS 140-2 et JSONStore sont facultatives sur le système d'exploitation Android. La norme FIPS 140-2 affecte le chiffrement de données JSONStore uniquement si la fonction facultative JSONStore est également activée. Si la fonction JSONStore n'est pas activée, elle n'est pas affectée par la norme FIPS 140-2. Sous iOS, la fonction facultative FIPS 140-2 n'est pas requise pour le chiffrement JSONStore FIPS 140-2 (données inactives) ou HTTPS (données dynamiques) car ces deux mécanismes sont gérés par iOS. Sous Android, vous devez activer la fonction facultative FIPS 140-2 si vous souhaitez utiliser le chiffrement JSONStore FIPS 140-2 ou HTTPS.

```bash
[WARN] FIPSHttp feature not found, but initOptions enables it on startup
```

## Configuration de norme FIPS 140-2 pour des applications existantes
{: #configuring-fips-140-2-for-existing-applications }
La fonction facultative FIPS 140-2 n'est pas activée par défaut sur des applications créées pour n'importe quelle version du système d'exploitation Android et sur des applications iOS dans les versions d'{{ site.data.keys.product_full }} antérieures à la version 8.0. Pour activer la fonction facultative FIPS 140-2 pour le système d'exploitation Android, voir Activation de la norme FIPS 140-2. Une fois la fonction facultative activée, vous pouvez configurer la norme FIPS 140-2.

Une fois que vous avez exécuté les étapes décrites dans la section Activation de la norme FIPS 140-2, vous devez configurer la norme FIPS 140-2 en modifiant l'objet initOptions dans le fichier index.js afin d'ajouter la propriété de configuration FIPS.

**Remarque :** La fonction FIPS 140-2, combinée à la fonction JSONStore, active la prise en charge de la norme FIPS 140-2 pour JSONStore. Cette combinaison remplace ce qui était indiqué dans le tutoriel JSONStore - Chiffrement de données sensibles avec la norme FIPS 140-2, disponible pour IBM Worklight V6.0 ou antérieure. Si vous aviez précédemment modifié une application en suivant les instructions décrites dans ce tutoriel, supprimez et recréez ses environnements iPhone, iPad et Android. Etant donné que les modifications propres aux environnements que vous avez précédemment effectuées sont perdues lorsque vous supprimez un environnement, prenez soin de sauvegarder ce type de modification avant de supprimer un environnement. Une fois l'environnement recréé, vous pouvez réappliquer ces modifications au nouvel environnement.

Ajoutez la propriété suivante à l'objet initOptions trouvé dans le fichier index.js.

```javascript
enableFIPS : true
```

Régénérez la plateforme Android.
