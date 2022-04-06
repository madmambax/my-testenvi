#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
${USER1_NAME}               jitka.malachova@gmail.com
${USER1_PASSWORD}           HesloHeslo123456
${USER1_SHORT}              Jitka Malachová



#Strings
${TEXT_MainTitle}                   Dr. Max lékárna
${TEXT_EmptyCart}                   Vysypat košík

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Chybné uživatelské jméno a nebo heslo.
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#Login
${SEL_HeaderLoginErrorTxt}  data-test-id=header-login-link-logged-in
${SEL_HeaderLogin}          id=header-login-link
${SEL_UserBoxLogoutBtn}     data-test-id=header-login-popover-logout-link
${SEL_LoginFormEmail}       id=username
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            id=submit

#Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#Goods
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_BtnMinus}             data-test=btnMinus


#Cart
${SEL_Cart}                 id=cart
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle
