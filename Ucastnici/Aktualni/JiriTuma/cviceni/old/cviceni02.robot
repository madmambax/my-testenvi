*** Variables ***

@{array} =  chrome  firefox

*** Test Cases ***
Test
    Log Many  ${array}
    Log To Console    ${array}[0]
    Should Contain  ${array}[0]  chrome
