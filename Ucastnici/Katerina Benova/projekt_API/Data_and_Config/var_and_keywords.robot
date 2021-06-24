*** Settings ***
Documentation   Testování API Memsource
Library         RequestsLibrary
Library         Collections

*** Variables ***
${url}      https://cloud.memsource.com/web/api2/
${admin_user}   marek.kure82
${admin_pwd}    Mpls6868
${client_id}    skip


*** Keywords ***
Check Error Msg
    [Arguments]     ${data}    ${msg}
    Should Be Equal As Strings      ${data}[errorDescription]   ${msg}

Make GET Call
    Skip If  '${token}'=='skip'    msg = Skipped with Skip keyword.
    [Arguments]  ${path}    ${token}    ${parameters}=    ${body}=
    &{header}=    Create Dictionary    Authorization=ApiToken ${token}
    CreateSession    apisession    ${url}
    ${resp} =    GET on Session    apisession   ${path}  params=${parameters}     data=${body}     headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}


Make POST Call
    Skip If  '${token}'=='skip'    msg = Skipped with Skip keyword.
    [Arguments]   ${path}   ${token}    ${parameters}=    ${body}=
    &{header}=    Create Dictionary    Authorization=ApiToken ${token}  Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    POST On Session    apilogin  ${path}   params=${parameters}    data=${body}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}


Make DELETE Call
    Skip If  '${token}'=='skip'    msg = Skipped with Skip keyword.
    Skip If  '${client_id}'=='skip'    msg = Skipped with Skip keyword.
    [Arguments]  ${path}    ${token}
    &{header}=    Create Dictionary    Authorization=ApiToken ${token}
    CreateSession    apisession    ${url}
    ${resp} =    DELETE On Session  apisession  ${path}   headers=${header}     expected_status=Anything
    Log	Response: @{resp}


API Login
    [Arguments]    ${username}    ${password}
    ${json_string}=    catenate    {"userName":"${username}","password":"${password}"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =   POST On Session  apilogin  v1/auth/login  data=${json_string}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}


API Login Admin
    ${data}=    API Login    ${admin_user}   ${admin_pwd}
    Dictionary Should Contain Key     ${data}      token
    Set Suite Variable   ${token}    ${data}[token]