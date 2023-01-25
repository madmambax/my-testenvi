*** Settings ***
Library  Browser
Resource    TestData.robot
Resource    Configuration.robot
Test Setup    BeforeTest
Test Teardown  AfterTest
Suite Setup  BeforeSuite
Suite Teardown  AfterSuite

*** Variables ***


*** Test Cases ***

Negativni test prihlaseni
    Login               ${USER_BAD_NAME}  ${USER_BAD_PASSWORD}  ${USER_BAD_SHORT}

Pozitivni pridani zbozi do kosiku, kontrola a odebrani
    Login               ${USER1_NAME}  ${USER1_PASSWORD}  ${USER1_SHORT}
    Pridat do kosiku varianta produkt id    ${ZBOZI01_NAME}  ${ZBOZI01_ID}  5
    ${ks} =  Zjistit Pocet Kusu  ${ZBOZI01_ID}
    Should Be Equal    ${ks}  5
    Log To Console    ${ks}
    Odebrat Z Kosiku    ${ZBOZI01_ID}  5


Negativni test s prekrocenim maximalniho poctu 50 kusu
    Login               ${USER1_NAME}  ${USER1_PASSWORD}  ${USER1_SHORT}
    Pridat do kosiku varianta produkt id    ${ZBOZI01_NAME}  ${ZBOZI01_ID}  100
    ${ks} =  Zjistit Pocet Kusu  ${ZBOZI01_ID}
    Should Be Equal    ${ks}  50
    Log To Console    ${ks}
    Odebrat Z Kosiku    ${ZBOZI01_ID}  50


*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_LoginFormEmail}  ${email}
    Type Text           ${SEL_LoginFormPwd}  ${heslo}
    Click               ${SEL_BtnSignIn}
    Wait For Response   matcher=${URL_api_login}
    Get Text            ${SEL_UserShortIcon}          ==      ${validation}
    ${log}=   Get Text  ${SEL_UserShortIcon}
    Log                 ${log}
    Take Screenshot



Logout
    ${log} =  Get Text  ${SEL_UserShortIcon}
    Run Keyword If	"${log}" != "${TEXT_Prihlasit}"  doLogout

doLogout
    Click   ${SEL_UserShortIcon}
    Click   ${SEL_UserBoxLogoutBtn}
    Wait For Response    matcher=${URL_api_logout}
    ${text} =  Get Text    css=[${SEL_UserShortIcon}]
    Should Contain  ${text}  Přihlásit

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END


Pridat kusy
   [Arguments]         ${produkt_id}     ${Kusu}
   FOR  ${i}  IN RANGE  ${Kusu}
     ${error} =  Get Element States  ${SEL_ERROR_TOOLTIP}  then    bool(value & visible)
     IF  not (${error})
        Click               ${SEL_CartAddPiecePrefix}${produkt_id}${SEL_CartAddPiecePostfix}
        Wait For Response    matcher=${URL_api_cart}
     END
   END


Pridat do kosiku varianta produkt id
    Go to  ${URL}
    Get Title  contains  ${TEXT_MainTitle}
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
    Type Text           ${SEL_SearchGlobal}  ${Zbozi}
    Click               ${SEL_SearchButton}

    FOR    ${i}    IN RANGE    100
           Sleep  ${TIME_BETWEEN_CHECKS}
           ${visible} =  Get Element States  ${SEL_CartWhisperer}  then    bool(value & visible)
           Exit For Loop If  ${visible}
           Log  ${i}
    END

    ${exist} =  Get Element States  ${SEL_CartWhispererAddPiecePrefix}${produkt_id}${SEL_CartWhispererAddPieceSuffix}  then    bool(value & visible)
    IF  ${exist}
     Click               ${SEL_CartWhispererAddPiecePrefix}${produkt_id}${SEL_CartWhispererAddPieceSuffix}
     ${Kusu} =  Evaluate  ${Kusu} - 1
     Pridat kusy  ${produkt_id}  ${Kusu}
    ELSE
     Pridat kusy  ${produkt_id}  ${Kusu}
    END


Odebrat z kosiku
    [Arguments]         ${produkt_id}     ${Kusu}
    Go to  ${URL_cart}
    Get Title  contains  Přehled
    ${exist} =  Get Element States  ${SEL_BtnMinusPrefix}${produkt_id}${SEL_CartBtnSufix}  then    bool(value & visible)
    IF  ${exist}
        Click  ${SEL_BtnMinusPrefix}${produkt_id}${SEL_CartBtnSufix}  clickCount=${Kusu}
        Wait For Response    matcher=${URL_api_cart}
    END


Zjistit pocet kusu
    [Arguments]         ${produkt_id}
    [Return]    ${return}
    Go to  ${URL_cart}
    Get Title  contains  Přehled
    ${exist} =  Get Element States  ${SEL_BtnMinusPrefix}${produkt_id}${SEL_CartBtnSufix}  then    bool(value & visible)
    ${return} =  Set Variable    0
    IF  ${exist}
        ${return} =  Get Text     ${SEL_BtnMinusPrefix}${produkt_id}${SEL_CartBtnSufix} ~ input
    END
    Log To Console    ${return}



BeforeSuite
    Set Browser Timeout  ${TIMEOUT_BROWSER}
    Open Browser        ${URL}                              headless=false
    Get Title           contains                            ${TEXT_MainTitle}
    Cookie              AcceptAll
    Login               ${USER1_NAME}  ${USER1_PASSWORD}  ${USER1_SHORT}
    Odebrat z kosiku  ${ZBOZI01_ID}  50
    Logout



AfterSuite
    Odebrat z kosiku  ${ZBOZI01_ID}  50

BeforeTest
    Go To    ${URL}
    Get Title  contains  ${TEXT_MainTitle}

AfterTest
    Odebrat z kosiku  ${ZBOZI01_ID}  50
    Logout
    Go To     ${URL}
    Get Title  contains  ${TEXT_MainTitle}





