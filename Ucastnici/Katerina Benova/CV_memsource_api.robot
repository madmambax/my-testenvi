*** Settings ***
Documentation     Testování API Memsource
Library     RequestsLibrary
Library     Collections

*** Variables ***
${url}      https://cloud.memsource.com/web/api2/



*** Test Cases ***

Login user
    [Documentation]     Uspesne prihlaseni a získání tokenu
    ${data}=    Login    jane.brown   ***
    Dictionary Should Contain Key     ${data}      token
    Set Suite Variable   ${token}    ${data}[token]


Who Am I
    [Documentation]     Ověř platnost tokenu
    Make GET Call   v1/auth/whoAmI
    Status Should Be  200

Who Am I Wrong Token
    [Documentation]     Ověř neplatnost tokenu
    Make GET Call Wrong Token  v1/auth/whoAmI
    Status Should Be  401


List projects
    [Documentation]     vypiš projekty
    Make GET Call   v1/projects
    Status Should Be  200


*** Keywords ***
Make GET Call
    Skip If  '${token}'=='skip'    msg = Skipped with Skip keyword.
    [Arguments]  ${path}     @{parameters}
    &{header}=    Create Dictionary    Authorization=ApiToken ${token}
    ${resp} =    GET    ${url}${path}  params=${parameters}  headers=${header}
    Log	Response: @{resp}
    [return]    ${resp.json()}


Make GET Call Wrong Token
    [Arguments]  ${path}     @{parameters}
    &{header}=    Create Dictionary    Authorization=ApiToken abc
    ${resp} =    GET    ${url}${path}  params=${parameters}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}



Login
    [Arguments]    ${username}    ${password}
    ${json_string}=    catenate    {"userName":"${username}","password":"${password}"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =   POST On Session  apilogin  v1/auth/login  data=${json_string}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    Set Suite Variable  ${token}  skip
    [return]    ${resp.json()}
