#!/bin/bash

cat npm_packages.txt | xargs -I {} npm install -g {}
echo "NPM packages installed."
