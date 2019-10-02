require "selenium-webdriver"
require "io/console"

class SiteElement
  def initialize(url)
    current_window = ""
    options = Selenium::WebDriver::Chrome::Options.new
    @driver = Selenium::WebDriver.for :chrome, options: options
    target_position = Selenium::WebDriver::Point.new(0, 0)
    @driver.manage.window.position = target_position
    current_window = @driver.window_handle()
    @driver.switch_to.window(current_window)
    @driver.navigate.to url
    # @driver.navigate().refresh();
  end

  def emailInput
    @driver.find_element(:id, "xReturningUserEmail")
  end

  def submitEmailBtn
    @driver.find_element(:id, "xCheckUser")
  end

  def entryForm
    @driver.find_element(:id, "xSecondaryForm")
  end

  def firstName
    @driver.find_element(:id, "name_Firstname");
  end

  def lastName
    @driver.find_element(:id, "name_Lastname");
  end

  def email
    @driver.find_element(:id, "email");
  end

  def address
    @driver.find_element(:id, "address_Address1");
  end

  def city
    @driver.find_element(:id, "address_City");
  end

  def state
    @driver.find_element(:id, "xFieldWrap_address_State").find_element(:class, 'option[data-value="VA"]');
  end

  def zip
    @driver.find_element(:id, "address_Zip");
  end

  def phone
    @driver.find_element(:id, "phone");
  end

  def sex
    @driver.find_element(:id, "gender_1");
  end

  def dobMonth
    @driver.find_element(:id, "xCompositeItem-Month").find_element(:class, 'option[data-value="03"]');
  end

  def dobDay
    @driver.find_element(:id, "date_of_birth_day");
  end

  def dobYear
    @driver.find_element(:id, "date_of_birth_year");
  end

  def isProvider
    @driver.find_element(:id, "mvpdWrapper").find_element(:class, 'option[data-value="Verizon_FIOS"]');
  end

  def submitEntryBtn
    @driver.find_element(:id, "xSecondaryForm").find_element(:class, "xSubmit")
  end

  def close_browser
    @driver.quit
  end
end
