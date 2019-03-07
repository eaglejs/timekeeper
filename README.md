# Timekeeper for Unisys Federal Employee's

## Purpose is to create a one-step process that eliminates human error while adding time. Thus, preventing punishment for being human. :)

## Requirements:
    - Ruby
    - Selenium Webdriver

## Install gems in this repository

`bundle install`

## Fill out your config.example.json file and rename it to config.json
  - All fields are required in the json file.

## This is now officially one step process.

You do have to add the cookies listed in the cookies section of the config.example.json. To do this:
- Open up your browser and log into the deltek time keeping application.
- Once you authenticated, navigate to: `chrome://settings/cookies` in your web browser.
- Search for `login.microsoft.com`
- You should have 13 results here. Open up your console and copy all of the code in get-cookies.js and paste it into your console.
- It should spit out data for you to copy and paste into your config.json file.
- Open up config.example.json file, or your config.json file if you already have one.
- copy and paste the data that was spit out in the cookie property section.
- Keep this file secret because if someone get's these cookie values, they can hi-jack your session, and do unspeakable things to you.
- Once it is saved, and you renamed your config.example.json to config.json, you should be good to go, and it will automatically log in. If your cookies expire, just repeat the process.

## To Run the selenium webdriver:

`ruby deltek-timesheet.rb time={{your time}}`

i.e., `ruby deltek-timesheet.rb time=8`

This will start up the selenium webdriver and open up Unisys's deltek url and input your credentials, and do your timesheet.

## Running in Crontab

*** MAKE SURE YOU BACKUP YOUR CRON JOBS IF YOU HAVE ANY AS THIS BLOWS IT AWAY ***
Make sure you run `rvm cron setup` < This will blow away your crontab >

- type: `$ crontab -e`
Here's an example crontab:
```
# Made by running `rvm cron setup`
#sm start rvm
PATH="/Users/jeagle/.rvm/gems/ruby-2.6.0/bin:/Users/jeagle/.rvm/gems/ruby-2.6.0@global/bin:/Users/jeagle/.rvm/rubies/ruby-2.6.0/bin:/Users/jeagle/.rvm/gems/ruby-2.6.0/bin:/Users/jeagle/.rvm/gems/ruby-2.6.0@global/bin:/Users/jeagle/.rvm/rubies/ruby-2.6.0/bin:/Library/Frameworks/Python.framework/Versions/3.7/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/usr/local/share/dotnet:/opt/X11/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:./node_modules/.bin:/usr/local/opt/go/libexec/bin:/usr/local/bin/tomcat-7:/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home/:/usr/local/sbin:/Users/jeagle/.rvm/bin"
GEM_HOME='/Users/jeagle/.rvm/gems/ruby-2.6.0'
GEM_PATH='/Users/jeagle/.rvm/gems/ruby-2.6.0:/Users/jeagle/.rvm/gems/ruby-2.6.0@global'
MY_RUBY_HOME='/Users/jeagle/.rvm/rubies/ruby-2.6.0'
IRBRC='/Users/jeagle/.rvm/rubies/ruby-2.6.0/.irbrc'
RUBY_VERSION='ruby-2.6.0'
#sm end rvm

30 8 * * 5 cd /Users/jeagle/ && sh do-timesheet.sh >> /Users/jeagle/cron.log 2>&1
00 16 * * 1-4 cd /Users/jeagle/ && sh do-timesheet.sh >> /Users/jeagle/cron.log 2>&1
#*/1 * * * * cd /Users/jeagle/ && sh do-timesheet.sh  >> /Users/jeagle/cron.log 2>&1
```

I created a shell script that runs the timesheet and included it in the repository, just put it in your home folder and this setup should work.

<p align="center">
  <img src="https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif" alt="Kitty!">
</p>
