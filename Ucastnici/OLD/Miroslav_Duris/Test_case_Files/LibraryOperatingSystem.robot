*** Settings ***
Documentation    Test klíčového slova 'Run'. Mělo by akceptovat pouze 1 argument.
...              Když použiju 2. argument, tak failne test?
Library         OperatingSystem

*** Test Cases ***
LibraryOperatingSystem_NegativniTest
    ${res}    run    help    dir
    # Mezi 'help' a 'dir' jsou 4 mezery, tzn. pro klíč. slovo 'Run' jsou to 2 (samostatné) argumenty.
    log    ${res}
    Should Contain    ${res}    For more information on a specific command, type HELP command-name
#1 Nejde spustit prostřednictvím 'Run'.
#2 Jinak je test asi OK.
#3 Upravit ho ale tak, aby výsledek testcasu byl OK. Akutálně failuje, protože klíč. slovo 'Run' očekává jenom 1 argument.

LibraryOperatingSystem_PozitivniTest
    ${res}    run    help dir
    # Mezi 'help' a 'dir' je 1 mezera, tzn. pro klíč. slovo 'Run' je to 1 argument.
    log    ${res}
    Should Contain    ${res}    For more information on a specific command, type HELP command-name
#1 Nejde spustit prostřednictvím 'Run'. (A stejná chyba/důvod jako v případě prvního testcasu.)
#2 V assertu 'Should Contain' mi nesedí porovnávaný hodnoty. Zkontrolovat v logu.. A nejdřív ten test udělat manuálně.

*** Comments ***
