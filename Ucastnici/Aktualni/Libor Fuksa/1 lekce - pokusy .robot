*** Settings ***
Library    String
Library    OperatingSystem

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

# co se stane, kdyz dam vice commitu na stejnem fileu a pak az poslu do hubu? (commit1)
# (commit2)
# (commit3) po nem poslu