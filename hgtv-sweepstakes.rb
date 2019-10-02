require "json"
require_relative "site-element.rb"

file = File.read "./config.json"
data = JSON.parse(file)

# define new browser
browser = SiteElement.new(data["url1"])

wait = Selenium::WebDriver::Wait.new(timeout: 30)

wait.until { browser.emailInput }

browser.emailInput.send_keys(data["email"])
browser.submitEmailBtn.click

wait.until { browser.entryForm }

sleep 5

# browser.firstName.send_keys(data['firstName'])
# browser.lastName.send_keys(data['lastName'])
# browser.email.clear()
# browser.email.send_keys(data['email'])
# browser.address.send_keys(data['address'])
# sleep 60
# browser.city.send_keys(data['city'])
# browser.state.click()
# sleep 5
# browser.zip.send_keys(data['zip'])
# browser.phone.send_keys(data['phone'])
# browser.sex.click()
# browser.dobMonth.click()
# browser.dobDay.send_keys(data['day'])
# browser.dobYear.send_keys(data['year'])
# browser.isProvider.click();

browser.submitEntryBtn.click

sleep 5

browser = SiteElement.new(data["url2"])

wait.until { browser.emailInput }

browser.emailInput.send_keys(data["email"])
browser.submitEmailBtn.click

wait.until { browser.entryForm }

sleep 5

# browser.firstName.send_keys(data['firstName'])
# browser.lastName.send_keys(data['lastName'])
# browser.email.clear()
# browser.email.send_keys(data['email'])
# browser.address.send_keys(data['address'])
# browser.city.send_keys(data['city'])
# browser.state.find_elements(tag_name: 'option').each { |option| option.click if option.text === data['state']}
# browser.zip.send_keys(data['zip'])
# browser.phone.send_keys(data['phone'])
# browser.sex.click()
# browser.dobMonth.find_elements(tag_name: 'option').each { |option| option.click if option.text === data['month']}
# browser.dobDay.send_keys(data['day'])
# browser.dobYear.send_keys(data['year'])
# browser.isProvider.find_elements(tag_name: 'option').each { |option| option.click if option.text === data['isProvider']}


browser.submitEntryBtn.click

sleep 5

browser.close_browser
