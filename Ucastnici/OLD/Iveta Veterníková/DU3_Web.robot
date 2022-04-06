*** Settings ***
Library    Browser
Library    Telnet


*** Variables ***
${email}        radek.tester@seznam.cz
${password}     tajneheslotajneheslo
${password2}    spatneheslospatneheslo
${inicial}      JT   

*** Test Cases ***
Pozitivní test
    rohlík příhlášení a odhlášení správné údaje

Negativní test
    rohlík přihlášení špatné údaje



*** Keywords ***
rohlík příhlášení a odhlášení správné údaje

    New Browser            chromium                    headless=false
    New Page               https://www.rohlik.cz/  
    Click                  xpath=//*[@id="headerLogin"]
    Click                  id=email  
    Type Text              input#email                 ${email}
    Click                  id=password  
    Type Text              input#password              ${password}
    Click                  data-test=btnSignIn
      
        
    Get Text               data-test=header-user-icon     ==     ${inicial}   
    Click                  xpath=//*[@id="headerUser"]/div  
    Click                  data-test=header-user-icon
    Take screenshot

rohlík přihlášení špatné údaje
    New Browser            chromium                    headless=false
    New Page               https://www.rohlik.cz/  
    Click                  xpath=//*[@id="headerLogin"]
    Click                  id=email  
    Type Text              input#email                 ${email}
    Click                  id=password  
    Type Text              input#password              ${password2}
    Click                  data-test=btnSignIn
    Get Text               data-test=header-user-icon     ==     ${inicial}

    Take Screenshot  


