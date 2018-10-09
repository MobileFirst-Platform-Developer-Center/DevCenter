---
layout: tutorial
title: Exécution d'IBM Installation Manager pour la mise à jour
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Exécution d'Installation Manager en mode graphique
{: #graphical-mode}

* Exécutez Installation Manager à partir du compte utilisateur employé lors de l'installation initiale.
  Pour appliquer une mise à jour, Installation Manager doit s'exécuter avec la même liste de fichiers de registre que celle de l'installation initiale. La liste des logiciels installés et les options utilisées lors de l'installation sont stockées dans ces fichiers de registre. Si vous exécutez Installation Manager en mode administrateur, les fichiers de registre sont installés au niveau du système (dans le dossier `/var` sur UNIX ou Linux et dans le dossier `c:\ProgramData` sous Windows). L'emplacement est indépendant de l'utilisateur qui exécute Installation Manager (bien que les privilèges de superutilisateur soient requis sur Linux ou UNIX). Toutefois, si vous exécutez Installation Manager en mode utilisateur unique, les fichiers de registre sont stockés par défaut dans le répertoire de base de l'utilisateur.

* Sélectionnez **Fichier > Préférences**.
  Si vous planifiez de mettre à jour un programme IBM MobileFirst Platform Foundation V8.0.0 existant (application d'un groupe de correctifs ou d'un correctif provisoire), le référentiel de produit n'est pas requis.

* Cliquez sur**OK** pour fermer le panneau **Préférences**.

* Cliquez sur **Mettre à jour** puis sélectionnez le package à mettre à jour. Installation Manager affiche une liste de packages. Par défaut, le package à mettre à jour est nommé IBM MobileFirst Platform Server.

* Acceptez les dispositions du contrat de licence puis cliquez sur **Suivant**.

* Dans le panneau **Merci**, cliquez sur **Suivant**. Un récapitulatif s'affiche.

* Cliquez sur **Mettre à jour** pour démarrer la procédure de mise à jour.

## Exécution d'Installation Manager en mode de ligne de commande
{: #cli-mode}

1. Téléchargez les fichiers d'installation en mode silencieux [ici](http://public.dhe.ibm.com/software/products/en/MobileFirstPlatform/docs/v800/Silent_Install_Sample_Files.zip).

2. Décompressez le fichier et sélectionnez le fichier `8.0/upgrade-initially-mfpserver.xml`.
  - Si vous avez initialement installé la version 6.0.0, 6.1.0 ou 6.2.0 du produit, sélectionnez à la place le fichier `8.0/upgrade-initially-worklightv6.xml`.
  - Si vous avez initialement installé la version 5.x du produit, sélectionnez à la place ce fichier `8.0/upgrade-initially-worklightv5.xml`.
  Le fichier contient l'identité de profil du produit. La valeur par défaut de cette identité change au fil des différentes éditions du produit. Dans la version 5.x, il s'agit de Worklight. Dans les versions 6.0.0, 6.1.0 et 6.2.0, il s'agit d'IBM Worklight. Dans les versions 6.3.0, 7.0.0, 7.1.0 et 8.0.0, il s'agit d'IBM MobileFirst Platform Server.

3. Effectuez une copie du fichier sélectionné.

4. Ouvrez, avec un éditeur de texte ou un éditeur XML, le fichier XML copié. Modifiez les éléments suivants :

   a. L'élément de référentiel qui définit la liste de référentiels. Etant donné que vous planifiez de mettre à jour un programme IBM MobileFirst Platform Foundation V8.0.0 existant (application d'un groupe de correctifs ou d'un correctif provisoire), le référentiel de produit n'est pas requis.

   b. **Facultatif :** Mettez à jour les mots de passe pour la base de données et le serveur d'applications.
      Si Application Center est installé lors de l'installation initiale avec Installation Manager et que les mots de passe de la base de données ou du serveur d'applications ont été modifiés, vous pouvez changer la valeur dans le fichier XML. En utilisant ces mots de passe, vous vous assurez que la base de données dispose de la version de schéma appropriée. Vous pouvez également effectuer une mise à niveau si la version est antérieure à la version 8.0.0. Ils permettent également d'exécuter **wsadmin** pour une installation d'Application Center sur le profil complet de WebSphere Application Server. Supprimez la mise en commentaire des lignes appropriées dans le fichier XML :
      ```
      <!-- Optional: If the password of the WAS administrator has changed-->
      <!-- <data key='user.appserver.was.admin.password2' value='password'/> -->

      <!-- Optional: If the password used to access the DB2 database for
           Application Center has changed, you may specify it here-->
      <!-- <data key='user.database.db2.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the MySQL database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.mysql.appcenter.password' value='password'/> -->

      <!-- Optional: If the password used to access the Oracle database for
           Application Center has changed, you may specify it here -->
      <!-- <data key='user.database.oracle.appcenter.password' value='password'/> -->
      ```

    c. Si vous n'avez pas auparavant choisi d'activer l'octroi de licence de jeton (fonction disponible dans un correctif provisoire du 15 septembre 2015 ou ultérieurement), annulez la mise en commentaire de la ligne `<data key=’user.licensed.by.tokens’ value=’false’/>`. Affectez la valeur **true** si vous disposez d'un contrat d'utilisation de l'octroi de licence de jeton avec Rational License Key Server. Sinon, définissez la valeur **false**.
      Si vous activez l'octroi de licence de jeton, vérifiez que Rational License Key Server est configuré et que le nombre de jetons pouvant être obtenu est suffisant pour exécuter MobileFirst Server et les applications qu'il sert. Sinon l'application d'administration de MobileFirst Server et l'environnement d'exécution ne peuvent pas s'exécuter.
      > **Restriction :** La décision d'activer ou non l'octroi de licence de jeton est irréversible. Si vous exécutez une mise à niveau avec la valeur **true** puis ultérieurement une autre mise à niveau avec la valeur **false**, la deuxième mise à niveau échoue.

    d. Consultez l'identité du profil et l'emplacement d'installation. Ils doivent correspondre aux éléments installés :
      * `<profile id='IBM MobileFirst Platform Server' installLocation='/opt/IBM/MobileFirst_Platform_Server'>`
      * `<offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>`
      * Pour consulter le profil d'identité et les répertoires d'installation connus d'Installation Manager, vous pouvez entrer la commande :
    ```bash
      chemin_installation_manager/eclipse/tools/imcl listInstallationDirectories -verbose
    ```

    e. Mettez à jour l'attribut de version et définissez-le en fonction de la version du correctif provisoire.
       Par exemple, si vous installez le correctif provisoire (8.0.0.0-MFPF-IF20171006-1725), remplacez

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20160610_0940' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      par

      ```xml
      <offering id='com.ibm.mobilefirst.foundation.server' version='8.0.0.20171006-1725' profile='IBM MobileFirst Platform Server' features='main.feature' installFixes='none'/>
      ```

      Installation Manager n'utilise pas uniquement les référentiels répertoriés dans le fichier d'installation mais également les référentiels installés dans ses préférences. La spécification de l'attribut de version dans l'élément d'offre est facultative. Toutefois, en l'indiquant, vous vous assurez que le correctif provisoire défini est la version que vous souhaitez installer. Cette spécification remplace les autres référentiels par des correctifs provisoires répertoriés dans les préférences Installation Manager.

5. Ouvrez une session avec le compte utilisateur de l'installation initiale.
    Pour appliquer une mise à jour, Installation Manager doit s'exécuter avec la même liste de fichiers de registre que celle utilisée lors de l'installation initiale. La liste des logiciels installés et les options utilisées lors de l'installation sont stockées dans ces fichiers de registre. Si vous exécutez Installation Manager en mode administrateur, les fichiers de registre sont installés au niveau du système (dans le dossier `/var` sur UNIX ou Linux et dans le dossier `c:\ProgramData` sous Windows). L'emplacement est indépendant de l'utilisateur qui exécute Installation Manager (bien que les privilèges de superutilisateur soient requis sur Linux ou UNIX). Toutefois, si vous exécutez Installation Manager en mode utilisateur unique, les fichiers de registre sont stockés par défaut dans le répertoire de base de l'utilisateur.

6. Exécutez la commande
  ```bash
   chemin_installation/eclipse/tools/imcl input <fichierRéponses> -log /tmp/installwl.log -acceptLicense
  ```
   où,
   * <fichierRéponses> correspond au fichier XML modifié à l'étape 4.
   * *-log /tmp/installwl.log* est facultatif. Cette option définit un fichier journal pour la sortie d'Installation Manager.
   * *-acceptLicense* est obligatoire. Cette option indique que vous acceptez les dispositions du contrat de licence d'IBM MobileFirst Platform Foundation V8.0.0. Si vous ne l'indiquez pas, Installation Manager ne peut pas effectuer la mise à jour.

## Etapes suivantes
{: #next-steps }

[Mise à jour du serveur d'applications](../appserver-update)
