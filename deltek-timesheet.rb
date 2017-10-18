require 'json'
require_relative 'site-element.rb'

file = File.read "./config.json"

data = JSON.parse(file)

ARGV.each do |a|
	if /time/.match(a.downcase)[0] == "time"
		TIMEINPUT = /\d\.\d|\d/.match(a)
	end
end

# define new browser
browser = SiteElement.new(data['url'])

# click on submit button
browser.msUserName.send_keys(data['username'])
browser.msElementBlock.click

wait = Selenium::WebDriver::Wait.new(timeout: 20)

wait.until {browser.msUserPass}

# Login
browser.msUserPass.send_keys(data['password'])
browser.msSubmitLogin.click

# Verify two-step login
wait = Selenium::WebDriver::Wait.new(timeout: 20)
wait.until {browser.verificationLink}

browser.verificationLink.click

# Wait for costPoint login to show up
wait = Selenium::WebDriver::Wait.new(timeout: 30)
wait.until {browser.costPointSystemInput}

# Fill out Creds for Cost Point
browser.costPointSystemInput.send_keys('UNISYS')
browser.costPointLoginBtn.click

# Wait until you are inside of Deltek
wait = Selenium::WebDriver::Wait.new(timeout: 30)
wait.until {browser.costPointNavTC }

# Navigate to the timesheet
browser.costPointNavTC.click
browser.costPointTimeBtn.click
browser.costPointTimeSheetsBtn.click
browser.costPointManageTimesheets.click

# If it is Monday, put in timecode
if DAY == 3
	sleep 3
	browser.costPointNewBtn.click
	wait.until {browser.costPointNewTimeCodeSlot}
	browser.costPointNewTimeCodeSlot.click
	sleep 3
	browser.costPointNewTimeCodeSlot.clear()
	browser.costPointNewTimeCodeSlot.send_keys(data['timecode'])
	sleep 3
	browser.costPointNewPayType.send_keys(data['payType'])
	sleep 2
	browser.costPointNewTimeSlot.clear()
	browser.costPointNewTimeSlot.send_keys(TIMEINPUT)	
else
	# Wait until timeslot is visible
	wait.until {browser.costPointTimeSlot}
	# set focus to time slot based on date
	browser.costPointTimeSlot.click
	sleep 3
	# Input time, then save
	browser.costPointTimeSlot.clear()
	browser.costPointTimeSlot.send_keys(TIMEINPUT)
end
	
sleep 2

browser.costPointSave.click

if DAY == 7
	sleep 5
	browser.costPointSign.click
	sleep 5
	browser.costPointConfirmSign
end

sleep 5

wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds

browser.close_browser