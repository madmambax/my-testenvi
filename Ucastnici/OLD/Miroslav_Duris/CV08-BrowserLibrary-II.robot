*** Comments ***

*** Settings ***
Library  Browser

*** Test Cases ***

Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://www.rohlik.cz
   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#   Type Text    id=searchGlobal     Ahoj

# Rohlik
#    New Browser    Chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://rohlik.cz
#
#    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#
##   Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
##   Click           text="Allow all"
##   Click           "Allow all"
##   Click           xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]
#    Click           css=CybotCookiebotDialogBodyButton
#   Sleep           3
#   Click           data-test=delivery-times
#
#   Sleep            30
#   Take Screenshot
#
##    # Na rohlíku je aktuálně problém, že strnka po potvrzení Cookies problikne a tím se stratí kliknutí na login
 ##    # poroto je nutné ověřit otveření přihlašovacího okna
 ###    ${nevim} =  Get Text            text=Přihlášení
 ##    ${je_otevreno_prihlaseni} =  Get Element Count    text=Přihlášení
 ##    Log                 ${je_otevreno_prihlaseni}
 ##    IF  ${je_otevreno_prihlaseni} == 0
 ##        sleep  1
 ##        Click               id=headerLogin
 ##    END