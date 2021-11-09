"""

Testovací Data - tento test používá následují testovací data - přihlašovací údaje
Login novak
Heslo tajnenovak
Login admin
Heslo tajneadmin
adresa api je http://testovani.kitner.cz/login_app/userauth.php

"""



*** Settings ***
Library	    Collections
Library	    RequestsLibrary
Library     SeleniumLibrary



*** Variables ***
${browser}        chrome
${URL}            http://testovani.kitner.cz/login_app/


*** Test Cases ***
Valid Login
    Open browser ${url}   ${browser}
    Input Username    novak
    Input Password    tajnenovak
    Submit Credentials
    Welcome Page Should Be Open


Setting Variables
    Do Something    first argument    second argument
    ${value} =      Get Some Value
    Should Be Equal    ${value}       Expected value

*** Keywords ***

Login
   [Arguments]     ${username}        ${password}
   Input Text      inputUsernameID    ${username}
   Input Text      inputPasswordID    ${password}
   Click Button    buttonID

