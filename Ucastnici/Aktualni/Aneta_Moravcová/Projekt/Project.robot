*** Settings ***

Documentation          Automatizace rohlik.cz s Browser Library
Library                Browser

Resource          Data_and_Config/Configuration.robot
Resource          Data_and_Config/TestData.robot

Suite Setup          Zacatek testovani
Suite Teardown       Konec testovani


*** Test Cases ***

Prihlaseni
     Prihlaseni                       ${USER_NAME}          ${USER_PASSWORD}          ${USER_SHORT}
     Pridani zbozi do kosiku          ${ZBOZI_NAME}          ${ZBOZI_ID}          5
     Odhlaseni                        ${TEXT_Prihlasit}

*** Keywords ***

Zacatek testovani
     New Browser          chromium          headless=false
     New Page             ${URL}
     Get Title            ==  ${TEXT_MainTitle}

     Cookies              AcceptAll

Prihlaseni
     [Arguments]          ${e-mail}          ${heslo}          ${overeni_1}

     Click          ${SEL_HeaderLogin}
     Type Text      ${SEL_LoginFormEmail}          ${e-mail}
     Type Text      ${SEL_LoginFormPwd}            ${heslo}
     Click          ${SEL_BtnSignIn}
     Get Text       ${SEL_HeaderLoginErrorTxt}     ==  ${overeni_1}

Cookies
     [Arguments]          ${moznost}

     IF  "${moznost}" == "AcceptAll"
          Click           ${SEL_Cookie_AllowAll}
     ELSE
          Click           ${SEL_Cookie_Decline}
     END

Odhlaseni
     [Arguments]          ${overeni_2}

     Go To               ${URL}
     Click               ${SEL_HeaderLoginErrorTxt}
     Click               ${SEL_UserBoxLogoutBtn}
     Get Text            ${SEL_HeaderLoginErrorTxt}          ==  ${overeni_2}

Pridani zbozi do kosiku
     [Arguments]          ${ZBOZI_NAME}          ${ZBOZI_ID}          ${mnozstvi}

     Type Text           ${SEL_SearchGlobal}         ${ZBOZI_NAME}
     Sleep               1                           # statický timeout
     Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
#     Sleep               5                           # statický timeout
     Get text           text="produktů"

     Click              css=[data-product-id="${ZBOZI_ID}"][data-test="btnAdd"]
     ${Pocet}           Evaluate                    ${mnozstvi} - 1
     Click              css=[data-product-id="${ZBOZI_ID}"][data-test="btnPlus"]  clickCount=${Pocet}
     Go To              ${URL_Cart}
     Sleep              3
     Take Screenshot

Konec testovani
     Prihlaseni          ${USER_NAME}          ${USER_PASSWORD}          ${USER_SHORT}
     Go To               ${URL_Cart}

     ${cart_overview_text}          Get Text          ${SEL_CartReview}
     Log                            ${cart_overview_text}

     Run Keyword If          '${TEXT_EmptyCart}' in '''${cart_overview_text}'''          Click          text="${TEXT_EmptyCart}"
     Take Screenshot

     Odhlaseni           ${TEXT_Prihlasit}