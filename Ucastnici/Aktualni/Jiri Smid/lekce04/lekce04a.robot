#*** Variables ***
#${zvire}  slon
#
#*** Test Cases ***
#Podminky
#
##    #Pozor: hodnoty, které se porovnávájí musí být v uvozovkách nebo leze použít python výrazy
#    IF  "${zvire}" == "slon"
#        Log To Console    Je to slon
#    ELSE
#        # klinout na "Odmítnout"
#        Log To Console    Neni to slon
#    END

--------------

*** Settings ***
Documentation   Automatizace Google s BrowserLibrary
Library  Browser


*** Test Cases ***

Vyhledavani na googlu
    Otevri stranku  https://www.google.cz

### Místo:
#    Click               css=button#L2AGLb
#    Vytvoříme KS Cookie s 1 parametrem, viz níže, parametr určuje zda chceme vše povolit nebo odmítnout

#    Cookie              id="L2AGLb"   #???doplnit parametr klíčového slova???

###

    Type Text       css=[aria-label="Najít"]   Testování     # selektor pomocí atributu

    sleep           3


*** Keywords ***
Otevri stranku
    [Arguments]         ${URL}
    New Browser         headless=false
    New Page            ${URL}


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               id="L2AGLb"
    ELSE
        # klinout na "Odmítnout"
        Click               id="W0wltc"

    END