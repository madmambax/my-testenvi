*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
Library         Browser

*** Test Cases ***
Test Example
    New Browser    chromium    headless=False
    New Context    enable_playwright_debug=True
    New Page       https://alza.cz
    Close Browser