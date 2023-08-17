from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from datetime import datetime as Time
import calendar

MONTH = Time.now().month
print(("Month: {}").format(MONTH))
DAY = Time.now().day
print(("Day: {}").format(DAY))
YEAR = Time.now().year
print(("Year: {}").format(YEAR))
DAY_OF_WEEK = Time.now().strftime("%a")
print(("Day of Week: {}").format(DAY_OF_WEEK))
DAY_15_OF_MONTH = Time(YEAR, MONTH, 15).strftime("%a")
print(("Day 15 of Month: {}").format(DAY_15_OF_MONTH))
DAY_16_OF_MONTH = Time(YEAR, MONTH, 16).strftime("%a")
print(("Day 16 of Month: {}").format(str(DAY_16_OF_MONTH)))
LAST_DAY_OF_MONTH_NUM = calendar.monthrange(YEAR, MONTH)[1]
print(("Last Day of Month as Number: {}").format(LAST_DAY_OF_MONTH_NUM))
LAST_DAY_OF_MONTH = Time(YEAR, MONTH, LAST_DAY_OF_MONTH_NUM).strftime("%a")
print(("Last Day of Month: {}").format(LAST_DAY_OF_MONTH))
DIFFERENCE_IN_DAYS_BETWEEN_TODAY_AND_16 = DAY - 15
print(("Difference in Days Between Today and 16: {}").format(DIFFERENCE_IN_DAYS_BETWEEN_TODAY_AND_16))

class SiteElements():
  def __init__(self, url, cookies):
    service = Service()
    options = webdriver.ChromeOptions()
    self.driver = webdriver.Chrome(service=service, options=options)
    self.driver.get(url)
    if len(cookies):
      self.driver.add_cookie(cookies)

  costPointSystemUsername = (By.ID, 'USER')
  costPointSystemPassword = (By.ID, 'CLIENT_PASSWORD')
  costPointSystemInput = (By.ID, 'DATABASE')
  costPointLoginBtn = (By.ID, 'loginBtn')
  costPointNavTC = (By.ID, 'navTC')
  costPointTimeBtn = (By.ID, 'dpt__TM')
  costPointTimeSheetsBtn = (By.ID, 'wrk__Timesheets')
  costPointManageTimesheets = (By.ID, 'actvty__TMMTIMESHEET')
  costPointTimeSlotAbove15 = (By.ID, ('DAY{}_HRS-_0_E').format(DIFFERENCE_IN_DAYS_BETWEEN_TODAY_AND_16))
  costPointTimeSlotBelow15 = (By.ID, ('DAY{}_HRS-_0_E').format(DAY))
  costPointNewTimeSlot = (By.ID, ('DAY{}_HRS-_0_N').format(DAY))
  costPointSave = (By.ID, 'svBttn')
  costPointNewBtn = (By.CLASS_NAME, '.rsltst:last-child #newBttn')
  costPointScrollBar = (By.XPATH, '/html/body/div/div[14]/div[20]/div[8]/form/div[6]/div[2]/div/span[2]')
  costPointTimeCodeSlot = (By.ID, 'UDT02_ID-_0_E')
  costPointNewTimeCodeSlot = (By.ID, 'UDT02_ID-_0_N')
  costPointPayType = (By.ID, 'UDT10_ID-_0_E')
  costPointNewPayType = (By.ID, 'UDT10_ID-_0_N')
  costPointSign = (By.ID, 'SIGN_BUT')
  costSaveMessage = (By.ID, 'mLink208_0')

  def selenium_options(self):
    options = Options()
    options.add_argument('--headless')
    return options

  def isFirstHalfOfMonth(self):
    return DAY < 16

  def isLastDayOfTimePeriod(self):
    if DAY == 15 or DAY == LAST_DAY_OF_MONTH_NUM:
      return True
    elif self.isFirstHalfOfMonth() and DAY_OF_WEEK == 'Fri' and (DAY_15_OF_MONTH == 'Sat' or DAY_15_OF_MONTH == 'Sun'):
      return (15 - DAY) <= 2
    elif DAY_OF_WEEK == 'Fri' and (LAST_DAY_OF_MONTH == 'Sat' or LAST_DAY_OF_MONTH == 'Sun'):
      return (LAST_DAY_OF_MONTH_NUM - DAY) <= 2
    return False

  def costPointTimeSlot(self):
    if DAY > 15:
      return self.costPointTimeSlotAbove15
    else:
      return self.costPointTimeSlotBelow15

  def costPointNewLine(self):
    return self.driver.switch_to.active_element.send_keys(':f2')

  def costPointConfirmSign(self):
    return self.driver.switch_to.alert.accept()

  def close_browser(self):
    return self.driver.quit
