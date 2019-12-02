#!/bin/bash

source /Users/jeagle/.zshrc
source /Users/jeagle/.profile

echo $PATH

ruby -v

cd /Users/jeagle/repos/timekeeper/ && ruby deltek-timesheet.rb time=8
