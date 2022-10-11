*** Settings ***
Documentation   Automatizace rohlik.cz s Browser Library
Library         Browser

Resource        Project/TestData.robot
Resource        Project/Configuration.robot

Suite Setup     Before_Set
Suite Teardown  After_Set

Test Timeout    ${WAIT}

*** Variables ***


*** Test Cases ***

Login
     Login              ${username}              ${password}        ${initials}
     Logout

Login wrong
    Login               ${username}             dasdas              ${LoginText}

Add item to cart
     Login              ${username}             ${password}        ${initials}
     Add item to cart   ${goods}          ${product_id}          2
     Logout

Remove item from cart
     Login              ${username}              ${password}        ${initials}
     Remove item from cart   ${product_id}        2
     Logout


*** Keywords ***

Login
     [Arguments]          ${username}          ${password}          ${initials}
     New Page             ${Rohlik}
     Get Title            ${MainTitle}

     Cookies              AcceptAll

     Click                ${SEL_iconUserLogin}
     Type Text            ${SEL_LoginFormEmail}                   ${username}
     Type Text            ${SEL_LoginFormPwd}                     ${password}
     Click                ${SEL_BtnSignIn}
     Get Text             ${SEL_HeaderUserIcon}   ==  ${initials}
     ${log}=              Get Text  ${SEL_HeaderUserIcon}
     Log                  ${log}
     Take Screenshot


Cookies
     [Arguments]          ${type}
     IF  "${type}" == "AcceptAll"
          Click           ${SEL_Cookie_AllowAll}
     ELSE
          Click           ${SEL_Cookie_Decline}
     END

Add item to cart
     [Arguments]          ${goods}          ${product_id}          ${amount}

     Type Text          ${SEL_SearchGlobal}          ${goods}
     Click              ${SEL_BtnSearchGlobal}
     Click              css=[${SEL_ProductID}="${product_id}"][${SEL_BtnAdd}]
     ${Pocet}           Evaluate                    ${amount} - 1
     Click              css=[${SEL_ProductID}="${product_id}"][${SEL_BtnPlus}]  clickCount=${Pocet}
     Go To              ${Cart}
     Sleep              ${WAIT}
     Take Screenshot


Remove item from cart
    [Arguments]          ${product_id}          ${amount}
    Go To      ${Cart}
    Click      css=[${SEL_ProductID}="${product_id}"][${SEL_BtnMinus}]   clickCount=${amount}
    Sleep      ${WAIT}
    Take Screenshot

Logout
   Go to               ${Rohlik}
   Click               ${SEL_HeaderLoginErrorTxt}
   Click               ${SEL_LogoutBtn}

Before_Set
    Open Browser               ${Rohlik}
    Cookies                      AcceptAll

After_Set
    Go to                   ${Rohlik}
    Logout
    Close Browser
