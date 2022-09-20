*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.mypillow.cz/

#robot .\Pillow.robot

*** Test Cases ***

Prihlaseni správný login a heslo
  Login          XXXXXX                    XXXXXXXX.                      Přihlásit
Prihlaseni špatný login
  Login          vaseh11111                tvoje44444.                      Přihlásit
Prihlaseni špatný heslo
  Login          vaseh1                    adarr664444.                  Přihlásit

*** Keywords ***
Login

    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}
    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    New Browser    chromium    headless=false
    New Context    viewport={'width': 1720, 'height': 980}
    New Page       ${URL}
    Get Title      ==   Pillow pojišťovna
    Click          text="Přihlásit se"
    sleep          2
    Click          id=username
    Type Text      id=username    ${pemail}
    sleep          2
    Click          id=password
    Type Text      id=password    ${pheslo}
    sleep          2
    Click          text="Pokračovat"
    sleep          11
    Take Screenshot
    sleep          2
