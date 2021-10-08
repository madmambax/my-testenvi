*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Test Cases ***
První test
    Open Browser      https://www.rockpoint.cz/     chrome
    Click Link      xpath://a[contains(text(),'Přihlášení / Registrace')]
    Input Text      id:login-email  alidemeterova@yahoo.com
    Input Text      id:login-heslo  NwWm63.3UdB96S2
    Click Element   xpath://button[contains(text(),'Přihlásit')]
    Close Browser

