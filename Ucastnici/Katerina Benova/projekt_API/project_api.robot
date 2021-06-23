*** Settings ***
Documentation   Testování API Memsource
Library         RequestsLibrary
Library         Collections
Resource        Data_and_Config/var_and_keywords.robot

Suite Setup     API Login Admin  #log in and get token



*** Test Cases ***
Login - wrong data
    ${data}=            API Login           ${admin_user}       wrongPassword
    Status Should Be    401
    Check Error Msg     ${data}             Unauthorized

Who Am I
    Make GET Call       v1/auth/whoAmI      ${token}
    Status Should Be    200

Who Am I - wrong Token
    Make GET Call       v1/auth/whoAmI      wrongToken
    Status Should Be    401

List projects
    Make GET Call       v1/projects         ${token}
    Status Should Be    200

List projects - wrong endpoint
    ${data}=            Make GET Call       v1/project         ${token}
    Status Should Be    404
    Check Error Msg     ${data}             Not Found

List Clients
    Make GET Call       v1/clients          ${token}
    Status Should Be    200

Create client - wrong parameter name
    ${data}=                Make POST Call      v1/clients      ${token}    body={"names":"Client ABC"}
    Status Should Be        400
    Check Error Msg         ${data}   The field "name" cannot be empty.

Create client - long name
    ${data}=                Make POST Call      v1/clients      ${token}    body={"name":"Client with very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC very long name ABC"}
    Status Should Be        400
    Check Error Msg         ${data}   The size of "name" must be between 0 and 255


Create client
    ${data}=                Make POST Call      v1/clients      ${token}    body={"name":"Client ABCD"}
    Status Should Be        201
    Set Suite variable      ${client_id}        ${data}[uid]


Delete Client - wrong Token
    Make DELETE Call    v1/clients/${client_id}      wrongToken
    Status Should Be    401


Delete Client - wrong ID
    Make DELETE Call    v1/clients/wrongID          ${token}
    Status Should Be    404


Delete Client   # test Create Client must be run first
    Make DELETE Call    v1/clients/${client_id}      ${token}
    Status Should Be    204










