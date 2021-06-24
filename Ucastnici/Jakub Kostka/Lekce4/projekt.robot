*** Settings ***
Library  Browser

Resource        TestData/TestData.robot

#Suite Setup     Prerekvizita
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
#Test Teardown   Uklid_po_testu

*** Variables ***
${URL}      https://www.aboutyou.cz/


*** Test Cases ***
Login ok
    Prihlaseni        ${USER1_NAME}            ${USER1_PASSWORD}         ${OVERENI_1}
    Log               Chyba           ERROR
Spatne heslo
    Prihlaseni        ${USER1_NAME}            Heslo            ${OVERENI_1}
    Get Text          ${SEL_XPATH_CHYBOVA_HLASKA}            ==       ${chybovahlaska}

Spatny email
    Prihlaseni        Kuba@gmail.com                    ${USER1_PASSWORD}         ${OVERENI_1}
    Get Text          ${SEL_XPATH_CHYBOVA_HLASKA}            ==       ${chybovahlaska}

Nezadane udaje
    Bez Udaju         ${OVERENI_1}  ${ERROR_MESSSAGE1}

Odhlaseni uzivatele
    PrihlaseniAOdhlaseni        ${USER1_NAME}            ${USER1_PASSWORD}         ${OVERENI_1}         ${OVERENI_2}

Pridani polozek do kosiku a odebrani polozky z kosiku prihlaseny uzivatel
    Prihlaseni                  ${USER1_NAME}            ${USER1_PASSWORD}         ${OVERENI_1}
    Vyber a odebrani            ${OVERENI_3}             ${OVERENI_4}


*** Keywords ***
Prihlaseni
    [Arguments]     ${email}        ${heslo}           ${overenilogin}
    #Open Browser
    #New Page        ${URL}
    Click           ${SEL_KROK_PRED_PRIHLASENIM}
    Type Text       ${SEL_EMAIL_FIELD}             ${email}
    Type Text       ${SEL_PASSWORD_FIELD}          ${heslo}
    Click           ${SEL_ACCEPT_COKIES}
    Get Text        ${SEL_LOGIN_BUTTON}             ==              ${overenilogin}
    Click           ${SEL_LOGIN_BUTTON}
    Take Screenshot

Bez udaju
    [Arguments]     ${overenilogin}  ${errortext}
    #Open Browser
    #New Page        ${URL}
    Click           ${SEL_KROK_PRED_PRIHLASENIM}
    Click           ${SEL_ACCEPT_COKIES}
    Get Text        ${SEL_LOGIN_BUTTON}             ==              ${overenilogin}
    Click           ${SEL_LOGIN_BUTTON}
    Get Text        ${SEL_ERROR_INFO_TEXT}           ==              ${errortext}
    Take Screenshot


PrihlaseniAOdhlaseni
    [Arguments]     ${email}        ${heslo}           ${overenilogin}      ${OVERENI_2}
    #Open Browser
    #New Page        ${URL}
    Click           ${SEL_KROK_PRED_PRIHLASENIM}
    Type Text       ${SEL_EMAIL_FIELD}              ${email}
    Type Text       ${SEL_PASSWORD_FIELD}           ${heslo}
    Click           ${SEL_ACCEPT_COKIES}
    Get Text        ${SEL_LOGIN_BUTTON}             ==              ${overenilogin}
    Click           ${SEL_LOGIN_BUTTON}
    Sleep           4
    Click           ${SEL_KROK_PRED_PRIHLASENIM}
    Get Text        ${SEL_LOGOUT_BUTTON}           ==              ${OVERENI_2}
    Click           ${SEL_LOGOUT_BUTTON}
    Take Screenshot

Vyber a odebrani
    [Arguments]     ${OVERENI_3}        ${OVERENI_4}
    Sleep           3
    Get Text        ${SEL_LABEL_BOTY}                     ==               ${OVERENI_3}
    Click           ${SEL_LABEL_BOTY}
    Get Text        ${SEL_CATEGORY_NAME_TENISKY}          ==               ${OVERENI_4}
    Click           ${SEL_CATEGORY_NAME_TENISKY}
    Sleep           3
    Click           ${SEL_SIZES_TENISKY}
    Click           ${SEL_VYBER_VELIKOSTI}
    Click           ${SEL_CLICK_NA_VELIKOST}
    Click           ${SEL_PRIDANI_DO_KOSIKU}
    Take Screenshot
    Click           ${SEL_ODEBRANI_Z_KOSIKU}
    Take Screenshot

Pred_testem
    Open Browser
    New Page                ${URL}

Uklid_sada
    Close Browser