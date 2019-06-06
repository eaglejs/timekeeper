require "json"
require_relative "site-element.rb"

file = File.read "./config.json"
data = JSON.parse(file)

ARGV.each do |argument|
  if /time/.match(argument.downcase)[0] == "time"
    TIMEINPUT = /\d\.\d|\d/.match(argument)
  end
end

# define new browser
browser = SiteElement.new(data["url"], data["cookies"])

wait = Selenium::WebDriver::Wait.new(timeout: 60)

# click on submit button
# browser.msUserName.send_keys(data["username"])
# browser.msSubmit.click

# wait.until { browser.msUserPass }

# Login
# browser.msUserPass.send_keys(data["password"])
# browser.msSubmitLogin.click

# Verify two-step login
# wait.until { browser.verificationLink }

# browser.verificationLink.click

# wait.until { browser.msRememberMeYes }
# browser.msRememberMeYes.click

# Wait for costPoint login to show up
wait.until { browser.costPointSystemInput }

# Fill out Creds for Cost Point
sleep 3
browser.costPointSystemInput.send_keys("UNISYS")
browser.costPointLoginBtn.click


# Wait until you are inside of Deltek
wait.until { browser.costPointNavTC }

# Navigate to the timesheet
browser.costPointNavTC.click
browser.costPointTimeBtn.click
browser.costPointTimeSheetsBtn.click
browser.costPointManageTimesheets.click

# If it is Monday, put in timecode
if DAY == 3
  sleep 5
  browser.costPointNewBtn.click
  wait.until { browser.costPointNewTimeCodeSlot }
  browser.costPointNewTimeCodeSlot.click
  sleep 3
  browser.costPointNewTimeCodeSlot.clear()
  browser.costPointNewTimeCodeSlot.send_keys(data["timecode"])
  sleep 3
  browser.costPointNewPayType.send_keys(data["payType"])
  sleep 3
  browser.costPointNewTimeSlot.click
  sleep 5
  browser.costPointNewTimeSlot.clear()
  browser.costPointNewTimeSlot.send_keys(TIMEINPUT)
else
  # Wait until timeslot is visible
  wait.until { browser.costPointTimeSlot }
  # set focus to time slot based on date
  browser.costPointTimeSlot.click
  sleep 3
  # Input time, then save
  browser.costPointTimeSlot.clear()
  browser.costPointTimeSlot.send_keys(TIMEINPUT)
end

sleep 2

browser.costPointSave.click

wait.until{browser.costSaveMessage}

if browser.costSaveMessage.text.include? "successfully"
  puts browser.costSaveMessage.text
else
  browser.costPointSave.click
end

if DAY == 7
  sleep 10
  browser.costPointSign.click
  sleep 5
  browser.costPointConfirmSign

  wait.until{browser.costSaveMessage}
end

sleep 10

browser.close_browser
