---
layout: tutorial
title: Preguntas frecuentes
breadcrumb_title: FAQs
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #faq }

En este tema se describe la lista de preguntas más frecuentes relacionadas con IBM Digital App Builder.

<div class="panel-group accordion" id="mfp-dab-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq1" aria-expanded="true" aria-controls="collapse-mfp-dab-faq1"><b>A. ¿Cómo se crean las claves de API de la plataforma?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq1">
            <div class="panel-body">
                <p>
                    <ol>
                        <li>Vaya a <a href="https://cloud.ibm.com/iam#/users" target="_blank">https://cloud.ibm.com/iam#/users</a> después de iniciar una sesión en IBM Cloud. </li>
                        <li>Vaya a <b>Usuarios</b>, pulse su nombre en la lista y seleccione la opción <b>Detalles de usuario</b>. </li>
                        <li>Pulse la ventana <b>Crear una clave de API de IBM Cloud</b>. </li>
                        <li>Especifique el <b>Nombre</b> y la <b>Descripción</b> para la nueva clave de API.</li>
                        <li>Pulse <b>Crear</b>.</li>
                        <li>A continuación, pulse <b>Mostrar</b> para visualizar, copiar y guardar la clave de API para más tarde, o pulse <b>Descargar</b>. </li>
                    </ol>
                    <b>Nota</b>: Por razones de seguridad, la clave de API sólo está disponible para copiarse o descargarse en el momento de la creación. Si se pierde la clave de API, deberá crear una nueva clave de API. Para obtener más información sobre la clave de la API, consulte <a href="https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey">https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey</a>.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq2" aria-expanded="true" aria-controls="collapse-mfp-dab-faq2"><b>B. Limitaciones de un servidor compartido</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq2">
            <div class="panel-body">
                  <p>El servidor Playground compartido es un servidor común que se comparte entre muchos desarrolladores. Este servidor no se debe utilizar para aplicaciones de producción. Los datos de este servidor se pueden suprimir sin previo aviso. El tiempo de actividad del servidor no está garantizado.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq3" aria-expanded="true" aria-controls="collapse-mfp-dab-faq3"><b>C. ¿Cómo se desinstala por completo Digital App Builder?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq3">
            <div class="panel-body">
                  <p>Puede desinstalar por completo Digital App Builder siguiendo estos pasos:
                  <ol><li>Desinstale Digital App Builder del modo habitual para cada sistema operativo. </li>
                      <li>Suprima manualmente lo archivos siguientes para su sistema operativo.
                      <ul><li><b>Windows</b> - <i>Users\worklight\AppData\Roaming\IBM Digital App Builder</i></li>
                          <li><b>MacOS</b> - <i>Users/&lt;systemname&gt;/Library/Application Support/IBM Digital App Builder</i></li>
                      </ul></li>
                  </ol></p>
            </div>
        </div>      
    </div>
</div>
<p>&nbsp;</p>       
