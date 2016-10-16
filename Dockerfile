# comments in a dockerfile
FROM ubuntu:latest
MAINTAINER Bilal Shah <bilal.shah.mail@gmail.com>
RUN apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install \
  apt-utils     \
  iputils-ping  \
  lsb           \
  net-tools	\
  wget \
  curl \
  vim \
  sudo \
  tree \
  git-all
#
# visit https://downloads.chef.io/chef-dk/ubuntu/   and use the version
# dropdown to determine latest version available
#
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -v 0.18.30
#
# password is chefuser
# echo "chefuser" | openssl passwd -crypt -stdin
#
RUN useradd -m -G sudo -p "pa8/1qs2vUg9U" chefuser && \
    mkdir /home/chefuser/chef-repo && \
    chown chefuser /home/chefuser/chef-repo && \
    chgrp chefuser /home/chefuser/chef-repo
#
# use sudo -s to change root pw and login as root
# we start off as chefuser and its in sudo
#
USER chefuser
#
# git configuration
#
RUN git config --global user.name "chefuser" && \
    git config --global user.email chefuser@example.com && \
    git config --global core.editor vi && \
    git clone https://github.com/BilalShahWork/chef-repo /home/chefuser/chef-repo
