#!/bin/bash

git clone git@github.com:ec-europa/platform-dev.git
git clone git@github.com:ec-europa/atomium.git
git clone git@github.com:ec-europa/ec_resp.git
git clone git@github.com:ec-europa/ec_europa.git

cp build.properties.local platform-dev/

docker-compose up -d
docker-compose run web composer install
docker-compose run web ./bin/phing build-platform-dev
docker-compose run web ./bin/phing install-platform

rm -rf platform-dev/profiles/multisite_drupal_standard/themes/*
ln -s ../../../../atomium ./platform-dev/profiles/multisite_drupal_standard/themes/
ln -s ../../../../ec_resp ./platform-dev/profiles/multisite_drupal_standard/themes/
ln -s ../../../../ec_europa ./platform-dev/profiles/multisite_drupal_standard/themes/

