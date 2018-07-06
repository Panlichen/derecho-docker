# derecho-docker
Docker containers for the Derecho project:  https://github.com/Derecho-Project/dericho-unified

# To build an image:

clone the repo at: https://github.com/scottslewis/derecho-docker.git cd into the directory derecho-dev and give command

$ docker build -t derecho-dev .

or use:

$ docker build -t derecho-dev https://github.com/scottslewis/derecho-docker.git#:derecho-dev

# To run the derecho-dev image once built

$ docker run -it derecho-dev /bin/bash


