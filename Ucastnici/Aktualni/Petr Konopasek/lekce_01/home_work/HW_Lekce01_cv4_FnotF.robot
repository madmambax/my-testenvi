"""
●	Cvičení č.4: vytvořit 2 negativní automatické testy  na příkazovou řádku
○	tedy spuštění jakéhokoliv příkazu z příkazové řádky (např. dir c:\neznamy_adresar) a
○	vyhodnocení (assert) zda došlo k očekávanému chování (obsahuje text File Not Found)
○	výsledky uložit do GITu do vašeho adresáře (git commit + git push)

"""
*** Settings ***
Library           OperatingSystem

*** Test Cases ***

První negativní test
    ${res_1} =              run                     dir c:\RobotFramework
    Log                     ${res_1}
    Should Contain          ${res_1}                File Not Found
    Log To Console          File Not Found

Druhý negativní test
    ${res_2} =              run                     dir c:\cislo_5_zije.txt
    Log                     ${res_2}
    Should Contain          ${res_2}                File Not Found
    Log To Console          File Not Found


*** Comments ***
Prvni negativní test:
=====================
Očekávam negativní, protože dir c:\RobotFramework neexistuje.
mi do proměnné uloží:  File Not Found


Druhý negativní test:
=====================
Očekávam negativní, protože dir c:\cislo_5_zije.txt neexistuje.
mi do proměnné uloží:  File Not Found