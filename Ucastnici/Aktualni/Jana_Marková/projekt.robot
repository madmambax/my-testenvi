
*** Settings ***
Library     Browser


*** Variables ***

${browser}		    chromium
${SERVER}           cswworkflow:81
${LOGIN URL}        http://${SERVER}/login.aspx
${WELCOME URL}      http://${SERVER}/default.aspx
${ERROR URL}        http://${SERVER}/login.aspx
${uzivatel}         admin
${heslo}            a
${url}        http://cswworkflow:81/wfl2/variablevalue.aspx?sid=std57d6b10495686ae&pid=p26670bc0318df4c7&vid=stredisko

*** Test Cases ***
Přihlas uživatele
    Otevřít přihlašovací stránku        ${LOGIN URL}        ${browser}
    Vlož přihlašovací údaje a přihlásit       ${uzivatel}       ${heslo}
    Přihlášení proběhlo
    #Click       //*[@id="table"]/tr[2]/td[2]/a
    #Click       //*[@id="Stredisko"]/td[2]/a
    #Click       //*[@id="rozdelwfl"]/div[2]/a[2]
    #Get Element Count       //*[@id="CisloDokladu"]/td[2]/b     !=      ZP00099
    #New Page        ${url}
    #Get Checkbox State      //*[@id="dfiltr_gv__ctl2_IdSelector"]       ==      checked
    #Click       //*[@id="btnOk"]

    Odhlásit uživatele a ověřit odhlášení



*** Keywords ***
Otevřít přihlašovací stránku
    [Arguments]    ${loginpage}       ${browser}
    New Browser     ${browser}    headless=false
    New Page        ${loginpage}
    Byla otevřena přihlašovací stránka

Byla otevřena přihlašovací stránka
    Get Title      ==        Portal - Přihlášení

Odhlásit uživatele a ověřit odhlášení
    Click           id=imgMenuUser
    Click           //*[@id="mpheader_logOff"]
    Byla otevřena přihlašovací stránka

Vlož přihlašovací údaje a přihlásit
    [Arguments]    ${username}      ${password}
    Type Text      id=userName      ${username}
    Type Text      id=password      ${password}
    Click           id=btnLogIn

Přihlášení proběhlo
    Get Title      ==        Portal - Doklady k podepsání

