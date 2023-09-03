#!/bin/bash

cat npm_packages.txt | xargs -I {} sudo npm install -g {}
echo "NPM packages installed."
