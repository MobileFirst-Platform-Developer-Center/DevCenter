---
layout: tutorial
title: Fonctions d'accessibilité pour IBM MobileFirst Foundation
breadcrumb_title: Fonctions d'accessibilité
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Les fonctions d'accessibilité aident les utilisateurs atteints par exemple de mobilité réduite ou de vision limitée, à utiliser le contenu des technologies de l'information.

### Fonctions d'accessibilité
{: #accessibility-features }
{{ site.data.keys.product_full }} comprend les principales fonctions d'accessibilité suivantes :

* Utilisation du clavier uniquement
* Opérations qui prennent en charge l'utilisation d'un lecteur d'écran

{{ site.data.keys.product }} utilise la norme W3C la plus récente, [WAI-ARIA
1.0](http://www.w3.org/TR/wai-aria/), pour être conforme à la norme [US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards) et respecter les instructions [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/). Pour tirer parti des fonctionnalités d'accessibilité, utilisez la dernière version de votre lecteur d'écran en combinaison avec le dernier navigateur Web qui est pris en charge par ce produit.

### Navigation au clavier
{: #keyboard-navigation }
Ce produit utilise les touches de navigation standard.

### Informations relatives à l'interface
{: #interface-informaton }
Les interfaces utilisateur {{ site.data.keys.product }} ne disposent pas de contenu qui clignote 2 à 55 fois par seconde.

Vous pouvez utiliser un lecteur d'écran avec un synthétiseur vocal numérique pour entendre ce qui est affiché sur votre écran. Consultez la documentation de votre technologie d'assistance pour plus de détails sur l'utilisation avec ce produit et sa documentation.

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
Par défaut, les messages d'état affichés par l'interface de ligne de commande
{{ site.data.keys.mf_cli }} apparaissent dans différentes couleurs qui
indiquent la réussite, les erreurs et les avertissements. Vous pouvez utiliser l'option `--no-color` sur toutes les commandes {{ site.data.keys.mf_cli }} pour supprimer l'utilisation de ces couleurs pour cette commande. Lorsque l'option `--no-color` est spécifiée, la sortie est affichée dans les couleurs d'affichage de texte qui sont définies pour votre console de système d'exploitation.

### Interface web 
{: #web-interface }
Les interfaces utilisateur Web {{ site.data.keys.product }} reposent sur des feuilles de style en cascade pour rendre le contenu correctement et pour fournir une expérience exploitable. L'application fournit un moyen équivalent pour les utilisateurs malvoyants pour utiliser les paramètres d'affichage du système utilisateur, y compris le mode de contraste élevé. Il est possible de contrôler la taille de
police dans les paramètres de l'appareil ou du navigateur Web.

Vous pouvez naviguer à travers les différents environnements {{ site.data.keys.product_adj }} et leur documentation à l'aide de raccourcis clavier. Eclipse fournit des fonctionnalités d'accessibilité pour ses environnements de développement. Les navigateurs Internet fournissent également des fonctions d'accessibilité pour des applications Web, par exemple, la console {{ site.data.keys.mf_console }}, la console {{ site.data.keys.mf_analytics_console }}, la console {{ site.data.keys.product }} Application Center et le client mobile {{ site.data.keys.product }} Application Center.

L'interface utilisateur Web {{ site.data.keys.product }} comprend les repères de navigation WAI ARIA que vous pouvez utiliser pour naviguer rapidement vers les zones fonctionnelles de l'application.

### Installation et configuration
{: #installation-and-configuration }
Vous pouvez installer et configurer
{{ site.data.keys.product }} de deux façons : via l'interface graphique
ou via l'interface de ligne de commande.

Bien que l'interface graphique (IBM Installation Manager en mode assistant ou Server
Configuration Tool) ne fournisse pas d'informations sur les objets de l'interface utilisateur, une fonction équivalente est disponible avec l'interface
de ligne de commande. Toutes les fonctions de l'interface graphique sont prises en charge sur la ligne de commande, et certaines fonctions d'installation
et de configuration ne sont disponibles qu'avec la ligne de commande. Vous pouvez vous renseigner sur les fonctions d'accessibilité d'[IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) dans IBM Knowledge Center.

Les rubriques suivantes expliquent comment procéder à l'installation et à la configuration sans l'interface graphique :

* Utilisation de fichiers de réponses exemple pour IBM Installation Manager
Cette méthode active l'installation et la configuration en mode silencieux du serveur {{ site.data.keys.mf_server }} et d'Application Center. Vous avez la possibilité de ne pas installer Application Center à l'aide du fichier de réponses nommé install-no-appcenter.xml. Vous pouvez utiliser des tâches Ant afin de l'installer ultérieurement. Voir la rubrique Installation d'Application Center à l'aide de tâches Ant. Dans ce cas, l'installation et la mise à niveau d'Application Center peuvent être effectuées indépendamment l'une de l'autre.
* Installation d'aide de tâches Ant
* Installation d'Application Center à l'aide de tâches Ant

### Logiciel de fournisseur
{: #vendor-software }
{{ site.data.keys.product }} contient
des logiciels fournisseur qui ne sont pas protégés par le contrat de licence IBM. IBM ne présente pas les fonctions d'accessibilité de ces produits. Contactez le fournisseur pour obtenir des informations
sur l'accessibilité de ses produits.

### Informations relatives à l'accessibilité
{: #related-accessibility-information }
Outre le centre d'assistance IBM standard et les sites Web de support, IBM a mis en place un service de téléscripteur permettant aux clients sourds ou malentendants d'accéder aux services commerciaux et de support :

Service TTY  
800-IBM-3383 (800-426-3383)  
(Amérique du nord)

### IBM et fonctions d'accessibilité
{: #ibm-and-accessibility }
Pour plus d'informations sur l'engagement d'IBM en matière d'accessibilité, voir
[IBM Accessibility](http://www.ibm.com/able).


