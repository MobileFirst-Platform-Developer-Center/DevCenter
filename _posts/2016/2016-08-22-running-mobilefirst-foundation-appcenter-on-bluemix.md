---
title: 'Running MobileFirst Foundation 8.0’s Application Center on Bluemix'
date: 2016-08-22
tags:
- MobileFirst_Foundation
- AppCenter
- Bluemix
- dashDB
- Liberty
version:
- 8.0
author:
  name: Andrii Vasylchenko
---
Follow the steps detailed below to setup MobileFirst Foundation 8.0's Application Center on Bluemix using Liberty and dashDB. It consist from three sections that will guide you though the whole setup process. All instructions were recorded on macOS, but you can use also almost any Linux or Windows environment.

> **Note:** The below is experimental in nature.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/k4C6ZP18I_E"></iframe>
    </div>
</div>

### Application Center on Bluemix Labs

**Time to complete:** 1 hour

**Prereq:** To follow the labs you will need files from installed MobileFirst Foundation 8.0 Server location. If you do not have it installed, you will need to setup it first. Afterwards, you will need to access the content of ApplicationCenter folder inside server installation location (for example, default path for linux will be /opt/IBM/MobileFirst_Platform_Server/ApplicationCenter).

**Labs videos for offline watch:** [Dropbox](https://www.dropbox.com/sh/25z5lvm21qpjwre/AABaO9pXsxsJa2KtywjhjF2ya?dl=0) | [OneDrive](https://1drv.ms/f/s!ArRVJ_BgeJEFiiqsPSuo0AxhPhX6)

<div class="panel-group accordion" id="accordion" role="tablist" aria-multiselectable="true">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="headingTwo">
            <h4 class="panel-title">
                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Create database instance on Bluemix using dashDB service</a>
            </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
            <div class="panel-body">
                <b>Description:</b> Using Bluemix create dashDB and then use sql script to prepare application center database.
                <br>
                <b>Time to complete:</b> 10 minutes
                <br>
                <b>Lab number for offline usage:</b> 8.4
                <br>
                <br>
                <div class="sizer">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/76WP6BxQvJc"></iframe>
                    </div>
                </div>

                <br>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="headingThree">
            <h4 class="panel-title">
                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">Configure Liberty profile server instance locally and connect it to database on Bluemix</a>
            </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
            <div class="panel-body">
                <b>Description:</b>Setup Liberty profile runtime locally, setup Application Center on it using remote database on Bluemix.
                <br>
                <b>Time to complete:</b> 30 minutes
                <br>
                <b>Lab number for offline usage:</b> 8.5
                <br>
                <br>
                <div class="sizer">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/4fYGBKIbkn8"></iframe>
                    </div>
                </div>

                <br>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="headingFour">
            <h4 class="panel-title">
                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">Replace push notification related code and configure server side to send push messages</a>
            </h4>
        </div>
        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
            <div class="panel-body">
                <b>Description:</b>Using CF CLI push current local server configuration to Bluemix runtime instance and then verify Application Center setup using test device installation.
                <br>
                <b>Time to complete:</b> 15 minutes
                <br>
                <b>Lab number for offline usage:</b> 8.6
                <br>
                <br>
                <div class="sizer">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/7c5Y2rXmz7M"></iframe>
                    </div>
                </div>
                <br>
            </div>
        </div>
    </div>
</div>
