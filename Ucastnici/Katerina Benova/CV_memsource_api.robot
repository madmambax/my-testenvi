*** Settings ***
Documentation     Testy pro Linguisty v Memsource
Library     RequestsLibrary
Library     Collections

*** Variables ***
${url}      https://cloud.memsource.com/web/api2/



*** Test Cases ***

Login linguist
    [Documentation]     Uspesne prihlaseni s odpovedi
    ${data}=    Login    jane.brown   ***
    Dictionary Should Contain Key     ${data}      token
    Set Suite Variable   ${token}    ${data}[token]


Who Am I
    [Documentation]     Ověř platnost tokenu
    Make GET Call   v1/auth/whoAmI
    Status Should Be  200


List projects
    [Documentation]     vypiš projekty
    Make GET Call   v1/projects
    Status Should Be  200


*** Keywords ***
Make GET Call
    [Arguments]  ${path}     @{parameters}
    &{header}=    Create Dictionary    Authorization=ApiToken ${token}
    ${resp} =    GET    ${url}${path}  params=${parameters}  headers=${header}
    Log	Response: @{resp}
    [return]    ${resp.json()}



Login
    [Arguments]    ${username}    ${password}
    ${json_string}=    catenate    {"userName":"${username}","password":"${password}"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =   POST On Session  apilogin  v1/auth/login  data=${json_string}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}
