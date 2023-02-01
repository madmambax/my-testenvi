*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Login_test
    Login               kayob47290@teknowa.com              hesloheslo                    Přihlásit
    sleep  2
    Click          \#headerUser
    Click          data-test=user-box-logout-button
    sleep  2



*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    New Browser    chromium  headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    sleep  1
    Click          id=headerLogin

    Type Text      id=email       ${pemail}
    Fill Secret    id=password    ${pheslo}


    Click          data-test=btnSignIn