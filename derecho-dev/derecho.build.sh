#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "usage: $0 Debug|Release"
    exit 1
else
    cd ~/derecho-unified
    mkdir $1
    cd $1
    cmake -DCMAKE_BUILD_TYPE=$1 ..
    make
    echo "Derecho $1 build completed successfully!"
fi