#!/bin/sh
source $HOME/.profile

H=$(date +%-H)
DO_NOT_RUN_TODAY=false

if [[ $DO_NOT_RUN_TODAY == true || $H < 15 ]]; then
    echo "It's too early in the day to be running the script... Exiting..."
    exit 0;
fi

cd $HOME/repos/timekeeper/ && /usr/local/bin/python3 deltek_timesheet.py
