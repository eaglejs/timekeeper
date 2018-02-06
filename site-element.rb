require 'selenium-webdriver'
require 'io/console'

TODAY = /([A-z])\w+/.match(Time.now.strftime('%a, %m'))[0]

DAY = case TODAY
    when 'Sat' then 1
    when 'Sun' then 2
    when 'Mon' then 3
    when 'Tue' then 4
    when 'Wed' then 5
    when 'Thu' then 6
    when 'Fri' then 7
end

class SiteElement
  def initialize(url)
	current_window = ''
	options = Selenium::WebDriver::Chrome::Options.new
	@driver = Selenium::WebDriver.for :chrome, options: options
	#@driver = Selenium::WebDriver.for :chrome
    # @driver.manage.window.maximize
    target_position = Selenium::WebDriver::Point.new(0, 0)
    #target_size = Selenium::WebDriver::Dimension.new(840, 1050)
    @driver.manage.window.position = target_position
	current_window = @driver.window_handle()
	@driver.switch_to.window(current_window)
	@driver.manage.window.maximize()
	@driver.navigate.to url
  end

  def msUserName
    @driver.find_element(:id, 'i0116')
  end

  def msSubmit
    @driver.find_element(:id, 'idSIButton9')
  end

  def msUserPass
    @driver.find_element(:id, 'passwordInput')
  end

  def msSubmitLogin
    @driver.find_element(:id, 'submitButton')
  end 
  
  def msRememberMeYes
	@driver.find_element(:id, 'idSIButton9')
  end

  def verificationLink
    @driver.find_element(:id, 'verificationOption3')
  end

  def costPointSystemInput
    @driver.find_element(:id, 'DATABASE')
  end

  def costPointLoginBtn
    @driver.find_element(:id, 'loginBtn')
  end

  def costPointNavTC
    @driver.find_element(:id, 'navTC')
  end

  def costPointTimeBtn
    @driver.find_element(:id, 'dpt__TM')
  end

  def costPointTimeSheetsBtn
    @driver.find_element(:id, 'wrk__Timesheets')
  end

  def costPointManageTimesheets
    @driver.find_element(:id, 'actvty__TMMTIMESHEET')
  end

  def costPointTimeSlot
    @driver.find_element(:id, format('DAY%s_HRS-_0_E', DAY))
  end

  def costPointNewTimeSlot
    @driver.find_element(:id, format('DAY%s_HRS-_0_N', DAY))
  end

  def costPointSave
    @driver.find_element(:id, 'svBttn')
  end

  def costPointNewBtn
    @driver.find_elements(:class, 'rsltst')[1].find_element(:id, 'newBttn')
  end

  def costPointNewLine
    @driver.switch_to.active_element.send_keys(:f2)
  end

  def costPointTimeCodeSlot
    @driver.find_element(:id, 'UDT02_ID-_0_E')
  end

  def costPointNewTimeCodeSlot
    @driver.find_element(:id, 'UDT02_ID-_0_N')
  end

  def costPointPayType
    @driver.find_element(:id, 'UDT10_ID-_0_E')
  end

  def costPointNewPayType
    @driver.find_element(:id, 'UDT10_ID-_0_N')
  end

  def costPointSign
    @driver.find_element(:id, 'SIGN_BUT')
  end

  def costPointConfirmSign
    @driver.switch_to.alert.accept
  end

  def close_browser
    @driver.quit
  end
end
