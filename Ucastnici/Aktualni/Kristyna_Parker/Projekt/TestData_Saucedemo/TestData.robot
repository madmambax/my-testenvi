
# Data pro projekt Sauce Demo

*** Variables ***

#uživatel
${USER_NAME_CORRECT}                        standard_user
${USER_PASSWORD_CORRECT}                    secret_sauce
${USER_CHECK}                               ADD TO CART
${USER_NOTCORRECT}                          stan_user
${USER_PASSWORD_NOTCORRECT}                 secret_sausage

#Strings
${TEXT_LOGINCHECK}                          Add to cart
${TEXT_LOGIN}                               Login
${TEXT_REMOVE_CART}                         Remove
${TEXT_APP_RESET}                           Reset App State
${TEXT_LOGOUT}                              Logout


#Zboží
${ITEM_NAME}                               Sauce Labs Backpack
${ITEM_NUMBER}                             4

#Selektory pro login
${SEL_USER_FIELD}                           xpath=//*[@id="user-name"]
${SEL_USERNAME}                             id=user-name
${SEL_PASSW_FIELD}                          data-test=password
${SEL_USERPASSW}                            id=password
${SEL_LOGIN_BTN}                            xpath=//*[@id="login-button"]
${SEL_LOGINCHECK}                           id=add-to-cart-sauce-labs-backpack

#Selektory pro zboží
${ITEM_CHOSEN}                              id=item_4_title_link
${ITEM_ADDTOCART}                           id=add-to-cart-sauce-labs-backpack

#Selektory pro košík
${CART}                                     id=shopping_cart_container
${ITEM_REMOVE}                             id=remove-sauce-labs-backpack

#Selektory Reset
${SEL_MENU_BTN}                             xpath=//*[@id="react-burger-menu-btn"]
${SEL_RESET_BTN}                            xpath=//*[@id="reset_sidebar_link"]

#Selektory logout
${SEL_LOGOUT_BTN}                           id=logout_sidebar_link

