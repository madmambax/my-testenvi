*** Settings ***
Documentation     Testování API Memsource
Library         RequestsLibrary
Library         Collections
Resource        Data_and_Config/var_and_keywords.robot

Suite Setup     API Login Admin  #log in and get token


*** Variables ***


*** Test Cases ***

# positive tests

Who Am I
    [Documentation]     Ověř platnost tokenu
    Make GET Call   v1/auth/whoAmI      ${token}
    Status Should Be  200

Who Am I - wrong Token
    [Documentation]     Ověř neplatnost tokenu
    Make GET Call  v1/auth/whoAmI      wrongToken
    Status Should Be  401

List projects
    [Documentation]     vypiš projekty
    Make GET Call   v1/projects     ${token}
    Status Should Be  200

List projects - wrong Token
    [Documentation]     vypiš projekty
    Make GET Call  v1/projects      wrongToken
    Status Should Be  401

List Clients
    [Documentation]     vypiš klienty
    Make GET Call       v1/clients      ${token}
    Status Should Be    200

List Clients - wrong Token
    [Documentation]     vypiš klienty
    Make GET Call   v1/clients      wrongToken
    Status Should Be  401

Create client
    ${data}=                Make POST Call      v1/clients      ${token}    body={"name":"Client ABC"}
    Status Should Be        201
    Set Suite variable      ${client_id}        ${data}[uid]

Delete Client - wrong Token
    Make DELETE Call    v1/clients/${client_id}      wrongToken
    Status Should Be    401


Delete Client - wrong ID
    Make DELETE Call    v1/clients/wrongID    ${token}
    Status Should Be    404


Delete Client
    Make DELETE Call    v1/clients/${client_id}      ${token}
    Status Should Be    204










