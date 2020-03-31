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
wait.until { browser.deltekLoginUsername}

# Fill out Creds for Cost Point
browser.deltekLoginUsername.send_keys(data["username"])
browser.deltekLoginPassword.send_keys(data["password"])
browser.deltekLoginDomain.send_keys(data["domain"])
browser.deltekLoginButton.click

# Manage Timesheet Desktop page.
browser.switchToIframe
puts(browser.deltekDesktopOpenTimesheet.text)
browser.deltekDesktopOpenTimesheet
puts("clicking open timesheet")
browser.deltekDesktopOpenTimesheet.click

# fill out timesheet.
wait.until {browser.hasTimesheetHeader}
puts(browser.hasTimesheetHeader.text)
puts(browser.hoursHeader.text)
puts(browser.projectNameCell.text)

browser.close_browser
