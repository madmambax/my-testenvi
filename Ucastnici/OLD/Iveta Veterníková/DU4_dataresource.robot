*** Settings ***
Library    Browser
Library    Telnet
Resource   dataresource.robot

Test Setup    pred_testem
Test Teardown    po_testu

*** Test Cases ***
Pozitivní test
    rohlík příhlášení a odhlášení správné údaje

Negativní test
    rohlík přihlášení špatné údaje



*** Keywords ***
rohlík příhlášení a odhlášení správné údaje

    Click                  ${headerlogin}
    Click                  ${idemail}  
    Type Text              ${inputemail}                    ${email}
    Click                  ${idpassword}  
    Type Text              ${inputpassword}                 ${password}
    Click                  ${sign}
      
        
    Get Text               ${icon}                   ==     ${inicial}   
    Click                  ${headerlogin/div}  
    Click                  ${icon}
    

rohlík přihlášení špatné údaje
    
    Click                  ${headerlogin}
    Click                  ${idemail}  
    Type Text              ${inputemail}                    ${email}
    Click                  ${idpassword}  
    Type Text              ${inputpassword}                 ${password2}
    Click                  ${sign} 
    Get Text               ${icon}                   ==     ${inicial}

    

pred_testem
    New Browser            ${browser1}                     headless=false
    New Page               ${url_rohlik}

po_testu
    Take Screenshot  