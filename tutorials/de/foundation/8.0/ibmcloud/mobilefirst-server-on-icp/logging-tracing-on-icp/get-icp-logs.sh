

# get MFP Logs from the Helm release
# this script can be run from CLI for ICP is set and configured to Connect
#to the ICP server < ie docker, kubectl, bx pr >

# get installed Helm release
typeset debug=false # set to true if need to debug

if [ $1 ]
then
 HELMINSTANCE=$1
else
  echo "****************** get_icp-logs : run with following options*****************************"
  echo "  get-icp.logs HELMINSTANCE [MFPLOGSOUT][NAMESPACE] "
  echo "  HELMINSTANCE  -  helm release instance deployed in the kube cluster"
 echo  "  MFPLOGSOUT    - directory in local machine where logs are copied. default: ./mfp-icp-logs "
 echo  "  NAMESPACE     - namespace  the pod is deployed, default:  default "
  echo "  helm Instance parameter is needed to continue"
 echo  "******************************************************************************************"
  exit 0
fi

if [ $2 ]
then
   MFPLOGSOUT=$2
else
if [ $debug == "true" ]; then  echo "MFPLOGSOUT not given assuming creating icp=mfp-logs under current working directory"
fi
#clean the output directory
   MFPLOGSOUT=./mfp-icp-logs
if [ -d "$MFPLOGSOUT" ]; then rm -Rf $MFPLOGSOUT; fi
   mkdir $MFPLOGSOUT
fi

if [ $3 ]
then
   NAMESPACE=$3
else
if [ $debug == "true" ]; then  echo "Namespace not given assuming default"
fi
   NAMESPACE=default
fi

#identify logs directoty
if [ $debug == "true" ]; then echo " get log location based on the helm instance"
fi
if grep -q "appcenter" <<<$HELMINSTANCE; then
if [ $debug == "true" ]; then  echo "this is an appcenter helm"
fi
  MFPCONTEXT="appcenter"
else
if [ $debug == "true" ]; then echo "this is mfp / analytics helm"
fi
  MFPCONTEXT="mfp"
fi

export LIBLOGSDIR="/opt/ibm/wlp/usr/servers/$MFPCONTEXT/logs"

if [ $debug == "true" ]; then
echo "namespace is $NAMESPACE"
echo "helminstance is $HELMINSTANCE"
echo "MFP output dir is $MFPLOGSOUT"
fi
kubectl cp  $NAMESPACE/$HELMINSTANCE:$LIBLOGSDIR/ $MFPLOGSOUT/ >>$MFPLOGSOUT/mfp-loggingstatus.out 2>&1

#get all the containers in a pod
echo "get all the containers in the pod and obtain logs "
kubectl get pod $HELMINSTANCE --output=jsonpath='{..name}' 2>&1 |xargs -n1|sort|uniq|grep "mfpf"|while read container;do
if grep -q $HELMINSTANCE <<<$container; then
  echo
else
 kubectl logs $HELMINSTANCE -c $container  >> $MFPLOGSOUT/mfpf-$container.out 2>&1 
fi
done 
echo "Zipping the output to $HELMINSTANCE-logs.zip"
tar -cvf $MFPLOGSOUT/$HELMINSTANCE-logs.zip $MFPLOGSOUT/.

