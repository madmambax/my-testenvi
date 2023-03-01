*** Settings ***
Library  Browser

*** Variables ***
${URL}          https://www.rohlik.cz/
${pnastane}     Účet
${pocet}


*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      *=    Rohlik
    Click  id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep  2
    Click    "Účet"
    Sleep   1
    Type Text   id=email       ${pemail}
    Type text   id=password    ${pheslo}
    Click       data-test=btnSignIn
    Get Text    data-test=header-user-icon  ==  ${pnastane}
    sleep  1
#   Take Screenshot  filename=TEST-${TEST NAME}
#    Take Screenshot  filename=TEST-LOGIN

Vyhledat zbozi
    [Arguments]         ${Zbozi}
    Set Global Variable    ${Zbozi}
    click    id=searchGlobal
    Sleep    1
    Type Text    id=searchGlobal    ${Zbozi}

Pridat do kosiku (ID), pocet
    [Arguments]         ${produkt_id}   ${pocet}
    Set Global Variable    ${pocet}
    Sleep    3
    Click   css=[data-product-id="1381458"]
    ${pocet}    Evaluate    ${pocet} - 1
    Click    css=[data-product-id="${produkt_id}"][aria-label*="Přidat"]  clickCount=${Pocet}
    ${pocet}    Evaluate    ${pocet} + 1
    Take Screenshot  filename=TEST-pridat ${pocet} ks ${zbozi}

Kontrola poctu v kosiku
    [Arguments]         ${pocet}
    ${kosik}    Get Text    css=[class="sc-559e95ea-0 klrptF"]
    Log To Console    KOSIK :${kosik} a POCET:${pocet}
    Should contain    ${kosik}    ${pocet}

Nespravny pocet
    [Arguments]         ${pocet}
    ${kosik}    Get Text    css=[class="sc-559e95ea-0 klrptF"]
    Log To Console    KOSIK :${kosik} a POCET:${pocet}
    Should not contain    ${kosik}    ${pocet}

odebrat zbozi
    Click   css=[data-test="whisperer-product-wrapper"] [data-product-id="1381458"][aria-label*="Odebrat"]  clickCount=${Pocet}
    Sleep   1
    Take Screenshot  filename=TEST- ${TEST NAME}

prazdny kosik
    [Arguments]         ${vystup}
    ${prazdny}  Get Text    css=[data-product-id="1381458"]
    Should Contain    ${prazdny}    ${vystup}

prazdny kosik2
    go to  https://www.rohlik.cz/
    ${aktual}   Get Text    css=[data-test="headerPrice"]
    Should Be Equal As Strings    ${aktual}     0,00 Kč

overeni plus
    
    ${statusElementu}   Get Element states   css=[data-product-id="1381458"] [data-test="IconPlus"]
    Log To Console    nacteny status ${statusElementu}
    Should Contain    ${statusElementu}    detached

odhlaseni
    go to  https://www.rohlik.cz/
    Click  id=headerUser
    sleep  1
    click  data-test=user-box-logout-button
    sleep  1

*** Test Cases ***

Prihlaseni bad heslo
  Login                                     hawetay362@laserlip.com             Nejake heslo       Účet

prihlasit, pridat, kontrola poctu, odhlasit
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  Vyhledat zbozi                             banán
  Pridat do kosiku (ID), pocet              1381458    3
  Kontrola poctu v kosiku                            ${pocet}
  odhlaseni

V kosiku jsou 3 banany
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  Vyhledat zbozi                             banán
  Kontrola poctu v kosiku                             3
  odhlaseni

V kosiku nejsou 4 banany
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  Vyhledat zbozi                             banán
  Nespravny pocet                            4
  odhlaseni

Odebrání banánů z košíku
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  Vyhledat zbozi                             banán
  odebrat zbozi
  prazdny kosik                              Do košíku
  odhlaseni

Pokud není alespoň jeden kus v košíku, není vidět +
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  Vyhledat zbozi                             banán
  overeni plus
  odhlaseni

Kontrola prázdného košíku
  Login                                      hawetay362@laserlip.com             MojeHeslo1_        L
  prazdny kosik2
  odhlaseni
