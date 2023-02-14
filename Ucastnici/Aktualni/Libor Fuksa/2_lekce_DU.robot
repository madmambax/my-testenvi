*** Settings ***
Library             OperatingSystem
Documentation       Libor - DÚ JAT LEKCE 2

*** Variables ***
${nazev} =  nicmnenenapada.txt
@{prikaz} =     git --version   help time                           help dnes                                            dir
@{obsahuje} =   git version     Displays or sets the system time.   This command is not supported by the help utility.   ${nazev}
${P} =  0

*** Keywords ***
Overeni
    [Arguments]    ${vstup}
    ${res}=        Run               ${vstup}
    ${P}=   Evaluate    ${P}+1
    Set Global Variable    ${P}
    [return]       ${res}

*** Test Cases ***

Je GIT nainstalovan?
        ${result}=        Overeni    ${prikaz}[${P}]
        Log    vystup provedeno prikazu "${prikaz}[${P-1}]" je "${result}"
        Should Contain    ${result}  ${obsahuje}[${P-1}]

Je prikaz "TIME" platny?
        ${result} =       Overeni     ${prikaz}[${P}]
        Log    vystup provedeno prikazu "${prikaz}[${P-1}]" je "${result}"
        Should Contain    ${result}   ${obsahuje}[${P-1}]

Je prikaz "DNES" neplatny?
 	    ${result} =        Overeni     ${prikaz}[${P}]
 	    Log    vystup provedeno prikazu "${prikaz}[${P-1}]" je "${result}"
        Should Contain     ${result}   ${obsahuje}[${P-1}]

Existuje soubor \"${nazev}" v aktuálním adresáři?
 	    ${result} =         Overeni     ${prikaz}[${P}]
 	    Log    vystup provedeno prikazu "${prikaz}[${P-1}]" je "${result}"
	    should Contain      ${result}   ${obsahuje}[${P-1}]

