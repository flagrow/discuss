#!/usr/bin/env bash

base=$PWD

for PACKAGE in `find vendor -mindepth 2 -maxdepth 2 -type d`
do
  cd $PACKAGE

  PACKAGE_PATH=$PWD

  if [ -f "bootstrap.php" ]; then
    echo "> --- Found extension $PACKAGE";
    if [ -d "js" ]; then
      if [ -f "js/bower.json" ]; then
        ec
        cd js/
        bower install
        cd $PACKAGE_PATH
      fi
      for JS in `find js -mindepth 1 -maxdepth 1 -type d`
      do
        cd $JS
        if [ -f "package.json" ]; then
          npm install
        fi
        if [ -f "Gulpfile.js" ]; then
          node_modules/gulp/bin/gulp.js
        fi

        if [ -d "node_modules" ]; then
          rm -rf node_modules
        fi

        cd $PACKAGE_PATH
      done
    fi
  fi
  cd $base
done
