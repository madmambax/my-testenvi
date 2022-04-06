*** Settings ***
Library     OperatingSystem

*** Variables ***
${file}     test.txt

*** Test Cases ***

Prvni test pozitivní
    create file                 ${file}         1. Test vytvoření souboru ${file}
    file should exist           ${file}
    file should not be empty    ${file}
    ${res} =                    get file        ${file}
    #log file                    ${file}
    should contain              ${res}          1. Test vytvoření souboru ${file}
    log to console              \n Soubor ${file} obsahuje text: \n ${res}

Druhý test pozitivní
    remove file             ${file}
    file should not exist   ${file}
    log to console          \n Soubor ${file} byl smazán.

Obsah adresáře Alex. Suchankova
    List       ${CURDIR}    ${7}

*** Keywords ***
List
    [Arguments]         ${dir}  ${count_files}
    ${list} =           list files in directory     ${dir}
    ${count} =          count files in directory    ${dir}
    log to console      \n Adresář obsahuje tyto soubory: ${list}, \n celkem ${count} souborů.
    Should Be Equal     ${count}   ${count_files}