#!/bin/bash

source /Users/eaglejs/.zshrc
source /Users/eaglejs/.profile

echo $PATH

ruby -v

cd /Users/eaglejs/repos/hgtv-sweepstakes/ && bundle install && ruby hgtv-sweepstakes.rb
