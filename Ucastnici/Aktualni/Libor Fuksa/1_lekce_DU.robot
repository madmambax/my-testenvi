*** Settings ***
#Library    String
Library    OperatingSystem

*** Test Cases ***

JE GIT NAINSTALOVAN?
    ${result} =             run         git --version
    Should Contain          ${result}   git version

FUNGUJE PRIKAZ "TIME" (ZOBRAZEI / EDITUJE AKTUALNI CAS)
    ${result} =             run         help time
    Should Contain          ${result}   Displays or sets the system time.

EXISTUJE PRIKAZ "DNES" (ZOBRAZI / EDITUJE AKTUALNI DATUM)
    ${result} =             run         help dnes
    Should Contain          ${result}   This command is not supported by the help utility.

EXISTUJE PRIKAZ "DNES" (ZOBRAZI / EDITUJE AKTUALNI DATUM)
    ${result} =             run         help dnes
    should Contain          ${result}   This command is not supported by the help utility.

EXISTUJE V AKTUALNIM ADRESARI SOUBOR "NicMneNenapada.txt"
    ${result} =             run         dir
    should                  ${result}   NicMneNenapada.txt