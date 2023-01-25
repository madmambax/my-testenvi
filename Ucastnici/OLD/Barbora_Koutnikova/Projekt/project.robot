*** Settings ***
Documentation               Automation rohlik.cz with BrowserLibrary
Library                     Browser

Resource                    Data/testData.robot
Resource                    Data/configuration.robot

Suite Setup     Before suite
Suite Teardown  After suite

Test Setup      Before test
Test Teardown   After test

Test Timeout                ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***

Pridani zbozi do kosiku
    Login                   ${USER1_NAME}        ${USER1_PWD}      ${USER1_SHORT}
    Add to the cart         ${PRODUCT01_NAME}    ${PRODUCT01_ID}     5
    Remove from the cart    ${TEXT_EmptyCart}
    [Teardown]  Logout      ${TEXT_Prihlasit}

Pridani do kosiku - maximalni pocet 50 ks
    Login                   ${USER1_NAME}        ${USER1_PWD}      ${USER1_SHORT}
    Add to the cart         ${PRODUCT01_NAME}    ${PRODUCT01_ID}     50
    Remove from the cart    ${TEXT_EmptyCart}
    [Teardown]  Logout      ${TEXT_Prihlasit}

Pridani do kosiku - negativni test 51 ks
    Login                   ${USER1_NAME}        ${USER1_PWD}      ${USER1_SHORT}
    Add to the cart         ${PRODUCT01_NAME}    ${PRODUCT01_ID}     51
    Remove from the cart    ${TEXT_EmptyCart}
    [Teardown]  Logout      ${TEXT_Prihlasit}


*** Keywords ***

Login
    [Arguments]         ${email}            ${password}            ${validation}

    Log                 ${email}
    Log                 ${password}
    Log                 ${validation}

    Click               ${SEL_HeaderUserIcon}
    Type Text           ${SEL_LoginEmail}   ${email}
    Type Text           ${SEL_Password}     ${password}
    Click               ${SEL_BtnSignIn}

    Get Text            ${SEL_HeaderUserIcon}  ==  ${validation}
    ${log}=  Get Text   ${SEL_HeaderUserIcon}
    Log                 ${log}
    Take Screenshot


Logout
    [Arguments]         ${validation}
    Click               ${SEL_HeaderUserIcon}
    Click               ${SEL_LogoutBtn}

    Get Text            ${SEL_HeaderLogin}  ==  ${validation}
    ${log}=  Get Text   ${SEL_HeaderLogin}
    Log                 ${log}
    Take Screenshot


Add to the cart
    [Arguments]         ${product}  ${product_id}  ${number}
    Type Text           ${SEL_SearchGlobal}        ${product}
    Click               ${SEL_SearchBtn}
    Get text            text="produktů"
    Click               css=[${SEL_ProductID}="${product_id}"][${SEL_BtnAdd}]
    ${num_click}=       Evaluate  ${number}-1
    Click               css=[${SEL_ProductID}="${product_id}"][${SEL_BtnPlus}]  clickCount=${num_click}

    IF  ${number} > 50
        ${error_num}=  Get Text  data-test=error-tooltip
        Log            ${error_num}
        Get Text       data-test=error-tooltip  matches        (?i)${TEXT_MaxNumber}
        Take Screenshot
    END

    ${cart_text}=       Get Text               ${SEL_CartItem}
    Log                 ${cart_text}
    Get Text            ${SEL_CartItem}        matches         (?i)${product}
    Take Screenshot


Remove from the cart
    [Arguments]         ${empty_cart}
    ${old_mode} =       Set Strict Mode        False
    Go To               ${URL_cart}
    Click               ${SEL_RemoveCart}

    ${cart_content}=    Get Text       ${SEL_CartReview}
    Log                 ${cart_content}

    FOR    ${i}    IN RANGE    100
           sleep               ${TIME_BETWEEN_CHECKS}
           ${cart_content}=    Get Text         ${SEL_CartReview}
           Exit For Loop If    '${TEXT_EmptyCart}' in '''${cart_content}'''

           Log                  ${cart_content}
           Log                  ${i}
    END

    Set Strict Mode     ${old_mode}

    #Click                [aria-label^="Odstranit z košíku"]

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

Before suite
    ${b_timeout} =      Set Browser Timeout                   ${TIMEOUT_BROWSER}
    Log                 Původní hodnota timeout ${b_timeout}
    New Browser         ${BROWSER1}         headless=false
    New Page            ${URL}
    Get Title           ==                  ${TEXT_Title}
    Cookie              AcceptAll

Before test
    Go To               ${URL}
    #check logout
    ${short_login}      Get Text            ${SEL_HeaderUserIcon}
    Log                 ${short_login}
    IF    "${short_login}" == "${USER1_SHORT}"
         Click          ${SEL_HeaderUserIcon}
         Click          ${SEL_LogoutBtn}
    END
    Take Screenshot

After test
    Go To               ${URL}

After suite
    New Page            ${URL}
    Login               ${USER1_NAME}        ${USER1_PWD}      ${USER1_SHORT}

    Go To               ${URL_cart}
    #check empty cart
    ${cart_overview_text}   Get Text                ${SEL_CartReview}
    Log                 ${cart_overview_text}
    IF    "${cart_overview_text}" != "${TEXT_EmptyCart}"
            Click  ${SEL_RemoveCart}
    END
    Take Screenshot

    Go To               ${URL}
    Logout              ${TEXT_Prihlasit}
    Close Browser
