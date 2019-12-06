---
layout: tutorial
title: Traitement des incidents liés à JSONStore
breadcrumb_title: JSONStore
relevantTo: [ios,android,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous trouverez ici des informations qui vous aideront à résoudre les problèmes que vous êtes susceptible de rencontrer lors de l'utilisation de l'API JSONStore.

## Fournissez des informations lorsque vous demandez de l'aide
{: #provide-information-when-you-ask-for-help }
Il vaut mieux fournir trop d'informations que risquer de n'en fournir pas assez. La liste ci-après est un bon point de départ pour savoir quelles informations sont requises lorsque vous demandez de l'aide concernant des problèmes liés à JSONStore.

* Système d'exploitation et version. Par exemple, Windows XP SP3 Virtual Machine ou Mac OSX 10.8.3.
* Version d'Eclipse. Par exemple, Eclipse Indigo 3.7 Java EE.
* Version du kit Java Development Kit. Par exemple, Java SE Runtime Environment (génération 1.7).
* Version d'{{ site.data.keys.product }}. Par exemple, IBM Worklight V5.0.6 Developer Edition.
* Version d'iOS. Par exemple, iOS Simulator 6.1 ou iPhone 4S iOS 6.0 (déprécié, voir Fonctions et éléments d'API dépréciés).
* Version d'Android. Exemple : Android Emulator 4.1.1 ou Samsung Galaxy Android 4.0 API niveau 14.
* Version de Windows. Par exemple, Windows 8, Windows 8.1 ou Windows Phone 8.1.
* Version d'adb. Exemple : Android Debug Bridge version 1.0.31.
* Journaux, tels que la sortie Xcode sous iOS ou la sortie logcat sous Android.

## Essayez d'isoler le problème
{: #try-to-isolate-the-issue }
Procédez comme suit afin d'isoler le problème et de le signaler plus précisément.

1. Réinitialisez l'émulateur (Android) ou le simulateur (iOS) et appelez l'API destroy pour commencer avec un système propre.
2. Vous devez vous trouver dans un environnement de production pris en charge.
    * Android >= émulateur ou appareil 2.3 ARM v7/ARM v8/x86
    * iOS >= simulateur ou appareil 6.0 (déprécié)
    * Windows : simulateur ou appareil 8.1/10 ARM/x86/x64
3. Essayez de désactiver le chiffrement en ne transmettant pas de mot de passe à l'API init ou open.
4. Reportez-vous au fichier de base de données SQLite généré par JSONStore. Le chiffrement doit être désactivé.

   * Emulateur Android :

   ```bash
   $ adb shell
   $ cd /data/data/com.<app-name>/databases/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * Simulateur iOS :

   ```bash
   $ cd ~/Library/Application Support/iPhone Simulator/7.1/Applications/<id>/Documents/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```  

   * Simulateur Windows 8.1 Universal / Windows 10 UWP

   ```bash
   $ cd C:\Users\<username>\AppData\Local\Packages\<id>\LocalState\wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * **Remarque :** L'unique implémentation de JavaScript qui s'exécute sur un navigateur Web (Firefox, Chrome, Safari, Internet Explorer) n'utilise pas de base de données SQLite. Le fichier est stocké dans HTML5 LocalStorage.
   * Consultez `searchFields` avec `.schema` et sélectionnez des données à l'aide de `SELECT * FROM <collection-name>;`. Pour quitter sqlite3, entrez `.exit`. Si vous transmettez un nom d'utilisateur à la méthode init, le fichier est nommé **the-username.sqlite**. Si vous ne transmettez pas de nom d'utilisateur, le fichier est appelé **jsonstore.sqlite** par défaut.
5. (Android seulement) Activez le journal prolixe de JSONStore.

   ```bash
   adb shell setprop log.tag.jsonstore-core VERBOSE
   adb shell getprop log.tag.jsonstore-core
   ```

6. Utilisez le débogueur.

## Problèmes courants
{: #common-issues }
La compréhension des caractéristiques JSONStore suivantes peut vous aider à résoudre certains problèmes courants que vous pouvez rencontrer.  

* Pour stocker des données binaires dans JSONStore, vous devez d'abord les coder en base64. Stockez les chemins d'accès et les noms de fichier au lieu des fichiers réels dans JSONStore.
* L'accès aux données JSONStore depuis le code natif n'est possible que dans {{ site.data.keys.v62_product_full }} version 6.2.0.
* La quantité de données que vous pouvez stocker dans JSONStore n'est pas limitée, en dehors des limites imposées par le système d'exploitation mobile.
* JSONStore fournit un stockage de persistance des données. Les données ne sont pas seulement stockées en mémoire.
* L'API init échoue si le nom de la collection commence par un chiffre ou un symbole. IBM Worklight versions 5.0.6.1 et ultérieures renvoient une erreur appropriée : `4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING`
* Les zones de recherche différencient les nombres et les entiers. Les valeurs numériques telles que `1` et `2` sont stockées sous la forme `1.0` et `2.0` lorsque le type est `number`. Elles sont stockées sous la forme `1` et `2` lorsque le type est `integer`.
* Si une application est forcée de s'arrêter ou tombe en panne, elle échoue toujours avec le code d'erreur -1 lorsqu'elle est redémarrée et que l'API `init` ou `open` est appelée. Si ce problème survient, appelez d'abord l'API `closeAll`.
* L'implémentation JavaScript de JSONStore s'attend à ce que le code soit appelé en série. Attendez que l'opération en cours se termine avant d'appeler la suivante.
* Les transactions ne sont pas prises en charge dans Android 2.3.x pour les applications Cordova.
* Lorsque vous utilisez JSONStore sur un appareil 64 bits, l'erreur suivante peut s'afficher : `java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit`
* Cette erreur signifie que vous disposez de bibliothèques natives 64 bits dans votre projet Android et que JSONStore ne fonctionne pas lorsque vous utilisez ces bibliothèques. Pour confirmation, accédez au répertoire **src/main/libs** ou **src/main/jniLibs** sous votre projet Android et vérifiez si le dossier x86_64 ou arm64-v8a existe. Si tel est le cas, supprimez-le ; JSONStore fonctionnera à nouveau.
* Dans certains cas (ou environnements), le flux entre `wlCommonInit()` avant l'initialisation du plug-in JSONStore. Cela entraîne l'échec des appels d'API liés à JSONStore. L'amorçage de `cordova-plugin-mfp` appelle automatiquement `WL.Client.init`, qui, une fois terminé, déclenche la fonction `wlCommonInit`. Ce processus d'initialisation est différent pour le plug-in JSONStore. En effet, ce dernier ne dispose d'aucun moyen d'arrêter (_halt_) l'appel de `WL.Client.init`. Dans certains environnements, il peut arriver que le flux indique `wlCommonInit()` avant la fin de `mfpjsonjslloaded`. Pour garantir
l'ordre des événements `mfpjsonjsloaded` et `mfpjsloaded`, le développeur a la possibilité d'appeler manuellement `WL.CLient.init`. Il n'est 
alors plus nécessaire de disposer d'un code spécifique à la plateforme.

  Pour configurer l'appel de `WL.CLient.init` manuellement, suivez les étapes ci-après :                             

  1. Dans `config.xml`, modifiez la propriété `clientCustomInit` et définissez-la sur **true**.

  + Dans le fichier `index.js` :                                   
    * ajoutez la ligne suivante au début du fichier :                
      ```javascript
      document.addEventListener('mfpjsonjsloaded', initWL, false);
      ```           
    * laissez l'appel de `WL.JSONStore.init` dans `wlCommonInit()`                    

    * ajoutez la fonction suivante :  
    ```javascript                                         
function initWL(){                                                     
        var options = typeof wlInitOptions !== 'undefined' ? wlInitOptions
        : {};                                                                
        WL.Client.init(options);                                           
}                                                                      
```                                                                       

Cela permet d'attendre l'événement `mfpjsonjsloaded` (en dehors de `wlCommonInit`),
ce qui garantit le chargement du script et appelle ensuite `WL.Client.init` qui déclenchera `wlCommonInit`, qui appellera ensuite `WL.JSONStore.init`.

## Eléments internes du magasin
{: #store-internals }
Voici un exemple de stockage des données JSONStore.

Eléments principaux dans cet exemple simplifié :

* `_id` est l'identificateur unique (par exemple, AUTO INCREMENT PRIMARY KEY).
* `json`  contient une représentation exacte de l'objet JSON stocké.
* `name` et age sont des zones de recherche.
* `key` est une zone de recherche supplémentaire.

| _id | key | name | age | JSON |
|-----|-----|------|-----|------|
| 1   | c   | carlos | 99 | {name: 'carlos', age: 99} |
| 2   | t   | tim   | 100 | {name: 'tim', age: 100} |

Lorsque vous effectuez une recherche à l'aide de l'une ou d'une combinaison des requêtes suivantes : `{_id : 1}, {name: 'carlos'}`, `{age: 99}, {key: 'c'}`, le document renvoyé est `{_id: 1, json: {name: 'carlos', age: 99} }`.

Les autres zones JSONStore internes sont :

* `_dirty` : Détermine si le document a été signalé comme modifié ou non. Cette zone est utile pour assurer le suivi des modifications apportées aux documents.
* `_deleted` : Signale un document comme supprimé ou non. Cette zone est utile pour retirer des objets d'une collection afin de les utiliser ultérieurement pour assurer le suivi des modifications avec votre système de back end et décider de les retirer ou non.
* `_operation` : Chaîne qui reflète la dernière opération effectuée sur le document (par exemple, un remplacement).

## Erreurs JSONStore
{: #jsonstore-errors }
### JavaScript
{: #javascript }
JSONStore utilise un objet erreur pour renvoyer des messages sur la cause des échecs.

Lorsqu'une erreur survient au cours d'une opération JSONStore (par exemple, les méthodes `find` et `add` dans la classe `JSONStoreInstance`), un objet erreur est renvoyé. Il fournit des informations sur la cause de l'échec.

```javascript
var errorObject = {
  src: 'find', // Operation that failed.
  err: -50, // Error code.
  msg: 'PERSISTENT\_STORE\_FAILURE', // Error message.
  col: 'people', // Collection name.
  usr: 'jsonstore', // User name.
  doc: {_id: 1, {name: 'carlos', age: 99}}, // Document that is related to the failure.
  res: {...} // Response from the server.
}
```

Les paires clé-valeur n'apparaissent pas toutes dans chaque objet erreur. Par exemple, la valeur doc est disponible uniquement lorsque l'opération échoue après l'échec d'un document (par exemple, la méthode `remove` dans la classe `JSONStoreInstance`) qui n'est pas parvenu à retirer un document.

### Objective-C
{: #objective-c }
Toutes les API pouvant échouer admettent un paramètre d'erreur dont la valeur est une adresse vers un objet NSError. Si vous ne voulez pas être averti des erreurs, vous pouvez transmettre la valeur `nil`. Lorsqu'une opération échoue, l'adresse est remplie avec un objet NSError, qui comporte une erreur et potentiellement un objet `userInfo`. L'objet `userInfo` peut contenir des détails supplémentaires (par exemple, le document à l'origine de l'erreur).

```objc
// This NSError points to an error if one occurs.
NSError* error = nil;

// Perform the destroy.
[JSONStore destroyDataAndReturnError:&error];
```

### Java
{: #java }
Tous les appels d'API Java lancent une certaine exception, selon l'erreur qui s'est produite. Vous pouvez traiter chaque exception séparément, ou intercepter `JSONStoreException` pour toutes les autres exceptions JSONStore.

```java
try {
  WL.JSONStore.closeAll();
}

catch(JSONStoreException e) {
  // Handle error condition.
}
```

### Liste des codes d'erreur
{: #list-of-error-codes }
Liste des codes d'erreur courants et leur description :

|Code d'erreur      | Description |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | Erreur non reconnue. |
| -75 OS\_SECURITY\_FAILURE | Ce code d'erreur est lié à l'indicateur requireOperatingSystemSecurity. Il peut être émis si l'API ne parvient pas à supprimer des métadonnées de sécurité qui sont protégées par la fonction de sécurité du système d'exploitation (Touch ID avec rétromigration vers le code d'accès) ou si l'API init ou open ne parvient pas à localiser les métadonnées de sécurité. Il peut également être émis si l'appareil ne prend pas en charge la fonction de sécurité du système d'exploitation, alors que l'utilisation de cette fonction a été demandée. |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore est fermé. Essayez d'abord d'appeler la méthode open dans la classe JSONStore pour activer l'accès au magasin. |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | Un problème est survenu lors de l'annulation de la transaction. |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION | Impossible d'appeler removeCollection lorsqu'une transaction est en cours. |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | Impossible d'appeler destroy lorsque des transactions sont en cours. |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | Impossible d'appeler closeAll lorsque des transactions sont en place. |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | Impossible d'initialiser un magasin lorsque des transactions sont en cours. |
| -43 TRANSACTION_FAILURE | Un problème lié aux transactions est survenu. |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | Impossible de valider l'annulation d'une transaction si aucune transaction n'est en cours. |
| -41 TRANSACTION\_IN\_POGRESS | Impossible de démarrer une nouvelle transaction si une autre transaction est en cours. |
| -40 FIPS\_ENABLEMENT\_FAILURE | Problème lié à la norme FIPS. |
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | Problème lors de l'obtention des informations relatives au fichier depuis le système de fichiers. |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | Problème lors du remplacement de documents dans une collection. |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | Problème lors de la suppression de documents d'une collection. |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | Problème lors du stockage de la clé de protection des données. |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | Problème lors de l'indexation des données d'entrée. |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | Vérifiez que les types que vous transmettez à searchFields sont string, integer, number ou boolean. |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | Une opération sur un tableau de documents, par exemple la méthode replace, peut échouer alors qu'elle s'exécute pour un document spécifique. Le document à l'origine de l'échec est renvoyé et la transaction est annulée. Sur Android, cette erreur survient également si vous essayez d'utiliser JSONStore dans des architectures non prises en charge. |
| -10 ACCEPT\_CONDITION\_FAILED | La fonction d'acceptation que l'utilisateur a fournie a renvoyé false. |
| -9 OFFSET\_WITHOUT\_LIMIT | Pour utiliser un décalage, vous devez aussi spécifier une limite. |
| -8 INVALID\_LIMIT\_OR\_OFFSET | Erreur de validation ; il doit s'agir d'un entier positif. |
| -7 INVALID_USERNAME | Erreur de validation (les lettres A à Z ou a à z et les chiffres 0 à 9 seulement sont admis). |
| -6 USERNAME\_MISMATCH\_DETECTED | Pour se déconnecter, un utilisateur de JSONStore doit d'abord appeler la méthode closeAll. Un seul utilisateur peut être connecté à la fois. |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED | Un problème lié à la méthode destroy est survenu alors qu'elle tentait de supprimer le fichier dans lequel se trouve le contenu du magasin. |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | Un problème lié à la méthode destroy est survenu alors qu'elle tentait d'effacer la chaîne de certificats (iOS) ou les préférences utilisateur partagées (Android). |
| -3 INVALID\_KEY\_ON\_PROVISION | Mot de passe incorrect transmis à un magasin chiffré. |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | Les zones de recherche ne sont pas dynamiques. Vous ne pouvez pas les modifier sans appeler la méthode destroy ou la méthode removeCollection avant d'appeler la méthode init ou openmethod avec les nouvelles zones de recherche. Cette erreur peut survenir si vous changez le nom ou le type de la zone de recherche. Par exemple : {key: 'string'} en {key: 'number'} ou {myKey: 'string'} en {theKey: 'string'}. |
| -1 PERSISTENT\_STORE\_FAILURE | Erreur générique. Dysfonctionnement dans le code natif, très probablement lors de l'appel de la méthode init. |
| 0 SUCCESS | Dans certains cas, le code natif JSONStore renvoie 0 pour indiquer la réussite. |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | Erreur de validation. |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | Erreur de validation. |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | Erreur de validation. |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | Erreur de validation. |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | Erreur de validation. |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | Erreur de validation. |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | Erreur de validation. |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB | La requête qui sélectionne tous les documents signalés comme modifiés a échoué. Exemple de requête en langage SQL : SELECT * FROM [collection] WHERE _dirty > 0. |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | Pour que vous puissiez utiliser des fonctions telles que les méthodes push et load dans la classe JSONStoreCollection, un adaptateur doit être transmis à la méthode init. |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | Erreur de validation. |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | Erreur de validation. |
| 12 ADAPTER_FAILURE | Problème lors de l'appel de WL.Client.invokeProcedure, plus précisément lors de la connexion à l'adaptateur. Cette erreur est différente de l'échec de l'adaptateur lors d'une tentative d'appel d'un système de back end. |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | Erreur de validation. |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | L'appel de la méthode enhance dans la classe JSONStoreCollection pour remplacer une fonction existante (find et add) n'est pas autorisé. |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | Le service push envoie le document à un adaptateur mais JSONStore ne parvient pas à signaler le document comme non modifié. |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | Pour que vous puissiez initier une collection avec un mot de passe, la connectivité à {{ site.data.keys.mf_server }} doit être établie car il renvoie un 'jeton aléatoire sécurisé'. IBM Worklight versions 5.0.6 et ultérieures permet aux développeurs de générer le jeton aléatoire sécurisé localement en transmettant {localKeyGen: true} à la méthode init via l'objet options. |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | Impossible de charger des données car WL.Client.invokeProcedure a appelé le rappel d'échec. |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | La validation de l'objet load qui a été transmis à la méthode init n'a pas abouti. |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | Un problème lié à la clé utilisée dans l'objet load lorsque vous appelez la méthode add est survenu. |
| 20 UNDEFINED\_PUSH\_OPERATION | Aucune procédure n'est définie pour l'envoi par commande push des documents modifiés au serveur. Par exemple, la méthode init (nouveau document modifié, opération 'add') et la méthode push (qui recherche le nouveau document avec l'opération 'add') ont été appelées, mais aucune clé d'ajout avec la procédure d'ajout n'a été trouvée dans l'adaptateur qui est lié à la collection. La liaison d'un adaptateur est effectuée dans la méthode init. |
| 21 INVALID\_ADD\_INDEX\_KEY | Problème lié à des zones de recherche supplémentaires. |
| 22 INVALID\_SEARCH\_FIELD | L'une de vos zones de recherche n'est pas valide. Vérifiez qu'aucune zone de recherche transmise ne correspond à _id, json, _deleted ou _operation. |
| 23 ERROR\_CLOSING\_ALL | Erreur générique. Une erreur est survenue lorsque le code natif a appelé la méthode closeAll. |
| 24 ERROR\_CHANGING\_PASSWORD | Impossible de changer le mot de passe. Il se peut que l'ancien mot de passe transmis ne soit pas correct. |
| 25 ERROR\_DURING\_DESTROY | Erreur générique. Une erreur est survenue lorsque le code natif a appelé la méthode destroy |
| 26 ERROR\_CLEARING\_COLLECTION | Erreur générique. Une erreur est survenue lorsque le code natif a appelé la méthode removeCollection. |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | Erreur de validation. |
| 28 INVALID\_SORT\_OBJECT | Le tableau fourni pour le tri n'est pas valide car l'un des objets JSON n'est pas valide. La syntaxe correcte est un tableau d'objets JSON, où chaque objet contient une seule propriété. Cette propriété recherche la zone en fonction de laquelle procéder au tri, et détermine si le tri est croissant ou décroissant. Exemple : {searchField1 : "ASC"}. |
| 29 INVALID\_FILTER\_ARRAY | Le tableau fourni pour le filtrage des résultats n'est pas valide. La syntaxe correcte pour ce tableau est un tableau de chaînes, dans lequel chaque chaîne est une zone de recherche ou une zone JSONStore interne. Pour plus d'informations, voir Eléments internes du magasin. |
| 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | Erreur de validation lorsque le tableau n'est pas un tableau contenant uniquement des objets JSON. |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | Erreur de validation. |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | Erreur de validation. |
