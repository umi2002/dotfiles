#!/bin/bash
git checkout master
git merge --no-commit --no-ff $1
git reset -- $2
git commit
