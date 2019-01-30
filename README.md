# Timekeeper for Unisys Federal Employee's

## Purpose is to create a one-step process that eliminates human error while adding time.

## Requirements:
	- Ruby
	- Selenium Webdriver

## Fill out your config.example.json file and rename it to config.json
	- All fields are required in the json file.

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
  - When you are prompted to save the session, open up your Dev Tools in the browser and go to the "application" tab.
  - On the left of the Dev Tools, you'll see a dropdown for cookies, click on it, and click on the url inside.
  - Now you will see several name, values, domains, etc. Just copy the values of the names that are in the config.example.json file and put them in there.
  - Keep this file secret because if someone get's these cookie values, they can hi-jack your session, and do unspeakable things to you.
  - Once it is saved, and you renamed your config.example.json to config.json, you should be good to go, and it will automatically log in. If your cookies expire, just repeat the process.
