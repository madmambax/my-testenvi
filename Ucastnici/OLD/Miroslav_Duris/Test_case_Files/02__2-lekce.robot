*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    [Documentation]    Zkouška knihovny 'Browser'
    [Tags]              Funkční

   New Browser    firefox    headless=true
   #1 Když headless=false, tak se exekuce testu provádí se zapnutým browserem
   #1 Když headless=true, tak se exekuce testu provádí s vypnutým browserem
   #2 Deafultně je nastavený jako browser 'chromium'.

   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html

   Get Title      ==    Browser     # Assert