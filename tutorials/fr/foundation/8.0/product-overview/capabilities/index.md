---
layout: tutorial
title: Fonctions principales du produit
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Avec {{ site.data.keys.product_full }}, vous pouvez utiliser des fonctions telles que le développement, le test, les connexions en arrière-plan, les notifications par commande push, le mode hors ligne, la mise à jour, la sécurité, l'analyse, la surveillance et la publication d'application.

### Développement
{: #deployment }
{{ site.data.keys.product }} fournit une infrastructure qui permet le développement, l'optimisation, l'intégration et la gestion d'applications mobiles sécurisées. {{ site.data.keys.product }} n'introduit pas de modèle ou de langage de programmation propriétaire que les utilisateurs doivent apprendre.

Vous pouvez développer des applications à l'aide de HTML5, CSS3 et JavaScript. Vous pouvez éventuellement écrire du code natif (Java ou Objective-C). {{ site.data.keys.product }}
fournit un kit de développement de logiciels (SDK) qui inclut les bibliothèques auxquelles vous pouvez accéder depuis le code natif.

#### Plateformes prises en charge
{: #supported-platforms }
Les logiciels SDK {{ site.data.keys.product }} prennent en charge les plateformes suivantes :

* iOS
* Android
* Windows Universal 8.1 et Windows 10 UWP
* Applications web

> **Navigateurs pris en charge pour les applications Web :**
> 
> |      Navigateur   | Chrome | Safari* | Internet Explorer | Firefox | Navigateur Android |
> |:-----------------:|:------:|:-------:|:-----------------:|:-------:|:---------------:|
> | Version prise en charge |   43+  |    8+   |        10+        |   38+   |   Android 4.3+  |

* Le mode de survol privé ne fonctionne qu'avec des applications de page unique. D'autres applications peuvent avoir un comportement inattendu.

### Connexions d'arrière plan
{: #back-end-connections }
Certaines applications mobiles s'exécutent uniquement hors ligne, sans connexion à un système d'arrière plan, mais la plupart se connectent à des services d'entreprise existants afin de fournir les fonctions utilisateur essentielles. Par exemple, des clients peuvent utiliser une application mobile pour effectuer des achats sur n'importe quel site, à tout moment, sans tenir compte des horaires d'ouverture du  magasin. Leurs commandes doivent encore être traitées à l'aide de la plateforme e-commerce existante du magasin. Pour intégrer une application mobile à des services d'entreprise, vous devez utiliser un middleware de type passerelle mobile. {{ site.data.keys.product }} peut constituer cette solution intermédiaire et faciliter la communication avec les services de back end.

### Notifications de commande push
{: #push-notifications }
Les notifications de commande push permettent aux applications d'entreprise d'envoyer des informations à des appareils mobiles, même lorsque l'application n'est pas utilisée. {{ site.data.keys.product }} inclut une infrastructure de notification unifiée qui fournit un mécanisme cohérent pour les notifications par commande push. Cette
infrastructure de notification unifiée permet d'envoyer des notifications de commande push sans connaître les détails de chaque appareil ou plateforme ciblé
car chaque plateforme mobile applique un mécanisme différent pour les notifications de commande push.

### Mode hors ligne
{: #offline-mode }
En matière de connectivité, les applications mobiles peuvent opérer en mode hors ligne, en ligne ou en mode mixte. {{ site.data.keys.product }}
utilise une architecture client-serveur qui peut détecter si un appareil possède une connectivité de réseau ainsi que la qualité du réseau. Agissant tel un client, les applications mobiles tentent périodiquement de se connecter au serveur et d'évaluer la puissance de la connexion. Une application mobile activée hors ligne peut être utilisée lorsqu'un appareil mobile n'a pas de connectivité mais certaines fonctions risquent d'être limitées. Lorsque
vous créez une application mobile activée hors ligne, stockez les informations concernant l'appareil mobile qui permettent de préserver sa fonctionnalité en
mode hors ligne. Ces informations proviennent généralement d'un système expéditeur et vous devez prévoir une synchronisation de données avec le système expéditeur dans le cadre de l'architecture d'application. {{ site.data.keys.product }} inclut une fonction appelée JSONStore pour le stockage et l'échange de données. Cette fonction permet de créer, lire, mettre à jour et supprimer des enregistrements de données depuis une source de données. Chaque opération est mise en file d'attente lors du fonctionnement hors ligne. Lorsqu'une connexion est disponible, l'opération est transférée au serveur et chaque opération est alors effectuée en fonction des données source.

### Mise à jour
{: #update }
{{ site.data.keys.product }} simplifie la gestion des versions et la compatibilité des applications mobiles. Chaque fois qu'un utilisateur démarre une application mobile, cette dernière communique avec un serveur. Avec ce serveur,
{{ site.data.keys.product }}
peut déterminer si une version plus récente de l'application est disponible, et si tel est le cas, il peut en informer l'utilisateur ou envoyer une mise à
jour d'application à l'appareil. Le serveur peut également imposer le passage à la dernière version d'une application afin d'empêcher l'usage d'une version obsolète.

### Sécurité
{: #security }
La protection des informations confidentielles et privées est essentielle pour toutes les applications d'une entreprise, y compris les applications mobiles. La sécurité des appareils mobiles s'applique à divers niveaux, tels qu'à l'application mobile, aux services d'application mobile ou au service de back end. Vous devez garantir la confidentialité des informations client et protéger les données confidentielles contre tout accès non autorisé. S'agissant
des appareils mobiles privés, il s'avère nécessaire de renoncer au contrôle de certains niveaux inférieurs de sécurité, tel celui du système d'exploitation
mobile.

{{ site.data.keys.product }} fournit une communication sécurisée de bout en bout en positionnant un serveur qui supervise le flux de données entre l'application mobile et vos systèmes expéditeurs. Avec {{ site.data.keys.product }}, vous pouvez définir des descripteurs de sécurité personnalisés pour tout accès à ce flux de données. Etant donné que l'accès aux données d'une application mobile doit s'effectuer via cette instance de serveur, vous pouvez définir différents gestionnaires de sécurité pour des applications mobiles, des applications Web et l'accès au système expéditeur. Avec ce type de sécurité granulaire, vous pouvez définir des niveaux distincts d'authentification pour différentes fonctions de votre application mobile. Vous
pouvez également empêcher des applications mobiles d'accéder à des informations sensibles.

### Analyse
{: #analytics }
La fonction {{ site.data.keys.mf_analytics }} active la recherche parmi les applications, les services, les appareils et d'autres sources afin de collecter des données d'utilisation ou de détecter des problèmes.

En
plus des rapports qui récapitulent l'activité des applications,
{{ site.data.keys.product }} inclut une plateforme d'analyse
opérationnelle évolutive qui est accessible dans {{ site.data.keys.mf_console }}. La fonction {{ site.data.keys.mf_analytics_short }} permet aux entreprises de rechercher dans les journaux et les événements collectés à partir d'appareils, d'applications et de serveurs des canevas, des problèmes et des statistiques d'utilisation de plateforme. Vous pouvez activer les fonctions d'analyse et/ou de génération de rapports en fonction de vos besoins.

### Surveillance
{: #monitoring }
{{ site.data.keys.product }} inclut divers mécanismes de génération de rapports et d'analyse opérationnelle pour la collecte, l'affichage et l'analyse des données depuis vos applications et vos serveurs {{ site.data.keys.product }}, ainsi que la surveillance de la santé des serveurs.

### Publication d'application
{: #application-publishing }
{{ site.data.keys.product }} Application Center
est un magasin d'applications d'entreprise. Il permet d'installer, de configurer et d'administrer un référentiel d'applications mobiles à l'usage d'individus et de groupes au sein de votre entreprise. Vous pouvez déterminer quelles sont les personnes de votre organisation qui peuvent accéder à Application Center et télécharger des applications dans le référentiel Application Center, ainsi que les personnes qui peuvent télécharger et installer ces applications sur un appareil mobile. Vous pouvez également utiliser Application Center pour collecter des commentaires en retour auprès d'utilisateurs et accéder à des informations concernant
les appareils sur lesquels des applications sont installées.

Application Center est similaire à la boutique App Store publique d'Apple ou à la boutique Play store de Google, excepté qu'il vise le processus de développement.

Application Center fournit un référentiel pour le stockage des fichiers d'application mobile et une console Web pour la gestion de ce référentiel. Application Center fournit également une application client mobile destinée à permettre aux utilisateurs de parcourir le catalogue des applications qui sont stockées par Application Center, d'installer des applications, de laisser des commentaires en retour pour l'équipe de développement et d'exposer des applications de production à IBM Endpoint Manager. L'accès aux procédures de téléchargement et d'installation d'applications à partir d'Application Center est contrôlé à l'aide de listes de contrôle d'accès.
