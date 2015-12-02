#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

## First, build for GitHub Pages
# build site with jekyll, by default to `_site' folder
rm -rf _site/*
bundle exec jekyll build --config _config.yml,_configPDF.yml -d _site --profile
rm -f _site/*.log
# bundle exec htmlproof ./_site --disable-external --href-ignore '#'

# cleanup
rm -rf ../generated-pdf

#clone pdf repository
git clone git@github.ibm.com:NATHANH/experimentalpdf.git --branch master --single-branch ../generated-pdf
# copy generated PDF site to `generated-pdf' branch
rm -rf ../generated-pdf/*
cp -R _site/pdf/* ../generated-pdf

# commit and push generated content to `generated-bluemix' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../generated-pdf
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin master
