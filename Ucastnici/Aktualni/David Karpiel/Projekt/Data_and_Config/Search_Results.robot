*** Settings ***
Library     Browser

Resource    Selectors.robot
Resource    InputData.robot

*** Keywords ***
Check cart
    ${basket} =  Get Text    ${SEL_BASKET_ICON}
    Log To Console    ${basket}

    IF   "${basket}" == "${EMPTY}"
        Go To    ${BASE_URL.${ENVIRONMENT}}
    ELSE
        Click    ${SEL_DOWN_ARROW_IN_BASKET}
        Click    ${SEL_REMOVE_BUTTON}
        Go To    ${BASE_URL.${ENVIRONMENT}}
    END

Search products
    Fill Text      ${SEL_SEARCH_FIELD}    ${SEARCH_TERM}
    Click          ${SEL_SEARCH_BUTTON}

Click product link
    Click          id=img6243351

Verify "product" page loaded
    Get Text       id=hlOrderFast   contains    Koupit zrychleně

Click on "Koupit"
    Click          ${SEL_BUY_BUTTON}

Verify the addition of the product to the cart
    Get Text       css=[class="productInfo__texts__message"]  ==  Zboží bylo přidáno do košíku
    Click          id=varBToBasketButton
    Get Text       ${SEL_BASKET_ICON}  ==  1

Increase the number of products in the cart and verify the addition
    IF  "${BROWSER}" != "firefox"
        Click       css=[class="countPlus"]    clickCount=2
        Get Text    ${SEL_BASKET_ICON}  ==  3
    ELSE
        # Repair for firefox
        Click      css=[class="countPlus"]
        Click      css=[class="countPlus"]
        Get Text   ${SEL_BASKET_ICON}  ==  3
    END

Remove the product from the cart and verify the removal
    Click          ${SEL_DOWN_ARROW_IN_BASKET}
    Click          ${SEL_REMOVE_BUTTON}
    Get Text       ${SEL_BASKET_ICON}  ==  0
    Get Text       id=blocke  contains  Jsem tak prázdný...