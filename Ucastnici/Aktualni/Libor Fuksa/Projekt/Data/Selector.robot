# Tento soubor obsahuje selektory
# proměnná začíná vždy SEL

*** Settings ***
Resource        Item.robot


*** Variables ***
# COOKIES
${SEL_Cookie_YES}    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_NO}     id=CybotCookiebotDialogBodyButtonDecline

# PRIHLASENI
${SEL_LOGIN_NAME}       id=email
${SEL_LOGIN_PASSWORD}   id=password
${SEL_LOGIN_CONFIRM}   data-test=btnSignIn
${SEL_LOGIN_USERICON}   data-test=header-user-icon
${SEL_LOGIN_USERICON_MASTER}    data-gtm-section=user-login

# ROHLIK
${SEL_LOGGED_USER_ICON}         id=headerUser
${SEL_LOGGED_USER_LOGOUT}       data-test=user-box-logout-button
${SEL_LOGGED_CART_TOTALPRICE}   css=[data-test="headerPrice"]

# ROHLIK - SEARCH
${SEL_SEARCH_TOP}           id=searchGlobal
${SEL_SEARCH_ITEM_ADD}      css=[data-product-id="${ITEM_ZBOZI_ID}"]
${SEL_SEARCH_ITEM_MINUS}    css=[data-test="whisperer-product-wrapper"] [data-product-id="${ITEM_ZBOZI_ID}"][aria-label*="Odebrat"]
${SEL_SEARCH_ITEM_QTY}      css=[class="sc-559e95ea-0 klrptF"]
${SEL_SEARCH_ITEM_ADDMORE}  ${SEL_SEARCH_ITEM_ADD}\[aria-label*="Přidat"\]
#${SEL_SEARCH_ITEM_ADDMORE}    ${SEL_SEARCH_ITEM_ADD} [data-test="IconPlus"]

# ROHLIK - CART PAGE
${SEL_CART_MAIN_REVIEW}     id=cartReviewMainTitle
${SEL_CART_CLEAR_CART}      css=[data-gtm-button="clear-cart"]