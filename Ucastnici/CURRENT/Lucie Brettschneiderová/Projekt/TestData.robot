*** Variables ***
#variables
${url}		                https://www.rohlik.cz/
${textLogin}                Přihlášení
${loginMail}                rohlikaccount@mail.com
${loginPass}                TestovaciHeslo
${userInitials}             KP
${userNotLoggedIn}          Přihlásit

#selectors
${SEL_UserAccount}          data-test=header-user-icon
${SEL_InputLoginMail}       data-test=user-login-form-email
${SEL_InputLoginPass}       data-test=user-login-form-password
${SEL_SignIn}               data-test=btnSignIn
${SEL_Logout}               data-test=user-box-logout-button
${SEL_MainLogo}             data-test=logo-main
${SEL_LoginMessMail}        data-test=user-login-form-email-message
${SEL_LoginMessPass}        data-test=user-login-form-password-message
${SEL_LoginNotif}           data-test=notification-content

#error messages
${errorMailReq}             Email je povinný
${errorPassReq}             Heslo je povinné
${wrongMailPass}            Zadal(a) jste nesprávný e-mail nebo heslo.