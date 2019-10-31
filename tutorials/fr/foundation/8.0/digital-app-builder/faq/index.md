---
layout: tutorial
title: Foire aux questions
breadcrumb_title: FAQs
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Présentation
{: #faq }

Cette rubrique décrit la liste des questions fréquemment posées liées à IBM Digital App Builder.

<div class="panel-group accordion" id="mfp-dab-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq1" aria-expanded="true" aria-controls="collapse-mfp-dab-faq1"><b>A. Comment créer une clé d'API de plateforme ?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq1">
            <div class="panel-body">
                <p>
                    <ol>
                        <li>Accédez à <a href="https://cloud.ibm.com/iam#/users" target="_blank">https://cloud.ibm.com/iam#/users</a> après vous être connecté à IBM Cloud.</li>
                        <li>Accédez à <b>Utilisateurs</b>, cliquez sur le nom souhaité dans la liste et sélectionnez l'option <b>Détails de l'utilisateur</b>.</li>
                        <li>Cliquez dans la fenêtre <b>Créer une clé d'API IBM Cloud</b>.</li>
                        <li>Entrez le <b>Nom</b> et la <b>Description</b> de la nouvelle clé d'API.</li>
                        <li>Cliquez sur <b>Créer</b>.</li>
                        <li>Cliquez ensuite sur <b>Afficher</b> pour afficher la clé d'API à copier et sauvegardez-la afin de l'utiliser ultérieurement, ou cliquez sur <b>Télécharger</b>.</li>
                    </ol>
                    <b>Remarque</b> : Pour des raisons de sécurité, la clé d'API est disponible pour copie ou téléchargement uniquement lors de la création. Si la clé d'API est perdue, vous devez en créer une autre. Pour plus d'informations sur la clé d'API de l'utilisateur, voir <a href="https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey">https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey</a>.
                </p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq2" aria-expanded="true" aria-controls="collapse-mfp-dab-faq2"><b>B. Limitations liées au serveur partagé</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq2">
            <div class="panel-body">
                  <p>Le serveur Playground partagé est un serveur commun partagé entre de nombreux développeurs. Il ne doit pas être utilisé pour des applications de production. Il n'est pas possible de supprimer les données de ce serveur sans notification. Le temps de disponibilité du serveur n'est pas garanti.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq3" aria-expanded="true" aria-controls="collapse-mfp-dab-faq3"><b>C. Comment désinstaller complètement Digital App Builder ?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq3">
            <div class="panel-body">
                  <p>Pour désinstaller complètement Digital App Builder, procédez comme suit :
                  <ol><li>Désinstallez Digital App Builder de façon habituelle pour chaque système d'exploitation.</li>
                      <li>Supprimez manuellement les fichiers suivants pour chaque système d'exploitation :
                      <ul><li><b>Windows</b> : <i>Users\worklight\AppData\Roaming\IBM Digital App Builder</i></li>
                          <li><b>MacOS</b> : <i>Users/&lt;systemname&gt;/Library/Application Support/IBM Digital App Builder</i></li>
                      </ul></li>
                  </ol></p>
            </div>
        </div>      
    </div>
</div>
<p>&nbsp;</p>       
