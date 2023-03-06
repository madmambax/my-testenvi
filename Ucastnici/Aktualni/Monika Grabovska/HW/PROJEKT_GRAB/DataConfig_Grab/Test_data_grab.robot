*** Variables ***
################# text/data
#user credentials
${DATA_user_name}            bavemal543@cebaike.com
${DATA_user_psw}             tajneheslotajneheslo
#login verification
${DATA_login_valid}          MS
${DATA_login_invalid}        Účet

#goods
${DATA_item01}               maso
${DATA_item01_code}          1353879


#strings
${DATA_cookies}              AcceptAll

${TEXT_IncorrectPSW}       Fill in correct password.

#-----------------------------------------
############ Selectory

#Login Selectors
${sel_login_btn}              xpath=//*[@id="__next"]/div[4]/div[3]/div/div/div[2]/div/div[2]/button
${sel_user_name}              id=email
${sel_user_psw}               id=password
${sel_show_password}          data-test=IconEyeStroked
${sel_SignIn_btn}             data-test=btnSignIn
${sel_HeaderLogin}            data-test=header-user-icon

#Cookies Selectors
${sel_cookie_allow}           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${sel_cookie_decline}         id="CybotCookiebotDialogBodyButtonDecline"

#Logout Selectors
${sel_Header_user}            id=headerUser
${sel_logout_btn}             data-test=user-box-logout-button

#Cart selectors
${sel_search_field}           id=searchGlobal
${sel_search_btn}             data-test=header-search-button
${sel_cart}                   data-test=IconCart
${sel_cart_remove}            css=[data-gtm-button="clear-cart"]

#Goods selectors
${sel_btnADD}                 data-test=btnAdd
#${sel_btn_minus}              css=[data-product-id="${DATA_item01_code}"][data-test="btnAdd"]
${sel_btnPlus}                data-test=btnPlus
#${sel_btnPlus}                css=[data-product-id="1${DATA_item01_code}"][data-test="btnPlus"]
${sel_item_ID}                data-product-id
${sel_btn_minus}              data-test=btnMinus
${sel_cssForAdding}           .amountCounterWrap






