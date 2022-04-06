*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    #New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/
    click       id=headerLogin         #není spolehlivé, může dojít ke změně ID
    #click       text=Přihlásit         není spolehlivé, může být na stránce několikrát
    #click      "Přihlásit"             není spolehlivé, může být na stránce několikrát
    Type Text   data-test=user-login-form-email    ahoj
    type text   data-test=user-login-form-password  heslo
    data-test="header-user-icon"
    take screenshot