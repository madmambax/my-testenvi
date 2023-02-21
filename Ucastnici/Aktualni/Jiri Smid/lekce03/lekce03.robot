#*** Settings ***
#Library  Browser
#
#*** Test Cases ***
#Starting a browser with a page
#   New Browser    chromium    headless=false
#   #New Context    viewport={'width': 1920, 'height': 1080}
#   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#   Get Title      ==    Browser

------------------------------------

*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   #New Context    viewport={'width': 1920, 'height': 1080}
   New Page       https://www.rohlik.cz/vitejte
   Get Title      contains    Rohlik.cz
   
   #Click    "Účet"
   Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
   #Click    text="Povolit všechny"
   #Click    xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]
   #Click    css=.CybotCookiebotDialogBodyButton  #selektor, css selektor s # je jako id
   Sleep    3
   Click    data-test=header-user-icon
   Sleep    3
   Type Text    id=email    test@funguje.cz
   Sleep    3
   Take Screenshot

   #Get Text


