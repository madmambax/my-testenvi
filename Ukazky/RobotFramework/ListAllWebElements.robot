#
# požadavky:
#
# web driver musí být nahrán v cestě (PATH)
# pip install selenium
# pip install robotframework-seleniumlibrary
#

*** Settings ***
Documentation     List all web elements from on class
Library           SeleniumLibrary


*** Variables ***
${LOGIN URL}      http://testovani.kitner.cz/login_app/
${BROWSER}        Chrome


*** Test Cases ***
Get Elements
    Open Browser To Login Page
    ${elements}=    Get WebElements    //div
    FOR    ${element}    IN    @{elements}
            Log             ${element.text}
            Log to console  ${element.text}
    END

    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be    test_login






