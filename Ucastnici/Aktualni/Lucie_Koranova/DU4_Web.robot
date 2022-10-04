*** Settings ***
Documentation   Automatizace rohlik.cz s Browser Library
Library         Browser


*** Variables ***
${Rohlik}      https://www.rohlik.cz/
${Cart}      https://www.rohlik.cz/objednavka/prehled-kosiku


*** Test Cases ***

Login
     Login              radek.tester@seznam.cz              tajneheslotajneheslo        JT
     Logout

Login wrong
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Add item to cart
     Login              radek.tester@seznam.cz              tajneheslotajneheslo        JT
     Add item to cart   alpro          1306143          2
     Logout

Remove item from cart
     Login              radek.tester@seznam.cz              tajneheslotajneheslo        JT
     Remove item from cart   1306143        2
     Logout


*** Keywords ***

Login
     [Arguments]          ${username}          ${password}          ${initials}
     New Page             ${Rohlik}
     Get Title            ==  Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

     Cookies              AcceptAll

     Click                data-test=IconUserLogin
     Type Text            id=email                        ${username}
     Type Text            id=password                     ${password}
     Click                data-test=btnSignIn
     Get Text             data-test=header-user-icon  ==  ${initials}
     ${log}=              Get Text  data-test=header-user-icon
     Log                  ${log}
     Take Screenshot


Cookies
     [Arguments]          ${type}
     IF  "${type}" == "AcceptAll"
          Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
     ELSE
          Click           id="CybotCookiebotDialogBodyButtonDecline"
     END

Add item to cart
     [Arguments]          ${goods}          ${produkt_id}          ${amount}

     Type Text          id=searchGlobal          ${goods}
     Click              text="Hledat"
     Click              css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
     ${Pocet}           Evaluate                    ${amount} - 1
     Click              css=[data-product-id="${produkt_id}"][data-test="btnPlus"]  clickCount=${Pocet}
     Go To              ${Cart}
     Sleep              2
     Take Screenshot


Remove item from cart
    [Arguments]          ${produkt_id}          ${amount}
    Go To      ${Cart}
    Click      css=[data-product-id="${produkt_id}"][data-test="btnMinus"]   clickCount=${amount}
    Sleep      2
    Take Screenshot

Logout
   Go to               ${Rohlik}
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button