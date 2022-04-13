# Prace s RobotFrameworkem

*** Settings ***
Library     OperatingSystem


# Sekce se označují pomocí 3 hvězdiček názvu a opět 3 hvězdičky jako
# Příklady:
#           *** Settings ***
#           *** Test Cases ***
#           *** Variables ***
#           *** Keywords ***


*** Variables ***
${NAZEV_PROMENNE}   Hodnota

*** Test Cases ***

Název testu
# Každy krok testu se zapisuje do "tabulky" která se odděluje pomocí tabelátorů nebo alespoň 2 mezer
# Příklad
#<tabulátor>log<tabulátor>${res}
    ${res} =        run     help
    Log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name


Nápověda pro příkaz CD (help cd)
    Log To Console             ${NAZEV_PROMENNE}
    ${res} =        run     help cd
    Log             ${res}
    Should Contain  ${res}  Specifies that you want to change to the parent directory