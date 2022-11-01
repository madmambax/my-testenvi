*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser

*** Test Cases ***
Prihlaseni bad login
    Otevri stranku      https://www.rohlik.cz
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

#Prihlaseni bad heslo
#    Otevri stranku      https://www.rohlik.cz
#    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

#Prihlaseni success
#    Otevri stranku      https://www.rohlik.cz
#    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***
Otevri stranku
    [Arguments]         ${URL}
    Open Browser        ${URL}      headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    New Page            ${URL}

### Místo:
#    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
#    sleep               1
# Vytvoříme KS Cookie s 1 parametrem, viz níže, parametr určuje zda chceme vše povolit nebo odmítnout
    Cookie              AcceptAll

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Click               id=headerLogin
    Type Text           id=email                                    ${email}
    Type Text           id=password                                 ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==      ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        # klinout na "Odmítnout"
        Click               id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep                1      #workaround: Probliknutí cele stránky po kliknutí na tlačítk