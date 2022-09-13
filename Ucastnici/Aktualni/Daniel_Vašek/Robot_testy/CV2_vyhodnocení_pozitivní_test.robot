*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}    Specifies drive, directory, and/or files to list.
${NAME}     Volume in drive C is Windows
${HELPDIR}  Specifies drive
${DIR}      229C-FC94

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run                help dir
    log to console             ${res}
    Should Contain             ${res}              ${GREET}        # Proměná pro identifikaci help dir
    Should Contain             ${res}              ${HELPDIR}      # Proměná pro identifikaci help dir

Druhy test pozitivní
    ${res} =        run                dir
    log to console              ${res}
    Should Contain              ${res}             ${NAME}          # Proměná pro identifikaci dir
    Should Contain              ${res}             ${DIR}           # Proměná pro identifikaci dir