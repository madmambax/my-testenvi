*** Variables ***
#uživatel
${USER1_EMAIL}              mihadaj733@eilnews.com
${USER1_PASSWORD}           supertajnerandomheslo

#zboží
${ZBOZI01_NAME}             esp
${ZBOZI01_ID}               .product:nth-child(1)

#Strings
${TEXT_MainTitle}                   LaskaKit.cz | by Makers for Makers
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_PrihlasitSe}                 Přihlásit se
${TEXT_MujUcet}                     Můj účet

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login
${SEL_HeaderLoginTxt}      .top-nav-button-account > span
${SEL_HeaderLogin}          data-testid=signin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
${SEL_LoginFormEmail}       .email > .form-control
${SEL_LoginFormPwd}         .password > .form-control
${SEL_BtnSignIn}            .btn-secondary:nth-child(1)



#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         data-testid=searchInput
${SEL_BtnSearchGlobal}      data-testid=searchBtn

#SELEKTORY pro zboží
${SEL_BtnAdd}               data-testid=addToCart
${SEL_BtnPlus}              data-testid=increase
#Tohle nebude fungovat, je nutné dělat selektror po částech
#${SEL_BtnAddId}             css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
#${SEL_BtnPlusId}            css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]
#Je třeba použít
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap

${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_PopUpCart}            data-testid=popupCart
${SEL_CartContent}          id=cartContent
${SEL_CartReview}           id=cartReviewMainTitle
${SEL_RemoveBasket}         [aria-label^="Odstranit z košíku"]

#SELEKTORY pro Cookie
${SEL_Cookie_Accept}      data-testid=btnCookiesAccept
${SEL_Cookie_Reject}      data-testid=btnCookiesReject