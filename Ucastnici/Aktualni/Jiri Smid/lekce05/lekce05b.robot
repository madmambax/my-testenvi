# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: Testovaci data - pripravit ciselnik chybovych hlasek
Library         Browser


Resource        lekce05/Data_and_Config_AT/TestData.robot
Resource        lekce05/Data_and_Config_AT/Configuration.robot

Test Setup      Pred_testem
Test Teardown   Po_testu
Suite Setup     Pred_sadou
Suite Teardown  Po_sade



*** Variables ***



*** Test Cases ***
Login spatny email
    Login           chyba                   ${USER1_PASSWORD}       ${ERROR_TEXT_FillCorrectEmail}

Login spatne heslo
    Login               ${USER1_NAME}       bad                     ${ERROR_TEXT_IncorrectEmailOrPwd}

Login vse OK
    Login               ${USER1_NAME}       ${USER1_PASSWORD}       ${USER1_SHORT}
    [Teardown]          Logout

Test Objednavky
    ${kusu} =	        Set Variable	    5
    Login               ${USER1_NAME}       ${USER1_PASSWORD}        ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}            ${kusu}
    Click               id=cartContent
    Take Screenshot
    Take Screenshot
    Odebrat z kosiku    ${kusu}
    Take Screenshot
    Take Screenshot
    Logout
    [Teardown]   Clean
    Take Screenshot
    Take Screenshot



*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}

    Set Browser Timeout         20                                  #20s je vhodné pro rohlik.cz


    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll

    Click                       data-test=header-user-icon
    Type Text                   id=email                            ${Email}
    Type Text                   id=password                         ${Heslo}

    Click                       data-test=btnSignIn

    Get Text                    xpath=//div[@class='u-mr--8']       contains                                ${Text}


Logout
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button


Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               1                           #Statický timeout
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               5                           #Statický timeout

    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
#    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}
    Click               css=.amountCounterWrap [data-product-id="${produkt_id}"][data-test="btnPlus"]      clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            ${SEL_Cart}                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False        # Does not fail if selector points to one or more elements
    Click               ${SEL_BtnMinus}          clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       #statické čekání
    Take Screenshot
    Go to               ${URL}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

 Pred_testem
     New Browser        headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode

    New Page                    ${URL}

 Po_testu


 Pred_sadou


 Po_sade
