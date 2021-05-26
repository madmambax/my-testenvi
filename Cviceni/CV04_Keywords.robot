*** Settings ***
Documentation     Používání klíčových slov


*** Test Cases ***

Ukázka klíčového slova
        Moje první kličové slovo


Ukázka klíčového slova s parametrem
        Vypis      Masaryk


Sečti dvě čísla
        ${result}=  Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal  ${result}  ${35}




*** Keywords ***

Moje první kličové slovo
    Documentation  Klíčové slovo bez parametru
    Log to console      Karel Novy


Vypis
    [Arguments]         ${parametrA}
    Documentation  Klíčové slovo s parametrem
    Log to console      ${parametrA}


Calculate
    [Arguments]    ${numberA}    ${numberB}   ${operator}
    Documentation  Klíčové slovo s parametry a návratovou hodnotou
    ${res}=        Evaluate    ${numberA}+${numberB}
    [return]       ${res}
