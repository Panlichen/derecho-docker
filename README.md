# derecho-docker
Docker containers for the Derecho project:  https://github.com/Derecho-Project/dericho-unified

# To build an image:

clone the repo at: https://github.com/scottslewis/derecho-docker.git cd into the directory derecho-dev and give command

$ docker build -t derecho-dev .

or 

$ docker build -t derecho-dev https://github.com/scottslewis/derecho-docker.git#:derecho-dev

# To run the derecho-dev image once built

$ docker run -it derecho-dev /bin/bash

# To clone repo

Move to the /root directory:

cd ~

run command

$ derecho.clone.sh <derecho branch>

e.g.

$ derecho.clone.sh   

for master

$ derecho.clone.sh libfabric

for libfabric branch

will create directory ~/derecho-unified with src tree

# To build Derecho

$ derecho.build.sh Debug|Release

e.g.

$ derecho.build.sh Debug

for producing a Debug build in ~/derecho-unified/Debug

or

$ derecho.build.sh Release

for producing a Release build in ~/derecho-unified/Release


