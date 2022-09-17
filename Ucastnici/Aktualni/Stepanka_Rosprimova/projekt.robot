*** Settings ***
Library    Browser

*** Variables ***
${webUrl}      https://www.jezdectvi.org/

*** Test Cases ***
Prihlaseni chybny login
    Login               rosprimova.stepanka                 Vorman1793                  Přihlásit se

Prihlaseni chybne heslo
    Login               stepanka.rosprimova                 Vorman1234                  Přihlásit se

Prihlaseni uspesne
    Login               stepanka.rosprimova                 Vorman1793                  Štěpánka Rosprimová
#    + doplnit Logout

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

Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       ${webUrl}
    Get Title      ==    ČJF | Jezdecký Informační Systém
#   Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          5
    Click          text="Přihlásit se"
    Click          id=cms-auth
    Click          css=#cms-auth
    Click          xpath=//*[@id="cms-auth"]
#   Click          data-login=cms-auth
    Sleep          5

    Type Text      text=”Uživatelské jméno”             ${login}
    Type Text      text=”Heslo”                         ${password}

    Type Text      id=id_username                       ${login}
    Type Text      id=id_password                       ${password}

    Type Text      css=#id_username                     ${login}
    Type Text      css=#id_password                     ${password}

    Type Text      xpath=//*[@id="id_username"]         ${login}
    Type Text      xpath=//*[@id="id_password"]         ${password}

    Type Text      data-username=cms-username           ${login}
    Type Text      data-password=cms-password           ${password}

    Sleep          5

    Click          text="Přihlásit se"
    Click          id=login-button
    Click          css=#login-button
    Click          xpath=//*[@id="login-button"]
#   Click          data-login-button=cms-auth-button

    Get Text       css=#cms-auth > div:nth-child(1) > a    ==    ${buttonText}

#Open Browser
#New Page
#Type Text
#Click
#Take Screenshot
#Type Text
#Get Title
#Get Text
