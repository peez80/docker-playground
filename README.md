docker-playground
=================

Since Vagrant is limited since docker for windows, I create this "VM" for me to perform
everyday's tasks that need linux to do so. 

This image is not intended to serve some special app! It's intended to log in and do something.

To mount your drive, start the image with:

    docker run -it --rm -v C:/:/C peez/playground