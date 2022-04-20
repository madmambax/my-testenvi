*** Settings ***
Library  Browser

*** Variables ***


*** Test Cases ***

* Test Cases *
Starting a browser with a page
    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/vitejte#_=_
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          2
    Click          id=headerLogin
    Take Screenshot
    Type Text      data-test=user-login-form-email          radek.tester@seznam.cz
    Type Text      data-test=user-login-form-password       tajneheslotajneheslo
    Click          data-test=btnSignIn
    Click          id=headerUser

    ${Text}         Get Text                                 data-test=my-account-button
    Log To Console      ${Text}
    ${Text}        ==   Můj účet   # přijít na to jak porovnat proměnou

#    Type Text       id=searchGlobal     Ahoj
#    ${Text}=        Get Text        data-test=header-user-icon
#    Log To Console      ${Text}
#
#   Click          data-test=header-user-icon
#   Click          id=headerLogin
#    Click          text=Přihlásit
#    Take Screenshot
*** Keywords ***

Login