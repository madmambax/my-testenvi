#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#user
${username}               radek.tester@seznam.cz
${password}               tajneheslotajneheslo
${initials}               JT

#goods
${goods}                    alpro
${product_id}               1306143

#Strings
${MainTitle}                   Online supermarket Rohlik.cz
${EmptyCart}                   Vysypat košík
${LoginText}                   Přihlásit

#Error strings
${ERROR_CorrectEmail}      Zadejte platný email
${ERROR_IncorrectEmail}   Zadal(a) jste nesprávný e-mail nebo heslo.

#SELEKTORY pro Login
${SEL_HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']
${SEL_iconUserLogin}        data-test=IconUserLogin
${SEL_HeaderUserIcon}       data-test=header-user-icon
${SEL_LogoutBtn}            data-test=user-box-logout-button
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            data-test=btnSignIn

#SELEKTORY pro Header
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_ProductID}            data-product-id

${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline