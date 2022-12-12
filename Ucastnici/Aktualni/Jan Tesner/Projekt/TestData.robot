*** Variables ***
#uživatel
${USER1_NAME}               hemof56369@probdd.com
${USER1_PASSWORD}           7Csa6aZfQUbagpJ
${USER1_SHORT}              JT

#zboží
${ZBOZI01_NAME}             banán
${ZBOZI01_ID}               1349777

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_Prihlasit}                   Přihlásit

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login
${SEL_HeaderLogin}          id=headerLogin
${SEL_HeaderUserIcon}       data-test=header-user-icon
${SEL_HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            data-test=btnSignIn

#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap
${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartItem}             data-test=cart-item
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle
${SEL_RemoveBasket}         [aria-label^="Odstranit z košíku"]

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline