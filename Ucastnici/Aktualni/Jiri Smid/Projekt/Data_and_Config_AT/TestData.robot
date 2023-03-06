#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***

#Webová stránka
${SEL_LogoMain}             data-test=logo-main

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#Uživatel
${USER_NAME_OK}             sm.jiri@seznam.cz
${USER_PASSWORD_OK}         Testovani864ZdR
${USER_CHECK_OK}            JŠ
${USER_NAME_NOTOK}          smm.jjiri@seznam.cz
${USER_NAME_NOTOK2}         sm.jiri
${USER_NAME_EMPTY}
${USER_PASSWORD_NOTOK}      TezstovQani864Zd4R
${USER_PASSWORD_EMPTY}
${USER_CHECK_NOTOK}         Účet

#SELEKTORY pro Login
${SEL_HeaderUserIcon}                   data-test=header-user-icon  #nebo css=[aria-label=účet]
${SEL_LoginEmail}                       id=email
${SEL_LoginPassword}                    xpath=//*[@id="password"]
${SEL_BtnSignIn}                        data-test=btnSignIn
${SEL_UserBoxLogoutBtn}                 data-test=user-box-logout-button
${SEL_ErrorLogin}                       data-test=notification-content
${SEL_ErrorLogin_BadEmailFormat}        data-test=validation-message
${SEL_ErrorEmptyEmail}                  data-test=user-login-form-email
${SEL_ErrorEmptyPassword}               data-test=user-login-form-password

#Strings
${TEXT_MainTitle}            Online supermarket Rohlik.cz
${TEXT_Logout}               Odhlásit se
${TEXT_Ucet}                 Účet
${TEXT_LogToConsole}         Uspesny test - Prihlaseni

#Error strings
${ErrorText_LoginNotOK}          Zadal(a) jste nesprávný e-mail nebo heslo.
${ErrorText_BadEmailFormat}      Zadejte platný email
${ErrorText_EmptyEmail}          Email je povinný
${ErrorText_EmptyPassword}       Heslo je povinné



