*** Settings ***
Library            Browser
Resource           TestData.robot
Test Timeout       45 seconds

Suite Setup        Před sadou
Test Setup         Před testem
Test Teardown      Po testu
Suite Teardown     Po sadě

*** Test Cases ***
Zkouška přihlášení uživatele
    [Setup]        Před testem
    Přihlášení uživatele
    [Teardown]     Po testu

*** Keywords ***
Před sadou
    New Browser    chromium    headless=false

Před testem
    New Page        ${Rohlik web} 
    [Timeout]       20
    Get Title       contains    ${TEXT_MainTitle}
    Click           ${SEL_Cookie_Decline} 
    Sleep           2
    Take Screenshot

Po testu
    Go To           ${Rohlik web}
    [Timeout]       20
    Click           ${SEL_HeaderLogin} 
    Sleep           2
    Click           ${SEL_BtnSignOut} 
    Take Screenshot

Po sadě
    Close Browser

Přihlášení uživatele
    Click           ${TEXT_Account}
    Sleep           2
    Type Text       ${SEL_LoginFormEmail}    ${USER1_NAME}  
    Type text       ${SEL_LoginFormPwd}      ${USER1_PASSWORD}
    Click           ${SEL_BtnSignIn}
    Sleep           2
    Get Text        ${USER1_SHORT}
    Sleep           2
    Take Screenshot
