*** Comments ***
Test klíčového slova 'Run'.
Mělo by akceptovat pouze 1 argument.
Když použiju 2. argument, tak failne test?

*** Settings ***
Library  OperatingSystem

*** Test Cases ***
Test 01
    ${res}    run    help    dir        # Mezi 'help' a 'dir' jsou 4 mezery.
    log    ${res}
    Should Contain    ${res}    For more information on a specific command, type HELP command-name
# Nemám asi nainstalovanej RBFW - přes terminál mi tenhle test nejde spustit. Ale za pomoci 'Run' IDE to jde.

Test 02
    ${res}    run    help dir        # Mezi 'help' a 'dir' je 1 mezera.
    log    ${res}
    Should Contain    ${res}    For more information on a specific command, type HELP command-name
# Teď to naopak jde spustit přes terminál, ale nejde to přes 'Run'.
