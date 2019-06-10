---
layout: tutorial
title: Installation de MobileFirst Server sur un serveur d'applications
breadcrumb_title: Installing MobileFirst Server to an application server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez installer les composants à l'aide de tâches Ant, avec l'outil de configuration de serveur ou manuellement. Prenez connaissance des éléments prérequis et des détails relatifs au processus d'installation avant d'installer les composants sur le serveur d'applications.

Avant d'installer les composants sur le serveur d'applications, vérifiez que les bases de données et les tables pour les composants sont préparées et prêtes à l'emploi. Pour plus d'informations, voir [Configuration des bases de données](../databases).

La topologie de serveur dans laquelle installer les composants doit également être définie. Voir [Topologies et flots réseau](../topologies).

#### Aller à
{: #jump-to }

* [Prérequis pour le serveur d'applications](#application-server-prerequisites)
* [Installation avec l'outil de configuration de serveur](#installing-with-the-server-configuration-tool)
* [Installation à l'aide de tâches Ant](#installing-with-ant-tasks)
* [Installation manuelle des composants {{ site.data.keys.mf_server }}](#installing-the-mobilefirst-server-components-manually)
* [Installation d'un parc de serveurs](#installing-a-server-farm)

## Prérequis pour le serveur d'applications
{: #application-server-prerequisites }
Selon le serveur d'applications que vous avez choisi, reportez-vous à l'une des rubriques suivantes pour prendre connaissance des prérequis que vous devez remplir avant d'installer les composants {{ site.data.keys.mf_server }} :

* [Prérequis pour Apache Tomcat](#apache-tomcat-prerequisites)
* [Prérequis pour WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites)
* [Prérequis pour WebSphere Application Server et WebSphere Application Server Network Deployment](#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites)

### Prérequis pour Apache Tomcat
{: #apache-tomcat-prerequisites }
Les exigences de {{ site.data.keys.mf_server }} relatives à la configuration d'Apache Tomcat sont détaillées dans les rubriques ci-dessous.  
Assurez-vous de remplir les critères suivants :

* Utilisez une version prise en charge d'Apache Tomcat. Voir [Configuration système requise](../../../../product-overview/requirements).
* Apache Tomcat doit être exécuté avec JRE 7.0 ou version ultérieure.
* La configuration de JMX doit être activée pour permettre la communication entre le service d'administration et le composant d'exécution. La communication utilise RMI comme décrit dans **Configuration de la connexion JMX pour Apache Tomcat** ci-après.

<div class="panel-group accordion" id="tomcat-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#tomcat-prereq" href="#collapse-jmx-connection" aria-expanded="true" aria-controls="collapse-jmx-connection"><b>Cliquez ici pour afficher des instructions de configuration de la connexion JMX pour Apache Tomcat</b></a>
            </h4>
        </div>

        <div id="collapse-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="jmx-connection">
            <div class="panel-body">
                <p>Vous devez configurer une connexion JMX sécurisée pour le serveur d'applications Apache Tomcat.</p>
                <p>L'outil de configuration de serveur et les tâches Ant peuvent configurer une connexion JMX sécurisée par défaut qui inclut la définition d'un port distant JMX et de propriétés d'authentification. Ils modifient <b>rép_install_tomcat/bin/setenv.bat</b> et <b>rép_install_tomcat/bin/setenv.sh</b> pour ajouter les options suivantes dans <b>CATALINA_OPTS</b> :</p>
{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}

                <p><b>Remarque :</b> 8686 est la valeur de port par défaut. Elle peut être changée si le port n'est pas disponible sur l'ordinateur.</p>

                <ul>
                    <li>Le fichier <b>setenv.bat</b> est utilisé si vous démarrez Apache Tomcat avec <b>rép_install_tomcat/bin/startup.bat</b> ou <b>rép_install_tomcat/bin/catalina.bat.</b></li>
                    <li>Le fichier <b>setenv.sh</b> est utilisé si vous démarrez Apache Tomcat avec <b>rép_install_tomcat/bin/startup.sh</b> ou <b>rép_install_tomcat/bin/catalina.sh.</b></li>
                </ul>

                <p>Il se peut que ce fichier ne soit pas utilisé si vous démarrez Apache Tomcat avec une autre commande. Si vous avez installé le programme d'installation du service Windows Apache Tomcat, le programme de lancement des services n'utilise pas <b>setenv.bat</b>.</p>

                <blockquote><b>Important :</b> cette configuration n'est pas sécurisée par défaut. Pour la sécuriser, vous devez effectuer manuellement les étapes 2 et 3 de la procédure ci-dessous.</blockquote>

                <p>Configuration manuelle d'Apache Tomcat :</p>

                <ol>
                    <li>Pour une configuration simple, ajoutez les options suivantes dans <b>CATALINA_OPTS</b> :

{% highlight xml %}
-Djava.rmi.server.hostname=localhost
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
{% endhighlight %}
                    </li>
                    <li>Pour savoir comment activer l'authentification, voir la documentation utilisateur d'Apache Tomcat <a href="https://tomcat.apache.org/tomcat-7.0-doc/config/http.html#SSL_Support">SSL Support - BIO and NIO</a> et <a href="http://tomcat.apache.org/tomcat-7.0-doc/ssl-howto.html">SSL Configuration HOW-TO</a>.</li>
                    <li>Pour une configuration JMX avec SSL activé, ajoutez les options suivantes :
{% highlight xml %}
-Dcom.sun.management.jmxremote=true
-Dcom.sun.management.jmxremote.port=8686
-Dcom.sun.management.jmxremote.ssl=true
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=localhost  
-Djavax.net.ssl.trustStore=<emplacement_magasin_clés_confiance>
-Djavax.net.ssl.trustStorePassword=<mot_de_passe_magasin_clés_confiance>
-Djavax.net.ssl.trustStoreType=<type_magasin_clés_confiance>
-Djavax.net.ssl.keyStore=<emplacement_magasin_clés>
-Djavax.net.ssl.keyStorePassword=<mot_de_passe_magasin_clés>
-Djavax.net.ssl.keyStoreType=<type_magasin_clés>
{% endhighlight %}

                    <b>Remarque :</b> le port 8686 peut être changé.</li>
                    <li>
                        <p>Si l'instance Tomcat s'exécute derrière un pare-feu, le programme d'écoute de cycle de vie distant JMX doit être configuré. Voir la documentation d'Apache Tomcat <a href="http://tomcat.apache.org/tomcat-7.0-doc/config/listeners.html#JMX_Remote_Lifecycle_Listener_-_org.apache.catalina.mbeans.JmxRemoteLifecycleListener">JMX Remote Lifecycle Listener</a>.</p><p>Vous devez également ajouter les propriétés d'environnement suivantes dans la section Context de l'application de service d'administration dans le fichier <b>server.xml</b>, conformément à l'exemple suivant :</p>

{% highlight xml %}
<Context docBase="mfpadmin" path="/mfpadmin ">
    <Environment name="mfp.admin.rmi.registryPort" value="portRegistre" type="java.lang.String" override="false"/>
    <Environment name="mfp.admin.rmi.serverPort" value="portServeur" type="java.lang.String" override="false"/>
</Context>
{% endhighlight %}

                        Dans l'exemple précédent :
                        <ul>
                            <li>portRegistre doit avoir la même valeur que l'attribut <b>rmiRegistryPortPlatform</b> du programme d'écoute de cycle de vie distant JMX.</li>
                            <li>portServeur doit avoir la même valeur que l'attribut <b>rmiServerPortPlatform</b> du programme d'écoute de cycle de vie distant JMX.</li>
                        </ul>
                    </li>
                    <li>Si vous avez installé Apache Tomcat avec le programme d'installation des services Windows Apache Tomcat au lieu d'ajouter les options dans <b>CATALINA_OPTS</b>, exécutez <b>rép_install_tomcat/bin/Tomcat7w.exe</b> et ajoutez les options dans l'onglet <b>Java</b> de la fenêtre des propriétés.

                    <img alt="Propriétés Apache Tomcat 7" src="Tomcat_Win_Service_Installer_properties.jpg"/></li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Prérequis pour WebSphere Application Server Liberty
{: #websphere-application-server-liberty-prerequisites }
Les exigences d'{{ site.data.keys.product_full }} relatives à la configuration du serveur Liberty sont détaillées dans les rubriques ci-dessous.  

Assurez-vous de remplir les critères suivants :

* Utilisez une version prise en charge de Liberty. Voir [Configuration système requise](../../../../product-overview/requirements).
* Liberty doit être exécuté avec JRE 7.0 ou version ultérieure. JRE 6.0 n'est pas pris en charge.
* Certaines versions de Liberty prennent en charge les fonctions de Java EE 6 et les fonctions de Java EE 7. Par exemple, la fonction Liberty jdbc-4.0 provient de Java EE 6, alors que la fonction Liberty jdbc-4.1 provient de Java EE 7. {{ site.data.keys.mf_server }} version 8.0.0 peut être installé avec des fonctions Java EE 6 ou Java EE 7. Toutefois, si vous voulez exécuter une version plus ancienne de {{ site.data.keys.mf_server }} sur le même serveur Liberty, vous devez utiliser les fonctions Java EE 6. La version 7.1.0 et les versions précédentes de {{ site.data.keys.mf_server }} ne prennent pas en charge les fonctions Java EE 7.
* JMX doit être configuré comme décrit dans **Configuration de la connexion JMX pour le profil Liberty de WebSphere Application Server** ci-après.
* Pour une installation dans un environnement de production, il est recommandé de démarrer le serveur Liberty en tant que service sur les systèmes Windows, Linux ou UNIX pour que les composants {{ site.data.keys.mf_server }} soient démarrés automatiquement lorsque l'ordinateur démarre
et le processus qui exécute le serveur Liberty ne s'arrête pas lorsque l'utilisateur qui a démarré le processus se déconnecte.
* {{ site.data.keys.mf_server }} version 8.0.0 ne peut pas être déployé sur un serveur Liberty contenant les composants {{ site.data.keys.mf_server }} déployés pour des versions précédentes.
* Pour l'installation dans un environnement de collectivité Liberty, le contrôleur de collectivité Liberty et les membres de cluster de collectivité Liberty doivent être configurés comme décrit dans [Configuration d'une collectivité Liberty](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/tagt_wlp_configure_collective.html?view=kc).

<div class="panel-group accordion" id="websphere-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-websphere-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-jmx-connection"><b>Cliquez ici pour afficher des instructions de configuration de la connexion JMX pour le profil Liberty de WebSphere Application Server</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiert la configuration de la connexion JMX sécurisée.</p>

                <ul>
                    <li>L'outil de configuration de serveur et les tâches Ant peuvent configurer une connexion JMX sécurisée par défaut qui inclut la génération d'un certificat SSL autosigné dont la période de validité est de 365 jours. Cette configuration ne peut pas être utilisée en production.</li>
                    <li>Afin de configurer la connexion JMX sécurisée pour un usage en production, suivez les instructions décrites dans <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/twlp_admin_restconnector.html?cp=SSD28V_8.5.5&view=embed">Configuration d'une connexion JMX sécurisée dans le profil Liberty</a>.</li>
                    <li>La fonction rest-connector est disponible pour WebSphere Application Server, Liberty Core et d'autres éditions de Liberty ; toutefois, il est possible de conditionner un serveur Liberty avec un sous-ensemble seulement des fonctions disponibles. Pour vérifier que la fonction rest-connector est disponible dans votre installation de Liberty, entrez la commande suivante : {% highlight bash %}                    
rép_install_liberty/bin/productInfo featureInfo
{% endhighlight %}
                    <b>Remarque :</b> vérifiez que la sortie de cette commande répertorie restConnector-1.0.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Prérequis pour WebSphere Application Server et WebSphere Application Server Network Deployment
{: #websphere-application-server-and-websphere-application-server-network-deployment-prerequisites }
Les exigences de {{ site.data.keys.mf_server }} relatives à la configuration de WebSphere Application Server et WebSphere Application Server Network Deployment sont détaillées dans les rubriques ci-dessous.  
Assurez-vous de remplir les critères suivants :

* Utilisez une version prise en charge de WebSphere Application Server. Voir [Configuration système requise](../../../../product-overview/requirements).
* Le serveur d'applications doit être exécuté avec JRE 7.0. Par défaut, WebSphere Application Server utilise le logiciel SDK Java 6.0. Pour utiliser le logiciel SDK Java 7.0, voir [Basculement vers le SDK Java 7.0 dans WebSphere Application Server](https://www.ibm.com/support/knowledgecenter/SSWLGF_8.5.5/com.ibm.sr.doc/twsr_java17.html).
* La sécurité administrative doit être activée. {{ site.data.keys.mf_console }}, le service d'administration de {{ site.data.keys.mf_server }} et le service de configuration de {{ site.data.keys.mf_server }} sont protégés par des rôles de sécurité. Pour plus d'informations, voir [Activation de la sécurité](https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/tsec_csec2.html?cp=SSEQTP_8.5.5%2F1-8-2-31-0-2&lang=en).
* La configuration de JMX doit être activée pour permettre la communication entre le service d'administration et le composant d'exécution. La communication utilise SOAP. RMI peut être utilisé pour WebSphere Application Server Network Deployment. Pour plus d'informations, voir **Configuration de la connexion JMX pour WebSphere Application Server et WebSphere Application Server Network Deployment** ci-après.

<div class="panel-group accordion" id="websphere-nd-prereq" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="websphere-nd-jmx-connection">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-nd-prereq" href="#collapse-websphere-nd-jmx-connection" aria-expanded="true" aria-controls="collapse-websphere-nd-jmx-connection"><b>Cliquez ici pour afficher des instructions de configuration de la connexion JMX pour WebSphere Application Server et WebSphere Application Server Network Deployment</b></a>
            </h4>
        </div>

        <div id="collapse-websphere-nd-jmx-connection" class="panel-collapse collapse" role="tabpanel" aria-labelledby="websphere-nd-jmx-connection">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiert la configuration de la connexion JMX sécurisée.</p>

                <ul>
                    <li>{{ site.data.keys.mf_server }} requiert l'accès au port SOAP ou au port RMI pour effectuer des opérations JMX. Par défaut, le port SOAP est actif sur un serveur WebSphere Application Server. {{ site.data.keys.mf_server }} utilise le port SOAP par défaut. Si le port SOAP et le port RMI sont désactivés, {{ site.data.keys.mf_server }} ne s'exécute pas.</li>
                    <li>RMI n'est pris en charge que par WebSphere Application Server Network Deployment. Il n'est pas pris en charge par les profils autonomes ni par les parcs de serveurs WebSphere Application Server.</li>
                    <li>Vous devez activer la sécurité administrative et la sécurité des applications.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

### Prérequis pour le système de fichiers
{: #file-system-prerequisites }
Pour installer {{ site.data.keys.mf_server }} sur un serveur d'applications, les outils d'installation de {{ site.data.keys.product_adj }} doivent être exécutés par un utilisateur disposant de droits spécifiques dans le système de fichiers.  
Les outils d'installation sont :

* IBM Installation Manager
* L'outil de configuration de serveur
* Les tâches Ant permettant de déployer {{ site.data.keys.mf_server }}

Pour le profil Liberty de WebSphere Application Server, vous devez disposer des droits permettant d'effectuer les actions suivantes :

* Lire les fichiers dans le répertoire d'installation de Liberty.
* Créer des fichiers dans le répertoire de configuration du serveur Liberty, en général usr/servers/nom-serveur, pour créer des copies de sauvegarde et modifier server.xml et jvm.options.
* Créer des fichiers et des répertoires dans le répertoire de ressources partagées, en général usr/shared.
* Créer des fichiers dans le répertoire des applications du serveur Liberty, en général usr/servers/nom-serveur/apps.

Pour le profil complet de WebSphere Application Server et WebSphere Application Server Network Deployment, vous devez disposer des droits permettant d'effectuer les actions suivantes :

* Lire les fichiers dans le répertoire d'installation de WebSphere Application Server.
* Lire le fichier de configuration du profil complet de WebSphere Application Server ou du profil Deployment Manager sélectionné.
* Exécuter la commande wsadmin.
* Créer des fichiers dans le répertoire de configuration des profils. Les outils d'installation placent les ressources telles que les bibliothèques partagées ou les pilotes JDBC dans ce répertoire.

Pour Apache Tomcat, vous devez disposer des droits permettant d'effectuer les actions suivantes :

* Lire le répertoire de configuration.
* Créer des fichiers de sauvegarde et modifier les fichiers dans le répertoire de configuration, comme server.xml et tomcat-users.xml.
* Créer des fichiers de sauvegarde et modifier les fichiers dans le répertoire bin, comme setenv.bat.
* Créer des fichiers dans le répertoire lib.
* Créer des fichiers dans le répertoire webapps.

Pour tous ces serveurs d'applications, l'utilisateur qui exécute le serveur d'applications doit pouvoir lire les fichiers qui ont été créés par l'utilisateur qui a exécuté les outils d'installation de {{ site.data.keys.product_adj }}.

## Installation avec l'outil de configuration de serveur
{: #installing-with-the-server-configuration-tool }
Utilisez l'outil de configuration de serveur pour installer les composants {{ site.data.keys.mf_server }} sur votre serveur d'applications.

L'outil de configuration de serveur peut configurer la base de données et installer les composants sur un serveur d'applications. Il a été conçu pour un seul utilisateur. Les fichiers de configuration sont stockés sur le disque. Vous pouvez changer le répertoire dans lequel ils sont stockés avec le menu **File   Preferences**. Les fichiers ne doivent être utilisés que par une instance de l'outil de configuration de serveur à la fois. L'outil ne gère pas l'accès simultané à un même fichier. Si plusieurs instances de l'outil accèdent à un même fichier, vous risquez de perdre les données. Pour plus d'informations sur la façon dont l'outil crée et configure les bases de données, voir [Création des tables de base de données avec l'outil de configuration de serveur](../databases/#create-the-database-tables-with-the-server-configuration-tool). Si les bases de données existent, l'outil peut les détecter en testant leur présence ainsi que le contenu de certaines tables de test, mais ne les modifie pas.

* [Systèmes d'exploitation pris en charge](#supported-operating-systems)
* [Topologies prises en charge](#supported-topologies)
* [Exécution de l'outil de configuration de serveur](#running-the-server-configuration-tool)
* [Application d'un groupe de correctifs avec l'outil de configuration de serveur](#applying-a-fix-pack-by-using-the-server-configuration-tool)

### Systèmes d'exploitation pris en charge
{: #supported-operating-systems }
Vous pouvez utiliser l'outil de configuration de serveur si vous utilisez les systèmes d'exploitation suivants :

* Windows x86 ou x86-64
* macOS x86-64
* Linux x86 ou Linux x86-64

L'outil n'est pas disponible sur les autres systèmes d'exploitation. Vous devez utiliser des tâches Ant pour installer les composants {{ site.data.keys.mf_server }} comme décrit dans [Installation à l'aide de tâches Ant](#installing-with-ant-tasks).

### Topologies prises en charge
{: #supported-topologies }
L'outil de configuration de serveur installe les composants {{ site.data.keys.mf_server }} avec les topologies suivantes :

* Tous les composants ({{ site.data.keys.mf_console }}, le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }}) se trouvent sur le même serveur d'applications. Toutefois, sur WebSphere Application Server Network Deployment, lorsque vous procédez à l'installation dans un cluster, vous pouvez spécifier un cluster différent pour les services d'administration et Live Update et pour l'environnement d'exécution. Dans la collectivité Liberty, {{ site.data.keys.mf_console }}, le service d'administration et le service Live Update sont installés sur un contrôleur de collectivité, et l'environnement d'exécution sur un membre de collectivité.
* Si le service push de {{ site.data.keys.mf_server }} est installé, il l'est sur le même serveur. Toutefois, sur WebSphere Application Server Network Deployment, lorsque vous procédez à l'installation dans un cluster, vous pouvez spécifier un cluster différent pour le service push. Dans la collectivité Liberty, le service push est installé sur un membre Liberty qui peut être celui sur lequel est installé l'environnement d'exécution.
* Tous les composants utilisent le même système de base de données et le même utilisateur. Pour DB2, tous les composants utilisent également le même schéma.
* L'outil de configuration de serveur installe les composants pour un serveur unique, sauf pour la collectivité Liberty et WebSphere Application Server Network Deployment dans le cas d'un déploiement asymétrique. Pour une installation sur plusieurs serveurs, vous devez configurer un parc de serveurs après l'exécution de l'outil. La configuration du parc de serveurs n'est pas requise sur WebSphere Application Server Network Deployment.

Pour les autres topologies ou les autres paramètres de base de données, vous pouvez installer les composants à l'aide de tâches Ant ou manuellement.

### Exécution de l'outil de configuration de serveur
{: #running-the-server-configuration-tool }
Avant d'exécuter l'outil de configuration de serveur, vérifiez que les exigences suivantes sont satisfaites :

* Les bases de données et les tables pour les composants sont préparées et prêtes à l'emploi. Voir [Configuration des bases de données](../databases).
* La topologie de serveur dans laquelle installer les composants a été choisie. Voir [Topologies et flots réseau](../topologies).
* Le serveur d'applications est configuré. Voir [Prérequis pour le serveur d'applications](#application-server-prerequisites).
* L'utilisateur qui exécute l'outil dispose des droits spécifiques dans le système de fichiers. Voir [Prérequis pour le système de fichiers](#file-system-prerequisites).

<div class="panel-group accordion" id="running-the-configuration-tool" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="configuration-tool">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#running-the-configuration-tool" href="#collapse-configuration-tool" aria-expanded="true" aria-controls="collapse-configuration-tool"><b>Cliquez ici pour afficher des instructions d'exécution de l'outil de configuration</b></a>
            </h4>
        </div>

        <div id="collapse-configuration-tool" class="panel-collapse collapse" role="tabpanel" aria-labelledby="configuration-tool">
            <div class="panel-body">
                <ol>
                    <li>Démarrez l'outil de configuration de serveur.
                        <ul>
                            <li>Sous Linux, cliquez sur les raccourcis d'application <b>Applications → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>Sous Windows, cliquez sur <b>Démarrer → Programmes → IBM MobileFirst Platform Server → Server Configuration Tool</b>.</li>
                            <li>Sous macOS, ouvrez une console d'interpréteur de commandes. Accédez à <b>rép_install_serveur_mfp/shortcuts</b> et entrez <b>./configuration-tool.sh</b>.</li>
                            <li>Le répertoire <b>rép_install_serveur_mfp</b> est l'emplacement auquel vous avez installé {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>Sélectionnez <b>File → New Configuration</b> pour créer une configuration {{ site.data.keys.mf_server }}.
                        <ul>
                            <li>Dans le panneau <b>Configuration Details</b>, entrez la racine de contexte du service d'administration et du composant d'exécution. Il est recommandé d'entrer un ID d'environnement. Ce dernier est utilisé dans les cas d'utilisation avancés, par exemple lorsque <a href="../topologies/#multiple-instances-of-mobilefirst-server-on-the-same-server-or-websphere-application-server-cell">plusieurs installations de {{ site.data.keys.mf_server }} sont effectuées sur un même serveur d'applications ou dans une même cellule WebSphere Application Server</a>.</li>
                            <li>Dans le panneau <b>Console Settings</b>, indiquez si {{ site.data.keys.mf_console }} doit être installé ou non. Si la console n'est pas installée, vous devez utiliser des outils de ligne de commande (<b>mfpdev</b> ou <b>mfpadm</b>) ou l'API REST pour interagir avec le service d'administration de {{ site.data.keys.mf_server }}.</li>
                            <li>Dans le panneau <b>Database Selection</b>, sélectionnez le système de gestion de base de données que vous prévoyez d'utiliser. Tous les composants utilisent le même type de base de données et la même instance de base de données. Pour plus d'informations sur les sous-fenêtres de base de données, voir <a href="../databases/#create-the-database-tables-with-the-server-configuration-tool">Création des tables de base de données avec l'outil de configuration de serveur</a>.</li>
                            <li>Dans le panneau <b>Application Server Selection</b>, sélectionnez le type de serveur d'applications sur lequel déployer {{ site.data.keys.mf_server }}.</li>
                        </ul>
                    </li>
                    <li>Dans le panneau <b>Application Server Settings</b>, choisissez le serveur d'applications et effectuez les opérations suivantes :
                        <ul>
                            <li>Pour une installation sur un serveur WebSphere Application Server Liberty :
                                <ul>
                                    <li>Entrez le répertoire d'installation de Liberty et le nom du serveur sur lequel installer {{ site.data.keys.mf_server }}.</li>
                                    <li>Vous pouvez créer un utilisateur par défaut pour la connexion à la console. Cet utilisateur est créé dans le registre de base Liberty. Pour une installation de production, il est recommandé de désélectionner l'option <b>Create a default user</b> et de configurer l'accès utilisateur après l'installation. For more information, see <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuring user authentication for {{ site.data.keys.mf_server }} administration</a>.</li>
                                    <li>Sélectionnez le type de déploiement : <b>Standalone deployment</b> (par défaut), <b>Server farm deployment</b> ou <b>Liberty collective deployment</b>.</li>
                                </ul>

                                Si l'option Liberty collective deployment est sélectionnée, procédez comme suit :
                                <ul>
                                    <li>Spécifiez le serveur de collectivité Liberty :
                                        <ul>
                                            <li>Sur lequel le service d'administration, {{ site.data.keys.mf_console }} et le service Live Update sont installés. Le serveur doit être un contrôleur de collectivité Liberty.</li>
                                            <li>Sur lequel l'environnement d'exécution est installé. Le serveur doit être un membre de collectivité Liberty.</li>
                                            <li>Sur lequel le service push est installé. Le serveur doit être un membre de collectivité Liberty.</li>
                                        </ul>
                                    </li>
                                    <li>Entrez l'ID de serveur du membre. Cet identificateur doit être différent pour chaque membre dans la collectivité.</li>
                                    <li>Entrez le nom de cluster des membres de collectivité.</li>
                                    <li>Entrez le nom d'hôte du contrôleur et le numéro de port HTTPS. Les valeurs doivent être identiques à celles qui sont définies dans l'élément <code>variable</code> du fichier <b>server.xml</b> du contrôleur de collectivité Liberty.</li>
                                    <li>Entrez le nom d'utilisateur et le mot de passe de l'administrateur du contrôleur.</li>
                                </ul>
                            </li>
                            <li>Pour une installation sur un serveur WebSphere Application Server ou WebSphere Application Server Network Deployment :
                                <ul>
                                    <li>Entrez le répertoire d'installation de WebSphere Application Server.</li>
                                    <li>Sélectionnez le profil WebSphere Application Server dans lequel installer {{ site.data.keys.mf_server }}. Si vous procédez à l'installation sur un serveur WebSphere Application Server Network Deployment, sélectionnez le profil du gestionnaire de déploiement. Dans le profil du gestionnaire de déploiement, vous pouvez sélectionner une portée (<b>Server</b> ou <b>Cluster</b>). Si vous sélectionnez <b>Cluster</b>, vous devez spécifier le cluster :
                                        <ul>
                                            <li>Dans lequel l'environnement d'exécution est installé.</li>
                                            <li>Dans lequel le service d'administration, {{ site.data.keys.mf_console }} et le service Live Update sont installés.</li>
                                            <li>Dans lequel le service push est installé.</li>
                                        </ul>
                                    </li>
                                    <li>Entrez l'ID de connexion et le mot de passe d'un administrateur. Cet utilisateur doit posséder un rôle d'administrateur.</li>
                                    <li>Si vous sélectionnez l'option <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b>, l'utilisateur qui installe {{ site.data.keys.mf_server }} est mappé au rôle de sécurité d'administration de la console et peut se connecter à la console avec des privilèges d'administrateur. Il est également mappé au rôle de sécurité du service Live Update. Le nom d'utilisateur et le mot de passe sont définis sous forme de propriétés JNDI (<b>mfp.config.service.user</b> et <b>mfp.config.service.password</b>) du service d'administration.</li>
                                    <li>Si vous ne sélectionnez pas l'option <b>Declare the WebSphere Administrator as an administrator user in {{ site.data.keys.mf_console }}</b>, vous devez effectuer les tâches suivantes avant d'utiliser {{ site.data.keys.mf_server }} :
                                        <ul>
                                            <li>Activez la communication entre le service d'administration et le service Live Update en :
                                                <ul>
                                                    <li>Mappant un utilisateur au rôle de sécurité <b>configadmin</b> du service Live Update.</li>
                                                    <li>Ajoutant l'ID de connexion et le mot de passe de cet utilisateur dans les propriétés JNDI (<b>mfp.config.service.user</b> et <b>mfp.config.service.password</b>) du service d'administration.</li>
                                                    <li>Mappant un ou plusieurs utilisateurs aux rôles de sécurité du service d'administration et de {{ site.data.keys.mf_console }}. Voir <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuration de l'authentification d'utilisateur pour l'administration de {{ site.data.keys.mf_server }}</a>.</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>Pour une installation sur Apache Tomcat :
                                <ul>
                                    <li>Entrez le répertoire d'installation d'Apache Tomcat.</li>
                                    <li>Entrez le port utilisé pour la communication JMX avec RMI. Par défaut, la valeur est 8686. L'outil de configuration de serveur modifie le fichier <b>rép_install_tomcat/bin/setenv.bat</b> ou <b>rép_install_tomcat/bin/setenv.sh</b> pour ouvrir ce port. Si vous voulez ouvrir le port manuellement ou si <b>setenv.bat</b> ou <b>setenv.sh</b> comporte déjà un code qui ouvre le port, n'utilisez pas l'outil. A la place, procédez à l'installation à l'aide de tâches Ant. Une option permettant d'ouvrir le port RMI manuellement est proposée dans le cadre d'une installation à l'aide de tâches Ant.</li>
                                    <li>Créez un utilisateur par défaut pour la connexion à la console. Cet utilisateur est également créé dans le fichier de configuration <b>tomcat-users.xml</b>. Pour une installation de production, il est recommandé de désélectionner l'option Create a default user et de configurer l'accès utilisateur après l'installation. For more information, see <a href="../../server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration">Configuring user authentication for {{ site.data.keys.mf_server }} administration</a>.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Dans le panneau <b>Push Service Settings</b>, sélectionnez l'option <b>Install the Push service</b> si vous voulez que le service push soit installé sur le serveur d'applications. La racine de contexte est <b>imfpush</b>. Pour activer la communication entre le service push et le service d'administration, vous devez définir les paramètres suivants :
                        <ul>
                            <li>Entrez l'adresse URL du service push et l'adresse URL de l'environnement d'exécution. L'adresse URL peut être calculée automatiquement si vous procédez à l'installation sur un serveur Liberty, Apache Tomcat ou WebSphere Application Server autonome. Elle utilise l'adresse URL du composant (l'environnement d'exécution ou le service push) sur le serveur local. Si vous procédez à l'installation sur un serveur WebSphere Application Server Network Deployment ou si les communications passent par un proxy Web ou un équilibreur de charge, vous devez la saisir manuellement.</li>
                            <li>Entrez les ID des clients confidentiels et les valeurs confidentielles correspondantes pour la communication OAuth entre les services. Si vous n'indiquez pas ces données, l'outil génère des valeurs par défaut et des mots de passe aléatoires.</li>
                        </ul>
                    </li>
                    <li>Dans le panneau <b>Analytics Settings</b>, sélectionnez l'option <b>Enable the connection to the Analytics server</b> si {{ site.data.keys.mf_analytics }} est installé. Entrez les paramètres de connexion suivants :
                        <ul>
                            <li>L'adresse URL de la console Analytics.</li>
                            <li>L'adresse URL du serveur Analytics (le service de données Analytics).</li>
                            <li>L'ID de connexion et le mot de passe de l'utilisateur autorisé à publier des données sur le serveur Analytics.</li>
                        </ul>

                        L'outil configure l'environnement d'exécution et le service push pour l'envoi de données au serveur Analytics.
                    </li>
                    <li>Cliquez sur <b>Deploy</b> pour effectuer l'installation.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

Une fois l'installation terminée, redémarrez le serveur d'applications dans le cas d'Apache Tomcat ou du profil Liberty.

Si Apache Tomcat est démarré en tant que service, il se peut que le fichier setenv.bat ou setenv.sh contenant l'instruction d'ouverture de RMI ne soit pas lu. En conséquence, il se peut que {{ site.data.keys.mf_server }} ne fonctionne pas correctement. Pour définir les variables requises, voir [Configuration de la connexion JMX pour Apache Tomcat](#apache-tomcat-prerequisites).

Sur un serveur WebSphere Application Server Network Deployment, les applications sont installées mais ne sont pas démarrées. Vous devez les démarrer manuellement. Vous pouvez effectuer cette opération depuis la console d'administration WebSphere Application Server.

Conservez le fichier de configuration dans l'outil de configuration de serveur. Vous pourrez être amené à le réutiliser afin d'installer les correctifs temporaires. Pour appliquer un correctif temporaire, sélectionnez **Configurations > Replace the deployed WAR files**.

### Application d'un groupe de correctifs avec l'outil de configuration de serveur
{: #applying-a-fix-pack-by-using-the-server-configuration-tool }
Si {{ site.data.keys.mf_server }} a été installé avec l'outil de configuration et que le fichier de configuration a été conservé, vous pouvez appliquer un groupe de correctifs ou un correctif temporaire en réutilisant le fichier de configuration.

1. Démarrez l'outil de configuration de serveur.
    * Sous Linux, cliquez sur les raccourcis d'application **Applications → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Sous Windows, cliquez sur **Démarrer → Programmes → IBM MobileFirst Platform Server → Server Configuration Tool**.
    * Sous macOS, ouvrez une console d'interpréteur de commandes. Accédez à **rép\_install\_mfp\_serveur/shortcuts** et entrez **./configuration-tool.sh**.
    * Le répertoire **rép\_install\_mfp\_serveur** est l'emplacement auquel vous avez installé {{ site.data.keys.mf_server }}.

2. Cliquez sur **Configurations → Replace the deployed WAR files** et sélectionnez une configuration existante pour appliquer le groupe de correctifs ou un correctif temporaire.

## Installation à l'aide de tâches Ant
{: #installing-with-ant-tasks }
Utilisez des tâches Ant pour installer les composants {{ site.data.keys.mf_server }} sur votre serveur d'applications.

Les exemples de fichier de configuration pour l'installation de {{ site.data.keys.mf_server }} se trouvent dans le répertoire **rép\_install\_mfp/MobileFirstServer/configuration-samples**.

Vous pouvez aussi créer une configuration avec l'outil de configuration de serveur et exporter les fichiers Ant en sélectionnant **File → Export Configuration as Ant Files...**. Les exemples de fichier Ant présentent les mêmes limitations que l'outil de configuration de serveur :

* Tous les composants ({{ site.data.keys.mf_console }}, service d'administration de {{ site.data.keys.mf_server }}, service Live Update de {{ site.data.keys.mf_server }}, artefacts de {{ site.data.keys.mf_server }} et environnement d'exécution de {{ site.data.keys.product_adj }}) se trouvent sur le même serveur d'applications. Toutefois, sur WebSphere Application Server Network Deployment, lorsque vous procédez à l'installation dans un cluster, vous pouvez spécifier un cluster différent pour les services d'administration et Live Update et pour l'environnement d'exécution.
* Si le service push de {{ site.data.keys.mf_server }} est installé, il l'est sur le même serveur. Toutefois, sur WebSphere Application Server Network Deployment, lorsque vous procédez à l'installation dans un cluster, vous pouvez spécifier un cluster différent pour le service push.
* Tous les composants utilisent le même système de base de données et le même utilisateur. Pour DB2, tous les composants utilisent également le même schéma.
* L'outil de configuration de serveur installe les composants sur un seul serveur. Pour une installation sur plusieurs serveurs, vous devez configurer un parc de serveurs après l'exécution de l'outil. La configuration d'un parc de serveurs n'est pas prise en charge sur WebSphere Application Server Network Deployment.

Vous pouvez configurer les services de {{ site.data.keys.mf_server }} pour qu'ils s'exécutent dans un parc de serveurs à l'aide de tâches Ant. Pour inclure votre serveur dans un parc de serveurs, vous devez spécifier des attributs spécifiques qui configurent votre serveur d'applications en conséquence. Pour plus d'informations sur la configuration d'un parc de serveurs à l'aide de tâches Ant, voir [Installation d'un parc de serveurs à l'aide de tâches Ant](#installing-a-server-farm-with-ant-tasks).

Pour les autres topologies présentées dans [Topologies et flots réseau](../topologies), vous pouvez modifier les exemples de fichier Ant.

Les références aux tâches Ant sont les suivantes :

* [Tâches Ant pour l'installation de {{ site.data.keys.mf_console }}, des artefacts de {{ site.data.keys.mf_server }} et des services d'administration et Live Update de {{ site.data.keys.mf_server }}](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services)
* [Tâches Ant pour l'installation du service push de {{ site.data.keys.mf_server }}](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service)
* [Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}](../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments)

Pour une présentation de l'installation à l'aide de l'exemple de fichier de configuration et de tâches, voir [Installation de {{ site.data.keys.mf_server }} en mode de ligne de commande](../../simple-install/tutorials/command-line).

Vous pouvez exécuter un fichier Ant avec la distribution Ant proposée avec l'installation du produit. Par exemple, si vous disposez d'un cluster WebSphere Application Server Network Deployment et que votre base de données est IBM DB2, vous pouvez utiliser le fichier Ant **rép\_install\_mfp/MobileFirstServer/configuration-samples/configure-wasnd-cluster-db2.xml**. Après avoir édité le fichier et entré toutes les propriétés requises, vous pouvez exécuter les commandes suivantes depuis le répertoire **rép\_install\_mfp/MobileFirstServer/configuration-samples** :

* **rép\_install\_mfp/shortcuts/ant -f configure-wasnd-cluster-db2.xml help** - Cette commande affiche la liste de toutes les cibles possibles du fichier Ant pour installer, désinstaller ou mettre à jour des composants.
* **rép\_install\_mfp/shortcuts/ant -f configure-wasnd-cluster-db2.xml install** - Cette commande installe {{ site.data.keys.mf_server }} dans le cluster WebSphere Application Server Network Deployment avec DB2 comme source de données en utilisant les paramètres que vous avez entrés dans les propriétés du fichier Ant.

<br/>
Après l'installation, faites une copie du fichier Ant afin de pouvoir le réutiliser pour appliquer un groupe de correctifs.

### Application d'un groupe de correctifs à l'aide des fichiers Ant
{: #applying-a-fix-pack-by-using-the-ant-files }

#### Mise à jour à l'aide de l'exemple de fichier Ant
{: #updating-with-the-sample-ant-file }
Si vous utilisez l'un des exemples de fichier Ant fournis dans le répertoire **rép\_install\_mfp/MobileFirstServer/configuration-samples** pour installer {{ site.data.keys.mf_server }}, vous pouvez réutiliser une copie de ce fichier Ant afin d'appliquer un groupe de correctifs. Pour les valeurs de mot de passe, vous pouvez entrer 12 astérisques (\*) à la place de la valeur réelle pour être invité à la saisir de manière interactive lorsque le fichier Ant est exécuté.

1. Vérifiez la valeur de la propriété **mfp.server.install.dir** dans le fichier Ant. Elle doit désigner le répertoire contenant le produit auquel est appliqué le groupe de correctifs. Cette valeur permet d'extraire les fichiers WAR {{ site.data.keys.mf_server }} mis à jour.
2. Exécutez la commande suivante : `rép_install_mfp/shortcuts/ant -f votre_fichier_ant update`

#### Mise à jour à l'aide de votre propre fichier Ant
{: #updating-with-own-ant-file }
Si vous utilisez votre propre fichier Ant, assurez-vous que pour chaque tâche d'installation (**installmobilefirstadmin**, **installmobilefirstruntime** et **installmobilefirstpush**), votre fichier Ant comporte une tâche de mise à jour correspondante avec les mêmes paramètres. Les tâches de mise à jour correspondantes sont **updatemobilefirstadmin**, **updatemobilefirstruntime** et **updatemobilefirstpush**.

1. Vérifiez le chemin d'accès aux classes de l'élément **taskdef** pour le fichier **mfp-ant-deployer.jar**. Il doit désigner le fichier **mfp-ant-deployer.jar** dans une installation de {{ site.data.keys.mf_server }} à laquelle le groupe de correctifs est appliqué. Par défaut, les fichiers WAR mis à jour de {{ site.data.keys.mf_server }} sont extraits de l'emplacement dans lequel se trouve **mfp-ant-deployer.jar**.
2. Exécutez les tâches de mise à jour (**updatemobilefirstadmin**, **updatemobilefirstruntime** et **updatemobilefirstpush**) de votre fichier Ant.

### Modification des exemples de fichier Ant
{: #sample-ant-files-modifications }
Vous pouvez modifier les exemples de fichier Ant fournis dans le répertoire **rép\_install\_mfp/MobileFirstServer/configuration-samples** afin de les adapter à la configuration requise pour votre installation.  
Les sections suivantes expliquent en détail comment modifier les exemples de fichier Ant afin d'adapter l'installation à vos besoins :

1. [Spécification de propriétés JNDI supplémentaires](#specify-extra-jndi-properties)
2. [Spécification d'utilisateurs existants](#specify-existing-users)
3. [Spécification du niveau Java EE de Liberty](#specify-liberty-java-ee-level)
4. [Spécification des propriétés JDBC de source de données](#specify-data-source-jdbc-properties)
5. [Exécution des fichiers Ant sur un ordinateur sur lequel {{ site.data.keys.mf_server }} n'est pas installé](#run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed)
6. [Spécification des cibles WebSphere Application Server Network Deployment](#specify-websphere-application-server-network-deployment-targets)
7. [Configuration manuelle du port RMI sur Apache Tomcat](#manual-configuration-of-the-rmi-port-on-apache-tomcat)

#### Spécification de propriétés JNDI supplémentaires
{: #specify-extra-jndi-properties }
Les tâches Ant **installmobilefirstadmin**, **installmobilefirstruntime** et **installmobilefirstpush** déclarent les valeurs pour les propriétés JNDI qui sont requises pour que les composants fonctionnent. Ces propriétés JNDI sont utilisées pour définir la communication JMX ainsi que les liens vers d'autres composants (comme le service Live Update, le service push, le service d'analyse ou le serveur d'autorisation). Toutefois, vous pouvez aussi définir des valeurs pour d'autres propriétés JNDI. Utilisez l'élément `<property>` qui existe pour ces trois tâches. Pour la liste des propriétés JNDI, voir :

* [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service)
* [Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime)

Exemple :

```xml
<installmobilefirstadmin ..>
    <property name="mfp.admin.actions.prepareTimeout" value="3000000"/>
</installmobilefirstadmin>
```

#### Spécification d'utilisateurs existants
{: #specify-existing-users }
Par défaut, la tâche Ant **installmobilefirstadmin** crée des utilisateurs :

* Dans WebSphere Application Server Liberty afin de définir un administrateur Liberty pour la communication JMX.
* Sur tout serveur d'applications afin de définir un utilisateur servant pour la communication avec le service Live Update.

Pour vous servir d'un utilisateur existant au lieu de créer un utilisateur, vous pouvez effectuer les deux opérations suivantes :

1. Dans l'élément `<jmx>`, spécifiez un utilisateur et un mot de passe et associez l'attribut **createLibertyAdmin** à la valeur false. Exemple :

   ```xml
   <installmobilefirstadmin ...>
       <jmx libertyAdminUser="myUser" libertyAdminPassword="password" createLibertyAdmin="false" />
       ...
   ```

2. Dans l'élément `<configuration>`, spécifiez un utilisateur et un mot de passe et associez l'attribut **createConfigAdminUser** à la valeur false. Exemple :

   ```xml
    <installmobilefirstadmin ...>
        <configuration configAdminUser="myUser" configAdminPassword="password" createConfigAdminUser="false" />
        ...
   ```

De plus, l'utilisateur créé par les fichiers d'exemple Ant est mappé aux rôles de sécurité du service d'administration et de la console. Avec ce paramètre, vous pouvez utiliser cet utilisateur pour vous connecter à {{ site.data.keys.mf_server }} après l'installation. Pour changer ce comportement, supprimez l'élément `<user>` des exemples de fichier Ant. Vous pouvez aussi supprimer l'attribut **password** de l'élément `<user>` pour ne pas créer l'utilisateur dans le registre local du serveur d'applications.

#### Spécification du niveau Java EE de Liberty
{: #specify-liberty-java-ee-level }
Certaines distributions de WebSphere Application Server Liberty prennent en charge des fonctions de Java EE 6 ou de Java EE 7. Par défaut, les tâches Ant détectent automatiquement les fonctions à installer. Par exemple, la fonction Liberty **jdbc-4.0** est installée pour Java EE 6 et la fonction **jdbc-4.1** est installée pour Java EE 7. Si l'installation Liberty prend en charge les deux fonctions (Java EE 6 et Java EE 7), vous pouvez imposer un certain niveau de fonctions. Imaginez par exemple que vous prévoyez d'exécuter la version 8.0.0 et la version 7.1.0 de {{ site.data.keys.mf_server }} sur le même serveur Liberty. {{ site.data.keys.mf_server }} version 7.1.0 ou antérieure ne prend en charge que les fonctions Java EE 6.

Pour imposer un certain niveau de fonctions Java EE 6, utilisez l'attribut jeeversion de l'élément `<websphereapplicationserver>`. Exemple :

```xml
<installmobilefirstadmin execute="${mfp.process.admin}" contextroot="${mfp.admin.contextroot}">
    [...]
    <applicationserver>
      <websphereapplicationserver installdir="${appserver.was.installdir}"
        profile="Liberty" jeeversion="6">
```

#### Spécification des propriétés JDBC de source de données
{: #specify-data-source-jdbc-properties }
Vous pouvez spécifier les propriétés pour la connexion JDBC. Utilisez l'élément `<property>` d'un élément `<database>`. L'élément est disponible dans les tâches Ant **configureDatabase**, **installmobilefirstadmin**, **installmobilefirstruntime** et **installmobilefirstpush**. Exemple :

```xml
<configuredatabase kind="MobileFirstAdmin">
    <db2 database="${database.db2.mfpadmin.dbname}"
        server="${database.db2.host}"
        instance="${database.db2.instance}"
        user="${database.db2.mfpadmin.username}"
        port= "${database.db2.port}"
        schema = "${database.db2.mfpadmin.schema}"
        password="${database.db2.mfpadmin.password}">

       <property name="commandTimeout" value="10"/>
    </db2>
```

#### Exécution des fichiers Ant sur un ordinateur sur lequel {{ site.data.keys.mf_server }} n'est pas installé
{: #run-the-ant-files-on-a-computer-where-mobilefirst-server-is-not-installed }
Pour exécuter les tâches Ant sur un ordinateur sur lequel {{ site.data.keys.mf_server }} n'est pas installé, vous avez besoin :

* D'une installation Ant
* D'une copie du fichier **mfp-ant-deployer.jar** sur l'ordinateur distant. Cette bibliothèque contient la définition des tâches Ant.
* De spécifier les ressources à installer. Par défaut, les fichiers WAR sont extraits depuis un emplacement proche de **mfp-ant-deployer.jar**, mais vous pouvez spécifier cet emplacement. Exemple :

```xml
<installmobilefirstadmin execute="true" contextroot="/mfpadmin" serviceWAR="/usr/mfp/mfp-admin-service.war">
  <console install="true" warFile="/usr/mfp/mfp-admin-ui.war"/>
```

Pour plus d'informations, voir les tâches Ant permettant d'installer chaque composant {{ site.data.keys.mf_server }} dans [Référence d'installation](../../installation-reference).

#### Spécification des cibles WebSphere Application Server Network Deployment
{: #specify-websphere-application-server-network-deployment-targets }
Pour procéder à l'installation sur WebSphere Application Server Network Deployment, le profil WebSphere Application Server spécifié doit être le gestionnaire de déploiement. Vous pouvez effectuer le déploiement dans les configurations suivantes :

* Un cluster
* Un serveur unique
* Une cellule (tous les serveurs d'une cellule)
* Un noeud (tous les serveurs d'un noeud)

Les exemples de fichier tels que **configure-wasnd-cluster-dbms-name.xml**, **configure-wasnd-server-dbms-name.xml** et **configure-wasnd-node-dbms-name.xml** contiennent une déclaration pour le déploiement de chaque type de cible. Pour plus d'informations, voir les tâches Ant permettant d'installer chaque composant {{ site.data.keys.mf_server }} dans [Référence d'installation](../../installation-reference).

> Remarque : depuis la version 8.0.0, l'exemple de fichier de configuration pour la cellule WebSphere Application Server Network Deployment n'est plus fourni.


#### Configuration manuelle du port RMI sur Apache Tomcat
{: #manual-configuration-of-the-rmi-port-on-apache-tomcat }
Par défaut, les tâches Ant modifient le fichier **setenv.bat** ou **setenv.sh** en vue de l'ouverture du port RMI. Si vous préférez ouvrir le port RMI manuellement, ajoutez l'attribut **tomcatSetEnvConfig** avec la valeur false dans l'élément `<jmx>` des tâches **installmobilefirstadmin**, **updatemobilefirstadmin** et **uninstallmobilefirstadmin**.

## Installation manuelle des composants {{ site.data.keys.mf_server }}
{: #installing-the-mobilefirst-server-components-manually }
Vous pouvez également installer les composants {{ site.data.keys.mf_server }} sur votre serveur d'applications manuellement.  
Les rubriques suivantes vous guideront tout au long du processus d'installation des composants sur les applications prises en charge en production :

* [Installation manuelle sur WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty)
* [Installation manuelle dans la collectivité WebSphere Application Server Liberty](#manual-installation-on-websphere-application-server-liberty-collective)
* [Installation manuelle sur Apache Tomcat](#manual-installation-on-apache-tomcat)
* [Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment](#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment)

### Installation manuelle sur WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty }
Assurez-vous d'avoir également satisfait les exigences décrites dans [Prérequis pour WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Contraintes liées à la topologie](#topology-constraints)
* [Paramètres de serveur d'applications](#application-server-settings)
* [Fonctions Liberty requises par les applications {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications)
* [Entrées JNDI globales](#global-jndi-entries)
* [Chargeur de classe](#class-loader)
* [Fonction utilisateur de décodage de mot de passe](#password-decoder-user-feature)
* [Détails de configuration](#configuration-details-liberty)

#### Contraintes liées à la topologie
{: #topology-constraints }
Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de MobileFirst doivent être installés sur un même serveur d'applications. La racine de contexte du service Live Update doit être **racine-contexteadminconfig**. La racine de contexte du service push doit être **imfpush**. Pour plus d'informations sur les contraintes, voir [Contraintes sur les composants {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Paramètres de serveur d'applications
{: #application-server-settings }
Vous devez configurer l'élément **webContainer** pour le chargement immédiat des servlets. Ce paramètre est requis pour l'initialisation via JMX. Par exemple : `<webContainer deferServletLoad="false"/>`.

Si vous le souhaitez, pour éviter tout problème de dépassement de délai d'attente interrompant la séquence de démarrage de l'environnement d'exécution et du service d'administration dans certaines versions de Liberty, changez l'élément **executor** par défaut. Définissez des valeurs élevées pour les attributs **coreThreads** et **maxThreads**. Exemple :

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Vous pouvez aussi configurer l'élément **tcpOptions** et associer l'attribut **soReuseAddr** à la valeur `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Fonctions Liberty requises par les applications {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications }
Vous pouvez utiliser les fonctions ci-dessous pour Java EE 6 ou Java EE 7.

**Service d'administration de {{ site.data.keys.mf_server }}**

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Service push de {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **servlet-3.0** (servlet-3.1 pour Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Environnement d'exécution de {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **servlet-3.0** (servlet-3.1 pour Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entrées JNDI globales
{: #global-jndi-entries }
Les entrées JNDI globales suivantes sont requises pour configurer la communication JMX entre l'environnement d'exécution et le service d'administration :

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**

Ces entrées JNDI globales sont définies avec la syntaxe ci-après et ne sont pas préfixées avec une racine de contexte. Par exemple : `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Remarque :** pour empêcher toute conversion automatique des valeurs JNDI, de sorte que 075 ne soit pas converti en 61 ou 31.500 en 31.5, utilisez la syntaxe '"075"' lorsque vous définissez la valeur.

Pour plus d'informations sur les propriétés JNDI pour le service d'administration, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  

Pour une configuration de parc de serveurs, voir aussi les rubriques suivantes :

* [Topologie de parc de serveurs](../topologies/#server-farm-topology)
* [Topologies et flots réseau](../topologies)
* [Installation d'un parc de serveurs](#installing-a-server-farm)

#### Chargeur de classe
{: #class-loader }
Pour toutes les applications, l'attribut delegation du chargeur de classe doit avoir la valeur parentLast (parent en dernier). Exemple :

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader> </application>
```

#### Fonction utilisateur de décodage de mot de passe
{: #password-decoder-user-feature }
Copiez la fonction utilisateur de décodage de mot de passe dans votre profil Liberty. Exemple :

* Sur les systèmes UNIX et Linux :

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Sur les systèmes Windows :

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```

#### Détails de configuration
{: #configuration-details-liberty }
<div class="panel-group accordion" id="manual-installation-liberty" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-admin-service" aria-expanded="true" aria-controls="collapse-admin-service"><b>Détails de configuration du service d'administration de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service">
            <div class="panel-body">
                <p>Le service d'administration est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Le fichier WAR du service d'administration est <b>rép_install_mfp/MobileFirstServer/mfp-admin-service.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpadmin</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte du service d'administration. L'exemple suivant est une déclaration de <b>mfp.admin.push.url</b> selon laquelle le service d'administration est installé avec la racine de contexte <b>/mfpadmin</b> :</p>
{% highlight xml %} <jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Si le service push est installé, vous devez configurer les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Les propriétés JNDI pour la communication avec le service de configuration sont les suivantes :</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour le service d'administration doit être <b>jndiName=racine-contexte/jdbc/mfpAdminDS</b>. L'exemple suivant illustre le cas où le service d'administration est installé avec la racine de contexte <b>/mfpadmin</b> et utilise une base de données relationnelle :</p>

{% highlight xml %} <dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Déclarez les rôles suivants dans l'élément <b>application-bnd</b> de l'application :</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-live-update-service" aria-expanded="true" aria-controls="collapse-live-update-service"><b>Détails de configuration du service Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service">
            <div class="panel-body">
                <p>Le service Live Update est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR du service Live Update est <b>rép_install_mfp/MobileFirstServer/mfp-live-update.war</b>. La racine de contexte du service Live Update doit être définie comme suit : <b>/racine-contexteadminconfig</b>. Par exemple, si la racine de contexte du service d'administration est <b>/mfpadmin</b>, la racine de contexte du service Live Update doit être <b>/mfpadminconfig</b>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour le service Live update doit être racine-contexte/jdbc/ConfigDS. L'exemple suivant illustre le cas où le service Live Update est installé avec la racine de contexte /mfpadminconfig et utilise une base de données relationnelle :</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3></h3>
                <p>Déclarez le rôle configadmin dans l'élément <b>application-bnd</b> de l'application. Un utilisateur au moins doit être mappé à ce rôle. L'utilisateur et son mot de passe doivent être fournis dans les propriétés JNDI suivantes du service d'administration :</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-console-configuration" aria-expanded="true" aria-controls="collapse-console-configuration"><b>Détails de configuration de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration">
            <div class="panel-body">
                <p>La console est conditionnée sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR de la console est <b>rép_install_mfp/MobileFirstServer/mfp-admin-ui.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpconsole</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte de la console. L'exemple suivant est une déclaration de <b>mfp.admin.endpoint</b> selon laquelle la console est installée avec la racine de contexte <b>/mfpconsole</b> :</p>

{% highlight xml %} <jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>La valeur habituelle pour la propriété mfp.admin.endpoint est <b>*://*:*/the-adminContextRoot</b>.<br/>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriétés JNDI pour {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Déclarez les rôles suivants dans l'élément <b>application-bnd</b> de l'application :</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Tout utilisateur mappé à un rôle de sécurité de la console doit également être mappé au même rôle de sécurité du service d'administration.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-runtime-configuration" aria-expanded="true" aria-controls="collapse-runtime-configuration"><b>Détails de configuration de l'environnement d'exécution MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration">
            <div class="panel-body">
                <p>L'environnement d'exécution est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR de l'environnement d'exécution est <b>rép_install_mfp/MobileFirstServer/mfp-server.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit par défaut de <b>/mfp</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte de l'environnement d'exécution. L'exemple suivant est une déclaration de <b>mfp.analytics.url</b> selon laquelle l'environnement d'exécution est installé avec la racine de contexte <b>/mobilefirst</b> :</p>

{% highlight xml %} <jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Vous devez définir la propriété <b>mobilefirst/mfp.authorization.server</b>. Exemple :</p>
{% highlight xml %} <jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Si {{ site.data.keys.mf_analytics }} est installé, vous devez définir les propriétés JNDI suivantes :</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour l'environnement d'exécution doit être <b>jndiName=racine-contexte/jdbc/mfpDS</b>. L'exemple suivant illustre le cas où l'environnement d'exécution est installé avec la racine de contexte <b>/mobilefirst</b> et utilise une base de données relationnelle :</p>

{% highlight xml %} <dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource> {% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-liberty">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-push-configuration-liberty" aria-expanded="true" aria-controls="collapse-push-configuration-liberty"><b>Détails de configuration du service push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-liberty" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-liberty">
            <div class="panel-body">
                <p>Le service push est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR du service push est <b>rép_install_mfp/PushService/mfp-push-service.war</b>. Vous devez définir la racine de contexte <b>/imfpush</b>. Sinon, les appareils client ne pourront pas se connecter au service car la racine de contexte est codée en dur dans le logiciel SDK.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte du service push. L'exemple suivant est une déclaration de <b>mfp.push.analytics.user</b> selon laquelle le service push est installé avec la racine de contexte <b>/imfpush</b> :</p>

{% highlight xml %} <jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Vous devez définir les propriétés suivantes :
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - La valeur doit être <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - Pour une base de données relationnelle, la valeur doit être DB.</li>
                </ul>

                Si {{ site.data.keys.mf_analytics }} est configuré, définissez les propriétés JNDI suivantes :
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - La valeur doit être <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty" href="#collapse-artifacts-configuration" aria-expanded="true" aria-controls="collapse-artifacts-configuration"><b>Détails de configuration des artefacts de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration">
            <div class="panel-body">
                <p>Le composant des artefacts est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR pour ce composant est <b>rép_install_mfp/MobileFirstServer/mfp-dev-artifacts.war</b>. Vous devez définir la racine de contexte <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Installation manuelle dans la collectivité Liberty WebSphere Application Server Liberty
{: #manual-installation-on-websphere-application-server-liberty-collective }
Assurez-vous d'avoir également satisfait les exigences décrites dans [Prérequis pour WebSphere Application Server Liberty](#websphere-application-server-liberty-prerequisites).

* [Contraintes liées à la topologie](#topology-constraints-collective)
* [Paramètres de serveur d'applications](#application-server-settings-collective)
* [Fonctions Liberty requises par les applications {{ site.data.keys.mf_server }}](#liberty-features-required-by-the-mobilefirst-server-applications-collective)
* [Entrées JNDI globales](#global-jndi-entries-collective)
* [Chargeur de classe](#class-loader-collective)
* [Fonction utilisateur de décodage de mot de passe](#password-decoder-user-feature-collective)
* [Détails de configuration](#configuration-details-collective)

#### Contraintes liées à la topologie
{: #topology-constraints-collective }
Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_console }} doivent être installés sur un contrôleur de collectivité Liberty. L'environnement d'exécution {{ site.data.keys.product_adj }} et le service push de {{ site.data.keys.mf_server }} doivent être installés sur chaque membre de cluster de collectivité Liberty.

La racine de contexte du service Live Update doit être **racine-contexteadminconfig**. La racine de contexte du service push doit être **imfpush**. Pour plus d'informations sur les contraintes, voir [Contraintes sur les composants {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Paramètres de serveur d'applications
{: #application-server-settings-collective }
Vous devez configurer l'élément **webContainer** pour le chargement immédiat des servlets. Ce paramètre est requis pour l'initialisation via JMX. Par exemple : `<webContainer deferServletLoad="false"/>`.

Si vous le souhaitez, pour éviter tout problème de dépassement de délai d'attente interrompant la séquence de démarrage de l'environnement d'exécution et du service d'administration dans certaines versions de Liberty, changez l'élément **executor** par défaut. Définissez des valeurs élevées pour les attributs **coreThreads** et **maxThreads**. Exemple :

```xml
<executor id="default" name="LargeThreadPool"
  coreThreads="200" maxThreads="400" keepAlive="60s"
  stealPolicy="STRICT" rejectedWorkPolicy="CALLER_RUNS"/>
```

Vous pouvez aussi configurer l'élément **tcpOptions** et associer l'attribut **soReuseAddr** à la valeur `true`: `<tcpOptions soReuseAddr="true"/>`.

#### Fonctions Liberty requises par les applications {{ site.data.keys.mf_server }}
{: #liberty-features-required-by-the-mobilefirst-server-applications-collective }

Vous devez ajouter les fonctions ci-dessous pour Java EE 6 ou Java EE 7.

**Service d'administration de {{ site.data.keys.mf_server }}**

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **appSecurity-2.0**
* **restConnector-1.0**
* **usr:MFPDecoderFeature-1.0**

**Service push de {{ site.data.keys.mf_server }}**  

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **servlet-3.0** (servlet-3.1 pour Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

**Environnement d'exécution de {{ site.data.keys.product_adj }}**  

* **jdbc-4.0** (jdbc-4.1 pour Java EE 7)
* **servlet-3.0** (servlet-3.1 pour Java EE 7)
* **ssl-1.0**
* **usr:MFPDecoderFeature-1.0**

#### Entrées JNDI globales
{: #global-jndi-entries-collective }
Les entrées JNDI globales suivantes sont requises pour configurer la communication JMX entre l'environnement d'exécution et le service d'administration :

* **mfp.admin.jmx.host**
* **mfp.admin.jmx.port**
* **mfp.admin.jmx.user**
* **mfp.admin.jmx.pwd**
* **mfp.topology.platform**
* **mfp.topology.clustermode**
* **mfp.admin.serverid**

Ces entrées JNDI globales sont définies avec la syntaxe ci-après et ne sont pas préfixées avec une racine de contexte. Par exemple : `<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>`.

> **Remarque :** pour empêcher toute conversion automatique des valeurs JNDI, de sorte que 075 ne soit pas converti en 61 ou 31.500 en 31.5, utilisez la syntaxe '"075"' lorsque vous définissez la valeur.

* Pour plus d'informations sur les propriétés JNDI pour le service d'administration, voir [Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).  
* Pour plus d'informations sur les propriétés JNDI pour l'environnement d'exécution, voir [Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime).

#### Chargeur de classe
{: #class-loader-collective }
Pour toutes les applications, l'attribut delegation du chargeur de classe doit avoir la valeur parentLast (parent en dernier). Exemple :

```xml
<application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
  [...]
  <classloader delegation="parentLast">
  </classloader> </application>
```

#### Fonction utilisateur de décodage de mot de passe
{: #password-decoder-user-feature-collective }
Copiez la fonction utilisateur de décodage de mot de passe dans votre profil Liberty. Exemple :

* Sur les systèmes UNIX et Linux :

  ```bash
  mkdir -p LIBERTY_HOME/wlp/usr/extension/lib/features
  cp product_install_dir/features/com.ibm.websphere.crypto_1.0.0.jar LIBERTY_HOME/wlp/usr/extension/lib/
  cp product_install_dir/features/MFPDecoderFeature-1.0.mf LIBERTY_HOME/wlp/usr/extension/lib/features/
  ```

* Sur les systèmes Windows :

  ```bash
  mkdir LIBERTY_HOME\wlp\usr\extension\lib
  copy /B product_install_dir\features\com.ibm.websphere.crypto_1.0.0.jar
  LIBERTY_HOME\wlp\usr\extension\lib\com.ibm.websphere.crypto_1.0.0.jar
  mkdir LIBERTY_HOME\wlp\usr\extension\lib\features
  copy /B product_install_dir\features\MFPDecoderFeature-1.0.mf
  LIBERTY_HOME\wlp\usr\extension\lib\features\MFPDecoderFeature-1.0.mf
  ```
#### Détails de configuration
{: #configuration-details-collective }
<div class="panel-group accordion" id="manual-installation-liberty-collective" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-admin-service-collective" aria-expanded="true" aria-controls="collapse-admin-service-collective"><b>Détails de configuration du service d'administration de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-collective">
            <div class="panel-body">
                <p>Le service d'administration est conditionné sous forme d'application WAR en vue de son déploiement sur le contrôleur de collectivité Liberty. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du contrôleur de collectivité Liberty.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty-collective">Installation manuelle dans la collectivité WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service d'administration se trouve dans <b>mfp_install_dir/MobileFirstServer/mfp-admin-service-collective.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpadmin</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte du service d'administration. L'exemple suivant est une déclaration de <b>mfp.admin.push.url</b> selon laquelle le service d'administration est installé avec la racine de contexte <b>/mfpadmin</b> :</p>
{% highlight xml %} <jndiEntry jndiName="mfpadmin/mfp.admin.push.url" value="http://localhost:9080/imfpush"/>
{% endhighlight %}

                <p>Si le service push est installé, vous devez configurer les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Les propriétés JNDI pour la communication avec le service de configuration sont les suivantes :</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour le service d'administration doit être <b>jndiName=racine-contexte/jdbc/mfpAdminDS</b>. L'exemple suivant illustre le cas où le service d'administration est installé avec la racine de contexte <b>/mfpadmin</b> et utilise une base de données relationnelle :</p>

{% highlight xml %} <dataSource jndiName="mfpadmin/jdbc/mfpAdminDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Rôles de sécurité</h3>
                <p>Déclarez les rôles suivants dans l'élément <b>application-bnd</b> de l'application :</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-live-update-service-collective" aria-expanded="true" aria-controls="collapse-live-update-service-collective"><b>Détails de configuration du service Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-collective">
            <div class="panel-body">
                <p>Le service Live Update est conditionné sous forme d'application WAR en vue de son déploiement sur le contrôleur de collectivité Liberty. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du contrôleur de collectivité Liberty.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty-collective">Installation manuelle dans la collectivité WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service Live Update est <b>rép_install_mfp/MobileFirstServer/mfp-live-update.war</b>. La racine de contexte du service Live Update doit être définie comme suit : <b>/racine-contexteadminconfig</b>. Par exemple, si la racine de contexte du service d'administration est <b>/mfpadmin</b>, la racine de contexte du service Live Update doit être <b>/mfpadminconfig</b>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour le service Live Update doit être <b>racine-contexte/jdbc/ConfigDS</b>. L'exemple suivant illustre le cas où le service Live Update est installé avec la racine de contexte <b>/mfpadminconfig</b> et utilise une base de données relationnelle :</p>

{% highlight xml %}
<dataSource jndiName="mfpadminconfig/jdbc/ConfigDS" transactional="false">
  [...]
</dataSource>
{% endhighlight %}

                <h3>Rôles de sécurité</h3>
                <p>Déclarez le rôle configadmin dans l'élément <b>application-bnd</b> de l'application. Un utilisateur au moins doit être mappé à ce rôle. L'utilisateur et son mot de passe doivent être fournis dans les propriétés JNDI suivantes du service d'administration :</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-console-configuration-collective" aria-expanded="true" aria-controls="collapse-console-configuration-collective"><b>Détails de configuration de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-collective">
            <div class="panel-body">
                <p>La console est conditionnée sous forme d'application WAR en vue de son déploiement sur le contrôleur de collectivité Liberty. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du contrôleur de collectivité Liberty.
                <br/><br/>Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty-collective">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de la console est <b>rép_install_mfp/MobileFirstServer/mfp-admin-ui.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpconsole</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte de la console. L'exemple suivant est une déclaration de <b>mfp.admin.endpoint</b> selon laquelle la console est installée avec la racine de contexte <b>/mfpconsole</b> :</p>

{% highlight xml %} <jndiEntry jndiName="mfpconsole/mfp.admin.endpoint" value="*://*:*/mfpadmin"/>
{% endhighlight %}

                <p>La valeur habituelle pour la propriété mfp.admin.endpoint est <b>*://*:*/the-adminContextRoot</b>.<br/>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriétés JNDI pour {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Déclarez les rôles suivants dans l'élément <b>application-bnd</b> de l'application :</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Tout utilisateur mappé à un rôle de sécurité de la console doit également être mappé au même rôle de sécurité du service d'administration.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-runtime-configuration-collective" aria-expanded="true" aria-controls="collapse-runtime-configuration-collective"><b>Détails de configuration de l'environnement d'exécution de {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-collective">
            <div class="panel-body">
                <p>L'environnement d'exécution est conditionné sous forme d'application WAR en vue de son déploiement sur les membres de cluster de collectivité Liberty. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> de chaque membre de cluster de collectivité Liberty.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty-collective">Installation manuelle dans la collectivité WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de l'environnement d'exécution est <b>rép_install_mfp/MobileFirstServer/mfp-server.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit par défaut de <b>/mfp</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte de l'environnement d'exécution. L'exemple suivant est une déclaration de <b>mfp.analytics.url</b> selon laquelle l'environnement d'exécution est installé avec la racine de contexte <b>/mobilefirst</b> :</p>

{% highlight xml %} <jndiEntry jndiName="mobilefirst/mfp.analytics.url" value="http://localhost:9080/analytics-service/rest"/>
{% endhighlight %}

                <p>Vous devez définir la propriété <b>mobilefirst/mfp.authorization.server</b>. Exemple :</p>
{% highlight xml %} <jndiEntry jndiName="mobilefirst/mfp.authorization.server" value="embedded"/>
{% endhighlight %}

                <p>Si {{ site.data.keys.mf_analytics }} est installé, vous devez définir les propriétés JNDI suivantes :</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour l'environnement d'exécution doit être <b>jndiName=racine-contexte/jdbc/mfpDS</b>. L'exemple suivant illustre le cas où l'environnement d'exécution est installé avec la racine de contexte <b>/mobilefirst</b> et utilise une base de données relationnelle :</p>

{% highlight xml %} <dataSource jndiName="mobilefirst/jdbc/mfpDS" transactional="false">
  [...]
</dataSource> {% endhighlight %}
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-push-configuration" aria-expanded="true" aria-controls="collapse-push-configuration"><b>Détails de configuration du service push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration">
            <div class="panel-body">
                <p>Le service push est conditionné sous forme d'application WAR en vue de son déploiement sur un membre de cluster de collectivité Liberty ou un serveur Liberty. Si vous installez le service push sur un serveur Liberty, reportez-vous à <a href="#configuration-details-liberty">Détails de configuration du service push de {{ site.data.keys.mf_server }}</a> sous <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a>.
                <br/><br/>
                Lorsque le service push de {{ site.data.keys.mf_server }} est installé dans une collectivité Liberty, il peut être installé dans le même cluster que l'exécution ou dans un autre cluster.
                <br/><br/>
                Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> de chaque membre de cluster de collectivité Liberty. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty-collective">Installation manuelle dans la collectivité WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.    
                <br/><br/>
                Le fichier WAR du service push est <b>rép_install_mfp/PushService/mfp-push-service.war</b>. Vous devez définir la racine de contexte <b>/imfpush</b>. Sinon, les appareils client ne pourront pas se connecter au service car la racine de contexte est codée en dur dans le logiciel SDK.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Lorsque vous définissez les propriétés JNDI, les noms JNDI doivent être préfixés avec la racine de contexte du service push. L'exemple suivant est une déclaration de <b>mfp.push.analytics.user</b> selon laquelle le service push est installé avec la racine de contexte <b>/imfpush</b> :</p>

{% highlight xml %} <jndiEntry jndiName="imfpush/mfp.push.analytics.user" value="admin"/>
{% endhighlight %}

                Vous devez définir les propriétés suivantes :
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - La valeur doit être <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - Pour une base de données relationnelle, la valeur doit être DB.</li>
                </ul>

                Si {{ site.data.keys.mf_analytics }} est configuré, définissez les propriétés JNDI suivantes :
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - La valeur doit être <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-collective">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-liberty-collective" href="#collapse-artifacts-configuration-collective" aria-expanded="true" aria-controls="collapse-artifacts-configuration-collective"><b>Détails de configuration des artefacts de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-collective" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-collective">
            <div class="panel-body">
                <p>Le composant des artefacts est conditionné sous forme d'application WAR en vue de son déploiement sur le contrôleur de collectivité Liberty. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du contrôleur de collectivité Liberty. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-liberty">Installation manuelle sur WebSphere Application Server Liberty</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR pour ce composant est <b>rép_install_mfp/MobileFirstServer/mfp-dev-artifacts.war</b>. Vous devez définir la racine de contexte <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Installation manuelle sur Apache Tomcat
{: #manual-installation-on-apache-tomcat }
Assurez-vous d'avoir satisfait les exigences décrites dans [Prérequis pour Apache Tomcat](#apache-tomcat-prerequisites).

* [Contraintes liées à la topologie](#topology-constraints-tomcat)
* [Paramètres de serveur d'applications](#application-server-settings-tomcat)
* [Détails de configuration](#configuration-details-tomcat)

#### Contraintes liées à la topologie
{: #topology-constraints-tomcat }
Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }} doivent être installés sur un même serveur d'applications. La racine de contexte du service Live Update doit être **racine-contexteadminconfig**. La racine de contexte du service push doit être **imfpush**. Pour plus d'informations sur les contraintes, voir [Contraintes sur les composants {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

#### Paramètres de serveur d'applications
{: #application-server-settings-tomcat }
Vous devez activer la **valve de connexion unique**. Exemple :

```xml
<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
```

Si vous le souhaitez, vous pouvez activer le domaine de mémoire (MemoryRealm) si les utilisateurs sont définis dans **tomcat-users.xml**. Exemple :

```xml
<Realm className="org.apache.catalina.realm.MemoryRealm"/>
```
#### Détails de configuration
{: #configuration-details-tomcat }
<div class="panel-group accordion" id="manual-installation-apache-tomcat" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-admin-service-tomcat" aria-expanded="true" aria-controls="collapse-admin-service-tomcat"><b>Détails de configuration du service d'administration de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-tomcat">
            <div class="panel-body">
                <p>Le service d'administration est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service d'administration est <b>rép_install_mfp/MobileFirstServer/mfp-admin-service.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpadmin</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Les propriétés JNDI sont définies dans l'élément <code>Environment</code> dans le contexte d'application. Exemple :</p>

{% highlight xml %}
<Environment name="mfp.admin.push.url" value="http://localhost:8080/imfpush" type="java.lang.String" override="false"/>
{% endhighlight %}
                <p>Pour activer la communication JMX avec l'environnement d'exécution, définissez les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Si le service push est installé, vous devez configurer les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Les propriétés JNDI pour la communication avec le service de configuration sont les suivantes :</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Source de données</h3>
                <p>La source de données (jdbc/mfpAdminDS) est déclarée comme ressource dans l'élément **Context**. Exemple :</p>

{% highlight xml %}
<Resource name="jdbc/mfpAdminDS" type="javax.sql.DataSource" .../>
{% endhighlight %}

                <h3>Rôles de sécurité</h3>
                <p>Les rôles de sécurité disponibles pour l'application de service d'administration sont :</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-live-update-service-tomcat" aria-expanded="true" aria-controls="collapse-live-update-service-tomcat"><b>Détails de configuration du service Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-tomcat">
            <div class="panel-body">
                <p>Le service Live Update est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service Live Update est <b>rép_install_mfp/MobileFirstServer/mfp-live-update.war</b>. La racine de contexte du service Live Update doit être définie comme suit : <b>/racine-contexteadmin/config</b>. Par exemple, si la racine de contexte du service d'administration est <b>/mfpadmin</b>, la racine de contexte du service Live Update doit être <b>/mfpadminconfig</b>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour le service Live Update doit être <code>jdbc/ConfigDS</code>. Déclarez-le comme ressource dans l'élément <code>Context</code>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Le rôle de sécurité disponible pour l'application de service Live Update est <b>configadmin</b>.
                <br/><br/>
                Un utilisateur au moins doit être mappé à ce rôle. L'utilisateur et son mot de passe doivent être fournis dans les propriétés JNDI suivantes du service d'administration :</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-console-configuration-tomcat" aria-expanded="true" aria-controls="collapse-console-configuration-tomcat"><b>Détails de configuration de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-tomcat">
            <div class="panel-body">
                <p>La console est conditionnée sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications.
                <br/><br/>Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de la console est <b>rép_install_mfp/MobileFirstServer/mfp-admin-ui.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpconsole</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous devez définir la propriété <b>mfp.admin.endpoint</b>. En général, la valeur de cette propriété est <b>*://*:*/racine-contexteadmin</b>.
                <br/><br/>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriétés JNDI pour {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Les rôles de sécurité disponibles pour l'application sont :</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-runtime-configuration-tomcat" aria-expanded="true" aria-controls="collapse-runtime-configuration-tomcat"><b>Détails de configuration de l'environnement d'exécution de {{ site.data.keys.product_adj }}</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-tomcat">
            <div class="panel-body">
                <p>L'environnement d'exécution est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de l'environnement d'exécution est <b>rép_install_mfp/MobileFirstServer/mfp-server.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit par défaut de <b>/mfp</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous devez définir la propriété <b>mfp.authorization.server</b>. Exemple :</p>

{% highlight xml %}
<Environment name="mfp.authorization.server" value="embedded" type="java.lang.String" override="false"/>
{% endhighlight %}

                <p>Pour activer la communication JMX avec le service d'administration, définissez les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.topology.platform</b></li>
                    <li><b>mfp.topology.clustermode</b></li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} est installé, vous devez définir les propriétés JNDI suivantes :</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Source de données</h3>
                <p>Le nom JNDI de la source de données pour l'environnement d'exécution doit être <b>jdbc/mfpDS</b>. Déclarez-le comme ressource dans l'élément <b>Context</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-apache-tomcat" href="#collapse-push-configuration-tomcat" aria-expanded="true" aria-controls="collapse-push-configuration-tomcat"><b>Détails de configuration du service push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-tomcat">
            <div class="panel-body">
                <p>Le service push est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application. Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.    
                <br/><br/>
                Le fichier WAR du service push est <b>rép_install_mfp/PushService/mfp-push-service.war</b>. Vous devez définir la racine de contexte <b>/imfpush</b>. Sinon, les appareils client ne pourront pas se connecter au service car la racine de contexte est codée en dur dans le logiciel SDK.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous devez définir les propriétés suivantes :</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - La valeur doit être <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - Pour une base de données relationnelle, la valeur doit être DB.</li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} est configuré, définissez les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - La valeur doit être <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}</a>.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-tomcat">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-on-apache-tomcat" href="#collapse-artifacts-configuration-tomcat" aria-expanded="true" aria-controls="collapse-artifacts-configuration-tomcat"><b>Détails de configuration des artefacts de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-tomcat" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-tomcat">
            <div class="panel-body">
                <p>Le composant des artefacts est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications. Avant de continuer, consultez la section <a href="#manual-installation-on-apache-tomcat">Installation manuelle sur Apache Tomcat</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR pour ce composant est <b>rép_install_mfp/MobileFirstServer/mfp-dev-artifacts.war</b>. Vous devez définir la racine de contexte <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

### Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment
{: #manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment }
Assurez-vous d'avoir satisfait les exigences décrites dans <a href="#websphere-application-server-and-websphere-application-server-network-deployment-prerequisites">Prérequis pour WebSphere Application Server et WebSphere Application Server Network Deployment</a>.

* [Contraintes liées à la topologie](#topology-constraints-nd)
* [Paramètres de serveur d'applications](#application-server-settings-nd)
* [Chargeur de classe](#class-loader-nd)
* [Détails de configuration](#configuration-details-nd)

#### Contraintes liées à la topologie
{: #topology-constraints-nd }
<b>Sur un serveur WebSphere Application Server autonome</b>  
Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }} doivent être installés sur un même serveur d'applications. La racine de contexte du service Live Update doit être <b>racine-contexteadminConfig</b>. La racine de contexte du service push doit être <b>imfpush</b>. Pour plus d'informations sur les contraintes, voir [Contraintes sur les composants {{ site.data.keys.mf_server }} et {{ site.data.keys.mf_analytics }}](../topologies/#constraints-on-the-mobilefirst-server-components-and-mobilefirst-analytics).

<b>Sur WebSphere Application Server Network Deployment</b>  
Le gestionnaire de déploiement doit s'exécuter lorsque {{ site.data.keys.mf_server }} s'exécute. Il est utilisé pour la communication JMX entre l'environnement d'exécution et le service d'administration. Le service d'administration et le service Live Update doivent être installés sur le même serveur d'applications. L'environnement d'exécution peut être installé sur un serveur différent de celui du service d'administration, mais doit se trouver dans la même cellule.

#### Paramètres de serveur d'applications
{: #application-server-settings-nd }
La sécurité administrative et la sécurité des applications doivent être activées. Vous pouvez activer la sécurité des applications dans la console d'administration WebSphere Application Server :

1. Connectez-vous à la console d'administration WebSphere Application Server.
2. Sélectionnez **Sécurité → Sécurité globale**. Assurez-vous que l'option Activer la sécurité administrative est sélectionnée.
3. Ensuite, assurez-vous que l'option **Activer la sécurité des applications** est sélectionnée. La sécurité des applications ne peut être activée que si la sécurité administrative est activée.
4. Cliquez sur **OK**.
5. Sauvegardez les modifications.

Pour plus d'informations, voir [Activation de la sécurité](http://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/tsec_csec2.html?view=kc) dans la documentation de WebSphere Application Server.

Les règles de chargeur de classe du serveur doivent prendre en charge la valeur d'attribut delegation parentLast (parent en dernier). Les fichiers WAR de {{ site.data.keys.mf_server }} doivent être installés en mode de chargeur de classe "parent en dernier". Prenez connaissance de la règle de chargeur de classe du serveur :

1. Connectez-vous à la console d'administration WebSphere Application Server.
2. Sélectionnez **Serveurs → Types de serveurs → Serveurs d'applications WebSphere** et cliquez sur le serveur qui est utilisé pour {{ site.data.keys.product }}.
3. Si la règle de chargeur de classe est **Plusieurs**, ne faites rien.
4. Si la règle de chargeur de classe est **Un seul** et si le mode de chargement des classes a pour valeur **Classes chargées en premier avec un chargeur de classe local (dernier parent)**, ne faites rien.
5. Si la règle de chargeur de classe est **Un seul** et si le mode de chargement des classes a pour valeur **Classes chargées en premier avec un chargeur de classes parent (parent en premier)**, remplacez la règle de chargeur de classe par **Plusieurs**. De plus, associez l'ordre de chargeur de classe de toutes les applications autres que les applications {{ site.data.keys.mf_server }} à **Classes chargées en premier avec un chargeur de classes parent (parent en premier)**.

#### Chargeur de classe
{: #class-loader-nd }
Pour toutes les applications {{ site.data.keys.mf_server }}, l'attribut delegation du chargeur de classe doit avoir la valeur parentLast (parent en dernier).

Pour définir la valeur de l'attribut delegation parentLast (parent en dernier) après l'installation d'une application, procédez comme suit :

1. Sélectionnez **Applications → Types d'application → Applications d'entreprise WebSphere**.
2. Cliquez sur l'application **{{ site.data.keys.mf_server }}**. Par défaut, le nom de l'application est le nom du fichier WAR.
3. Dans la section **Propriétés du détail**, cliquez sur le lien **Chargement de classes et détection de mise à jour**.
4. Dans la sous-fenêtre **Ordre du chargeur de classes**, sélectionnez l'option **Classes chargées en premier avec un chargeur de classe local (dernier parent)**.
5. Cliquez sur **OK**.
6. Dans la section **Modules**, cliquez sur le lien **Gestion des modules**.
7. Cliquez sur le module.
8. Dans la zone **Ordre du chargeur de classes**, sélectionnez l'option **Classes chargées en premier avec un chargeur de classe local (dernier parent)**.
9. Cliquez sur **OK** deux fois pour confirmer la sélection et revenir au panneau **Configuration** de l'application.
10. Cliquez sur **Sauvegarder** pour sauvegarder les modifications.

#### Détails de configuration
{: #configuration-details-nd }
<div class="panel-group accordion" id="manual-installation-nd" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="admin-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-admin-service-nd" aria-expanded="true" aria-controls="collapse-admin-service-nd"><b>Détails de configuration du service d'administration de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-admin-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="admin-service-nd">
            <div class="panel-body">
                <p>Le service d'administration est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service d'administration est <b>rép_install_mfp/MobileFirstServer/mfp-admin-service.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpadmin</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous pouvez définir des propriétés JNDI depuis la console d'administration WebSphere Application Server. Sélectionnez <b>Applications → Types d'application → Applications d'entreprise WebSphere → nom_application → Entrées d'environnement pour les modules Web</b> et définissez les entrées.</p>

                <p>Pour activer la communication JMX avec l'environnement d'exécution, définissez les propriétés JNDI suivantes :</p>

                <b>Sur WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b></li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - Port SOAP sur le gestionnaire de déploiement.</li>
                    <li><b>mfp.topology.platform</b> - Définissez la valeur <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - Définissez la valeur <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - Définissez la valeur <b>SOAP</b>.</li>
                </ul>

                <b>Sur un serveur WebSphere Application Server autonome</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - Définissez la valeur <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - Définissez la valeur <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - Définissez la valeur <b>SOAP</b>.</li>
                </ul>

                <p>Si le service push est installé, vous devez configurer les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.admin.push.url</b></li>
                    <li><b>mfp.admin.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.admin.authorization.client.id</b></li>
                    <li><b>mfp.admin.authorization.client.secret</b></li>
                </ul>
                <p>Les propriétés JNDI pour la communication avec le service de configuration sont les suivantes :</p>
                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service">Liste des propriétés JNDI pour le service d'administration de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Source de données</h3>
                <p>Créez une source de données pour le service d'administration et mappez-la à <b>jdbc/mfpAdminDS</b>.</p>

                <h3>Ordre de lancement</h3>
                <p>L'application de service d'administration doit démarrer avant l'application d'environnement d'exécution. Vous pouvez définir l'ordre dans la section <b>Comportement de lancement</b>. Par exemple, définissez l'ordre de lancement <b>1</b> pour le service d'administration et <b>2</b> pour l'environnement d'exécution.</p>

                <h3>Rôles de sécurité</h3>
                <p>Les rôles de sécurité disponibles pour l'application de service d'administration sont :</p>
                <ul>
                    <li>mfpadmin</li>
                    <li>mfpdeployer</li>
                    <li>mfpmonitor</li>
                    <li>mfpoperator</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="live-update-service-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-live-update-service-nd" aria-expanded="true" aria-controls="collapse-live-update-service-nd"><b>Détails de configuration du service Live Update de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-live-update-service-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="live-update-service-nd">
            <div class="panel-body">
                <p>Le service Live Update est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR du service Live Update est <b>rép_install_mfp/MobileFirstServer/mfp-live-update.war</b>. La racine de contexte du service Live Update doit être définie comme suit : <b>/racine-contexteadmin/config</b>. Par exemple, si la racine de contexte du service d'administration est <b>/mfpadmin</b>, la racine de contexte du service Live Update doit être <b>/mfpadminconfig</b>.</p>

                <h3>Source de données</h3>
                <p>Créez une source de données pour le service Live Update et mappez-la à <b>jdbc/ConfigDS</b>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Le rôle <b>configadmin</b> est défini pour cette application.
                <br/><br/>
                Un utilisateur au moins doit être mappé à ce rôle. L'utilisateur et son mot de passe doivent être fournis dans les propriétés JNDI suivantes du service d'administration :</p>

                <ul>
                    <li><b>mfp.config.service.user</b></li>
                    <li><b>mfp.config.service.password</b></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="console-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-console-configuration-nd" aria-expanded="true" aria-controls="collapse-console-configuration-nd"><b>Détails de configuration de {{ site.data.keys.mf_console }}</b></a>
            </h4>
        </div>

        <div id="collapse-console-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="console-configuration-nd">
            <div class="panel-body">
                <p>La console est conditionnée sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications.
                <br/><br/>Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de la console est <b>rép_install_mfp/MobileFirstServer/mfp-admin-ui.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit généralement de <b>/mfpconsole</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous pouvez définir des propriétés JNDI depuis la console d'administration WebSphere Application Server. Sélectionnez <b>Applications → Types d'application → Applications d'entreprise WebSphere → nom_application → Entrées d'environnement pour les modules Web</b> et définissez les entrées.
                <br/><br/>
                Vous devez définir la propriété <b>mfp.admin.endpoint</b>. En général, la valeur de cette propriété est <b>*://*:*/racine-contexteadmin</b>.
                <br/><br/>
                Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#jndi-properties-for-mobilefirst-operations-console">Propriétés JNDI pour {{ site.data.keys.mf_console }}</a>.</p>

                <h3>Rôles de sécurité</h3>
                <p>Les rôles de sécurité disponibles pour l'application sont :</p>
                <ul>
                    <li><b>mfpadmin</b></li>
                    <li><b>mfpdeployer</b></li>
                    <li><b>mfpmonitor</b></li>
                    <li><b>mfpoperator</b></li>
                </ul>
                Tout utilisateur mappé à un rôle de sécurité de la console doit également être mappé au même rôle de sécurité du service d'administration.
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="runtime-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-runtime-configuration-nd" aria-expanded="true" aria-controls="collapse-runtime-configuration-nd"><b>Détails de configuration de l'environnement d'exécution de MobileFirst</b></a>
            </h4>
        </div>

        <div id="collapse-runtime-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="runtime-configuration-nd">
            <div class="panel-body">
                <p>L'environnement d'exécution est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b>.
                <br/><br/>
                Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.
                <br/><br/>
                Le fichier WAR de l'environnement d'exécution est <b>rép_install_mfp/MobileFirstServer/mfp-server.war</b>. Vous pouvez définir la racine de contexte de votre choix. Toutefois, il s'agit par défaut de <b>/mfp</b>.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous pouvez définir des propriétés JNDI depuis la console d'administration WebSphere Application Server. Sélectionnez <b>Applications → Types d'application → Applications d'entreprise WebSphere → nom_application → Entrées d'environnement pour les modules Web</b> et définissez les entrées.</p>

                <p>Vous devez définir la propriété <b>mfp.authorization.server</b> avec la valeur intégrée.<br/>
                De même, définissez les propriétés JNDI ci-dessous pour permettre la communication JMX avec le service d'administration :</p>

                <b>Sur WebSphere Application Server Network Deployment</b>
                <ul>
                    <li><b>mfp.admin.jmx.dmgr.host</b> - Nom d'hôte du gestionnaire de déploiement.</li>
                    <li><b>mfp.admin.jmx.dmgr.port</b> - Port SOAP du gestionnaire de déploiement.</li>
                    <li><b>mfp.topology.platform</b> - Définissez la valeur <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - Définissez la valeur <b>Cluster</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - Définissez la valeur <b>SOAP</b>.</li>
                </ul>

                <b>Sur un serveur WebSphere Application Server autonome</b>
                <ul>
                    <li><b>mfp.topology.platform</b> - Définissez la valeur <b>WAS</b>.</li>
                    <li><b>mfp.topology.clustermode</b> - Définissez la valeur <b>Standalone</b>.</li>
                    <li><b>mfp.admin.jmx.connector</b> - Définissez la valeur <b>SOAP</b>.</li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} est installé, vous devez définir les propriétés JNDI suivantes :</p>
                <ul>   
                    <li><b>mfp.analytics.url</b></li>
                    <li><b>mfp.analytics.console.url</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                </ul>

                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-runtime">Liste des propriétés JNDI pour l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</p>

                <h3>Ordre de lancement</h3>
                <p>L'application d'environnement d'exécution doit démarrer après l'application de service d'administration. Vous pouvez définir l'ordre dans la section <b>Comportement de lancement</b>. Par exemple, définissez l'ordre de lancement <b>1</b> pour le service d'administration et <b>2</b> pour l'environnement d'exécution.</p>

                <h3>Source de données</h3>
                <p>Créez une source de données pour l'environnement d'exécution et mappez-la à <b>jdbc/mfpDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="push-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-push-configuration-nd" aria-expanded="true" aria-controls="collapse-push-configuration-nd"><b>Détails de configuration du service push de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-push-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="push-configuration-nd">
            <div class="panel-body">
                <p>Le service push est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.    
                <br/><br/>
                Le fichier WAR du service push est <b>rép_install_mfp/PushService/mfp-push-service.war</b>. Vous devez définir la racine de contexte <b>/imfpush</b>. Sinon, les appareils client ne pourront pas se connecter au service car la racine de contexte est codée en dur dans le logiciel SDK.</p>

                <h3>Propriétés JNDI obligatoires</h3>
                <p>Vous pouvez définir des propriétés JNDI depuis la console d'administration WebSphere Application Server. Sélectionnez <b>Applications → Types d'application → Applications d'entreprise WebSphere → nom_application → Entrées d'environnement pour les modules Web</b> et définissez les entrées.</p>

                <p>Vous devez définir les propriétés suivantes :</p>
                <ul>
                    <li><b>mfp.push.authorization.server.url</b></li>
                    <li><b>mfp.push.authorization.client.id</b></li>
                    <li><b>mfp.push.authorization.client.secret</b></li>
                    <li><b>mfp.push.services.ext.security</b> - La valeur doit être <b>com.ibm.mfp.push.server.security.plugin.OAuthSecurityPlugin</b>.</li>
                    <li><b>mfp.push.db.type</b> - Pour une base de données relationnelle, la valeur doit être DB.</li>
                </ul>

                <p>Si {{ site.data.keys.mf_analytics }} est configuré, définissez les propriétés JNDI suivantes :</p>
                <ul>
                    <li><b>mfp.push.analytics.endpoint</b></li>
                    <li><b>mfp.analytics.username</b></li>
                    <li><b>mfp.analytics.password</b></li>
                    <li><b>mfp.push.services.ext.analytics</b> - La valeur doit être <b>com.ibm.mfp.push.server.analytics.plugin.AnalyticsPlugin</b>.</li>
                </ul>
                <p>Pour plus d'informations sur les propriétés JNDI, voir <a href="../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service">Liste des propriétés JNDI pour le service push de {{ site.data.keys.mf_server }}</a>.</p>

                <h3>Source de données</h3>
                <p>Créez la source de données pour le service push et mappez-la à <b>jdbc/imfPushDS</b>.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="artifacts-configuration-nd">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#manual-installation-nd" href="#collapse-artifacts-configuration-nd" aria-expanded="true" aria-controls="collapse-artifacts-configuration-nd"><b>Détails de configuration des artefacts de {{ site.data.keys.mf_server }}</b></a>
            </h4>
        </div>

        <div id="collapse-artifacts-configuration-nd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="artifacts-configuration-nd">
            <div class="panel-body">
                <p>Le composant des artefacts est conditionné sous forme d'application WAR en vue de son déploiement sur le serveur d'applications. Vous devez effectuer des configurations spécifiques pour cette application dans le fichier <b>server.xml</b> du serveur d'applications. Avant de continuer, consultez la section <a href="#manual-installation-on-websphere-application-server-and-websphere-application-server-network-deployment">Installation manuelle sur WebSphere Application Server et WebSphere Application Server Network Deployment</a> pour prendre connaissance des détails de configuration communs à tous les services.</p>

                <p>Le fichier WAR pour ce composant est <b>rép_install_mfp/MobileFirstServer/mfp-dev-artifacts.war</b>. Vous devez définir la racine de contexte <b>/mfp-dev-artifacts</b>.</p>
            </div>
        </div>
    </div>
</div>

## Installation d'un parc de serveurs
{: #installing-a-server-farm }
Vous pouvez installer votre parc de serveurs en exécutant des tâches Ant, avec l'outil de configuration de serveur ou manuellement.

* [Planification de la configuration d'un parc de serveurs](#planning-the-configuration-of-a-server-farm)
* [Installation d'un parc de serveurs avec l'outil de configuration de serveur](#installing-a-server-farm-with-the-server-configuration-tool)
* [Installation d'un parc de serveurs à l'aide de tâches Ant](#installing-a-server-farm-with-ant-tasks)
* [Configuration manuelle d'un parc de serveurs](#configuring-a-server-farm-manually)
* [Vérification de la configuration du parc de serveurs](#verifying-a-farm-configuration)
* [Cycle de vie d'un noeud de parc de serveurs](#lifecycle-of-a-server-farm-node)

### Planification de la configuration d'un parc de serveurs
{: #planning-the-configuration-of-a-server-farm }
Pour planifier la configuration d'un parc de serveurs, choisissez le serveur d'applications, configurez les bases de données {{ site.data.keys.product_adj }}, et déployez les fichiers WAR des composants {{ site.data.keys.mf_server }} sur chaque serveur du parc de serveurs. Vous pouvez utiliser l'outil de configuration de serveur, des tâches Ant ou des opérations manuelles afin de configurer un parc de serveurs.

Si vous prévoyez d'installer un parc de serveurs, reportez-vous d'abord à [Contraintes sur le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de MobileFirst](../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime), et en particulier à [Topologie de parc de serveurs](../topologies/#server-farm-topology).

Dans {{ site.data.keys.product }}, un parc de serveurs se compose de plusieurs serveurs d'applications autonomes qui ne sont pas fédérés ni administrés par le composant de gestion d'un serveur d'applications. {{ site.data.keys.mf_server }} fournit en interne un plug-in de parc de serveurs afin d'améliorer le serveur d'applications de sorte qu'il puisse faire partie d'un parc de serveurs.

#### Quand déclarer un parc de serveurs ?
{: #when-to-declare-a-server-farm }
**Déclarez un parc de serveurs dans les cas suivants :**

* {{ site.data.keys.mf_server }} est installé sur plusieurs serveurs d'applications Tomcat.
* {{ site.data.keys.mf_server }} est installé sur plusieurs serveurs WebSphere Application Server, mais pas sur WebSphere Application Server Network Deployment.
* {{ site.data.keys.mf_server }} est installé sur plusieurs serveurs WebSphere Application Server Liberty.

**Ne déclarez pas de parc de serveurs dans les cas suivants :**

* Votre serveur d'applications est autonome.
* Plusieurs serveurs d'applications sont fédérés par WebSphere Application Server Network Deployment.

#### Eléments obligatoires pour déclarer un parc de serveurs
{: #why-it-is-mandatory-to-declare-a-farm }
A chaque fois qu'une opération de gestion est effectuée par le biais de {{ site.data.keys.mf_console }} ou de l'application de service d'administration de {{ site.data.keys.mf_server }}, elle doit être répliquée sur toutes les instances d'un environnement d'exécution. Par exemple, il peut s'agir d'une opération de gestion telle que le téléchargement d'une nouvelle version d'une application ou d'un adaptateur. La réplication est assurée via des appels JMX effectués par l'instance d'application de service d'administration qui gère l'opération. Le service d'administration doit contacter toutes les instances d'exécution dans le cluster. Dans les environnements répertoriés sous **Quand déclarer un parc de serveurs ?** ci-dessus, l'environnement d'exécution peut être contacté via JMX seulement si un parc de serveurs est configuré. Si un serveur est ajouté à un cluster alors qu'un parc de serveurs n'est pas configuré correctement, l'état de l'environnement d'exécution sur ce serveur sera incohérent après chaque opération de gestion et jusqu'à ce que l'environnement d'exécution soit redémarré.

### Installation d'un parc de serveurs avec l'outil de configuration de serveur
{: #installing-a-server-farm-with-the-server-configuration-tool }
Utilisez l'outil de configuration de serveur pour configurer chaque serveur du parc de serveurs conformément aux exigences du type unique de serveur d'applications qui est utilisé pour chaque membre du parc de serveurs.

Lorsque vous planifiez un parc de serveurs avec l'outil de configuration de serveur, créez d'abord des serveurs autonomes et configurez leurs magasins de clés de confiance respectifs de sorte qu'ils puissent communiquer les uns avec les autres de façon sécurisée. Ensuite, exécutez l'outil qui effectue les opérations suivantes :

* Configuration de l'instance de base de données qui est partagée par les composants {{ site.data.keys.mf_server }}
* Déploiement des composants {{ site.data.keys.mf_server }} sur chaque serveur
* Modification de la configuration du serveur pour qu'il devienne membre d'un parc de serveurs

<div class="panel-group accordion" id="installing-mobilefirst-server-ct" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ct">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ct" aria-expanded="true" aria-controls="collapse-server-farm-ct"><b>Cliquez ici pour afficher des instructions d'installation d'un parc de serveurs avec l'outil de configuration de serveur</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ct" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ct">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiert la configuration de la connexion JMX sécurisée.</p>

                <ol>
                    <li>Préparez les serveurs d'applications qui doivent être configurés en tant que membres du parc de serveurs.
                        <ul>
                            <li>Choisissez le type de serveur d'applications à utiliser pour configurer les membres du parc de serveurs. {{ site.data.keys.product }} prend en charge les serveurs d'applications suivants dans les parcs de serveurs :
                                <ul>
                                    <li>Profil complet de WebSphere Application Server<br/>
                                    <b>Remarque :</b> dans une topologie de parc de serveurs, vous ne pouvez pas utiliser le connecteur JMX RMI. Dans ce type de topologie, le connecteur SOAP seulement est pris en charge par {{ site.data.keys.product }}.</li>
                                    <li>Profil Liberty de WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Pour prendre connaissance des versions des serveurs d'applications prises en charge, voir <a href="../../../../product-overview/requirements">Configuration système requise</a>.

                                <blockquote><b>Important :</b> {{ site.data.keys.product }} ne prend en charge que des parcs de serveurs homogènes. Un parc de serveurs est homogène lorsqu'il connecte le même type de serveur d'applications. Si vous tentez d'associer des types différents de serveur d'applications, le comportement à l'exécution risque d'être imprévisible. Par exemple, un parc de serveurs comportant un mélange de serveurs Apache Tomcat et de serveurs WebSphere Application Server (profil complet) constitue une configuration non valide.</blockquote>
                            </li>
                            <li>Configurez autant de serveurs autonomes que vous voulez de membres dans le parc de serveurs.
                                <ul>
                                    <li>Chacun de ces serveurs autonomes doit communiquer avec la même base de données. Vous devez vous assurer qu'aucun port utilisé par l'un de ces serveurs n'est utilisé par ailleurs par un autre serveur configuré sur le même hôte. Cette contrainte concerne les ports utilisés par les protocoles HTTP, HTTPS, REST, SOAP et RMI.</li>
                                    <li>Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et un ou plusieurs environnements d'exécution de {{ site.data.keys.product_adj }} doivent être déployés sur chacun de ces serveurs.</li>
                                    <li>Pour plus d'informations sur la configuration d'un serveur, voir <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Contraintes sur le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</li>
                                </ul>
                            </li>
                            <li>Echangez les certificats de signataire entre tous les serveurs dans leurs magasins de clés de confiance respectifs.
                            <br/><br/>
                            Cette étape est obligatoire pour les parcs de serveurs qui utilise le profil complet de WebSphere Application Server ou Liberty doit être activé. De plus, pour les parcs de serveurs Liberty, la même configuration LTPA doit être répliquée sur chaque serveur afin d'activer la fonction de connexion unique. Pour effectuer cette configuration, suivez les instructions présentées à l'étape 6 de la section <a href="#configuring-a-server-farm-manually">Configuration manuelle d'un parc de serveurs</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Exécutez l'outil de configuration de serveur pour chaque serveur du parc de serveurs. Tous les serveurs doivent partager les mêmes bases de données. Assurez-vous de sélectionner le type de déploiement <b>Server farm deployment</b> dans le panneau <b>Application Server Settings</b>. Pour plus d'informations sur l'outil, voir <a href="#running-the-server-configuration-tool">Exécution de l'outil de configuration de serveur</a>.
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Installation d'un parc de serveurs à l'aide de tâches Ant
{: #installing-a-server-farm-with-ant-tasks }
Utilisez des tâches Ant pour configurer chaque serveur du parc de serveurs conformément aux exigences du type unique de serveur d'applications qui est utilisé pour chaque membre du parc de serveurs.

Lorsque vous planifiez un parc de serveurs à l'aide de tâches Ant, créez d'abord des serveurs autonomes et configurez leurs magasins de clés de confiance respectifs de sorte qu'ils puissent communiquer les uns avec les autres de façon sécurisée. Ensuite, exécutez des tâches Ant pour configurer l'instance de base de données qui est partagée par les composants {{ site.data.keys.mf_server }}. Enfin, exécutez des tâches Ant pour déployer les composants {{ site.data.keys.mf_server }} sur chaque serveur et modifier la configuration des serveurs pour qu'ils deviennent membres d'un parc de serveurs.

<div class="panel-group accordion" id="installing-mobilefirst-server-ant" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="server-farm-ant">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#server-farm-ct" href="#collapse-server-farm-ant" aria-expanded="true" aria-controls="collapse-server-farm-ant"><b>Cliquez ici pour afficher des instructions d'installation d'un parc de serveurs à l'aide de tâches Ant</b></a>
            </h4>
        </div>

        <div id="collapse-server-farm-ant" class="panel-collapse collapse" role="tabpanel" aria-labelledby="server-farm-ant">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} requiert la configuration de la connexion JMX sécurisée.</p>

                <ol>
                    <li>Préparez les serveurs d'applications qui doivent être configurés en tant que membres du parc de serveurs.
                        <ul>
                            <li>Choisissez le type de serveur d'applications à utiliser pour configurer les membres du parc de serveurs. {{ site.data.keys.product }} prend en charge les serveurs d'applications suivants dans les parcs de serveurs :
                                <ul>
                                    <li>Profil complet de WebSphere Application Server. <b>Remarque :</b> dans une topologie de parc de serveurs, vous ne pouvez pas utiliser le connecteur JMX RMI. Dans ce type de topologie, le connecteur SOAP seulement est pris en charge par {{ site.data.keys.product }}.</li>
                                    <li>Profil Liberty de WebSphere Application Server</li>
                                    <li>Apache Tomcat</li>
                                </ul>
                                Pour prendre connaissance des versions des serveurs d'applications prises en charge, voir <a href="../../../../product-overview/requirements">Configuration système requise</a>.

                                <blockquote><b>Important :</b> {{ site.data.keys.product }} ne prend en charge que des parcs de serveurs homogènes. Un parc de serveurs est homogène lorsqu'il connecte le même type de serveur d'applications. Si vous tentez d'associer des types différents de serveur d'applications, le comportement à l'exécution risque d'être imprévisible. Par exemple, un parc de serveurs comportant un mélange de serveurs Apache Tomcat et de serveurs WebSphere Application Server (profil complet) constitue une configuration non valide.</blockquote>
                            </li>
                            <li>Configurez autant de serveurs autonomes que vous voulez de membres dans le parc de serveurs.
                            <br/><br/>
                            Chacun de ces serveurs autonomes doit communiquer avec la même base de données. Vous devez vous assurer qu'aucun port utilisé par l'un de ces serveurs n'est utilisé par ailleurs par un autre serveur configuré sur le même hôte. Cette contrainte concerne les ports utilisés par les protocoles HTTP, HTTPS, REST, SOAP et RMI.
                            <br/><br/>
                            Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et un ou plusieurs environnements d'exécution de {{ site.data.keys.product_adj }} doivent être déployés sur chacun de ces serveurs.
                            <br/><br/>
                            Pour plus d'informations sur la configuration d'un serveur, voir <a href="../topologies/#constraints-on-mobilefirst-server-administration-service-mobilefirst-server-live-update-service-and-mobilefirst-foundation-runtime">Contraintes sur le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et l'environnement d'exécution de {{ site.data.keys.product_adj }}</a>.</li>
                            <li>Echangez les certificats de signataire entre tous les serveurs dans leurs magasins de clés de confiance respectifs.
                            <br/><br/>
                            Cette étape est obligatoire pour les parcs de serveurs qui utilise le profil complet de WebSphere Application Server ou Liberty doit être activé. De plus, pour les parcs de serveurs Liberty, la même configuration LTPA doit être répliquée sur chaque serveur afin d'activer la fonction de connexion unique. Pour effectuer cette configuration, suivez les instructions présentées à l'étape 6 de la section <a href="#configuring-a-server-farm-manually">Configuration manuelle d'un parc de serveurs</a>.
                            </li>
                        </ul>
                    </li>
                    <li>Configurez la base de données pour le service d'administration, le service Live Update et l'environnement d'exécution.
                        <ul>
                            <li>Choisissez la base de données à utiliser ainsi que le fichier Ant permettant de créer et de configurer la base de données dans le répertoire <b>rép_install_mfp/MobileFirstServer/configuration-samples</b> :
                                <ul>
                                    <li>Pour DB2 , utilisez <b>create-database-db2.xml</b>.</li>
                                    <li>Pour MySQL, utilisez <b>create-database-mysql.xml</b>.</li>
                                    <li>Pour Oracle, utilisez <b>create-database-oracle.xml</b>.</li>
                                </ul>
                                <blockquote>Remarque : n'utilisez pas la base de données Derby dans une topologie de parc de serveurs car elle n'autorise qu'une seule connexion à la fois.</blockquote>

                            </li>
                            <li>Editez le fichier Ant et entrez toutes les propriétés requises pour la base de données.
                            <br/><br/>
                            Pour activer la configuration de la base de données utilisée par les composants {{ site.data.keys.mf_server }}, définissez les valeurs des propriétés suivantes :
                                <ul>
                                    <li>Associez <b>mfp.process.admin</b> à la valeur <b>true</b> afin de configurer la base de données pour le service d'administration et le service Live Update.</li>
                                    <li>Associez <b>mfp.process.runtime</b> à la valeur <b>true</b> afin de configurer la base de données pour l'environnement d'exécution.</li>
                                </ul>
                            </li>
                            <li>Exécutez les commandes ci-dessous depuis le répertoire <b>rép_install_mfp/MobileFirstServer/configuration-samples</b> où <b>fichier-ant-création-base-données.xml</b> doit être remplacé par le nom de fichier Ant réel de votre choix : <code>rép_install_mfp/shortcuts/ant -f fichier-ant-création-base-données.xml admdatabases</code> et <code>rép_install_mfp/shortcuts/ant -f fichier-ant-création-base-données.xml rtmdatabases</code>.
                            <br/><br/>
                            Comme les bases de données {{ site.data.keys.mf_server }} sont partagées entre les serveurs d'application dans un parc de serveurs, ces deux commandes ne doivent être exécutées qu'une seule fois, quel que soit le nombre de serveurs dans le parc de serveurs.
                            </li>
                            <li>Si vous voulez installer un autre environnement d'exécution, vous devez configurer une autre base de données avec un autre nom ou un autre schéma de base de données. Pour ce faire, éditez le fichier Ant, modifiez les propriétés et exécutez la commande suivante une seule fois, quel que soit le nombre de serveurs dans le parc de serveurs : <code>rép_install_mfp/shortcuts/ant -f fichier-ant-création-base-données.xml rtmdatabases</code>.</li>
                        </ul>
                    </li>
                    <li>Déployez le service d'administration, le service Live Update et l'environnement d'exécution sur les serveurs et configurez ces serveurs comme membres d'un parc de serveurs.
                        <ul>
                            <li>Choisissez le fichier Ant qui correspond à votre serveur d'applications et à votre base de données dans le répertoire <b>rép\_install\_mfp/MobileFirstServer/configuration-samples</b> afin de déployer le service d'administration, le service Live Update et l'environnement d'exécution sur les serveurs.
                            <br/><br/>
                            Par exemple, sélectionnez le fichier <b>configure-liberty-db2.xml</b> pour un déploiement sur le serveur Liberty avec la base de données DB2. Effectuez autant de copies de ce fichier que vous voulez de membres dans le parc de serveurs.
                            <br/><br/>
                            <b>Remarque :</b> Conservez ces fichiers après la configuration, car ils peuvent être réutilisés pour la mise à niveau des composants {{ site.data.keys.mf_server }} déjà déployés ou pour les désinstaller sur chaque membre du parc de serveurs.</li>
                            <li>Editez chaque copie du fichier Ant, entrez les propriétés de base de données indiquées à l'étape 2, et entrez également les autres propriétés requises pour le serveur d'applications.
                            <br/><br/>
                            Pour configurer le serveur comme membre d'un parc de serveurs, définissez les valeurs des propriétés suivantes :
                                <ul>
                                    <li>Associez <b>mfp.farm.configure</b> à la valeur true.</li>
                                    <li><b>mfp.farm.server.id</b> : identificateur que vous définissez pour ce membre de parc de serveurs. Veillez à ce que chaque serveur dans le parc de serveurs possède un identificateur unique. Si deux serveurs dans le parc de serveurs possèdent le même identificateur, le comportement du parc de serveurs risque d'être imprévisible.</li>
                                    <li><b>mfp.config.service.user</b> : nom d'utilisateur indiqué pour accéder au service Live Update. Il doit être identique pour tous les membres du parc de serveurs.</li>
                                    <li><b>mfp.config.service.password</b> : mot de passe indiqué pour accéder au service Live Update. Il doit être identique pour tous les membres du parc de serveurs.</li>
                                </ul>
                                Pour permettre le déploiement des fichiers WAR des composants {{ site.data.keys.mf_server }} sur le serveur, définissez les valeurs des propriétés suivantes :
                                    <ul>
                                        <li>Associez <b>mfp.process.admin</b> à la valeur <b>true</b> pour déployer les fichiers WAR du service d'administration et du service Live Update.</li>
                                        <li>Associez <b>mfp.process.runtime</b> à la valeur <b>true</b> pour déployer le fichier WAR de l'environnement d'exécution.</li>
                                    </ul>
                                <br/>
                                <b>Remarque :</b> Si vous envisagez d'installer plusieurs exécutions sur les serveurs du parc de serveurs, spécifiez le l'ID d'attribut et définissez une valeur qui doit être unique pour chaque exécution dans les tâches Ant <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> et <b>uninstallmobilefirstruntime</b>.
                                <br/>
                                Par exemple,
{% highlight xml %}
<target name="rtminstall">
    <installmobilefirstruntime execute="true" contextroot="/runtime1" id="rtm1">
{% endhighlight %}
                            </li>
                            <li>Pour chaque serveur, exécutez les commandes ci-dessous, où <b>fichier-ant-configuration-base-données-serveur-app.xml</b> doit être remplacé par le nom de fichier Ant réel de votre choix : <code>rép_install_mfp/shortcuts/ant -f fichier-ant-configuration-base-données-serveur-app.xml adminstall</code> et <code>rép_install_mfp/shortcuts/ant -f fichier-ant-configuration-base-données-serveur-app.xml rtminstall</code>.
                            <br/><br/>
                            Ces commandes exécutent les tâches Ant <b>installmobilefirstadmin</b> et <b>installmobilefirstruntime</b>. Pour plus d'informations sur ces tâches, voir <a href="../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services">Tâches Ant pour l'installation de {{ site.data.keys.mf_console }}, des artefacts de {{ site.data.keys.mf_server }} et des services d'administration et Live Update de {{ site.data.keys.mf_server }}</a> et <a href="../../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments">Tâches Ant pour l'installation des environnements d'exécution de {{ site.data.keys.product_adj }}</a>.
                            </li>
                            <li>Si vous voulez installer un autre environnement d'exécution, procédez comme suit :
                                <ul>
                                    <li>Effectuez une copie du fichier Ant que vous avez configuré à l'étape 3.b.</li>
                                    <li>Editez la copie, définissez une racine de contexte distincte et définissez une valeur pour l'attribut <b>id</b> de <b>installmobilefirstruntime</b>, <b>updatemobilefirstruntime</b> et <b>uninstallmobilefirstruntime</b> qui est différente de celle définie dans l'autre configuration d'environnement d'exécution.</li>
                                    <li>Exécutez la commande suivante sur chaque serveur du parc de serveurs où <b>fichier_ant_configuration_base_données_serveur_app2.xml</b> doit être remplacé par le nom réel du fichier Ant qui est édité : <code>rép_install_mfp/shortcuts/ant -f >fichier_ant_configuration_base_données_serveur_app2.xml rtminstall</code>.</li>
                                    <li>Répétez cette étape pour chaque serveur du parc de serveurs.</li>
                                </ul>
                            </li>                            
                        </ul>
                    </li>
                    <li>Redémarrez tous les serveurs.</li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Configuration manuelle d'un parc de serveurs
{: #configuring-a-server-farm-manually }
Vous devez configurer chaque serveur du parc de serveurs conformément aux exigences du type unique de serveur d'applications qui est utilisé pour chaque membre du parc de serveurs.

Lorsque vous planifiez un parc de serveurs, créez d'abord des serveurs autonomes qui communiquent avec la même instance de base de données. Ensuite, modifiez la configuration de ces serveurs pour qu'ils deviennent membres d'un parc de serveurs.

<div class="panel-group accordion" id="configuring-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="manual">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#websphere-prereq" href="#collapse-manual" aria-expanded="true" aria-controls="collapse-manual"><b>Cliquez ici pour afficher des instructions de configuration manuelle d'un parc de serveurs</b></a>
            </h4>
        </div>

        <div id="collapse-manual" class="panel-collapse collapse" role="tabpanel" aria-labelledby="manual">
            <div class="panel-body">
                <ol>
                    <li>Choisissez le type de serveur d'applications à utiliser pour configurer les membres du parc de serveurs. {{ site.data.keys.product }} prend en charge les serveurs d'applications suivants dans les parcs de serveurs :
                        <ul>
                            <li>Profil complet de WebSphere Application Server<br/>
                            <b>Remarque :</b> dans une topologie de parc de serveurs, vous ne pouvez pas utiliser le connecteur JMX RMI. Dans ce type de topologie, le connecteur SOAP seulement est pris en charge par {{ site.data.keys.product }}.</li>
                            <li>Profil Liberty de WebSphere Application Server</li>
                            <li>Apache Tomcat</li>
                        </ul>
                        Pour prendre connaissance des versions des serveurs d'applications prises en charge, voir <a href="../../../../product-overview/requirements">Configuration système requise</a>.

                        <blockquote><b>Important :</b> {{ site.data.keys.product }} ne prend en charge que des parcs de serveurs homogènes. Un parc de serveurs est homogène lorsqu'il connecte le même type de serveur d'applications. Si vous tentez d'associer des types différents de serveur d'applications, le comportement à l'exécution risque d'être imprévisible. Par exemple, un parc de serveurs comportant un mélange de serveurs Apache Tomcat et de serveurs WebSphere Application Server (profil complet) constitue une configuration non valide.</blockquote>
                    </li>
                    <li>Choisissez la base de données à utiliser. Vous pouvez choisir :
                        <ul>
                            <li>DB2 </li>
                            <li>MySQL</li>
                            <li>Oracle</li>
                        </ul>
                        Les bases de données {{ site.data.keys.mf_server }} sont partagées entre les serveurs d'applications d'un parc de serveurs, ce qui signifie que :
                        <ul>
                            <li>Vous ne créez la base de données qu'une fois, quel que soit le nombre de serveurs dans le parc de serveurs.</li>
                            <li>Vous ne pouvez pas utiliser la base de données Derby dans une topologie de parc de serveurs car elle n'autorise qu'une seule connexion à la fois.</li>
                        </ul>
                        Pour plus d'informations sur les bases de données, voir <a href="../databases">Configuration des bases de données</a>.
                    </li>
                    <li>Configurez autant de serveurs autonomes que vous voulez de membres dans le parc de serveurs.
                        <ul>
                            <li>Chacun de ces serveurs autonomes doit communiquer avec la même base de données. Vous devez vous assurer qu'aucun port utilisé par l'un de ces serveurs n'est utilisé par ailleurs par un autre serveur configuré sur le même hôte. Cette contrainte concerne les ports utilisés par les protocoles HTTP, HTTPS, REST, SOAP et RMI.</li>
                            <li>Le service d'administration de {{ site.data.keys.mf_server }}, le service Live Update de {{ site.data.keys.mf_server }} et un ou plusieurs environnements d'exécution de {{ site.data.keys.product_adj }} doivent être déployés sur chacun de ces serveurs.</li>
                            <li>Lorsque chacun de ces serveurs fonctionne correctement dans une topologie autonome, vous pouvez les transformer en membres d'un parc de serveurs.</li>
                        </ul>
                    </li>
                    <li>Arrêtez tous les serveurs devant devenir membres du parc de serveurs.</li>
                    <li>Configurez chaque serveur de façon appropriée pour le type de serveur d'application.<br/>Vous devez définir correctement certaines propriétés JNDI. Dans une topologie de parc de serveurs, les valeurs des propriétés JNDI mfp.config.service.user et mfp.config.service.password doivent être identiques pour tous les membres du parc de serveurs. Pour Apache Tomcat, vous devez aussi vérifier que les arguments JVM sont définis correctement.
                        <ul>
                            <li><b>Profil Liberty de WebSphere Application Server</b>
                                <br/>
                                Dans le fichier server.xml, définissez les propriétés JNDI affichées dans l'exemple de code ci-dessous.
{% highlight xml %}
<jndiEntry jndiName="mfp.topology.clustermode" value="Farm"/>
<jndiEntry jndiName="mfp.admin.serverid" value="membre_parc_1"/>
<jndiEntry jndiName="mfp.admin.jmx.user" value="monUtilisateurConnecteurREST"/>
<jndiEntry jndiName="mfp.admin.jmx.pwd" value="motdepasse-utilisateur-connecteur-rest"/>
<jndiEntry jndiName="mfp.admin.jmx.host" value="93.12.0.12"/>
<jndiEntry jndiName="mfp.admin.jmx.port" value="9443"/>
{% endhighlight %}
                                Ces propriétés doivent être associées à des valeurs appropriées :
                                <ul>
                                    <li><b>mfp.admin.serverid</b> : identificateur que vous avez défini pour ce membre de parc de serveurs. Cet identificateur doit être unique parmi tous les membres du parc de serveurs.</li>
                                    <li><b>mfp.admin.jmx.user</b> et <b>mfp.admin.jmx.pwd</b> : ces valeurs doivent correspondre aux données d'identification d'un utilisateur telles que déclarées dans l'élément <code>administrator-role</code>.</li>
                                    <li><b>mfp.admin.jmx.host</b> : pour ce paramètre, définissez l'adresse IP ou le nom d'hôte qui est utilisé par les membres distants pour accéder à ce serveur. Vous ne pouvez donc pas indiquer <b>localhost</b>. Ce nom d'hôte est utilisé par les autres membres du parc de serveurs et doit être accessible pour tous les membres du parc de serveurs.</li>
                                    <li><b>mfp.admin.jmx.port</b> : pour ce paramètre, définissez le port HTTPS du serveur qui est utilisé pour la connexion REST JMX. La valeur se trouve dans l'élément <code>httpEndpoint</code> du fichier <b>server.xml</b>.</li>
                                </ul>
                            </li>
                            <li><b>Apache Tomcat</b>
                                <br/>
                                Modifiez le fichier <b>conf/server.xml</b> pour définir les propriétés JNDI ci-dessous dans le contexte de service d'administration et dans chaque contexte d'exécution.
{% highlight xml %}
<Environment name="mfp.topology.clustermode" value="Farm" type="java.lang.String" override="false"/>
<Environment name="mfp.admin.serverid" value="membre_parc_1" type="java.lang.String" override="false"/>
{% endhighlight %}
                                La propriété <b>mfp.admin.serverid</b> doit avoir pour valeur l'identificateur que vous avez défini pour ce membre de parc de serveurs. Cet identificateur doit être unique parmi tous les membres du parc de serveurs.
                                <br/>
                                Vous devez vous assurer que l'argument JVM <code>-Djava.rmi.server.hostname</code> est défini sur l'adresse IP ou le nom d'hôte utilisé par les membres distants pour accéder à ce serveur. Vous ne pouvez donc pas indiquer <b>localhost</b>. De plus, assurez-vous que l'argument JVM <code>-Dcom.sun.management.jmxremote.port</code> ait pour valeur un port qui n'est pas déjà utilisé pour activer les connexions JMX RMI. Les deux arguments sont définis dans la variable d'environnement <b>CATALINA_OPTS</b>.
                            </li>
                            <li><b>Profil complet de WebSphere Application Server</b>
                                <br/>
                                Vous devez déclarer les propriétés JNDI suivantes dans le service d'administration et dans chaque application déployée sur le serveur.
                                <ul>
                                    <li><b>mfp.topology.clustermode</b></li>
                                    <li><b>mfp.admin.serverid</b></li>
                                </ul>
                                Dans la console WebSphere Application Server :
                                <ul>
                                    <li>Sélectionnez <b>Applications → Types d'application → Applications d'entreprise WebSphere</b>.</li>
                                    <li>Sélectionnez l'application de service d'administration.</li>
                                    <li>Dans <b>Propriétés du module Web</b>, cliquez sur <b>Entrées d'environnement pour les modules Web</b> pour afficher les propriétés JNDI.</li>
                                    <li>Définissez les valeurs des propriétés ci-dessous.
                                        <ul>
                                            <li>Associez <b>mfp.topology.clustermode</b> à la valeur <b>Farm</b>.</li>
                                            <li>Associez <b>mfp.admin.serverid</b> à l'identificateur que vous avez choisi pour ce membre de parc de serveurs. Cet identificateur doit être unique parmi tous les membres du parc de serveurs.</li>
                                            <li>Associez <b>mfp.admin.jmx.user</b> à un nom d'utilisateur ayant accès au connecteur SOAP.</li>
                                            <li>Associez <b>mfp.admin.jmx.pwd</b> au mot de passe de l'utilisateur déclaré dans <b>mfp.admin.jmx.user</b>.</li>
                                            <li>Associez <b>mfp.admin.jmx.port</b> à la valeur du port SOAP.</li>
                                        </ul>
                                    </li>
                                    <li>Vérifiez que <b>mfp.admin.jmx.connector</b> a pour valeur <b>SOAP</b>.</li>
                                    <li>Cliquez sur <b>OK</b> et sauvegardez la configuration.</li>
                                    <li>Apportez les mêmes modifications pour chaque application d'environnement d'exécution {{ site.data.keys.product_adj }} déployée sur le serveur.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li>Echangez les certificats serveur entre les membres du parc de serveurs dans leurs magasins de clés de confiance respectifs. L'échange des certificats serveur dans les magasins de clés de confiance est obligatoire pour les parcs de serveurs qui utilisent le profil complet et le profil Liberty de WebSphere Application Server car dans ces parcs de serveurs, la communication entre les serveurs est sécurisée par SSL.
                        <ul>
                            <li><b>Profil Liberty de WebSphere Application Server</b>
                                <br/>
                                Vous pouvez configurer le magasin de clés de confiance en utilisant des utilitaires IBM, comme Keytool ou iKeyman.
                                <ul>
                                    <li>Pour plus d'informations sur Keytool, voir <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/keytoolDocs/keytool_overview.html">Keytool</a> dans IBM SDK, Java Technology Edition.</li>
                                    <li>Pour plus d'informations sur iKeyman, voir <a href="http://www-01.ibm.com/support/knowledgecenter/?lang=en#!/SSYKE2_6.0.0/com.ibm.java.security.component.60.doc/security-component/ikeyman_tool.html">iKeyman</a> dans IBM SDK, Java Technology Edition.</li>
                                </ul>
                                Les emplacements du magasin de clés et du magasin de clés de confiance sont définis dans le fichier <b>server.xml</b>. Voir les attributs <b>keyStoreRef</b> et <b>trustStoreRef</b> dans <a href="http://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/ae/rwlp_ssl.html?lang=en&view=kc">Attributs de configuration SSL</a>. Par défaut, le magasin de clés du profil Liberty est <b>${server.config.dir}/resources/security/key.jks</b>. Si la référence du magasin de clés de confiance est manquante ou n'est pas définie dans le fichier <b>server.xml</b>, le magasin de clés de confiance spécifié par <b>keyStoreRef</b> est utilisé. Le serveur utilise le magasin de clés par défaut et le fichier est créé à la première exécution du serveur. Dans ce cas, un certificat par défaut est créé avec une période de validité de 365 jours. En production, vous pouvez envisager d'utiliser votre propre certificat (y compris les certificats intermédiaires si nécessaire) ou de changer la date d'expiration du certificat généré.

                                <blockquote>Remarque : pour confirmer l'emplacement du magasin de clés de confiance, ajoutez la déclaration suivante dans le fichier server.xml :
{% highlight xml %}
<logging traceSpecification="SSL=all:SSLChannel=all"/>
{% endhighlight %}
                                </blockquote>
                                Enfin, démarrez le serveur et recherchez les lignes contenant com.ibm.ssl.trustStore dans le fichier <b>${wlp.install.dir}/usr/servers/nom_serveur/logs/trace.log</b>.
                                <ul>
                                    <li>Importez les certificats publics des autres serveurs du parc de serveurs dans le magasin de clés de confiance qui est référencé par le fichier de configuration <b>server.xml</b> du serveur. Le tutoriel <a href="../../simple-install/tutorials/graphical-mode">Installation de {{ site.data.keys.mf_server }} en mode graphique</a> explique comment échanger les certificats entre deux serveurs Liberty dans un parc de serveurs. Pour plus d'informations, voir l'étape 5 de la section <a href="../../simple-install/tutorials/graphical-mode/#creating-a-farm-of-two-liberty-servers-that-run-mobilefirst-server">Création d'un parc de deux serveurs Liberty exécutant {{ site.data.keys.mf_server }}</a>.</li>
                                    <li>Redémarrez chaque instance du profil Liberty de WebSphere Application Server pour appliquer la configuration des paramètres de sécurité. Les étapes ci-après sont requises pour que la connexion unique fonctionne.</li>
                                    <li>Démarrez un membre du parc de serveurs. Dans la configuration LTPA par défaut, une fois que le serveur Liberty a démarré, un magasin de clés LTPA <b>${wlp.user.dir}/servers/nom_serveur/resources/security/ltpa.keys</b> est généré.</li>
                                    <li>Copiez le fichier <b>ltpa.keys</b> dans le répertoire <b>${wlp.user.dir}/servers/nom_serveur/resources/security</b> de chaque membre du parc de serveurs afin de répliquer les magasins de clés LTPA sur les membres du parc de serveurs. Pour plus d'informations sur la configuration LTPA, voir <a href="http://www.ibm.com/support/knowledgecenter/?view=kc#!/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_sec_ltpa.html">Configuration de l'authentification LTPA dans le profil Liberty</a>.</li>
                                </ul>
                            </li>
                            <li><b>Profil complet de WebSphere Application Server</b>
                                <br/>
                                Configurez le magasin de clés de confiance dans la console d'administration de WebSphere Application Server.
                                <ul>
                                    <li>Connectez-vous à la console d'administration WebSphere Application Server.</li>
                                    <li>Sélectionnez <b>Sécurité → Certificat SSL et gestion des clés</b>.</li>
                                    <li>Dans <b>Articles liés</b>, sélectionnez <b>Magasins de clés et certificats</b>.</li>
                                    <li>Dans la zone <b>Utilisations des magasins de clés</b>, assurez-vous que l'option <b>Fichiers de clés SSL</b> est sélectionnée. A présent, vous pouvez importer les certificats de tous les autres serveurs dans le parc de serveurs.</li>
                                    <li>Cliquez sur <b>NodeDefaultTrustStore</b>.</li>
                                    <li>Dans <b>Propriétés supplémentaires</b>, sélectionnez <b>Certificats de signataire</b>.</li>
                                    <li>Cliquez sur <b>Extraire d'un port</b>. A présent, vous pouvez entrer les détails de communication et de sécurité des autres serveurs dans le parc de serveurs. Suivez les étapes ci-dessous pour chaque autre membre du parc de serveurs.</li>
                                    <li>Dans la zone <b>Hôte</b>, entrez le nom d'hôte ou l'adresse IP du serveur.</li>
                                    <li>Dans la zone <b>Port</b>, entrez le port de transport HTTPS (SSL).</li>
                                    <li>Dans <b>Configuration SSL pour une connexion de communication sortante</b>, sélectionnez <b>NodeDefaultSSLSettings</b>.</li>
                                    <li>Dans la zone <b>Alias</b>, entrez un alias pour ce certificat de signataire.</li>
                                    <li>Cliquez sur <b>Récupérer les informations du signataire</b>.</li>
                                    <li>Vérifiez les informations qui sont extraites depuis le serveur distant, puis cliquez sur <b>OK</b>.</li>
                                    <li>Cliquez sur <b>Sauvegarder</b>.</li>
                                    <li>Redémarrez le serveur.</li>
                                </ul>    
                            </li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>

### Vérification de la configuration du parc de serveurs
{: #verifying-a-farm-configuration }
Le but de cette tâche consiste à vérifier le statut des membres du parc de serveurs et à déterminer si le parc de serveurs est configuré correctement.

1. Démarrez tous les serveurs du parc de serveurs.
2. Accédez à {{ site.data.keys.mf_console }}, par exemple en entrant **http://nom_serveur:port/mfpconsole** ou **https://nom_hôte:port_sécurisé/mfpconsole** pour HTTPS.
    La barre de navigation de la console contient un menu supplémentaire intitulé Noeuds de parc de serveurs.
3. Cliquez sur **Noeuds de parc de serveurs** pour accéder à la liste des membres de parc de serveurs enregistrés et à leur statut. Dans l'exemple ci-dessous, le noeud **MembreParc2** est considéré comme arrêté, ce qui indique que ce serveur est probablement défaillant et qu'il requiert une maintenance.

![Statut des noeuds de parc de serveurs dans la {{ site.data.keys.mf_console }}](farm_nodes_status_list.jpg)

### Cycle de vie d'un noeud de parc de serveurs
{: #lifecycle-of-a-server-farm-node }
Vous pouvez configurer la fréquence des signaux de présence et la valeur de délai permettant de détecter les problèmes de serveur possibles pour les membres du parc de serveurs en déclenchant la modification du statut d'un noeud affecté.

#### Enregistrement et surveillance des serveurs en tant que noeuds de parc de serveurs
{: #registration-and-monitoring-servers-as-farm-nodes }
Lorsqu'un serveur configuré en tant que noeud de parc de serveurs est démarré, son service d'administration l'enregistre automatiquement comme nouveau membre du parc de serveurs.
Lorsqu'un membre de parc de serveurs est arrêté, son enregistrement dans le parc de serveurs est annulé automatiquement.

Un mécanisme de signaux de présence existe pour assurer le suivi des membres de parc de serveurs qui ne répondent plus, en raison d'une panne de courant ou d'une défaillance du serveur par exemple. Dans ce mécanisme de signaux de présence, les environnements d'exécution de {{ site.data.keys.product_adj }} envoient régulièrement un signal de présence aux services d'administration de
{{ site.data.keys.product_adj }} à une fréquence spécifiée. Si le service d'administration de {{ site.data.keys.product_adj }} détermine que le temps écoulé depuis le dernier signal de présence envoyé par un membre du parc de serveurs est trop long, il considère que le membre du parc de serveurs est arrêté.

Les membres du parc de serveurs qui sont considérés comme arrêtés n'envoient plus de demandes aux applications mobiles.

Le fait qu'un ou plusieurs noeuds soient arrêtés n'empêche par les autres membres du parc de serveurs d'envoyer correctement des demandes aux applications mobiles ni d'accepter de nouvelles opérations de gestion qui sont déclenchées via {{ site.data.keys.mf_console }}.

#### Configuration de la fréquence des signaux de présence et de la valeur de délai
{: #configuring-the-heartbeat-rate-and-timeout-values }
Vous pouvez configurer la fréquence des signaux de présence et la valeur de délai en définissant les propriétés JNDI suivantes :

* **mfp.admin.farm.heartbeat**
* **mfp.admin.farm.missed.heartbeats.timeout**

<br/>
Pour plus d'informations sur les propriétés JNDI, voir [Liste des propriétés JNDI pour le {{ site.data.keys.mf_server }}service d'administration](../../server-configuration/#list-of-jndi-properties-for-mobilefirst-server-administration-service).
