#!/bin/bash
#git clone from main repo
git clone --recursive https://github.com/Derecho-Project/derecho-unified
cd derecho-unified
if [ $# -eq 0 ]
  then
    echo "Using master branch"
else
  echo "Using $1 branch"
  git checkout $1
fi
# update any submodules in either case
git submodule update --init
echo "Cloned derecho-unified repo successfully!"
if [ $# -eq 0 ]
  then
    echo "Now on master branch"
else
  echo "Now on $1 branch"
fi