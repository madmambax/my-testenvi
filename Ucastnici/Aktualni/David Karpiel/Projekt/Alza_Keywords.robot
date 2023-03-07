*** Settings ***
Library     Browser

Resource    ../Projekt/Data_and_Config/Selectors.robot
Resource    ../Projekt/Data_and_Config/Landing_Page.robot
Resource    ../Projekt/Data_and_Config/Sign_In.robot
Resource    ../Projekt/Data_and_Config/Search_Results.robot

*** Keywords ***
Open website "Alza.cz"
    Landing_Page.Load page
    Landing_Page.Verify page loaded
    Landing_Page.Close cookies
    Landing_Page.Close pop-up

#LOGIN WITH VALID CREDENTIALS

Check if user is log out
    Open website "Alza.cz"
    Sign_In.Check user

Login with valid credentials
    [Arguments]     ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}
    Sign_In.Click on "Přihlásit"
    Sign_In.Verify "Přihlásit" page loaded
    Sign_In.Login    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}
    Sign_In.Verify login
    Sign_In.Logout
    Landing_Page.Close pop-up
    Sign_In.Verify logout

#==============================

#LOGIN WITH INVALID CREDENTIALS

Test multiple invalid login scenarios
    [Arguments]    ${Credentials}
    Navigate to sign in page
    Attempt login   ${Credentials}
    Verify Login Page Error Message   ${Credentials.ExpectedErrorMessage}

Navigate to sign in page
    Sign_In.Navigate to

Attempt login
    [Arguments]   ${Credentials}
    Sign_In.Enter credentials   ${Credentials}
    Sign_In.Click on "Přihlásit se"

Verify Login Page Error Message
   [Arguments]    ${ExpectedErrorMessage}
   Sign_In.Verify Login Page Error Message and close page  ${ExpectedErrorMessage}

#==============================

#SEACH FOR PRODUCT
Check if cart is empty
    Open website "Alza.cz"
    Go To    https://www.alza.cz/Order1.htm
    Search_Results.Check cart

Search for products
    Search_Results.Search products

Select product
    Search_Results.Click product link
    Search_Results.Verify "product" page loaded

Add product to cart
    Search_Results.Click on "Koupit"
    Search_Results.Verify the addition of the product to the cart

Increase product in the cart
    Search_Results.Increase the number of products in the cart and verify the addition

Remove the product from the cart
    Search_Results.Remove the product from the cart and verify the removal
    Close Browser