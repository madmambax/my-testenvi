*** Settings ***
Library     Browser
Resource    TestData.robot
Resource    Configuration.robot
Suite Setup     Pred_sadou
Test Setup      Pred_testem


*** Variables ***



*** Test Cases ***

#Přihlášení šatný email - doladit test -
#    Login       chyba                ${USER1_PASSWORD}           ${ERROR_TEXT_FillCorrectEmail}
#    Clik        alt=Dr.Max


Přihlášení a odhlášení OK
    Login               ${USER1_NAME}       ${USER1_PASSWORD}        ${USER1_SHORT}
    Logout

*** Keywords ***

Login
    [Arguments]     ${email}      ${heslo}     ${text}
#    set browser timeout     200              #200s jede to fakt hodně pomalu

#    log             ${email}
#    log             ${heslo}
#    log             ${text}


    #otevřít prohlížeč
#    new browser     chromium    headless=false
    #otevřít stránku drmax.cz
#    new page        ${URL}
    #ověřit že se stránka otevřela
    get title       contains                     ${TEXT_MainTitle}
    #kliknout na Přihlásit
    click           ${SEL_HeaderLogin}
    #    zadat email ${email} do místa pro zadání emailu
    type text       ${SEL_LoginFormEmail}        ${email}
    #zadat heslo ${heslo} do místa pro zadání hesla
    type text       ${SEL_LoginFormPwd}          ${heslo}
    #klinout na tlačítko "Přihlasit se"
    click           ${SEL_BtnSignIn}
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${text}
    get text        ${SEL_HeaderLoginErrorTxt}  ==  ${text}

Logout
    click          ${SEL_HeaderLoginErrorTxt}
    click          ${SEL_UserBoxLogoutBtn}


Pred_sadou
     ${b_timeput} =             Set Browser Timeout                 200                 #200s je to lenoch
     Log                        ${b_timeput}


Pred_testem
       New Browser       chromium       headless=false
       New Page          ${URL}