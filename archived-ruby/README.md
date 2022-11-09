# Timekeeper for Deltek Timesheets

## Purpose is to create a one-step process that eliminates human error while adding time into Deltek. Thus, preventing punishment for being a human. :)

***
*Note*: This runs only for semi-monthly setups. When I take a job that requires bi-weekly, i'll add it in as something that is configurable.

## Requirements:
    - Ruby (I may change this over to Java someday but I like not having to compile code)
    - Selenium Webdriver
    - Chromedriver

## Install gems in this repository

`bundle install`

## Fill out your config.example.json file and rename it to config.json
  - All fields may be required, it just depends on your companies setup.

## You may need cookies for some companies
This is needed if your company does 2-step verification for logging in. If you need to add the cookies listed in the cookies section of the config.example.json. To do this:
- Open up your browser and log into the deltek time keeping application.
- Once you authenticated, navigate to: `chrome://settings/siteData` in your web browser.
- Search for `login.microsoft.com`, and click on the one result that you found.
- You should have 12ish cookies here on the next page. Open up your console and copy all of the code in get-cookies.js and paste it into your console.
- It should output the data in your clipboard, so all you have to do is paste it in the config.json file.
- Open up config.example.json file, or your config.json file if you already have one.
- Paste the data that was spit out in the cookie property value.
- Keep this file secret because if someone get's these cookie values, they can hi-jack your session, and do unspeakable things to you.
- Once it is saved, and you renamed your config.example.json to config.json, you should be good to go, and it will automatically log in. If your cookies expire, just repeat the process.

## To Run the selenium webdriver:

`ruby deltek-timesheet.rb time={{your time}}`

i.e., `ruby deltek-timesheet.rb time=8`

This will start up the selenium webdriver and open up Unisys's deltek url and input your credentials, and do your timesheet.

## Running in Systemd at a certain time of day
For my setup, I chose to run this process using systemd. If my understanding is correct, crontab is going to be deprecated eventually (OSX has already done this, and a lot of linux distros have already moved away from it.) To get started you will need to create a service and a timer.

### Creating a service in systemd
- `sudo vim /etc/systemd/system/timekeeper.service`
  ```
  [Unit]
  Descrption=Fills out timesheet automatically daily
  Wants=timekeeper.timer

  [Service]
  Type=oneshot
  User=<your username>
  Group=Admin #Check your group for admin, it could be wheel, adm, equivalent
  ExecStart=/home/<your username>/path/to/respository/do-timesheet.sh

  [Install]
  WantedBy=multi-user.target
  ```

### Creating a timer in systemd
- `sudo vim /etc/systemd/system/timekeeper.timer`
  ```
  [Unit]
  Description=Starting Time Keeper
  Requires=timekeeper.service

  [Timer]
  Unit=timekeeper.service
  OnCalendar=Mon..Fri *-*-* 15:00:00 # Runs Monday through Friday at 3pm

  [Install]
  WantedBy=timers.target
  ```

### Enabling your timer
- You shouldn't need to enable the service because the timer just calls the service anyway
- `sudo systemctl enable timekeeper.timer`
  - `sudo systemctl status timekeeper.timer` <= Do this to ensure that it is enabled

### Debugging systemd
If you cannot get the service to run, check the journal logs by running
`journalctl -S today -f -u timekeeper.service` or `sudo systemctl enable timekeeper.service`
The first command will give you a live log so you can keep running tests againts and the other just prints out the last 20lines or so. But it should give you all you need to test an debug an issue if my instructions didn't work out for you.

Enjoy! :)

<p align="center">
  <img src="https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif" alt="Kitty!">
</p>
