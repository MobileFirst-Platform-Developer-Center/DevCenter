---
title: Securing Mobile Foundation deployments on IBM Cloud Private using your own security certificates
date: 2018-10-03
version:
- 8.0
tags:
- Mobile_Foundation
- MobileFirst_Foundation
- Security
- IBM_Cloud_Private
author:
  name: Krishna K Chandrasekar
---
IBM Mobile Foundation deployments on ICP has https enabled by default with NodePort. To enable with your own security certificates (for both NodePort and ingress) follow the below details.
 
###Case A : During setting up of MobileFoundation on ICP

In general, we enable the https by configuring keystore and truststore during the deployment at the time of intial setting up of Mobile Foundation on ICP as follows.

1. Create a secret with keystore.jks, keystore-password.txt, truststore.jks, truststore-password.txt and provide the secret name in the field keystores.keystoresSecretName.

2. Keep the files keystore.jks and its password in a file named keystore-password.txt and truststore.jks and its password in a file named truststore-password.jks.

3. Go to the command line and execute:

```
kubectl create secret generic mfpf-cert-secret --from-file keystore-password.txt --from-file truststore-password.txt --from-file keystore.jks --from-file truststore.jks
```
 Note: The names of the files should be the same as mentioned 
    i.e, keystore.jks, keystore-password.txt, truststore.jks and truststore-password.txt. Make sure you provide the name of the secret in keystoresSecretName to override the default keystores


###Case B: Post MobileFoundation deployment on ICP

In case if MFP was already deployed on ICP and one wants to enable HTTPS, below are the steps.

1. Follow the steps 1-3 listed in **Case A** above
2. Run the following command to get the values from the helm deployment
        ```helm get values <helm-name>   > values.yaml```
3. Make sure the following entries are added to the values.yaml (in addition to the appropriate data according to your own environments) and make sure the yaml is valid

	```yaml
	ingress:
	 enabled: true
	 hostname: <host-name>
	 sslPassThrough: false
	 tlsEnabled: true
	 tlsSecretName: "<cluster-name>"
	keystores:
	 keystoresSecretName: "mfpf-cert-secret"
	```

4. Unzip the mfp-icp PPA archive (downloaded from passport advantage) used to load the images of mfp 
5. Locate the charts directory within the extracted artifacts
6. Perform the helm upgrade
     
     ```helm upgrade <helm-release-name> ./ibm-mfpf-server-prod-<chart_version>.tgz -f values.yaml```

Sample command for adding the certificate to the trust store 

 ```keytool -import -storepass <worklight-storepass> -noprompt -alias icp -keystore ./usr-mfpf-server/security/truststore.jks -trustcacerts -file <mycert-loc>/wildcardcert.crt```


> For more details on Enabling SSL on IBM Liberty on ICP, refer the [documentation](https://www.ibm.com/support/knowledgecenter/en/was_beta_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_icp_ssl_helm.html)