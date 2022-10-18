*** Settings ***
# Sem je možné mj. připojit nějakou knihovnu RF.
# Co všechno je možné nastavit v sekcvi 'Setting'? Viz User Guide RBFW>

# Jediná knihovna, která funguje v testech RF a není potřeba ji tady (ani nikde jinde) připojovat, je knihovna 'BuiltIn'.
Library            OperatingSystem
Documentation     Zkouska knihovny 'OperatingSystem'

*** Test Cases ***
1. Zkouška příkazu 'help'
# Každy krok testu/testcasu se zapisuje do "tabulky", která se odděluje pomocí tabelátorů nebo alespoň 2 mezer - ne, každý test. krok se zapisuje na 1 řádek v test file.
# Příklad
#<tabulátor>log<tabulátor>${res}
    [Tags]      nefunkční
    [Documentation]     Pokus-1
    ${res} =        run     help
    Log             ${\n}${res}  console=yes
    Should Contain  ${res}  GNU bash, verze 5.0.17(1)-release (x86_64-pc-linux-gnu  # Assert I.

2. Zkouška příkazu 'help cd' (tj. nápověda pro příkaz CD)
#    Log To Console             ${NAZEV_PROMENNE}
    [Documentation]     Pokus-2
    [Tags]      nefunkční
    ${res} =  run  help cd
    Log  ${res}  console=yes
    Should Contain  ${res}  Změní pracovní adresář shellu.

3. Pozitivní test - příkaz 'help dir'
    [Documentation]     Pokus-3
    [Tags]      nefunkční
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Zobrazí zásobník adresářů.

*** Comments ***
