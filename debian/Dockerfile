FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install python-setuptools python2.7 git tox dh-virtualenv dpkg-dev debhelper libssl-dev python-dev libffi-dev

RUN easy_install pip

WORKDIR /home/elastalert

ADD . /home/elastalert/

#RUN pip install no-manylinux1
RUN dpkg-buildpackage -us -uc
