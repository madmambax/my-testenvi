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


*** Variables ***
${BROWSER}                      chromium
${WU_URL_NIGHTLY}               https://nightly.webuntis.com/
${WU_URL_STAGING}               https://tom.staging.webuntis.com/
${SCHOOL_NIGHTLY_HRY}           nightlyhry
${SCHOOL_STAGING_HRY}           staginghry
${SCHOOL_NIGHTLY_API}           nightlyautoapi
${VALID USER}                   admin
${VALID PASSWORD}               admin
${AUTH_BASE_URL_NIGHTLY}        ${WU_URL_NIGHTLY}WebUntis/api/sso/${SCHOOL_NIGHTLY_HRY}
${AUTH_BASE_URL_STAGING}        ${WU_URL_STAGING}WebUntis/api/sso/${SCHOOL_STAGING_HRY}
${ENDPOINT_WELLKNOWNADDRESSES}  /.well-known/openid-configuration
${ENDPOINT_TOKEN_CREDENTIALS}   /token?grant_type=client_credentials


*** Keywords ***
Generate Token
    create session      my_session     https://tom.staging.webuntis.com/WebUntis/api/sso/staginghry      verify=True
    ${data1}            create dictionary   grant_type=client_credentials
    ${headers}          create dictionary        Authorization=Basic QmVycnkyYjo4SlYXXXXXX      Content-Type=application/x-www-form-urlencoded
    ${resp}             post request     my_session      /token?grant_type=client_credentials    data=${data1}     headers=${headers}
    ${code}             convert to string    ${resp.status_code}
    Should contain                  ${code}                 200
    Should Be Equal As Strings      ${resp.status_code}     200
    ${token}                        evaluate        $resp.json().get("access_token")
    Log                             ${token}
    Log to console                  ${token}

GetWellKnown
    ${response}                 GET                  ${AUTH_BASE_URL_STAGING}${ENDPOINT_WELLKNOWNADDRESSES}
    ${body}                     convert to string    ${response.content}
    ${code}                     convert to string    ${response.status_code}
    should contain  ${body}     authorization_endpoint  token_endpoint  jwks_uri    issuer  scopes_supported
    should contain  ${code}     200