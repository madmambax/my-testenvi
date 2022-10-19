*** Keywords ***
Suite_Setup_DU4
    Set Browser Timeout    ${browser_timeout}[15]    scope=Global
    Set Log Level          ${logLev}[T]
    New Page               ${url}[0]

Assert_DU4_1
    Get Title    ==         test_login

Assert_DU4_2
    [Timeout]      ${teardown_timeout}[15]
    Take Screenshot

Suite_Teardown_DU4
    [Timeout]      ${teardown_timeout}[15]
    Log Variables
    Close Page

Login
    [Arguments]            ${login}          ${password}
    Type Text              ${SEL}[0]         ${login}
    Type Text              ${SEL}[1]         ${password}
    Log                    {Jméno: ${login}, Heslo: ${password}}
    Click                  ${SEL}[2]
#    Sleep                  ${sleep}["0.5"]

Logout
    Click      ${SEL}[3]
    Get Url    !=         ${url}[1]    # Assert.
