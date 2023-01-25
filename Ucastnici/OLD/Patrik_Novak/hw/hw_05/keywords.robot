*** Settings ***

Library   Browser

Resource  configuration.robot
Resource  test_data.robot


*** Keywords ***

MySetup
    Set Browser Timeout  ${TIMEOUT_BROWSER}
    New Browser          headless=false
    New Context          viewport={'width': 1920, 'height': 1080}  bypassCSP=True
    New Page             ${URL}
    Get Title            contains                 ${TEXT_MainTitle}
    Cookie               Accept

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "Accept"
        Click           ${SEL_Cookie_Accept}
    ELSE
        Click           ${SEL_Cookie_Reject}
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

Login
    [Arguments]     ${Email}      ${Heslo}      ${Text}
    Log             Logging in with credentials: ${Email}, ${Heslo}

    Click           ${SEL_HeaderLogin}
#    ${selector} =    Record Selector   Button
#    Log  ${selector}
#    Sleep  60
    Type Text       ${SEL_LoginFormEmail}               ${Email}
    Type Text       ${SEL_LoginFormPwd}                 ${Heslo}

#    Sleep  60

    Click           ${SEL_BtnSignIn}

    Get Text        ${SEL_HeaderLoginTxt}               contains            ${Text}

Logout
    Click  \#headerUser
    Click  data-test=user-box-logout-button

Add To Cart
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               1                           # statický timeout
    Keyboard Key        press                       Enter
    Sleep               1                           # statický timeout
    Click               ${produkt_id}
    Sleep               1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               ${SEL_BtnPlus}              clickCount=${Pocet}
    Click               ${SEL_BtnAdd}
    Click               ${SEL_PopUpCart}
    Take Screenshot
    Click               .remove-item
