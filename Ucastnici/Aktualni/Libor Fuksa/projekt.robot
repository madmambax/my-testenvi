*** Settings ***
Library  Browser

*** Variables ***
${URL}          https://www.rohlik.cz/
${pnastane}     Účet

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}
    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=    Rohlik
    Click  id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep  2
    Click    "Účet"
    Sleep   1
    Type Text   id=email       ${pemail}
    Type text   id=password    ${pheslo}
    Click       data-test=btnSignIn
    Get Text    data-test=header-user-icon  ==  ${pnastane}
    sleep  1
    Take Screenshot  filename=TEST-${TEST NAME}


odhlaseni
    Click  id=headerUser
    sleep  1
    click  data-test=user-box-logout-button
    sleep  1
    Take Screenshot  filename=TEST-ODHLASENI

*** Test Cases ***

Prihlaseni bad login
  Login               dsadsad@sdas.cz                     MojeHeslo1_        Účet

Prihlaseni bad heslo
  Login               hawetay362@laserlip.com             Nejake heslo       Účet


Prihlaseni success
  Login               hawetay362@laserlip.com             MojeHeslo1_        L
  Odhlaseni