*** Settings ***
Library  Browser

*** Test Cases ***

*** Settings ***
Library  Browser

*** Test Cases ***

Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://www.rohlik.cz
   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

   Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
   sleep       2        # nutné z důvodu chyby na rohlik.cz



### CSS selektory ###

#element: Jedná se o element z rohli.cz: Přihlášení
#   <div data-gtm-section="user-login"><div aria-expanded="false" aria-label="účet" data-test="header-user-icon" role="button" tabindex="0" class="sc-18g3ccf-0 RlOsA"><span id="headerLogin" class="sc-18g3ccf-3 iIgRWM">Přihlásit<svg xmlns="http://www.w3.org/2000/svg" width="18" height="22" viewBox="0 0 18 22" class="icon"><path fill="#6DA305" d="M17.2 21a.81.81 0 0 1-.79-.83c0-5.41-4.43-6.04-4.62-6.06a.8.8 0 0 1-.62-.48.89.89 0 0 1 .06-.8c.02-.04 1.76-2.87 1.76-6.39 0-3.16-1.28-3.77-3.5-3.77-2.22 0-3.5.61-3.5 3.77a13.3 13.3 0 0 0 1.76 6.38c.15.24.17.55.06.8a.8.8 0 0 1-.62.49c-.18.02-4.15.62-4.58 5.22h10.57c.44 0 .8.38.8.84 0 .46-.36.83-.8.83H1.78a.81.81 0 0 1-.79-.83c0-5.02 3.17-6.82 4.9-7.43a14.96 14.96 0 0 1-1.49-6.3C4.4 1.56 7.31 1 9.49 1c2.18 0 5.09.56 5.09 5.44 0 2.73-.89 5.05-1.49 6.3 1.73.61 4.9 2.41 4.9 7.43 0 .46-.35.83-.79.83z"></path></svg></span></div></div>
#   <span id="headerLogin" class="sc-18g3ccf-3 iIgRWM">Přihlásit<svg xmlns="http://www.w3.org/2000/svg" width="18" height="22"

#co nefunguje
#   ${text} =     Get Text    css=\#headerLogin
#   ${text} =     Get Text    css=header > div > div > div > div > div > div > span > .sc-18g3ccf-3 iIgRWM
#   ${text} =     Get Text    css=span > .sc-18g3ccf-3
#   ${text} =     Get Text    data-gtm-section="user-login"
#   ${text} =     Get Text    css=sc-18g3ccf-3 iIgRWM


#Co JEDE
   ${text} =     Get Text    css=.sc-18g3ccf-3.iIgRWM               #výběr pomocí 2 class, nesmí nezi nima být mezera
   ${text} =     Get Text    css=\#headerLogin
   ${text} =     Get Text    css=[data-gtm-section="user-login"]    #výběr pomocí CSS atributu
   ${text} =     Get Text    css=[class="sc-18g3ccf-3 iIgRWM"]      #výběr pomocí 2 class formou css atributu
   ${text} =     Get Text    css=\#header >> [class="sc-18g3ccf-3 iIgRWM"]   #kobinace 2 CSS selektorů
   ${text} =     Get Text    css=\#header >> [class="sc-hlaif7-1 hBMDTj"] >> [class="sc-18g3ccf-3 iIgRWM"]
   ${text} =     Get Text    css=[data-test=header-user-icon]
   log to console       ${text}

   ${text} =     Get Text    css=[aria-label="Sortiment"]    #výběr pomocí Aria - informace pro zrakově postižené

   log to console       ${text}

   Take Screenshot



### XPATH selektory ###
   ${text} =     Get Text   xpath=//*[@id="headerLogin"]
   ${text} =     Get Text   //*[@id="headerLogin"]

   log to console       ${text}

   Take Screenshot


### TEXT selektory ###
   ${text} =     Get Text   text="Přihlásit"
   ${text} =     Get Text   "Přihlásit"

   log to console       ${text}

   Take Screenshot



### ID selektory ###

   ${text} =     Get Text   id=headerLogin

   log to console       ${text}

   Take Screenshot


### "data-test" selektory ###
   ${text} =     Get Text   data-test=header-user-icon


   log to console       ${text}

   Take Screenshot


































#
#
#
#rohlik
#    New Browser    Chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://rohlik.cz
#
#    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#
#
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
#
#
#
#
#
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
#
#
#
#
#
#















