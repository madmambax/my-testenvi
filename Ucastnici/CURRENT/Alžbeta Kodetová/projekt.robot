*** Settings ***
Library  Browser

*** Variables ***
${pemail}          radek.tester@seznam.cz
${pheslo}          tajneheslotajneheslo
${pinicialy}       JT
*** Test Cases ***
Starting a browser with a page
    New Browser             chromium    headless=false
    Set Browser Timeout     20
    New Page                https://www.rohlik.cz/
    Get Title               contains    Rohlik.cz

    Click          text="Přihlásit"
    Type Text      data-test=user-login-form-email    ${pemail}

    Type Text      xpath=//input[@data-test='user-login-form-password']   ${pheslo}

    Click          data-test=btnSignIn

    Get Text       data-test=header-user-icon    ==    ${pinicialy}

    Click          data-test=header-user-icon

    Click          data-test=user-box-logout-button


    sleep   3