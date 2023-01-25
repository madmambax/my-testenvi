# požadavky
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Resource        Data_and_Config/Configuration.robot
Resource        Data_and_Config/TestData.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***
Login spatny email
    Login               blebleble     ${OK_PASS_ROHLIK}    ${ERROR_TEXT_FillCorrectEmail}

Login spatny password
    Login               ${OK_EMAIL}      BadPAssword      ${ERROR_TEXT_IncorrectEmailOrPwd}

Login vse OK
    Login               ${OK_EMAIL}   ${OK_PASS_ROHLIK}    ${OK_VALID_ROHLIK}
    [Teardown]          Logout

Test Objednávka
    ${Kusu} =           Set Variable        5
    Login               ${OK_EMAIL}        ${OK_PASS_ROHLIK}    ${OK_VALID_ROHLIK}
    Pridat do kosiku    ${ZBOZI01_NAME}    ${ZBOZI01_ID}        ${Kusu}
    Click               ${SEL_CartContent}
    Take Screenshot
    Odebrat z kosiku    ${Kusu}
    Take Screenshot
    [Teardown]          Logout
    Take Screenshot


*** Keywords ***
Login
    [Arguments]         ${email}   ${heslo}   ${validation}

    Get Title           contains   ${TEXT_MainTitle}

    Click               ${SEL_GET_TXT_headerLogin}
    Type Text           ${SEL_TYPE_TEXT_email}             ${email}
    Type Text           ${SEL_TYPE_TEXT_password}          ${heslo}
    Click               ${SEL_d_test_btnSignIn}
    Get Text            ${SEL_HeaderLoginErrorTxt}         contains   ${validation}



Logout
   Go to                ${URL}
   Click                ${SEL_HeaderLoginErrorTxt}
   Click                ${SEL_US_B_LOGOUT_BTT}
   Get Text             ${SEL_HeaderLoginErrorTxt}       contains     ${TEXT_Prihlasit}


Pridat do kosiku
    [Arguments]         ${Zbozi}                 ${produkt_id}     ${Kusu}
    ${old_mode} =       Set Strict Mode     False
    Type Text           ${SEL_SearchGlobal}      ${Zbozi}
    Sleep               1                           # statický timeout
    Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
    Sleep               2                           # statický timeout
#   Get text           text="AG Seafood Krevety celé syrové"
                                                    #RE:tohle je lepší než statický timeout
                                                    #tzn. Lepší je použít vyhledání/získání  stringu proto
                                                    # browserlib počká něž se vypíše a získá...
                                                    #Logicky užasná pomůcka. Děkuji.

    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=${SEL_CssForAdding} [${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus}]           clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text               ${SEL_CartItem}
    Log                 ${cart_text}
    Get Text            ${SEL_CartItem}        matches            (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot

Odebrat z kosiku
    [Arguments]         ${Kusu}
    Take Screenshot

    ${old_mode} =       Set Strict Mode             False
    Click     ${SEL_BtnMinus}    clickCount=${Kusu}      delay=100ms
    Take Screenshot

   #  *************************************************************************************************
   #FYI pro Radka:
   #  S dovolením jsem si Radku naimportoval tvůj  Dynamický timeout
   #  Napadlo mě, že si to tyto vychytávky mohu ukládat jako knihovnu a kdykoliv pak vyvolat.
   #  Je to hodně podobné objektovému programovování v PY. V podstatě asi i je.
   #  Idalní způsob učení je pro mě prolézat kódy a najít myšlenku a funkčnost.
   #  Já se Ve čtvrtek vrátil z Německa a v pátek a pondělí jsem měl kurr na TU v Liberci kurz
   #  na LabVIEW od NI a musím říct, že jak jsem si zvykl u tebe na podporu a hlavně spoustu materiálu
   #  nastudování, máš neskutečně vše dokonale připravené. Jak v Německu, tak i tady v Lbc na TULce,
   #  by se mohli od Tebe hodně učit.
   #  *************************************************************************************************
   # FYI Radek:
   # nějakou dobu trvá než se zboží přidá do košíku, možnosti

    #Statický timeout
#    Sleep                   3 s
#    Take Screenshot

    # Dynamický timeout - čeka dokud není košík prázdnýelay
    # je třeba vědět co je synchronyzační bod. Na co čeakt. Co se stane když se z košíku odebere X položek?
    # v případě košíku to je aktuální počet zboží v košíku
    #  *************************************************************************************************

    ${CartContentText}=     Get Text                ${SEL_CartContent}
    Log                     ${CartContentText}

    FOR    ${i}    IN RANGE    100
           sleep                   ${TIME_BETWEEN_CHECKS}
           ${CartContentText}=     Get Text         ${SEL_CartContent}
           Exit For Loop If         '${ERROR_TEXT_EmptyCart}' in '''${CartContentText}'''

           Log                     ${CartContentText}
           Log                     ${i}
    END

    Set Strict Mode     ${old_mode}



Pred_testem
    GO To               ${URL}

Pred_sadou             # poznámka pro mě  Set Browser Timeout >>> https://marketsquare.github.io/robotframework-browser/Browser.html#Set%20Browser%20Timeout
    ${b_timeput} =     Set Browser Timeout                 ${TIMEOUT_BROWSER}                 #20s je vhodné pro rohlik.cz
    Log                Původní hodnota timeout ${b_timeput}
    New Browser        headless=false

#   Super video Radku https://www.youtube.com/watch?v=Bgd6DkkzLNY
#   Jak snadno vytvořit video záznam automatických testů   https://marketsquare.github.io/robotframework-browser/Browser.html#Set%20Browser%20Timeout
#   New Context  recordVideo={'dir':'${OUTPUT_DIR}/video', 'size':{'width':1280, 'height':720}}

    New Page                   ${URL}
    Cookie                      AcceptAll

Uklid_po_testu
    Log                 Uklízečka po každem testu
    CLick               ${SEL_HeaderLogo}
    Go To               ${URL}

Uklid_sada
    New Page                ${URL}
    Login                   ${OK_EMAIL}       ${OK_PASS_ROHLIK}    ${OK_VALID_ROHLIK}
    Go to                   ${URL_cart}

    ${cart_overview_text}   Get Text                ${SEL_CartReview}
    Log                     ${cart_overview_text}
    Run Keyword If          '${TEXT_EmptyCart}' in '''${cart_overview_text}'''       Click               text="${TEXT_EmptyCart}"
    Take Screenshot
    #Logout
    Go to                    ${URL}
    Logout
    Close Browser


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               1



*** Comments ***
#   ODLOŽENO
# *** Test Cases *** vyřazeno a nahrazeno.
#Pridani zbozi do kosiku
#    Login               ${OK_EMAIL}          ${OK_PASS_ROHLIK}    ${OK_VALID_ROHLIK}
#    sleep       50ms
#    Type Text           ${SEL_searchGlobal}  ${ZBOZI01_NAME}
#    Click               ${SEL_search_button_hledat}
#    sleep       3
#    Pridat do kosiku     ${ZBOZI01_NAME}      ${ZBOZI01_ID}     5
#    sleep       2
#
#    Logout
#
#Vyčištění košíku
#   Login               ${OK_Email}      ${OK_PASS_ROHLIK}          ${OK_VALID_ROHLIK}
#   Go To               ${URL_kosik}
#   Click               ${SEL_clearCart}
#   Sleep               1
#   Take Screenshot
#
#    Get Text                      ${SEL_cartReviewMainTitle}  ==   ${TXT_CLEAR_BASKET}
#    ${log_cl_basket}=   Get Text  ${SEL_cartReviewMainTitle}
#    Log                           ${log_cl_basket}
#
#   Sleep               1
#   Logout

#*** Keywords ***

#vyřazeno a nahrazeno.
#   Take Screenshot
#   Get Text             ${SEL_GET_TXT_headerLogin}  ==  ${NG_VALIDATION}
#   ${log}=  Get Text    ${SEL_GET_TXT_headerLogin}
#   Log                  ${log}

#vyřazeno a nahrazeno.
#Pridat do kosiku varianta produkt id
#
#    [Arguments]         ${zbozi}  ${pr_id}  ${pocet}
#    Sleep               1
#    Type Text           ${SEL_GET_TXT_headerLogin}             ${zbozi}
#    Click               ${SEL_GET_TXT_header-user-icon}
#    Sleep               2
#    Click               css=[${SEL_Product_id}="${pr_id}"][${SEL_BtnAdd}"]
#    ${num_click}=       Evaluate  ${pocet}-1
#    Click               css=[${SEL_Product_id}="${pr_id}"][${SEL_BtnPlus}"]   clickCount=${num_click}
#    Sleep               5


#vyřazeno a nahrazeno.
#Pridat do kosiku varianta produkt id
#
#    [Arguments]         ${zbozi}  ${pr_id}  ${pocet}
#    Sleep               1
#    Type Text           ${SEL_GET_TXT_headerLogin}             ${zbozi}
#    Click               ${SEL_GET_TXT_header-user-icon}
#    Sleep               2
#    Click               css=[${SEL_Product_id}="${pr_id}"][${SEL_BtnAdd}"]
#    ${num_click}=       Evaluate  ${pocet}-1
#    Click               css=[${SEL_Product_id}="${pr_id}"][${SEL_BtnPlus}"]   clickCount=${num_click}
#    Sleep               5

#vyřazeno a nahrazeno.
#    Get Text            ${SEL_GET_TXT_header-user-icon}    ==   ${validation}
#    ${log}=   Get Text  ${SEL_GET_TXT_header-user-icon}
#    Log                 ${log}
#    Take Screenshot