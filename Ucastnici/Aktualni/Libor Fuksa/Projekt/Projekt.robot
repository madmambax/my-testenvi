*** Settings ***
Library         Browser

Resource        Data/Configuration.robot
Resource        Data/User.robot
Resource        Data/Item.robot
Resource        Data/Message-error.robot
Resource        Data/Selector.robot
Resource        Data/Text.robot

Suite Setup     Pred_sadou
Test Setup      Pred_testem

#Suite Teardown  Po_sade

*** Variables ***

*** Keywords ***
Cekej
    [Arguments]     ${Requested_element}
   FOR    ${i}    IN RANGE    15
      Sleep    ${TIME_BETWEEN_CHECKS}
      ${statusElement}   Get Element states   ${Requested_element}
      Exit For Loop If    ${TEXT_USER_ICON_STATUS_VISIBLE} in ${statusElement}
   END 
    

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    #   ceka na zobrazeni ikonky (UCET)
    Cekej    ${SEL_LOGIN_USERICON}
    Click    ${SEL_LOGIN_USERICON}

    #   ceka na zobrazeni pop-up prihlaseni
    Cekej    ${SEL_LOGIN_CONFIRM}
    Type Text   ${SEL_LOGIN_NAME}       ${pemail}
    Type text   ${SEL_LOGIN_PASSWORD}       ${pheslo}
    Click       ${SEL_LOGIN_CONFIRM}
    Get Text    ${SEL_LOGIN_USERICON}  ==  ${pnastane}

#   Take Screenshot  filename=TEST-${TEST NAME}
#    Take Screenshot  filename=TEST-LOGIN

Vyhledat zbozi
    click    ${SEL_SEARCH_TOP}
    Type Text    ${SEL_SEARCH_TOP}    ${ITEM_ZBOZI}

Pridat do kosiku (ID), pocet
    Click   ${SEL_SEARCH_ITEM_ADD}
    ${POCET}    Evaluate    ${POCET} - 1
    Click   ${SEL_SEARCH_ITEM_ADDMORE}  clickCount= ${POCET}
    ${POCET}    Evaluate    ${POCET} + 1
    Take Screenshot  filename=TEST-pridat ${POCET} ks ${ITEM_ZBOZI}

Kontrola poctu v kosiku
    [Arguments]         ${POCET}
    ${kosik}    Get Text    ${SEL_SEARCH_ITEM_QTY}
    Log To Console    KOSIK :${kosik} a POCET:${POCET}
    Should contain    ${kosik}    ${pocet}

Nespravny pocet
    ${kosik}    Get Text    ${SEL_SEARCH_ITEM_QTY}
    Log To Console    KOSIK :${kosik} a POCET:${pocet}
    ${POCET}    Evaluate    ${POCET} + 1
    Should Not Be Equal    ${kosik}    ${POCET}

odebrat zbozi
    Click   ${SEL_SEARCH_ITEM_MINUS}  clickCount= ${POCET}
    Sleep   1
    Take Screenshot  filename=TEST- ${TEST NAME}

prazdny kosik
    [Arguments]         ${vystup}
    ${prazdny}  Get Text    ${SEL_SEARCH_ITEM_ADD}
    Should Contain    ${prazdny}    ${vystup}

prazdny kosik2
    go to  ${URL}
    ${aktual}   Get Text    ${SEL_LOGGED_CART_TOTALPRICE}
    Should Be Equal As Strings    ${aktual}     ${TEXT_EMPTY_CART_TOTAL_SUM}

overeni plus
    
    ${statusElementu}   Get Element states   ${SEL_SEARCH_ITEM_ADDMORE}
    Log To Console    nacteny status ${statusElementu}
    Should Contain    ${statusElementu}    detached

odhlaseni
   go to     ${URL}

# ceka na zobrazeni ikonky (inicialu uzivatele)
   Cekej     ${SEL_LOGGED_USER_ICON}
   Click     ${SEL_LOGGED_USER_ICON}
   Click     ${SEL_LOGGED_USER_LOGOUT}
   Get Text  ${SEL_LOGIN_USERICON}  contains  ${TEXT_LOGIN}

Set Cookies
   Sleep    1
    [Arguments]     ${type}
   IF  "${type}" == "NO"
    Click   ${SEL_Cookie_NO}
   ELSE
    Click   ${SEL_Cookie_YES}
   END

Pred_sadou
   New Browser    ${BROWSER}    headless=false
   Set Browser Timeout                 ${TIMEOUT_BROWSER}
   New Page       ${URL}
   Get Title      *=    ${TEXT_PAGE_HEADER}
   Set Cookies    ${COOKIES}


Pred_testem
   Go To    ${URL}



Po_sade
    New Page                ${URL}
    Login                   ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
    Go to                   ${URL_CART}

    ${CART_TEXT}        Get Text     ${SEL_CART_MAIN_REVIEW}

    Run Keyword If    '${CART_MAIN_REVIEW_NOTEMPTY}' in '''${CART_TEXT}'''      Click   ${SEL_CART_CLEAR_CART}

    odhlaseni
    Close Browser

*** Test Cases ***

Prihlaseni bad heslo
  Login                                     ${USER1_VALID_NAME}             ${USER_INVALID_PASSWORD}       ${TEXT_LOGIN}

prihlasit, pridat, kontrola poctu, odhlasit
  Login                                     ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  Vyhledat zbozi
  Pridat do kosiku (ID), pocet
  Kontrola poctu v kosiku                   ${POCET}
  [Teardown]          odhlaseni

V kosiku jsou 3 banany
  Login                                      ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  Vyhledat zbozi
  Kontrola poctu v kosiku                    ${POCET}
  [Teardown]          odhlaseni

V kosiku nejsou 4 banany
  Login                                      ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  Vyhledat zbozi
  Nespravny pocet                            
  [Teardown]          odhlaseni

Odebrání banánů z košíku
  Login                                      ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  Vyhledat zbozi
  odebrat zbozi
  prazdny kosik                              ${TEXT_SEARCH_ADD_FIRST}
  [Teardown]          odhlaseni

Pokud není alespoň jeden kus v košíku, není vidět +
  Login                                      ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  Vyhledat zbozi
  overeni plus
  [Teardown]          odhlaseni

Kontrola prázdného košíku
  Login                                      ${USER1_VALID_NAME}             ${USER1_VALID_PASSWORD}        ${USER1_VALID_SHORT}
  prazdny kosik2
  [Teardown]          odhlaseni
