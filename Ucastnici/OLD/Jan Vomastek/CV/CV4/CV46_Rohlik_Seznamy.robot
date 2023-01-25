# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Pridani zbozi do kosiku
    Login               bavemal543@cebaike.com              tajneheslotajneheslo        MS

    #zvažte kolik parametrů bude třeba
    #Pridat Do Kosiku                        banán
    Pridat Do Kosiku                        banán
    Pridat do kosiku varianta pocet         banán  5
    Pridat do kosiku varianta produkt id    banán  1349777  5

    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

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
   Odebrat vse
   Go to               ${URL}
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button


Pridat Do Kosiku
    [Arguments]         ${Zbozi}

#    ${old_mode} =      Set Strict Mode    False
    Set Strict Mode    False
#    Sleep    50
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep    2
    Napis do vyhledavace    ${Zbozi}
    
    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Sleep    2
    Klikni na hledat

    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Sleep    2
    Klikni na do kosiku

    #ověří že je zboží v košíku
    Sleep    2
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}

    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive
    Sleep    2
    Get Text    id=cart     matches     (?i)${Zbozi}
    Take Screenshot

Pridat do kosiku varianta pocet
    [Arguments]         ${Zbozi}     ${Kusu}
    Set Strict Mode    False
#    Sleep    50
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep    2
    Napis do vyhledavace    ${Zbozi}

    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Sleep    2
    Klikni na hledat

    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Sleep    2
    FOR    ${counter}    IN RANGE    0    5
        Log    Kliknuto: ${counter+1}x
        Klikni na do kosiku
    END

    #ověří že je zboží v košíku
    Sleep    2
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}

    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive
    Sleep    2
    Get Text    id=cart     matches     (?i)${Zbozi}
    Take Screenshot

Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}

#    ${old_mode} =      Set Strict Mode    False
    Set Strict Mode    False
#    Sleep    50
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep    2
    Napis do vyhledavace    ${Zbozi}

    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Sleep    2
    Klikni na hledat

    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Sleep    2
    FOR    ${counter}    IN RANGE    0    5
        Log    Kliknuto: ${counter+1}x
        Klikni na do kosiku s id    ${produkt_id}

         
    END

    #ověří že je zboží v košíku
    Sleep    2
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}

    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive
    Sleep    2
    Get Text    id=cart     matches     (?i)${Zbozi}
    Take Screenshot


Napis do vyhledavace
    [Arguments]     ${hledanyText}
    Type Text    id=searchGlobal    ${hledanyText}
    
Klikni na hledat
    Click    xpath=//*[@id="searchForm"]/button
    
Klikni na do kosiku s id
    [Arguments]     ${product_id}

    Scroll To Element    [data-product-id="${product_id}"][data-gtm-button="addPiece"]

    Click               [data-product-id="${product_id}"][data-gtm-button="addPiece"]

Klikni na do kosiku
    Click               [data-gtm-button="addPiece"] >> nth=1
Klikni na odebrat
    Click               [data-gtm-button="removePiece"] >> nth=1
Odebrat vse
    Click               [data-test="cart"]
    Click               [data-gtm-button="clear-cart"]