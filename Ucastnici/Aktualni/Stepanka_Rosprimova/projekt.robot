*** Settings ***
Library    Browser

*** Variables ***
${webUrl}      https://www.jezdectvi.org/

*** Test Cases ***
Prihlaseni chybny login
    Login               rosprimova.stepanka                 Vorman1793                  Přihlásit se

Prihlaseni chybne heslo
    Login               stepanka.rosprimova                 Vorman1234                  Přihlásit se

Prihlaseni uspesne a odhlaseni
    Login               stepanka.rosprimova                 Vorman1793                  Štěpánka Rosprimová
    Logout              Štěpánka Rosprimová

*** Keywords ***
Login
    [Arguments]        ${login}      ${password}     ${buttonText}
    [Documentation]    Prihlaseni uzivatele do JIS
    Log                ${login}
    Log                ${password}
    Log                ${buttonText}

    New Browser        chromium    headless=false
    New Page           ${webUrl}
    Get Title          ==    ČJF | Jezdecký Informační Systém
    Sleep              3
    Click              id=cms-auth
    Sleep              3
#    Set Strict Mode    false
    Type Text          css=input#id_username                         ${login}
    Type Text          css=input#id_password                         ${password}
    Sleep              3
    Click              id=login-button
    Sleep              3
    Get Text           css=#cms-auth > div:nth-child(1) > a    ==    ${buttonText}

Logout
    [Arguments]        ${buttonText}
    [Documentation]    Odhlaseni uzivatele z JIS

    Log                ${buttonText}

    Get Text           css=#cms-auth > div:nth-child(1) > a    ==    ${buttonText}
    Click              xpath=//*[@id="cms-auth"]
    Sleep              3
    Click              id=logout-button
    Sleep              3
    Get Text           css=#cms-auth > div:nth-child(1) > a    ==    Přihlásit se
    Take Screenshot    screenshot

#Open Browser       - otevření prohlížeče
#New Page           - otevření nové stránky
#Type Text          - vložení hodnoty (na požadované pole)
#Click              - klik (na požadované tlačítko)
#Take Screenshot    - vytvoření screenu
#Get Title          - získá titulek webu (lze jej porovnat s požadovaným)
#Get Text           - získá obsah daného pole (lze jej porovnat s požadovaným)
