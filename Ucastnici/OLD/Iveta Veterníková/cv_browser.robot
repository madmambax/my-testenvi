*** Settings ***
Library     Browser


*** Variables ***


*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       https://www.rohlik.cz/vitejte
    #Click         id=headerLogin
    #Click         "Přihlásit"
    Click          id=headerLogin
    Type Text      data-test=user-login-form-email     login
    Type Text    data-test=user-login-form-password    heslo
    Take Screenshot    


    #headerLogin+