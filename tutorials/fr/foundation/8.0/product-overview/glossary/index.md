---
layout: tutorial
title: Glossaire
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{ site.data.keys.mf_console }}" for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>
Ce glossaire contient les termes et définitions du logiciel et des produits {{ site.data.keys.product }}.

Les références croisées suivantes sont utilisées dans ce glossaire :

* **Voir** vous renvoie d'un terme non préféré vers le terme préféré ou d'une abréviation vers sa forme non abrégée.
* **Voir aussi** renvoie à un terme connexe ou opposé.

Pour d'autres termes et définitions, voir le [site Web IBM Terminology](http://www.ibm.com/software/globalization/terminology/).

## A
{: #a }

### Abonnement
{: #subscription }
Enregistrement des informations données par un abonné à un courtier ou serveur local pour décrire les publications qu'il souhaite recevoir.

### Adaptateur
{: #adapter }
Code côté serveur d'une application {{ site.data.keys.product_adj }}. Les adaptateurs se connectent aux applications d'entreprise, distribuent des données à des applications mobiles ou en provenant, et appliquent côté serveur toute la logique nécessaire aux données envoyées.

### Adaptateur MobileFirst
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Voir [adaptateur](#adapter)

### Alias
{: #alias }
Association supposée ou réelle entre deux entités de données  ou entre une entité de données et un pointeur.

### Android
{: #android }
Système d'exploitation mobile créé par Google, dont la plus grande partie est publiée sous les licences de code source ouvert Apache 2.0 et GPLv2. Voir aussi Appareil mobile.

### API
{: #api-application-programming-interfacae-api }
Interface qui permet à un programme d'application écrit dans un langage évolué d'utiliser les données ou les fonctions particulières du système d'exploitation ou d'un autre programme.

### Appareil
{: #device }
Voir [Appareil mobile](#mobile-device)

### Appareil mobile
{: #mobile-device }
Téléphone, tablette graphique ou assistant électronique de poche qui fonctionne sur un réseau radio. Voir aussi Android.

### Application
{: #app }
Application Web ou pour appareil mobile. Voir aussi Application Web.

### Application Center
{: #application-center }
Composant {{ site.data.keys.product_adj }} qui peut être utilisé pour partager des applications et faciliter la collaboration entre les membres d'équipe dans un référentiel unique d'applications mobiles.

### Application d'entreprise
{: #company-application }
Application conçue pour être utilisée uniquement au sein d'une entreprise.

### Application d'entreprise
{: #enterprise-application }
Voir Application de société.

### Application d'entreprise de l'autorité de certification
{: #certificate-authority-enterprise-application }
Application d'entreprise qui fournit des certificats et des clés privées pour ses applications client.

### Application hybride
{: #hybrid-application }
Application écrite principalement en langages orientés Web
(HTML5, CSS et JS), mais encapsulée dans un interpréteur de
commandes natif de manière à fonctionner
comme une application native et à fournir à l'utilisateur
toutes les fonctionnalités d'une application native.

### Application interne
{: #in-house-application }
Voir [Application d'entreprise](#company-application).

### Application native
{: #native-app }
Application compilée en code binaire pour utilisation sur le système d'exploitation mobile de l'appareil.

### Application Web
{: #web-app--application }
Application accessible par un navigateur Web et qui fournit certaines fonctions autres que l'affichage statique d'informations, par exemple en autorisant l'utilisateur à interroger une base de données. Les composants les plus courants d'une application Web sont les pages HTML, les pages JSP et les servlets. Voir également [application](#A).

### Authentification
{: #authentication }
Service de sécurité qui fournit la preuve qu'un utilisateur d'un ordinateur est bien la personne qu'il prétend être. Les mécanismes habituels de mise en oeuvre de ce service sont des mots de passe et des signatures électroniques.

### Autorité de certification
{: #ca--certificate-authority-ca }
Organisation ou société tiers certifiée émettant les certificats numériques. L'autorité de certification vérifie l'identité des personnes auxquelles
est accordé le certificat unique. Voir aussi [Certificat](#certificate).

## B
{: #b }
### Base64
{: #base64 }
Format de texte en clair qui est utilisé pour coder les données binaires. Le codage Base64 est couramment utilisé pour l'authentification du certificat utilisateur afin de coder les certificats X.509, les CSR X.509 et les CRL X.509. Voir aussi Codé DER, Codé PEM.

### Base de données d'administration
{: #administration-database }
Base de données de la {{ site.data.keys.mf_console }}
et des services d'administration. Les tables de base de données définissent des éléments, tels que des applications, des adaptateurs ou des projets, avec leurs descriptions et leurs ordres de grandeur.

### Bibliothèque
{: #library }
Objet système qui sert d'annuaire pour les autres objets. Une bibliothèque regroupe des objets connexes et permet aux utilisateurs de retrouver ces objets par leur nom.
Ensemble d'éléments de modèle (éléments métier, processus, tâches, ressources et organisations).

### Binaire
{: #binary }
Qualifie un élément compilé ou exécutable.

### Bloc
{: #block }
Collection de plusieurs propriétés (telles qu'adaptateur, procédure ou paramètre).

## C
{: #c }

### Catalogue
{: #catalog }
Collection d'applications.

### Certificat
{: #certificate }
Dans le domaine de la sécurité informatique, document numérique qui associe une clé publique à l'identité du propriétaire du certificat, permettant ainsi au propriétaire du certificat d'être authentifié. Un certificat est émis par une autorité de certification et signé numériquement par cette autorité. Voir aussi [Autorité de certification](#ca--certificate-authority-ca).

### Certificat X.509
{: #x509-certificate }
Certificat qui contient des informations définies par la norme X.509.
### Chaîne de certificats
{: #keychain }
Système de gestion de mot de passe pour logiciel Apple. Une chaîne de certificats s'emploie comme
un conteneur de stockage sécurisé pour les mots de passe utilisés par des applications et des services multiples.

### Chiffrement
{: #encryption }
En sécurité informatique, processus de transformation des données dans un format incompréhensible de sorte que les données d'origine ne puissent pas être obtenues ou ne puissent l'être que par le biais d'un processus de décryptage.

### Clé
{: #key }
Valeur mathématique cryptographique utilisée pour signer numériquement, vérifier, chiffrer et déchiffrer un message. Voir aussi Clé privée, Clé publique.
Un ou plusieurs caractères dans un élément de données qui sont utilisés pour identifier de façon unique un enregistrement et définir son ordre par rapport aux autres enregistrements.

### Clé privée
{: #private-key }
Dans le cadre de la communication sécurisée, motif basé sur un algorithme permettant de
chiffrer des messages que seule la clé publique correspondante peut déchiffrer. La clé privée
sert également à déchiffrer des messages chiffrés à l'aide de la clé publique correspondante. La clé privée est conservée sur le système de l'utilisateur et elle est protégée par un mot de passe. Voir aussi Clé, Clé publique.

### Clé publique
{: #public-key }
Dans les communications sécurisées, canevas algorithmique utilisé pour déchiffrer les messages chiffrés par la clé privée correspondante. Une clé publique est également utilisée pour chiffrer les messages qui peuvent être déchiffrés uniquement par la clé privée correspondante. Les utilisateurs diffusent leurs clés publiques avec toutes les personnes avec lesquelles ils doivent échanger des messages chiffrés. Voir aussi Clé, Clé privée.

### Client
{: #client }
Programme logiciel ou ordinateur qui demande des services à un serveur.

### Client mobile
{: #mobile-client }
Voir [Programme d'installation d'Application Center](#application-center-installer).

### Clone
{: #clone }
Copie identique de la dernière version approuvée d'un composant dotée d'un nouvel ID unique de composant.

### Cluster
{: #cluster }
Série de systèmes complets qui, ensemble, mettent à disposition une fonctionnalité de calcul unifiée.

### Codé DER
{: #der-encoded }
Qualifie un format binaire d'un certificat ASCII au format PEM. Voir aussi Base64, Codé PEM.

### Code PEM
{: #pem-encoded }
Qualifie un certificat codé en Base64. Voir aussi Base64, Codé DER.

### Composant
{: #component }
Objet ou programme réutilisable qui exécute une fonction spécifique et fonctionne avec d'autres composants et applications.

### Composant d'authentification côté client
{: #client-side-authentication-componnet }
Composant qui collecte des informations client, puis qui utilise des modules de connexion pour contrôler ces informations.

### Concentrateur d'entreprise
{: #company-hub }
Application qui peut distribuer d'autres applications spécifiées devant être installées sur un appareil mobile. Par exemple, Application Center est un concentrateur d'entreprise. Voir également [Application Center](#application-center).

### Contexte d'appareil
{: #device-context }
Données permettant d'identifier l'emplacement d'un appareil. Ces données peuvent inclure des coordonnées géographiques, des points d'accès Wi-Fi et des détails d'horodatage. Voir aussi Déclencheur.

## D
{: #d }

### Déclencher
{: #fire }
En programmation orientée objet, provoquer un changement d'état.

### Déclencheur
{: #trigger }
Mécanisme qui détecte une occurrence et qui peut, en réponse, enclencher un traitement supplémentaire. Des déclencheurs peuvent être activés lors de modifications du contexte d'appareil. Voir aussi Contexte d'appareil.

### Définition de génération
{: #build-definition }
Objet qui définit une génération (par exemple, une génération d'intégration à l'échelle d'un projet hebdomadaire).

### Demande d'authentification
{: #challenge }
Demande de certaines informations à un système. Ces informations, qui sont renvoyées au serveur en réponse à cette demande, sont nécessaires pour authentifier le client.

### Déploiement
{: #deployment }
Processus d'installation et de configuration d'une application logicielle et de tous ses composants.

### documentify
{: #documentify }
Commande JSONStore permettant de créer un document.

### Données d'identification
{: #credential }
Ensemble d'informations qui accorde à un utilisateur ou à un processus certains droits d'accès.

## E
{: #e }

### Emulateur
{: emulator }
Application permettant d'exécuter une application prévue pour une plateforme autre que la plateforme en cours.

### Encapsuleur
{: #wrapper }
Section de code qui contient le code que le compilateur ne peut pas interpréter autrement. L'encapsuleur fait office d'interface entre le compilateur et le code encapsulé.

### Enregistrement d'appareil
{: #device-enrollment }
Processus consistant, pour un propriétaire, à enregistrer son appareil comme appareil autorisé.

### Entité
{: #entity }
Utilisateur, groupe ou ressource défini sur un service de sécurité.

### environment
{: #environment }
Instance caractéristique d'une configuration de matériel ou de logiciel.

### Environnement d'exécution MobileFirst
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Composant côté serveur optimisé pour les mobiles qui exécute le côté serveur de vos applications mobiles (intégration dorsale, gestion de version, sécurité, notification push unifiée). Chaque environnement d'exécution est inclus dans une application Web (fichier WAR).

### Envoyer par commande push
{: #push }
Envoyer des informations d'un serveur vers un client. Lorsqu'un serveur envoie du contenu par commande push, c'est le serveur initie la transaction, et non une demande provenant du client.

### Equilibrage de charge
{: #load-balancing }
Méthode de mise en réseau d'ordinateurs permettant de répartir les charges de travail entre plusieurs ordinateurs ou dans un cluster (grappe) d'ordinateurs, des liaisons réseau, des unités de traitement centralisé, des unités de disque ou d'autres ressources. Un équilibrage de charge réussi optimise l'utilisation des ressources, augmente la capacité de traitement, réduit le temps de réponse et évite les surcharges.

### Evénement
{: #event }
Occurrence significative pour une tâche ou un système. Les événements peuvent inclure l'achèvement ou l'échec d'une opération, une action de l'utilisateur ou le changement d'état d'un processus.

## F
{: #f }

### Facette
{: #facet }
Entité XML qui restreint les types de données XML.

### Fichier descripteur d'application
{: #application-descriptor-file }
Fichier de métadonnées qui définit divers aspects d'une application.

### Fichier WAR de projet
{: #project-war-file }
Fichier d'archive Web qui contient les configurations de l'environnement d'exécution {{ site.data.keys.product_adj }} et est déployé sur un serveur d'applications.

### Fonction de rappel
{: #callback-function }
Code exécutable qui permet à une couche logicielle de niveau inférieur d'appeler une fonction définie dans une couche de niveau supérieur.

## G
{: #g }
### Géocodage
{: #geocoding }
Processus d'identification de géocodes à partir de marqueurs géographiques plus traditionnels (adresses, codes postaux etc...). Par exemple, un repère peut être situé à l'intersection de deux rues
mais le géocode de ce repère représente une séquence de numéros.

### Géolocalisation
{: #geolocation }
Processus de repérage d'un emplacement par évaluation de divers types de signaux. En informatique mobile, des points d'accès de réseau local sans fil (WLAN) et des tours de téléphonie mobile sont souvent utilisés pour localiser approximativement un emplacement. Voir aussi Géocodage, Services de localisation.

### Gestionnaire de demandes d'authentification
{: #challenge-handler }
Composant côté client qui émet une séquence de demandes d'authentification côté serveur et qui répond côté client.

### Glisser
{: #slide }
Déplacer un élément d’interface à curseur horizontalement sur un écran tactile. En général, les applications utilisent des symboles de déplacement pour verrouiller et déverrouiller les téléphones, ou des options de basculement.

## H
{: #h }

### Habillage
{: #skin }
Elément d'une interface graphique qui peut être modifié pour changer la présentation de l'interface sans affecter sa fonctionnalité.

## I
{: #i }

### Intercepteur de relations de confiance
{: #tai--trust-association-interceptor-tai }
Mécanisme par lequel la confiance est validée dans
l'environnement produit pour chaque demande reçue par le serveur proxy. La méthode de validation est
acceptée par le serveur proxy et l'intercepteur.

## J
{: #j }

### JMX/Java Management Extensions (JMX)
{: #jmx--java-management-extensions-jmx }
Mode de gestion de et par la technologie Java. JMX est une extension libre et universelle du langage de
programmation Java pour des opérations de gestion, déployables dans
tous les secteurs d'activité.

## L
{: #l }

### Liste de révocation de certificat
{: #crl-certificate-revocation-list-crl }
Liste des certificats qui ont été révoqués après leur date d'expiration planifiée. Les CRL sont gérées par l'autorité de certification et utilisées lors de l'établissement de liaison SSL (Secure Sockets Layer) pour s'assurer que les certificats impliqués n'ont pas été révoqués.

### Logiciel SDK/Kit de développement de logiciels
{: #sdk--software-development-kit-sdk }
Ensemble d'outils, d'API et de documentations facilitant le développement
de logiciels en langage informatique spécifique ou pour un environnement d'exploitation particulier.

## M
{: #m }

### Magasin local
{: #local-store }
Zone d'un appareil dans laquelle des applications peuvent stocker et extraire des données en local sans nécessiter de connexion réseau.

### MBean/Bean géré
{: #mbean--managed-bean-mbean}
Dans la spécification Java Management Extensions (JMX), objets Java permettant de mettre en oeuvre les ressources et leur instrumentation.

### Message système
{: #system-message }
Message automatique sur un appareil mobile qui indique l'état opérationnel ou des alertes, par exemple si des connexions sont ou non établies.

### Mettre à disposition
{: #provisin }
Fournir, déployer et contrôler un service, un composant, une application ou une ressource.

### Mobile
{: #mobile }
Voir [Appareil mobile](#mobile-device).

### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Interface Web utilisée pour contrôler et gérer les environnements d'exécution {{ site.data.keys.product_adj }} déployés sur {{ site.data.keys.mf_server }} et pour collecter et analyser des statistiques d'utilisateur.

### MobileFirst Server
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Composant {{ site.data.keys.product_adj }} qui gère la sécurité, les connexions de back end, les notifications de commande push, la gestion des applications mobiles et les analyses. Le serveur {{ site.data.keys.mf_server }} est un ensemble d'applications qui s'exécutent sur un serveur d'applications. Il fait office de conteneur d'exécution pour les environnements d'exécution {{ site.data.keys.product_adj }}.

### Modèle
{: #template }
Groupe d'éléments ayant des propriétés communes. Ces propriétés peuvent être définies une seule fois, au niveau du modèle, et sont héritées par tous les éléments utilisant le modèle.

## N
{: #n }

### Navigation entre pages
{: #page-navigation }
Fonction de navigateur permettant aux utilisateurs de naviguer vers l'avant et vers l'arrière dans un navigateur.

### Noeud
{: #node }
Regroupement logique de serveurs gérés.

### Noeud de parc de serveurs
{: #farm-node }
Serveur en réseau hébergé dans un parc de serveurs.

### Notification
{: #notification }
Dans un processus, occurrence pouvant déclencher une action. Les notifications peuvent être utilisées pour modéliser des conditions à transmettre d'un expéditeur à un ensemble (généralement inconnu) de parties intéressées (les récepteurs).

### Notification basée sur des balises
{: #tag-based-notification }
Notification à destination des appareils ayant souscrit à une balise spécifique. Des balises sont utilisées pour représenter des rubriques susceptibles d'intéresser un utilisateur. Voir aussi Notification de diffusion.

### Notification de commande push
{: #push-notification }
Alerte signalant une modification ou une mise à jour au niveau d'une icône d'application mobile.

### Notification de diffusion
{: #broadcast-notification }
Notification à destination de tous les utilisateurs d'une application {{ site.data.keys.product_adj }} spécifique. Voir aussi Notification basée sur des balises.

## O
{: #o }

### OAuth
{: #oauth }
Protocole d'autorisation basé sur HTTP qui permet à des applications
d'accéder à une ressource protégée pour le compte du propriétaire de la ressource,
en créant une interaction d'approbation entre le propriétaire des ressources, le client et le serveur de ressources.

## P
{: #p }

### Paire de clés
{: #key-pair }
Dans le domaine de la sécurité informatique, correspond à une clé publique et une clé privée. Lorsque la paire de clés
est utilisée pour effectuer un chiffrement, l'émetteur utilise la clé publique du destinataire pour chiffrer le message et le destinataire
utilise sa clé privée pour déchiffrer le message. Lorsque la paire de clés est utilisée pour fournir une signature,
le signataire utilise la clé privée pour chiffrer une représentation du message et le destinataire utilise la clé publique de l'émetteur
pour déchiffrer la représentation du message et vérifier la signature.

### Parc de serveurs
{: #server-farm }
Groupe de serveurs en réseau.

### Parc de serveurs homogène
{: #homogeneous-server-farm }
Parc de serveurs dans lequel les serveurs
d'application sont de même type, niveau et version.

### Passerelle
{: #gateway }
Appareil ou programme permettant de connecter des réseaux ou des systèmes à des architectures réseau différentes.

### PKI/Infrastructure PKI
{: #pki--public-key-infrastructure-pki }
Système de certificats numériques, d'autorités de certification et d'autres autorités d'enregistrement qui vérifie et authentifie la validité de chaque partie impliquée dans une transaction réseau.

### Pont PKI
{: #pki-bridge }
Concept {{ site.data.keys.mf_server }}
qui active l'infrastructure d'authentification de certificat utilisateur pour communiquer avec une infrastructure PKI.

### Programme d'installation d'Application Center
{: #application-center-installer }
Application qui répertorie l'ensemble des applications disponibles dans Application Center. Le programme d'installation d'Application Center
doit se trouver sur un appareil pour pouvoir installer des applications
à partir de votre référentiel d'application privé.

### Projet
{: #project }
Environnement de développement pour divers composants, tels que des applications, des adaptateurs, des fichiers de configuration, du code Java personnalisé et des bibliothèques.

### Proxy
{: #proxy }
Passerelle d'application entre deux réseaux pour une application réseau donnée comme Telnet ou FTP, par exemple, où le serveur Telnet proxy authentifie l'utilisateur avant de laisser passer le trafic dans le proxy comme s'il n'était pas là. L'opération s'effectue au niveau du pare-feu et non sur le poste de travail client, ce qui augmente la charge dans le pare-feu.

### Proxy de données MobileFirst
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
Composant côté serveur sur le logiciel DSK IMFData qui peut être utilisé pour sécuriser les appels d'application mobile émis vers Cloudant à l'aide des fonctions de sécurité OAuth{{ site.data.keys.product }}. Le proxy de données {{ site.data.keys.product_adj }} requiert une authentification via l'intercepteur de relations de confiance.

### Proxy inverse
{: #reverse-proxy }
Topologie de réacheminement dans laquelle le proxy agit pour le compte d'un serveur HTTP dorsal. Il s'agit d'un proxy d'application pour serveurs utilisant HTTP.

## R
{: #r }

### Racine
{: #root }
Répertoire qui contient tous les autres répertoires d'un système.

### Règle d'acquisition
{: #acquisition-policy }
Règle qui contrôle comment les données sont collectées à partir du détecteur d'un appareil mobile. La règle est définie par code d'application.

### Ressource Web
{: #web-resource }
Une des ressources créées lors du développement d'une application Web, par exemple des projets Web, des pages HTML, des fichiers JavaServer Pages (JSP), des servlets, des bibliothèques de balises personnalisées et des fichiers archive.

## S
{: #s}

### Sel de cryptage
{: #salt }
Données générées de façon aléatoire insérées dans un mot de passe ou un dièse de phrase passe,
indiquant que ces mots de passe ne sont pas communs (et plus difficile à détourner).

### Serveur d'applications Web
{: #web-application-server }
Environnement d'exécution des applications Web dynamiques. Un serveur d'applications
Web Java EE implémente les services de la norme Java EE.

### Service
{: #service }
Programme qui effectue une fonction primaire sur un serveur ou dans un logiciel associé.

### Services d'administration
{: #administration-services }
Application qui héberge les services REST et les tâches d'administration. L'application Services d'administration est incluse dans son propre fichier WAR.

### Session
{: #sessions }
Connexion logique ou virtuelle entre deux postes, programmes logiciels ou appareils sur un réseau, qui permet aux deux éléments de communiquer et d'échanger des données pour la durée de la session.

### Signer
{: #sign }
Associer une signature électronique unique, dérivée de l'ID utilisateur de l'expéditeur, à un document ou une zone au moment de l'expédition par courrier électronique d'un document. La signature des courriers électroniques garantit qu'un utilisateur non autorisé qui crée une copie d'un ID utilisateur ne peut pas établir de signatures avec cet ID. De plus, la signature vérifie que personne n'a falsifié les données pendant que le message était en transit.

### Simulateur
{: #simulator }
Environnement de code de transfert écrit pour une plateforme différente. Les simulateurs sont utilisés pour développer et tester du code dans un même environnement de développement intégré, mais déploient ensuite ce code sur sa propre plateforme. Par exemple,
du code peut être développé pour un appareil Android sur un ordinateur,
puis testé à l'aide d'un simulateur sur cet ordinateur.

### Sondage
{: #poll }
Demande répétée de données à partir d'un serveur.

### Source de données
{: #data-source }
Moyen par lequel une application accède aux données d'une base de données.

### Source d'événement
{: #event-source }
Objet qui prend en charge un serveur de notification asynchrone au sein d'une machine virtuelle Java™. A l'aide d'une source d'événement, l'objet programme d'écoute d'événements peut être enregistré et utilisé pour implémenter n'importe quelle interface.

### Sous-élément
{: #subelement }
Dans les normes EDI UN/EDIFACT, élément de données EDI appartenant à un élément de données composites EDI. Par exemple, un élément de données EDI et son qualificatif sont des sous-éléments d'un élément de données composites EDI.

### Syntaxe
{: #syntax }
Règles de construction d'une commande ou d'une instruction.

## T
{: t}

### Taper
{: #tap }
Toucher brièvement un écran tactile. En général, les applications utilisent des symboles pour la sélection des éléments (équivalent d'un clic sur le bouton gauche de la souris).

### Test de sécurité
{: #security-test }
Ensemble ordonné de domaines d'authentification utilisé afin de protéger une ressource
telle qu'une procédure d'adaptateur, une application ou une URL statique.

## V
{: #v }

### Vue
{: #view }
Panneau situé hors de la zone de l'éditeur et permettant de visualiser ou d'utiliser les ressources du plan de travail.

## W
{: #w}

### Widget
{: #widget }
Application portable réutilisable ou partie de contenu dynamique pouvant être placée sur une page Web, recevoir des entrées et communiquer avec une application ou avec un autre widget.

