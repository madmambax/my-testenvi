# požadavky
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser

*** Variables ***
#URL - rohlík.cz
${URL}                 https://www.rohlik.cz/
${URL_KOSIK}           https://www.rohlik.cz/objednavka/prehled-kosiku

#Login - rohlík.cz
${OK_EMAIL}            nabopob356@nubotel.com                                                                           # spolecný test email pro rohlik.cz a datart.cz
${OK_VALID_ROHLIK}     IK
${NG_VALIDATION}       Přihlásit

#Passwords        #
${OK_PASS_ROHLIK}      M76*Fag7L*Nbfkw

#Zboží
${ZBOZI01_NAME}        AG Seafood Krevety celé syrové 30/40
${ZBOZI01_ID}          1356351

#Selektory
${SEL_SEARCH_BT_HLEDAT}     css=.sc-4b6d3da4-2
${SEL_CLR_CART}             css=.clearCart
${SEL_HEADER_LOGIN}         xpath=//*[@id="headerLogin"]
${TXT_CLEAR_BASKET}         Košík funguje i jako nákupní seznam
# Selektory pro Logout
${SEL_HEA_USER_ICO}         data-test=header-user-icon
${SEL_US_B_LOGOUT_BTT}      data-test=user-box-logout-button


*** Test Cases ***

Negativní login
    Login               ${OK_EMAIL}        BadPAssword          ${NG_VALIDATION}

Pridani zbozi do kosiku
    Login               ${OK_EMAIL}        ${OK_PASS_ROHLIK}    ${OK_VALID_ROHLIK}
    Type Text           id=searchGlobal    ${ZBOZI01_NAME}

    Click               ${SEL_SEARCH_BT_HLEDAT}
    sleep       1

    Pridat do kosiku varianta produkt id     ${ZBOZI01_NAME}      ${ZBOZI01_ID}     5
    sleep       2

    Logout

Vyčištění košíku
   Login               ${OK_Email}      ${OK_PASS_ROHLIK}         ${OK_VALID_ROHLIK}
   Go To               ${URL_KOSIK}
   Click               ${SEL_CLR_CART}
   Sleep               1
   Take Screenshot

    Get Text                      id=cartReviewMainTitle  ==   ${TXT_CLEAR_BASKET}
    ${log_cl_basket}=   Get Text  id=cartReviewMainTitle
    Log                           ${log_cl_basket}


   Sleep               1
   Logout

*** Keywords ***

Login
    [Arguments]         ${email}   ${heslo}   ${validation}
    Log                 ${heslo}
    Log                 ${email}
    Log                 {validation}

    Open Browser        ${URL}     headless=false

    Get Title           contains               Rohlik
    Cookie              AcceptAll
                                                                                                                        # hover xpath=//*[@id="headerLogin"]
    Click               ${SEL_HEADER_LOGIN}                                                                             # id=headerLogin
    Sleep               1

    Type Text           id=email             ${email}                                                                   #  css=[aria-describedby="password"]
    Type Text           id=password          ${heslo}                                                                   #  css=[aria-describedby="password"]
    Click               data-test=btnSignIn

    Get Text            data-test=header-user-icon  ==   ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               2                                                                                               # workaround: Probliknutí cele stránky po kliknutí na tlačítko

Logout
   Go to                       ${URL}
   Click                       ${SEL_HEA_USER_ICO}                                        # xpath=//*[@id="headerUser"]/div
   Click                       ${SEL_US_B_LOGOUT_BTT}
   Take Screenshot
   Get Text             id=headerLogin  ==  ${NG_VALIDATION}
   ${log}=  Get Text    id=headerLogin
   Log                  ${log}
   Take Screenshot

Pridat do kosiku varianta produkt id

    [Arguments]         ${zbozi}  ${pr_id}  ${pocet}

    Type Text           id=searchGlobal             ${zbozi}
    Click               data-test=header-search-button
    Sleep               3
    Click               css=[data-product-id="${pr_id}"][data-test="btnAdd"]
    ${num_click}=       Evaluate  ${pocet}-1
    Click               css=[data-product-id="${pr_id}"][data-test="btnPlus"]   clickCount=${num_click}
    Sleep               5


