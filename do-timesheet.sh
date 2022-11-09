#!/bin/sh
source $HOME/.profile

H=$(date +%-H)

if (( $H < 15 )); then
    echo "It's too early in the day to be running the script... Exiting..."
    exit 0;
fi

cd $HOME/repos/timekeeper/ && /usr/local/bin/python3 deltek_timesheet.py
