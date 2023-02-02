*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}   Ahoj


*** Keywords ***


*** Test Cases ***

Ukazka prace s KS
    Log   Zaciname
    Moje prvni KS    Honzo
    ${vysledek}=   Secti  2  5
    ${vysledek}=   Odecti  2  5
    ${vysledek}=   Vynasob  2  5
    ${vysledek}=   Vydel  2  5
    Log To Console    ${vysledek}




