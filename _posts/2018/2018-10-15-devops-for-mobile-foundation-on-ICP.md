---
title: 'Devops for Mobile Foundation on IBM Cloud Private (ICP) '
date: 2018-10-15
tags:
- MobileFirst_Foundation
- ICP
- DevOps
version:
- 8.0
author: 
name: Shinoj Zacharias
additional_authors:
- Prashanth Bhat
---

## Introduction
Devops is a technique used by enterprise for faster delivery of software and thus improving the time to market. The DevOps pipeline for [Mobile Foundation on IBM Cloud Private](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/) helps in automating tasks that are required to setup a continous delivery of mobile apps. The tasks such as  deployments of Mobile Foundation on ICP, building and deployment apps and adatpers on to MF deployed on ICP, testing apps and adapters and updating the Mobile Foundation deployments on ICP can be automated using a DevOps pipleline.

In this blog post we will walk you through the steps of creating a DevOps pipeline for Mobile Foundation on ICP using Jenkins. The Jenkins jobs use the combination of ICP, Helm and mfpdev command line to automate the different stages in the pipeline. The jobs can be configured in such a way that whenever developers commit a code change to git repository, the pipeline can be automatically triggered to perform a fresh deployments of Mobile Foundation on ICP followed by building of apps and adatper and registering it with Mobile Foundation Server running on ICP followed by testing both apps and adatper and finally tearing down the Mobile Foudation deployment on ICP

## DevOps Pipeline
The DevOps pipeline that is described in this blog is built by using Jenkins. In this blog post we assume Jenkins is installed locally within the organization's intranet.  ICP provides helm charts for Jenkins deployments that you could use to build the DevOps pipeline, but ICP may run the Jenkins job on a new pod everytime a jobs is run, and that would require every jobs to have the scripts to install necessary software such as mfpdev command line, maven, helm etc that is required to run the job. This may have performance impact on execution of jobs. So it is recommended to have locally installed Jenkins server and client for this purpose, which can connect to the ICP running on your data center. The Jenkins jobs that is used for creating DevOps pipeline for MF on ICP is shown below.

![Jenkins Job View]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/jobs_view.png)

We will now discuss each of these jobs in details.

### Setting up the Jenkins build machine
As mentioned earlier, we will be using Jenkins that is installed locally for running Jenkins job. This jobs install all the prerequisite software required to run the Jenkins jobs. The job needs to be run only once on the build machine. The jobs installs IBM Cloud CLI (Bluemix CLI), IBM Cloud Private Command Line, Helm Command Line, NodeJS, Maven, MFP Dev CLI and Android SDK. These Commad Line Tools are needed for running the rest of the Jobs in the pipeline such as building apps and adapters and testing them. The scripts for setting up the build can be found in the attachment. A snapshot of the script for the same is given below

![Set Up Jenkins Build Machine]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/setup_build_machine_scripts.png)

### Deploy MF on ICP
Once the build machine is setup, which is a one time activitiy, the other jobs can run. The jobs can be linked together to create an end-to-end devops pipeline. You can configure Jenkins jobs in such a way that whenever an app or adapter change is committed to git repositoy, a job can be kicked-off. You can choose to test the changes on a fresh MF deployments by configuring the *deploy_mfp_on_ICP* job to listen to the changes in the source repository. If you don't require to test the app and adatper changes on a new deploment of MF on ICP, you can skip this job from the pipeline. The apps and adapter source code is publically available in git repo.

![GIT Repository for MF Apps and Adatper]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/Git_repo_for_app_adapter.png)

The scripts for deploying MF on ICP requries details of the ICP cluster and DB credentials (In this pipeline we use DB2 as the database), that can be provided as parameters for the Jenkins jobs. The parameters are used internally in the scripts of the job.

![Deploy MF on ICP Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/deploy_mfp_on_icp_parameters.png)

The screen snapshot of the scripts that perform the deployment of MF on ICP is shown below. The scripts uses the helm commands to deploy MF server and Analytics Server onto ICP.  The script is available in the attachment.

![Deploy MF on ICP Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/deploy_mfp_on_icp.png)

Once the Jenkins job is successfully completed, MF deployment can be seen from the ICP deployments dashboard, as shown in the snapshot.

![MF Deployment on ICP]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/mf_deployment_on_icp.png)

### Build And Deploy Adapter
After MF is deployed on ICP, adapters can be built and deployed on MF for testing the changes. This is automated by *build_and_deploy_adapter* Jenkins job . The job can be configured to be run after the previous job, *deploy_mfp_on_ICP* is successfully completed. This job build the adapter using mfpdev cli and uses the MF deployment end-points to deploy the adapter to MF that is running on ICP. 

![GIT Repository for MF Apps and Adatper]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/Git_repo_for_app_adapter.png)

The scripts for building and deploying adapter requires details of ICP cluster and credential to login to ICP. These details are provided as parameters to Jenkins job

![Build And Deploy Adapter Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/build_and_deploy_adapter_parameters.png)

The screen snapshot of the scripts that perform the building of adapter and deploying it to MF is shown below. The script uses mfpdev cli for building and deploying the adapter. The script is available in the attachment.

![Build And Deploy Adapter Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/build_and_deploy_adapter_script.png)

After successful completion of the job, the adapter would have deployed on MF running on ICP as shown in the image

![Adapter Deployed on MF on ICP]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/adapter_deployed_MF_on_ICP.png)

### Test Adapter
*Test_Adapter* job performs unit tests on the adapter that was built and deployed in the earlier Jenkins job. This way any adatper changes can be tested using unit tests. For this DevOps pipeline, the tests that are written to test the adapter end-points is available under the *tests* folder of Adapter git repository. You can add all the tests under this folder and these scripts can be executed from the job's scripts. The job can be configured to be run after the previous jobs *build_and_deploy_adapter* is successfully completed.

![GIT Repository for Adapter Tests]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/Git_repo_for_app_adapter.png)

This job also require the same set of parameters that was mentioned in the previous job. The parameters are referred in scripts that is used to automate the job.
The script first gets the deployment end-point of MF. The MF end-point is then used to register confidential client that is required to test adapter endpoint from the unit tests. The screen snapshot of the script is shown below, the complete script is available from the attachment.

![Test Adapter Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/test_adapters_script.png)

### Build And Deploy Apps
Any app changes commited to the git repository can be built using this job. In this DevOps pipeline, we are using Fastlane for building the Android app. The app that is built is then published to another git repository to be used later in the *test_app_with_bitbar* Jenkins Job. The git repository for apps is same as the git repo that is used for adapter.

![GIT Repository for MF Apps and Adatper]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/Git_repo_for_app_adapter.png)

The parameters required for the runing the script includes the ICP cluster details and credential to login to the ICP as well as the git url for publishing the app that is built. In this DevOps pipeline, we use the GIT Push Token, that can be found from the GIT settings page. You need to use your own GIT repo for publishing the app and provide the GIT details such as url, token and publish url as shown in the image below

![Build And Deploy Apps Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/build_and_deploy_app_parameters.png)

The scripts for automating building and deploying the app uses Fastlane for building the android app and mfpdev cli for registering the app with MF deployed on ICP. It uses the git commands to publish the .apk file that was built by Fastlane.

![Build And Deploy Apps Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/build_and_deploy_app_scripts.png)

Once the job is successfully completed, the app would have registered with MF running on ICP as shown in the image

![Apps Deployed on MF on ICP]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/apps_deployed_MF_on_ICP.png)

### Test App With Bitbar
Once the app is built and registered with MF, the app can be tested. We use Bitbar cloud testing for functional testing of the app. Before you can test the app, you need to create a Bitbar cloud instance. The Bitbar service can be created from IBM Cloud. If you are using Bitbar cloud for testing, you need to work with Bitbar to open-up the port in ICP to connect it from Bitbar to test app running on MF on ICP. For functional testing of app on Bitbar cloud, we use the Appium tests. We use different git repository for tests that are used for testing the apps.

![App Tests GIT Repository]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/test_apps_tests_git_repo.png)

The parameters required to run the Jenkins job requires git repository where the built app was published in the  previous *build_and_deploy_app* job and the bitbar cloud details such as BitbarAPIKey and ClientType etc. The parameters required is shown in the image

![Test App With Bitbar Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/test_app_parameters.png)

The script to run the tests on Bitbar is invoked using maven, that is shown in the screen snapshot 

![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/test_app_scripts.png)

Note that, we used Bitbar cloud for testing the app. You can use any of the testing tools of your choice for testing the apps that can be run locally on your organization's intranet, without going to the public network to connect to cloud testing vendors like Bitbar cloud. 

This job can be configured to run after previous job for *build_and_deploy_apps* is successfully completed. Once the job is successfully completed, the status of app tested can be viewd in Bitbar dashboard

![Bitbar Dashboard]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/bit_bar_test_status.png)

### Delete MF on ICP
This Jenkins job will clean up the MF on ICP after all the previous jobs are successfully completed. Cleaning up MF on ICP helps in leaving no traces of previous pipeline run and helps in tear down the MF after completion of pipeline run. You can choose not to perform this phase in pipeline if you don't wish to clean-up the environment after every successful build of the pipeline. This means that the jobs for deploying MF on ICP and Deleting MF on ICP can be taken out from the continous build and testing of apps and adapter pipeline. 

For this Job to be run, we need to provide the ICP cluster connection credentials and release name as shown in the image

![Delete MF on ICP Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/delete_mfp_on_icp_parameters.png)

The script for *delete_mfp_on_icp* job uses the helm commands to delete the MF deployment. Note that as part of the MF deployments, we have also deployed MF Analtyics. So this job performs the deletion of both MF and Analystics deployment.

![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/delete_mfp_on_icp_scripts.png)

### Upgrade MF on ICP
It is often required to upgrade the MF on ICP whenever the latest version of MF for ICP is released.  This job can be used to upgrade MF and Analytics on ICP.
This job needs the credentials of ICP cluster and Release name

![Upgrade MF on ICP Job Parameters]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/delete_mfp_on_icp_parameters.png)

The scripts uses the helm command to upgrade the deployment for MF and Analytics on ICP

![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/upgrade_mfp_on_icp_scripts.png)

## DevOps Pipeline for Development, Test and Production
What we have seen in the blog is a DevOps pipeline for development evironment, where developers make changes to apps and adapter and commits the changes to git repository. Whenever the changes are commited to git repository, the pipeline is configured to run the phases (jobs) such as deploying MF on ICP, building and testing apps and adapter and finally deleting the MF deployment from ICP.  This is how a standard devops pipeline can be created for development environment. Based on your requiirement the jobs can be linked to create a continous delivery pipeline for development.

The DevOps pipeline for Test is very similar to development, the only difference is that for test environment, instead of kicking off the pipeline for each of the git commit, it can be configured to run at regular interval (nightly) or twice in a day. This way all the changes delivered to git repository gets tested in the test environment at regular interval.

In the case of DevOps for Production environment, you will not be using/running all the jobs that we discussed in the blog, rather you will be having jobs for registering the app and deploying the adapter after the app and adapters was successfully tested in the Test environment.

### Attachment
The zip file [MF_on_ICP_Jenkins_Job_Scripts]({{site.baseurl}}/assets/blog/2018-10-15-devops-for-mobile-foundation-on-ICP/MFP_on_ICP_Jenkins_Job_Scripts.zip) includes all the scripts used for the Jenkins jobs described in this blog. The scripts assume that Jenkins job parameters are set correctly before running the pipeline.



 



