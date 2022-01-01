#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
${USER1_NAME}               stribrna.hana@gmail.com
${USER1_PASSWORD}           zkusebniheslo
${USER1_SHORT}              HS



#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_EmptyCart}                   Vysypat košík

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte... - dopsat
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#Login
${SEL_HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']
${SEL_HeaderLogin}          id=headerLogin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
${SEL_LoginFormEmail}       data-test=user-login-form-email
${SEL_LoginFormPwd}         data-test=user-login-form-password
${SEL_BtnSignIn}            data-test=btnSignIn

#Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat
${SEL_HeaderUser}           id=headerUser


#Goods
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_BtnMinus}             data-test=btnMinus


#Cart
${SEL_Cart}                 id=cart
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle


${timeout_browser}          60

