*** Settings ***
Resource          Data_and_Config/Selectors.robot
Resource          Alza_Keywords.robot
Resource          Data_and_Config/Common.robot
Resource          Data_and_Config/InputData.robot

Suite Setup       Common.Begin web test
Suite Teardown    Common.End web test

# robot '.\Ucastnici\Aktualni\David Karpiel\Projekt\Alza.robot'

*** Test Cases ***
The website "Alza.cz" and login window should load
    [Tags]   Test_1
    Alza_Keywords.Open website "Alza.cz"

User should be able to login and logout (positive test)
    [Tags]  Test_2
    [Setup]  Alza_Keywords.Check if user is log out
    Alza_Keywords.Login with valid credentials    ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}

User can search and add products to the cart
    [Tags]  Test_3
    [Setup]  Alza_Keywords.Check if cart is empty
    Alza_Keywords.Search for products
    Alza_Keywords.Select product
    Alza_Keywords.Add product to cart
    Alza_Keywords.Increase product in the cart
    Alza_Keywords.Remove the product from the cart

User shouls see correct error messages with invalid logins (negative test)
     [Tags]  Test_4
     [Template]  Test multiple invalid login scenarios
     [Setup]   Common.Begin web test
     ${INVALID_LOGIN}
     ${INVALID_EMAIL}
     ${INVALID_PASSWORD}
     ${BLANK_FIELDS}