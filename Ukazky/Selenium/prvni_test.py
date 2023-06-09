from selenium import webdriver
from selenium.webdriver.common.keys import Keys

# driver = webdriver.Firefox()
# driver = webdriver.Chrome()
options = webdriver.FirefoxOptions()
driver = webdriver.Firefox(executable_path="SeleniumDrivers\geckodriver.exe", options=options)

driver.get("http://www.python.org")
assert "Python" in driver.title
elem = driver.find_element_by_name("q")
elem.clear()
elem.send_keys("pycon")
elem.send_keys(Keys.RETURN)
assert "No results found." not in driver.page_source

input("Press Enter to continue...")
driver.close()