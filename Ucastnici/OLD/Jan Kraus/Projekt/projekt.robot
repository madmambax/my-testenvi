*** Settings ***
Library         Browser
Resource        Data/TestData.robot
Resource        Data/Configuration.robot

Suite Setup     Pred_sadou
Test Teardown   Po_testu

*** Test Cases ***

Přihlášení s dobrým loginem pro temp účet a přidání do košíku
    Login               ${USER1_NAME}         ${USER1_PASSWORD}             ${USER1_SHORT}
    Add To Basket       ${ZBOZI01_NAME}       ${ZBOZI01_NUMBER}
    Sleep               ${SLEEP_TIME}
    Remove From Basket
    Sleep               ${SLEEP_TIME}
    Logout

Přihlášení se špatným heslem
    Login               ${USER1_NAME}             ${USER1_WRONG_PASS}           ${TEXT_Prihlasit}

Prihlaseni s dobrým loginem pro radekkitner
    Login               ${USER2_NAME}             ${USER2_PASSWORD}             ${USER2_SHORT}


*** Keywords ***
Login
    [Arguments]     ${email}      ${heslo}     ${user}

    #Ověření načtení stránky
    Get Title       contains   ${TEXT_MainTitle}

    #Otevření login okna
    Click           ${SEL_HeaderLogin}
    #Sleep           ${SLEEP_TIME}

    #Zadání emailu
    Type Text       ${SEL_LoginFormEmail}      ${email}
    #Sleep           ${SLEEP_TIME}

    #Zadání hesla
    Type Text       ${SEL_LoginFormPwd}        ${heslo}

    #Kliknout na přihlásit se
    Click           text="Přihlásit se"
    #Sleep           ${SLEEP_TIME}
    ${header_icon}=   Get Text     ${SEL_HeaderLoginIconText}

    #Ověření přihlášení uživatele pomocí iniciálů v ikonce
    Get Text             ${SEL_HeaderLoginIconText}          ==      ${user}
    ${icon}=   Get Text  ${SEL_HeaderLoginIconText}
    Log         ${icon}
    Take Screenshot

    log             ${email}
    log             ${heslo}
    log             ${user}
    #Sleep           ${SLEEP_TIME}

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    #Sleep               ${SLEEP_TIME}


Logout
     Go to           ${URL}
     Click           ${SEL_HeaderLoginIcon}
     Click           ${SEL_BtnLogOut}
     #Sleep           ${SLEEP_TIME}
     Take Screenshot

Add to basket
     [Arguments]      ${product}    ${number}
     Type Text           ${SEL_SearchGlobal}             ${product}
     #Sleep               ${SLEEP_TIME}
     Click               ${SEL_BtnSearchGlobal}
     Sleep               ${SLEEP_TIME}
     Click               css=[data-test=btnAdd] >> nth=1
     #Sleep               ${SLEEP_TIME}
     ${pocet} =          Evaluate       ${number} - 1
     Click               css=[data-gtm-button="addPiece"] >> nth=1       clickCount=${pocet}

Remove from basket
     Click               ${SEL_RemoveBasket}

Pred_sadou
    ${browser_timetout} =       Set Browser Timeout     ${TIMEOUT_BROWSER}
    Open Browser         ${URL}         headless=False
    Cookie               AcceptAll

Po_testu
    Go To       ${URL}
