---
layout: tutorial
title: Configuration de MobileFirst Server
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Déterminez votre stratégie de sauvegarde et de récupération, optimisez la configuration de votre serveur {{ site.data.keys.mf_server }} et appliquez des restrictions d'accès et des options de sécurité. 

#### Accéder à
{: #jump-to }

* [Noeuds finaux du serveur de production de {{ site.data.keys.mf_server }}](#endpoints-of-the-mobilefirst-server-production-server)
* [Configuration de {{ site.data.keys.mf_server }} pour activer TLS V1.2](#configuring-mobilefirst-server-to-enable-tls-v12)
* [Configuration de l'authentification d'utilisateur pour l'administration de {{ site.data.keys.mf_server }} ](#configuring-user-authentication-for-mobilefirst-server-administration)
* [Liste des propriétés JNDI des applications Web de {{ site.data.keys.mf_server }}](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [Configuration des sources de données](#configuring-data-sources)
* [Configuration des mécanismes de journalisation et de surveillance](#configuring-logging-and-monitoring-mechanisms)
* [Configuration de plusieurs environnements d'exécution](#configuring-multiple-runtimes)
* [Configuration du suivi des licences](#configuring-license-tracking)
* [Configuration SSL WebSphere Application Server et adaptateurs HTTP](#websphere-application-server-ssl-configuration-and-http-adapters)

## Noeuds finaux du serveur de production de {{ site.data.keys.mf_server }}
{: #endpoints-of-the-mobilefirst-server-production-server }
Vous pouvez créer des listes blanches et des listes noires pour les noeuds finaux du serveur IBM {{ site.data.keys.mf_server }}.

> **Remarque :** Des informations sur les URL qui sont exposées par {{ site.data.keys.product }} sont fournies comme instructions. Les organisations doivent s'assurer que les URL sont testées dans une infrastructure d'entreprise, en fonction de ce qui a été activé pour les listes blanches et les listes noires.

| URL d'API sous `<runtime context root>/api/` | Description                               | Suggérée pour une liste blanche ? |
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | Renvoyer la documentation swagger d'adaptateur pour l'adaptateur nommé | Non. Utilisée en interne uniquement par l'administrateur et les développeurs |
| /adapters/*  | Prise en charge d'adaptateurs | Oui |
| /az/v1/authorization/* | Autoriser le client à accéder à une portée spécifique | Oui |
| /az/v1/introspection | Procéder à l'introspection du jeton d'accès du client | Non. Cette API s'adresse uniquement à des clients confidentiels.  |
| /az/v1/token | Générer un jeton d'accès pour le client | Oui |
| /clientLogProfile/* | Obtenir un profil de journal client | Oui |
| /directupdate/* | Obtenir un fichier .zip de mise à jour directe | Oui, si vous prévoyez d'utiliser la mise à jour directe |
| /loguploader | Télécharger des journaux client sur un serveur | Oui |
| /preauth/v1/heartbeat | Accepter le signal de présence du client et noter l'heure de la dernière activité | Oui |
| /preauth/v1/logout | Se déconnecter d'un contrôle de sécurité | Oui |
| /preauth/v1/preauthorize | Mapper et exécuter des contrôles de sécurité pour une portée spécifique | Oui |
| /reach | Le serveur est accessible | Non, pour un usage interne uniquement |
| /registration/v1/clients/* | API de clients de service d'enregistrement | Non. Cette API s'adresse uniquement à des clients confidentiels.  |
| /registration/v1/self/* | API d'auto-enregistrement de client de service d'enregistrement | Oui |

## Configuration de {{ site.data.keys.mf_server }} pour activer TLS V1.2
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
Pour que {{ site.data.keys.mf_server }} communique avec des appareils prenant en charge uniquement TLS (Transport Layer Security) v1.2, parmi les protocoles SSL, vous devez exécuter les instructions décrites ci-après. 

Les étapes de configuration de {{ site.data.keys.mf_server }} pour activer TLS V1.2 dépendent de la façon dont {{ site.data.keys.mf_server }} se connecte aux appareils. 

* Si {{ site.data.keys.mf_server }} se trouve derrière un proxy inverse qui déchiffre des paquets codés en SSL à partir d'appareils avant de transmettre ces paquets au serveur d'applications, vous devez activer la prise en charge de TLS V1.2 sur votre proxy inverse. Si vous utilisez IBM HTTP Server comme proxy inverse, voir [Securing IBM HTTP Server](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc) pour obtenir des instructions.
* Si {{ site.data.keys.mf_server }} communique directement avec des appareils, les étapes permettant d'activer TLS V1.2 varient selon que votre serveur d'applications est Apache Tomcat, le profil Liberty de WebSphere Application Server ou le profil complet de WebSphere Application Server. 

### Apache Tomcat
{: #apache-tomcat }
1. Vérifiez que l'environnement d'exécution Java (JRE) prend en charge TLS V1.2.
    Assurez-vous que vous disposez de l'une des versions JRE suivantes :
    * Oracle JRE version 1.7.0_75 ou ultérieure
    * Oracle JRE version 1.8.0_31 ou ultérieure
2. Editez le fichier **conf/server.xml** et modifiez l'élément `Connector` qui déclare le port HTTPS de sorte que l'attribut **sslEnabledProtocols** soit défini avec la valeur suivante : `sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"`.

### Profil Liberty de WebSphere Application Server
{: #websphere-application-server-liberty-profile }
1. Vérifiez que l'environnement d'exécution Java (JRE) prend en charge TLS V1.2. 
    * Si vous utilisez un logiciel SDK IBM Java, assurez-vous que celui-ci dispose d'un correctif pour la vulnérabilité POODLE. Les versions minimales du logiciel SDK IBM Java qui contiennent le correctif pour votre version de WebSphere Application Server sont disponibles sur la page [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).

        > **Remarque :** Vous pouvez utiliser les versions répertoriées dans le bulletin de sécurité ou des versions ultérieures. 
    * Si vous utilisez un logiciel SDK Oracle Java, assurez-vous que vous disposez de l'une des versions suivantes :
        * Oracle JRE version 1.7.0_75 ou ultérieure
        * Oracle JRE version 1.8.0_31 ou ultérieure
2. Si vous utilisez un logiciel SDK IBM Java, éditez le fichier **server.xml**.
    * Ajoutez la ligne suivante : `<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * Ajoutez l'attribut `sslProtocol="SSL_TLSv2"` à tous les éléments `<ssl>` existants. 

### Profil complet de WebSphere Application Server
{: #websphere-application-server-full-profile }
1. Vérifiez que l'environnement d'exécution Java (JRE) prend en charge TLS V1.2. 

Assurez-vous que votre logiciel SDK IBM Java dispose d'un correctif pour la vulnérabilité POODLE. Les versions minimales du logiciel SDK IBM Java qui contiennent le correctif pour votre version de WebSphere Application Server sont disponibles sur la page [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).    > **Remarque :** Vous pouvez utiliser les versions répertoriées dans le bulletin de sécurité ou des versions ultérieures.
2. Connectez-vous à la console d'administration de WebSphere Application Server, puis cliquez sur **Sécurité → Certificat SSL et gestion des clés → Configurations SSL **.
3. Pour chaque configuration SSL répertoriée, modifiez la configuration de manière à activer TLS V1.2.
    * Sélectionnez une configuration SSL, puis, sous **Propriétés supplémentaires**, cliquez sur les paramètres **Qualité de protections (QoP)**. 
    * Dans la liste **Protocole**, sélectionnez **SSL_TLSv2**.
    * Cliquez sur **Appliquer** et sauvegardez les modifications. 

## Configuration de l'authentification d'utilisateur pour l'administration de {{ site.data.keys.mf_server }}
{: #configuring-user-authentication-for-mobilefirst-server-administration }
L'administration de {{ site.data.keys.mf_server }} requiert l'authentification d'utilisateur. Vous pouvez configurer l'authentification d'utilisateur et sélectionner une méthode d'authentification. Ensuite, la procédure de configuration dépend du serveur d'applications Web que vous utilisez. 

> **Important :** Si vous utilisez un profil complet de WebSphere Application Server autonome, utilisez une méthode d'authentification autre que la méthode d'authentification WebSphere simple (SWAM) dans la sécurité globale. Vous pouvez utiliser l'authentification LTPA. Si vous utilisez la méthode d'authentification SWAM, il se peut que des échecs d'authentification inattendus se produisent.
Vous devez configurer l'authentification après que le programme d'installation a déployé les applications Web d'administration de {{ site.data.keys.mf_server }} dans le serveur d'applications Web. 

Les rôles de sécurité Java Platform, Enterprise Edition (Java EE) suivants sont définis pour l'administration de {{ site.data.keys.mf_server }} : 

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

Vous devez mapper les rôles aux ensembles d'utilisateurs correspondants. Le rôle **mfpmonitor** ne peut pas modifier des données, mais uniquement les visualiser. Les tableaux ci-après répertorient les rôles et les fonctions MobileFirst pour les serveurs de production. 

#### Déploiement
{: #deployment }

|                        | Administrateur | Déployeur    | Opérateur     | Moniteur    |
|------------------------|---------------|-------------|-------------|------------|
| Rôle de sécurité Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Déployer une application. | Oui           | Oui         | Non          | Non         |
| Déployer un adaptateur.     | Oui           | Oui         | Non          | Non         |

#### Gestion de {{ site.data.keys.mf_server }}
{: #mobilefirst-server-management }

|                            | Administrateur | Déployeur    | Opérateur     | Moniteur    |
|----------------------------|---------------|-------------|-------------|------------|
| Rôle de sécurité Java EE.     | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Configurer les paramètres d'exécution.| Oui           | Oui         | Non          | Non         |

#### Gestion des applications
{: #mobilefirst-server-management }

|                                     | Administrateur | Déployeur    | Opérateur     | Moniteur    |
|-------------------------------------|---------------|-------------|-------------|------------|
| Rôle de sécurité Java EE.              | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Télécharger une nouvelle application {{ site.data.keys.product_adj }}. | Oui           | Oui         | Non          | Non         |
| Retirer une application {{ site.data.keys.product_adj }}.	  | Oui           | Oui         | Non          | Non         |
| Télécharger un nouvel adaptateur.     | Oui           | Oui         | Non          | Non         |
| Retirer un adaptateur.         | Oui           | Oui         | Non          | Non         |
| Activer ou désactiver les tests d'authenticité d'une application. | Oui | Oui | Non | Non    |
| Modifier les propriétés de statut d'application {{ site.data.keys.product_adj }} : Actif, Actif, notification et Désactivé. | Oui | Oui | Oui | Non |

D'une manière générale, tous les rôles peuvent émettre des demandes GET, les rôles **mfpadmin**, **mfpdeployer** et **mfpmonitor** peuvent également émettre des demandes POST et PUT, et les rôles **mfpadmin** et **mfpdeployer** peuvent également émettre des demandes DELETE. 

#### Demandes liées aux notifications push
{: #requests-related-to-push-notifications }

|                        | Administrateur | Déployeur    | Opérateur     | Moniteur    |
|------------------------|---------------|-------------|-------------|------------|
| Rôle de sécurité Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Demandes GET {::nomarkdown}<ul><li>Obtenir la liste de tous les appareils qui utilisent la notification push pour une application</li><li>Obtenir les détails relatifs à un appareil spécifique</li><li>Obtenir la liste d'abonnements</li><li>Obtenir les informations d'abonnement associées à un ID d'abonnement.</li><li>Obtenir les détails d'une configuration GCM.</li><li>Obtenir les détails d'une configuration APNS.</li><li>Obtenir la liste des étiquettes définies pour l'application.</li><li>Obtenir les détails relatifs à une étiquette spécifique</li></ul>{:/}| Oui           | Oui         | Oui         | Oui        |
| Demandes POST et PUT {::nomarkdown}<ul><li>Enregistrer une application auprès de notifications push</li><li>Mettre à jour un enregistrement d'appareil par commande push</li><li>Créer un abonnement</li><li>Ajouter ou mettre à jour une configuration GCM</li><li>Ajouter ou mettre à jour une configuration APNS</li><li>Soumettre des notifications à un appareil</li><li>Créer ou mettre à jour une étiquette</li></ul>{:/} | Oui           | Oui         | Oui         | Non         |
| Demandes DELETE {::nomarkdown}<ul><li>Supprimer l'enregistrement d'un appareil auprès d'une notification push</li><li>Supprimer un abonnement</li><li>Désabonner un appareil d'une étiquette</li><li>Supprimer une configuration GCM</li><li>Supprimer une configuration APNS</li><li>Supprimer une étiquette</li></ul>{:/} | Oui           | Oui         | Non          | Non         |

#### Désactivation
{: #disabling }

|                        | Administrateur | Déployeur    | Opérateur     | Moniteur    |
|------------------------|---------------|-------------|-------------|------------|
| Rôle de sécurité Java EE. | mfpadmin      | mfpdeployer | mfpoperator | mfpmonitor |
| Désactiver l'appareil spécifique en marquant l'état comme perdu ou volé de sorte que l'accès à cet appareil à partir des applications soit bloqué.       | Oui           | Oui         | Oui          | Non        |
| Désactiver une application spécifique en marquant l'état comme désactivé de sorte que l'accès à cet appareil à partir de cette application soit bloqué.              | Oui           | Oui         | Oui         | Non         |

Si vous choisissez d'utiliser une méthode d'authentification via un référentiel d'utilisateurs, tel que LDAP, vous pouvez configurer l'administration de {{ site.data.keys.mf_server }} de manière à pouvoir utiliser des utilisateurs et des groupes avec le référentiel d'utilisateurs pour définir la liste de contrôle d'accès de l'administration de {{ site.data.keys.mf_server }}. Cette procédure dépend du type et de la version du serveur d'applications Web que vous utilisez. 

### Configuration du profil complet de WebSphere Application Server pour l'administration de {{ site.data.keys.mf_server }}
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
Configurez la sécurité en mappant les rôles Java EE d'administration de {{ site.data.keys.mf_server }} à un ensemble d'utilisateurs pour les deux applications Web. 

Vous définissez les bases de la configuration utilisateur dans la console WebSphere Application Server. L'accès à la console se fait généralement à l'aide de l'adresse suivante : `https://localhost:9043/ibm/console/`

1. Sélectionnez **Sécurité → Sécurité globale**.
2. Sélectionnez **Assistant de configuration de sécurité** pour configurer des utilisateurs.
    Vous pouvez gérer des comptes utilisateur individuels en sélectionnant **Utilisateurs et groupes → Gérer les utilisateurs**.
3. Mappez les rôles **mfpadmin**, **mfpdeployer**, **mfpmonitor** et **mfpoperator** à un ensemble d'utilisateurs. 
    * Sélectionnez **Serveurs → Types de serveur → Serveurs d'applications WebSphere**.
    * Sélectionnez le serveur.
    * Sur l'onglet **Configuration**, sélectionnez **Applications → Applications d'entreprise**.
    * Sélectionnez **MobileFirst_Administration_Service**.
    * Sur l'onglet **Configuration**, sélectionnez **Détails → Mappage de rôle de sécurité** à utilisateur/groupe.
    * Effectuez les tâches de personnalisation nécessaires.
    * Cliquez sur **OK**.
    * Répétez les étapes afin de mapper les rôles pour la console d'application Web. Cette fois-ci, sélectionnez **MobileFirst_Administration_Console**.
    * Cliquez sur **Sauvegarder** pour sauvegarder les modifications.

### Configuration du profil Liberty de WebSphere Application Server pour l'administration de {{ site.data.keys.mf_server }}
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
Dans le profil Liberty de WebSphere Application Server, vous configurez les rôles **mfpadmin**, **mfpdeployer**, **mfpmonitor** et **mfpoperator** dans le fichier de configuration **server.xml** du serveur. 

Pour configurer les rôles de sécurité, vous devez éditer le fichier **server.xml**. Dans l'élément `<application-bnd>` de chaque élément `<application>`, créez des éléments `<security-role>`. Chaque élément `<security-role>` s'applique à chacun des rôles : **mfpadmin**, mfpdeployer, mfpmonitor et mfpoperator. Mappez les rôles du nom de groupe d'utilisateurs approprié, dans cet exemple :**mfpadmingroup**, **mfpdeployergroup**, **mfpmonitorgroup** ou **mfpoperatorgroup**. Ces groupes sont définis via l'élément `<basicRegistry>`. Vous pouvez personnaliser cet élément ou le remplacer entièrement par un élément `<ldapRegistry>` ou un élément `<safRegistry>`. 

Ensuite, pour garantir des temps de réponse convenables avec un nombre important d'applications installées, par exemple, avec 80 applications, vous devez configurer un pool de connexions pour la base de données d'administration. 

1. Editez le fichier **server.xml**. Exemple :

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. Définissez la taille **AppCenterPool** :

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. Dans l'élément `<dataSource>`, définissez une référence pour le gestionnaire de connexions :

   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### Configuration d'Apache Tomcat pour l'administration de {{ site.data.keys.mf_server }}
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
Vous devez configurer les rôles de sécurité Java EE pour l'administration de {{ site.data.keys.mf_server }} sur le serveur d'applications Web Apache Tomcat.

1. Si vous avez installé l'administration de {{ site.data.keys.mf_server }} manuellement, déclarez les rôles suivants dans le fichier **conf/tomcat-users.xml** :

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. Ajoutez des rôles aux utilisateurs sélectionnés, par exemple :

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. Vous pouvez définir l'ensemble d'utilisateurs en procédant comme indiqué dans la documentation Apache Tomcat, [Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html).

## Liste des propriétés JNDI des applications Web {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
Configurez les propriétés JNDI des applications Web {{ site.data.keys.mf_server }} qui sont déployées sur le serveur d'applications. 

* [Configuration de propriétés JNDI pour les applications Web de {{ site.data.keys.mf_server }}](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Liste des propriétés JNDI pour le service Live Update de {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}](#list-of-jndi-properties-for-mobilefirst-runtime)
* [Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### Configuration de propriétés JNDI pour les applications Web de {{ site.data.keys.mf_server }}
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
Configurez les propriétés JNDI pour configurer les applications Web {{ site.data.keys.mf_server }} qui sont déployées sur le serveur d'applications.   
Définissez les entrées d'environnement JNDI en procédant de l'une des façons suivantes :

* Configurer les entrées d'environnement de serveur. Les étapes permettant de configurer les entrées d'environnement de serveur dépendent du serveur d'applications que vous utilisez :

    * **WebSphere Application Server :**
        1. Dans la console d'administration de WebSphere Application Server, accédez à **Applications → Types d'application → Applications d'entreprise WebSphere → application_name → Entrées d'environnement pour les modules Web**.
        2. Dans les zones Valeur, entrez les valeurs appropriées pour votre environnement de serveur.

        ![Entrées d'environnement JNDI dans WebSphere](jndi_was.jpg)
    * WebSphere Application Server Liberty :

      Dans **liberty\_install\_dir/usr/servers/serverName**, éditez le fichier **server.xml** et déclarez les propriétés JNDI comme suit : 

      ```xml
      <application id="app_context_root" name="app_context_root" location="app_war_name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="app_context_root/JNDI_property_name" value="JNDI_property_value" />
      ```

      La racine de contexte (dans l'exemple précédent : **app\_context\_root**) se connecte entre l'entrée JNDI et une application {{ site.data.keys.product_adj }} spécifique. Si plusieurs applications {{ site.data.keys.product_adj }} existent sur le même serveur, vous pouvez définir des entrées JNDI spécifiques pour chaque application en utilisant le préfixe du chemin de contexte. 

      > **Remarque :** Certaines propriétés sont définies globalement sur WebSphere Application Server Liberty, sans préfixer le nom de propriété avec la racine de contexte. Pour obtenir la liste de ces propriétés, voir [Entrées JNDI globales](../appserver/#global-jndi-entries).

      Pour toutes les autres propriétés JNDI, les noms doivent être préfixés avec la racine de contexte de l'application :

       * Pour le service Live Update, la racine de contexte doit être **/[adminContextRoot]config**. Par exemple, si la racine de contexte du service d'administration est **/mfpadmin**, la racine de contexte du service Live Update doit être **/mfpadminconfig**.
       * Pour le service push, vous devez définir la racine de contexte comme **/imfpush**. Sinon, les appareils client ne peuvent pas se connecter à ce service car la racine de contexte est codée en dur dans le logiciel SDK. 
       * Pour l'application Service d'administration de {{ site.data.keys.product_adj }}, le composant {{ site.data.keys.mf_console }} et l'environnement d'exécution de {{ site.data.keys.product_adj }}, vous pouvez définir la racine de contexte comme vous le souhaitez. Toutefois, par défaut, il s'agit de **/mfpadmin** pour le service d'administration de {{ site.data.keys.product_adj }}, **/mfpconsole** pour {{ site.data.keys.mf_console }} et **/mfp** pour l'environnement d'exécution de {{ site.data.keys.product_adj }}. 

      Exemple :

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat :

      Dans **tomcat\_install\_dir/conf**, éditez le fichier **server.xml** et déclarez les propriétés JNDI comme suit :

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="JNDI_property_name" override="false" type="java.lang.String" value="JNDI_property_value"/>
      </Context>
      ```

        * Le préfixe du chemin de contexte n'est pas nécessaire car les entrées JNDI sont définies au sein de l'élément `<Context>` d'une application. 
        * `override="false"` est obligatoire. 
        * L'attribut `type` est toujours `java.lang.String`, sauf spécification contraire pour la propriété. 

      Exemple :

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* Si vous effectuez une installation à l'aide de tâches Ant, vous pouvez également définir les valeurs des propriétés JNDI lors de l'installation. 

  Dans **mfp_install_dir/MobileFirstServer/configuration-samples**, éditez le fichier XML de configuration pour les tâches Ant et déclarez les valeurs pour les propriétés JNDI en utilisant l'élément property au sein des étiquettes suivantes : 

  * `<installmobilefirstadmin>` pour l'administration de {{ site.data.keys.mf_server }}, {{ site.data.keys.mf_console }} et les services Live Update. Pour plus d'informations, voir [Tâches Ant pour l'installation de {{ site.data.keys.mf_console }}, des artefacts de {{ site.data.keys.mf_server }}, de l'administration de {{ site.data.keys.mf_server }} et des services Live Update. ](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
  * `<installmobilefirstruntime>` pour les propriétés de configuration de l'environnement d'exécution de {{ site.data.keys.product_adj }}. Pour plus d'informations, voir  [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}. ](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)
  * `<installmobilefirstpush>` pour la configuration du service push. Pour plus d'informations, voir [Tâches Ant pour l'installation du service push de {{ site.data.keys.mf_server }}. ](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)

  Exemple :

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
Lorsque vous configurez le service d'administration de {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_console }} pour votre serveur d'applications, définissez les propriétés JNDI facultatives ou obligatoires, en particulier pour Java Management Extensions (JMX).

Les propriétés suivantes peuvent être définies sur l'application Web (mfp-admin-service.war) du service d'administration. 

#### Propriétés JNDI pour le service d'administration : JMX
{: #jndi-properties-for-administration-service-jmx }

| Propriété                 | Facultative ou obligatoire | Description | Restrictions |
|--------------------------|-----------------------|-------------|--------------|
| mfp.admin.jmx.connector  | Facultative	           | Type de connecteur JMX (Java Management Extensions).<br/>Les valeurs possibles sont `SOAP` et `RMI`. La valeur par défaut est SOAP. | WebSphere Application Server uniquement.  |
| mfp.admin.jmx.host       | Facultative	           | Nom d'hôte de la connexion REST JMX.  | Profil Liberty uniquement.  |
| mfp.admin.jmx.port	   | Facultative	           | Port de la connexion REST JMX.  | Profil Liberty uniquement.  |
| mfp.admin.jmx.user       | Obligatoire pour le profil Liberty et pour le parc de serveurs WebSphere Application Server, sinon, facultative | Nom d'utilisateur de la connexion REST JMX.  | Profil Liberty de WebSphere Application Server : Nom d'utilisateur de la connexion REST JMX.<br/><br/>Parc de serveurs WebSphere Application Server : Nom d'utilisateur de la connexion SOAP.<br/><br/>WebSphere Application Server Network Deployment : Nom d'utilisateur de l'administrateur WebSphere si l'hôte virtuel mappé à l'application d'administration de {{ site.data.keys.mf_server }} n'est pas l'hôte par défaut.<br/><br/>Collectivité Liberty : Nom d'utilisateur de l'administrateur contrôleur qui est défini dans l'élément `<administrator-role>` du fichier server.xml ou du contrôleur Liberty. |
| mfp.admin.jmx.pwd	| Obligatoire pour le profil Liberty et pour le parc de serveurs WebSphere Application Server, sinon, facultative | Mot de passe utilisateur pour la connexion REST JMX. | Profil Liberty de WebSphere Application Server : Mot de passe utilisateur de la connexion REST JMX.<br/><br/>Parc de serveurs WebSphere Application Server : Mot de passe utilisateur de la connexion SOAP.<br/><br/>WebSphere Application Server Network Deployment : Mot de passe utilisateur de l'administrateur WebSphere si l'hôte virtuel qui est mappé à l'application d'administration du serveur {{ site.data.keys.mf_server }} n'est pas l'hôte par défaut.<br/><br/>Collectivité Liberty : Mot de passe de l'administrateur contrôleur qui est défini dans l'élément `<administrator-role>` du fichier server.xml du contrôleur Liberty.  |
| mfp.admin.rmi.registryPort | Facultative | Port de registre RMI pour la connexion JMX via un pare-feu.  | Tomcat uniquement.  |
| mfp.admin.rmi.serverPort | Facultative | Port de serveur RMI pour la connexion JMX via un pare-feu.  | Tomcat uniquement.  |
| mfp.admin.jmx.dmgr.host | Obligatoire | Nom d'hôte de gestionnaire de déploiement.  | WebSphere Application Server Network Deployment uniquement. |
| mfp.admin.jmx.dmgr.port | Obligatoire | Port SOAP ou RMI de gestionnaire de déploiement.  | WebSphere Application Server Network Deployment uniquement. |

#### Propriétés JNDI pour le service d'administration : délai
{: #jndi-properties-for-administration-service-timeout }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.actions.prepareTimeout | Facultative | Délai en millisecondes pour transférer des données entre le service d'administration et l'environnement d'exécution lors d'une transaction de déploiement. Si l'environnement d'exécution ne peut pas être atteint dans ce délai, une erreur est générée et la transaction de déploiement s'arrête.<br/><br/>Valeur par défaut : 1800000 ms (30 min) |
| mfp.admin.actions.commitRejectTimeout | Facultative | Délai en millisecondes, lorsqu'un environnement d'exécution est contacté, pour valider ou rejeter une transaction de déploiement. Si l'environnement d'exécution ne peut pas être atteint dans ce délai, une erreur est générée et la transaction de déploiement s'arrête.<br/><br/>Valeur par défaut : 120000 ms (2 min) |
| mfp.admin.lockTimeoutInMillis | Facultative |Délai en millisecondes pour obtenir le verrou de transaction. Etant donné que les transactions de déploiement s'exécutent de manière séquentielle, elles utilisent un verrou. Par conséquent, une transaction doit attendre la fin d'une transaction précédente. Ce délai correspond à la période d'attente maximale d'une transaction.<br/><br/>Valeur par défaut : 1200000 ms (20 min) |
| mfp.admin.maxLockTimeInMillis | Facultative | Délai maximal pendant lequel un processus peut prendre le verrou de transaction. Etant donné que les transactions de déploiement s'exécutent de manière séquentielle, elles utilisent un verrou. Si le serveur d'applications échoue pendant la prise d'un verrou, il peut arriver dans de rares cas que le verrou ne soit pas libéré au démarrage suivant du serveur d'applications. Dans ce cas, le verrou est libéré automatiquement au terme du délai de verrouillage maximal de sorte que le serveur ne soit pas indéfiniment bloqué. Définissez un délai supérieur à une transaction normale.<br/><br/>Valeur par défaut : 1800000 (30 min) |

#### Propriétés JNDI pour le service d'administration : journalisation
{: #jndi-properties-for-administration-service-logging }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.logging.formatjson | Facultative | Affectez la valeur true à cette propriété pour activer le formatage automatique (espace vide supplémentaire) des objets JSON dans les réponses et les messages de journal. La définition de cette propriété est utile lorsque vous déboguez le serveur. Valeur par défaut : false. |
| mfp.admin.logging.tosystemerror | Facultative | Spécifie si tous les messages de journalisation sont également dirigés vers System.Error. La définition de cette propriété est utile lorsque vous déboguez le serveur.  |

#### Propriétés JNDI pour le service d'administration : proxys
{: #jndi-properties-for-administration-service-proxies }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.proxy.port | Facultative | Si le serveur d'administration de {{ site.data.keys.product_adj }} se trouve derrière un pare-feu ou un proxy inverse, cette propriété spécifie l'adresse de l'hôte. Définissez cette propriété de manière à permettre à un utilisateur en dehors du pare-feu d'atteindre le serveur d'administration de {{ site.data.keys.product_adj }}. Généralement, cette propriété correspond au port du proxy, par exemple, 443. Elle n'est nécessaire que si le protocole des URI externes et internes sont différents.  |
| mfp.admin.proxy.protocol | Facultative | Si le serveur d'administration de {{ site.data.keys.product_adj }} se trouve derrière un pare-feu ou un proxy inverse, cette propriété spécifie le protocole (HTTP ou HTTPS). Définissez cette propriété de manière à permettre à un utilisateur en dehors du pare-feu d'atteindre le serveur d'administration de {{ site.data.keys.product_adj }}. Généralement, le protocole du proxy est affecté à cette propriété. Par exemple, wl.net. Cette propriété n'est nécessaire que si le protocole des URI externes et internes sont différents.  |
| mfp.admin.proxy.scheme | Facultative | Cette propriété est juste un autre nom pour mfp.admin.proxy.protocol. |
| mfp.admin.proxy.host | Facultative | Si le serveur d'administration de {{ site.data.keys.product_adj }} se trouve derrière un pare-feu ou un proxy inverse, cette propriété spécifie l'adresse de l'hôte. Définissez cette propriété de manière à permettre à un utilisateur en dehors du pare-feu d'atteindre le serveur d'administration de {{ site.data.keys.product_adj }}. Généralement, cette propriété correspond à l'adresse du proxy.  |

#### Propriétés JNDI pour le service d'administration : topologies
{: #jndi-properties-for-administration-service-topologies }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.audit | Facultative. | Affectez la valeur false à cette propriété pour désactiver la fonction d'audit de {{ site.data.keys.mf_console }}. La valeur par défaut est true. |
| mfp.admin.environmentid | Facultative. | Identificateur d'environnement pour l'enregistrement des beans gérés. Utilisez cet identificateur lorsque différentes instances de {{ site.data.keys.mf_server }} sont installées sur le même serveur d'applications. L'identificateur détermine le service d'administration, la console et les environnements d'exécution qui appartiennent à la même installation. Le service d'administration ne gère que les environnements d'exécution possédant le même identificateur d'environnement.  |
| mfp.admin.serverid | Obligatoire pour les parcs de serveurs et la collectivité Liberty, sinon, facultative. | Parc de serveurs : identificateur de serveur. Doit être différent pour chaque serveur du parc de serveurs.<br/><br/> Collectivité Liberty : la valeur doit correspondre à un contrôleur.  |
| mfp.admin.hsts | Facultative. | Affectez la valeur true pour activer HTTP Strict Transport Security selon la norme RFC 6797. |
| mfp.topology.platform | Facultative | Type de serveur. Valeurs valides :{::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}Si vous ne définissez pas la valeur, l'application tente de deviner le type de serveur.  |
| mfp.topology.clustermode | Facultative | En plus du type de serveur, spécifiez ici la topologie du serveur. Valeurs valides :{::nomarkdown}<ul><li>Autonome</li><li>Cluster</li><li>Parc de serveurs</li></ul>{:/}La valeur par défaut est Autonome.  |
| mfp.admin.farm.heartbeat | Facultative | Cette propriété vous permet de définir en minutes le taux de pulsations utilisé dans les topologies de parc de serveurs. La valeur par défaut est 2 minutes.<br/><br/>Dans un parc de serveurs, tous les membres doivent utiliser le même taux de pulsations. Si vous définissez ou modifiez cette valeur JNDI sur un serveur du parc de serveurs, vous devez également définir la même valeur sur chacun des autres serveurs du parc de serveurs. Pour plus d'informations, voir [Cycle de vie d'un noeud de parc de serveurs](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.missed.heartbeats.timeout | Facultative | Cette propriété vous permet de définir le nombre de pulsations manquées d'un parc de serveurs avant que le parc de serveurs soit considéré comme en échec ou arrêté. La valeur par défaut est 2.<br/><br/>Dans un parc de serveurs, tous les membres doivent utiliser la même valeur de pulsation manquée. Si vous définissez ou modifiez cette valeur JNDI sur un serveur du parc de serveurs, vous devez également définir la même valeur sur chacun des autres serveurs du parc de serveurs. Pour plus d'informations, voir [Cycle de vie d'un noeud de parc de serveurs](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.reinitialize | Facultative | Valeur booléenne (true ou false) pour réenregistrer ou réinitialiser le parc de serveurs.  |
| mfp.swagger.ui.url | Facultative | Cette propriété définit l'URL de l'interface utilisateur swagger à afficher dans la console d'administration.  |

#### Propriétés JNDI pour le service d'administration : base de données relationnelle
{: #jndi-properties-for-administration-service-relational-database }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.db.jndi.name | Facultative | Nom JNDI de la base de données. Ce paramètre est le mécanisme normal permettant de spécifier la base de données. La valeur par défaut est **java:comp/env/jdbc/mfpAdminDS**. |
| mfp.admin.db.openjpa.ConnectionDriverName | Facultative/Obligatoire dans certaines conditions | Nom qualifié complet de la classe de pilote de connexion à la base de données. Obligatoire uniquement lorsque la source de données spécifiée par la propriété **mfp.admin.db.jndi.name** n'est pas définie dans la configuration du serveur d'applications.  |
| mfp.admin.db.openjpa.ConnectionURL | Facultative/Obligatoire dans certaines conditions | URL pour la connexion à la base de données. Obligatoire uniquement lorsque la source de données spécifiée par la propriété **mfp.admin.db.jndi.name** n'est pas définie dans la configuration du serveur d'applications.  |
| mfp.admin.db.openjpa.ConnectionUserName | Facultative/Obligatoire dans certaines conditions | Nom d'utilisateur de la connexion à la base de données. Obligatoire uniquement lorsque la source de données spécifiée par la propriété **mfp.admin.db.jndi.name** n'est pas définie dans la configuration du serveur d'applications.  |
| mfp.admin.db.openjpa.ConnectionPassword | Facultative/Obligatoire dans certaines conditions | Mot de passe de la connexion à la base de données. Obligatoire uniquement lorsque la source de données spécifiée par la propriété **mfp.admin.db.jndi.name** n'est pas définie dans la configuration du serveur d'applications.  |
| mfp.admin.db.openjpa.Log | Facultative | Cette propriété est transmise à OpenJPA et active la journalisation JPA. Pour plus d'informations, voir le document [Apache OpenJPA User's Guide](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html). |
| mfp.admin.db.type | Facultative | Cette propriété définit le type de base de données. La valeur par défaut est déduite de l'URL de connexion. |

#### Propriétés JNDI pour le service d'administration : octroi de licence
{: #jndi-properties-for-administration-service-licensing }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.license.key.server.host	| {::nomarkdown}<ul><li>Facultative pour les licences perpétuelles</li><li>Obligatoire pour les licences de jeton</li></ul>{:/} | Nom d'hôte de Rational License Key Server. |
| mfp.admin.license.key.server.port	| {::nomarkdown}<ul><li>Facultative pour les licences perpétuelles</li><li>Obligatoire pour les licences de jeton</li></ul>{:/} | Numéro de port de Rational License Key Server. |

#### Propriétés JNDI pour le service d'administration : configurations JNDI
{: #jndi-properties-for-administration-service-jndi-configurations }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.jndi.configuration | Facultative | Nom de la configuration JNDI si les propriétés JNDI (à l'exception de celle-ci) doivent être lues à partir d'un fichier de propriétés injecté dans le fichier WAR. Si vous ne définissez pas cette propriété, les propriétés JNDI ne sont pas lues à partir d'un fichier de propriétés.  |
| mfp.jndi.file | Facultative | Nom du fichier contenant la configuration JNDI si les propriétés JNDI (à l'exception de celle-ci) doivent être lues à partir d'un fichier installé dans le serveur Web. Si vous ne définissez pas cette propriété, les propriétés JNDI ne sont pas lues à partir d'un fichier de propriétés.  |

Le service d'administration utilise un service Live Update comme fonction auxiliaire pour stocker différentes configurations. Utilisez ces propriétés pour configurer la façon dont le service Live Update doit être atteint. 

#### Propriétés JNDI pour le service d'administration : service Live Update
{: #jndi-properties-for-administration-service-live-update-service }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.config.service.url | Facultative. URL du service Live Update. L'URL par défaut est déduite de l'URL du service d'administration en ajoutant config à la racine de contexte du service d'administration.  |
| mfp.config.service.user | Obligatoire | Nom d'utilisateur permettant d'accéder au service Live Update. Dans le cadre d'une topologie de parc de serveurs, le nom d'utilisateur doit être identique pour tous les membres du parc de serveurs. |
| mfp.config.service.password | Obligatoire | Mot de passe permettant d'accéder au service Live Update. Dans le cadre d'une topologie de parc de serveurs, le mot de passe doit être identique pour tous les membres du parc de serveurs. |
| mfp.config.service.schema | Facultative | Nom du schéma qui est utilisé par le service Live Update.  |

Le service d'administration utilise un service push comme fonction auxiliaire pour stocker différents paramètres de push. Utilisez ces propriétés pour configurer la façon dont le service push doit être atteint. Le service push étant protégé par le modèle de sécurité OAuth, vous devez définir différentes propriétés pour activer les clients confidentielles dans OAuth.

#### Propriétés JNDI pour le service d'administration : service push
{: #jndi-properties-for-administration-service-push-service }

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.push.url | Facultative | URL du service push. Si la propriété n'est pas spécifiée, le service push est considéré comme désactivé. Si la propriété n'est pas correctement définie, le service d'administration ne peut pas contacter le service push et l'administration des services push dans {{ site.data.keys.mf_console }} ne fonctionne pas.  |
| mfp.admin.authorization.server.url | Facultative | URL du serveur d'autorisations OAuth qui est utilisé par le service push. L'URL par défaut est déduite de l'URL du service d'administration en remplaçant la racine de contexte par la racine de contexte du premier environnement d'exécution installé. Si vous installez plusieurs environnements d'exécution, il est préférable de définir la propriété. Si la propriété n'est pas correctement définie, le service d'administration ne peut pas contacter le service push et l'administration des services push dans {{ site.data.keys.mf_console }} ne fonctionne pas.  |
| mfp.push.authorization.client.id | Facultative/Obligatoire dans certaines conditions | Identificateur du client confidentiel qui traite l'autorisation OAuth pour le service push. Obligatoire uniquement si la propriété **mfp.admin.push.url** est spécifiée.  |
| mfp.push.authorization.client.secret | Facultative/Obligatoire dans certaines conditions | Secret du client confidentiel qui traite l'autorisation OAuth pour le service push. Obligatoire uniquement si la propriété **mfp.admin.push.url** est spécifiée. |
| mfp.admin.authorization.client.id | Facultative/Obligatoire dans certaines conditions | Identificateur du client confidentiel qui traite l'autorisation OAuth pour le service d'administration. Obligatoire uniquement si la propriété **mfp.admin.push.url** est spécifiée.  |
| mfp.push.authorization.client.secret | Facultative/Obligatoire dans certaines conditions | Secret du client confidentiel qui traite l'autorisation OAuth pour le service d'administration. Obligatoire uniquement si la propriété **mfp.admin.push.url** est spécifiée.  |

### Propriétés JNDI pour {{ site.data.keys.mf_console }}
{: #jndi-properties-for-mobilefirst-operations-console }
Les propriétés suivantes peuvent être définies sur l'application Web (mfp-admin-ui.war) de {{ site.data.keys.mf_console }}.

| Propriété                 | Facultative ou obligatoire | Description  |
|--------------------------|-----------------------|--------------|
| mfp.admin.endpoint | Facultative | Permet à {{ site.data.keys.mf_console }} de localiser le service REST d'administration de {{ site.data.keys.mf_server }}. Spécifiez l'adresse externe et la racine de contexte de l'application Web **mfp-admin-service.war**. Dans un scénario avec un pare-feu ou un proxy inverse sécurisé, cet URI doit être l'URI externe et non l'URI interne au sein du réseau local. Exemple : https://wl.net:443/mfpadmin. |
| mfp.admin.global.logout | Facultative | Efface le cache d'authentification d'utilisateur WebSphere lors de la déconnexion de la console. Cette propriété est utile uniquement pour WebSphere Application Server V7. La valeur par défaut est false.  |
| mfp.admin.hsts | Facultative | Affectez la valeur true à cette propriété pour activer HTTP [Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security) selon la norme RFC 6797. Pour plus d'informations, voir la page W3C Strict Transport Security. La valeur par défaut est false.  |
| mfp.admin.ui.cors | Facultative | La valeur par défaut est true. Pour plus d'informations, voir la page [W3C Cross-Origin Resource Sharing](http://www.w3.org/TR/cors/). |
| mfp.admin.ui.cors.strictssl | Facultative | Affectez la valeur false pour autoriser des situations CORS au cours desquelles la console {{ site.data.keys.mf_console }} est sécurisée avec SSL (protocole HTTPS) tandis que le service d'administration de {{ site.data.keys.mf_server }} ne l'est pas, ou réciproquement. Cette propriété prend effet uniquement si la propriété **mfp.admin.ui.cors** est activée.  |

### Liste des propriétés JNDI pour le service Live Update de {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
Lorsque vous configurez le service Live Update de {{ site.data.keys.mf_server }} pour votre serveur d'applications, vous pouvez définir les propriétés JNDI ci-après. Le tableau répertorie les propriétés JNDI pour le service Live Update de base de données relationnelle IBM. 

| Propriété | Facultative ou obligatoire | Description |
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout | Facultative | Délai pour l'exécution d'une requête dans le système de gestion de base de données relationnelle, en secondes. La valeur zéro signifie que le délai d'attente est infini. Une valeur négative désigne la valeur par défaut (pas de remplacement).<br/><br/>Si aucune valeur n'est configurée, une valeur par défaut est utilisée. Pour plus d'informations, voir [setQueryTimeout](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int)). |

Pour savoir comment définir ces propriétés, voir [Configuration de propriétés JNDI pour les applications Web de {{ site.data.keys.mf_server }}](#setting-up-jndi-properties-for-mobilefirst-server-web-applications).

### Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}
{: #list-of-jndi-properties-for-mobilefirst-runtime }
Lorsque vous configurer l'environnement d'exécution de {{ site.data.keys.mf_server }} pour votre serveur d'applications, vous devez définir les propriétés JNDI facultatives ou obligatoires.   
Le tableau suivant répertorie les propriétés {{ site.data.keys.product_adj }} qui sont déjà disponibles en tant qu'entrées JNDI :

| Propriété | Description |
|----------|-------------|
| mfp.admin.jmx.dmgr.host | Obligatoire. Nom d'hôte du gestionnaire de déploiement. WebSphere Application Server Network Deployment uniquement. |
| mfp.admin.jmx.dmgr.port | Obligatoire. Port RMI ou SOAP du gestionnaire de déploiement. WebSphere Application Server Network Deployment uniquement. |
| mfp.admin.jmx.host | Liberty uniquement. Nom d'hôte de la connexion REST JMX. Pour la collectivité Liberty, utilisez le nom d'hôte du contrôleur.  |
| mfp.admin.jmx.port | Liberty uniquement. Numéro de port de la connexion REST JMX. Pour la collectivité Liberty, le port du connecteur REST doit être identique à la valeur de l'attribut httpsPort qui est déclarée dans l'élément `<httpEndpoint>`. Cet élément est déclaré dans le fichier server.xml du contrôleur Liberty.  |
| mfp.admin.jmx.user | Facultative. Parc de serveurs WebSphere Application Server : Nom d'utilisateur de la connexion SOAP.<br/><br/>Collectivité Liberty : Nom d'utilisateur de l'administrateur contrôleur qui est défini dans l'élément `<administrator-role>` du fichier server.xml du contrôleur Liberty.  |
| mfp.admin.jmx.pwd | Facultative. Parc de serveurs WebSphere Application Server : Mot de passe utilisateur de la connexion SOAP.<br/><br/>Collectivité Liberty : Mot de passe de l'administrateur contrôleur qui est définie dans l'élément `<administrator-role>` du fichier server.xml du contrôleur Liberty.  |
| mfp.admin.serverid | Obligatoire pour les parcs de serveurs et pour la collectivité Liberty, sinon, facultative.<br/><br/>Parc de serveurs : identificateur de serveur. Doit être différent pour chaque serveur du parc de serveurs.<br/><br/> Collectivité Liberty : identificateur de membre. L'identificateur doit être différent pour chaque membre de la collectivité. La valeur Contrôleur ne peut pas être utilisée car elle est réservée pour le contrôleur de collectivité.  |
| mfp.topology.platform | Facultative. Type de serveur. Les valeurs valides sont les suivantes :<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>Si vous ne définissez pas la valeur, l'application tente de deviner le type de serveur.  |
| mfp.topology.clustermode | Facultative. En plus du type de serveur, spécifiez ici la topologie du serveur. Valeurs valides :<ul><li>Autonome<li>Cluster</li><li>Parc de serveurs</li></ul>La valeur par défaut est Autonome.  |
| mfp.admin.jmx.replica | Facultative. Pour la collectivité Liberty uniquement.<br/><br/>Définissez cette propriété uniquement lorsque les composants d'administration qui gèrent cet environnement d'exécution sont déployés dans différents contrôleurs Liberty (répliques).<br/><br/>Liste des noeuds finaux des différentes répliques de contrôleur avec la syntaxe suivante : `replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` |
| mfp.analytics.console.url | Facultative. URL exposée par IBM {{ site.data.keys.mf_analytics }} qui établit un lien vers la console Analytics. Définissez cette propriété si vous souhaitez accéder à la console Analytics à partir de {{ site.data.keys.mf_console }}. Par exemple, `http://<hostname>:<port>/analytics/console` |
| mfp.analytics.password | Mot de passe qui est utilisé si le point d'entrée de données pour IBM {{ site.data.keys.mf_analytics }} est protégé par l'authentification de base.  |
| mfp.analytics.url | URL exposée par IBM {{ site.data.keys.mf_analytics }} qui reçoit les données d'analyse entrantes. Exemple : `http://<hostname>:<port>/analytics-service/rest` |
| mfp.analytics.username | Nom d'utilisateur qui est utilisé si le point d'entrée de données pour IBM {{ site.data.keys.mf_analytics }} est protégé par l'authentification de base. |
| mfp.device.decommissionProcessingInterval | Définit la fréquence (en secondes) à laquelle la tâche de déclassement est exécutée. Valeur par défaut : 86400 (un jour).  |
| mfp.device.decommission.when | Nombre de jours d'inactivité au terme desquels un appareil client est déclassé par la tâche de déclassement d'appareil. Valeur par défaut : 90 jours.  |
| mfp.device.archiveDecommissioned.when | Nombre de jours d'inactivité au terme desquels un appareil client qui a été déclassé est archivé.<br/><br/>Cette tâche écrit les appareils client qui ont été déclassés dans un fichier archive. Les appareils client archivés sont écrits dans un fichier dans le répertoire **home\devices_archive** de {{ site.data.keys.mf_server }}. Le nom du fichier contient l'horodatage de création du fichier archive. Valeur par défaut : 90 jours.  |
| mfp.licenseTracking.enabled | Valeur qui est utilisée pour activer ou désactiver le suivi des appareils dans {{ site.data.keys.product }}.<br/><br/>Pour améliorer les performances, vous pouvez désactiver le suivi des appareils lorsque {{ site.data.keys.product }} exécute uniquement des applications Business-to-Consumer (B2C). Lorsque le suivi des appareils est désactivé, les rapports de licence sont également désactivés et aucune mesure de licence n'est générée.<br/><br/>Valeurs possibles : true (valeur par défaut) et false.  |
| mfp.runtime.temp.folder | Définit le dossier de fichiers temporaires d'environnement d'exécution. L'emplacement de dossier temporaire par défaut du conteneur Web est utilisé lorsque cette propriété n'est pas définie.  |
| mfp.adapter.invocation.url | URL à utiliser pour appeler des procédures d'adaptateur à partir d'adaptateurs Java ou d'adaptateurs JavaScript qui sont appelés à l'aide du point final REST. Si cette propriété n'est pas définie, l'URL de la demande en cours d'exécution sera utilisée (il s'agit du comportement par défaut). Cette valeur doit contenir l'URL complète, y compris la racine de contexte.  |
| mfp.authorization.server | Mode de serveur d'autorisations. Peut être l'un des modes suivants : {::nomarkdown}<ul><li>Imbriqué : Utilisez le serveur d'autorisations de {{ site.data.keys.product_adj }}. </li><li>Externe : Utilisez un serveur d'autorisations externe. </li></ul>{:/}. Lorsque vous définissez cette valeur, vous devez également définir les propriétés **mfp.external.authorization.server.secret** et **mfp.external.authorization.server.introspection.url** pour votre serveur externe.  |
| mfp.external.authorization.server.secret | Secret du serveur d'autorisations externe. Cette propriété est obligatoire lorsque vous utilisez un serveur d'autorisations externe ; la propriété **mfp.authorization.server** a pour valeur Externe, sinon, elle est ignorée.  |
| mfp.external.authorization.server.introspection.url | URL du noeud final d'introspection du serveur d'autorisations externe. Cette propriété est obligatoire lorsque vous utilisez un serveur d'autorisations externe ; la propriété **mfp.authorization.server** a pour valeur **Externe**, sinon, elle est ignorée.  |
| ssl.websphere.config | Utilisée pour configurer le magasin de clés d'un adaptateur HTTP. Lorsque cette propriété a pour valeur false (valeur par défaut), cela indique à l'environnement d'exécution de {{ site.data.keys.product_adj }} qu'il doit utiliser le magasin de clés de {{ site.data.keys.product_adj }}. Lorsque cette propriété a pour valeur true, cela indique à l'environnement d'exécution de {{ site.data.keys.product_adj }} qu'il doit utiliser la configuration SSL WebSphere. Pour plus d'informations, voir [Configuration SSL WebSphere Application Server et adaptateurs HTTP](#websphere-application-server-ssl-configuration-and-http-adapters). |

### Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

| Propriété | Facultative ou obligatoire | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Facultative | Type de base de données. Valeurs possibles : DB, CLOUDANT. Valeur par défaut : DB |
| mfp.push.db.queue.connections | Facultative | Nombre d'unités d'exécution dans le pool d'unités d'exécution qui exécute l'opération de base de données. Valeur par défaut : 3 |
| mfp.push.db.cloudant.url | Facultative | URL de compte Cloudant. Lorsque cette propriété est définie, la base de données Cloudant est dirigée vers cette URL.  |
| mfp.push.db.cloudant.dbName | Facultative | Nom de la base de données dans le compte Cloudant. Ce nom doit commencer par un caractère en minuscule et ne peut contenir que des caractères en minuscules, des chiffres et les caractères _, $ et -. Valeur par défaut : mfp\_push\_db |
| mfp.push.db.cloudant.username | Facultative | Nom d'utilisateur du compte Cloudant, utilisé pour stocker la base de données. Lorsque cette propriété n'est pas définie, une base de données relationnelle est utilisée. |
| mfp.push.db.cloudant.password | Facultative | Mot de passe du compte Cloudant, utilisé pour stocker la base de données. Cette propriété est obligatoire lorsque la propriété mfp.db.cloudant.username est définie.  |
| mfp.push.db.cloudant.doc.version | Facultative | Version du document Cloudant.  |
| mfp.push.db.cloudant.socketTimeout | Facultative	| Délai d'attente relatif à la détection de la perte d'une connexion réseau pour Cloudant, exprimé en secondes. La valeur zéro signifie que le délai d'attente est infini. Une valeur négative désigne la valeur par défaut (pas de remplacement). Valeur par défaut. Voir [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Facultative	| Délai d'attente relatif à l'établissement d'une connexion réseau pour Cloudant, exprimé en secondes. La valeur zéro signifie que le délai d'attente est infini. Une valeur négative désigne la valeur par défaut (pas de remplacement). Valeur par défaut. Voir [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Facultative | Nombre maximal de connexions au connecteur Cloudant. Valeur par défaut. Voir [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Facultative | Valeur booléenne (true ou false) qui spécifie si la validation de chaîne de certificats SSL et la vérification de nom d'hôte sont activées pour les connexions HTTPS à la base de données Cloudant. Valeur par défaut : True  |
| mfp.push.db.cloudant.ssl.configuration | Facultative	| (Profil complet de WAS uniquement) Pour les connexions HTTPS à la base de données Cloudant : Nom d'une configuration SSL dans la configuration WebSphere Application Server, à utiliser lorsqu'aucune configuration n'est spécifiée pour l'hôte et le port. |
| mfp.push.db.cloudant.proxyHost | Facultative	| Hôte proxy du connecteur Cloudant. Par défaut : voir [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Facultative	| Port proxy du connecteur Cloudant. Par défaut : voir [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Facultative	| Plug-in d'extension de sécurité. |
| mfp.push.security.endpoint | Facultative	| URL de noeud final pour le serveur d'autorisations.  |
| mfp.push.security.user | Facultative	| Nom d'utilisateur permettant d'accéder au serveur d'autorisations.  |
| mfp.push.security.password | Facultative	| Mot de passe permettant d'accéder au serveur d'autorisations.  |
| mfp.push.services.ext.analytics | Facultative | Plug-in d'extension d'Analytics.  |
| mfp.push.analytics.endpoint | Facultative | URL de noeud final pour le serveur Analytics.  |
| mfp.push.analytics.user | Facultative | Nom d'utilisateur permettant d'accéder au serveur Analytics.  |
| mfp.push.analytics.password | Facultative | Mot de passe permettant d'accéder au serveur Analytics.  |
| mfp.push.analytics.events.notificationDispatch | Facultative	| Evénement d'analyse lorsque la notification est sur le point d'être déployée. Valeur par défaut : true |
| mfp.push.internalQueue.maxLength | Facultative | Longueur de la file d'attente qui contient les tâches de notification avant déploiement. Valeur par défaut : 200000  |
| mfp.push.gcm.proxy.enabled | Facultative	| Indique si Google GCM doit être accessible via un proxy. Valeur par défaut : false |
| mfp.push.gcm.proxy.protocol | Facultative | Peut être http ou https. |
| mfp.push.gcm.proxy.host | Facultative | Hôte proxy GCM. Une valeur négative désigne le port par défaut.  |
| mfp.push.gcm.proxy.port | Facultative | Port proxy GCM. Valeur par défaut : -1 |
| mfp.push.gcm.proxy.user | Facultative | Nom d'utilisateur de proxy, si le proxy requiert une authentification. Si cette propriété n'est pas définie, aucune authentification n'est effectuée. |
| mfp.push.gcm.proxy.password | Facultative | Mot de passe de proxy, si le proxy requiert une authentification.  |
| mfp.push.gcm.connections | Facultative | Nombre maximal de connexions Push GCM. Valeur par défaut : 10  |
| mfp.push.apns.proxy.enabled | Facultative | Indique si des APN GCM doivent être accessibles via un proxy. Valeur par défaut : false |
| mfp.push.apns.proxy.type | Facultative | Type de proxy APNS. |
| mfp.push.apns.proxy.host | Facultative | hôte proxy APNS. |
| mfp.push.apns.proxy.port | Facultative | Port proxy APNS. Valeur par défaut : -1 |
| mfp.push.apns.proxy.user | Facultative | Nom d'utilisateur de proxy, si le proxy requiert une authentification. Si cette propriété n'est pas définie, aucune authentification n'est effectuée. |
| mfp.push.apns.proxy.password | Facultative | Mot de passe de proxy, si le proxy requiert une authentification.  |
| mfp.push.apns.connections | Facultative | Nombre maximal de connexions Push APNS. Valeur par défaut : 3 |
| mfp.push.apns.connectionIdleTimeout | Facultative | Délai de connexion inactive APNS. Valeur par défaut : 0  |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448 
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## Configuration des sources de données
{: #configuring-data-sources }
Découvrez certains détails de configuration de source de données relatifs aux bases de données prise en charge. 

* [Gestion de la taille du journal de transactions DB2](#managing-the-db2-transaction-log-size)
* [Configuration de la reprise en ligne en continu HADR de DB2 pour les sources de données de {{ site.data.keys.mf_server }} et d'Application Center](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [Gestion des connexions périmées](#handling-stale-connections)
* [Données périmées après création ou suppression d'applications dans {{ site.data.keys.mf_console }}](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### Gestion de la taille du journal de transactions DB2
{: #managing-the-db2-transaction-log-size }
Lorsque vous déployez une application d'au moins 40 Mo avec IBM {{ site.data.keys.mf_console }}, vous êtes susceptible de recevoir un journal de transactions contenant des erreurs. 

La sortie système suivante est un exemple du code d'erreur contenu dans le journal de transactions :

```bash
DB2 SQL Error: SQLCODE=-964, SQLSTATE=57011
```

Le contenu de chaque application est stocké dans la base de données d'administration de {{ site.data.keys.product_adj }}. 

Le nombre de fichiers journaux actifs est défini par les paramètres de configuration de base de données **LOGPRIMARY** et **LOGSECOND** et leur taille est définie par le paramètre de configuration de base de données **LOGFILSIZ**. Une seule transaction ne peut pas utiliser un espace journal supérieur à la valeur définie par **LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096 Ko.

La commande `DB2 GET DATABASE CONFIGURATION` inclut des informations sur la taille de fichier journal, ainsi que le nombre de fichiers journaux principal et secondaire. 

En fonction de la plus grande taille de l'application {{ site.data.keys.product_adj }} déployée, vous devrez peut-être augmenter l'espace journal DB2. 

A l'aide de la commande `DB2 update db cfg`, augmentez la valeur du paramètre **LOGSECOND**. Aucun espace n'est alloué lorsque la base de données est activée. En revanche, de l'espace est alloué uniquement lorsque cela s'avère nécessaire. 

### Configuration de la reprise en ligne en continu HADR de DB2 pour les sources de données de {{ site.data.keys.mf_server }} et d'Application Center
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
Vous devez activer la reprise en ligne en continu avec le profil Liberty de WebSphere Application Server et WebSphere Application Server. Cette fonction vous permet de gérer une exception lorsqu'une base de données fait l'objet d'une reprise en ligne et est réacheminée par le pilote JDBC DB2. 

> **Remarque :** La reprise en ligne HADR de DB2 n'est pas prise en charge pour Apache Tomcat.

Par défaut avec la fonction HADR de DB2, lorsque le pilote JDBC DB2 effectue une redirection de client après avoir détecté qu'une base de données a fait l'objet d'une reprise en ligne lors de la première tentative de réutilisation d'une connexion existante, le pilote déclenche une exception **com.ibm.db2.jcc.am.ClientRerouteException** avec **ERRORCODE=-4498** et **SQLSTATE=08506**. WebSphere Application Server mappe cette exception à **com.ibm.websphere.ce.cm.StaleConnectionException** avant qu'elle ne soit reçue par l'application. 

Dans ce cas, l'application doit intercepter l'exception et relancer l'exécution de la transaction. Les environnements d'exécution de {{ site.data.keys.product_adj }} et d'Application Center ne gèrent pas l'exception, mais font appel à une fonction appelée reprise en ligne en continu. Pour activer cette fonction, vous devez affecter à la propriété JDBC **enableSeamlessFailover** la valeur "1".

#### Configuration du profil Liberty de WebSphere Application Server
{: #websphere-application-server-liberty-profile-configuration }
Vous devez éditer le fichier **server.xml** et ajouter la propriété **enableSeamlessFailover** à l'élément **properties.db2.jcc** des sources de données de {{ site.data.keys.product_adj }} et d'Application Center. Exemple :

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### Configuration de WebSphere Application Server 
{: #websphere-application-server-configuration }
A partir de la console d'administration de WebSphere Application Server pour chaque source de données de {{ site.data.keys.product_adj }} et d'Application Center :

1. Accédez à **Ressources → JDBC → Sources de données → Nom de source de données**.
2. Sélectionnez **Nouveau** et ajoutez la propriété personnalisée suivante ou mettez à jour les valeurs si les propriétés existent déjà : `enableSeamlessFailover : 1`
3. Cliquez sur **Appliquer**.
4. Enregistrez votre configuration.

Pour plus d'informations sur la procédure de configuration d'une connexion à une base de données DB2 prenant en charge la fonction HADR, voir [Configuration d'une connexion à une base de données DB2 prenant en charge la fonction HADR](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=en).

### Gestion des connexions périmées
{: #handling-stale-connections }
Configurez votre serveur d'applications de manière à éviter les problèmes de dépassement de délai de base de données. 

**StaleConnectionException** est une exception générée par le code de connexion de base de données de profils de serveur d'applications Java lorsqu'un pilote JDBC renvoie une erreur irrémédiable suite à une demande ou à une opération de connexion. L'exception **StaleConnectionException** est générée lorsque le fournisseur de base de données émet une exception pour indiquer qu'une connexion présente dans le pool de connexions n'est plus valide. Cette exception peut se produite pour un certain nombre de raisons. L'exception **StaleConnectionException** se produit le plus souvent lorsque des connexions sont extraites du pool de connexions de base de données et qu'il s'avère que la connexion a expiré ou a été supprimée car elle n'était plus utilisée depuis longtemps. 

Vous pouvez configurer votre serveur d'applications de manière à éviter cette exception. 

#### Configuration d'Apache Tomcat 
{: #apache-tomcat-configuration }
**MySQL**  
La base de données MySQL ferme une connexion après une période d'inactivité sur celle-ci. Ce délai est défini par la variable système appelée **wait_timeout**. La valeur par défaut de cette variable est 28000 secondes (8 heures).

Lorsqu'une application tente de se connecter à la base de données après que MySQL a fermé la connexion, l'exception suivante est générée :

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

Editez les fichiers **server.xml** et **context.xml** et, pour chaque élément `<Resource>`, ajoutez les propriétés suivantes :

* **testOnBorrow="true"**
* **validationQuery="select 1"**

Exemple :

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### Configuration du profil Liberty de WebSphere Application Server
{: #websphere-application-server-liberty-profile-configuration-1 }
Editez le fichier **server.xml** et, pour chaque élément `<dataSource>` (bases de données d'Application Center et d'environnement d'exécution), ajoutez l'élément `<connectionManager>` avec la propriété agedTimeout :

```xml
<connectionManager agedTimeout="timeout_value"/>
```

La valeur de délai dépend principalement du nombre de connexions ouvertes en parallèle, mais également du nombre minimal et du nombre maximal de connexions dans le pool. Par conséquent, vous devez régler les différents attributs **connectionManager** pour identifier les valeurs les plus appropriées. Pour plus d'informations sur l'élément **connectionManager**, voir [Liberty : Eléments de configuration dans le fichier **server.xml**](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html).

> **Remarque :** L'utilisation de MySQL conjointement avec le profil Liberty de WebSphere Application Server ou le profil complet de WebSphere Application Server n'est pas considérée comme une configuration prise en charge. Pour plus d'informations, voir [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Utilisez IBM DB2 ou une autre base de données prise en charge par WebSphere Application Server afin de bénéficier d'une configuration entièrement prise en charge par le support IBM.
### Données périmées après création ou suppression d'applications dans {{ site.data.keys.mf_console }}
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
Sur un serveur d'applications Tomcat 8, si vous utilisez une base de données MySQL, certains appels émis depuis {{ site.data.keys.mf_console }} vers des services renvoient une erreur 404. 

Sur un serveur d'applications Tomcat 8, si vous utilisez une base de données MySQL, lorsque vous vous servez de {{ site.data.keys.mf_console }} pour supprimer ou ajouter une application et que vous tentez d'actualiser la console deux fois, il se peut que des données périmées apparaissent. Par exemple, une application déjà supprimée peut apparaître dans la liste qui s'affiche pour les utilisateurs. 

Pour éviter ce problème, remplacez le niveau d'isolement par **READ_COMMITTED**, soit dans la source de données, soit dans le système de gestion de base de données. 

Pour connaître la signification de **READ_COMMITTED**, voir la [documentation MySQL](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc) sur le site[http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html).

* Pour remplacer le niveau d'isolement par **READ_COMMITTED** dans la source de données, modifiez le fichier de configuration Tomcat **server.xml** : dans la section **<Resource name="jdbc/mfpAdminDS" .../>**, ajoutez l'attribut **defaultTransactionIsolation="READ_COMMITTED"**. 
* Pour effectuer un remplacement global du niveau d'isolement par **READ_COMMITTED** dans le système de gestion de base de données, voir la [page relative à la syntaxe SET TRANSACTION](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html) dans la documentation MySQL sur le site [http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html).

#### Configuration du profil complet de WebSphere Application Server
{: #websphere-application-server-full-profile-configuration }
**DB2 ou Oracle**  
Pour réduire les problèmes de connexion périmée, vérifiez la configuration des pools de connexion sur chaque source de données dans la console d'administration de WebSphere Application Server. 

1. Connectez-vous à la console d'administration de WebSphere Application Server.
2. Sélectionnez **Ressources → Fournisseurs JDBC → database_jdbc_provider → Sources de données → votre_source_données → Propriétés de pool de connexions**.
3. Affectez au paramètre **Nombre minimal de connexions** la valeur 0.
4. Définissez une valeur d'**intervalle de régulation** inférieure à la valeur de **délai d'attente d'inactivité**. 
5. Vérifiez que la propriété **Règle de purge** a pour valeur **EntirePool (valeur par défaut)**.

Pour plus d'informations, voir [Paramètres de pool de connexions](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html).

**MySQL**  

1. Connectez-vous à la console d'administration de WebSphere Application Server.
2. Sélectionnez **Ressources → JDBC → Sources de données**.
3. Pour chaque source de données MySQL :
    * Cliquez sur la source de données.
    * Sélectionnez les propriétés **Pool de connexions** sous **Propriétés supplémentaires**.
    * Modifiez la valeur de la propriété **Délai d'expiration inutilisé**. La valeur doit être inférieure à celle de la variable système MySQL **wait_timeout** de sorte que les connexions soient purgées avant que MySQL ne les ferme. 
    * Cliquez sur **OK**.

> **Remarque :** L'utilisation de MySQL conjointement avec le profil Liberty de WebSphere Application Server ou le profil complet de WebSphere Application Server n'est pas considérée comme une configuration prise en charge. Pour plus d'informations, voir [WebSphere Application Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Utilisez IBM DB2 ou une autre base de données prise en charge par WebSphere Application Server afin de bénéficier d'une configuration entièrement prise en charge par le support IBM.
## Configuration des mécanismes de journalisation et de surveillance
{: #configuring-logging-and-monitoring-mechanisms }
{{ site.data.keys.product }} consigne des erreurs, des avertissements et des messages d'information dans un fichier journal. Le mécanisme de journalisation sous-jacent varie en fonction des serveurs d'applications. 

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
{{ site.data.keys.product }} (ou {{ site.data.keys.mf_server }} dans sa forme abrégée) utilise le package standard java.util.logging. Par défaut, toutes les informations journalisées par {{ site.data.keys.product_adj }} sont dirigées vers les fichiers journaux de serveur d'applications. Vous pouvez contrôler la journalisation de {{ site.data.keys.mf_server }} en utilisant les outils standard disponibles dans chaque serveur d'applications. Par exemple, si vous souhaitez activer la journalisation de trace dans WebSphere Application Server Liberty, ajoutez un élément de trace au fichier server.xml. Pour activer la journalisation de trace dans WebSphere Application Server, utilisez l'écran de journalisation dans la console et activez la trace pour les journaux {{ site.data.keys.product_adj }}. 

Les journaux {{ site.data.keys.product_adj }} commencent tous par **com.ibm.mfp**.  
Les journaux Application Center commencent par **com.ibm.puremeap**.

Pour plus d'informations sur les modèles de journalisation de chaque serveur d'applications, y compris l'emplacement des fichiers journaux, voir la documentation du serveur d'applications pertinent, comme indiqué dans le tableau ci-après. 

| Serveur d'applications | Emplacement de la documentation |
| -------------------|---------------------------|
| Apache Tomcat	     | [http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
| Profil complet de WebSphere Application Server version 8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
| Profil Liberty de WebSphere Application Server version 8.5 | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### Mappages de niveau de journalisation
{: #log-level-mappings }
{{ site.data.keys.mf_server }} utilise l'API **java.util.logging**. Les niveaux de journalisation sont mappés aux niveaux suivants :

* WL.Logger.debug : FINE
* WL.Logger.info : INFO
* WL.Logger.warn : WARNING
* WL.Logger.error : SEVERE

### Outils de surveillance des journaux
{: #log-monitoring-tools }
Pour Apache Tomcat, vous pouvez utiliser [IBM Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) ou d'autres outils de surveillance de fichiers journaux standard afin de surveiller les journaux et mettre en évidence les erreurs et les avertissements.

Pour WebSphere Application Server, utilisez les fonctions d'affichage de journal décrites dans IBM Knowledge Center. Les URL sont répertoriées dans le tableau contenu dans la section {{ site.data.keys.mf_server }} de cette page. 

### Connectivité de back end
{: #back-end-connectivity }
Pour activer la trace afin de surveiller la connectivité de back end, voir la documentation de votre plateforme de serveur d'applications spécifique dans le tableau contenu dans la section {{ site.data.keys.mf_server }} de cette page. Utilisez le package **com.ibm.mfp.server.js.adapter** et affectez la valeur **FINEST** au niveau de journalisation.

### Journal d'audit pour les opérations d'administration
{: #audit-log-for-administration-operations }
{{ site.data.keys.mf_console }} stocke un journal d'audit pour la connexion, la déconnexion et toutes les opérations d'administration, telles que le déploiement d'applications ou d'adaptateurs ou le verrouillage d'applications. Vous pouvez désactiver le journal d'audit en affectant à la propriété JNDI **mfp.admin.audit** la valeur false sur l'application Web du service d'administration de {{ site.data.keys.product_adj }} (**mfp-admin-service.war**).

Lorsque le journal d'audit est activé, vous pouvez le télécharger à partir de {{ site.data.keys.mf_console }} en cliquant sur le lien **Journal d'audit** dans le pied de page de la page. 

### Problèmes de connexion et d'authentification
{: #login-and-authentication-issues }
Pour diagnostiquer les problèmes de connexion et d'authentification, activez le package **com.ibm.mfp.server.security** pour la trace et affectez la valeur **FINEST** au niveau de journalisation.

## Configuration de plusieurs environnements d'exécution
{: #configuring-multiple-runtimes }
Vous pouvez configurer {{ site.data.keys.mf_server }} avec plusieurs environnements d'exécution en créant une différenciation visuelle entre les types d'application dans {{ site.data.keys.mf_console }}.

> **Remarque :** Plusieurs environnements d'exécution ne sont pas pris en charge dans une instance de serveur Mobile Foundation créée par le service Mobile Foundation Bluemix. Dans le service Bluemix, vous devez créer plusieurs instances de service à la place.

#### Accéder à
{: #jump-to-1 }
* [Configuration de plusieurs environnements d'exécution dans le profil Liberty de WebSphere](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [Enregistrement d'applications et déploiement d'adaptateurs sur différents environnements d'exécution](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [Exportation et importation de configurations d'environnement d'exécution](#exporting-and-importing-runtime-configurations)

### Configuration de plusieurs environnements d'exécution dans le profil Liberty de WebSphere
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. Ouvrez le fichier **server.xml** du serveur d'applications. Il se trouve généralement dans le dossier **[serveur-applications]/usr/servers/server-name/**. Par exemple, avec {{ site.data.keys.mf_dev_kit }}, le fichier se trouve dans **[dossier-installation]/mfp-server/usrs/servers/mfp/server.xml**.

2. Ajoutez un second élément `application` :

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. Ajoutez un second ensemble d'entrées JNDI :

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. Ajoutez un second élément `dataSource` :

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **Remarque :**
    >
    > * Assurez-vous que `dataSource` désigne un autre schéma de base de données. 
    > * Prenez soin de créer une [autre instance de base de données](../databases) pour le nouvel environnement d'exécution. 
    > * Dans l'environnement de développement, ajoutez `createDatabase="create"` dans l'élément enfant `properties.derby.embedded`. 

5. Redémarrez le serveur d’applications.

### Enregistrement d'applications et déploiement d'adaptateurs sur différents environnements d'exécution
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
Lorsqu'un serveur {{ site.data.keys.mf_server }} est configuré avec plusieurs environnements d'exécution, l'enregistrement d'applications et le déploiement d'adaptateurs sont légèrement différents. 

* [Enregistrement et déploiement à partir de {{ site.data.keys.mf_console }}](#registering-and-deploying-from-the-mobilefirst-operations-console)
* [Enregistrement et déploiement à partir de la ligne de commande](#registering-and-deploying-from-the-command-line)

#### Enregistrement et déploiement à partir de {{ site.data.keys.mf_console }}
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
Lorsque vous exécutez ces actions dans {{ site.data.keys.mf_console }}, vous devez désormais sélectionner l'environnement d'exécution sur lequel effectuer l'enregistrement ou le déploiement.

<img class="gifplayer" alt="Plusieurs environnements d'exécution dans {{ site.data.keys.mf_console }}" src="register-and-deploy-to-multiple-runtimes.png"/>

#### Enregistrement et déploiement à partir de la ligne de commande
{: #registering-and-deploying-from-the-command-line }
Lorsque vous exécutez ces actions à l'aide de l'outil de ligne de commande **mfpdev**, vous devez désormais ajouter le nom de l'environnement d'exécution sur lequel effectuer l'enregistrement ou le déploiement. 

Pour enregistrer une application : `mfpdev app register <server-name> <runtime-name>`.  

```bash
mfpdev app register local second-runtime
```

Pour déployer un adaptateur : `mfpdev adapter deploy <server-name> <runtime-name>`.  

```bash
mfpdev adapter deploy local second-runtime
```

* **local** est le nom de la définition de serveur par défaut dans l'{{ site.data.keys.mf_cli }}. Remplacez *local* par le nom de la définition de serveur sur lequel effectuer l'enregistrement ou le déploiement. 
* **runtime-name** est le nom de l'environnement d'exécution sur lequel effectuer l'enregistrement ou le déploiement. 

> Obtenir plus d'informations à l'aide des commandes d'aide de l'interface de ligne de commande :
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## Exportation et importation de configurations d'environnement d'exécution
{: #exporting-and-importing-runtime-configurations }
Vous pouvez exporter une configuration d'environnement d'exécution et l'importer sur un autre serveur {{ site.data.keys.mf_server }} à l'aide des API REST du **service d'administration** de {{ site.data.keys.mf_server }}. 

Par exemple, vous pouvez définir une configuration d'environnement d'exécution dans un environnement de développement, l'exporter, puis l'importer dans un environnement de test pour une configuration rapide, puis la configurer davantage en fonction des besoins spécifiques de l'environnement de test.

> Pour découvrir toutes les API REST disponibles, voir la documentation [API Reference](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html).
## Configuration du suivi des licences
{: #configuring-license-tracking }
Le suivi des licences est activé par défaut. Pour savoir comment configurer le suivi des licences, voir les rubriques ci-après. Pour plus d'informations sur le suivi des licences, voir [Suivi des licences](../../../administering-apps/license-tracking).

* [Configuration du suivi des licences pour un appareil client et un appareil adressable](#configuring-license-tracking-for-client-device-and-addressable-device)
* [Configuration de fichiers journaux IBM License Metric Tool](#configuring-ibm-license-metric-tool-log-files)

### Configuration du suivi des licences pour un appareil client et un appareil adressable
{: #configuring-license-tracking-for-client-device-and-addressable-device }
Le suivi des licences pour les appareils client et les appareils adressables est activé par défaut. Les rapports de licence sont disponibles dans {{ site.data.keys.mf_console }}. Vous  pouvez spécifier les propriétés JNDI suivantes pour modifier les paramètres par défaut du suivi des licences. 

> **Remarque :** Si vous disposez d'un contrat qui définit l'utilisation de l'octroi de licence de jeton, voir aussi [Installation et configuration pour l'octroi de licence de jeton](../token-licensing).
Vous  pouvez spécifier les propriétés JNDI suivantes pour modifier les paramètres par défaut du suivi des licences. 

**mfp.device.decommission.when**  
Nombre de jours d'inactivité au terme desquels un appareil est déclassé par la tâche de déclassement d'appareil. Les rapports de licence ne comptabilisent pas les appareils déclassés comme appareils actifs. La valeur par défaut de la propriété est 90 jours. Ne définissez pas une valeur inférieure à 30 jours si l'option de licence pour votre logiciel est Appareil client ou Appareil adressable, sinon, les rapports de licence ne seront peut-être pas suffisants pour prouver la conformité. 

**mfp.device.archiveDecommissioned.when**  
Valeur, exprimée en nombre de jours, qui indique à quel moment les appareils déclassés sont placés dans un fichier archive lors de l'exécution de la tâche de déclassement. Les appareils archivés sont écrits dans un fichier dans le répertoire **home\devices_archive** d'IBM {{ site.data.keys.mf_server }}. Le nom du fichier contient l'horodatage de création du fichier archive. La valeur par défaut est 90 jours.

**mfp.device.decommissionProcessingInterval**  
Définit la fréquence (en secondes) à laquelle la tâche de déclassement est exécutée. Valeur par défaut : 86400 (un jour). La tâche de déclassement effectue les actions suivantes :

* Elle déclasse les appareils actifs, en fonction du paramètre **mfp.device.decommission.when**.
* Le cas échéant, elle archive les anciens appareils déclassés, en fonction du paramètre **mfp.device.archiveDecommissioned.when**.
* Elle génère le rapport de suivi des licences.

**mfp.licenseTracking.enabled**  
Valeur qui est utilisée pour activer ou désactiver le suivi des licences dans {{ site.data.keys.product }}. Par défaut, le suivi des licences est activé. Pour améliorer les performances, vous pouvez désactiver cet indicateur lorsque l'option Appareil client ou Appareil adressable n'est pas utilisée pour la mise sous licence de {{ site.data.keys.product }}. Lorsque le suivi des appareils est désactivé, les rapports de licence sont également désactivés et aucune mesure de licence n'est générée. Dans ce cas, seuls les enregistrements IBM License Metric Tool pour le nombre d'applications sont générés. 

Pour plus d'informations sur la spécification de propriétés JNDI, voir [Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}](#list-of-jndi-properties-for-mobilefirst-runtime).

### Configuration de fichiers journaux IBM License Metric Tool
{: #configuring-ibm-license-metric-tool-log-files }
{{ site.data.keys.product }} génère des fichiers SLMT (IBM Software License Metric Tag). Les versions d'IBM License
Metric Tool qui prennent en charge IBM Software License Metric Tag peuvent générer des rapports de consommation de licences. Lisez cette section pour comprendre comment configurer l'emplacement et la taille maximale des fichiers générés. 

Par défaut, les fichiers IBM Software License Metric Tag figurent dans les répertoires suivants :

* Sous Windows : **%ProgramFiles%\ibm\common\slm**
* Sous les systèmes d'exploitation UNIX et de type UNIX : **/var/ibm/common/slm**

Si les répertoires ne sont pas accessibles en écriture, les fichiers sont créés dans le répertoire de journaux du serveur d'applications qui exécute l'environnement d'exécution de {{ site.data.keys.product_adj }}. 

Vous pouvez configurer l'emplacement et la gestion de ces fichiers à l'aide des propriétés suivantes :

* **license.metric.logger.output.dir** : Emplacement des fichiers IBM Software License Metric Tag.
* **license.metric.logger.file.size** : Taille maximale d'un fichier SLMT avant l'exécution d'une rotation. La taille par défaut est 1 Mo.
* **license.metric.logger.file.number** : Nombre maximal de fichiers archive SLMT à conserver dans les rotations. Le nombre par défaut est 10.

Pour modifier les valeurs par défaut, vous devez créer un fichier de propriétés Java, au format **key=value**, et indiquer le chemin d'accès à ce fichier de propriétés à l'aide de la propriété JVM **license_metric_logger_configuration**. 

Pour plus d'informations sur les rapports IBM License Metric Tool, voir [Intégration à IBM License Metric Tool](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool).

## Configuration SSL WebSphere Application Server et adaptateurs HTTP
{: #websphere-application-server-ssl-configuration-and-http-adapters }
En définissant une propriété, vous pouvez permettre aux adaptateurs HTTP de profiter de la configuration SSL WebSphere. 

Par défaut, les adaptateurs HTTP n'utilisent pas SSL WebSphere en concaténant le magasin de clés JRE (Java Runtime Environment) et le magasin de clés {{ site.data.keys.mf_server }}, lequel est décrit dans [Configuration du magasin de clés {{ site.data.keys.mf_server }}](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore). Voir aussi [Configuration de SSL entre des adaptateurs et des serveurs de back end à l'aide de certificats auto-signés](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

Pour que des adaptateurs HTTP utilisent la configuration SSL WebSphere, affectez la valeur true à la propriété JNDI **ssl.websphere.config**. Cette propriété a les effets suivants sur l'ordre de priorité :

1. Les adaptateurs qui s'exécutent sur WebSphere utilisent le magasin de clés WebSphere et non le magasin de clés {{ site.data.keys.mf_server }}. 
2. Si la propriété **ssl.websphere.alias** est définie, l'adaptateur utilise la configuration SSL qui est associée à l'alias, comme indiqué dans cette propriété. 
