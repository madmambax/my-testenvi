*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.aboutyou.cz/
${chybovahlaska}=  Tvá e-mailová adresa nebo heslo není správné. Zkus to prosím znovu.

*** Test Cases ***
Login ok
    Prihlaseni        KubaKostka23@gmail.com            Heslo123         Přihlásit se

Spatne heslo
    Prihlaseni        KubaKostka23@gmail.com            Heslo            Přihlásit se
    Get Text          xpath=//*[@id="modal-root"]/div/div/div/div/div[2]/div[2]/form/div[3]            ==       ${chybovahlaska}

Spatny email
    Prihlaseni        Kuba@gmail.com                    Heslo123         Přihlásit se
    Get Text          xpath=//*[@id="modal-root"]/div/div/div/div/div[2]/div[2]/form/div[3]            ==       ${chybovahlaska}

Nezadane udaje
    Bez Udaju         Přihlásit se  Zadej prosím e-mailovou adresu

Odhlaseni uzivatele
    PrihlaseniAOdhlaseni        KubaKostka23@gmail.com            Heslo123         Přihlásit se

*** Keywords ***
Prihlaseni
    [Arguments]     ${email}        ${heslo}           ${overenilogin}
    Open Browser
    New Page        ${URL}
    Click           data-test-id=WishlistIconHeader
    Type Text       data-testid=EmailField              ${email}
    Type Text       data-testid=PasswordField           ${heslo}
    Click           id=onetrust-accept-btn-handler
    Get Text        data-testid=SubmitLogin             ==              ${overenilogin}
    Click           data-testid=SubmitLogin
    Take Screenshot

Bez udaju
    [Arguments]     ${overenilogin}  ${errortext}
    Open Browser
    New Page        ${URL}
    Click           data-test-id=WishlistIconHeader
    Click           id=onetrust-accept-btn-handler
    Get Text        data-testid=SubmitLogin             ==              ${overenilogin}
    Click           data-testid=SubmitLogin
    Get Text        data-testid=ErrorInfoText           ==              ${errortext}
    Take Screenshot


PrihlaseniAOdhlaseni
    [Arguments]     ${email}        ${heslo}           ${overenilogin}
    Open Browser
    New Page        ${URL}
    Click           data-test-id=WishlistIconHeader
    Type Text       data-testid=EmailField              ${email}
    Type Text       data-testid=PasswordField           ${heslo}
    Click           id=onetrust-accept-btn-handler
    Get Text        data-testid=SubmitLogin             ==              ${overenilogin}
    Click           data-testid=SubmitLogin
    Click           data-test-id=WishlistIconHeader
    Get Text        data-test-id=LogoutButton           ==              Odhlásit se
    Click           data-test-id=LogoutButton
    Take Screenshot