#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# build site with jekyll, by default to `_site' folder
rm -rf _site/*
bundle exec jekyll build --config _config.yml,_configPDF.yml -d _site --profile
rm -f _site/*.log
# bundle exec htmlproof ./_site --disable-external --href-ignore '#'

# cleanup
rm -rf ../generated-pdf

## Push the `master`
#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch master --single-branch ../generated-pdf/master
# copy generated PDF
rm -rf ../generated-pdf/master/*
cp -R _site/pdf/* ../generated-pdf/master
# commit and push generated content
cd ../generated-pdf/master
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin master

## Push the `8.0`
cd ../../DevCenter
pwd
#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch release80 --single-branch ../generated-pdf/release80
# copy generated PDF
rm -rf ../generated-pdf/release80/*
mkdir -p ../generated-pdf/release80/tutorials/en/foundation/8.0 && cp -R _site/pdf/tutorials/en/foundation/8.0/* ../generated-pdf/release80/tutorials/en/foundation/8.0/
mkdir -p ../generated-pdf/release80/tutorials/en/product-integration/8.0 && cp -R _site/pdf/tutorials/en/product-integration/8.0/* ../generated-pdf/release80/tutorials/en/product-integration/8.0/
mkdir -p ../generated-pdf/release80/tutorials/en/quality-assurance/8.0 && cp -R _site/pdf/tutorials/en/quality-assurance/8.0/* ../generated-pdf/release80/tutorials/en/quality-assurance/8.0/
mkdir -p ../generated-pdf/release80/tutorials/en/application-scanning && cp -R _site/pdf/tutorials/en/application-scanning/* ../generated-pdf/release80/tutorials/en/application-scanning/
mkdir -p ../generated-pdf/release80/tutorials/en/cloudant && cp -R _site/pdf/tutorials/en/cloudant/* ../generated-pdf/release80/tutorials/en/cloudant/
# copy the index file
cp _site/pdf/8.0.html ../generated-pdf/release80/index.html
# commit and push generated content
cd ../generated-pdf/release80
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin release80


## Push the `7.1`
cd ../../DevCenter
pwd
#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch release71 --single-branch ../generated-pdf/release71
# copy generated PDF
rm -rf ../generated-pdf/release71/*
mkdir -p ../generated-pdf/release71/tutorials/en/foundation/7.1 && cp -R _site/pdf/tutorials/en/foundation/7.1/* ../generated-pdf/release71/tutorials/en/foundation/7.1/
mkdir -p ../generated-pdf/release71/tutorials/en/product-integration/7.1 && cp -R _site/pdf/tutorials/en/product-integration/7.1/* ../generated-pdf/release71/tutorials/en/product-integration/7.1/
mkdir -p ../generated-pdf/release71/tutorials/en/quality-assurance/7.1 && cp -R _site/pdf/tutorials/en/quality-assurance/7.1/* ../generated-pdf/release71/tutorials/en/quality-assurance/7.1/
mkdir -p ../generated-pdf/release71/tutorials/en/application-scanning && cp -R _site/pdf/tutorials/en/application-scanning/* ../generated-pdf/release71/tutorials/en/application-scanning/
mkdir -p ../generated-pdf/release71/tutorials/en/cloudant && cp -R _site/pdf/tutorials/en/cloudant/* ../generated-pdf/release71/tutorials/en/cloudant/
# copy the index file
cp _site/pdf/7.1.html ../generated-pdf/release71/index.html
# commit and push generated content
cd ../generated-pdf/release71
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin release71


## Push the `7.0`
cd ../../DevCenter
pwd
#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch release70 --single-branch ../generated-pdf/release70
# copy generated PDF
rm -rf ../generated-pdf/release70/*
mkdir -p ../generated-pdf/release70/tutorials/en/foundation/7.0 && cp -R _site/pdf/tutorials/en/foundation/7.0/* ../generated-pdf/release70/tutorials/en/foundation/7.0/
mkdir -p ../generated-pdf/release70/tutorials/en/product-integration/7.0 && cp -R _site/pdf/tutorials/en/product-integration/7.0/* ../generated-pdf/release70/tutorials/en/product-integration/7.0/
mkdir -p ../generated-pdf/release70/tutorials/en/application-scanning && cp -R _site/pdf/tutorials/en/application-scanning/* ../generated-pdf/release70/tutorials/en/application-scanning/
mkdir -p ../generated-pdf/release70/tutorials/en/cloudant && cp -R _site/pdf/tutorials/en/cloudant/* ../generated-pdf/release70/tutorials/en/cloudant/
# copy the index file
cp _site/pdf/7.0.html ../generated-pdf/release70/index.html
# commit and push generated content
cd ../generated-pdf/release70
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin release70


## Push the `6.3`
cd ../../DevCenter
pwd
#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch release63 --single-branch ../generated-pdf/release63
# copy generated PDF
rm -rf ../generated-pdf/release63/*
mkdir -p ../generated-pdf/release63/tutorials/en/foundation/6.3 && cp -R _site/pdf/tutorials/en/foundation/6.3/* ../generated-pdf/release63/tutorials/en/foundation/6.3/
mkdir -p ../generated-pdf/release63/tutorials/en/product-integration/6.3 && cp -R _site/pdf/tutorials/en/product-integration/6.3/* ../generated-pdf/release63/tutorials/en/product-integration/6.3/
mkdir -p ../generated-pdf/release63/tutorials/en/application-scanning && cp -R _site/pdf/tutorials/en/application-scanning/* ../generated-pdf/release63/tutorials/en/application-scanning/
mkdir -p ../generated-pdf/release63/tutorials/en/cloudant && cp -R _site/pdf/tutorials/en/cloudant/* ../generated-pdf/release63/tutorials/en/cloudant/
# copy the index file
cp _site/pdf/6.3.html ../generated-pdf/release63/index.html
# commit and push generated content
cd ../generated-pdf/release63
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin release63
