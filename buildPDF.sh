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
cp _site/pdf/8.0.html ../generated-pdf/release80/index.html

# commit and push generated content
cd ../generated-pdf/release80
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin release80
