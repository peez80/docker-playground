docker-playground
=================

Since Vagrant is limited since docker for windows, I create this "VM" for me to perform
everyday's tasks that need linux to do so. 

This image is not intended to serve some special app! It's intended to log in and do whatever you need in linux.

To mount your drive, start the image with:

    docker run -it --rm -v C:/:/C peez/playground


Vagrantfile
===========
Additionally a Vagrantfile is provided in this git repo. Initially it was just intended to serve the docker daemon for testing the playground image - nowadays I use it to serve additional features.

Currently it's only Kubernetes but could be extended if I need any additional tools in the future.

Kubernetes
----------
To keep the vagrantfile as small as possible, the local kubernetes (1-node) cluster is not installed by ```vagrant up```. To install it, log in to the vagrantbox (```vagrant ssh```) and issue ```sudo install-kubernetes``` (sudo is important!).

Attention! Currently the kubernetes install is not yet working 100%

