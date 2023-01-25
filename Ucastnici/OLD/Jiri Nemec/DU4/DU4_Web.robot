*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Negativni test prihlaseni
    Login               fsdfdssd@sdas.cz                     tytryrt                      Přihlásit

Pozitivni pridani zbozi do kosiku, kontrola a odebrani
    Login               manod33170@teknowa.com              3jgRYyfUYxUeENL             T9
    Pridat do kosiku varianta produkt id    banán  1349777  5
    ${ks} =  Zjistit Pocet Kusu  1349777
    Should Be Equal    ${ks}  5
    Log To Console    ${ks}
    Odebrat Z Kosiku    1349777  5
    Logout


Negativni test s prekrocenim maximalniho poctu 50 kusu
    Login               manod33170@teknowa.com              3jgRYyfUYxUeENL             T9
    Pridat do kosiku varianta produkt id    banán  1349777  100
    ${ks} =  Zjistit Pocet Kusu  1349777
    Should Be Equal    ${ks}  50
    Log To Console    ${ks}
    Odebrat Z Kosiku    1349777  50
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode

    Get Title           contains                            Rohlik
    Cookie              AcceptAll

    Click               id=headerLogin
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn

    Get Text            data-test=header-user-icon          ==      ${validation}
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
    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


Logout
    Click   data-test=header-user-icon
    Click   data-test=user-box-logout-button
    Go To   ${URL}
    sleep  1
    ${text} =  Get Text    css=[data-test=header-user-icon]
    Should Contain  ${text}  Přihlásit



Pridat do kosiku varianta produkt id
    Go to  ${URL}
    Get Title  contains  Rohlik
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}


    Type Text           id=searchGlobal  ${Zbozi}
    Click               data-test=header-search-button
    Sleep  2
    ${exist} =  Get Element State  \#whisperer [data-product-id="${produkt_id}"][data-test="btnAdd"]  visible
    IF  ${exist}
     Click               \#whisperer [data-product-id="${produkt_id}"][data-test="btnAdd"]
     ${Kusu} =  Evaluate  ${Kusu} - 1
     Click               \#cart [data-product-id="${produkt_id}"][data-gtm-button="addPiece"]  clickCount=${Kusu}
    ELSE
     Click               \#cart [data-product-id="${produkt_id}"][data-gtm-button="addPiece"]  clickCount=${Kusu}
    END
    Sleep  1



Odebrat z kosiku
    [Arguments]         ${produkt_id}     ${Kusu}
    Go to  ${URL}objednavka/prehled-kosiku
    Get Title  contains  Přehled
    Click  [data-test="btnMinus"][data-product-id="${produkt_id}"]  clickCount=${Kusu}





Zjistit pocet kusu
    [Arguments]         ${produkt_id}
    [Return]    ${return}
    Go to  ${URL}objednavka/prehled-kosiku
    Get Title  contains  Přehled
    Sleep  1
    ${exist} =  Get Element State  [data-test="btnMinus"][data-product-id="${produkt_id}"]  visible
    ${return} =  Set Variable    0
    IF  ${exist}
        ${return} =  Get Text     [data-test="btnMinus"][data-product-id="${produkt_id}"] ~ input
    END
    Log To Console    ${return}







