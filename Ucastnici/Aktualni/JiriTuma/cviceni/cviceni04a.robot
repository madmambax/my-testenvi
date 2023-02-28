*** Settings ***
Documentation   Automatizace Google s BrowserLibrary
Library  Browser


*** Test Cases ***

Vyhledavani na googlu
    Otevri stranku  https://www.google.cz

### Místo:
#    Click               css=button#L2AGLb
#    Vytvoříme KS Cookie s 1 parametrem, viz níže, parametr určuje zda chceme vše povolit nebo odmítnout

#    Cookie              ???doplnit parametr klíčového slova???

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
        Click               id=L2AGLb
        Sleep    2
    ELSE
        # klinout na "Odmítnout"
        Click               id=W0wltc
        Sleep    2

    END