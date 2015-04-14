#!/usr/bin/env bash

echo '##################################'
echo '# Installing vagrant-box gems... #'
echo '##################################'
cd /pitchhub/ && bundle install

echo '############################################'
echo '# Adding aliases:                          #'
echo '#  - "pup" to start the server             #'
echo '#  - "pcd" to cd into pitchhub directory   #'
echo '############################################'
echo "alias pup=\"rails s -b 0.0.0.0\"" >> ~/.bashrc
echo "alias pcd=\"cd /pitchhub/\"" >> ~/.bashrc

source $HOME/.bashrc