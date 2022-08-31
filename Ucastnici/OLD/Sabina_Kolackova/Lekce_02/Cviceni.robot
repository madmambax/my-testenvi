*** Settings ***
Library  Browser

*** Variables ***

${URL}      http://testovani.kitner.cz/login_app/

*** Test Cases ***

Test na URL
    New Browser    chromium    headless=false
    New Page       ${URL}

