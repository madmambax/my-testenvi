*** Variables ***
${text1}                    Celkem za zboží
${text2}                    Váš nákupní košík je prázdný
${text3}                    Bonusy
${URL_client}               https://www.vonavazastavka.cz/klient/
${URL_trash}                https://www.vonavazastavka.cz/kosik/

#uživatel
${USER1_NAME}               lukasbaron@seznam.cz
${USER1_PASSWORD}           tajneheslo
${USER2_NAME}               neco@seznam.cz
${USER2_PASSWORD}           tajneheslo

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      data-testid=btnCookiesAccept
${SEL_Cookie_Decline}       data-testid=btnCookiesReject

#TEXTY
${TEXT_MainTitle}           Voňavá zastávka
${WRONG_LOGIN}              Neplatné přihlášení

#ARTIKLY
${ARTICLE01}                mýdlo
${ARTICLE01ID}              181
${ARTICLE01PCS}             1

#PŘIHLÁŠENÍ/ODHLÁŠENÍ
${SEL_LOGOUT}               css=[data-testid="signout"]
${SEL_LOGIN}                css=[data-testid=signin]
${SEL_EMAIL}                css=[name="email"]
${SEL_PASSWORD}             css=[name="password"]
${SEL_LOGIN_BUT}            xpath=//*[@id="formLoginIncluded"]/div[3]/div/button
${LOG_USER}                 xpath=//*[@id="content-wrapper"]/div[2]/aside/div/div/ul/li[1]/a/strong

#ZBOŽÍ
${SEL_SEARCH_ICON}          data-testid=searchIcon
${SEL_SEARCH_AREA}          data-testid=searchInput
${SEL_SEARCH_BUT}           data-testid=searchBtn
${SEL_CLOSEBOX}             id=cboxClose
${SEL_PROD_ADD}             data-testid=addToCart
${SEL_PROD_ID}              css=[data-micro-product-id=
${SEL_CONTENT}              id=content

#KOŠÍK
${SEL_REMOVE_TRASH}         .remove-item
${SEL_REMOVE}               class="removeable"
${SEL_REMOVE_ITEM}          .cart-table [data-micro-sku="${ARTICLE01ID}"]>>css=[aria-label="Snížit množství"]
${SEL_DECRASE}              css=[aria-label="Snížit množství"]
${SEL_EMPTY}                id=content-wrapper

#web
${SEL_HEAD}                 css=[class="site-name"]