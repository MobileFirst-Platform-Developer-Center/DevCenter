#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST != "false" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# only proceed script when on "master" branch
if [ $TRAVIS_BRANCH != 'master' ]; then
  echo "this is not the master branch, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

## First, build
# build site with jekyll, by default to `_site' folder
rm -rf _site/*
bundle exec jekyll build --config _config.yml,build/_configBluemix.yml -d _site --profile
rm -f _site/*.log
travis_wait 30 bundle exec htmlproofer ./_site --disable-external --url-ignore "#,/support/knowledgecenter/js/kc/globaltopic.js,/support/knowledgecenter/js/kc/themes/css/globaltopic.css"

# Test also for external URLs
#bundle exec htmlproofer ./_site --url-ignore '#'

# cleanup
rm -rf ../mfpsamples.github.ibm.com.generated-bluemix

#clone `generated-bluemix' branch of the repository
git clone git@github.ibm.com:MFPSamples/mfpsamples.github.ibm.com.git --depth 1 --branch generated-bluemix --single-branch ../mfpsamples.github.ibm.com.generated-bluemix
# copy generated HTML site to `generated-bluemix' branch
rm -rf ../mfpsamples.github.ibm.com.generated-bluemix/*
cp -R _site/* ../mfpsamples.github.ibm.com.generated-bluemix

# commit and push generated content to `generated-bluemix' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../mfpsamples.github.ibm.com.generated-bluemix
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin generated-bluemix
