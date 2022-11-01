*** Settings ***
Documentation   Automatizace rohlik.cz s Browser Library
Library         Browser


*** Variables ***
${URL1}      https://www.rohlik.cz/
${URL2}      https://www.rohlik.cz/objednavka/prehled-kosiku


*** Test Cases ***

Prihlaseni, vlozeni zbozi do kosiku a jeho nasledne odebrani, odhlaseni
     Prihlaseni          radek.tester@seznam.cz          tajneheslotajneheslo          JT
     Pridani Do Kosiku   banán          1349777          5
     Odebrani Z Kosiku   1349777        5
     Odhlaseni           Přihlásit


*** Keywords ***

Prihlaseni
     [Arguments]          ${e-mail}          ${heslo}          ${potvrzeni1}

     New Browser          chromium  headless=false
     New Page             ${URL1}
     Get Title            ==  Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

     Cookies              AcceptAll

     Click                data-test=IconUserLogin
     Type Text            id=email                        ${e-mail}
     Type Text            id=password                     ${heslo}
     Click                data-test=btnSignIn
     Get Text             data-test=header-user-icon  ==  ${potvrzeni1}
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


Odhlaseni
     [Arguments]    ${potvrzeni2}

     Go To          ${URL1}
     Click          xpath=//div[@class='u-mr--8']
     Click          data-test=user-box-logout-button
     Get Text       id=headerLogin  ==  ${potvrzeni2}
     ${log}=        Get Text  id=headerLogin
     Log            ${log}
     Take Screenshot


Pridani do kosiku
     [Arguments]          ${zbozi}          ${IDproduktu}          ${mnozstvi}

     Type Text          id=searchGlobal          ${zbozi}
     Click              text="Hledat"
     Click              css=[data-product-id="${IDproduktu}"][data-test="btnAdd"]
     ${Pocet}           Evaluate                    ${mnozstvi} - 1
     Click              css=[data-product-id="${IDproduktu}"][data-test="btnPlus"]  clickCount=${Pocet}
     Go To              ${URL2}
     Sleep              5
     Take Screenshot


Odebrani z kosiku
    [Arguments]          ${IDproduktu}          ${mnozstvi}

    Go To      ${URL2}
    Click      css=[data-product-id="${IDproduktu}"][data-test="btnMinus"]   clickCount=${mnozstvi}
    Sleep      5
    Take Screenshot