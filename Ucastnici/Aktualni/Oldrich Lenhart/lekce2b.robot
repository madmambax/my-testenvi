*** Settings ***
Library    OperatingSystem

*** Variables ***
@{web browsers} =  Chrome  Mozila  Edge

*** Test Cases ***

Vypsat list
    Log To Console  ${web browsers}

Vypsat jednu položku
    Log To Console    ${web browsers}[0]

Je prvni chrom?
    Should Contain    Chrome    ${web browsers}[0]
