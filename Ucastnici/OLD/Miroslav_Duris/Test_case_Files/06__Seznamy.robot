*** Settings ***
Library     Collections

*** Test Cases ***

Cvičení na proměnné typu 'seznam'
    @{List1}=     Create List   Položka1    Položka2    Položka3
    Log To Console    ${\n}${\n}Výpis 1. seznamu:${\n}@{List1}
    Log To Console    1. položka seznamu:${\n}${List1}[0]   # Pro vypsání položky ze seznamu je potřeba nahradit zavinář dolarem.
    Log To Console    -----------------------------------------

    ${Scalar2} =  Create List    1. polozka  2. polozka  3. polozka     # Jednotlivý položky považuje asi za 'stringy'. - to je blbost, se stringem to nemá nic společnýho
    Log To Console    ${\n}Výpis 2. seznamu:${\n}${Scalar2}
    Log To Console    2. položka seznamu:${\n}${Scalar2}[1]   # Syntaxe vypsání položky ze 'skalárního' seznamu. (Je to stejný jako v předchozím případě.)
    Log To Console    -----------------------------------------

    @{list3} = 	Set Variable 	${1, 2, 3}
    Log To Console    ${\n}Výpis 3. seznamu:${\n}${list3}
    # Když nechám před názvem seznamu zavináč, tak píše chybu> AttributeError: 'int' object has no attribute 'lower'
    # Aby to prošlo bez chyby (a vypsalo do Console položky seznamu), tak musím zavináč před názvem seznamu nahradit dolarem.
    Log To Console    2. položka seznamu:${\n}${list3}[2]   # Syntaxe vypsání položky ze 'skalárního' seznamu. Proč skalárního? Ta syntaxe je stejná jako v případech výše.
    Log Many    @{list3}    # Do log file se zapisujou jednotlivý položky seznamu samostatně.
    Log To Console    -----------------------------------------

    ${list4} = 	Set Variable 	${1, 2, 3}
    Log To Console    ${\n}Výpis 4. seznamu:${\n}${list4}
    # Oproti předchozímu případu jsem zaměnil zavináče za dolary a už to prochází, ale netvoří to proměnnou typu 'seznam'.
    # A nevypadá to ani jako 'string'. Proč string? Spíš skalár, ne?
    # Je to 'tuple'?  (1, 2, 3)
    Log To Console    3. položka seznamu:${\n}${list4}[2]
    Log Many    ${list4}    # Do log file se zapisuje jedna n-tice> (1, 2, 3)
    Log To Console    ${\n}-----------------------------------------