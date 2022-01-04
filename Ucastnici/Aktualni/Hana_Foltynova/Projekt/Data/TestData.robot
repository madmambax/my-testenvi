*** Variables ***
${URL} =  https://www.rohlik.cz/ 
@{randomPassw}=    Create List    srhdgnkjmhgjgegrnsfmldhygnkfm    nesmyslnehesločísldvje    nesmyslneheslo    shdgfjghfjghjhg    fghfjghjghkgjkhive   wčžeřýržátýízáoiuo

#textaky
${File}=    Get File  textaky\\psw.txt

#kredence
${USER_login_correct} =  rohlicektest@seznam.cz
${USER_login_unreal_bez_cz} =  neco@sefhgjgkhznahgjklkj
${USER_login_unreal} =  oiaslkfjfls@kdvldjklf.cz

#hlášky na webu (nejen chybové) 
${LOGIN_user_letter} =  R
${LOGIN_hlaska_1} =  Přihlásit
${LOGIN_hlaska_2} =  Heslo je povinné
${LOGIN_hlaska_3} =  Zadejte platný email
${LOGIN_hlaska_4} =  Email je povinný
${LOGIN_hlaska_5} =  Zadal(a) jste nesprávný e-mail nebo heslo.




#selectory

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
    
