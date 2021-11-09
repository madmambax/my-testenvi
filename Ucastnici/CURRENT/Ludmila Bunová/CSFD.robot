*** Settings ***
Library  Browser


Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot
Test Timeout    25

*** Test Cases ***

Login - incorrect login
    Login             ${INVALID_Email}          ${USER1_Password}                ${SEL_Icon1}

Login - incorrect password
   Login              ${USER1_Email}              ${INVALID_Password}                           ${SEL_Icon1}

Login successful
    Login             ${USER1_Email}             ${USER1_Password}                 ${SEL_Icon2}
    Logout            ${SEL_Icon1}

*** Keywords ***

Login
    [Arguments]     ${USER1_Email}     ${USER1_Password}     ${RESULT}
    log             ${USER1_Email}
    log             ${USER1_Password}
    log             ${RESULT}

    New Browser     chromium    headless=false

    New Page        ${URL}

    Get Title       contains    ${TEXT_MainTitle}

    Mouse Move Relative To      ${SEL_Icon1}

    Click          ${SEL_LoginLink}
    Type Text      ${SEL_LoginFormEmail}        ${USER1_Email}

    Type Text      ${SEL_LoginFormPwd}          ${USER1_Password}

    Click          ${SEL_BtnSignIn}

Login Verifying
    [Arguments]     ${ICON}     ${RESULT}
    Log     ${ICON}
    Log     ${RESULT}

    IF      ${ICON}     ==      ${SEL_Icon2}

        Get Text        ${SEL_LoginVerifying}   ==     ${RESULT}
    ELSE
        Get Element     ${SEL_Icon1}     ==       ${RESULT}
Logout
    [Arguments]     ${RESULT}
    log             ${RESULT}
    Mouse Move Relative To      ${SEL_Icon2}
    Click                       ${SEL_LogoutLink}
    Get Element                 ${SEL_Icon1}

Before_suite
    ${b_timeput}     =         Set Browser Timeout                 20
    Log                        ${b_timeput}
