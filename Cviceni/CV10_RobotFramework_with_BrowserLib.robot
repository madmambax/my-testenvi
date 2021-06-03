# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Test webu
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email     kfjhdskjfhsadjkf
    Take Screenshot