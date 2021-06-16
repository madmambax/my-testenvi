#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***

#Login data
${USER_RIGHT_NAME}      radek.tester@seznam.cz
${USER_RIGHT_PWD}       tajneheslotajneheslo
${USER_SHORT}           JT
${USER_WRONG_NAME}      radek.tester@seznam..cz

#Login
${TEXT_TitleText}       Rohlik
${SEL_HeaderLogin}      id=headerLogin
${SEL_XPATH_HeaderLogin_1}      xpath=//x-translation[contains(.,'Přihlásit')]
${SEL_XPATH_HeaderLogin_2}      xpath=//x-translation[contains(.,'Přihlásit se')]
${SEL_ID_Email}         id=email
${SEL_ID_Password}      id=password
${SEL_LoginFormEmail}   data-test=user-login-form-email
${SEL_LoginFormPwd}     data-test=user-login-form-password
${SEL_BtnSignIn}        data-test=btnSignIn
${SEL_CSS_BtnSignIn}    css=.sc-1232tqx-0
${SEL_VerifUserShort}   css=.sc-18g3ccf-6

#Logout
${SEL_HeaderUser}       xpath=//div[@id='headerUser']/div
${SEL_Logout}           xpath=//x-translation[contains(.,'Odhlásit se')]

#Error message
${ERROR_ID_ObligatoryPassword}      data-test=user-login-form-password-message
${ERROR_TEXT_ObligatoryPassword}    Heslo je povinné
${ERROR_ID_FillCorrectEmail}        data-test=user-login-form-email-message
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email

#Forgotten password
${ERROR_TEXT_ForgottenPassword}     xpath=//x-translation[contains(.,'Zapomenuté heslo?')]
${SEL_XPATH_Email}                  xpath=//input[@id='email']
${SEL_Btn}                          data-test=button