

*** Settings ***
Library  Browser


*** Variables ***
${URL}              https://www.decathlon.cz/
${title}            Decathlon



*** Test Cases ***
Přihlášení a odhlášení
    Přihlášení    tester.olda@gmail.com    Test12345    Olda Tester
    Odhlášení

*** Keywords ***

Přihlášení
    [Arguments]         ${email}     ${heslo}     ${user-icon}

    New Browser         chromium     headless=false
    New Page            ${URL}
    Click               id=didomi-notice-agree-button
    Sleep               1
    Click               "můj účet"
    Sleep               1
    Type text           xpath=//input[@id='input-email']        ${email}
    Click               xpath=//button[@id='lookup-btn']
    Sleep               1
    Type text           id="input-password"     ${heslo}
    Click               id="signin-button"
    Sleep               1
    Click               id="consents-button-submit"
    Sleep               1
    Get text            css=span > class="svelte-skopdm" == ${user-icon}

Odhlášení
    go to               ${URL}
    Click               "Olda Tester"
    Sleep               1
    Click               xpath=//div[@id='app']//aside/nav/ul/li[@class='wrapper']/button[@type='button']/span[.='Odhlásit se']

Přidání zoží do košíku
    [Arguments]         ${nazev-zbozi}      ${id-produktu}      ${pocet}
    Type text           id="search-bar"     ${nazev-zbozi}
    Click               css=form[role='search'] path

Odebrání zboží z košíku