*** Settings ***
Library   OperatingSystem

*** Test Cases ***
#Negativní testy

První
    ${result} =        run           verr
    Log                ${result}
    Should Contain     ${result}     'verr' is not recognized as an internal or external command,


Druhý
    ${result} =        run           help ip
    Log                ${result}
    Should Contain     ${result}     Try "ip /?".