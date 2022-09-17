
*** Settings ***
Library     OperatingSystem


*** Variables ***
${GREET}  Hello       #Definice proměnné a co vypíše v rámci testu, já ji zde definuji a pak použiji v testu skrz LOG
${NAME}   Daniel

*** Test Cases ***

Prvni test negativní
    ${císlo} =            Set variable             10
    ${dc} =               Set variable             10.23232
    ${R} =                Set variable             Ahoj
    ${res} =              run                     dir adr_ktery_neexistuje           #spustí příkaz dir a něco - nesmysl
    ${v} =                Evaluate                ${dc} * 2                          #použití interní proměnné v rámci test case
    log to console        ${res}                                                     #uložení proměné v tomto případě dir nesmysl, tedy hodnoty proměnné dc
    log to console                                Pozdrav: ${Greet} Jméno: ${Name}   #Zobrazení konkrétní proměnné, kterou mám v daném testu a to přímo na obrazovku.
    log to console                                ${V}                               #Zobrazení konkrétní proměnné, kterou mám v daném testu a to přímo na obrazovku.
    log to console                                ${císlo}                           #Zobrazení konkrétní proměnné, kterou mám v daném testu a to přímo na obrazovku
    log to console                                ${dc}                              #Zobrazení konkrétní proměnné, kterou mám v daném testu a to přímo na obrazovku
    log to console                                ${r}                               #Zobrazení konkrétní proměnné, kterou mám v daném testu a to přímo na obrazovku
    Should Contain        ${res}                  File Not Found                     #Co má hledat v daném spuštěném příkazu
