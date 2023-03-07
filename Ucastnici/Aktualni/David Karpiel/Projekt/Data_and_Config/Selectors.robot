*** Variables ***

#Login selectors
${SEL_SIGN_IN_EMAIL} =          id=loginIframe >>> id=userName
${SEL_SIGN_IN_PASSWORD} =       id=loginIframe >>> id=password
${SEL_LOGIN_BUTTON} =           id=loginIframe >>> id=loginButtonText
${SEL_EMAIL_TEXT_FIELD} =       id=loginIframe >>> id=userName
${SEL_PASSWORD_TEXT_FIELD} =    id=loginIframe >>> id=password

#Header selectors
${SEL_USER_LOGIN_BUTTON} =      id=lblLogin
${SEL_LOGOUT_ICON} =            css=[class="alzaico-l-logout"]

#Selectors for product search
${SEL_SEARCH_FIELD} =           id=edtSearch
${SEL_SEARCH_BUTTON} =          id=btnSearch

#Selectors for purchasing goods
${SEL_BUY_BUTTON} =             css=[class="btnx new green buy js-buy-button"]

#Basket selectors
${SEL_DOWN_ARROW_IN_BASKET} =   css=[class="item-options__trigger js-item-options-trigger"]
${SEL_REMOVE_BUTTON} =          css=[class="item-options__option item-options__option--del js-item-options-del"] >> nth=1
${SEL_BASKET_ICON} =            xpath=//*[@id="basketLink"]/span[2]

#Cookie selectors
${SEL_ACCEPT_COOKIE_BUTTON} =   xpath=//*[@id="rootHtml"]/body/div[7]/div/div/div[2]/a[1]
${SEL_DECLINE_COOKIE_BUTTON} =  xpath=//*[@id="rootHtml"]/body/div[7]/div/div/div[2]/a[3]
