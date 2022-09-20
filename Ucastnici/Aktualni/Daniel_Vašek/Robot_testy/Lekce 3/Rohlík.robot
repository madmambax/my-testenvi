*** Settings ***
Library  Browser

*** Test Cases ***

Starting a browser with a page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/vitejte
    Get Title      ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click          text="Přihlásit"
    #Click           data-test=IconUserLogin
    Take Screenshot
    sleep          5