"""

Testovací Data - tento test používá následují testovací data - přihlašovací údaje
Login novak
Heslo tajnenovak
Login admin
Heslo tajneadmin
adresa api je http://testovani.kitner.cz/login_app/userauth.php

"""
#Nefunkční test - v rozpracovanosti



*** Settings ***
Library	Collections
Library	RequestsLibrary
Library  Browser



*** Variables ***
${browser}  chrome
${url}		http://testovani.kitner.cz/login_app/


*** Test Cases ***
Login novak Input Text
    [Documentation]  	Uspesne prihlaseni pomoci Input Text
    Open Browser        ${browser}          ${url}
    Input Text          id=inputUsername    novak
    Input Password      id=inputPassword    tajnenovak
    Click Button        id=butt


Login
    [Documentation]  	Neuspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       tajneadmin


*** Keywords ***

Login
    [Arguments]     ${username}         ${password}
    Input Text      inputUsernameID     ${username}
    Input Text      inputPasswordID     ${password}
    Click Button    buttonID            butt
