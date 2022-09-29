*** Comments ***

*** Settings ***
Library  Browser
Documentation   4 testcasy na 'Browser' library

*** Test Cases ***

Case #1
    [Documentation]     PASS (Starting a browser with a page)
    [Tags]          funkční
   New Browser    chromium    headless=false
   New Page       https://www.rohlik.cz
   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#   Type Text    id=searchGlobal     Ahoj

Case #2
    [Documentation]     Zapnutý 'Headless mode', overrided error message, s chybou v assertu (Starting a browser with a page)
    [Tags]          nefunkční?
   New Browser    chromium    headless=true
   New Page       https://www.rohlik.cz
   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve   ERROR!

Case #3
    [Documentation]     Jiný browser a jiný AssertionOperator (Starting a browser with a page)
    [Tags]              funkční
   New Browser            firefox    headless=true
   New Page               https://www.rohlik.cz
   Get Title             *=    Online supermarket Rohlik.cz  #AssertionOperator '*=' is equal to 'contains' - jsou zcela zaměnitelný.
   ${Title}      Get Title
   Log To Console   ${\n}${Title}
#   Get Title      !=       'Title of the Web Page mustn't contain this item.'

Case #4
    [Documentation]     Keywords 'Click', 'Type Text', 'Take Screenshot'
    [Tags]               funkční
    #New Context
    New Browser         chromium  headless=true
    New Page             https://www.rohlik.cz/vitejte
    #Click     id=headerLogin        #Nesmí být id="headerLogin" ani id='headerLogin' (to 'id' musí být bez uvozovek..)

    # Možnosti zápisu selektoru typu 'text' (platí to jenom pro klíč. slovo 'Click'?)>
    #1 Click    text=Přihlásit
    #2 Click    text="Přihlásit"
    #3 Click    text='Přihlásit'
    #4 Click    "Přihlásit"
    Click        'Přihlásit'
    Type Text    data-test=input     Váš e-mail  # S input v uvozovkách to nefunguje (ani "input" ani 'input').
    Type Text    data-test=input    Vaše heslo
    Take Screenshot
