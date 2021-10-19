#
# požadavky:
#
# web driver musí být nahrán v cestě (PATH)
# pip install selenium
# pip install robotframework-seleniumlibrary 
#

*** Settings ***
Documentation     Automatizace rohlik.cz.
Library           SeleniumLibrary
#Library           DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug


*** Variables ***
${LOGIN URL}      http://rohlik.cz
${BROWSER}        Chrome


*** Test Cases ***
Valid Login
    Open Browser To Login Page
#    Click Link                 headerLogin
#    Click Link                 css:#headerLogin
#    Click Link                 xpath://*[@id="headerLogin"]/x-translation
#    Click Link                 class:sc-18g3ccf-3 fnBZyB
#    Click Link                 xpath://x-translation[contains(text(),'Přihlásit')]
    Click Element               headerLogin

    ${AllLinks}=                Get All Links
    Log                         ${AllLinks}

    Input Username              testuser
    Input Password              tajneheslo
#    Debug
    Submit Credentials
    Element Text Should Be      emailError  Zadejte platný email
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${LOGIN URL}                                                    ${BROWSER}
    Title Should Be     Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

Input Username
    [Arguments]         ${username}
    Input Text          email           ${username}

Input Password
    [Arguments]         ${password}
    Input Text          password        ${password}

Submit Credentials
    Click Element       xpath://x-translation[contains(text(),'Přihlásit se')]



