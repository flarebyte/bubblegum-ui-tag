#!/usr/bin/env sh
npm install -g elm-use elm-test
elm-use 0.18.0
elm-package install --yes
cd tests
elm-package install --yes
cd ..
