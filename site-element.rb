require "selenium-webdriver"
require "io/console"

TODAY = /([A-z])\w+/.match(Time.now.strftime("%a, %m"))[0]


class SiteElement
  def initialize(url, cookies)
    current_window = ""
    options = Selenium::WebDriver::Chrome::Options.new
    @driver = Selenium::WebDriver.for :chrome, options: options
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

  # ********** START Deltek Login Page elements **********
  def deltekLoginUsername
    @driver.find_element(:id, "uid")
  end
  def deltekLoginPassword
    @driver.find_element(:id, "passField")
  end
  def deltekLoginDomain
    @driver.find_element(:id, "dom")
  end
  def deltekLoginButton
    @driver.find_element(:id, "loginButton")
  end
  # ********** END Deltek Login Page elements **********

  # ********** START Deltek Desktop Page elements **********
  def switchToIframe
    @driver.switch_to.frame "unitFrame"
  end
  def deltekDesktopOpenTimesheet
    @driver.find_elements(:class, "desktopNormalAlertBackgroud")[1]
      .find_element(:tag_name, "span")
  end
  # ********** END Deltek Desktop Page elements **********

  # ********** START Deltek Timesheet Page elements **********
  def hasTimesheetHeader
    @driver.find_element(:id , "appTitle")
  end
  def hoursHeader
    puts(TODAY)
    @driver.find_element(:id, "hrsHeaderText4")
  end
  def projectNameCell
    @driver.find_element(:id, "udt0_2")
  end
  # ********** END Deltek Timesheet Page elements **********

  def costPointSystemInput
    @driver.find_element(:id, "DATABASE")
  end

  def costPointTimeSlot
    @driver.find_element(:id, format("DAY%s_HRS-_0_E", DAY))
  end

  def costPointNewBtn
    @driver.find_elements(:class, "rsltst")[1].find_element(:id, "newBttn")
  end

  def costPointNewLine
    @driver.switch_to.active_element.send_keys(:f2)
  end

  def costPointConfirmSign
    @driver.switch_to.alert.accept
  end

  def close_browser
    @driver.quit
  end
end
