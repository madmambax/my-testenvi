"""

●	Cvičení č.1:
○	DU 3 a 4 z minule lekce bude základ vašeho projektu. Tedy 4 testy na váš software
○	Přidejte do nějaké proměnné které vám test zjednoduší
○	Napřiklad příkaz nebo kontrolní text nastavte jako proměnou v sekci Variables
○	Příklad pro RFW:
${output_text}     For more information on a specific command

"""

*** Settings ***
Library     OperatingSystem
Library     DateTime


*** Variables ***
${CONTAIN}  notepad.exe
${FNF}      File Not Found

*** Test Cases ***

# Použití klíčového slovo v projektu - CV č.3.
TimeStamp
        TimeStamp
        Where_HW_L2
        Log_Var

# 2 x Pozitivní test
# Modifikované cvičení z první lekce HW_Lekce01_cv3_notepad.robot
První Positivní test
    ${res_1} =            Run              DIR C:\Windows
    Log                   ${res_1}
    Log To Console        ${\n}${res_1}
    should not contain    ${res_1}         ${CONTAIN}


Druhý Positivní test
    ${res_2} =            run              where ${CONTAIN}
    Log                   ${res_2}
    Log To Console        ${\n}${res_2}
    should contain        ${res_2}         ${CONTAIN}


# 2x Negativní test
# Modifikované cvičení z první lekce HW_Lekce01_cv4_FnotF.robot
První negativní test
    ${res_1} =            run               dir c:\RobotFramework
    Log                   ${res_1}
    Log To Console        ${\n}${res_1}
    Should Contain        ${res_1}          ${FNF}


Druhý negativní test
    ${res_2} =            run               dir c:\cislo_5_zije.txt
    Log                   ${res_2}
    Log To Console        ${\n}${res_2}
    Should Contain        ${res_2}          ${FNF}

#Vypíše do konzole datum a čas 3. lekce
Lekce-3-JAT
    Lekce-3-JAT

*** Keywords ***

Log_Var
    [Documentation]  Zaloguje všechny proměnné
    Log Variables

TimeStamp
    [Documentation]  Vypíše datum a čas
    ${Date} =        Get Current Date
	Log To Console   ${\n}Dnesni datum a čas je ${Date}

Where_HW_L2
    [Documentation]  Vypíše název a cesta spuštěného souboru
    ${find_hw} =     run  where HW_Lekce02_Projekt.robot
    Log To Console   Název a cesta spuštěného souboru je:${\n}${find_hw}${\n}${\n}

Lekce-3-JAT
    [Documentation]  Vypíše do konzole datum a čas 3. lekce
    Log To Console   ${\n}Lekce č.3 - JAT je ve středu 23-11-2022 v 17:30 hod.
    





