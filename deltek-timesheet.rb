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

# Wait for costPoint login to show up
wait.until { browser.costPointSystemInput }

# Fill out Creds for Cost Point
browser.costPointSystemUsername.send_keys(data["username"])
browser.costPointSystemPassword.send_keys(data["password"])
browser.costPointSystemInput.send_keys(data["system"])
browser.costPointLoginBtn.click


# Wait until you are inside of Deltek
wait.until { browser.costPointNavTC }

# Navigate to the timesheet
browser.costPointNavTC.click
browser.costPointTimeBtn.click
browser.costPointTimeSheetsBtn.click
browser.costPointManageTimesheets.click

sleep 2
# Wait until timeslot is visible
for a in 1..10 do
  browser.costPointScrollBar.click
end
wait.until { browser.costPointTimeSlot }

# set focus to time slot based on date
browser.costPointTimeSlot.click
sleep 3

# Input time, then save
browser.costPointTimeSlot.clear()
browser.costPointTimeSlot.send_keys(TIMEINPUT)

sleep 2

browser.costPointSave.click
wait.until{browser.costSaveMessage}

if browser.costSaveMessage.text.include? "successfully"
  puts browser.costSaveMessage.text
else
  browser.costPointSave.click
end

if isLastDayOfTimePeriod()
  sleep 5
  browser.costPointSign.click
  sleep 5
  browser.costPointConfirmSign
  wait.until{browser.costSaveMessage}
end

sleep 5

puts('Time entered for ' + MONTH + '/' + DAY + '/' + YEAR + ' with time equal to ' + TIMEINPUT.to_s + 'hrs')

browser.close_browser
