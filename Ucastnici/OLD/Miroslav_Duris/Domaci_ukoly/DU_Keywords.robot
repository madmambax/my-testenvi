*** Keywords ***
# DÚ lekce č. 4
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


# DÚ lekce č. 5
Suite_Setup_DU5
    Set Log Level    ${logLev}[T]
    Log Variables

Login_přes_API
    [Arguments]    ${Jméno}    ${Heslo}
    &{request_body}    Create Dictionary    username=${Jméno}    password=${Heslo}    useragent=Chrome 101.0.4951.67
# Hodnotu klíče 'useragent' jsem vzal z dokumentace k API aplikace 'TestLogin'.
    Log    ${\n}Přihlašovací jméno <${Jméno}>, heslo <${Heslo}>.       console=True
    ${response}    POST    ${APP_API_url}    json=&{request_body}
    Set Test Variable   ${response}     ${response}
    Log    ${\n}Response (resp. jeho 'status info' na začátku) na můj http request je:${\n}${response}${\n}    console=True
    Log    Tělo responsu je>${\n}${response.json()}    console=True

AssertPoz
    Status Should Be    ${status_code}[200]
    Status Should Be    ${response.json()}[response]

AssertNeg
    Should Not Be Equal    ${status_code}[200]    ${response.json()}[response]    msg=Status code by měl být jiný než 200!${SPACE}
    Should Not Be Equal    ${text}["3"]           ${response.json()}[reason]      msg=Hodnota klíče 'reason' by měl být jiná než 'correct'.${SPACE}

Login_přes_API_metodou_GET
    [Arguments]    ${Jméno}    ${Heslo}
    Set Suite Variable    &{request_body}    username=${Jméno}    password=${Heslo}    useragent=Chrome 101.0.4951.67
# Hodnotu klíče 'useragent' jsem vzal z dokumentace k API aplikace 'TestLogin'.
    Log    ${\n}Přihlašovací jméno <${Jméno}>, heslo <${Heslo}>.       console=True
    ${response}    GET    ${APP_API_url}    json=&{request_body}
    Set Test Variable   ${response}     ${response}
    Log     ${\n}Body responsu>${\n} ${response.json()}      console=yes

