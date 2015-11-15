#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# build site with jekyll, by default to `_site' folder
bundle exec jekyll build --profile --verbose
rm -f _site/*.log
 bundle exec htmlproof ./_site --disable-external --href-ignore '#' --checks-to-ignore "ScriptCheck","ImageCheck" --disable-external --href-swap \/MFPSamples:

# cleanup
rm -rf ../mfpsamples.github.ibm.com.master

#clone `master' branch of the repository using encrypted GH_TOKEN for authentification
git clone git@github.ibm.com:MFPSamples/mfpsamples.github.ibm.com.git --branch master --single-branch ../mfpsamples.github.ibm.com.master
# copy generated HTML site to `master' branch
rm -rf ../mfpsamples.github.ibm.com.master/*
cp -R _site/* ../mfpsamples.github.ibm.com.master

# commit and push generated content to `master' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../mfpsamples.github.ibm.com.master
git config user.email "nathanh@il.ibm.com"
git config user.name "Nathan Hazout Travis"
git add -A .
git commit -a -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push --quiet origin master
