*** Settings ***
Library     Browser
Resource    ../Data_and_Config/Configuration.robot
Resource    ../Data_and_Config/TestData.robot
Resource    ../Data_and_Config/Keywords.robot

Test Setup      Before_test
Test Teardown    After_test



*** Test Cases ***

Přihlášení a odhlasení
    LogIn   ${email}  ${passw}  ${valid}
    LogOut  Přihlásit

Add to cart - pokus se koupit přes 50 másel
    Login                   ${email}  ${passw}  ${valid}
    Add to the cart         máslo           726539      52
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit

Add to cart - pridat do kosiku 10 masel
    Login                   ${email}  ${passw}  ${valid}
    Add to the cart         máslo           726539      10
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit