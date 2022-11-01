*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    Set Browser Timeout  ${40}
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://rohlik.cz/vitejte
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    sleep          2

# odklikne cookies
    Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep       2        # nutné z důvodu chyby na rohlik.cz

    click       data-test=IconUserLogin
    sleep       10
    Take Screenshot


#když text tak s uvozovkama / když id tak bez uvozovek
    #click          text="Přihlásit"
#můžu přes f12 zvolit i id
    #click          id=HeaderLogin
#css
    #click          css=#HeaderLogin
#data test - nejvíce reliable (css = pořád se mění, text = hrozí duplicita textu, id = 2nd, data test = nejlepší)
    #Click          data-test=IconUserLogin

    #Sleep          3


#     Click   text="Přihlásit"
#     Click   id=headerLogin
#     Click   css=#headerLogin
#     Click   xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]
#     Click   data-test=IconUserLogin