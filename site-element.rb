require "selenium-webdriver"
require "io/console"
require "date"

MONTH = Time.now.month
DAY = Time.now.day
YEAR = Time.now.year
DAY_OF_WEEK = Time.now.strftime("%a")
DAY_15_OF_MONTH = Time.new(YEAR, MONTH, 15).strftime("%a")
DAY_16_OF_MONTH = Time.new(YEAR, MONTH, 16).strftime("%a")
LAST_DAY_OF_MONTH_NUM = Date.new(YEAR, MONTH, -1).day.to_i
LAST_DAY_OF_MONTH = Time.new(YEAR, MONTH, LAST_DAY_OF_MONTH_NUM).strftime("%a")
DIFFERENCE_IN_DAYS_BETWEEN_TODAY_AND_16 = DAY - 15

class SiteElement
  def initialize(url, cookies)
    current_window = ""
    caps = [
      selenium_options,
      selenium_capabilities_chrome,
    ]
    @driver = Selenium::WebDriver.for(:chrome, capabilities: caps)
    target_position = Selenium::WebDriver::Point.new(0, 0)
    @driver.manage.window.position = target_position
    current_window = @driver.window_handle()
    @driver.switch_to.window(current_window)
    @driver.navigate.to url

    cookies.each{ |cookie|
      @driver.manage.add_cookie(:name => cookie["name"], :value => cookie["value"], :secure => cookie["secure"] || false, :HTTP => cookie["HTTP"] || false, :domain => cookie["domain"])
    }
    @driver.navigate().refresh();
  end

  def selenium_options
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options
  end
  
  # optional
  def selenium_capabilities_chrome
    Selenium::WebDriver::Remote::Capabilities.chrome
  end

  def isFirstHalfOfMonth
    DAY < 16
  end
  
  def isLastDayOfTimePeriod
    if (DAY == 15 || DAY == LAST_DAY_OF_MONTH_NUM)
      return true
    elsif isFirstHalfOfMonth && DAY_OF_WEEK == 'Fri' && (DAY_15_OF_MONTH == 'Sat' || DAY_15_OF_MONTH == 'Sun')
      return (15 - DAY) <= 2
    elsif DAY_OF_WEEK == 'Fri' && (LAST_DAY_OF_MONTH == 'Sat' || LAST_DAY_OF_MONTH == 'Sun')
      return (LAST_DAY_OF_MONTH_NUM - DAY) <= 2
    end
    return false
  end

  def costPointSystemUsername
    @driver.find_element(:id, "USER")
  end

  def costPointSystemPassword
    @driver.find_element(:id, "CLIENT_PASSWORD")
  end

  def costPointSystemInput
    @driver.find_element(:id, "DATABASE")
  end

  def costPointLoginBtn
    @driver.find_element(:id, "loginBtn")
  end

  def costPointNavTC
    @driver.find_element(:id, "navTC")
  end

  def costPointTimeBtn
    @driver.find_element(:id, "dpt__TM")
  end

  def costPointTimeSheetsBtn
    @driver.find_element(:id, "wrk__Timesheets")
  end

  def costPointManageTimesheets
    @driver.find_element(:id, "actvty__TMMTIMESHEET")
  end

  def costPointTimeSlot
    if DAY > 15
      @driver.find_element(:id, format("DAY%s_HRS-_0_E", DIFFERENCE_IN_DAYS_BETWEEN_TODAY_AND_16))
    else
      @driver.find_element(:id, format("DAY%s_HRS-_0_E", DAY))
    end
  end

  def costPointNewTimeSlot
    @driver.find_element(:id, format("DAY%s_HRS-_0_N", DAY))
  end

  def costPointSave
    @driver.find_element(:id, "svBttn")
  end

  def costPointNewBtn
    @driver.find_elements(:class, "rsltst")[1].find_element(:id, "newBttn")
  end

  def costPointScrollBar
    @driver.find_elements(:class, 'hScrCnt')[3].find_element(:id, "hp2")
  end

  def costPointNewLine
    @driver.switch_to.active_element.send_keys(:f2)
  end

  def costPointTimeCodeSlot
    @driver.find_element(:id, "UDT02_ID-_0_E")
  end

  def costPointNewTimeCodeSlot
    @driver.find_element(:id, "UDT02_ID-_0_N")
  end

  def costPointPayType
    @driver.find_element(:id, "UDT10_ID-_0_E")
  end

  def costPointNewPayType
    @driver.find_element(:id, "UDT10_ID-_0_N")
  end

  def costPointSign
    @driver.find_element(:id, "SIGN_BUT")
  end

  def costSaveMessage
    @driver.find_element(:id, "mLink208_0")
  end

  def costPointConfirmSign
    @driver.switch_to.alert.accept
  end

  def close_browser
    @driver.quit
  end
end
