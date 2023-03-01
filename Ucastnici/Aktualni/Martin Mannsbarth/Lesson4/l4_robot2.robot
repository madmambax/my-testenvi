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

    Type Text       xpath=/html/body/div[1]/div[3]/form/div[1]/div[1]/div[1]/div/div[2]/input  Testování     # selektor pomocí atributu

    Sleep           10


*** Keywords ***
Otevri stranku
    [Arguments]         ${URL}
    New Browser         headless=false
    New Page            ${URL}


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               css=button#L2AGLb
    ELSE
        # klinout na "Odmítnout"
        Click               css=button#W0wltc

    END