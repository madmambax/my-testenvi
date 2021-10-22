*** Settings ***
Library  Browser


*** Test Cases ***
Starting a browser with a page
    Set Browser Timeout    20
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1800, 'height': 1080}
    New Page       https://www.rohlik.cz/
    Get Title      *=    Rohlik.cz

    Click          text="Přihlásit"
    Sleep          1

*** Keywords ***
