#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatel temp
${USER1_NAME}               riyap56604@orlydns.com
${USER1_PASSWORD}           b..d[e]1(/TWKgi
${USER1_WRONG_PASS}         spatne_heslo1345
${USER1_SHORT}              HK

#uživatel radek kitner
${USER2_NAME}               radek.tester@seznam.cz
${USER2_PASSWORD}           tajneheslotajneheslo
${USER2_SHORT}              JT

#zboží
${ZBOZI01_NAME}             penne
${ZBOZI01_NUMBER}           5
${ZBOZI01_ID}               1320669

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_Prihlasit}                   Přihlásit

#Error strings
#${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
#${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
#${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login a Logout
${SEL_HeaderLoginIcon}      xpath=//div[@class='u-mr--8']
${SEL_HeaderLoginIconText}  data-test=header-user-icon
${SEL_HeaderLogin}          id=headerLogin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
#${SEL_LoginFormEmail}       data-test=user-login-form-email
#${SEL_LoginFormPwd}         data-test=user-login-form-password
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            data-test=btnSignIn
${SEL_BtnLogOut}            data-test=user-box-logout-button

#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text="Hledat"

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
#Tohle nebude fungovat, je nutné dělat selektror po částech
#${SEL_BtnAddId}             css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
#${SEL_BtnPlusId}            css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]
#Je třeba použít
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap

${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle
${SEL_RemoveBasket}         [aria-label^="Odstranit z košíku"]

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline