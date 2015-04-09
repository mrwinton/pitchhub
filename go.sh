#!/usr/bin/env bash

set -e

echo "Running:"
echo ".. Making sure VM is up"
vagrant --no-provision up

echo ".. Making sure VM is fully provisioned"
vagrant provision

echo ".. Starting up Project"
vagrant ssh -c "cd /pitchhub/ && bundle install"

echo ".. Done - navigate to http://localhost:3000 to view the application"