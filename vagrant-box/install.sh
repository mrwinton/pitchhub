#!/usr/bin/env bash

echo '################################'
echo '# Installing chef cookbooks... #'
echo '################################'
berks vendor ./cookbooks

echo '##################################'
echo '# All set, ready for vagrant up! #'
echo '##################################'