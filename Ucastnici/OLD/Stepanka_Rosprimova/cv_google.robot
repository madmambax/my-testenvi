*** Settings ***
Library         Browser

*** Test Cases ***
Priklad vyberu pomoci atributu, elementu a id - Google
    New Browser     chromium    headless=false
    New Page        https://www.google.com
    Click           css=button#L2AGLb                        #Přijmou prohlášení
    Type Text       css=[aria-label="Najít"]   Testování     # selektor pomocí atributu
    Click           css=input.gNO89b >> nth=1                # selektor pomoci elementu a id
    sleep           3