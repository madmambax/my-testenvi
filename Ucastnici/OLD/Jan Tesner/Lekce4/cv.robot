*** Settings ***
Documentation
Library  Browser


*** Test Cases ***

Accept Cookies
    Otevri stranku  https://www.google.cz
#    Click           css=button#L2AGLb                        #Přijmou prohlášení
#    Type Text       css=[aria-label="Najít"]   Testování     # selektor pomocí atributu
#    Click           css=input.gNO89b >> nth=1                # selektor pomoci elementu a id
    Cookie          AcceptAll
    sleep           3

Decline Cookies
    Otevri stranku  https://www.google.cz
#    Click           css=button#L2AGLb                        #Přijmou prohlášení
#    Type Text       css=[aria-label="Najít"]   Testování     # selektor pomocí atributu
#    Click           css=input.gNO89b >> nth=1                # selektor pomoci elementu a id
    Cookie          decline
    sleep           3

*** Keywords ***
Otevri stranku
    [Arguments]         ${URL}
    New Browser         headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               id=L2AGLb
    ELSE
        # klinout na "Odmítnout"
        Click               id=W0wltc
    END