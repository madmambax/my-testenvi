*** Settings ***
Library  Browser

*** Test Cases ***

Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://www.saucedemo.com/
   Get Title      ==    Swag Labs

#element: Chceme identifikovat element z saucedemo.com
# Zde je uveden:
#  <input class="input_error form_input" placeholder="Username"
#       type="text" data-test="username" id="user-name" name="user-name"
#       autocorrect="off" autocapitalize="none" value="">

    Set Strict Mode    off
### CSS selektory ###
#identifikace pole pro zadání uživatelského jména

    Type Text     css=#user-name                     standard_user
    Type Text     css=\#user-name                    standard_user
    Type Text     css=input#user-name                standard_user   # výběr pomocí typu elementu (span) a id (headerLogin)
    Type Text     css=[name="user-name"]             standard_user   # výběr pomocí CSS atributu
    Type Text     css=[data-test="username"]         standard_user   # výběr pomocí CSS atributu

    # Níže popsané 3 způsoby jednou jen pokud je vyplý strict mode a vybere 1. ze dvou variant
    Type Text     css=.form_input                   standard_user   # výběr pomocí 1 class
    Type Text     css=.input_error.form_input       standard_user   # výběr pomocí 2 class, nesmí mezi něma být mezera
    Type Text     css=[class="input_error form_input"]   standard_user   #výběr pomocí 2 class formou css atributu

    # vyběr pomocí více elemntů (zanoření)
    Type Text     css=.login-box >> #user-name      standard_user

    Take Screenshot



### XPATH selektory ###
#heslo

   Type Text     xpath=//*[@id="password"]                     nevim_co

   Take Screenshot



### ID selektory ###

   Click  id=login-button

   Take Screenshot


## TEXT selektory ###
   ${text} =    Get Text  text="Password for all users:"
   Log          ${text}

   Take Screenshot

### "data-test" selektory ###
#uspěšné přihlášení

   Type Text   data-test=username   standard_user
   Type Text   data-test=password   secret_sauce
   Click       data-test=login-button
   Get Text    text="Products"  ==  PRODUCTS

   Take Screenshot









