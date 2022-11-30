*** Settings ***
Documentation   Automatizace Google s BrowserLibrary
Library  Browser


*** Test Cases ***

Priklad vyberu pomoci atributu, elementu a id
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
        Click               ???doplnit identifikátor???
    ELSE
        # klinout na "Odmítnout"
        Click               ???doplnit identifikátor???

    END