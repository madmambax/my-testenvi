*** Settings ***
Library     Browser

Resource    Selectors.robot
Resource    InputData.robot

*** Keywords ***

Load page
    ${old_timeout} =    Set Browser Timeout    10 seconds
    New Page            ${BASE_URL.${ENVIRONMENT}}
    Set Browser Timeout    ${old_timeout}

Verify page loaded
    Get Title              contains      ${URL_TITLE}

Close cookies
    ${acceptAll} =  Get Text    ${SEL_ACCEPT_COOKIE_BUTTON}
    IF    "${acceptAll}" == "Rozumím"
        Click    ${SEL_ACCEPT_COOKIE_BUTTON}
    ELSE
        Click    ${SEL_DECLINE_COOKIE_BUTTON}
    END

Close pop-up
    ${passed} =  Run Keyword And Return Status    Click    css=[class=close] >> nth=1
    Run Keyword If  ${passed}  Log  The previous step FAILED!