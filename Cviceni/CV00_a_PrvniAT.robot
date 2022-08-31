*** Test Cases ***

# Každy krok testu se zapisuje do "tabulky" která se odděluje pomocí tabelátorů nebo alespoň 2 mezer
# Příklad
#<tabulátor>log<tabulátor>Toto

Prvni test
    log     Toto
    log     Se zapíše
    log     do logu































#*** Settings ***
#Library           OperatingSystem
#
#
#*** Test Cases ***
#
#Prvni test
#    ${result} =      run            help
#    Log             ${result}
#    Should Contain  ${result}       For more information on a specific command, type HELP command-name
#
#Druhy test
#    ${result} =      run            TASKLIST
#    Should Contain   ${result}      Calculator.exe

