"""
●	Cvičení č.4: Příprava na příště
○	nainstalujte si NODE.JS - odkaz ke stažení: Download | Node.js
○	restartujte  počítač
○	nainstalujte si knihovnu BrowserLibrary pro Robot Framework
do příkazového řádku zadejte: pip install robotframework-browser
inicializujte knihovnu příkazem: rfbrowser init
○	spusťte první test
"""

*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
   Get Title      ==    Browser
   Take Screenshot