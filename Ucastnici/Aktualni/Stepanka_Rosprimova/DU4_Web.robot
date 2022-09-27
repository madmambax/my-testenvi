*** Settings ***
Library         Browser

*** Variables ***
${URL}          https://www.rohlik.cz/

*** Test Cases ***
Pridani zbozi do kosiku
    Login                       radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Pridani zbozi do kosiku     cokolada                            1315797
    Odebrani zbozi z kosiku
    Logout

*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Open Browser        ${URL}                              headless=false
    Get Title           contains                            Rohlik
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               id=headerLogin
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==      ${validation}
    Sleep               1
    Take Screenshot

Logout
    Go to               ${URL}
    Click               data-test=header-user-icon
    Click               data-test=user-box-logout-button
    Sleep               1
    Take Screenshot

Pridani zbozi do kosiku
    [Arguments]         ${sortiment}       ${productId}
    Type Text           id=searchGlobal    ${sortiment}
    Sleep               2
    Click               text="Hledat"
    Sleep               2
    Click               css=[data-product-id="${productId}"][data-test="btnAdd"]
    Get Text            css=.cartCount      ==      1
    Sleep               1
    Take Screenshot

Odebrani zbozi z kosiku
    Click               data-test=btnMinus >> nth=1
    Get Text            css=.cartCount      ==      0
    Sleep               1
    Take Screenshot