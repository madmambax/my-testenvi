*** Settings ***
Documentation     Používání klíčových slov

*** Variables ***
${P}  2   # Globalni proměnná

*** Test Cases ***

Ukázka klíčového slova
        Moje první kličové slovo


Ukázka klíčového slova s parametrem
        Vypis      Masaryk


Sečti dvě čísla
        ${result}=          Secti       20      15              # use double spaces or tab between arguments
        Should Be Equal     ${result}   ${35}

globalni promenna a jejich zmeny
    log to console  Pred zavolanim KS: ${P}
    Zmena globalni promenne v KS
    log to console  Po zavolani KS: ${P}



*** Keywords ***

Moje první kličové slovo
    [Documentation]     Klíčové slovo bez parametru
    Log to console      Karel
    Log to console      Novy


Vypis
    [Arguments]         ${parametrA}
    [Documentation]     Klíčové slovo s parametrem
    Log to console      ${parametrA}


Secti
    [Arguments]         ${numberA}                                          ${numberB}
    [Documentation]     Klíčové slovo s parametry a návratovou hodnotou
    ${res}=             Evaluate                                            ${numberA}+${numberB}
    [return]            ${res}



Zmena globalni promenne v KS
##    ${P} =  evaluate  ${P}+1   # Tohle nebude fungovat
    ${N} =  evaluate  ${P}+1
    Set Global Variable  ${P}  ${N}
    Log To Console    ve funkci: ${P}