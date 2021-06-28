*** Settings ***
Library         SeleniumLibrary

*** Variables ***

${browser}  chrome
${url}      https://www.rohlik.cz/

*** Test Cases ***
LoginTest
    open browser    ${url}      ${browser}
    LoginToApplication
    close browser



*** Keywords ***

LoginToApplication
    click element   id=headerLogin
    get all links
    input text      xpath=//*[@id="email"]                                                                      TesterNotARobot12@gmail.com
    input text      xpath=//*[@id="password"]                                                                   hesloNeniPassword34
    press keys      xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button          [return]
