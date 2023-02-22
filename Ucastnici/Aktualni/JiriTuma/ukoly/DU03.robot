*** Settings ***
Library  Browser

*** Variables ***
${Rohlik web}      https://www.rohlik.cz/

*** Test Cases ***
Starting a browser with a page of Rohlik, decline cookie dialog, login and logout.
    New Browser    chromium    headless=false
    New Page        ${Rohlik web} 
    Get Title       contains    Online supermarket Rohlik.cz
    Click           id=CybotCookiebotDialogBodyButtonDecline
    Sleep           2
    Click           "Účet"
    Sleep           2
    Type Text       id=email    jt5@seznam.cz
    Type text       id=password    Heslo12345
    Click           "Přihlásit se"
    Sleep           2
    Get Text        "JT"
    Sleep           2

    Click          id=headerUser
    sleep          2
    Click          "Odhlásit se"
