---
layout: tutorial
title: Nouveautés
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0 apporte des modifications significatives qui modernisent votre expérience en matière de développement, de déploiement et de gestion d'applications {{ site.data.keys.product_adj }}.

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">Nouveautés en matière de génération d'applications</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>La conception du kit de développement de logiciels et de l'interface de ligne de commande {{ site.data.keys.product }} a été repensée pour vous fournir davantage de souplesse et d'efficacité dans le développement de vos applications. De plus, vous pouvez désormais utiliser n'importe lequel de vos outils Cordova préférés pour développer des applications multiplateformes.</p>

                <p>Examinez les sections suivantes pour connaître les nouveautés en matière de développement d'applications.</p>

                <h3>Nouveau processus de développement et de déploiement</h3>
                <p>Vous ne créez plus de fichier WAR de projet à installer dans le serveur d'applications. A la place, le serveur {{ site.data.keys.mf_server }} est installé une fois, et vous téléchargez la configuration côté serveur de vos applications, de la sécurité des ressources ou du service push sur le serveur. Vous pouvez modifier la configuration de vos applications à l'aide de la console {{ site.data.keys.mf_console }}.</p>

                <p>Les projets {{ site.data.keys.product_adj }} n'existent plus. Vous développez désormais votre application mobile dans l'environnement de développement de votre choix.<br/>
                Vous pouvez modifier la configuration côté serveur de vos applications et de vos adaptateurs sans arrêter {{ site.data.keys.mf_server }}.</p>

                <ul>
                    <li>Pour plus d'informations sur le nouveau processus de développement, consultez <a href="../../../application-development/">Présentation et concepts de développement</a></li>
                    <li>Pour plus d'informations sur la migration d'applications existantes, voir le <a href="../../../upgrading/migration-cookbook">manuel d'instructions de migration</a>.</li>
                    <li>Pour plus d'informations sur l'administration des applications {{ site.data.keys.product_adj }}, voir la rubrique Administration des applications {{ site.data.keys.product_adj }}.</li>
                </ul>

                <h3>Applications Web</h3>
                <p>Vous pouvez désormais utiliser l'API JavaScript côté client {{ site.data.keys.product_adj }} pour développer des applications Web avec vos outils et votre interface IDE préférés. Vous pouvez enregistrer votre application Web sur {{ site.data.keys.mf_server }} pour ajouter des fonctions de sécurité à l'application.</p>

                <p>Vous pouvez également utiliser la nouvelle API d'analyse Web JavaScript côté client, fournie dans le cadre du nouveau kit de développement de logiciels Web, afin d'ajouter des fonctions {{ site.data.keys.mf_analytics }} à votre application Web.</p>

                <h3>Développement d'applications multiplateformes à l'aide de vos outils Cordova préférés</h3>
                <p>Vous pouvez désormais utiliser vos outils Cordova préférés (par exemple, l'interface de ligne de commande Apache Cordova ou Ionic Framework) pour développer vos applications hybrides multiplateformes. Vous vous procurez ces outils indépendamment de {{ site.data.keys.product }}, puis vous ajoutez des plug-in {{ site.data.keys.product_adj }} pour fournir des fonctions de back end {{ site.data.keys.product_adj }}.</p>

                <p>Vous pouvez installer le plug-in {{ site.data.keys.product }} Studio Eclipse pour gérer vos applications Cordova multiplateformes activées avec {{ site.data.keys.product }} dans l'environnement de développement Eclipse. Le plug-in {{ site.data.keys.product }} Studio fournit également des commandes {{ site.data.keys.mf_cli }} supplémentaires que vous pouvez exécuter à partir de l'environnement Eclipse.</p>

                <h3>Mise en composants du SDK</h3>
                <p>Auparavant, le SDK client {{ site.data.keys.product_adj }} était livré en tant qu'infrastructure unique ou fichier JAR. Vous pouvez désormais choisir d'inclure ou d'exclure des fonctionnalités spécifiques. En plus du SDK de base, chaque API {{ site.data.keys.product_adj }} comporte son propre ensemble de composants facultatifs.</p>

                <h3>Nouvelle interface de ligne de commande (CLI) de développement améliorée</h3>
                <p>La conception de l'interface de ligne de commande {{ site.data.keys.mf_cli }} a été repensée pour obtenir une plus grande efficience en matière de développement, y compris pour une utilisation dans des scripts automatisés. Les commandes démarrent à présent avec le préfixe mfpdev. L'interface de ligne de commande est incluse dans {{ site.data.keys.mf_dev_kit_full }} ou vous pouvez télécharger rapidement sa dernière version à partir de npm.</p>

                <h3>Outil d'assistance à la migration</h3>
                <p>Un outil d'assistance à la migration simplifie la procédure de migration de vos applications existantes sur {{ site.data.keys.product }} version 8.0. L'outil analyse vos applications {{ site.data.keys.product_adj }} existantes et crée une liste des API utilisées dans le fichier qui sont retirées, dépréciées ou remplacées dans la version 8.0. Lorsque vous exécutez l'outil d'assistance à la migration sur des applications Apache Cordova qui ont été créées avec {{ site.data.keys.product }}, une nouvelle structure Cordova compatible avec la version 8.0 est créée pour les applications. En savoir plus sur l'outil d'assistance à la migration.</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>A compter de Cordova 4.0, le programme WebView enfichable permet de remplacer l'environnement d'exécution Web par défaut. Crosswalk est à présent pris en charge par les applications Cordova avec {{ site.data.keys.product }}. Crosswalk WebView for Android permet d'obtenir des performances élevées et des acquis utilisateur cohérents sur une vaste gamme d'appareils mobiles. Pour bénéficier des fonctions Crosswalk, appliquez le plug-in Cordova Crosswalk.</p>

                <h3>Distribution du kit de développement de logiciels {{ site.data.keys.product_adj }} pour les applications Windows 8 et Windows 10 Universal avec NuGet</h3>
                <p>Le kit de développement de logiciels {{ site.data.keys.product_adj }} pour les applications Windows 8 et Windows 10 Universal est disponible auprès de NuGet à l'adresse <a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>. Initiation.</p>

                <h3>org.apache.http remplacé par okHttp</h3>
                <p><code>org.apache.http</code> a été retiré du kit de développement de logiciels Android. okHttp sera utilisé comme dépendance HTTP.</p>

                <h3>Support WKWebView pour les applications Cordova hybrides iOS</h3>
                <p>Vous pouvez désormais remplacer le programme UIWebView par défaut dans des applications Cordova à l'aide de WKWebView.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">Nouveautés en matière d'API MobileFirst</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>De nouvelles fonctions améliorent et étendent les API que vous pouvez utiliser pour développer des applications mobiles. Utilisez les dernières API pour tirer parti des fonctions nouvelles, améliorées, ou modifiées dans {{ site.data.keys.product }}.</p>

                <h3>API côté serveur JavaScript mise à jour</h3>
                <p>Les fonctions d'appel de back end ne sont prises en charge que pour les types d'adaptateur acceptés. Actuellement, seuls les adaptateurs HTTP et SQL sont pris en charge, de sorte que les appelants de back-end <code>WL.Server.invokeHttp</code> et <code>WL.Server.invokeSQL</code> sont également pris en charge.</p>

                <h3>Nouvelle API côté serveur Java</h3>
                <p>Une nouvelle API côté serveur Java est fournie et vous pouvez l'utiliser pour étendre {{ site.data.keys.mf_server }}.</p>

                <h4>Nouvelle API côté serveur Java pour la sécurité</h4>
                <p>Le nouveau package d'API de sécurité, <code>com.ibm.mfp.server.security.external</code>, et les packages qu'il contient, comprennent les interfaces nécessaires pour le développement des contrôles de sécurité et des adaptateurs qui utilisent le contexte de contrôle de sécurité.</p>

                <h4>Nouvelle API côté serveur Java pour les données d'enregistrement des clients</h4>
                <p>Le package de la nouvelle API de données d'enregistrement client, <code>com.ibm.mfp.server.registration.external</code>, et les packages qu'il contient, comprennent une interface pour fournir l'accès aux données persistantes d'enregistrement client {{ site.data.keys.product_adj }}.</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>Avec cette nouvelle API, vous pouvez revenir à l'application JAX-RS pour l'adaptateur.</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>Avec cette nouvelle API, vous pouvez obtenir la valeur (ou la valeur par défaut) de la configuration de l'adaptateur.</p>

                <h3>API côté serveur Java mise à jour</h3>
                <p>Une API côté serveur Java mise à jour est fournie et vous pouvez l'utiliser pour étendre {{ site.data.keys.mf_server }}.</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>La signature de cette nouvelle API n'a pas été modifiée dans cette version. Toutefois, son comportement est désormais identique à celui de <code>String getPropertyValue (String propertyName)</code>, décrit dans la rubrique Nouvelle API côté serveur Java.</p>

                <h4>WLServerAPIProvider</h4>
                <p>Dans les versions V7.0.0 et V7.1.0, l'API Java était accessible via l'interface WLServerAPIProvider. Par exemple :<code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> et <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>Ces interfaces statiques sont toujours prises en charge pour permettre la compilation et le déploiement des adaptateurs qui ont été développés dans les versions précédentes du produit. Les anciens adaptateurs qui n'utilisent pas les notifications push ou l'API de sécurité précédente continuent de fonctionner avec la nouvelle version. Les adaptateurs qui utilisent les notifications push ou l'API de sécurité précédente ne fonctionnent plus.</p>

                <h3>API côté client JavaScript pour applications Web</h3>
                <p>L'API côté client JavaScript qui est utilisée pour le développement d'applications Cordova multiplateformes est maintenant disponible également pour le développement des applications Web, avec de légères variations dans la méthode d'initialisation. Notez que les fonctions de l'API JavaScript ne sont pas toutes applicables aux applications Web.</p>

                <p>En outre, une nouvelle API d'analyse Web côté client JavaScript est fournie pour l'ajout de fonctions {{ site.data.keys.mf_analytics }} à votre application Web.</p>

                <h3>API côté client C# mise à jour pour Windows 8 Universal et Windows Phone 8 Universal</h3>
                <p>L'API côté client C# pour Windows 8 Universal et Windows Phone 8 Universal a été modifiée.</p>

                <h3>Nouvelles API côté client Java pour Android</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>Avec cette nouvelle méthode, vous pouvez obtenir le nom d'affichage d'un appareil à partir des données d'enregistrement {{ site.data.keys.mf_server }}.</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>Avec cette nouvelle méthode, vous pouvez définir le nom d'affichage d'un appareil dans les données d'enregistrement {{ site.data.keys.mf_server }}.</p>

                <h3>Nouvelles API côté client Objective-C pour iOS</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>Avec cette nouvelle méthode, vous pouvez obtenir le nom d'affichage d'un appareil à partir des données d'enregistrement {{ site.data.keys.mf_server }}.</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>Avec cette nouvelle méthode, vous pouvez définir le nom d'affichage d'un appareil dans les données d'enregistrement {{ site.data.keys.mf_server }}.</p>

                <h3>API REST mise à jour pour le service d'administration</h3>
                <p>L'API REST pour le service d'administration est partiellement restructurée. En particulier, l'API pour les alarmes et les médiateurs est retirée et la plupart des services REST pour les notifications push font maintenant partie de l'API REST pour le service push.</p>

                <h3>API REST mise à jour pour le contexte d'exécution</h3>
                <p>L'API REST pour l'exécution de {{ site.data.keys.product_adj }} offre désormais plusieurs services pour les clients mobiles et les clients confidentiels pour appeler des adaptateurs, obtenir des jetons d'accès, obtenir du contenu de mise à jour directe, et plus encore. La plupart des noeuds finaux de l'API REST sont protégés par OAuth. Sur un serveur de développement, vous pouvez afficher le doc swagger pour l'API d'exécution sur le site : <code>http(s)://server_ip:server_port/context_root/doc</code>.</p>

                <h3>Possibilité d'épingler plusieurs certificats</h3>
                <p>A partir du correctif temporaire 8.0.0.0-IF201706240159, {{ site.data.keys.mf_bm_short }} prend en charge l'épinglage de plusieurs certificats. Cette fonction permet aux utilisateurs d'accéder sans risque à différents hôtes. Avant ce correctif temporaire, {{ site.data.keys.mf_bm_short }} ne permettait d'épingler qu'un seul certificat. {{ site.data.keys.mf_bm_short }} met en oeuvre une nouvelle API qui permet de se connecter à plusieurs hôtes en autorisant l'utilisateur à épingler les clés publiques de plusieurs certificats X509 (obtenus auprès d'une autorité de certification) à l'application client. Une copie de tous les certificats doit être placée dans votre application client. Lors de l'établissement de la liaison SSL, le SDK du client {{ site.data.keys.product_full }} vérifie que la clé publique du certificat du serveur correspond bien à celle de l'un des certificats stockés dans l'application.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">Nouveautés en matière de sécurité MobileFirst</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>L'infrastructure de sécurité dans {{ site.data.keys.product }} a été entièrement remaniée. De nouvelles fonctionnalités de sécurité ont été introduites, et quelques modifications ont été apportées aux fonctions existantes.</p>

                <h3>Révision de l'infrastructure de sécurité</h3>
                <p>L'infrastructure de sécurité {{ site.data.keys.product_adj }} a été remaniée et réimplémentée pour améliorer et simplifier les tâches de développement et d'administration de la sécurité. L'infrastructure est à présent intrinsèquement basée sur le modèle OAuth, et l'implémentation est indépendante des sessions. Voir la rubrique Présentation de l'infrastructure de sécurité {{ site.data.keys.product_adj }}.</p>

                <p>Côté serveur, les multiples blocs de construction de l'infrastructure ont été remplacés par des contrôles de sécurité (mis en œuvre dans des adaptateurs), permettant un développement simplifié avec de nouvelles API. Des implémentations d'échantillon et des contrôles de sécurité prédéfinis sont fournis. Voir la rubrique Contrôles de sécurité. Les contrôles de sécurité peuvent être configurés dans le descripteur de l'adaptateur, et personnalisés par des modifications de configuration d'adaptateur ou d'application d'exécution, sans redéployer l'adaptateur ni perturber le flux. Les configurations peuvent être effectuées à partir des interfaces de sécurité {{ site.data.keys.mf_console }} remaniées. Vous pouvez également éditer les fichiers de configuration manuellement ou utiliser les outils {{ site.data.keys.mf_cli }} ou mfpadm.</p>

                <h3>Contrôle de sécurité de l'authenticité de l'application</h3>
                <p>La validation d'authenticité d'application {{ site.data.keys.product_adj }} est maintenant implémentée en tant que contrôle de sécurité prédéfini qui remplace le "contrôle d'authenticité d'application étendu" précédent. Vous pouvez activer, désactiver et configurer dynamiquement la validation d'authenticité d'application en utilisant {{ site.data.keys.mf_console }} ou mfpadm. Un outil Java d'authenticité d'application {{ site.data.keys.product_adj }} autonome (mfp-app-authenticity-tool.jar) est fourni pour générer un fichier d'authenticité d'application.</p>

                <h3>Clients confidentiels</h3>
                <p>Le support pour les clients confidentiels a été remanié et réimplémenté à l'aide de la nouvelle infrastructure de sécurité OAuth.</p>

                <h3>Sécurité des applications Web</h3>
                <p>L'infrastructure de sécurité basé sur OAuth révisée prend en charge les applications Web. Vous pouvez maintenant enregistrer des applications web sur {{ site.data.keys.mf_server }} pour ajouter des fonctionnalités de sécurité à votre application et protéger l'accès à vos ressources web. Pour plus d'informations sur le développement d'applications Web {{ site.data.keys.product_adj }}, voir la rubrique Développement d'applications Web. Le contrôle de sécurité d'authenticité d'application n'est pas pris en charge pour les applications web.</p>

                <h3>Applications multiplateformes (applications Cordova), fonctions de sécurité nouvelles et modifiées</h3>
                <p>Des fonctions de sécurité supplémentaires sont disponibles pour vous aider à protéger votre application Cordova. Ces fonctions sont notamment les suivantes :</p>

                <ul>
                    <li>Chiffrement des ressources Web : utilisez cette fonction pour chiffrer les ressources Web dans votre package Cordova afin d'éviter la modification du package.</li>
                    <li>Somme de contrôle des ressources Web : utilisez cette fonction pour exécuter un test de somme de contrôle qui compare les statistiques actuelles des ressources Web de l'application aux statistiques de référence qui ont été établies lorsque l'application a été ouverte la première fois. Ce contrôle aide à empêcher de modifier l'application après qu'elle a été installé et  ouverte.</li>
                    <li>Epinglage de certificat : utilisez cette fonction pour associer le certificat d'une application à un certificat sur le serveur hôte. Cette fonction permet d'empêcher que des informations qui sont transmises entre l'application et le serveur soient consultées ou modifiées.</li>
                    <li>Support de la norme Federal Information Processing Standard (FIPS) 140-2 : utilisez cette fonction pour garantir que les données qui sont transférées sont conformes à la norme de cryptographie FIPS 140-2.</li>
                    <li>OpenSSL : Pour utiliser le chiffrement et le déchiffrement de données OpenSSL avec votre application Cordova pour la plateforme iOS, vous pouvez utiliser le plug-in Cordova cordova-plugin-mfp-encrypt-utils.</li>
                </ul>

                <h3>Connexion unique à l'appareil</h3>
                <p>La connexion unique (SSO) à l'appareil est désormais prise en charge par le biais de la nouvelle propriété de configuration de descripteur d'application de contrôle de sécurité, <code>enableSSO</code>.</p>

                <h3>Mise à jour directe</h3>
                <p>Contrairement aux versions précédentes de {{ site.data.keys.product_adj }}, à compter de la version V8.0 :</p>

                <ul>
                    <li>Si une application client accède à une ressource protégée, l'application ne reçoit pas les mises à jour, y compris si une mise à jour est disponible sur {{ site.data.keys.mf_server }}.</li>
                    <li>Une fois qu'elle a été activée, la mise à jour directe est appliquée sur chaque demande d'une ressource protégée.</li>
                </ul>

                <h3>Protection des ressources externes</h3>
                <p>La méthode prise en charge et les artefacts fournis pour la protection des ressources sur des serveurs externes ont été modifiés :</p>

                <ul>
                    <li>Un nouveau module de validation de jeton d'accès {{ site.data.keys.product_adj }} Java Token Validator configurable est fourni pour l'utilisation de l'infrastructure de sécurité {{ site.data.keys.product_adj }} afin de protéger les ressources sur un serveur Java externe. Le module est fourni comme bibliothèque Java (mfp-java-token-validator-8.0.0.jar) et remplace l'utilisation du noeud final de validation de jeton {{ site.data.keys.mf_server }} obsolète pour créer un module de validation Java personnalisé.</li>
                    <li>Le filtre d'intercepteur de relations de confiance OAuth {{ site.data.keys.product_adj }} permettant de protéger des ressources Java sur un serveur WebSphere Application Server ou WebSphere Application Server Liberty externe, est désormais fourni comme bibliothèque Java library (com.ibm.imf.oauth.common_8.0.0.jar). La bibliothèque utilise le nouveau module de validation Java Token Validator et la configuration modifiée du filtre d'intercepteur de relations de confiance fourni.</li>
                    <li>L'API d'intercepteur de relations de confiance OAuth {{ site.data.keys.product_adj }} côté serveur n'est plus nécessaire et a été retirée.</li>
                    <li>L'infrastructure Node.js passport-mfp-token-validation {{ site.data.keys.product_adj }} permettant de protéger des ressources Java sur un serveur Node.js externe, a été modifiée pour prendre en charge la nouvelle infrastructure de sécurité.</li>
                    <li>Vous pouvez également écrire votre propre module de validation et de filtrage personnalisé, pour tout type de serveur de ressources, qui utilise le nouveau point final d'introspection du serveur d'autorisations.</li>
                </ul>

                <h3>Intégration à WebSphere DataPower en tant que serveur d'autorisations</h3>
                <p>Vous pouvez désormais choisir d'utiliser WebSphere DataPower comme serveur d'autorisations OAuth à la place du serveur d'autorisations {{ site.data.keys.mf_server }} par défaut. Vous pouvez configurer DataPower pour l'intégration à l'infrastructure de sécurité {{ site.data.keys.product_adj }}.</p>

                <h3>Contrôle de sécurité de la connexion unique (SSO) reposant sur LTPA</h3>
                <p>Le support pour le partage de l'authentification des utilisateurs entre les serveurs qui utilisent l'authentification (LTPA) WebSphere est maintenant disponible par le biais du nouveau contrôle de sécurité prédéfini de connexion unique (SSO) basé sur LTPA. Ce contrôle remplace le domaine LTPA {{ site.data.keys.product_adj }} obsolète, et élimine la configuration requise précédente.</p>

                <h3>Gestion d'applications mobiles avec {{ site.data.keys.mf_console }}</h3>
                <p>Certaines modifications ont été apportées au support pour le suivi et la gestion des applications mobiles, des utilisateurs et des appareils de {{ site.data.keys.mf_console }}. Le blocage de l'accès aux appareils ou aux applications est applicable uniquement aux tentatives d'accès à des ressources protégées.</p>

                <h3>Magasin de clés {{ site.data.keys.mf_server }}</h3>
                <p>Un magasin de clés {{ site.data.keys.mf_server }} unique est utilisé pour la signature des jetons OAuth et les packages de mise à jour directe, ainsi que pour l'authentification HTTPS (SSL) mutuelle. Vous pouvez configurer dynamiquement ce magasin de clés en utilisant {{ site.data.keys.mf_console }} ou mfpadm.</p>

                <h3>Chiffrement et déchiffrement natif pour iOS</h3>
                <p>OpenSSL a été retiré de l'infrastructure principale pour iOS et remplacé par un chiffrement/déchiffrement natif. OpenSSL peut être ajouté sous la forme d'une infrastructure distincte. Voir la rubrique Activation de OpenSSL pour iOS. Pour iOS Cordova JavaScript, OpenSSL est toujours intégré à l'infrastructure principale. Pour les deux API, le chiffrement natif et OpenSSL est disponible.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">Nouveautés en matière de prise en charge de système d'exploitation</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} prend désormais en charge les applications Windows 10 Universal, les constructions de bitcode et Apple watchOS 2.</p>

                <h3>Prise en charge des applications universelles pour Windows 10 Native</h3>
                <p>Avec {{ site.data.keys.product }}, vous pouvez maintenant écrire des applications natives C# Universal App Platform pour utiliser le SDK {{ site.data.keys.product_adj }} au sein de votre application.</p>

                <h3>Prise en charge des environnements hybrides Windows</h3>
                <p>Windows 10 Universal Windows Platform (UWP) prend en charge les environnements hybrides Windows. En savoir plus sur l'initiation.</p>

                <h3>Fin de la prise en charge de BlackBerry</h3>
                <p>L'environnement BlackBerry n'est plus pris en charge dans {{ site.data.keys.product }}.</p>

                <h3>Bitcode</h3>
                <p>Les constructions de bitcode sont désormais prises en charge pour les projets iOS. Cependant, le contrôle de sécurité de l'authenticité de l'application {{ site.data.keys.product_adj }} n'est pas pris en charge pour les applications générées avec du code binaire (bitcode).</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 est désormais pris en charge et requiert des générations en bitcode.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">Nouveautés en matière de déploiement et de gestion d'applications</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>De nouvelles fonctions {{ site.data.keys.product }} ont été introduites pour vous aider à déployer et gérer vos applications. Vous pouvez désormais mettre à jour vos applications et adaptateurs sans avoir à redémarrer {{ site.data.keys.mf_server }}.</p>

                <h3>Support DevOps amélioré</h3>
                <p>{{ site.data.keys.mf_server }} a été entièrement repensé pour mieux prendre en charge votre environnement DevOps. {{ site.data.keys.mf_server }} est installé une fois dans votre environnement de serveur d'applications, et aucune modification de la configuration du serveur d'applications n'est nécessaire lorsque vous téléchargez une application ou modifiez la configuration de {{ site.data.keys.mf_server }}.</p>

                <p>Il est inutile de redémarrer {{ site.data.keys.mf_server }} lorsque vous mettez à jour vos applications ou des adaptateurs dont dépendent vos applications. Vous pouvez effectuer des opérations de configuration, ou télécharger une nouvelle version d'un adaptateur ou enregistrer une nouvelle application alors que le serveur continue de gérer le trafic.</p>

                <p>Les modifications de configuration et les opérations de développement sont protégées par des rôles de sécurité.</p>

                <p>Vous pouvez télécharger des artefacts de développement sur le serveur de diverses façons pour obtenir plus de flexibilité opérationnelle :</p>

                <ul>
                    <li>{{ site.data.keys.mf_console }} est amélioré : en particulier, vous pouvez maintenant l'utiliser pour enregistrer une application ou une nouvelle version d'une application, pour gérer les paramètres de sécurité des applications, et pour déployer des certificats, créer des étiquettes de notification push, et envoyer des notifications push. A présent, la console inclut également des guides d'aide contextuelle.</li>
                    <li>Outil de ligne de commande</li>
                </ul>

                <p>Les artefacts de développement que vous téléchargez sur le serveur comprennent des adaptateurs et leur configuration, des configurations de sécurité pour vos applications, des certificats de notification push et des filtres de journal.</p>

                <h3>Exécution d'applications créées sur IBM Bluemix on {{ site.data.keys.product }}</h3>
                <p>Les développeurs peuvent faire migrer des applications IBM Bluemix pour qu'elles s'exécutent sur {{ site.data.keys.product }}. La migration exige que vous modifiiez la configuration de votre application client pour qu'elle soit compatible avec les API {{ site.data.keys.product }}.</p>

                <h3>Utilisation de {{ site.data.keys.product }} en tant que service sur IBM Bluemix</h3>
                <p>Vous pouvez désormais utiliser le service {{ site.data.keys.mf_bm_full }} sur IBM Bluemix pour créer et exécuter vos applications mobiles d'entreprise.</p>

                <h3>Absence des fichiers .wlapp</h3>
                <p>Dans les versions précédentes, des applications ont été déployées sur {{ site.data.keys.mf_server }} en téléchargeant un fichier <b>.wlapp</b>. Ce fichier contenait des données qui décrivaient l'application et, dans le cas d'applications hybrides, les ressources Web nécessaires également. Dans la version V8.0.0, à la place du fichier <b>.wlapp</b> :</p>

                <ul>
                    <li>Vous enregistrez une application dans {{ site.data.keys.mf_server }} en déployant un fichier JSON descripteur d'application.</li>
                    <li>Pour mettre à jour des applications Cordova en utilisant la mise à jour directe, vous téléchargez une archive (fichier .zip) de la ressource Web modifiée sur le serveur. Le fichier archive ne contient plus les fichiers de prévisualisation Web ou les habillages qui étaient possibles dans les versions précédentes de {{ site.data.keys.product }}. Ces éléments ne sont plus utilisés. L'archive contient uniquement les ressources Web qui sont envoyées aux clients, ainsi que les sommes de contrôle pour les validations de la mise à jour directe.</li>
                </ul>

                <p>Pour activer la mise à jour directe des applications Cordova client qui sont installées sur les appareils des utilisateurs finaux, vous devez maintenant déployer les ressources Web modifiées en tant qu'archive (fichier .zip) sur le serveur. Pour activer la mise à jour directe sécurisée, un fichier magasin de clés défini par l'utilisateur doit être déployé dans {{ site.data.keys.mf_server }} et une copie de la clé publique correspondante doit être incluse dans l'application client déployée.</p>

                <h3>Adaptateurs</h3>
                <h4>Les adaptateurs sont des projets Apache Maven.</h4>
                <p>Les adaptateurs sont désormais traités en tant que projets Maven. Vous pouvez créer, construire et déployer des adaptateurs en utilisant les commandes Maven de ligne de commande standard, et en utilisant les environnements IDE prenant en charge Maven, tels qu'Eclipse et IntelliJ.</p>

                <h4>Configuration et déploiement d'un adaptateur dans des environnements DevOps</h4>
                <ul>
                    <li>Les administrateurs {{ site.data.keys.mf_server }} peuvent désormais utiliser la console {{ site.data.keys.mf_console }} pour modifier le comportement d'un adaptateur qui a été déployé. Une fois la reconfiguration effectuée, les modifications sont immédiatement prises en compte dans le serveur, sans qu'il soit nécessaire de redéployer l'adaptateur ou de redémarrer le serveur.</li>
                    <li>Vous pouvez désormais "redéployer à chaud" des adaptateurs, autrement dit, vous pouvez les déployer, annuler leur déploiement et les redéployer lors de l'exécution alors que le trafic est toujours pris en charge par {{ site.data.keys.mf_server }}.</li>
                </ul>

                <h4>Modifications du fichier descripteur de l'adaptateur</h4>
                <p>Le fichier descripteur <b>adapter.xml</b> a été légèrement modifié. Pour plus d'informations sur la structure du fichier descripteur d'adaptateur, voir <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">Tutoriels des adaptateurs</a>.</p>

                <h4>Intégration à l'interface utilisateur Swagger</h4>
                <p>{{ site.data.keys.mf_server }} intègre désormais l'interface utilisateur Swagger. Pour tout adaptateur, vous pouvez consulter l'API associée en cliquant sur Afficher les documents Swagger dans l'onglet Ressources dans la console {{ site.data.keys.mf_console }}. Cette fonction est disponible uniquement dans les environnements de développement.</p>

                <h4>Prise en charge des adaptateurs JavaScript</h4>
                <p>Les adaptateurs JavaScript ne sont pris en charge qu'avec les types de connectivité HTTP et SQL.</p>

                <h4>Support de JAX-RS 2.0</h4>
                <p>JAX-RS 2.0 introduit une nouvelle fonctionnalité côté serveur : des filtres et des intercepteurs HTTP asynchrones côté serveur.  Les adaptateurs peuvent désormais exploiter ces nouvelles fonctions.</p>

                <h3>{{ site.data.keys.product }} on IBM Containers</h3>
                <p>{{ site.data.keys.product }} on IBM Containers publié pour la version V8.0.0 est disponible sur le <a href="http://www-01.ibm.com/software/passportadvantage/">site IBM Passport Advantage</a>. Cette version de {{ site.data.keys.product }} on IBM Containers est prêt pour la production et prend en charge la base de données transactionnelle dashDB™ d'entreprise sur IBM Bluemix.</p>

                <p><b>Remarque :</b> Voir la rubrique Prérequis au déploiement de {{ site.data.keys.product }} on IBM Containers.</p>

                <h3>Déploiement de {{ site.data.keys.mf_server }} sur IBM PureApplication System</h3>
                <p>Vous pouvez désormais déployer et configurer {{ site.data.keys.mf_server }} sur le système {{ site.data.keys.product }} System Pattern on IBM PureApplication  System pris en charge.</p>

                <p>Tous les canevas système {{ site.data.keys.product }} pris en charge incluent désormais la prise en charge d'une base de données IBM DB2 existante. {{ site.data.keys.mf_app_center_full }} est désormais pris en charge sur un canevas de système virtuel.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">Nouveautés de {{ site.data.keys.mf_server }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>La conception de {{ site.data.keys.mf_server }} a été modifiée pour réduire les délais et les coûts de déploiement et de mise à jour de vos applications. En plus de la refonte de {{ site.data.keys.mf_server }}, {{ site.data.keys.product }} augmente le nombre de méthodes d'installation disponibles.</p>

                <p>La nouvelle conception de {{ site.data.keys.mf_server }} introduit deux nouveaux composants, le service de mise à jour en direct {{ site.data.keys.mf_server }} et les artefacts {{ site.data.keys.mf_server }}.</p>

                <p>Le service de mise à jour opérationnel de {{ site.data.keys.mf_server }} a été conçu pour vous aider à réduire les délais et les coûts des mises à jour incrémentielles de vos applications. Il gère et stocke les données de configuration côté serveur des applications et des adaptateurs. Vous pouvez modifier ou mettre à jour différentes parties de votre application en régénérant ou en redéployant votre application :</p>

                <ul>
                    <li>Modifier ou mettre à jour dynamiquement un comportement d'application en fonction des segments utilisateur que vous définissez.</li>
                    <li>Modifier ou mettre à jour dynamiquement la logique métier côté serveur.</li>
                    <li>Modifier ou mettre à jour dynamiquement la sécurité d'application.</li>
                    <li>Externaliser et modifier dynamiquement la configuration d'application.</li>
                </ul>

                <p>Les artefacts {{ site.data.keys.mf_server }} fournissent des ressources pour {{ site.data.keys.mf_console }}.</p>

                <p>Avec la refonte de {{ site.data.keys.mf_server }}, plus d'options d'installation sont désormais fournies. Outre l'installation manuelle,  {{ site.data.keys.product }} fournit deux options d'installation de {{ site.data.keys.mf_server }} dans un parc de serveurs. Vous pouvez également installer {{ site.data.keys.mf_server }} dans une collectivité Liberty.</p>

                <p>Vous pouvez désormais installer les composants {{ site.data.keys.mf_server }} dans un parc de serveurs en utilisant des tâches Ant ou à l'aide de l'outil de configuration de serveur. Pour plus d'informations, voir les rubriques suivantes :</p>

                <ul>
                    <li>Installation d'un parc de serveurs</li>
                    <li>Tutoriels sur l'installation de {{ site.data.keys.mf_server }}</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} prend également en charge la collectivité Liberty. Pour plus d'informations sur la topologie de serveur et sur les différentes méthodes d'installation, voir les rubriques suivantes :</p>

                <ul>
                    <li>Topologie de collectivité Liberty</li>
                    <li>Exécution de l'outil de configuration de serveur</li>
                    <li>Installation d'aide de tâches Ant</li>
                    <li>Installation manuelle sur la collectivité Liberty WebSphere Application Server Liberty</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">Nouveautés de {{ site.data.keys.mf_analytics }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }} introduit une console remaniée avec des améliorations de présentation de l'information et des contrôles d'accès basés sur les rôles. La console est également disponible en différentes langues.</p>

                <p>{{ site.data.keys.mf_analytics_console }} a été remanié pour présenter des informations d'une manière intuitive et plus significative, et utilise des données résumées, pour certains types d'événements.</p>

                <p>Vous pouvez maintenant vous déconnecter de {{ site.data.keys.mf_analytics_console }} en cliquant sur l'icône d'engrenage.</p>

                <p>{{ site.data.keys.mf_analytics_console }} est maintenant disponible dans les langues suivantes :</p>
                <ul>
                    <li>Allemand</li>
                    <li>espagnol</li>
                    <li>Français</li>
                    <li>Italien</li>
                    <li>Japonais</li>
                    <li>Coréen</li>
                    <li>Portugais (Brésil)</li>
                    <li>Russe</li>
                    <li>Chinois simplifié</li>
                    <li>Chinois traditionnel</li>
                </ul>

                <p>La console {{ site.data.keys.mf_analytics_console }} affiche désormais un contenu différent basé sur le rôle de sécurité de l'utilisateur connecté.<br/>
                Pour plus d'informations, voir <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">Role-based access control</a>.</p>

                <p>{{ site.data.keys.mf_analytics_server }} utilise Elasticsearch V1.7.5.</p>

                <p>La prise en charge de {{ site.data.keys.mf_analytics_short }} pour les applications Web a été ajoutée à l'aide de la nouvelle API côté client d'analyse Web.</p>

                <p>Certains types d'événement ont été modifiés entre les versions précédentes de {{ site.data.keys.mf_analytics_server }} et la version V8.0. En raison de cette évolution, les propriétés JNDI qui étaient déjà configurées dans votre fichier de configuration du serveur doivent être converties au nouveau type d'événement.</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">Nouveautés en matière de notifications push {{ site.data.keys.product_adj }}</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>Le service de notification push est désormais fourni comme service autonome hébergé sur une application Web distincte.</p>

                <p>Les versions antérieures de {{ site.data.keys.product }} intégraient le service de notification push dans le contexte d'exécution de l'application.</p>

                <h3>Modèle de programmation</h3>
                <p>Le modèle de programmation s'étend sur le serveur vers le client, et vous devez configurer votre application pour que le service de notification push fonctionne sur vos applications client. Deux types de clients interagiraient avec le service de notification push :</p>

                <ul>
                    <li>Applications client mobiles</li>
                    <li>Applications de serveur de back end</li>
                </ul>

                <h3>Sécurité du service de notification push</h3>
                <p>Le serveur d'autorisations  {{ site.data.keys.product }} applique le protocole OAuth pour sécuriser le service de notification push.</p>

                <h3>Modèle de service de notification push</h3>
                <p>Le modèle basé sur une source d'événement n'est pas pris en charge. La fonction de notification push est activée sur {{ site.data.keys.product }} par le modèle de service push.</p>

                <h3>API REST Push</h3>
                <p>Vous pouvez activer des applications de serveur back-end qui sont déployées en dehors de {{ site.data.keys.mf_server }} pour accéder aux fonctions de notification push à l'aide de l'API REST pour push dans le contexte d'exécution de {{ site.data.keys.product }}.</p>

                <h3>Mise à niveau à partir d'un modèle existant de notification basé sur la source d'événement</h3>
                <p>Le modèle basé sur une source d'événement n'est pas pris en charge. La fonction de notification push est entièrement activée par le modèle de service push. Toutes les applications basées sur des sources d'événement existantes doivent être migrées vers le nouveau modèle de service push.</p>

                <h3>Envoi de notifications push</h3>
                <p>Vous pouvez choisir d'envoyer une notification push basée sur la source d'événement, basée sur l'étiquette ou activée par diffusion à partir du serveur.</p>

                <p>Les notifications push peuvent être envoyées comme suit :</p>
                <ul>
                    <li>Dans la console {{ site.data.keys.mf_console }}, deux types de notification peuvent être envoyés : tag et broadcast. Voir la rubrique Envoi de notification push à l'aide de la console {{ site.data.keys.mf_console }}.</li>
                    <li>Avec l'API REST Push Message (POST), toutes les formes de notification peuvent être envoyées : tag, broadcast et authenticated.</li>
                    <li>Avec l'API REST pour le service d'administration de {{ site.data.keys.mf_server }}, toutes les formes de notification peuvent être envoyées : tag, broadcast et authenticated.</li>
                </ul>

                <h3>Envoi de notifications SMS</h3>
                <p>Vous pouvez configurer le service push pour envoyer une notification par SMS aux appareils d'utilisateur.</p>

                <h3>Installation du service de notification push</h3>
                <p>Le service de notification push est conditionné comme un composant  {{ site.data.keys.mf_server }} (service push {{ site.data.keys.mf_server }}).</p>

                <h3>Le modèle de service push est pris en charge sur les applications Windows Universal Platform</h3>
                <p>Vous pouvez maintenant faire migrer des applications Windows Universal Platform (UWP) natives pour utiliser le modèle de service push pour l'envoi de notifications push.</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter">Nouveautés de {{ site.data.keys.mf_app_center }} </a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_app_center }} est désormais pris en charge dans Bluemix (sur la base des conteneurs) à l'aide des scripts BYOL.</p>
            </div>
        </div>
    </div>
</div>
