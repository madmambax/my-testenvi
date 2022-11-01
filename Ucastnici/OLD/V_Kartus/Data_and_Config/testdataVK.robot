#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***

#uživatel
${SEL_USER1_NAME}               vojta.kartus@gmail.com
${SEL_USER1_PASSWORD}           mojeheslonarohlik


#zboží
${SEL_ZBOZI01_NAME}             Banán Chiquita
${SEL_ZBOZI01_ID}               1349785


#Strings
${TEXT_USER1_GoodLoginOvereni}              VK
${TEXT_USER1_BadLoginOvereni}               Přihlásit
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_DoporuceneRazeni}            text="Doporučené řazení"

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login
${SEL_HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']
${SEL_HeaderLogin}          id=headerLogin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
#${SEL_LoginFormEmail}       data-test=user-login-form-email
#${SEL_LoginFormPwd}         data-test=user-login-form-password
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            data-test=btnSignIn

#SELEKTORY pro Header
${SEL_HeaderUserIcon}       data-test=header-user-icon
${SEL_HeaderDoKosiku}       data-test=cart-redirectToCart
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      css=.sc-4b6d3da4-2.eUMBpW  #hledat na global search

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
#Tohle nebude fungovat, je nutné dělat selektror po částech
#${SEL_BtnAddId}             css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
#${SEL_BtnPlusId}            css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]
#${SEL_BtnMinusId}           css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnMinus"]
#Je třeba použít
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap

${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline