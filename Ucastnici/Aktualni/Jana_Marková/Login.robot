"""

Cvičení 01
poznámka: Mezi trojté uvozovky se píší víceřádkové komentáře

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

Testovací Data - tento test používá následují testovací data - přihlašovací údaje
Login novak
Heslo tajnenovak
Login admin
Heslo tajneadmin
adresa api je http://testovani.kitner.cz/login_app/userauth.php

"""
# kratký komentář



*** Settings ***
Library	SeleniumLibrary





*** Variables ***

${browser}		    IE
${SERVER}           cswworkflow:81
${LOGIN URL}        http://${SERVER}/login.aspx
${WELCOME URL}      http://${SERVER}/default.aspx
${ERROR URL}        http://${SERVER}/login.aspx

*** Test Cases ***
Přihlas uživatele
    Otevřít přihlašovací stránku        ${LOGIN URL}        ${browser}
    Jdi na přihlašovací stránku
    Vlož Username       JMarkova
    Vlož Password       a
    Potvrď
    Přihlášení proběhlo


*** Keywords ***
Otevřít přihlašovací stránku
    [Arguments]    ${loginpage}       ${browser}
    Open Browser    ${loginpage}       ${browser}
    Maximize Browser Window
    Byla otevřena správná stránka

Byla otevřena správná stránka
    Title Should Be     Portal - Přihlášení

Jdi na přihlašovací stránku
    Go To    ${LOGIN URL}
    Byla otevřena správná stránka

Vlož Username
    [Arguments]    ${username}
    Input Text    userName    ${username}

Vlož Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Potvrď
    Click Button    btnLogIn

Přihlášení proběhlo
    Location Should Be    ${WELCOME URL}
    Title Should Be     Portal - Přihlášení