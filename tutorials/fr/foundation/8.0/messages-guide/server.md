---
layout: tutorial
title: Messages de la console, de l'environnement d'exécution et du serveur MobileFirst
breadcrumb_title: Foundation Server
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Présentation
{: #overview }
Vous trouverez ici des informations vous permettant de résoudre les problèmes pouvant survenir lors de l'utilisation de Mobile Foundation Server.

## Messages de l'environnement d'exécution de Mobile Foundation
{: #mfp-runtime-error-codes }
**Préfixe :** FWLSE<br/>
**Plage :** 0000-0012

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE0000E** | *Impossible de stocker AuthorizationGrant {0} dans TransientStorage.* |
| **FWLSE0001E** | *Echec de l'extraction du client {0}.* |
| **FWLSE0002E** | *Demande non valide, paramètres manquants ou non valides : {0}.* |
| **FWLSE0003E** | *Type d'octroi non pris en charge {0}.* |
| **FWLSE0004E** | *RedirectUri a été transmis au noeud final d'autorisation {0} mais n'a pas été transmis au noeud final de jeton.* |
| **FWLSE0005E** | *Conflit RedirectUri. Noeud final d'autorisation : {0}, noeud final de jeton : {1}.* |
| **FWLSE0006E** | *Echec de l'analyse syntaxique du code d'octroi à partir de la demande de jeton {0}.* |
| **FWLSE0007E** | *Echec de la validation du code d'octroi. Un code d'octroi {0} a été fourni pour clientId {1} mais a été utilisé par clientId {2}.* |
| **FWLSE0008E** | *Echec de l'action d'analyse d'AccessToken avec l'exception.* |
| **FWLSE0009E** | *Impossible de signer le jeton d'accès.* |
| **FWLSE0010E** | *Impossible de valider JWT, erreur dans le serveur Keystore.* |
| **FWLSE0011E** | *Impossible de valider JWT, {0}.* |
| **FWLSE0012E** | *Echec de l'authentification JWT du client - Elément jti non valide.* |


### Messages de l'adaptateur Java

**Préfixe :** FWLSE<br/>
**Plage :** 0290-0299

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE0290E** | *La classe d'application JAXRS {0} n'a pas été trouvée (ou ne peut pas être chargée). Vérifiez que le nom de classe dans le fichier xml de l'adaptateur est correct et que la classe existe réellement dans le dossier bin de l'adaptateur ou dans un des fichiers jar du dossier lib de l'adaptateur.* |
| **FWLSE0291E** | *La classe d'application JAXRS {0} ne peut pas être instanciée. Vérifiez que la classe dispose d'un constructeur public ne comportant aucun argument. S'il existe un constructeur, consultez le journal serveur pour voir la cause principale de l'erreur survenue lors de la création de l'instance.* |
| **FWLSE0292E** | *La classe d'application JAXRS {0} doit étendre javax.ws.rs.Application.* |
| **FWLSE0293E** | *Echec du déploiement de l'adaptateur. Le type de propriété {0} n'est pas pris en charge.* |
| **FWLSE0294E** | *Echec du déploiement de l'adaptateur. La valeur {0} n'est pas conforme pour le type {1}.* |
| **FWLSE0295E** | *Echec du déploiement de la configuration de l'adaptateur. La propriété {0} n'est pas définie dans l'adaptateur {1}.* |
| **FWLSE0296E** | *Echec du déploiement de la configuration de l'adaptateur. La propriété {0} n'est pas valide pour le type {1}.* |
| **FWLSE0297W** | *Echec de la génération de la documentation Swagger pour l'adaptateur {0}.* |
| **FWLSE0298W** | *Dans la procédure {0} de l'adaptateur {1}, la valeur 'enduser' est affectée à l'attribut 'connectAs'. Cette fonction n'est pas prise en charge.* |
| **FWLSE0299E** | *Echec du déploiement de la configuration de la connectivité de l'adaptateur. Les propriétés {0} n'existent pas.* |


**Préfixe :** FWLSE<br/>
**Plage :** 0500-0506

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE0500E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. Le paramètre {0} doit être un entier.* |
| **FWLSE0501E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. Le paramètre {0} doit être positif.* |
| **FWLSE0502E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. Le paramètre {0} se trouve hors de la plage définie.* |
| **FWLSE0503E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. Le paramètre {0} doit être une valeur booléenne.* |
| **FWLSE0504E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. L'élément {0} doit être http ou https.* |
| **FWLSE0505E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. La politique en matière de cookies {0} n'est pas prise en charge.* |
| **FWLSE0506E** | *Echec du déploiement de la configuration de connectivité de l'adaptateur. Le paramètre {0} doit être une chaîne.* |

### Messages d'enregistrement

**Préfixe :** FWLSE<br/>
**Plage :** 4200-4229

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE4200E** | *Echec du changement du statut de l'application de l'appareil.* |
| **FWLSE4201E** | *Echec du changement du statut de l'appareil.* |
| **FWLSE4202E** | *Echec de l'obtention d'appareils.* |
| **FWLSE4203E** | *Echec du retrait de l'appareil.* |
| **FWLSE4204E** | *Echec de l'obtention des clients associés à l'appareil.* |
| **FWLSE4205E** | *Echec de getAll pour pageInfo : {0}.* |
| **FWLSE4206E** | *Echec de GetByAttributes.* |
| **FWLSE4207E** | *Impossible de convertir des données en données persistantes.* |
| **FWLSE4208E** | *Echec de la lecture du client {0}.* |
| **FWLSE4209E** | *Echec de la mise à jour du nom d'affichage de l'appareil.* |
| **FWLSE4210E** | *Impossible de créer la signature.* |
| **FWLSE4211E** | *Echec du stockage des données d'enregistrement client car elles n'ont pas été correctement extraites. ID client : {0}.* |
| **FWLSE4212E** | *Echec de la mise à jour du nom d'affichage sur tous les clients de type appareil.* |
| **FWLSE4213E** | *Echec de l'authentification JWT du client - les clés publiques ne correspondent pas.* |
| **FWLSE4214E** | *Les données client sont de type null - cette situation peut survenir si les données client viennent d'être archivées (supprimées).* |
| **FWLSE4215E** | *Plusieurs tentatives d'accès à la console, abandon.* |
| **FWLSE4216E** | *GetDeviceClientsError pour deviceId {0}.* |
| **FWLSE4217E** | *Erreur lors de la tentative d'obtention d'appareils avec les éléments pageStart {0} et pageSize {1}.* |
| **FWLSE4218E** | *Erreur lors de la tentative d'obtention des appareils pour le nom {0} avec les éléments pageStart {1} et pageSize {2}.* |
| **FWLSE4219E** | *RemoveDeviceError pour deviceId : {0}.* |
| **FWLSE4220E** | *Echec de la création de la clé Web pour le client {0}.* |
| **FWLSE4221E** | *Echec de la recherche d'appareils avec pageInfo {0}, searchMethod {1} et le filtre {2}.* |
| **FWLSE4222E** | *Echec de l'enregistrement du client - Signature non valide.* |
| **FWLSE4223E** | *Echec de l'enregistrement du client - Application non valide. Erreur : {0}.* |
| **FWLSE4224E** | *Echec du traitement de la demande d'enregistrement.* |
| **FWLSE4225E** | *Demande d'auto-enregistrement de mise à jour non valide, il n'a pas été possible de vérifier la signature du client.* |
| **FWLSE4226E** | *Erreur d'authenticité de l'application lors de la mise à jour de l'enregistrement, échec de la mise à jour {0}.* |
| **FWLSE4227E** | *Echec de l'enregistrement de la mise à jour.* |
| **FWLSE4228E** | *Erreur applyRegistrationValidations lors de l'enregistrement, retrait du client {0}.* |
| **FWLSE4229W** | *Nouvelle lecture du contexte client initialisé, les changements peuvent être perdus.* |

### Messages d'application

**Préfixe :** FWLST<br/>
**Plage :** 0100-0106

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLST0100E** | *Tentative d'accès à la mise à jour directe d'une application qui n'a jamais été associée à la sécurité de mise à jour directe.* |
| **FWLST0101E** | *Aucune application portant le nom {0} n'a été trouvée.* |
| **FWLST0102E** | *Impossible de finir la mise à jour directe : {0}.* |
| **FWLST0110E** | *Tentative d'accès à la mise à jour native d'une application qui n'a jamais été associée à la sécurité de mise à jour native.* |
| **FWLST0111E** | *Aucune application portant le nom {0} n'a été trouvée.* |
| **FWLST0112E** | *Impossible de finir la mise à jour native : {0}.* |
| **FWLST0120E** | *Tentative d'accès à la mise à jour de modèle d'une application qui n'a jamais été associée à la sécurité de mise à jour de modèle.* |
| **FWLST0121E** | *Aucune application portant le nom {0} n'a été trouvée.* |
| **FWLST0122E** | *Impossible de finir la mise à jour de modèle : {0}.* |
| **FWLST0103E** | *Profil de journal client non valide, le niveau ne doit pas avoir la valeur null.* |
| **FWLST0104E** | *Profil de journal client non valide, plusieurs profils globaux trouvés.* |
| **FWLST0105E** | *Impossible de télécharger le fichier journal d'utilisateur : {0}.* |
| **FWLST0106E** | *Echec du déploiement de l'application. L'ID d'application {0} n'est pas conforme. Il ne peut contenir que les caractères a-z, A-Z, _-.* |

### Messages de l'adaptateur JavaScript

**Préfixe :** FWLST<br/>
**Plage :** 0900-0906

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLST0900E** | *Echec du déploiement du descripteur de l'adaptateur. Magasin de clés non valide.* |
| **FWLST0901W** | *L'alias SSL {0} n'existe pas dans le magasin de clés. Les appels de back end pour lesquels le magasin de clés est requis vont échouer.* |
| **FWLST0902W** | *L'alias SSL est présent dans le descripteur mais il n'existe aucun mot de passe. Les appels de back end pour lesquels le magasin de clés est requis vont échouer.* |
| **FWLST0902W** | *Le mot de passe SSL est présent dans le descripteur mais il n'existe aucun alias. Les appels de back end pour lesquels le magasin de clés est requis vont échouer.* |
| **FWLST0903W** | *L'alias et le mot de passe ne sont pas valides. Les appels de back end pour lesquels le magasin de clés est requis vont échouer.* |
| **FWLST0904E** | *L'exception a été émise lors de l'appel de la procédure {0} dans l'adaptateur {1}.* |
| **FWLST0905E** | *Echec du déploiement de l'adaptateur. Le pilote SQL {0} n'a pas été trouvé dans les ressources de l'adaptateur.* |
| **FWLST0906E** | *L'exception a été émise lors de l'appel de l'élément SQL {0}.* |


**Préfixe :** FWLSE<br/>

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE0014W** | *Le paramètre {0} n'est pas connu et sera ignoré.* |
| **FWLSE0152E** | *Impossible de trouver la chaîne de certificats ayant l'alias {0}.* |
| **FWLSE0207E** | *Echec de la lecture dans le flux d'entrée de réponses HTTP.* |
| **FWLSE0299W** | *La réponse à la demande {0} a été renvoyée en 0 ms. Une investigation du flux de messages HTTP est requise.* |
| **FWLSE0310E** | *Echec de l'analyse syntaxique JSON.* |
| **FWLSE0311E** | *Echec de la transformation ou de l'analyse syntaxique XML.* |
| **FWLSE0318I** | *{0}.* |
| **FWLSE0319W** | *Le type de contenu de la réponse de back end {0} ne correspond pas au type de contenu attendu {1}, poursuite du traitement de la réponse. Corps et en-têtes de demande et de réponse : {2}.* |
| **FWLSE0330E** | *Impossible d'initialiser le contexte SSL WebSphere.* |


### Messages de base

**Préfixe :** FWLST<br/>

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLST3022W** | *Le dossier {0} n'est pas modifiable. Le répertoire principal de l'utilisateur sera utilisé.* |
| **FWLST3023E** | *Echec du démarrage du projet {0}, impossible de créer le répertoire {1}.* |
| **FWLST3024I** | *Le serveur MFP utilise le dossier {0} comme cache du système de fichiers.* |
| **FWLST3025W** | *Le rapport d'analyse du serveur MFP est désactivé en raison d'une URL vide dans la configuration du registre.* |
| **FWLST3026W** | *Une erreur est survenue sur le serveur MFP lors de l'appel du service d'analyse : {0}.* |
| **FWLST3027I** | *Changement de la configuration. Le serveur d'analyse est désormais activé sur {0}.* |
| **FWLST4047W** | *Impossible de trouver la version du produit. Recherche dans le fichier {0} et dans la propriété {1}.* |
| **FWLST4048W** | *Impossible de trouver la version d'environnement d'exécution. Effectuez une recherche dans le fichier {0} et dans la propriété {1}.* |

### Messages de sécurité

**Préfixe :** FWLSE<br/>
**Plage :** 4010-4068

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE4010E** | *Impossible de lire le fichier zip de déploiement du magasin de clés.* |
| **FWLSE4011E** | *Le fichier zip n'inclut pas le fichier du magasin de clés.* |
| **FWLSE4012E** | *Le fichier zip n'inclut pas le fichier de propriétés.* |
| **FWLSE4016E** | *Le type de l'algorithme de certificat de magasin de clés n'est pas RSA. Consultez le guide de la console pour créer un fichier de magasin de clés avec un algorithme RSA.* |
| **FWLSE4017E** | *Impossible de créer le magasin de clés. Magasin de clés : type : {0}.* |
| **FWLSE4018E** | *Certains algorithmes de chiffrement ne sont pas pris en charge dans cet environnement. Magasin de clés : type : {0}.* |
| **FWLSE4019E** | *Cette exception indique un type de problème de certificat. Magasin de clés : type : {0}.* |
| **FWLSE4021E** | *Création de magasin de clés impossible. Chemin : type : {0}.* |
| **FWLSE4022E** | *Impossible de récupérer la clé dans le magasin de clés. Magasin de clés : type : {0}.* |
| **FWLSE4023E** | *Impossible d'extraire la clé privée dans KeyStore, alias non valide ou manquant. Alias :  {0}.* |
| **FWLSE4024W** | *Configuration en double pour la vérification de sécurité {0} dans cet adaptateur. Configuration utilisée : {1}.* |
| **FWLSE4025W** | *La vérification de sécurité {0} a déjà été configurée dans un autre adaptateur, la nouvelle configuration ne sera pas utilisée.* |
| **FWLSE4026E** | *La classe {1} de la vérification de sécurité {0} n'a pas été trouvée.* |
| **FWLSE4027E** | *Impossible de créer la vérification de sécurité {0}. Classe : {1}, erreur : {2}.* |
| **FWLSE4028E** | *La classe {1} de la vérification de sécurité {0} n'implémente pas l'interface SecurityCheck.* |
| **FWLSE4029E** | *Echec du déploiement des données d'authenticité. Message d'erreur : {0}.* |
| **FWLSE4030E** | *Un mappage d'élément de portée en double a été trouvé pour l'élément de portée {0}, mappage utilisé : {1}.* |
| **FWLSE4031E** | *Une configuration de vérification de sécurité en double a été trouvée pour la vérification de sécurité {0}.* |
| **FWLSE4032E** | *Le descripteur de l'application {0} contient une configuration pour la vérification de sécurité {1}. Le contrôle de sécurité manque ou une tentative de retrait de ce dernier a eu lieu.* |
| **FWLSE4033E** | *Le descripteur de l'application {0} contient une configuration pour la vérification de la sécurité {1}. La configuration de la vérification de sécurité n'a pas pu être appliquée.* |
| **FWLSE4034E** | *La vérification de sécurité {0} comporte une erreur de configuration pour le paramètre {1} : {2}.* |
| **FWLSE4035W** | *La vérification de sécurité ''{0}'' comporte un avertissement de configuration pour le paramètre {1} : {2}.* |
| **FWLSE4036W** | *Le descripteur de l'application {0} contient une configuration pour une portée d'application obligatoire {1}. Un ou plusieurs éléments de portée sont manquants ou une tentative de retrait de ces éléments a eu lieu.* |
| **FWLSE4037E** | *La vérification de sécurité {0} ne peut pas avoir le même nom qu'un mappage d'élément de portée.* |
| **FWLSE4038E** | *Le descripteur de l'application {0} contient une configuration pour une portée {1} qui est mappée à la vérification de sécurité {2}. Le contrôle de sécurité manque ou une tentative de retrait de ce dernier a eu lieu.* |
| **FWLSE4039W** | *L'élément de portée vide ne peut pas être mappé. Tentative de mappage à {0}.* |
| **FWLSE4040E** | *La zone {0} de la configuration de l'adaptateur n'est pas correctement formatée.* |
| **FWLSE4041W** | *Caractères non autorisés utilisés dans l'élément de portée {0}. Les caractères autorisés sont les suivants : lettres, chiffres, '-' et '_'.* |
| **FWLSE4042I** | *Configuration de vérification de sécurité {0} pour le paramètre {1} : {2}.* |
| **FWLSE4043E** | *Le délai d'expiration maximal de jeton de l'application doit être positif. Elément configuré : {0}.* |
| **FWLSE4044I** | *L'utilisateur {0} est authentifié via la sécurité SSO reposant sur LTPA.* |
| **FWLSE4045I** | *L'utilisateur n'est PAS authentifié via la sécurité SSO reposant sur LTPA.* |
| **FWLSE4046** | *Echec de la vérification de la désactivation d'appareil pour l'enregistrement avec l'exception.* |
| **FWLSE4047** | *La valeur du délai d'expiration maximal de jeton pour l'application {0} est supérieure à la limite d'expiration. Valeur : {1}, limite d'expiration : {2}.* |
| **FWLSE4048E** | *Echec de la validation du jeton d'accès avec le serveur AZ externe {0}.* |
| **FWLSE4049E** | *Echec du tri des vérifications de sécurité.* |
| **FWLSE4050E** | *Données client non valides.* |
| **FWLSE4051E** | *L'application n'existe pas.* |
| **FWLSE4052E** | *Echec de la lecture des vérifications de sécurité externalisées. Nettoyage initialisé de contexte pour le client {0}.* |
| **FWLSE4053E** | *La vérification de sécurité n'existe pas - {0}.* |
| **FWLSE4054E** | *Echec de l'externalisation des vérifications de sécurité. Ces dernières sont supprimées pour le client {0}.* |
| **FWLSE4055E** | *Echec de l'obtention de l'expiration de portée, valeur 0 renvoyée.* |
| **FWLSE4056E** | *Echec de l'introspection avec l'exception.* |
| **FWLSE4057E** | *Résultat de validation de jeton inattendu : {0}.* |
| **FWLSE4058E** | *Erreur lors du codage de l'en-tête et du contenu.* |
| **FWLSE4059E** | *Echec de la création de l'objet d'en-tête à partir de l'en-tête décodé : {0}.* |
| **FWLSE4060E** | *Echec de la création de l'objet de contenu à partir du contenu décodé : {1}.* |
| **FWLSE4061E** | *Erreur lors du codage de header64 + payload64.* |
| **FWLSE4062E** | *Erreur lors du codage de l'en-tête pour la signature ou lors de la création de l'en-tête.* |
| **FWLSE4063E** | *Erreur lors du codage du contenu.* |
| **FWLSE4064E** | *Le client n'est pas autorisé dans la portée {0}.* |
| **FWLSE4065E** | *Le client n'est pas autorisé.* |
| **FWLSE4066E** | *Le flux d'octrois implicite est disponible uniquement pour l'interface utilisateur Swagger.* |
| **FWLSE4067E** | *Le client n'est pas autorisé.* |
| **FWLSE4068E** | *Le client n'est pas autorisé.* |


### Messages de persistance du serveur

**Préfixe :** FWLSE<br/>
**Plage :** 3000-3009

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE3000E** | *Liaison JNDI de la source de données introuvable pour les noms {0} et {1}.* |
| **FWLSE3001E** | *Impossible de sérialiser la liste dans le tableau JSON.* |
| **FWLSE3002E** | *Impossible de créer de données persistantes : {0}.* |
| **FWLSE3003E** | *Problème de désérialisation de tableau JSON.* |
| **FWLSE3004E** | *Impossible de lire la colonne de valeur CLOB.* |
| **FWLSE3005E** | *Impossible de sérialiser la liste dans le tableau JSON.* |
| **FWLSE3006E** | *Impossible de démarrer la transaction {0}.* |
| **FWLSE3007E** | *Erreur inattendue détectée.* |
| **FWLSE3008E** | *Génération de hachage impossible.* |
| **FWLSE3009E** | *Une erreur s'est produite lors de la tentative de validation de la transaction.* |

### Message War du serveur

**Préfixe :** FWLSE<br/>
**Plage :** 3100-3103

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE3100E** | *Mode du serveur d'autorisation non reconnu : {0}.* |
| **FWLSE3101E** | *Entrée Jndi {0} introuvable, mode de serveur d'autorisation inconnu.* |
| **FWLSE3102I** | *Echec du regroupement des annotations pour la classe {0}. Il est possible qu'une portée soit manquante dans l'interface utilisateur Swagger.* |
| **FWLSE3103I** | *Echec de détermination de la classe pour le bean {0}. Il est possible que des portées soient manquantes dans l'interface utilisateur Swagger.* |
| **FWLSE3103I** | *Démarrage avec le serveur d'autorisation intégré.* |
| **FWLSE3103I** | *Démarrage avec l'intégration de serveur d'autorisation externe.* |

### Messages de licence

**Préfixe :** FWLSE<br/>

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE0277I** | *Création d'un enregistrement ILMT dans le fichier {0}.* |
| **FWLSE0278I** | *Impossible d'utiliser le répertoire ILMT par défaut {0}.* |
| **FWLSE0279E** | *Echec de la création d'un enregistrement ILMT.* |
| **FWLSE0280I** | *Mode de débogage ILMT activé par la variable d'environnement {0}.* |
| **FWLSE0281E** | *Echec de la création d'un consignateur ILMT.* |
| **FWLSE0282I** | *Utilisation du répertoire ILMT {0}.* |
| **FWLSE0283E** | *Le répertoire ILMT n'est pas compatible. Vous pouvez attribuer une propriété nommée 'license.metric.logger.output.dir' à un répertoire approprié dans le fichier 'license_metric_logger.properties' et utiliser la propriété JVM '-Dlicense_metric_logger_configuration=\<path to license_metric_logger.properties\>'.* |
| **FWLSE0284E** | *Echec de l'extraction du chemin dans lequel cette instance {0} est en cours d'exécution. Cette situation n'est pas compatible avec ILMT.* |
| **FWLSE0286I** | *Exception inattendue.* |
| **FWLSE0287E** | *Echec de la création d'un enregistrement ILMT car le consignateur ILMT n'a pas été correctement initialisé. Cette situation n'est pas compatible avec ILMT. Consultez les fichiers journaux afin de trouver la cause de l'erreur d'initialisation.* |
| **FWLSE0367E** | *Données du rapport de licence manquantes. Echec de la création d'un enregistrement ILMT.* |

### Messages relatifs à la purge

**Préfixe :** FWLSE<br/>
**Plage :** 0290-0292

| **FWLSE0290I** | *Suppression de {0} enregistrements terminée en {1} ms.* |
| **FWLSE0291I** | *Suppression de {0} correctifs terminée en {1} ms.* |
| **FWLSE0292I** | *La suppression recommandée des données persistantes concerne les enregistrements de plus de {0} jours.* |

### Autres messages

**Préfixe :** FWLSE<br/>

| **FWLSE0211W** | *L'intervalle de mise hors service recommandé ({0}) est de 86 400 secondes, soit 1 jour.* |
| **FWLSE0801E** | *L'utilitaire de décodage de mot de passe com.ibm.websphere.crypto.PasswordUtil n'est pas disponible. Impossible de prendre en charge le mot de passe déchiffré pour {0}.* |
| **FWLSE0802E** | *Impossible de décoder le mot de passe pour {0}.* |
| **FWLSE0803E** | *Impossible de trouver le message pour l'ID {0} dans le bundle {1} " + ". Erreur : {2}.* |
| **FWLSE0802E** | *Impossible de décoder le mot de passe pour {0}.* |



## Messages du service d'administration de Mobile Foundation
{: #admin-services-error-codes }
<!-- Messages taken from mfp-admin-services/mfp-admin-util/src/main/resources/com/ibm/worklight/admin/resources/messages.properties-->
**Préfixe :** FWLSE<br/>
**Plage :** 3000-3299

| **Code d'erreur**  | **Description** |
|-----------------|-----------------|
| **FWLSE3000E** | **Une erreur de serveur a été détectée.** |
| **FWLSE3001E** | **Un conflit a été détecté.** |
| **FWLSE3002E** | **La ressource est introuvable.** |
| **FWLSE3003E** | **Impossible d'ajouter l'environnement d'exécution car son contenu n'inclut aucun nom.** |
| **FWLSE3010E** | **Une erreur de base de données a été détectée.** <br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, configurez de manière incorrecte la base de données. |
| **FWLSE3011E** | **Le numéro de port "{0}" de la propriété JNDI mfp.admin.proxy.port n'est pas valide.** <br/><br/>{0} correspond au numéro de port, par exemple 9080.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, attribuez une valeur incorrecte à la propriété JNDI mfp.admin.proxy.port.  Ouvrez ensuite la console Operations Console. Le message apparaîtra alors dans les journaux serveur. |
| **FWLSE3012E** | **Erreur de connexion JMX. Motif : "{0}". Pour plus de détails, consultez les journaux serveur de l'application.** <br/><br/>{0} est un message d'erreur provenant du protocole JMX du serveur Web.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, configurez de manière incorrecte JMX de manière à ce que des exceptions soient générées. |
| **FWLSE3013E** | **Dépassement du délai d'attente lors de la tentative d'obtention du verrou de transaction après {0} millisecondes.** <br/><br/>{0} correspond au nombre de millisecondes, par exemple 32 000.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient lorsqu'une base de données est connectée via un réseau lent ou instable. |
| **FWLSE3017E** | **Une erreur de base de données a été détectée : {0}. Motif : {1}** <br/><br/>{0} correspond au message d'erreur de cloudant.<br/>{1} correspond au message d'explication de cloudant.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, configurez Cloudant de manière incorrecte. |
| **FWLSE3018E** | **L'opération Cloudant ne s'est pas exécutée pendant la période définie de {0} millisecondes.** <br/><br/>{0} correspond au nombre de millisecondes, par exemple 32 000.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, utilisez la base de données Cloudant et attribuez la valeur 1 à la propriété JNDI mfp.db.cloudant.documentOperation.timeout. Si la connexion à Cloudant est lente, ouvrez la console Operations Console. Le message apparaîtra alors dans les journaux serveur. |
| **FWLSE3019E** | **Impossible d'obtenir le verrou de transaction. Motif : {0}** <br/><br/>{0} correspond à un message d'exception provenant d'une source externe. Il peut s'agir de n'importe quelle chaîne.  <br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut être reproduite lorsque vous avez un parc de serveurs avec Cloudant et que vous arrêtez le maître de verrouillage alors qu'une opération de verrouillage est en cours. Ouvrez ensuite la console Operations Console.  Le message apparaîtra alors dans les journaux serveur. |
| **FWLSE3021E** | **Dépassement de délai d'attente lors de la tentative d'obtention du verrou de transaction après {0} millisecondes. Augmentez la propriété {1}.**<br/><br/>{0} correspond au nombre de millisecondes, par exemple 32 000.<br/>{1} correspond au nom de la propriété JNDI dans laquelle le délai d'attente est défini.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient lorsqu'une base de données est connectée via un réseau lent ou instable. |
| **FWLSE3030E** | **L'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>**Emplacement :** {0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/><br/>Cette erreur se produit lorsque le serveur {{ site.data.keys.mf_server }} ne peut pas charger l'environnement d'exécution stocké dans la base de données.  L'[APAR PI71317](http://www-01.ibm.com/support/docview.wss?uid=swg1PI71317) a été publié afin de prendre en charge certaines occurrences de ce message.  Si le niveau de correctif du serveur est antérieur à **iFix 8.0.0.0-IF20170125-0919**, effectuez une mise à niveau vers le [dernier correctif iFix](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all). |
| **FWLSE3031E** | **Impossible d'ajouter ou de supprimer l'environnement d'exécution "{0}" car il est toujours en cours d'exécution.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne). |
| **FWLSE3032E** | **Impossible d'ajouter l'environnement d'exécution "{0}" car il existe déjà.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne). |
| **FWLSE3033E** | **L'environnement d'exécution "{0}" n'est pas vide mais vous avez demandé à ce que la suppression ne puisse être effectuée que lorsqu'il est vide.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, supprimez un environnement d'exécution arrêté qui contient toujours des applications. |
| **FWLSE3034E** | **L'application "{1}" de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/>{1} correspond au nom de l'application (n'importe quelle chaîne). |
| **FWLSE30302E** | **La configuration de licence pour l'application "{1}" de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/>{1} correspond au nom de l'application (n'importe quelle chaîne). |
| **FWLSE30303E** | **La configuration de licence ne peut pas être supprimée car l'application "{1}" de l'environnement d'exécution "{0}" existe dans la base de données d'administration MobileFirst ou la configuration de licence n'existe pas.** <br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/>{1} correspond au nom de l'application (n'importe quelle chaîne). |
| **FWLSE30035E** | **Impossible d'ajouter l'application "{1}" car elle existe déjà dans l'environnement d'exécution "{0}".** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/>{1} correspond au nom de l'application (n'importe quelle chaîne).<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Se produit uniquement dans les tests d'unité |
| **FWLSE3035E** | **L'application "{1}" avec l'environnement "{2}" de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne)<br/>{1} correspond au nom de l'application (n'importe quelle chaîne).<br/>{2} correspond au nom de l'environnement : android, ios... |
| **FWLSE30304E** | **Les données AppAuthenticity de l'application "{1}" avec l'environnement "{2}" et la version "{3}" de l'environnement d'exécution "{0}" n'existent pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne)<br/>{1} correspond au nom de l'application (n'importe quelle chaîne).<br/>{2} correspond au nom de l'environnement : android, ios... |
| **FWLSE3036E** | **L'application "{1}" avec l'environnement "{2}" et la version "{3}" de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).<br/>{1} correspond au nom de l'application (n'importe quelle chaîne).<br/>{2} correspond au nom de l'environnement : android, ios... <br/>{3} correspond à la version : 1.0, 2.0... |
| **FWLSE3037E** | **Impossible d'ajouter l'environnement "{1}" avec la version "{2}" car il existe déjà dans l'application "{0}".** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne).<br/>{1} correspond au nom de l'environnement : android, ios... <br/>{2} correspond à la version : 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Se produit uniquement dans les tests d'unité |
| **FWLSE3038E** | **L'adaptateur "{1}" de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).  {1} correspond au nom de l'adaptateur (n'importe quelle chaîne). |
| **FWLSE3039E** | **Impossible d'ajouter l'adaptateur "{0}" car il existe déjà dans l'environnement d'exécution "{1}".** <br/>{0} correspond au nom de l'environnement d'exécution (n'importe quelle chaîne).  {1} correspond au nom de l'adaptateur (n'importe quelle chaîne).<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Se produit uniquement dans les tests d'unité |
| **FWLSE3040E** | **Le profil de configuration "{0}" n'a été trouvé pour aucun environnement d'exécution dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.** <br/><br/>{0} correspond à l'ID du profil de configuration (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans le journal de trace lors de la suppression d'un profil de configuration client qui n'existe pas. |
| **FWLSE3045E** | **Aucun bean géré (MBean) trouvé pour l'administration {0}. ** <br/><br/>{0} correspond au mot MobileFirst.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3041E** | **Aucun bean géré (MBean) trouvé pour le projet {0} ''{1}''. Il est possible que l'application Web d'environnement d'exécution {0} pour le projet {0} ''{1}'' ne soit pas en cours d'exécution. Si elle est en cours d'exécution, utilisez JConsole pour inspecter les beans gérés disponibles. Si elle n'est pas en cours d'exécution, des informations détaillées sur les erreurs sont disponibles dans les fichiers journaux du serveur.** <br/><br/>{0} correspond au mot MobileFirst.  {1} correspond au nom du projet/de l'environnement d'exécution (n'importe quelle chaîne) |
| **FWLSE3042E** | **Erreur de communication avec le bean géré ''{0}''. Consultez les journaux du serveur d'applications.** <br/><br/>{0} correspond à l'ID canonique du bean géré, qui est une chaîne.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation peut survenir en cas d'installation d'un élément worklight-jee-library 6.2 dans un serveur MobileFirst 7.1. |
| **FWLSE3043E** | **Le bean géré nommé ''{0}'' n'est plus présent. Consultez les journaux du serveur d'applications.** <br/><br/>{0} correspond à l'ID canonique du bean géré, qui est une chaîne.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient dans un parc de serveurs lors de l'arrêt d'un serveur alors qu'une opération de déploiement est en cours. |
| **FWLSE3044E** | **Le bean géré nommé ''{1}'' ne prend pas en charge les opérations attendues. Vérifiez que la version de l'environnement d'exécution {0} est identique à celle des services d'administration.** <br/><br/>{0} correspond au mot MobileFirst. {1} correspond à l'ID canonique du bean géré, qui est une chaîne.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation peut survenir en cas d'installation d'un élément worklight-jee-library 6.2 dans un serveur MobileFirst 7.1. |
| **FWLSE3050E** | **L'opération de bean géré renvoie un type inconnu. Vérifiez que la version de l'environnement d'exécution {0} est identique à celle des services d'administration.** <br/><br/>{0} correspond au mot MobileFirst.<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation peut survenir en cas d'installation d'un élément worklight-jee-library 6.2 dans un serveur MobileFirst 7.1. |
| **FWLSE3051E** | **Contenu non valide. Pour plus de détails, consultez les messages supplémentaires.** |
| **FWLSE3052E** | **Le contenu suivant n'est pas reconnu : "{0}".** <br/><br/>{0} est un extrait du contenu utilisant la syntaxe JSON, par exemple "{ a : 0 }" |
| **FWLSE3053E** | **Paramètres non valides. Pour plus de détails, consultez les messages supplémentaires.** |
| **FWLSE3061E** | **L'environnement "{0}" référencé dans le fichier "{1}" du fichier wlapp est inconnu. Vérifiez que l'application a été correctement générée.** <br/><br/>{0} correspond à l'environnement : android, ios.  {1} correspond à un nom de fichier |
| **FWLSE3063E** | **Impossible de déployer l'application car le dossier "{0}" manque dans le fichier wlapp. Vérifiez que l'application a été correctement générée.** <br/><br/>{0} correspond à un nom de dossier, par exemple "meta".<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Déployez un fichier wlapp qui ne contient pas le dossier meta |
| **FWLSE3065E** | **Impossible de déployer l'application car la zone "{0}" manque dans le fichier wlapp. Vérifiez que l'application a été correctement générée.** <br/><br/>{0} correspond à une zone obligatoire, par exemple "app.id" |
| **FWLSE3066E** | **Impossible de déployer l'application car la version de l'application "{2}" est différente de la version de l'environnement d'exécution {0} "{3}". \nUtilisez {1} "{4}" pour générer et déployer l'application.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'élément Studio, par exemple MobileFirst Studio, {2} à une version d'application : 1.0, 2.0 ... , {3} à la version de l'environnement d'exécution et {4} à la version Studio requise |
| **FWLSE3067E** | **Impossible de déployer l'application car la version de l'application est antérieure à la version de l'environnement d'exécution {0} "{2}". \nUtilisez {1} "{3}" pour générer et déployer l'application.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'élément Studio, par exemple MobileFirst Studio, {2} à la version de l'environnement d'exécution et {3} à la version Studio requise |
| **FWLSE3068E** | **Impossible de déployer l'adaptateur car la version de ce dernier "{2}" est différente de la version de l'environnement d'exécution {0} "{3}". \nUtilisez {1} "{4}" pour générer et déployer l'adaptateur.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'élément Studio, par exemple MobileFirst Studio, {2} à une version d'adaptateur, 1.0, 2.0... , {3} à la version de l'environnement d'exécution et {4} à la version Studio requise |
| **FWLSE3069E** | **Impossible de déployer l'adaptateur car la version de ce dernier est antérieure à la version de l'environnement d'exécution {0} "{2}". \nUtilisez {1} "{3}" pour générer et déployer l'adaptateur.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'élément Studio, par exemple MobileFirst Studio, {2} à la version de l'environnement d'exécution et {3} à la version Studio requise |
| **FWLSE3070E** | **La mise à jour de l'application "{1}" avec l'environnement "{2}" et la version "{3}" a échoué car cette application est verrouillée. Elle peut être déverrouillée à l'aide de la console Operations Console {0}.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'application (n'importe quelle chaîne), {2} à l'environnement d'application : android, ios... et {3} à la version de l'application : 1.0, 2.0, ... |
| **FWLSE3071E** | **Impossible de déployer l'application hybride "{0}" car il existe déjà une application native portant le même nom.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne).<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Créez une application native et une application hybride portant le même nom et déployez-les dans la console Operations Console. |
| **FWLSE3072E** | **Impossible de déployer l'application native "{0}" car il existe déjà une application hybride portant le même nom.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne).<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Créez une application native et une application hybride portant le même nom et déployez-les dans la console Operations Console. |
| **FWLSE3073E** | **Impossible de trouver le fichier de programme d'installation Adobe Air dans l'application "{1}" version "{2}". \nUtilisez {0} pour reconstruire et déployer le fichier wlapp pour cette application.** <br/><br/>{0} correspond au nom de l'élément Studio, par exemple MobileFirst Studio, {1} au nom de l'application (n'importe quelle chaîne) et {2} à la version de l'application : 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Cette situation se produit lorsque l'application Adobe est endommagée |
| **FWLSE3074W** | **Le verrou a été correctement mis à jour pour l'application "{0}" avec l'environnement "{1}" et la version "{2}" mais ce paramètre n'a aucune conséquence sur l'environnement "{1}" car ce dernier ne prend pas en charge la mise à jour directe.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne), {1} à l'environnement de l'application : android, ios... et {2} à la version de l'application : 1.0, 2.0, ...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3075W** | **La règle d'authentification d'application a été correctement mise à jour pour l'application "{0}" avec l'environnement "{1}" et la version "{2}" mais ce paramètre n'a aucune conséquence sur l'application "{0}" avec l'environnement "{1}" car ce dernier ne prend pas en charge la vérification d'authenticité d'application. Vous pouvez activer ce support pour cet environnement d'application en déclarant dans application-descriptor.xml une configuration de sécurité définie dans authenticationConfig.xml.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne), {1} à l'environnement de l'application : android, ios... et {2} à la version de l'application : 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3076W** | **L'application "{0}" avec l'environnement "{1}" et la version "{2}" n'a pas été déployée car elle n'a pas changé depuis le dernier déploiement.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne), {1} à l'environnement de l'application : android, ios... et {2} à la version de l'application : 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, déployez exactement le même fichier wlapp deux fois avec la console Operations. |
| **FWLSE3077W** | **L'adaptateur "{0}" n'a pas été déployé car il n'a pas changé depuis le dernier déploiement.** <br/><br/>{0} correspond au nom de l'adaptateur (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, déployez exactement le même adaptateur deux fois avec la console Operations. |
| **FWLSE3078W** | **Le fichier de miniature est manquant dans le fichier wlapp pour l'application "{0}" avec l'environnement "{1}" et la version "{2}".** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne), {1} à l'environnement de l'application : android, ios... et {2} à la version de l'application : 1.0, 2.0... |
| **FWLSE3079W** | **Impossible de vérifier que l'application "{2}" avec l'environnement "{3}" et la version "{4}" a été générée avec la même version {1} que l'environnement d'exécution {0} car les versions d'application et d'environnement d'exécution sont toutes les deux générées avec des versions antérieures à la version 6.0 de Worklight Studio. Veuillez vous assurer que ces deux éléments ont été générés avec la même version de {1}.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de Studio, par exemple MobileFirst Studio, {2} au nom de l'application (n'importe quelle chaîne), {3} à l'environnement d'application : android, ios... et {4} à la version de l'application : 1.0, 2.0...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, déployez la génération wlapp avec Worklight Studio 5.0.6 ou une version antérieure dans MobileFirst Server 7.1. |
| **FWLSE3080W** | **Impossible de vérifier que l'adaptateur "{2}" a été généré avec la même version {1} que l'environnement d'exécution {0} car les versions d'adaptateur et d'environnement d'exécution sont toutes les deux générées avec des versions antérieures à la version 6.0 de Worklight Studio. Veuillez vous assurer que ces deux éléments ont été générés avec la même version de {1}.** <br/><br/>{0} correspond au mot MobileFirst, {1} au nom de l'élément Studio, par exemple MobileFirst Studio, {2} au nom de l'adaptateur (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, déployez la génération d'adaptateur avec Worklight Studio 5.0.6 ou une version antérieure dans MobileFirst Server 7.1. |
| **FWLSE3081E** | **La vérification d'authenticité de l'application n'est pas prise en charge pour l'environnement "{0}". Seuls les environnements iOS et Android sont pris en charge.** <br/><br/>{0} correspond à l'environnement d'application : android, ios...<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, éditez l'application Android avec la vérification d'authenticité activée, modifiez l'environnement puis effectuez le déploiement. |
| **FWLSE3082E** | **Le contenu du fichier "{0}" est vide et ne peut donc pas être déployé.** <br/><br/>{0} correspond à un nom de fichier |
| **FWLSE3084E** | **Impossible de déployer le fichier d'adaptateur car il ne contient pas le fichier XML d'adaptateur obligatoire. Vérifiez qu'il a été correctement généré.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Déployez un adaptateur qui ne contient aucun fichier XML |
| **FWLSE3085E** | **Le fichier d'application ne peut pas être déployé car il ne contient pas le fichier "{0}" obligatoire. Vérifiez qu'il a été correctement généré.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Déployez un fichier wlapp qui ne contient aucun fichier meta/deployment.data |
| **FWLSE3090E** | **La transaction n'a jamais été terminée. Consultez les journaux du serveur d'applications.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient lorsqu'une transaction est bloquée pendant trente minutes pour une raison inconnue |
| **FWLSE3091W** | **Le traitement de la transaction {0} a échoué. Consultez les journaux du serveur d'applications.** <br/><br/>{0} correspond à l'ID de la transaction, généralement un nombre<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Elle peut être reproduite en arrêtant un environnement d'exécution alors qu'une transaction est en cours. |
| **FWLSE3092W** | **La transaction {0} a été annulée avant le démarrage du traitement. Consultez les journaux du serveur d'applications.** <br/><br/>{0} correspond à l'ID de la transaction, généralement un nombre<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation survient lorsque vous créez plusieurs transactions de déploiement, une d'entre elles au moins n'étant pas encore traitée lors de l'arrêt du serveur. Lors du redémarrage du serveur, la transaction non traitée est annulée. |
| **FWLSE3100W** | **Impossible d'accéder à la ressource binaire {3}. La demande de plage HTTP {0} à {1} ne peut pas être satisfaite. La longueur maximale du contenu est de {2} octets.** <br/><br/>{0} correspond au début de la plage d'octets, par exemple 0, {1} à la fin de la plage d'octets, par exemple 6666, {2} au nombre d'octets disponibles, par exemple 25, {3} au nom de la ressource (nom de fichier, par exemple) |
| **FWLSE3101W** | **L'application {1}, environnement {2}, version {3} générée avec {0} version {4} a été remplacée par l'environnement généré avec {0} version {5}** <br/><br/>{0} correspond au nom de Studio, MobileFirst Studio, {1} au nom de l'application (n'importe quelle chaîne), {2} à l'environnement d'application : android, ios... , {3} à la version de l'application : 1.0, 2.0... , {4} à la version de Studio, par exemple 3.0, {5} à l'autre version de Studio, par exemple 4.0<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, vous devez avoir une application générée avec deux différentes versions de Studio mais l'application doit avoir le même numéro de version et le même environnement. Si vous déployez ensuite les deux applications sur le même serveur, le message peut être généré. Cependant, ce message peut être masqué par d'autres messages. Ce message n'est jamais apparu. |
| **FWLSE3102W** | **L'application {0} n'est pas activée pour la notification push.** <br/><br/>{0} correspond au nom de l'application (n'importe quelle chaîne) |
| **FWLSE3103E** | **La balise de notification push {0} n'a pas été trouvée pour l'application {2} de l'environnement d'exécution {1}.** <br/><br/>{0} correspond à la balise de notification push (n'importe quelle chaîne), {1} au nom de l'environnement d'exécution (n'importe quelle chaîne) et {2} au nom de l'application (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Se produit uniquement dans les tests d'unité |
| **FWLSE3104E** | **La balise de notification push {0} existe déjà pour l'application {2} de l'environnement d'exécution {1}.** <br/><br/>{0} correspond à la balise de notification push (n'importe quelle chaîne), {1} au nom de l'environnement d'exécution (n'importe quelle chaîne) et {2} au nom de l'application (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3105W** | **Le certificat de notification push pour {0} est arrivé à expiration.** <br/><br/>{0} correspond au nom du médiateur push (n'importe quelle chaîne)<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3113E** | **Plusieurs erreurs sont survenues lors de la synchronisation de l'environnement d'exécution {0}.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient dans une configuration de parc de serveurs (configuration à plusieurs noeuds) lorsque le serveur démarre et que chaque noeud signale une erreur différente. |
| **FWLSE3199I** | **========= {0} version {1} démarré.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Cette situation survient toujours dans le journal serveur au démarrage du serveur. |
| **FWLSE3210W** | **L'environnement {1} de l'application {0} version {2} a été déployé avec une autre version du kit SDK MobileFirst natif. Les mises à jour directes ne seront plus disponibles pour les clients existants utilisant d'autres versions du kit SDK MobileFirst. Pour continuer à utiliser les mises à jour directes, incrémentez la version de l'application, publiez-la dans le magasin d'applications public, déployez-la sur le serveur, et (éventuellement) bloquez/signalez les anciennes versions de l'application pour faire appliquer aux clients la mise à niveau vers la nouvelle version à partir du magasin d'applications. **<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir si une application a été créée avec une version antérieure de MobileFirst Studio avec un kit SDK MobileFirst plus ancien. Cependant, je connais mal les versions du kit SDK MobileFirst natif. |
| **FWLSE3119E** | **Echec de la validation du certificat APNS. Pour plus de détails, consultez les messages supplémentaires.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation survient lorsque le certificat de notification push Apple n'est pas valide. |
| **FWLSE3120E** | **Cette API peut être utilisée uniquement après la migration de l'application vers MobileFirst Platform 6.3. La version actuelle de l'application est {0}**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Cette situation survient uniquement lorsque de nouvelles notifications push sont utilisées dans des anciennes applications. |
| **FWLSE3121E** | **Cette API n'est plus disponible sur le serveur. Pour plus de détails, consultez les messages supplémentaires.** |
| **FWLSE3122E** | **La règle de vérification d'authenticité d'une application ne peut plus être modifiée dans le serveur. Vous devez reconstruire votre application afin de modifier la règle de vérification de l'authenticité et de la déployer.** |
| **FWLSE3123W** | **L'environnement {1} de l'application {0} version {2} a été déployé avec l'authenticité d'application étendue désactivée. Il est recommandé d'utiliser l'authenticité d'application étendue pour une meilleure protection contre les applications non autorisées en utilisant la commande enable-extended-authenticity de l'outil mfpadm avant de déployer l'application.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Dans la console Operations Console, déployez une application avec l'authenticité de base. Toutes les applications antérieures à la version 7.0 ne disposent pas de l'authenticité étendue et doivent désormais afficher cet avertissement ou le suivant. L'avertissement n'est pas généré si vous utilisez la console Operations Console intégrée à Worklight Studio. |
| **FWLSE3124W** | **L'environnement {1} de l'application {0} version {2} a été déployé avec l'authenticité d'application désactivée. Activez-la pour assurer la protection contre les applications non autorisées.** |

### Messages de licence de jeton

| **FWLSE3125E** | **La bibliothèque native Rational Common Licensing n'a pas été trouvée. Vérifiez que la propriété JVM (java.library.path) contient le chemin d'accès correct et que la bibliothèque native peut être exécutée. Redémarrez IBM MobileFirst Platform Server après avoir effectué l'action corrective.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Ne définissez pas la propriété JVM (java.library.path) désignant la bibliothèque native RCL dans la configuration du serveur d'applications. Ce message sera alors émis lors de la synchronisation de l'environnement d'exécution. |
| **FWLSE3126E** | **La bibliothèque partagée Rational Common Licensing n'a pas été trouvée. Vérifiez que la bibliothèque partagée est configurée. Redémarrez IBM MobileFirst Platform Server après avoir effectué l'action corrective.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Ne définissez pas le chemin de bibliothèque partagée désignant la bibliothèque Java RCL dans la configuration du serveur d'applications. Ce message sera alors émis lors de la synchronisation de l'environnement d'exécution. |
| **FWLSE3127E** | **La connexion du serveur Rational License Key Server n'est pas configurée. Vérifiez que les propriétés JNDI d'administration "{0}" et "{1}" sont définies. Redémarrez IBM MobileFirst Platform Server après avoir effectué l'action corrective.** <br/><br/>{0} correspond au nom d'hôte du serveur de licences et {1} au port du serveur de licences<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Ne définissez pas les propriétés JNDI (liées à l'octroi de licence de jeton) dans la configuration du serveur d'applications. Ce message sera alors émis lors de la synchronisation de l'environnement d'exécution. |
| **FWLSE3128E** | **Le serveur Rational License Key Server "{0}" n'est pas accessible. Vérifiez que le serveur de licences est en cours d'exécution et accessible dans IBM MobileFirst Platform Server. Si cette erreur se produit au démarrage, redémarrez IBM MobileFirst Platform Server après avoir effectué cette action corrective.** <br/><br/>{0} correspond à l'adresse complète du serveur de licences<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Ne démarrez pas le serveur de licences. Ce message sera alors émis lors de la synchronisation de l'environnement ou lors du déploiement de l'application. |
| **FWLSE3129E** | **Licences de jeton insuffisantes pour la fonction "{0}".** <br/><br/>{0} correspond au nom de la fonction de licence<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Utilisez toutes les licences du serveur. Ce message sera alors émis lors de la synchronisation de l'environnement ou lors du déploiement de l'application. |
| **FWLSE3130E** | **Les licences de jeton sont arrivées à expiration pour la fonction "{0}".** <br/><br/>{0} correspond au nom de la fonction de licence<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Autorisez l'expiration des licences de jeton. Ce message sera alors émis lors de la synchronisation de l'environnement ou lors du déploiement de l'application. |
| **FWLSE3131E** | **Une erreur de licence a été détectée. Consultez les journaux serveur de l'application pour plus de détails.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. |
| **FWLSE3132E** | **La connexion au serveur Rational License Key Server est configurée avec les propriétés JNDI d'administration "{0}" et "{1}" mais ce serveur IBM MobileFirst Platform Server n'est pas activé pour l'octroi de licence de jeton.** <br/><br/>{0} correspond au nom d'hôte du serveur de licences et {1} au port du serveur de licences<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> N'activez pas l'octroi de licence de jeton. Cependant, définissez les propriétés JNDI (liées à l'octroi de licence de jeton) dans la configuration du serveur d'applications. Ce message sera alors émis lors de la synchronisation de l'environnement d'exécution. |
| **FWLSE3133I** | **Cette application est désactivée. Pour plus de détails, contactez l'administrateur.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Autorisez l'expiration des licences de jeton. Toutes les applications seront alors automatiquement désactivées et ce message s'affiche lorsque l'accès à l'application s'effectue à partir de l'appareil. |
| **FWLSE3134E** | **La bibliothèque native Rational Common Licensing n'a pas été trouvée.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3135E** | **La bibliothèque partagée Rational Common Licensing n'a pas été trouvée.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3136E** | **Les caractéristiques du serveur Rational License Key Server n'ont pas été configurées.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3137E** | **Le serveur Rational License Key Server "{0}" n'est pas accessible.** <br/><br/>{0} correspond à l'adresse complète du serveur de licences<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3138E** | **Licences de jeton insuffisantes pour la fonction "{0}".** <br/><br/>{0} correspond au nom de la fonction de licence<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3139E** | **Les licences de jeton sont arrivées à expiration pour la fonction "{0}".** <br/><br/>{0} correspond au nom de la fonction de licence<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3140E** | **Une erreur de licence a été détectée.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |
| **FWLSE3141E** | **Les caractéristiques du serveur Rational License Key Server ont été configurées.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> A stocker en interne dans la base de données. Difficile. |

### Messages concernant la configuration en parc de serveurs

| **FWLSE3200W** | **Le serveur "{0}" ne peut pas être ajouté en tant que nouveau membre de parc de serveurs car un serveur ayant le même ID est déjà enregistré pour l'environnement d'exécution "{1}". Cela peut se produire si la propriété JNDI mfp.admin.serverid a la même valeur sur un autre noeud en cours d'exécution, ou si votre serveur ne s'est pas désenregistré correctement lors de son dernier arrêt.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation survient si vous configurez un parc de serveurs de manière incorrecte. Un parc de serveurs se compose de plusieurs ordinateurs (noeuds). Chaque ordinateur doit avoir un ID (propriété JNDI mfp.admin.serverid).  Si vous utilisez exactement le même ID pour deux noeuds différents, ce message apparaît dans le journal serveur. |
| **FWLSE3201E** | **Echec de l'annulation de l'enregistrement du membre du parc de serveurs "{0}" pour l'environnement d'exécution "{1}".**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans les journaux serveur si vous avez un parc de serveurs, que vous arrêtez un noeud dans ce dernier et que cette opération ne se déroule pas correctement. |
| **FWLSE3202E** | **Echec de l'extraction de la liste de membres de parc de serveurs pour le serveur "{0}".**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans les journaux serveur lorsque le service d'administration est arrêté dans un parc de serveurs.  Il tente ensuite d'envoyer une notification aux membres du parc de serveurs et doit pour cela disposer de la liste de ses membres. |
| **FWLSE3203E** | **Aucun noeud de parc de serveurs n'est enregistré avec l'ID de serveur "{0}" pour l'environnement d'exécution "{1}".** |
| **FWLSE3204W** | **Le noeud "{0}" semble inaccessible, cette transaction n'a pas été effectuée sur ce noeud.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans un parc de serveurs si vous déconnectez du réseau un noeud de ce parc et que vous attendez suffisamment. Cet événement apparaît dans le journal serveur. |
| **FWLSE3205W** | **Impossible de placer l'environnement d'exécution "{0}" sur le serveur "{1}" en mode de refus de service. Vous pouvez ignorer cet avertissement si l'environnement d'exécution est également en cours d'arrêt.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans un parc de serveurs si vous déconnectez du réseau un noeud de ce parc et que vous attendez suffisamment ou que vous arrêtez le serveur. Outre la procédure normale, il faut qu'une autre exception se produise (par exemple, une exception OutOfMemory). |
| **FWLSE3206E** | **Il n'est pas autorisé d'annuler l'enregistrement du serveur "{0}" pour l'environnement d'exécution "{1}" car le serveur semble être toujours actif.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, vous pouvez reproduire cette situation en appelant l'API REST pour retirer un parc de serveurs alors que ce noeud de parc est toujours en cours d'exécution. |
| **FWLSE3207E** | **Le membre de parc de serveurs ayant l'ID de serveur "{0}" n'est pas accessible. Faites une nouvelle tentative ultérieurement.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. En théorie, cette situation peut survenir dans un parc de serveurs si vous déconnectez du réseau un noeud de ce parc puis que vous tentez de déployer un fichier wlapp. La transaction va échouer et ce message est généré dans le journal des erreurs (journal des transactions accessible via l'interface utilisateur). |
| **FWLSE3208E** | **Un code de statut non valide "{0}" a été renvoyé. Le contenu de la réponse est "{1}".**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Cette situation peut survenir lorsqu'un code de statut inattendu est renvoyé suite à l'appel REST de service de configuration. |
| **FWLSE3209E** | **Une exception s'est produite lors de l'appel du service de configuration. Le message d'exception est "{0}".**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Cette situation peut survenir lorsqu'il existe des problèmes avec les opérations CRUD liées aux configurations du service de configuration. Cette exception est générique et regroupe plusieurs erreurs |
| **FWLSE3210E** | **La ressource ou les ressources {0} que vous tentez d'exporter n'ont pas été trouvées.** |
| **FWLSE3211E** | **Le paramètre resourceInfos {0} est spécifié de manière incorrecte. Ce paramètre doit avoir une valeur au format nomRessource\|\|typeRessource.** |

## Messages de la console {{ site.data.keys.mf_console }}

**Préfixe :** FWLSE<br/>
**Plage :** 3300-3399

| **FWLSE3301E** | **Problème lié aux certificats SSL. Correctifs possibles : placez le certificat du serveur d'applications dans le magasin de clés de confiance. Ou attribuez la valeur {1} à la propriété JNDI {0} (pas dans les environnements de production).**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Difficile. Survient lorsque vous configurez le serveur avec SSL mais que vous n'utilisez pas le certificat SSL approprié. Cette situation peut également survenir avec des certificats autosignés dans certaines circonstances. |
| **FWLSE3302E** | **Le magasin de clés de l'environnement d'exécution "{0}" n'existe pas dans la base de données d'administration MobileFirst. La base de données est peut-être endommagée.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Aucun magasin de clés |
| **FWLSE3303E** | **Le nom d'application "{0}", environnement "{1}" et version "{2}" des données de ressource Web/d'authenticité ne correspond pas à l'application déployée.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Téléchargez une ressource Web générée pour une autre application |
| **FWLSE3304E** | **La propriété JNDI "{0}" n'est pas définie. Le service Push n'est pas activé sur ce serveur.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Indiquez une URL de serveur Push incorrecte |
| **FWLSE3305E** | **L'alias de magasin de clés ne peut pas être de type null.**<br/><br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Essayez de télécharger un magasin de clés puis ignorez les zones de mot de passe et d'alias. |
| **FWLSE3306E** | **Le mot de passe du magasin de clés ne peut pas être de type null.** |
| **FWLSE3307E** | **Impossible de trouver l'alias "{0}" dans ce magasin de clés.** |
| **FWLSE3308E** | **Non concordance du mot de passe d'alias.** |
| **FWLSE3309E** | **Le mot de passe de l'alias ne peut pas être de type null.** |
| **FWLSE3310W** | **Le serveur n'autorise le déploiement que de "{0}" applications.** <br/>{::nomarkdown}<i>Procédure à reproduire :</i>{:/}<br/> Tentez de déployer des applications dont le nombre dépasse la limite définie par la propriété jndi mfp.admin.max.apps |
