---
title: Using LDAP registry on Mobile Foundation deployed on IBM Cloud Private (ICP)
date: 2018-11-04
tags:
- MobileFirst_Foundation
- IBM_Cloud_Private
- IKS
- Customization
- LDAP
- Mobile_Foundation
version:
- 8.0
author: 
    name: Krishna K Chandrasekar
---

When Mobile Foundation (MFP) Server Helm chart is deployed on IBM Cloud Private it uses **basicRegistry** along with various other configuration details.  This user registry is good enough for basic development and testing environments, but for production scenarios LDAP registry is used. 

This blog focuses on how to use Apache Directory Server as an LDAP registry against the Mobile Foundation server that is deployed on IBM Cloud Private (or IBM Cloud Kubernetes Service, IKS).

This blog post focuses on how to use the Apache Directory Server as an LDAP Registry with Mobile Foundation Server on ICP and assumes the following:

a) User has an MFP setup on IBM Cloud Private loaded with [IBM Mobile Foundation Passport Advantage Archive](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#download-the-ibm-mfpf-ppa-archive) on ICP.

b) User has the knowledge of LDAP Registry.

###	Procedure

1. [Optional] Make sure the configured LDAP Registry works with MFP devkit and the MFP console is accessible to the ldap users instead of basic users that comes Out-of-box.
2. From the Apache Directory Studio, make sure that the LDAP is configured correctly. For instance this article uses the following ldap setting.

	![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-03-customizing-mfp-on-icp-ldap-registry/apache-ds-ldap-config-on-studio.png)

3. Create **registry.xml** as follows

	```bash
	[root@masternode1 ~]# mkdir -p usr-mfpf-server/config
	[root@masternode1 ~]# cd usr-mfpf-server/config
	```
	This creates the following directory structure that can be used to customize the image on the ICP for modifying the registry.xml
	
	```bash
	icp-kubernetes/usr-mfpf-server
	├── config
	│   └── registry.xml
	```
4. Create a Dockerfile to overwrite *jvm.options* as follows
	
	```bash
	FROM mycluster.icp:8500/default/mfpf-server:1.0.0.1
	COPY jvm.options /opt/ibm/wlp/usr/servers/config/registry.xml
	```
5. Create a file **registry.xml** with LDAP registry configuration as follows:

	```xml
	<?xml version="1.0" encoding="UTF-8"?>
	<server>
	<featureManager>
    <feature>appSecurity-2.0</feature>
    <feature>ldapRegistry-3.0</feature>
	</featureManager>
	<ldapRegistry id="ldap" host="yathendra.local" port="10389" ignoreCase="true" baseDN="dc=ibm,dc=com" ldapType="Custom" recursiveSearch="true" sslEnabled="false" bindDN="uid=admin,ou=system" bindPassword="secret">
	<customFilters userFilter="(&amp;(uid=%v)(objectclass=inetOrgPerson))" groupFilter="(&amp;(member=uid=%v (objectclass=groupOfNames))" userIdMap="*:uid" groupIdMap="*:cn" groupMemberIdMap="ibm-allGroups:member;ibm-allGroups:uniqueMember;groupOfUniqueNames:uniqueMember;groupOfNames:member"/>
	 <group name="mfpadmingroup">
	 	<member name="adminuser"/>
	 </group>
	 <group name="mfpconfiggroup">
	 	 <member name="configUser_mfpadmin"/>
	 </group>
	 <member name="MfpRESTUser"/>
	 <member name="Push_MFPLDAPPOC"/>
	 <member name="Admin_MFPLDAPPOC"/>
	</ldapRegistry>
	</server>
	```
	>**Note:** Make sure the right user and group details are used according to your own LDAP server settings.
	
6. Build docker image with a new tag name (say 1.0.0.2)

	```bash
	# docker build . -t mfpf-server:1.0.0.2
	```
This updates the existing mfp-server docker image with the customized registry.xml.

7.	Log in to the ICP cluster and docker registry via commandline:

	```bash
	# bx pr login -a https://<icp_cluster_ip>:8443 --skip-ssl-validation -u admin -p xxxx -c <mycluster-account>
	# docker login mycluster.icp:8500 -u admin -p xxxx
	```
8.	Push the new image to the ICP container repository as follows:

	```bash
	# docker tag mfpf-server:1.0.0.2 mycluster.icp:8500/default/mfpf-server:1.0.0.2
	# docker push mycluster.icp:8500/default/mfpf-server:1.0.0.2
	```
9. Check the available Mobile Foundation Server deployment on Kubernetes as follows:

	```bash
	kubectl get deployments
	NAME                                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
	mfpserver-ibm-mfpf-server-prod         2         2         2            2           5d
	```
10. Now update Mobile Foundation Server kubernetes deployment **mfpserver-ibm-mfpf-server-prod** to use the customized image. 
	
	```bash
	kubectl edit deployments mfpserver-ibm-mfpf-server-prod
	```
11. Replace **- image: mycluster.icp:8500/default/mfpf-server:1.0.0.1** with **- image: mycluster.icp:8500/default/mfpf-server:1.0.0.2**

12. Once the image is updated in the kube configuration, the mfp server pods are deleted and recreated automatically using the new configuration. Make sure that all the pods are running and ready using the command below:

	```bash
	kubectl get pods
	```
13. Log in to the ICP Console with one of the configured LDAP user (here **adminuser**) and make sure the login is successful and all the services are up and running from the Mobile First Server Operations Console.

The above set of instructions are applicable for using any other LDAP servers like IBM Directory Server, Microsoft Active Directory Server etc.

> For more details on Configuring LDAP user registries in Liberty, refer to the [documentation](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ldap.html) 
