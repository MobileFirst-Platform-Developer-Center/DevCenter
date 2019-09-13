---
layout: tutorial
title: Utilisation de MobileFirst Server dans Eclipse
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #overview }
Vous pouvez intégrer {{ site.data.keys.mf_server }} à l'environnement de
développement intégré Eclipse, afin de proposer une expérience de développement unifiée.

* Vous pouvez également exposer la fonctionnalité d'interface de ligne de
commande dans Eclipse ; voir le
tutoriel
[Using
the {{ site.data.keys.mf_server }} CLI in Eclipse](../../../../application-development/using-mobilefirst-cli-in-eclipse).
* De plus, vous pouvez développer des adaptateurs dans Eclipse ; voir
le tutoriel [Developing Adapters in Eclipse](../../../../adapters/developing-adapters).

### Ajout du serveur à Eclipse
{: #adding-the-server-to-eclipse }
1. Depuis la vue **Serveurs** dans Eclipse, sélectionnez **Nouveau → Serveur**.
2. S'il n'existe pas d'option de dossier IBM, cliquez sur "Télécharger des adaptateurs de serveur supplémentaires".
3. Sélectionnez **Outils WebSphere Application Server Liberty** et suivez les instructions affichées à l'écran.
4. Depuis la vue **Serveurs** dans Eclipse, sélectionnez **Nouveau → Serveur**.
5. Sélectionnez **IBM → WebSphere Application Server Liberty**.
6. Indiquez un **nom** de serveur et un **nom d'hôte**, puis cliquez sur **Suivant**.
7. Indiquez le chemin d'accès au répertoire de base du serveur et sélectionnez la version de l'environnement d'exécution Java (JRE) à utiliser. Lorsque vous utilisez {{ site.data.keys.mf_dev_kit }}, le répertoire de base est le dossier **[répertoire_installation]/mfp-server**.
8. Cliquez sur **Suivant**, puis sur **Terminer**.

A présent, vous pouvez démarrer et arrêter {{ site.data.keys.mf_server }}
depuis la vue "Serveurs" de l'environnement d'exécution intégré Eclipse.
