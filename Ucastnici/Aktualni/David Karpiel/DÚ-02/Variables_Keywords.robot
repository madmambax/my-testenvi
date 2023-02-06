*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary

#robot -d results .\Tests\Demo2.robot
*** Variables ***
${prvni_pozitivni_prikaz} =   dir
${prvni_negativni_prikaz} =   dar
${druhy_pozitivni_prikaz} =   cd
${druhy_negativni_prikaz} =   cd1

${jmeno} =   Jan Novák
${e-mail} =  jan.novak@gmail.com
${ulice} =   Hradská
${mesto} =   Zlín
${heslo} =   heslo

*** Test Cases ***
První pozitivní test
        ${result} =       Run            help ${prvni_pozitivni_prikaz}
        Log               ${result}
        Should Contain    ${result}      Displays a list of files and subdirectories in a directory.
        Log               Výstupní text: ${result}

Druhý pozitivní test
        ${result} =       Run            help ${druhy_pozitivni_prikaz}
        Log               ${result}
        Should Contain    ${result}      Displays the name of or changes the current directory.
        Log               Výstupní text: ${result}

První negativní test
        ${result} =       Run            help ${prvni_negativni_prikaz}
        Log               ${result}
        Should Contain    ${result}      This command is not supported by the help utility.
        Log               Výstupní text: ${result}

Druhý negativní test
        ${result} =       Run            help ${druhy_negativni_prikaz}
        Log               ${result}
        Should Contain    ${result}      This command is not supported by the help utility.
        Log               Výstupní text: ${result}

*** Keywords ***
Registrace
    [Arguments]     ${jmeno}    ${e-mail}   ${ulice}   ${mesto}  ${heslo}
    Zadej jméno     ${jmeno}
    Zadej e-mail    ${e-mail}
    Zadej ulici     ${ulice}
    Zadej město     ${mesto}
    Zadej heslo     ${heslo}

Zadej jméno
    [Arguments]     ${jmeno}
    Input Text      zadejt ID uživatelského jména       ${jmeno}

Zadej e-mail
    [Arguments]     ${e-mail}
    Input Text      zadejt ID e-malilu     ${e-mail}

Zadej ulici
    [Arguments]     ${ulice}
    Input Text      zadejt ID ulice        ${ulice}

Zadej město
    [Arguments]     ${mesto}
    Input Text      zadejt ID města        ${mesto}

Zadej heslo
    [Arguments]     ${heslo}
    Input Text      zadejt ID hesla        ${heslo}

Klikni na tlačítko
    Click Button    BUTTON ID