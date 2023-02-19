*** Settings ***
Library  Browser    auto_closing_level= suite

*** Variables ***
${URL}          https://www.rohlik.cz/
${pnastane}     Účet

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}
    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    Type Text   id=email       ${pemail}
    Type text   id=password    ${pheslo}
    Click       data-test=btnSignIn
    Get Text    data-test=header-user-icon  ==  ${pnastane}
    sleep  1
    Take Screenshot  filename=TEST-${TEST NAME}

*** Test Cases ***

Otevreni ROHLIK.CZ
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=    Rohlik
    Click  id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep  2

Otevreni Loginu (ucet)
#    Click  data-test=IconUserLogin (funguje)
#    Click  xpath=//*[@id="__next"]/div[4]/div[3]/div/div/div[2]/div/div (nefunguje mi)
    Click    "Účet"
    Sleep   1
    Take Screenshot  filename=TEST-${TEST NAME}

Prihlaseni bad login
  Login               dsadsad@sdas.cz                     MojeHeslo1_        Účet

Prihlaseni bad heslo
  Login               hawetay362@laserlip.com             Nejake heslo       Účet

Prihlaseni success
  Login               hawetay362@laserlip.com             MojeHeslo1_        L

Odhlasení success
  Click  id=headerUser
  sleep  1
  click  data-test=user-box-logout-button
  sleep  1
  Take Screenshot   filename=TEST-${TEST NAME}
