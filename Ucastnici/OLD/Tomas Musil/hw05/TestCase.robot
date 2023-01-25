*** Settings ***
Library  Browser
Resource  Configuration.robot
Resource  TestData.robot
Resource  Keywords.robot
Test Setup  Open site
Test Teardown  Cleanup


*** Test Cases ***

Login Successful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Check logged in

Login Unsuccessful
    Login          test.test@test.test  password
    Check logged out

Logout Successful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Sleep          1
    Logout
    Check logged out

Logout Unsuccessful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Click          ${SEL_HeaderLogo}
    Check logged in

Add item to cart Successful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Search         ${ZBOZI01_NAME}
    Sleep          1
    Add item to cart  ${ZBOZI01_ID}
    Sleep          1
    Check item in cart  ${ZBOZI01_NAME}

Add item to cart Unsuccessful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Search         test
    Sleep          1
    Click          ${SEL_HeaderLogo}
    Sleep          1
    Check item not in cart  test

Remove item from cart Successful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Add item to cart  ${ZBOZI01_ID}
    Sleep          1
    Check item in cart  ${ZBOZI01_NAME}
    Sleep          1
    Remove item from cart
    Sleep          1
    Check item not in cart  ${ZBOZI01_NAME}

Remove item from cart Unsuccessful
    Login          ${USER1_NAME}  ${USER1_PASSWORD}
    Add item to cart  ${ZBOZI01_ID}
    Sleep          1
    Check item in cart  ${ZBOZI01_NAME}
    Sleep          1
    Click          ${SEL_HeaderLogo}
    Sleep          1
    Check item in cart  ${ZBOZI01_NAME}