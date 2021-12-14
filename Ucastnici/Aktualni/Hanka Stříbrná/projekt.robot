*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=true
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/

#    Click          id=headerLogin
    Click           "Přihlásit"

#   Click          data-test=header-user-icon
    Type Text       data-test=user-login-form-email     stribrna.hana@gmail.com
    Type Text       id=password                         zkusebniheslo
    Click           "Přihlásit se"
    Take Screenshot
    


