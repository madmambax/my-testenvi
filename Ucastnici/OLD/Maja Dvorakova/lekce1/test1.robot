*** Settings ***

Library     SeleniumLibrary

*** Variables ***

*** Test Cases ***

LoginTest

    create webdriver    chrome  executable_path="C:\Users\Maja\Downloads\chromedriver_win32.zip"
    open browser        http://testovani.kitner.cz/ chrome


*** Keywords ***