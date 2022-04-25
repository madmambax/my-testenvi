*** Settings ***
Documentation   A resource file with reusable keywords and variables.
...
...             The system specific keywords created here form our own
...             domain specific language. They utilize keywords provided
...             by the imported SeleniumLibrary.
Library         RequestsLibrary
Library         String
Library         OperatingSystem
Library         Collections
Library         BuiltIn

*** Variables ***
${encruser}     Berry2b
${encrpass}     8JV7UP&Y3bx5C9Rwr=47n3y.,0!34.1Q


*** Test Cases ***
Generate Token
    create session      my_session     https://tom.staging.webuntis.com/WebUntis/api/sso/staginghry      verify=True
    ${data1}            create dictionary   grant_type=client_credentials
    ${headers}          create dictionary        Authorization=Basic QmVycnkyYjo4SlY3VVAmWTNieDVDOVJ3cj00N24zeS4sMCEzNC4xUQ==      Content-Type=application/x-www-form-urlencoded
    ${resp}             post request     my_session      /token?grant_type=client_credentials    data=${data1}     headers=${headers}
    ${code}             convert to string    ${resp.status_code}
    Should contain                  ${code}                 200
    Should Be Equal As Strings      ${resp.status_code}     200
    ${token}                        evaluate        $resp.json().get("access_token")
    Log                             ${token}
    Log to console                  ${token}

Encrypt
    ${encrpass}     encode string to bytes
    ${bytes} =	Encode String To Bytes	${string}	ASCII	errors=ignore
