# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation     Automatizace rohlik.cz s BrowserLibrary
Library   Browser
#Library           DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug


*** Variables ***
${URL}         https://rohlik.cz




*** Test Cases ***
Example Test
#    Open Available Browser      ${URL}      headless=True
    New Page                    ${URL}
#    Get Text                    h1    ==    Playwright enables reliable end-to-end testing for modern web apps.
#    Get Element
    Get Title                  contains        Online supermarket Rohlik.cz

    Click                       id=headerLogin
    Type Text                   id=email       testuser
    Type Text                   id=password    tajneheslo
#    Debug
    Click                       xpath=//x-translation[contains(text(),'Přihlásit se')]
    Get Text                    id=emailError  ==                                             Zadejte platný email



