#!/bin/bash

read -p "Enter the branch that you want to build:"  branch
git checkout $branch
git checkout master -- .travis.yml 
sed 's/origin HEAD:[^ ]* /origin HEAD:'"$branch"' /' .travis.yml 
sed -i 's/#//g' .travis.yml
