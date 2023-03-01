
*** Settings ***
Library  Browser
Library  DebugLibrary


*** Variables ***
${url}      https://www2.hm.com/cs_cz/index.html
${pemail}   tester.olda@gmail.com
${pheslo}   Test12345


*** Test Cases ***
Login
   New Browser    chromium    headless=false
   New Page       ${url}

   Debug

   Get Title      contains    H&M

   #kliknout na povolit cookies
   Click           id=onetrust-accept-btn-handler
   Sleep           1

   #kliknout na Účet
   Click           css=.Ov8g
   Sleep           1

   Debug

   #zadat email ${pemail} do místa pro zadání emailu
   Type text       id=email         ${pemail}
   Sleep           1

   #zadat heslo ${pheslo} do místa pro zadání hesla
   Type text       id=password      ${pheslo}
   Sleep           1

   #klinout na tlačítko "Přihlasit se"
   Click           data-testid=submitButton
   Sleep           3

   #ERROR napíše občas že heslo je chybné i když je správně




