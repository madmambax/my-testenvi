*** Variables ***
#user
${USER1_NAME}           hahacip784@dmonies.com
${USER1_PWD}            mojeheslo1
${USER1_SHORT}          NU

#products
${PRODUCT01_NAME}       máslo
${PRODUCT01_ID}         726539

#strings
${TEXT_Title}           Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${TEXT_EmptyCart}       Košík funguje i jako nákupní seznam
${TEXT_Prihlasit}       Přihlásit
${TEXT_MaxNumber}       maximálně 50 kusů


#selectors for login, logout
${SEL_HeaderUserIcon}   data-test=header-user-icon
${SEL_LoginEmail}       id=email
${SEL_Password}         id=password
${SEL_BtnSignIn}        data-test=btnSignIn
${SEL_LogoutBtn}        data-test=user-box-logout-button
${SEL_HeaderLogin}      id=headerLogin

#selectors for products
${SEL_SearchGlobal}     id=searchGlobal
${SEL_SearchBtn}        data-test=header-search-button

${SEL_ProductID}        data-product-id
${SEL_BtnAdd}           data-test=btnAdd
${SEL_BtnPlus}          data-test=btnPlus

#selectors for cart
${SEL_CartItem}         data-test=cart-item
${SEL_RemoveCart}       text="Vysypat košík"
${SEL_CartReview}       id=cartReviewMainTitle

#selectors for Cookie
${SEL_Cookie_AllowAll}  id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}   id=CybotCookiebotDialogBodyButtonDecline



