*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Library	    String

*** Variables ***
${URL} =  https://www.rohlik.cz/ 
@{randomPassw}=    Create List    srhdgnkjmhgjgegrnsfmldhygnkfm    nesmyslnehesločísldvje    nesmyslneheslo    shdgfjghfjghjhg    fghfjghjghkgjkhive   wčžeřýržátýízáoiuo


*** Test Cases ***
# Cíle: prihlaseni, odhlaseni, 2 druhy identifikace selectoru,
# KW, Happy path, Negativní, Edge

Logy debug
  Log  ${randomPassw}[0]  # vypisuje Create list - jakto?
  Log  ${randomPassw}[1]
  Log  ${randomPassw}[2]
  Log  ${randomPassw}[3]
 
Spravne vsechyn udaje a odhlaseni (popup)
      ${File}=    Get File  textaky\\psw.txt
      @{psw}=    Split to lines  ${File} 
      Log   @{psw}     #just debug
      Login (popup)   rohlicektest@seznam.cz                      @{psw}                       R             R
      # Click               class=sc-18g3ccf-6${SPACE}fDcQri      #problem s nalezenim selectoru
      # Click               data-test=user-box-logout-button
Spravny mail, spatne heslo (popup)
      Login (popup)   rohlicektest@seznam.cz                      ${randomPassw}[0]             Přihlásit    Přihlásit   
Spravny mail, zadne heslo (popup)
      Login (popup)   rohlicektest@seznam.cz                      ${EMPTY}	                    Přihlásit    Heslo je povinné
Nesmyslny format mail, spatne heslo (popup)
     Login (popup)   neco@sefhgjgkhznahgjklkj                     ${randomPassw}[1]             Přihlásit    Zadejte platný email
Null mail, spatne heslo (popup)
     Login (popup)    ${EMPTY}	                                  ${randomPassw}[2]             Přihlásit    Email je povinný
Spatny mail, spatne heslo (popup)
     Login (popup)    oiaslkfjfls@kdvldjklf.cz                    ${randomPassw}[2]             Přihlásit    Zadal(a) jste nesprávný e-mail nebo heslo.


Spravne vsechyn udaje a odhlaseni (Prihlaseni pres registracni btn)
      ${File}=    Get File  textaky\\psw.txt
      @{psw}=    Split to lines  ${File} 
      Login (Prihlaseni pres registracni btn)    rohlicektest@seznam.cz                     @{psw}                        R             R
Spravny mail, spatne heslo (Prihlaseni pres registracni btn)
      Login (Prihlaseni pres registracni btn)   rohlicektest@seznam.cz                      ${randomPassw}[0]             Přihlásit    Přihlásit   
Spravny mail, zadne heslo (Prihlaseni pres registracni btn)
      Login (Prihlaseni pres registracni btn)   rohlicektest@seznam.cz                      ${EMPTY}	                  Přihlásit    Heslo je povinné
Nesmyslny format mail, spatne heslo (Prihlaseni pres registracni btn)
     Login (Prihlaseni pres registracni btn)   neco@sefhgjgkhznahgjklkj                     ${randomPassw}[1]             Přihlásit    Zadejte platný email
Null mail, spatne heslo (Prihlaseni pres registracni btn)
     Login (Prihlaseni pres registracni btn)    ${EMPTY}	                                ${randomPassw}[2]             Přihlásit    Email je povinný
Spatny mail, spatne heslo (Prihlaseni pres registracni btn)
     Login (Prihlaseni pres registracni btn)    oiaslkfjfls@kdvldjklf.cz                    ${randomPassw}[2]             Přihlásit    Zadal(a) jste nesprávný e-mail nebo heslo.





*** Keywords ***
Login (popup)
    [Arguments]         ${email}                            ${heslo}                     ${validationLogin}       ${validationHlaska}
    Open Browser        ${URL}                              headless=true    
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            body                                contains                    ${validationHlaska}
    Get Text            data-test=header-user-icon          ==                          ${validationLogin}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot
    

Login (Prihlaseni pres registracni btn)
    [Arguments]         ${email}                            ${heslo}                    ${validationLogin}       ${validationHlaska}
    Open Browser        ${URL}                              headless=false    
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Click               data-test=linkRegistration
    Click               text=Přihlásit se
    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            body                                contains                    ${validationHlaska}
    Get Text            data-test=header-user-icon          ==                          ${validationLogin}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot
    
