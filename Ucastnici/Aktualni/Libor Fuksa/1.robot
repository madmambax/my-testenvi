*** Settings ***
#Library    String
Library    OperatingSystem

*** Test Cases ***

JE GIT NAINSTALOVAN?
    ${result} =             run         git --version
    Log                     ${result}
    Should Contain          ${result}   git version

FUNGUJE PRIKAZ TIME (ZOBRAZENI / EDITACE CASU)
    ${result} =             run         help time
#    Log                     ${result}
    Should Contain          ${result}   Displays or sets the system time.


#HELP NEEXTISTUJICI
#    ${result} =             run         help tohlejespatne
#    Log                     ${result}
#    Should not Contain      ${result}   is not supported