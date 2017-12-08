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
bundle exec jekyll build --config _config.yml,build/_configElastic.yml -d _site --profile
rm -f _site/*.log

#curl -u $ELASTICCREDENTIALS -X DELETE "mfpsearch.mybluemix.net/dev_center"
#curl -u $ELASTICCREDENTIALS -XPOST 'mfpsearch.mybluemix.net/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json"
curl -u $ELASTICCREDENTIALS -X DELETE "169.48.167.218:31418/dev_center"
curl -u $ELASTICCREDENTIALS -XPOST '169.48.167.218:31418/dev_center/_bulk?pretty' --data-binary "@_site/js/data/elastic.json"
