# Timekeeper for Unisys Federal Employee's

## Purpose is to create a one or two-step process that eliminates human error while adding time for multiple timesheets. Why multiple timesheets you ask? Ask the government. :) My goal is to make everything consistent with one command.

## Requirements:
	- Ruby
	- Selenium Webdriver

## Fill out your config.example.json file and rename it to config.json
	- All fields are required in the json file.

## To Run the selenium webdriver:
`ruby deltek-timesheet.rb time={{your time}}`

i.e., `ruby deltek-timesheet.rb time=8`

This will start up the selenium webdriver and open up Unisys's deltek url and input your credentials, and do your timesheet. For now, if you work at CBP, (this part is being developed) it will also log into that system and input the time as well.

## But eaglejs, you have to put in a two-step verification!??
Yes, that's why I said earlier that this is a one or two-step process, but all you have to do is reply to the text message and it will do the rest. Sorry, it's not 100% one-step, but it's the best I can do. I you have better ideas to get around this, I will love to hear them. :) 


