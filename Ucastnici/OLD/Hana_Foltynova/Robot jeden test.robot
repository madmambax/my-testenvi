*** Settings ***
Library     OperatingSystem
Library     Collections


*** Test Cases ***


Prvni test pozitivní
    #${res} =        run     help
    #log             ${res}
    #Should Contain  ${res}  For more information on a specific command, type HELP command-name
    Should Be Equal As Numbers	    1.123	    1.1	    precision=1

Druhy test pozitivni
    ${cislice} =	    Create List	    1   2   3   4   5   6   7   8   9   0
    ${sude_cislice} =	Create List	    2   4   6   8
    List Should Contain Sub List        ${cislice}  ${sude_cislice}


Prvni test negativni
    #${res} =        run     ahoj
    #log             ${res}
    #Should Contain  ${res}  This command is not supported by the help utility.
    Should Be Equal As Numbers	    1.123	    1.1	    precision=2

Druhy test negativni
    ${liche_cislice} =	Create List	    1   3   5   7   9
    ${sude_cislice} =	Create List     1   4   6   8
    List Should Contain Sub List        ${liche_cislice}  ${sude_cislice}
