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
  DEFAULT_COMMIT="fcb36cc66f4fba9b2e5ee405bc102eaf4f8273b1"
fi
NCPU=$3
if [[ -z $NCPU ]]; then
  NCPU=`lscpu | grep ^CPU\(s\) | awk '{print $2}'`
fi

# step 1 clone
git clone --recursive https://github.com/Derecho-Project/derecho
cd derecho
echo "Using $BRANCH"
git checkout -b $BRANCH
git checkout $DEFAULT_COMMIT

# step 2 install dependencies
cd scripts/prerequisites
./install-mutils.sh
./install-mutils-tasks.sh
./install-mutils-containers.sh
./install-spdlog.sh
./install-libfabric.sh
cd ../../

# step 2 build
mkdir $BUILD
cd $BUILD
cmake -DCMAKE_BUILD_TYPE=$BUILD ..
make -j $NCPU
make install
