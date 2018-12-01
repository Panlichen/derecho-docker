#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 Debug|Release|RelWithDebInfo [branch] [number of cpu cores=4]"
    exit 1
fi

BUILD=$1
BRANCH=$2
DEFAULT_COMMIT="HEAD"
if [[ -z $BRANCH ]]; then
  BRANCH=master
  DEFAULT_COMMIT="3eb02e646fe18db3548a49dc6e8153a2d5331481"
fi
NCPU=$3
if [[ -z $NCPU ]]; then
  NCPU=4
fi

# step 1 clone
git clone --recursive https://github.com/Derecho-Project/derecho-unified
cd derecho-unified
echo "Using $BRANCH"
git checkout -b $BRANCH
git checkout $DEFAULT_COMMIT
git submodule update --init

# step 2 build
mkdir $BUILD
cd $BUILD
cmake -DCMAKE_BUILD_TYPE=$BUILD ..
make -j $NCPU
