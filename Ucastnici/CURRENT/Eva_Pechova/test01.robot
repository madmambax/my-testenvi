*** Settings ***
Library     SeleniumLibrary

*** Test Case ***
Test1 pozitivní

    Open browser        http://www.google.com   chrome
    go to               https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Copy%20Directory
    close browser

Test2 negativní
    Open browser        http://www.seznam.cz    firefox
    close browser

Test3 pozitivní
    Open browser                        https://robotframework.org/    chrome
    page should contain                 Robot
    close browser

Test4 negativní
    Open browser                        https://robotframework.org/    chrome
    page should not contain             Ahoj
    close browser