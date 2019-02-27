# Timekeeper for Unisys Federal Employee's

## Purpose is to create a one-step process that eliminates human error while adding time. Thus, preventing punishment for being human. :)

## Requirements:

    - Ruby
    - Selenium Webdriver

## Fill out your config.example.json file and rename it to config.json

    - All fields are required in the json file.

## Install gems in this repository

`bundle install`

## To Run the selenium webdriver:

`ruby deltek-timesheet.rb time={{your time}}`

i.e., `ruby deltek-timesheet.rb time=8`

This will start up the selenium webdriver and open up Unisys's deltek url and input your credentials, and do your timesheet.

## This is now officially one step process.

You do have to add the cookies listed in the cookies section of the config.example.json. To do this:

- Open up incognito mode in your chrome browser (do this so we are sure we are creating a new session).
- Navigate to the url in the config.example.json file.
- Fill out your username.
- Fill out your password.
- It will ask you to receive a text message, and do so, and reply to that text message.
- When you are prompted to save the session, click yes, and let it take you to the deltek login page.
- Once you are there, hit back, to reveal office 365. open up your Dev Tools in the browser and go to the "application" tab.
- On the left of the Dev Tools, you'll see a dropdown for cookies, click on it, and click on the url inside.
- Now you will see several name, values, domains, etc. Just copy the value from the name "ESTSAUTH", and "CCState" and paste it in the config.json file.
- Keep this file secret because if someone get's these cookie values, they can hi-jack your session, and do unspeakable things to you.
- Once it is saved, and you renamed your config.example.json to config.json, you should be good to go, and it will automatically log in. If your cookies expire, just repeat the process.

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
