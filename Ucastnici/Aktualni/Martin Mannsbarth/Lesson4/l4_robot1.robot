*** Variables ***
${zvire}  slon

*** Test Cases ***
Podminky

#    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
    IF  "${zvire}" == "slon"
        Log To Console    Je to slon
    ELSE
        # klinout na "Odmítnout"
        Log To Console    Neni to slon
    END