---
title: How to customize the Mobile Foundation Component deployed on IBM Cloud Private (ICP)
date: 2018-10-03
tags:
- MobileFirst_Foundation
- ICP
- IKS
- Customization
- MFP
version:
- 8.0
author: 
    name: Krishna K Chandrasekar
---

During the deployment of the Mobile Foundation Helm charts on the IBM Cloud Private various configuration details are supplied. There are several cases, these configuration settings available on the deployed Mobile Foundation on the ICP needs customizations post deployment especially when the system runs in production scenarios or during the tests.

This blog post assumes that you have already set up IBM Cloud Private and loaded the [IBM Mobile Foundation Passport Advantage Archive](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#download-the-ibm-mfpf-ppa-archive) on ICP.

Following set of instructions shows how can the Mobile Foundation artifacts can be customized once the base PPA package is loaded and the helm charts on deployed on the IBM Cloud Private. 

The MobileFoundation for ICP PPA package contains set of customizable mfp server artifacts structured as follows, 

```
icp-kubernetes/usr-mfpf-server
├── config
│   ├── keystore.xml
│   ├── ltpa.xml
│   ├── mfpfproperties.xml
│   ├── mfpfsqldb.xml
│   ├── registry.xml
│   └── tracespec.xml
├── env
│   ├── jvm.options
│   └── server.env
├── jre-security
│   └── readme.txt
└── security
    ├── keystore.jks
    ├── ltpa.keys
    └── truststore.jks
```
Note: For analytics and app center, please locate the structure under the directory **usr-mfpf-analytics** and **usr-mfpf-server** respectively within the package

###Procedure
Below are the set of steps which explains how the jvm.options file can be customized (say to add the MaxHeap settings) and used for updating the kubernetes pods on the Mobile Foundation Server deployments.

1. As depicted in the mfp server artifacts directory structure, one can create a directory structure in the local directory 

	```
	[root@masternode1 ~]# mkdir -p usr-mfpf-server/env
	[root@masternode1 ~]# cd usr-mfpf-server/env
	```
	This creates the following directory structure that can be used to customize the image on the ICP for modifying the jvm.options
	
	```
	icp-kubernetes/usr-mfpf-server
	├── env
	│   └── jvm.options
	```
2. Create a Dockerfile to overwrite jvm.options as follows
	
	```
	FROM mycluster.icp:8500/default/mfpf-server:1.0.0.1
	COPY jvm.options /opt/ibm/wlp/usr/servers/mfp/jvm.options
	```
3. Let us conside we want to add the MaxHeap size (Xmx) in the jvm.options for the Mobile Foundation Server
	```
	-Dcom.ibm.ws.jmx.connector.client.rest.readTimeout=180000
	-Xmx1024m
	```
4. Build docker image with a new tag name (say 1.0.0.2)

	```
	# docker build . -t mfpf-server:1.0.0.2
	```
This updates the existing mfp-server docker image with the customized jvm.options

5.	Login into ICP cluster and docker registry via commandline

	```bash
	# bx pr login -a https://<icp_cluster_ip>:8443 --skip-ssl-validation -u admin -p xxxx -c <mycluster-account>
	# docker login mycluster.icp:8500 -u admin -p xxxx
	```
6.	Push the new image to the ICP container repository as follows

	```
	# docker tag mfpf-server:1.0.0.2 mycluster.icp:8500/default/mfpf-server:1.0.0.2
	# docker push mycluster.icp:8500/default/mfpf-server:1.0.0.2
	```
7. Check the available Mobile Foundation Server kubernetes as follows

	```kubectl get deployments
	NAME                                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
	mfpserver-ibm-mfpf-server-prod         2         2         2            2           5d
	```
8. Now update Mobile Foundation Server kubernetes deployment **mfpserver-ibm-mfpf-server-prod** to use the customized image 
	
	```
	kubectl edit deployments mfpserver-ibm-mfpf-server-prod
	```
9. Replace **- image: mycluster.icp:8500/default/mfpf-server:1.0.0.1** with **- image: mycluster.icp:8500/default/mfpf-server:1.0.0.2**

10. Once the image is updated in the kube configuration, the mfp server pods are deleted and recreated automatically using the new configuration. Make sure that all the pods are running and ready as follows

	```
	kubectl get pods
	```
11.	Access the pods and verify the updated **jvm.options** file is being used:

	```
	# kubectl exec -it mfpserver-ibm-mfpf-server-prod-bbcf6bcd4-dprsz bash
	root@mfpserver-ibm-mfpf-server-prod-sdd76xs82-pjswe:/# cat /opt/ibm/wlp/usr/servers/mfp/jvm.options
	
	-Dcom.ibm.ws.jmx.connector.client.rest.readTimeout=180000
	-Xmx1024m
	```

The above set of instructions are applicable for customzing any of the mfpserver, analytics or appcenter components running on the ICP.

> For MobileFirst Server on IBM Cloud Private, refer the [documentation](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/)
