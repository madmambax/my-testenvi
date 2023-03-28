*** Settings ***
Library    RequestsLibrary

Resource    ../Data_and_Lib/validations.robot
Resource    ../Data_and_Lib/import_jsonSchema.resource

Test Template   Custom Test Template

# robot '.\Ucastnici\Aktualni\David Karpiel\DÚ-07\Test_login\test_login_pozitiveTests.robot'

*** Variables ***
${API URL} =   	http://testovani.kitner.cz
${APP} =		/login_app/userauth.php
${LOGIN_URL} =  ${API URL}${APP}

*** Test Cases ***                  USERNAME            PASSWORD            USERAGENT                       EXPECTED_STATUS

Verify OK Login - Chrome            admin               tajneadmin          Chrome 111.0.5563.65            200

#NEPROJDE!
#Verify Login - Edge                admin               tajneadmin          Microsoft Edge 111.0.1661.54     200

*** Keywords ***
Custom Test Template
    [Arguments]    ${username}    ${password}    ${useragent}    ${expected_status}
    Log To Console    \nSending Request To ${LOGIN_URL}\n
    &{jsonBody}  Create Dictionary  username=${username}  password=${password}  useragent=${useragent}
    &{header}        Create Dictionary   Content-Type=application/json    #vytoření hlavičky (header) zprávy
    ${response}  POST   url=${LOGIN_URL}  json=${jsonBody}  headers=${header}  expected_status=Anything
    Log	                Responce: @{response}
    Should Contain      ${response.json()}[response]     ${expected_status}    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Validate Schema     input_Json=${response.json()}    reference_Schema_Path=${GLOBAL_SCHEMA_LOGIN_POST}     #json schema - ověření