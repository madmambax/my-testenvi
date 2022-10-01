*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.mypillow.cz/

#robot .\Pillow.robot

*** Test Cases ***

Prihlaseni správný login a heslo
  Login          dvasek1                   Kalendar66.                      Přihlásit
  Logout
Prihlaseni špatný login
  Login          vaseh141111                tvoje44444.                      Přihlásit
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
    sleep          10
    Take Screenshot
    sleep          2

Logout
     Go to           ${URL}
     Click           css=[class="mat-menu-trigger pilic pilic-11 icon-angle-down"]
     Click           text="Odhlásit"
     Take Screenshot

# span _ngcontent-csc-c57="" mat-button="" class="mat-menu-trigger pilic pilic-11 icon-angle-down" aria-haspopup="menu"></span>

