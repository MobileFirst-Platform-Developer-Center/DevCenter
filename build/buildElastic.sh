#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST != "false" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# only proceed script when on "master" branch
#if [ $TRAVIS_BRANCH != 'master' ]; then
if [ $TRAVIS_BRANCH != 'master' ]; then
  echo "this is not the master branch, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

## First, build
# build site with jekyll, by default to `_site' folder
rm -rf _site/*
bundle exec jekyll build --config _config.yml,build/_configElastic.yml -d _site --verbose
rm -f _site/*.log
#Old set of curl commands used when Container Group was used --------
#curl -u $ELASTICCREDENTIALS -X DELETE "mfpsearch.mybluemix.net/dev_center"
#curl -u $ELASTICCREDENTIALS -XPOST 'mfpsearch.mybluemix.net/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json"
#--------------------------------------------------------------------
#curl -u $ELASTICSVCCREDENTIALS -XPOST 'https://admin:DPEKZCXTYVUMWJQZ@portal-ssl403-12.bmix-dal-yp-4e981698-2fe4-416b-b80d-dcc839ed7ed8.bluempus-in-ibm-com.composedb.com:29660/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json" --verbose
#Working pair ES Compose service-----------
#curl -u $ELASTICSVCCREDENTIALS -X DELETE "https://portal-ssl403-12.bmix-dal-yp-4e981698-2fe4-416b-b80d-dcc839ed7ed8.bluempus-in-ibm-com.composedb.com:29660/dev_center"
#curl -u $ELASTICSVCCREDENTIALS -XPOST -H "Content-Type: application/json" "https://portal-ssl403-12.bmix-dal-yp-4e981698-2fe4-416b-b80d-dcc839ed7ed8.bluempus-in-ibm-com.composedb.com:29660/dev_center/_bulk?pretty" --data-binary "@_site/js/data/elastic.json"
#------------------------------------------

#curl -u poneogentoredichaveradev:b40e4b8c0214e6579e4df7debb78385bd5eeecf8 -XPOST '169.48.167.218:31569/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json"
#ELASTICSEARCH on Kube cluster <WORKER_IP>:<NODE_PORT> -----------------------------------
curl -u $ELASTICCREDENTIALS -X DELETE "169.48.167.218:31569/dev_center"
curl -u $ELASTICCREDENTIALS -XPOST '169.48.167.218:31569/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json"
#-----------------------------------------------------------------
