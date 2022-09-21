*** Settings ***
Library    Browser



*** Variables ***
${pemail}    radek.tester@seznam.cz
${pheslo}    tajneheslotajneheslo
${pnastane}  data-test=header-user-icon=JT



*** Test Cases ***


Přihlášení na www.rohlik.cz

    New Browser    chromium  headless=false
    New Context    viewport={'width': 1280, 'height': 800}
    New Page       https://rohlik.cz/
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    Click          text="Povolit všechny"

    Click          id=headerLogin

#    Click          text="Přihlásit"
#    Sleep          10
#
#    Click          data-test=IconUserLogin
#    Sleep          10

    Type Text      id=email     ${pemail}

    Type Text      id=password  ${pheslo}

    Click          data-test=btnSignIn

    Log             ${pnastane}

    Click           id=headerUser

    Click           data-test=user-box-logout-button
    Sleep           5

    Log             id=headerLogin

*** Keywords ***

Login
    [Arguments]         ${pemail}                            ${pheslo}                    ${pnastane}
    #zkopírovaný test case