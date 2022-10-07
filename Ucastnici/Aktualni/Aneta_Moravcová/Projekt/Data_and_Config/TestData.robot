# Tento soubor obsahuje testovací data


*** Variables ***

# Uživatel
${USER_NAME}          bavemal543@cebaike.com
${USER_PASSWORD}      tajneheslotajneheslo
${USER_SHORT}         MS

# Zboží
#${ZBOZI_NAME}          banán
#${ZBOZI_ID}            1349777
${ZBOZI_NAME}          mléko
${ZBOZI_ID}            1320669


# Selektory pro přihlášení a odhlášení
${SEL_HeaderLoginErrorTxt}          xpath=//div[@class='u-mr--8']
${SEL_HeaderLogin}                  data-test=IconUserLogin
${SEL_LoginFormEmail}               id=email
${SEL_LoginFormPwd}                 id=password
${SEL_BtnSignIn}                    data-test=btnSignIn
${SEL_UserBoxLogoutBtn}             data-test=user-box-logout-button

# Selektory pro cookies
${SEL_Cookie_AllowAll}          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}           id=CybotCookiebotDialogBodyButtonDecline

# Selektory pro vyhledávání
${SEL_SearchGlobal}          id=searchGlobal
${SEL_BtnSearchGlobal}       text=Hledat

# Selektory pro zboží a košík
${SEL_BtnAdd}          data-test=btnAdd
${SEL_BtnPlus}         data-test=btnPlus
# ${SEL_BtnAddId}       css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
# ${SEL_BtnPlusId}      css=[data-product-id="${produkt_id}"][data-test="btnPlus"]
${SEL_BtnMinus}        data-test=btnMinus
${SEL_CartReview}      id=cartReviewMainTitle

# Texty
${TEXT_MainTitle}          Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${TEXT_EmptyCart}          Vysypat košík
${TEXT_Prihlasit}          Přihlásit

# Chybové hlášky
${ERROR_TEXT_FillCorrectEmail}          Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}       Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}                 Košík funguje i jako nákupní seznam