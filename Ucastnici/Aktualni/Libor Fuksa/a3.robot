*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***
#${x}    10
#${text}    assdasdjksahd

*** Test Cases ***

HELP DIR
    ${result} =             run         help dir
    Log                     ${result}
    Should not Contain      ${result}   is not supported
#   Should Contain          ${result}   Switches may be preset in the DIRCMD environment variable.

HELP NEEXTISTUJICI
    ${result} =             run         help tohlejespatne
    Log                     ${result}
    Should not Contain      ${result}   is not supported

HELP NEEXTISTUJICI
    ${result} =             run         help tohlejespatne
    Log                     ${result}
    Should Contain      ${result}   is not supported
