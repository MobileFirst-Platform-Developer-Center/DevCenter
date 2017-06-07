---
layout: tutorial
title: Configuration de la journalisation et du traçage pour Application Center sur le serveur d'applications
breadcrumb_title: Configuration de la journalisation et du traçage
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez définir des paramètres de journalisation et de traçage pour des serveurs d'applications particuliers et utiliser les propriétés JNDI pour contrôler la sortie sur tous les serveurs d'applications pris en charge.

Vous pouvez définir les niveaux de journalisation et le fichier de sortie pour les opérations de traçage pour Application Center de manière spécifique pour des serveurs d'applications particuliers. En outre, {{ site.data.keys.product_full }} fournit des propriétés Java™ Naming et Directory Interface (JNDI) pour contrôler la mise en forme et la redirection de la sortie de trace et pour imprimer les instructions SQL générées.

#### Accéder à
{: #jump-to }
* [Activation de la journalisation et du traçage dans le profil complet de WebSphere Application Server](#logging-in-websphere)
* [Activation de la journalisation et du traçage dans WebSphere Application Server Liberty](#logging-in-liberty)
* [Activation de la journalisation et du traçage dans Apache Tomcat](#logging-in-tomcat)
* [Propriétés JNDI pour contrôler la sortie de trace](#jndi-properties-for-controlling-trace-output)

## Activation de la journalisation et du traçage dans le profil complet de WebSphere Application Server
{: #logging-in-websphere }
Vous pouvez définir les niveaux de journalisation et le fichier de sortie pour les opérations de traçage sur le serveur d'applications.

Lorsque vous essayez de diagnostiquer des problèmes dans Application Center (ou d'autres composants de {{ site.data.keys.product }}), il est important de pouvoir afficher les messages du journal. Pour imprimer des messages de journal lisibles dans des fichiers journaux, vous devez spécifier les paramètres applicables en tant que propriétés de machine virtuelle Java™ (JVM).

1. Ouvrez la console d'administration de WebSphere Application Server.
2. Sélectionnez **Troubleshooting → Logs and Trace**.
3. Dans **Logging and tracing**, sélectionnez le serveur d'applications approprié, puis sélectionnez **Change log detail levels**.
4. Sélectionnez les modules et leur niveau de détail correspondant. Cet exemple permet la journalisation de {{ site.data.keys.product }}, y compris Application Center, avec le niveau **FINEST** (équivalent à **ALL**).

```xml
com.ibm.puremeap.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

Où :

* **com.ibm.puremeap.*** est pour Application Center.
* **com.ibm.worklight.*** et **com.worklight.*** sont pour les autres composants {{ site.data.keys.product_adj }}.

Les traces sont envoyées vers un fichier appelé **trace.log**, et non vers **SystemOut.log** ou **SystemErr.log**.

## Activation de la journalisation et du traçage dans WebSphere Application Server Liberty
{: #logging-in-liberty }
Vous pouvez définir les niveaux de journalisation et le fichier de sortie pour les opérations de traçage pour Application Center sur le serveur d'applications Liberty.

Lorsque vous tentez de diagnostiquer des problèmes dans Application Center, il est important de pouvoir afficher les messages du journal. Pour imprimer des messages de journal lisibles dans des fichiers journaux, vous devez spécifier les paramètres applicables.

Pour activer la journalisation de {{ site.data.keys.product }}, y compris Application Center, avec le niveau FINEST (équivalent à ALL), ajoutez une ligne au fichier server.xml. Par exemple :

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

Dans cet exemple, les entrées d'un module et son niveau de journalisation sont séparées par le signe deux-points (:).

Les traces sont envoyées vers un fichier appelé **trace.log**, et non vers **messages.log** ou **console.log**.

Pour plus d'informations, voir [Liberty profile: Logging and Trace](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc).

## Activation de la journalisation et du traçage dans Apache Tomcat
{: #logging-in-tomcat }
Vous pouvez définir les niveaux de journalisation et le fichier de sortie pour les opérations de traçage effectuées sur le serveur d'applications Apache Tomcat.

Lorsque vous tentez de diagnostiquer des problèmes dans Application Center, il est important de pouvoir afficher les messages du journal. Pour imprimer des messages de journal lisibles dans des fichiers journaux, vous devez spécifier les paramètres applicables.

Pour activer la journalisation de {{ site.data.keys.product }}, y compris Application Center, avec le niveau **FINEST** (équivalent à **ALL**), éditez le fichier **conf/logging.properties**. Par exemple, ajoutez des lignes similaires à ces lignes :

```xml
com.ibm.puremeap.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

Pour plus d'informations, voir [Logging in Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html).

## Propriétés JNDI pour contrôler la sortie de trace
{: #jndi-properties-for-controlling-trace-output }
Sur toutes les plateformes prises en charge, vous pouvez utiliser les propriétés Java™ Naming et Directory Interface (JNDI) pour formater et rediriger la sortie de trace pour Application Center et pour imprimer les instructions SQL générées.

Les propriétés JNDI suivantes sont applicables à l'application Web pour les services Application Center (**applicationcenter.war**).

| Paramètres des propriétés | Paramètre | Description | 
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | Par défaut, cette propriété a pour valeur false. Définissez-la sur true pour formater la sortie JSON avec des espaces, pour faciliter la lecture dans les fichiers journaux. | 
| ibm.appcenter.logging.tosystemerror | true | Par défaut, cette propriété a pour valeur false. Définissez-la sur true pour imprimer tous les messages de journalisation dans les fichiers journaux d'erreurs système. Utilisez la propriété pour activer la journalisation globale. | 
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TR  ACE | Ce paramètre imprime toutes les instructions SQL générées dans les fichiers journaux. | 
