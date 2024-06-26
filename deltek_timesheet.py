from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import datetime as Time
import time
import json
from site_elements import SiteElements

with open('config.json', 'r') as f:
  data = json.load(f)

MONTH = Time.now().month
DAY = Time.now().day
YEAR = Time.now().year
DAY_OF_WEEK = Time.now().strftime("%a")
TIMEINPUT = 8
if DAY_OF_WEEK == "Sat" or DAY_OF_WEEK == "Sun":
  print("It's the weekend, nothing to do...")
  raise SystemExit
browser = SiteElements(data['url'], data['cookies'])
wait = WebDriverWait(browser.driver, 10)

try:
  wait.until(EC.presence_of_element_located(browser.costPointSystemInput))

  # Fill out Creds for Cost Point
  browser.driver.find_element(*browser.costPointSystemUsername).send_keys(data["username"])
  browser.driver.find_element(*browser.costPointSystemPassword).send_keys(data["password"])
  browser.driver.find_element(*browser.costPointSystemInput).send_keys(data["system"])
  browser.driver.find_element(*browser.costPointLoginBtn).click()

  # Commented out because CostPoint changed how we navigate to the timesheet
  # Wait until you are inside of Deltek
  # wait.until(EC.presence_of_element_located(browser.costPointNavTC))

  # Navigate to the timesheet
  # browser.driver.find_element(*browser.costPointNavTC).click()
  # browser.driver.find_element(*browser.costPointTimeBtn).click()
  # browser.driver.find_element(*browser.costPointTimeSheetsBtn).click()
  # browser.driver.find_element(*browser.costPointManageTimesheets).click()

  browser.driver.implicitly_wait(10)

  if DAY > 24 or (DAY > 9 and DAY < 15):
    for a in range(0, 10):
      browser.driver.find_element(*browser.costPointScrollBar).click()

  wait.until(EC.presence_of_element_located(browser.costPointTimeSlot()))
  browser.driver.find_element(*browser.costPointTimeSlot()).click()
  browser.driver.find_element(*browser.costPointTimeSlot()).clear()
  browser.driver.find_element(*browser.costPointTimeSlot()).send_keys(TIMEINPUT)

  browser.driver.find_element(*browser.costPointSave).click()
  wait.until(EC.presence_of_element_located(browser.costSaveMessage))

  if browser.driver.find_element(*browser.costSaveMessage).text.find("successfully"):
    print(browser.driver.find_element(*browser.costSaveMessage).text)
  else:
    browser.driver.find_element(*browser.costPointSave).click()

  if browser.isLastDayOfTimePeriod():
    browser.driver.find_element(*browser.costPointSign).click()
    time.sleep(5)
    browser.costPointConfirmSign()
    wait.until(EC.presence_of_element_located(browser.costSaveMessage))

  time.sleep(5)

  print(('Time entered for {}/{}/{} with time equal to {} hrs').format(MONTH, DAY, YEAR, TIMEINPUT))

  browser.close_browser

finally:
  browser.close_browser()
