# Testování přihlášení do aplikace rohlik.cz



*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/
${user}     JT
${id_message}   data-test=user-login-form-email-message
${email_text}   Zadejte platný email



*** Test Cases ***

Login uspesne data-test
    [Documentation]  Uspesne prihlaseni pomoci data-test
    Login               radek.tester@seznam.cz      tajneheslotajneheslo

Login uspesne id
    [Documentation]  Uspesne prihlaseni pomoci id
    Login_id            radek.tester@seznam.cz      tajneheslotajneheslo

Login zapomenute heslo
    [Documentation]  Zapomenute heslo
    Login_zapom_heslo            radek.tester@seznam.cz

Login prazdne heslo
    [Documentation]  Prazdne heslo
    Login_Prazdne_heslo      radek.tester@seznam.cz

Login neplatny email
    [Documentation]  Zadan neplatny e-amil
    Login_Neplatny_email    radek.tester@seznam..cz      tajneheslotajneheslo


*** Keywords ***
Login
    [Documentation]  	Uspesne prihlaseni
    [Arguments]         ${username}         ${password}
    New Page            ${URL}
        Get Title           contains           Rohlik      # Hláška: TimeoutError: page.goto: Timeout 10000ms exceeded.
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email             ${username}
    Type Text           data-test=user-login-form-password          ${password}
    Click               data-test=btnSignIn

Login_id
    [Documentation]  	Uspesne prihlaseni
    [Arguments]         ${username}         ${password}
    New Page            ${URL}
    Get Title           contains           Rohlik      # Hláška: TimeoutError: page.goto: Timeout 10000ms exceeded.
    Click               id=headerLogin
    Type Text           id=email             ${username}
    Type Text           id=password          ${password}
    Click               css=.sc-1232tqx-0
    Get Text            css=.sc-18g3ccf-6       ==      ${user}

Login_zapom_heslo
    [Documentation]  	Zapomenute heslo
    [Arguments]         ${username}
    New Page            ${URL}
    Click               id=headerLogin
    Click               xpath=//x-translation[contains(.,'Zapomenuté heslo?')]
    Type Text           xpath=//input[@id='email']             ${username}
    Click               data-test=button

Login_Prazdne_heslo
    [Documentation]  	Prazdne heslo
    [Arguments]         ${username}
    New Page            ${URL}
    Click               id=headerLogin
    Type Text           id=email             ${username}
    Click               data-test=btnSignIn
    Get Text            data-test=user-login-form-password-message        ==      Heslo je povinné

Login_Neplatny_email
    [Documentation]  	Neplatny email
    [Arguments]         ${username}         ${password}
    New Page            ${URL}
    Click               xpath=//x-translation[contains(.,'Přihlásit')]
    Type Text           id=email            ${username}
    Type Text           id=password         ${password}
    Click               xpath=//x-translation[contains(.,'Přihlásit se')]
    Get Text            data-test=user-login-form-email-message       ==      Zadejte platný email