

*** Settings ***
Library  Browser

#Resource        Data_and_Config/TestData.robot
#Resource        Data_and_Config/Configuration.robot

#Test Setup      Pred_testem
#Test Teardown   Po_testu
#Suite Setup     Pred_sadou
#Suite Teardown  Po_sade

*** Variables ***
${URL}              https://www.rohlik.cz/
${title}            Rohlik



*** Test Cases ***
Přihlášení, přidání, odebrání, odhlášení
    Pred testem
    Click                   id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Přihlášení              tester.olda@gmail.com    Test12345    TO
    Sleep                   6
#    Přidání do košíku       meloun      1353365     1
    Přidání do košíku       chleba       1435296     1





*** Keywords ***
Pred testem
    New Browser         chromium     headless=false
    New Page            ${URL}
    Sleep               1


Přihlášení
    [Arguments]         ${email}     ${heslo}     ${user-icon}

    Click    "Účet"
    Sleep   1
    Type Text   id=email       ${email}
    Type text   id=password    ${heslo}
    Click       data-test=btnSignIn
    Get Text    data-test=header-user-icon  ==  ${user-icon}
    Sleep  1


Přidání do košíku
   [Arguments]          ${nazev-produktu}               ${id-produktu}      ${pocet}

   Type text            id=searchGlobal                 ${nazev-produktu}
   Sleep                1
   Click                text=Hledat      #klik na tlačítko Hledat
   Sleep                1
   Click                css=[data-product-id="${id-produktu}"][data-test="btnAdd"]
   Sleep                1
   ${pocet}             Evaluate                ${pocet}-1

Odebrání z košíku


Odhlaseni
    go to  https://www.rohlik.cz/
    Click  id=headerUser
    sleep  1
    click  data-test=user-box-logout-button
    sleep  1