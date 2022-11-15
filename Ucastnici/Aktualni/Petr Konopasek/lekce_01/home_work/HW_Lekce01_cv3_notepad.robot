"""
●	Cvičení č.3: vytvořit 2 pozitivní automatické testy na příkazovou řádku
○	tedy spuštění jakéhokoliv příkazu z příkazové řádky (např. dir c:\Windows) a
○	vyhodnocení (assert) zda došlo k očekávanému chování (obsahuje text notepad.exe)
○	výsledky uložit do GITu do vašeho adresáře (git commit + git push)

"""
*** Settings ***
Library           OperatingSystem

*** Test Cases ***

První Positivní test
    ${res_1} =                  run               DIR C:\Windows
    Log                         ${res_1}
    Log To Console              ${res_1}
    should not contain          ${res_1}          notepad.exe


Druhý Positivní test
    ${res_2} =                  run               where notepad.exe
    Log                         ${res_2}
    Log To Console              ${res_2}
    should contain              ${res_2}          notepad.exe


*** Comments ***
Prvni Positivni test:
=====================
Očekávam, že se notepad.exe nevypíše, protože DIR C:\Windows
mi do proměnné uloží: Volume in drive C has no label.
                      Volume Serial Number is A617-330F
should not contain != = Proměnná ${res_1} >> neobsahuje notepad.exe.

Prvni Positivni test:
=====================
Očekávam, že se notepad.exe vypíše, protože where vyhledá cestu notepad.exe
a do proměnné uloží: C:\Windows\System32\notepad.exe
should contain  = Proměnná ${res_2} >> obsahuje notepad.exe.


