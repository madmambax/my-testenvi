*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/vitejte
    Get Title      contains   Rohlik
    
    Click    "Povolit všechny"
    Sleep    3
    Click    data-test=header-user-icon
    
    Type Text    id=email    pokus@seznam.cz