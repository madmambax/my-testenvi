#Rohlik.cz s Browser library

*** Settings ***
Library     Browser


*** Variables ***


*** Test Cases ***
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://www.rohlik.cz   #Otevře tab

#    Get Title      ==    Browser
    Get Title      contains    Rohlik.cz  #*=
 #web- prozkoumat - selector
     Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
#    Click       text="Povolit všechny"
#    Click    xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]  #copy xpath
#    Click    css=.CybotCookiebotDialogBodyButton
     Sleep      3
     Click      data-test=header-user-icon

     Type Text    id=email    aaa@bbb.cz
#     Get Text    selector    na chybové hlášky
#     Take Screenshot
