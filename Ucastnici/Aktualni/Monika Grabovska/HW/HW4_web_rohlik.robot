*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

#Prihlaseni bad login
 #   Login               dsadsad@sdas.cz                     dasdas                      Přihlásit
#Prihlaseni bad heslo
 #   Login               radek.tester@seznam.cz              dasdas                      Přihlásit
Login_success
    Login_with_control               bavemal543@cebaike.com               tajneheslotajneheslo        MS
    User_logged_in
    Add_to_cart                      maso                              1353879                   2
    Remove
    Logout

Login_no_success
    Login_with_control               dsadsad@sdas.cz               noha          Účet
    User_is_not_logged_in


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login_with_control
    [Arguments]     ${pemail}      ${pheslo}     ${validation}

    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title    contains    supermarket
    Cookie        AcceptAll

    Sleep        2
    Click        xpath=//*[@id="__next"]/div[4]/div[3]/div/div/div[2]/div/div[2]/button
    Sleep        2
    Click        id=email
    Type text    id=email       ${pemail}


    Click        id=password
    Type Text    id=password      ${pheslo}
    Sleep        2
    Click       data-test=IconEyeStroked
    Click       data-test=btnSignIn
    Sleep       2

User_logged_in
    Get Text       data-test=header-user-icon    contains   MS
User_is_not_logged_in
    Get Text       data-test=header-user-icon    contains    Účet

Cookie
    [Arguments]     ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               1
Logout
    Go To           ${URL}
    Click           id=headerUser
    Click           data-test=user-box-logout-button
Add_to_cart

    [Arguments]       ${itema}       ${itema_id}        ${quantity}

    Type Text           id=searchGlobal      ${itema}
    Click               data-test=header-search-button
    Sleep    2
    Click               css=[data-product-id="${itema_id}"][data-test="btnAdd"]
    ${amount}           Evaluate                    ${quantity} - 1
    Sleep    2
    Click              css=[data-product-id="${itema_id}"][data-test="btnPlus"]  clickCount= ${amount}
    Go To              ${URL}
    Sleep              2

Remove
    Click               data-test=IconCart
    Sleep               2
    Click               css=[data-gtm-button="clear-cart"]
    Sleep               2