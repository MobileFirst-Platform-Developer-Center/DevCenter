---
title: Running Mobile Foundation Server on ICP deployed on IBM SoftLayer
date: 2018-10-03
tags:
- MobileFirst_Foundation
- ICP
- Softlayer
- MFP
version:
- 8.0
author: 
    name: Krishna K Chandrasekar
---

The blog focuses on setting up of MobileFirst Server running on an ICP on SoftLayer VMs or baremetal hosts. The topology that is targeted is an ICP Host with 2 Workers and one master/boot node as represented in the following diagram.

![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-03-running-mfp-deployed-on-icp-on-softlayer/softlayer-mfp-icp-toplogy)

Note: This blog instructions are documented with ICP2.1.0.3 in place, for ICP 3.1 also one can follow the same instructions with suitable binaries for ICP.

###Prequisites 

This blog post focuses on how to use the Apache Directory Server as an LDAP Registry with Mobile Foundation Server on ICP and assumes following

1. IBM SoftLayer Account
2. [IBM Mobile Foundation Passport Advantage Archive](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#download-the-ibm-mfpf-ppa-archive)
3. IBM DB2 Server with Database configured (Either community edition, enterprise or DB2 service on IBM Cloud)

###Procedure
Below instructions lists all the steps required to setup the Mobile Foundation Server on ICP installed on SoftLayer VM.

####A. Setting up of Bare metal Machines (x86) running Ubuntu 16.04 on IBM SoftLayer

1. Logon to https://control.softlayer.com/ with your SoftLayer Account
2. Create two new Baremetal x86_64 bits machine with Ubuntu 16.04 installed with the required Region/DataCenter (Recommended: 16Gig Memory, Quad Core, 250GB Storage) 
3. Wait for few minutes IBM SoftLayer to provisions a Ubuntu 16.04 VM. 

####B. Setting up the Master / Proxy / Worker Nodes for Installing ICP

For both master node (boot, master and proxy) and two worker nodes, both running Ubuntu 16.04 and SSH enabled for **root** user.

1. From Terminal, login into the Worker Node-1 as **root** user
2. Disable the firewall
	
	```
	[root@ home]# /usr/sbin/ufw disable
	```
3. Enable NTP

	```
	[root@ home]# /usr/bin/timedatectl set-ntp on
	```

4. Set **vm.max_map_count** to at least **262144**
	
	```
	[root@ home]# /sbin/sysctl -w vm.max_map_count=262144
	[root@ home]# /bin/echo "vm.max_map_count=262144" | /usr/bin/tee -a /etc/sysctl.conf
	```

5. Prepare the system for updates, install Docker and install Python

	```
	 [root@ home]# /usr/bin/apt update
	 [root@ home]# /usr/bin/apt-get --assume-yes install docker.io
	 [root@ home]# /usr/bin/apt-get --assume-yes install python
	 [root@ home]# /usr/bin/apt-get --assume-yes install python-pip
	 [root@ home]# /bin/systemctl start docker
	```
	
6. Ensure the hostname is resolvable

	```
	[root@ home]# ifconfig -a 
	```
	 Make a note of interface name the IP is bound to "eth0" or "ens7" or "eth1" etc
	
	```
	[root@ home]# IP=<IP_address_of_this_worker_machine>
	[root@ home]# /bin/echo "${IP} $(hostname)" >> /etc/hosts
	```

7. Check dockers status to make sure there are no errors

	```
	[root@ home]# /bin/systemctl status docker
	```	
8. Check no docker containers exist at present

	```
	docker container list 
	```
	This should not list any containers 

9. Run Docker pull hyperkube

	```
	docker pull ibmcom/hyperkube:v1.10.0
	```

NOTE: Please repeat this for all nodes. At this point the manual configuration of the worker nodes is complete.

#### C. Installation of the Master Node 

Further configuration is required on the master node (please note this node is running boot, master and proxy functions). Login into the Master Node as **root** user.

1. Download ibm-cloud-private-*.tar.gz  from IBM Passport Advantage - do not unzip/untar as this gz file is used for the installation. 

2. Unpack the ICP binary downloaded above, and load into docker
3. 
	```
	[root@ home]# TMP_DIR="$(/bin/mktemp -d)"
	[root@ home]# cd "${TMP_DIR}"
	```
4. Move the ibm-cloud-private-x86_64-2.1.0.tar.gz file to the current directory
	
	```
	[root@ home]# mv <download_location>/ibm-cloud-private-x86_64-2.1.0.3.tar.gz .
	[root@ home]# ls -l *.gz
	```
4. Unzip the file and load into docker

	```
	[root@ home]# /bin/tar xf *.tar.gz -O | /usr/bin/docker load
	```
5. Set the ICP parameters needed for installation and prepare the environment by running following commands from the terminal

	```
	ICP_DOCKER_IMAGE="ibmcom/icp-inception"
	ICP_VER="2.1.0.3"
	ICP_ROOT_DIR="/opt/ibm-cloud-private-ee"
	mkdir "${ICP_ROOT_DIR}-${ICP_VER}"
	cd "${ICP_ROOT_DIR}-${ICP_VER}"
	/usr/bin/docker run -e LICENSE=accept -v "$(pwd)":/data ${ICP_DOCKER_IMAGE}:${ICP_VER}-ee cp -r cluster /data
	mkdir -p cluster/images
	mv ${TMP_DIR}/*.tar.gz ${ICP_ROOT_DIR}-${ICP_VER}/cluster/images/   # moves the image to the image directory
	rm -rf "${TMP_DIR}"     # clean up the tmp directory
	```

6. Create the cluster/hosts file ready for installation

	```
	/bin/echo "[master]"  > cluster/hosts
	/bin/echo "${IP}"    >> cluster/hosts
	/bin/echo "[proxy]"  >> cluster/hosts
	/bin/echo "${IP}"    >> cluster/hosts
	```

	Add the worker node IPs
	
	```
	/bin/echo "[worker]"     >> cluster/hosts
	echo "x.x.x.x" >> cluster/hosts
	echo "z.z.z.z" >> cluster/hosts     
	```
	Here x.x.x.x is the IP of the WorkerNode-1 (here for this topology, MasterNode IP) and z.z.z.z is the IP of the WorkerNode-2

7. Check the **cluster/hosts** file

	```
	[root@ home]# cat cluster/hosts

	Output
	[master]
	y.y.y.y
	[proxy]
	y.y.y.y
	[worker]
	x.x.x.x
	z.z.z.z
	```

8. Setup SSH keys from master node (boot, master and proxy) to remaining nodes
	
	```
	ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N ""
	cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys
	ssh-copy-id -i ~/.ssh/id_rsa.pub root@x.x.x.x   # copy key to worker nodes
	ssh-copy-id -i ~/.ssh/id_rsa.pub root@y.y.y.y   # copy key to worker nodes
	chmod 400 /root/.ssh/id_rsa.pub
	```
	
9. Test ssh login works without a password

10. Move the key to ICP config
	
	```
	cp ~/.ssh/id_rsa ${ICP_ROOT_DIR}-${ICP_VER}/cluster/ssh_key
	```

12. From Master Node, test you can ssh to the worker nodes without a password

	```
	ssh root@<worker_node_ip>
	```

13. Configure the **cluster/config.yaml** file to suit to your environment. You might want to consider changing the following options:

	```yaml
	cluster_name: mycluster
	calico_ip_autodetection_method: interface=<your primary interface e.g. eth0>
	cluster_access_ip: y.y.y.y   # The primary IP address of your master node
	```
	
#### D. Deploying ICP Enterprise Edition

You are now ready to run the ICP installation process, which are a set of Ansible playbooks.

	```
	cd "${ICP_ROOT_DIR}-${ICP_VER}/cluster"
	/usr/bin/docker run -e LICENSE=accept --net=host -t -v "$(pwd)":/installer/cluster ${ICP_DOCKER_IMAGE}:${ICP_VER}-ee install | /usr/bin/tee install.log
	```
	
This will take between 30-50 minutes, depending on your machine size and network speed. The installation script has to copy code to the worker nodes and install into containers

If you face any challenges during the installation that leads to failure. Uninstall ICP, run the following command and retry the previous installation step

```
cd "${ICP_ROOT_DIR}-${ICP_VER}/cluster"
/usr/bin/docker run -e LICENSE=accept --net=host -t -v "$(pwd)":/installer/cluster ${ICP_DOCKER_IMAGE}:${ICP_VER}-ee uninstall | /usr/bin/tee uninstall.log
```

**Sample Output:**

```
PLAY RECAP *********************************************************************
y.y.y.y          : ok=201  changed=66   unreachable=0    failed=0   
z.z.z.z          : ok=123  changed=51   unreachable=0    failed=0   
x.x.x.x          : ok=123  changed=51   unreachable=0    failed=0   
localhost        : ok=216  changed=114  unreachable=0    failed=0   

POST DEPLOY MESSAGE ************************************************************

UI URL is https://<master_ip>:8443 , default username/password is admin/admin

Playbook run took 0 days, 0 hours, 41 minutes, 35 seconds
```

####E. Setting up of MobileFirst Server on ICP####

Below instructions shows the complete list of steps to deploy MFP helm on ICP

**Setup the ibmcloud cli environment**

Run the following instructions from the client terminal from which ICP environment can be accessed. (here Mac OSX)

1. Install the ibmcloud cli by using following command.

	```
	curl -sL http://ibm.biz/idt-installer | bash
	```

2. Install the *bx pr* plugin 

	```
	curl -O https://<myicphost>:8443/api/cli/icp-darwin-amd64 --insecure
	bx plugin install icp-darwin-amd64
	```

3. Appending the IP hostname to the /etc/hosts file

	```
	echo "<icp_master_node_ip>  mycluster.icp" >> /etc/hosts
	```

4. Make sure the hostname is correct

	```
	 cat /etc/hosts  # to make sure hostname is set correctly
	```
5. Open the *Docker Preferences > Daemon > Click Tab Basic > Under insecure-registries*, add **mycluster.icp:8500** as shown in the following image

	![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-03-running-mfp-deployed-on-icp-on-softlayer/docker-preference-client.png)

6. Click Apply & Restart

**Load the MFP PPA archive to the ICP repo**

1. Download the IBM Mobile Foundation for ICP archive from IBM Passport Advantage 
2. Login into the ICP cluster

	```
	bx pr login -a https://mycluster.icp:8443 -u admin -p admin -c id-mycluster-account --skip-ssl-validation
	```
3. Load the PPA Archive of Mobile Foundation using the following command: (This takes around 30-40 minutes, depends on network speed)
	
	```
	bx pr load-ppa-archive --archive <archive_name>
	    
	Example: 
	bx pr load-ppa-archive --archive 8.0.0.0-MFPF-Server-ICp-XXXXX.tar.gz
	```
4. After you load the PPA Archive, synch the repositories, which ensures the listing of Helm Charts in the Catalog. You can do this in IBM Cloud Private management console.
		Select *Admin > Repositories > Synch Repositories*
5. View the Docker images and Helm Charts in the IBM Cloud Private management console. To view Docker images, Select *Platform > Images*

**Install and configure IBM Mobile Foundation Helm Charts**

1. [Mandatory] a DB2 database configured and ready to use. Before you begin the installation of MobileFirst Server ensure that you have pre-configured a DB2 database. Following details are required to configure the Helm.

	```
	   MFPF_ADMIN_DB2_SERVER_NAME=dashdb-txn-small-sample-service-dal01-services.dal.bluemix.net
	   MFPF_ADMIN_DB2_PORT=50000
	   MFPF_ADMIN_DB2_DATABASE_NAME=BLUDB
	   MFPF_ADMIN_DB2_USERNAME=admin
	   MFPF_ADMIN_DB2_PASSWORD=thisisadummypassword
	   MFPF_ADMIN_DB2_SCHEMA=<any_Schema_name>
	```
	
 2. From the ICP Catalog choose *ibm-mfpf-server-prod* helm chart to configure and Click on Install.
 
    Deployment takes around 10-15 minutes for the services to come up after completing the health checks, pod running.

**Verifying the MFP deployment**

1. Locate the deployed MFP Server Helm Chart on the ICP Console *Menu > Workloads > Helm Releases* > Click on the mfp server's helm

2. Make sure the pods are in Running State as show in the below screenshot

	![Test Apps Script]({{site.baseurl}}/assets/blog/2018-10-03-running-mfp-deployed-on-icp-on-softlayer/mfp-server-ready-deployed.png)

3. Run the commands shown in the *Notes* page, to view the console URL which looks as follows.

####References

1. [Setting up MobileFirst Server on IBM Cloud Private](https://mobilefirstplatform.ibmcloud.com/tutorials/fr/foundation/8.0/bluemix/mobilefirst-server-on-icp/)

2. [Implementing IBM Cloud Private EE and CE on IBM Power8](https://www.ibm.com/developerworks/community/blogs/6eaa2884-e28a-4e0a-a158-7931abe2da4f/entry/Implementing_IBM_Cloud_Private_CE_and_EE_on_IBM_Power8?lang=en)
