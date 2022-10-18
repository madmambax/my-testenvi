*** Keywords ***
# Použít 'wait for element' místo Sleep.

Suite_Setup_DU4
    New Page        ${url}[0]
    Set Log Level   ${logLev}[T]

Assert_DU4_1
    Get Title    ==         test_login

Assert_DU4_2
    Take Screenshot

Suite_Teardown_DU4
    Log Variables
    Close Page

Login
    [Arguments]            ${login}          ${password}
    Type Text              ${SEL}[0]         ${login}
    Type Text              ${SEL}[1]         ${password}
    Log                    {Jméno: ${login}, Heslo: ${password}}
    Click                  ${SEL}[2]
#    Sleep                  ${sleep}["0.5"]
    Set Browser Timeout    ${browser_timeout}[1]

Logout
    Click      ${SEL}[3]
    Get Url    !=         ${url}[1]             # Assert.
