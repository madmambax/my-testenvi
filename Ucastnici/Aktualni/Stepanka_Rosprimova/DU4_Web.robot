*** Settings ***
Library         Browser

*** Variables ***
${URL}          https://www.rohlik.cz/

*** Test Cases ***
Pozitivni test
    Login                       radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Pridani zbozi do kosiku     cokolada                            1315797
    Odebrani zbozi z kosiku     cokolada
    Logout                      JT

Negativni test
    Login                       stepanka.tester@seznam.cz           tajneheslotajneheslo        Přihlásit
    Pridani zbozi do kosiku     banan                               1315797
    Odebrani zbozi z kosiku     banan
    Logout                      Přihlásit

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
    [Arguments]         ${validation}
    Go to               ${URL}

    IF  "${validation}" == "JT"
        Click           data-test=header-user-icon
        Click           data-test=user-box-logout-button
        Get Text        data-test=header-user-icon    ==    Přihlásit
    ELSE
        Get Text        data-test=header-user-icon    ==    ${validation}
    END

    Sleep               1
    Take Screenshot

Pridani zbozi do kosiku
    [Arguments]         ${sortiment}       ${productId}
    Type Text           id=searchGlobal    ${sortiment}
    Sleep               2
    Click               text="Hledat"
    Sleep               2

    IF  "${sortiment}" == "cokolada"
        Click           css=[data-product-id="${productId}"][data-test="btnAdd"]
        Get Text        css=.cartCount      ==      1
    ELSE
        # sortiment banan does not exists
        Get Text        css=.cartCount      ==      0
    END

    Sleep               1
    Take Screenshot

Odebrani zbozi z kosiku
    [Arguments]         ${sortiment}

    IF  "${sortiment}" == "cokolada"
        Click           data-test=btnMinus >> nth=1
        Get Text        css=.cartCount      ==      0
    ELSE
        # sortiment banan does not exists
        Get Text        css=.cartCount      ==      0
    END

    Sleep               1
    Take Screenshot
