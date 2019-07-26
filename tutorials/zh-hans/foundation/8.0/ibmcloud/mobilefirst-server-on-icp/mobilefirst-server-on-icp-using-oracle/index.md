---
layout: tutorial
title: Setting up Mobile Foundation with Oracle database on IBM Cloud Private
breadcrumb_title: Foundation with Oracle DB on ICP
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview}

Out of the box IBM Mobile Foundation - ICP PPA package supports the use of IBM DB2 server. This tutorial focuses on extending the Mobile Foundation deployed on IBM Cloud Private (ICP) to use a remote Oracle database for storing Mobile Foundation data.

## Assumption
{: #assumption }
Before proceeding with the tutorial, following assumptions are made:

* You have already set up IBM Cloud Private and loaded the IBM Mobile Foundation Passport Advantage Archive on ICP.
* Setup of Mobile Foundation database tables that are created manually on a remote Oracle database server ([Download]((customizable-db-artifacts-for-mfp-icp.zip)) and refer to the db scripts for Oracle database for Mobile Foundation server).
* IBM Cloud Private CLI tooling is installed on the local computer (`bx pr`, `docker`, `kube` or `cloudctl`, etc.)

>**Note:** During the helm deploy for DB2 databases, the tables are created automatically. For Oracle, PostgreSQL, or MySQL you have to create the tables manually before deploying the helm chart.

## Artifacts that needs to be customized
{: #artifacts-to-be-customized }

The docker image of Mobile Foundation server has certain artifacts that can be customized to enable the Oracle DB support. Following are the files within the docker image that needs to be modified in order to have the containers created with Oracle related artifacts and configs.
1.	`mfpdbconfig.sh`.
2.	`mfpfsqldb.xml` - modified to support Oracle DB and related data sources.
3.	Include Oracle client JBDC driver.
4.	Update `server.xml`.

>**Note:** The above file names are to be kept same in order to customize the base docker image.


### Procedure
{: #procedure}

1.	From the ICP console **Catalog**, ensure that the `ibm-mfpf-*` helm charts are loaded.
2.	Unzip the attachment (`mfp-icp-oracle.zip`) to locate the `Dockerfile` and `usr-mfpf-server` that shows the directory structure and a sample `Dockerfile` for use.
3.	Modify the `Dockerfile` in such a way so as to use the image version correction on which the docker image has to be extended.<br/>
     *Example :*<br/>
      `FROM mycluster.icp:8500/default/mfpf-server:<a.b.c.d>`<br/>
       *a.b.c.d* is the image version which is available in the image registry.
4.	Follow the instructions in the blog for customizing the docker image and create the Mobile Foundation server pods.
5.	Once the docker image is extended with the above steps, the ICP console can be used to deploy the Helm chart for the Mobile Foundation server. Make sure the new image is supplied.

For customization or extending the docker image see [how to customize the Mobile Foundation component deployed on IBM Cloud Private (ICP)](https://mobilefirstplatform.ibmcloud.com/blog/2018/11/04/customize-mfp-on-icp/).

>**Note:** For MySQL and PostgreSQL databases the appropriate JDBC drivers has to be used.
