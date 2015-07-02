#!/usr/bin/env bash
set -e # exit on first error
set -u # exit on using unset variable

# See http://michaelchelen.net/81fa/install-jekyll-2-ubuntu-14-04/

apt-get update
apt-get upgrade -y
apt-get install ruby ruby-dev make gcc nodejs -y

gem install jekyll --no-rdoc --no-ri
