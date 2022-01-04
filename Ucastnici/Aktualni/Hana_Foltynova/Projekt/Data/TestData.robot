*** Variables ***
@{randomPassw}=    Create List    srhdgnkjmhgjgegrnsfmldhygnkfm    nesmyslnehesločísldvje    nesmyslneheslo    shdgfjghfjghjhg    fghfjghjghkgjkhive   wčžeřýržátýízáoiuo
${title_homePage} =  Rohlik

#path
${PATH_login_psw} =  textaky\\psw.txt

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


#selectory login form
${SEL_LoginFormMail} =  data-test=user-login-form-email
${SEL_LoginFormPsw} =  data-test=user-login-form-password

#selectory login obecné
${SEL_BtnSignIn} =  data-test=btnSignIn
${SEL_UserIcon} =  data-test=header-user-icon
${SEL_IdHeaderLogin} =  id=headerLogin

#selectory login pres registrační form
${SEL_registrace} =  data-test=linkRegistration
${SEL_registrace_prihlas} =  text=Přihlásit se
    
