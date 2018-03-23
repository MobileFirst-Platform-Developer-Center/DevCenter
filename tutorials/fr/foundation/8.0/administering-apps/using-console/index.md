---
layout: tutorial
title: Administration d'applications via MobileFirst Operations Console
breadcrumb_title: Administrating using the console
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez administrer des applications {{ site.data.keys.product_adj }} via la console {{ site.data.keys.mf_console }} en verrouillant des applications ou en refusant des accès ou en affichant des messages de notification.

Vous pouvez démarrer la console en entrant l'une des URL suivantes :

* Mode sécurisé pour un environnement de production ou de test : `https://hostname:secure_port/mfpconsole`
* Développement : `http://server_name:port/mfpconsole`

Vous devez disposer d'un ID de connexion et d'un mot de passe vous permettant d'accéder à la console {{ site.data.keys.mf_console }}. Pour plus d'informations, voir [Configuration de l'authentification d'utilisateur pour l'administration de {{ site.data.keys.mf_server }}](../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

Vous pouvez utiliser la console {{ site.data.keys.mf_console }} pour gérer vos applications.

A partir de la console {{ site.data.keys.mf_console }}, vous pouvez également accéder à la console d'analyse et contrôler la collecte de données mobiles destinées à être analysées par le serveur d'analyse. Pour plus d'informations, voir [Activation ou désactivation de la collecte de données à partir de la console {{ site.data.keys.mf_console }}](../../analytics/console/#enabledisable-analytics-support).

#### Accéder à
{: #jump-to }

* [Gestion des applications mobiles](#mobile-application-management)
* [Statut d'application et octroi de licence de jeton](#application-status-and-token-licensing)
* [Journal des erreurs liées aux opérations dans des environnements d'exécution](#error-log-of-operations-on-runtime-environments)
* [Journal d'audit des opérations d'administration](#audit-log-of-administration-operations)

## Gestion des applications mobiles
{: #mobile-application-management }
Les fonctions de gestion des applications mobiles de {{ site.data.keys.product_adj }} fournissent aux opérateurs et aux administrateurs de {{ site.data.keys.mf_server }} un contrôle granulaire comparé à l'accès des utilisateurs et des appareils à leurs applications.

{{ site.data.keys.mf_server }} assure le suivi de toutes les tentatives d'accès à votre infrastructure mobile et stocke des informations sur l'application, l'utilisateur et l'appareil sur lequel l'application est installée. Le mappage entre l'application, l'utilisateur et l'appareil constitue la base des fonctions de gestion des applications mobiles du serveur.

Utilisez IBM {{ site.data.keys.mf_console }} pour surveiller et gérer les accès à vos ressources :

* Recherchez un utilisateur par nom et affichez des informations sur les appareils et les applications qu'il utilise pour accéder à vos ressources.
* Recherchez un appareil par nom d'affichage et affichez les utilisateurs qui sont associés à cet appareil, ainsi que les applications {{ site.data.keys.product_adj }} enregistrées utilisées sur cet appareil.
* Bloquez l'accès à vos ressources à partir de toutes les instances de vos applications sur un appareil donné. Cette opération est utile lorsqu'un appareil est perdu ou volé.
* Bloquez l'accès à vos ressources uniquement pour une application ou un appareil spécifiques. Par exemple, si un employé change de service, vous pouvez bloquer l'accès de cet employé à une application du service précédent, mais autoriser cet employé à accéder au même appareil à partir d'autres applications.
* Annulez l'enregistrement d'un appareil et supprimez toutes les données d'enregistrement et de surveillance collectées pour l'appareil.

Le blocage des accès possède les caractéristiques suivantes :

* L'opération de blocage est réversible. Vous pouvez retirer le blocage en modifiant le statut d'appareil ou d'application dans la console {{ site.data.keys.mf_console }}.
* Le blocage s'applique uniquement à des ressources protégées. Un client bloqué peut tout de même utiliser l'application pour accéder à une ressource non protégée. Voir la rubrique Ressources non protégées.
* L'accès à des ressources d'adaptateur sur {{ site.data.keys.mf_server }} est immédiatement bloqué lorsque vous sélectionnez cette opération. En revanche, cela n'est pas toujours le cas pour les ressources d'un serveur externe car l'application peut comporter un jeton d'accès valide qui n'a pas encore expiré.

### Statut de l'appareil
{: #device-status }
{{ site.data.keys.mf_server }} gère les informations de statut pour chaque appareil qui accède au serveur. Les valeurs de statut possibles sont **Actif**, **Perdu**, **Volé**, **Arrivé à expiration** et **Désactivé**.

Le statut d'appareil par défaut est **Actif**, indiquant que l'accès à partir de cet appareil n'est pas bloqué. Vous pouvez remplacer le statut par **Perdu**, **Volé** ou **Désactivé** pour bloquer l'accès à vos ressources d'application à partir de l'appareil. Vous pouvez toujours restaurer le statut **Actif** pour autoriser de nouveau l'accès. Voir [Gestion des accès des appareils dans la console {{ site.data.keys.mf_console }}](#managing-device-access-in-mobilefirst-operations-console).

Le statut **Arrivé à expiration** est un statut spécial défini par le serveur {{ site.data.keys.mf_server }} qui se déclenche au terme d'une durée d'inactivité préconfigurée depuis la dernière connexion de l'appareil à cette instance de serveur. Ce statut est utilisé pour le suivi des licences et n'affecte par les droits d'accès d'un appareil. Lorsqu'un appareil ayant le statut **Arrivé à expiration** se reconnecte au serveur, il repasse au statut **Actif** et il est autorisé à accéder au serveur.

### Nom d'affichage d'appareil
{: #device-display-name }
{{ site.data.keys.mf_server }} identifie les appareils au moyen d'un ID d'appareil unique, affecté par le kit de développement de logiciels du client {{ site.data.keys.product_adj }}. Définir un nom d'affichage pour un appareil vous permet de rechercher ce dernier à partir de son nom d'affichage. Les développeurs d'applications peuvent utiliser la méthode `setDeviceDisplayName` de la classe `WLClient` pour définir le nom d'affichage d'appareil. Voir la documentation `WLClient` dans [{{ site.data.keys.product_adj }} client-side API](../../api/client-side-api/javascript/client/). (La classe JavaScript est `WL.Client`.) Les développeurs d'adaptateurs Java (y compris les développeurs de contrôle de sécurité) peuvent également définir le nom d'affichage d'appareil en utilisant la méthode `setDeviceDisplayName` de la classe com.ibm.mfp.server.registration.external.model `MobileDeviceData`. Voir [MobileDeviceData](../../api/client-side-api/objc/client/).

### Gestion des accès des appareils dans la console {{ site.data.keys.mf_console }}
{: #managing-device-access-in-mobilefirst-operations-console }
Pour surveiller et gérer les accès des appareils à vos ressources, sélectionnez l'onglet Appareils dans le tableau de bord de {{ site.data.keys.mf_console }}.

Utilisez la zone de recherche pour rechercher un appareil à l'aide de l'ID utilisateur associé à cet appareil ou du nom d'affichage de l'appareil (s'il est défini). Voir [Nom d'affichage d'appareil](#device-display-name). Vous pouvez également rechercher une partie de l'ID utilisateur ou du nom d'affichage d'appareil (au moins trois caractères).

Les résultats de la recherche affichent tous les appareils qui correspondent à l'ID utilisateur ou au nom d'affichage d'appareil spécifié. Pour chaque appareil, vous pouvez afficher l'ID et le nom d'affichage d'appareil, le modèle d'appareil, le système d'exploitation et la liste des ID utilisateur associés à l'appareil.

La colonne Statut de l'appareil affiche le statut de l'appareil. Vous pouvez remplacer le statut de l'appareil par **Perdu**, **Volé** ou **Désactivé** pour bloquer l'accès à vos ressources protégées à partir de l'appareil. Le fait de rétablir le statut **Actif** restaure les droits d'accès d'origine.

Vous pouvez annuler l'enregistrement d'un appareil en sélectionnant **Annuler l'enregistrement** dans la colonne **Actions**. Le fait d'annuler l'enregistrement d'un appareil supprime les données d'enregistrement de toutes les applications {{ site.data.keys.product_adj }} installées sur l'appareil. En outre, le nom d'affichage d'appareil, les listes d'utilisateurs associés à l'appareil et les attributs publics enregistrés par l'application pour cet appareil sont supprimés.

**Remarque :** L'action **Annuler l'enregistrement** est irréversible. La prochaine fois que l'une des applications{{ site.data.keys.product_adj }} de l'appareil tentera d'accéder au serveur, elle sera de nouveau enregistrée avec le nouvel ID d'appareil. Lorsque vous choisissez de réenregistrer l'appareil, celui-ci passe au statut **Actif** et il peut accéder aux ressources protégées, même s'il existe des blocages précédents. Par conséquent, si vous souhaitez bloquer un appareil, n'annulez pas son enregistrement. A la place, remplacez son statut par **Perdu**, **Volé** ou **Désactivé**.

Pour afficher toutes les applications qui ont fait l'objet d'un accès sur un appareil spécifique, sélectionnez la flèche de développement en regard de l'ID d'appareil dans le tableau répertoriant les appareils. Chaque ligne du tableau répertoriant les applications affichées contient le nom de l'application, ainsi que le statut d'accès de l'application (indiquant si l'accès aux ressources protégées est activé pour cette application sur cet appareil). Vous pouvez remplacer le statut de l'application par **Désactivé** pour bloquer l'accès à partir de l'application sur cet appareil en particulier.

#### Accéder à
{: #jump-to-1 }

* [Désactivation à distance de l'accès d'une application à des ressources protégées](#remotely-disabling-application-access-to-protected-resources)
* [Affichage d'un message d'administrateur](#displaying-an-administrator-message)
* [Définition de messages d'administrateur dans plusieurs langues](#defining-administrator-messages-in-multiple-languages)

### Désactivation à distance de l'accès d'une application à des ressources protégées
{: #remotely-disabling-application-access-to-protected-resources }
Utilisez {{ site.data.keys.mf_console }} (la console) pour désactiver l'accès utilisateur à une version spécifique d'une application sur un système d'exploitation mobile spécifique et fournir un message personnalisé à l'utilisateur.

1. Sélectionnez votre version d'application dans la section **Applications** de la barre d'options latérale de la console, puis sélectionnez l'onglet **Gestion**.
2. Remplacez le statut par **Accès désactivé**.
3. Vous avez la possibilité d'indiquer dans la zone **Adresse URL de la dernière version** l'URL d'une version plus récente de l'application (généralement dans le magasin d'applications public ou privé approprié). Pour certains environnements, Application Center fournit une URL permettant d'accéder directement à la vue Détails d'une version d'application. Voir [Propriétés d'application](../../appcenter/appcenter-console/#application-properties).
4. Ajoutez dans la zone **Message de notification par défaut** le message de notification personnalisé à afficher lorsque l'utilisateur tente d'accéder à l'application. L'exemple de message suivant indique aux utilisateurs qu'ils doivent effectuer une mise à niveau vers la version la plus récente :

   ```bash
   Cette version n'est plus prise en charge. Effectuez une mise à niveau vers la dernière version.
   ```

5. Vous pouvez éventuellement indiquer le message de notification dans d'autres langues dans la section **Environnements locaux pris en charge**.
6. Sélectionnez **Sauvegarder** pour appliquer vos modifications.

Lorsqu'un utilisateur exécute une application qui a été désactivée à distance, une fenêtre de dialogue contenant votre message personnalisé s'affiche. Le message apparaît pour toute interaction d'application nécessitant d'accéder à une ressource protégée ou lorsque l'application tente d'obtenir un jeton d'accès. Si vous avez indiqué une URL de mise à niveau de version, la boîte de dialogue comporte un bouton **Obtenir la nouvelle version** permettant d'effectuer une mise à niveau vers une version plus récente, en plus du bouton **Fermer** affiché par défaut. Si l'utilisateur ferme la fenêtre de boîte de dialogue sans mettre à niveau la version, il peut continuer de gérer les parties de l'application pour lesquelles l'accès à des ressources protégées n'est pas requis. Toutefois, une interaction d'application pour laquelle l'accès à une ressource protégée est requis provoque une nouvelle apparition de la fenêtre de dialogue et l'application n'est pas autorisée à accéder à la ressource.

<!-- **Note:** For cross-platform applications, you can customize the default remote-disable behavior: provide an upgrade URL for your application, as outlined in Step 3, and set the **showCloseOnRemoteDisableDenial** attribute in your application's initOptions.js file to false. If the attribute is not defined, define it. When an application-upgrade URL is provided and the value of **showCloseOnRemoteDisableDenial** is false, the **Close** button is omitted from the remote-disable dialog window, leaving only the Get new version button. This forces the user to upgrade the application. When no upgrade URL is provided, the **showCloseOnRemoteDisableDenial** configuration has no effect, and a single **Close** button is displayed. -->

### Affichage d'un message d'administrateur
{: #displaying-an-administrator-message }
Suivez la procédure décrite pour configurer le message de notification. Vous pouvez utiliser ce message pour signaler des situations temporaires aux utilisateurs de l'application, telles qu'une durée d'immobilisation prévue pour cause de maintenance.

1. Sélectionnez votre version d'application dans la section **Applications** de la barre d'options latérale de la console {{ site.data.keys.mf_console }}, puis sélectionnez l'onglet de gestion des applications.
2. Remplacez le statut par **Actif et notification**.
3. Ajoutez un message de démarrage personnalisé. L'exemple de message suivant signale à l'utilisateur une activité de maintenance planifiée pour l'application :

   ```bash
   Le serveur sera indisponible samedi entre 4 h 00 et 6 h 00 en raison d'une opération de maintenance planifiée.
   ```

4. Vous pouvez éventuellement indiquer le message de notification dans d'autres langues dans la section Environnements locaux pris en charge.

5. Sélectionnez **Sauvegarder** pour appliquer vos modifications.

Le message apparaît la première fois que l'application utilise {{ site.data.keys.mf_server }} pour accéder à une ressource protégée ou pour obtenir un jeton d'accès. Si l'application acquiert un jeton d'accès lorsqu'elle démarre, le message s'affiche à ce moment-là. Sinon, le message apparaît lors de la première demande de l'application pour accéder à une ressource protégée ou obtenir un jeton d'accès. Le message ne s'affiche qu'une seule fois, pour la première interaction.

### Définition de messages d'administrateur dans plusieurs langues
{: #defining-administrator-messages-in-multiple-languages }
<b>Remarque :</b> Dans Microsoft Internet Explorer (IE) et Microsoft Edge, des messages d'administration et des messages SDK Web client s'affichent en fonction de la définition des préférences de format de région du système d'exploitation et non en fonction des préférences de langue configurées pour le navigateur ou le système d'exploitation. Voir [Limitations des applications Web IE et Edge](../../product-overview/release-notes/known-issues-limitations/#web_app_limit_ms_ie_n_edge).

Suivez la procédure décrite pour configurer plusieurs langues dans lesquelles afficher les messages d'administration d'application que vous avez définis via la console. Les messages sont envoyés en fonction de l'environnement local de l'appareil et doivent être conformes aux normes utilisées par le système d'exploitation mobile pour spécifier les environnements locaux.

1. Sélectionnez votre version d'application dans la section **Applications** de la barre d'options latérale de la console {{ site.data.keys.mf_console }}, puis sélectionnez l'onglet **Gestion** de l'application.
2. Sélectionnez le statut **Actif et notification** ou **Accès désactivé**.
3. Sélectionnez **Mettre à jour les environnements locaux**. Dans la section **Télécharger le fichier** de la fenêtre de dialogue affichée, sélectionnez **Télécharger** et accédez à l'emplacement d'un fichier CSV qui définit les environnements locaux.

   Chaque ligne du fichier CSV contient une paire de chaînes séparées par des virgules. La première chaîne est le code d'environnement local (par exemple, fr-FR pour Français (France) ou en pour Anglais), et la seconde chaîne est le texte de message dans la langue correspondante. Les codes d'environnement local spécifiés doivent être conformes aux normes utilisées par le système d'exploitation mobile pour indiquer les environnements locaux, par exemple, ISO 639-1, ISO 3166-2 et ISO 15924.

   > **Remarque :** Pour créer le fichier CSV, vous devez utiliser un éditeur prenant en charge le codage UTF-8, tel que Notepad.

   Voici un exemple de fichier CSV qui définit le même message pour plusieurs environnements locaux :

   ```xml
   en,Your application is disabled
   en-US,Your application is disabled in US
   en-GB,Your application is disabled in GB
   fr,votre application est désactivée
   he,האפליקציה חסמומה
   ```

4. Un tableau répertoriant les codes d'environnement local et les messages de votre fichier CSV est visible dans la section **Vérification des messages de notification
**. Vérifiez les messages, puis sélectionnez **OK**.
Vous pouvez sélectionner l'option Editer à tout moment afin de remplacer le fichier CSV d'environnements locaux. Vous pouvez également utiliser cette option pour envoyer par téléchargement un fichier CSV vide et retirer tous les environnements locaux.
5. Sélectionnez **Sauvegarder** pour appliquer vos modifications.

Le message de notification localisé s'affiche sur l'appareil mobile de l'utilisateur, en fonction de l'environnement local de l'appareil. Si aucun message n'a été configuré pour l'environnement local d'appareil, le message par défaut que vous avez indiqué s'affiche.

## Statut d'application et octroi de licence de jeton
{: #application-status-and-token-licensing }
Vous devez restaurer manuellement le statut d'application approprié dans la console {{ site.data.keys.mf_console }} après le statut Bloqué en raison d'un nombre de jetons insuffisant.

Si vous utilisez l'octroi de licence de jeton et que vous ne disposez plus de suffisamment de jetons de licence pour une application, le statut d'application de toutes les versions de l'application devient **Bloqué**. Vous ne pouvez plus modifier le statut de n'importe quelle version de l'application. Le message suivant s'affiche dans la console{{ site.data.keys.mf_console }} :

```bash
L'application a été bloquée car sa licence a expiré
```

Si un nombre suffisant de jetons pour exécuter l'application se libère ultérieurement ou si votre organisation acquiert d'autres jetons, le message suivant s'affiche dans la console {{ site.data.keys.mf_console }} :

```bash
L'application a été bloquée car sa licence a expiré. Une nouvelle licence est désormais disponible
```

Le statut d'affichage est toujours **Bloqué**. Vous devez restaurer manuellement le statut actuel correct de la mémoire ou de vos propres enregistrements en éditant la zone Statut. {{ site.data.keys.product }} ne gère pas l'affichage du statut **Bloqué** dans la console {{ site.data.keys.mf_console }} d'une application qui a été bloquée en raison d'un nombre de jetons de licence insuffisant. Il vous incombe de restaurer un statut réel pour une application ainsi bloquée pouvant être affiché via la console {{ site.data.keys.mf_console }}.

## Journal des erreurs liées aux opérations dans des environnements d'exécution
{: #error-log-of-operations-on-runtime-environments }
Utilisez le journal des erreurs pour accéder aux opérations de gestion ayant échoué initiées à partir de la console {{ site.data.keys.mf_console }} ou de la ligne de commande sur l'environnement d'exécution sélectionné et pour voir l'effet de cet échec sur les serveurs.

Lorsqu'une transaction échoue, la barre de statut affiche une notification de l'erreur et affiche un lien vers le journal des erreurs. Utilisez le journal des erreurs pour obtenir davantage de détails sur l'erreur, par exemple, le statut de chaque serveur avec un message d'erreur spécifique, ou pour obtenir l'historique des erreurs. Le journal des erreurs affiche l'opération la plus récente en premier.

Vous accédez au journal des erreurs en cliquant sur **Journal des erreurs** pour un environnement d'exécution dans la console {{ site.data.keys.mf_console }}.

Développez la ligne qui fait référence à l'opération ayant échoué afin d'accéder à d'autres informations sur l'état en cours de chaque serveur. Pour accéder au journal complet, téléchargez- celui-ci en cliquant sur **Télécharger le journal**.

![Journal des erreurs dans la console](error-log.png)

## Journal d'audit des opérations d'administration
{: #audit-log-of-administration-operations }
Dans la console {{ site.data.keys.mf_console }}, vous pouvez faire référence à un journal d'audit des opérations d'administration.

{{ site.data.keys.mf_console }} fournit un accès à un journal d'audit pour la connexion, la déconnexion et toutes les opérations d'administration, telles que le déploiement d'applications ou d'adaptateurs ou le verrouillage d'applications. Le journal d'audit peut être désactivé en affectant la valeur **false** à la propriété JNDI (Java Naming and Directory Interface) **mfp.admin.audit** sur l'application Web du service d'administration de {{ site.data.keys.product_adj }}.

Pour accéder au journal d'audit, cliquez sur le nom d'utilisateur dans la barre d'en-tête et sélectionnez **A propos**, cliquez sur **Informations de support supplémentaires**, puis sur **Télécharger le journal d'audit**.

| Nom de zone | Description |
|------------|-------------|
| Timestamp	 | Date et heure auxquelles l'enregistrement a été créé. |
| Type	     | Type d'opération. Pour connaître les valeurs possibles, voir la liste des types d'opération. |
| User	     | **Nom** de l'utilisateur qui est connecté. |
| Outcome	 | Résultat de l'opération : les valeurs possibles sont SUCCESS, ERROR, PENDING. |
| ErrorCode	 | Si le résultat est ERROR, ErrorCode indique de quelle erreur s'il s'agit. |
| Runtime	 | Nom du projet {{ site.data.keys.product_adj }} qui est associé à l'opération. |

La liste suivante répertorie les valeurs de type d'opération possibles :

* Login
* Logout
* AdapterDeployment
* AdapterDeletion
* ApplicationDeployment
* ApplicationDeletion
* ApplicationLockChange
* ApplicationAuthenticityCheckRuleChange
* ApplicationAccessRuleChange
* ApplicationVersionDeletion
* add config profile
* DeviceStatusChange
* DeviceApplicationStatusChange
* DeviceDeletion
* unsubscribeSMS
* DeleteDevice
* DeleteSubscriptions
* SetPushEnabled
* SetGCMCredentials
* DeleteGCMCredentials
* sendMessage
* sendMessages
* setAPNSCredentials
* DeleteAPNSCredentials
* setMPNSCredentials
* deleteMPNSCredentials
* createTag
* updateTag
* deleteTag
* add runtime
* delete runtime
