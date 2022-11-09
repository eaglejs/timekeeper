#!/bin/sh

echo "Unloading plist..."
launchctl unload -w ~/Library/LaunchAgents/com.eaglejs.launched.timekeeper.plist
echo "Deleting plist..."
rm ~/Library/LaunchAgents/com.eaglejs.launched.timekeeper.plist
echo "Copying new plist..."
cp ~/repos/timekeeper/com.eaglejs.launched.timekeeper.plist ~/Library/LaunchAgents/
echo "Loading plist"
launchctl load -w ~/Library/LaunchAgents/com.eaglejs.launched.timekeeper.plist
launchctl enable gui/$UID/com.eaglejs.launched.timekeeper
echo "Succeeded!"
