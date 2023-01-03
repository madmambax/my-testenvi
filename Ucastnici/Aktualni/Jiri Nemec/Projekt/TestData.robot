#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatel
${USER1_NAME}               manod33170@teknowa.com
${USER1_PASSWORD}           3jgRYyfUYxUeENL
${USER1_SHORT}              T9

${USER_BAD_NAME}               fsdfdssd@sdas.cz
${USER_BAD_PASSWORD}           tytryrt
${USER_BAD_SHORT}              Přihlásit


#zboží
${ZBOZI01_NAME}             Banán Chiquita
${ZBOZI01_ID}               1349785

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_Prihlasit}                   Přihlásit

#Error strings
${ERROR_TEXT_MaxPieces}     Do košíku můžete přidat maximálně 50 kusů tohoto produktu

#SELEKTORY pro Login
${SEL_HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']
${SEL_HeaderLogin}          id=headerLogin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
${SEL_LoginFormEmail}       id=email
${SEL_LoginFormPwd}         id=password
${SEL_BtnSignIn}            data-test=btnSignIn
${SEL_UserShortIcon}        data-test=header-user-icon

#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnPlus}              data-test=btnPlus
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap
${SEL_SearchButton}         data-test=header-search-button
${SEL_BtnMinusPrefix}       [data-test="btnMinus"][data-product-id="
${SEL_CartBtnSufix}         "]
${SEL_CartAddPiecePrefix}   \#cart [data-product-id="
${SEL_CartAddPiecePostfix}  "][data-gtm-button="addPiece"]
${SEL_CartWhisperer}        \#whisperer
${SEL_CartWhispererAddPiecePrefix}  ${SEL_CartWhisperer} [data-product-id="
${SEL_CartWhispererAddPieceSuffix}  "][data-test="btnAdd"]
${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartItem}             data-test=cart-item
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle
${SEL_RemoveBasket}         [aria-label^="Odstranit z košíku"]
${SEL_ERROR_TOOLTIP}        [data-test="error-tooltip"]

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline


