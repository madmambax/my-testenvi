from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


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

#chack if page contains string "Vitej"
assert "Vitej" in driver.page_source

#Wait until element is ready
wait = WebDriverWait(driver, 10)
elem3 = wait.until(EC.element_to_be_clickable((By.ID, 'logout')))

#logout
elem3.click()

#assert "Login" in driver.page_source

#wait for ENTER
input("Press Enter to continue...")
driver.close()
