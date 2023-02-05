*** Settings ***
Library             OperatingSystem
Documentation       Libor - DÚ JAT LEKCE 2

*** Variables ***
${nazev} =  nicmnenenapada.txt
@{prikaz} =     git --version   help time                           help dnes                                            dir
@{obsahuje} =   git version     Displays or sets the system time.   This command is not supported by the help utility.   ${nazev}


*** Keywords ***
Overeni
    [Arguments]    ${vstup}
    ${res}=        Run               ${vstup}
    [return]       ${res}

*** Test Cases ***

Je GIT nainstalovan?
        ${result}=        Overeni    ${prikaz}[0]
        Log    vystup provedeno prikazu "${prikaz}[0]" je "${result}"
        Should Contain    ${result}  ${obsahuje}[0]

Je prikaz "TIME" platny?
        ${result} =       Overeni     ${prikaz}[1]
        Log    vystup provedeno prikazu "${prikaz}[1]" je "${result}"
        Should Contain    ${result}   ${obsahuje}[1]

Je prikaz "DNES" neplatny?
 	    ${result} =        Overeni     ${prikaz}[2]
 	    Log    vystup provedeno prikazu "${prikaz}[2]" je "${result}"
        Should Contain     ${result}   ${obsahuje}[2]

Existuje soubor \"${nazev}" v aktuálním adresáři?
 	    ${result} =         Overeni     ${prikaz}[3]
 	    Log    vystup provedeno prikazu "${prikaz}[3]" je "${result}"
	    should Contain      ${result}   ${obsahuje}[3]

