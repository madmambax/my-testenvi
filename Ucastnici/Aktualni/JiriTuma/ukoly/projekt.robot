*** Settings ***
Library    Browser
Resource   TestData.robot

*** Test Cases ***
Before test
    New Browser    chromium    headless=false
    New Page        ${Rohlik web} 
    Sleep           2
    Get Title       contains    ${TEXT_MainTitle}
    Click           ${SEL_Cookie_Decline} 
    Sleep           2
    Take Screenshot

Starting a browser with a page of Rohlik, decline cookie dialog, login and logout.
    Click           ${TEXT_Account}
    Sleep           2
    Type Text       ${SEL_LoginFormEmail}    ${USER1_NAME}  
    Type text       ${SEL_LoginFormPwd}      ${USER1_PASSWORD}
    Click           ${SEL_BtnSignIn}
    Sleep           2
    Get Text        ${USER1_SHORT}
    Sleep           2
    Take Screenshot

After test
    Go To           ${Rohlik web}
    Sleep           2
    Click           ${SEL_HeaderLogin} 
    Sleep           2
    Click           ${SEL_BtnSignOut} 
    Take Screenshot
