*** Settings ***
Library    String
#Library    OperatingSystem

*** Test Cases ***

JE GIT NAINSTALOVAN?
    ${result} =             run         git --version
    Log                     ${result}
    Should Contain          ${result}   git version
#   Should Contain          ${result}   Switches may be preset in the DIRCMD environment variable.

#HELP NEEXTISTUJICI
#    ${result} =             run         help tohlejespatne
#    Log                     ${result}
#    Should not Contain      ${result}   is not supported