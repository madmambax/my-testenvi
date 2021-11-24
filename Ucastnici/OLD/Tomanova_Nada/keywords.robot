*** Settings ***
Library   Browser

*** Test Cases ***
Test
    Otevreni prohlizece
    


*** Keywords ***
Otevreni prohlizece
    Open Browser    https://seznam.cz   chromium

    Type Text       //*[@id="hp-app"]/div/div[1]/div[2]/div/div/div[1]/header/div/div/div[2]/div[1]/form/div/label/input                 nevim
    Click           //*[@id="hp-app"]/div/div[1]/div[2]/div/div/div[1]/header/div/div/div[2]/div[1]/form/button
    sleep           3
    
    