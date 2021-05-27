from selenium import webdriver
from selenium.webdriver.common.by import By
import unittest

class LoginTest(unittest.TestCase):
    def setUp(self) -> None:
        self.options = webdriver.ChromeOptions()
        self.driver = webdriver.Chrome(executable_path="chromedriver.exe", options= self.options)
        self.driver.implicitly_wait(5)

    def test_ucet(self):
        driver = self.driver
        driver.get("https://www.ponoziska.cz")
        ucet = driver.find_element(By.XPATH,"//*[@id='et-secondary-nav']/li[3]")
        ucet.click()
        driver.implicitly_wait(5)
        self.assertIn("Můj účet" and "Přihlášení",driver.page_source)

        jmeno = driver.find_element(By.ID,"username")
        jmeno.send_keys("janka.pasakova@gmail.com")

        heslo = driver.find_element(By.ID, "password")
        heslo.send_keys("tester.testersky")

        button = driver.find_element(By.NAME, "login")
        button.click()
        logout = driver.find_element(By.XPATH, "//*[@id='post-110']/div/div/div/p[1]/a")
        self.assertEqual(logout.text,"Odhlásit se")
        print("Ok")
        logout.click()


    def tearDown(self) -> None:
        self.driver.close()

if __name__ == " __main__":
    unittest.main()

