*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}              https://www.rohlik.cz/vitejte/  #julinka808@gmail.com, zkouska123
${url2}             https://www.google.com
${url3}             https://robotframework.org/

*** Test Cases ***
Test1 pozitivní - prohlížeč otevře stránku a menu pro přihlášení a vyplní emailovou adresu

    Open browser        ${url}                              chrome
    click element       ID=headerLogin
    input text          xpath://*[@id="email"]              julinka808@gmail.com
    input password      xpath://*[@id="password"]           zkouska123
    click button        xpath://*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button
    close browser

Test2 pozitivní - Browser otevře stránku a zkontroluje, zda obsahuje slovo Robot
    Start Case
        page should contain                 Robot
        close browser
        log to console                      stránka obsahuje slovo "Robot"

Test3 negativní - stránka neobsahuje slovo Ahoj

    Start Case
        maximize browser window
        page should not contain             Ahoj
        close browser

Test4 negativní - vybraný prohlížeč nemá driver uložený na správném místě
    Open browser                        ${url}               firefox
    close browser

*** Keywords ***
Start Case
        Open browser                        ${url2}             chrome
        Go to                               ${url3}
