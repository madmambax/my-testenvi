from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
#from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys

options = webdriver.FirefoxOptions()
driver = webdriver.Firefox(executable_path="SeleniumDrivers\geckodriver.exe", options=options)

driver.get("http://testovani.kitner.cz/login_app/")
assert "test_login" in driver.title

#fill username
elem1 = driver.find_element_by_name("name")
elem1.send_keys("novak")
elem1.send_keys(Keys.RETURN)

#fill password
elem2 = driver.find_element_by_name("password")
elem2.send_keys("tajnenovak")
elem2.send_keys(Keys.RETURN)

input("Press Enter to continue...")

ids = driver.find_elements_by_xpath('//*[@id]')
for ii in ids:
    #print (ii.tag_name)
    print (ii.get_attribute('id')) # id name as string


driver.close()