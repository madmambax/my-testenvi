#
# požadavky:
#
#   web driver musí být nahrán v cestě (PATH)
#   pip install selenium
#   pip install robotframework-seleniumlibrary
#

*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary


*** Variables ***
${LOGIN URL}      http://testovani.kitner.cz/login_app/
${BROWSER}        Chrome
${SEL_DRIVER}     C:\Users\radek\AppData\Local\Programs\Python\Python37-32\Scripts\   # nepoužívá se, webdriver je nahraný v cestě

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username                  novak
    Input Password                  tajnenovak
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]                      Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${LOGIN URL}    ${BROWSER}
    Title Should Be     test_login

Input Username
    [Arguments]         ${username}
    Input Text          inputUsername   ${username}

Input Password
    [Arguments]         ${password}
    Input Text          inputPassword   ${password}

Submit Credentials
    Click Button        butt

Welcome Page Should Be Open
    Log Location
    Wait Until Page Contains            Vitej
#    Wait Until Page Contains Element    username           # další možný způsob kontroly
    Log Location


