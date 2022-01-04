*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Library	    String
Resource    Data/TestData.robot
Resource    Config/TestConfig.robot


*** Test Cases ***
Ukázka práce s \${URL}
    Log to console  ${\n}Testujeme ${URL}!!
Spravne vsechyn udaje přihlášení (popup)
      @{psw}=    Split to lines  ${File} 
      #Log   @{psw}     #just debug
      Login (popup)   ${USER_login_correct}                      @{psw}                      ${LOGIN_user_letter}          ${LOGIN_user_letter}
Spravny mail, spatne heslo (popup)
      Login (popup)   ${USER_login_correct}                      ${randomPassw}[0]             Přihlásit    ${LOGIN_hlaska_1}   
Spravny mail, zadne heslo (popup)
      Login (popup)   ${USER_login_correct}                      ${EMPTY}	                    Přihlásit    ${LOGIN_hlaska_2}
Nesmyslny format mail, spatne heslo (popup)
     Login (popup)   ${USER_login_unreal_bez_cz}                     ${randomPassw}[1]             Přihlásit    ${LOGIN_hlaska_3}
Null mail, spatne heslo (popup)
     Login (popup)    ${EMPTY}	                                  ${randomPassw}[2]             Přihlásit    ${LOGIN_hlaska_4}
Spatny mail, spatne heslo (popup)
     Login (popup)    ${USER_login_unreal}                    ${randomPassw}[2]             Přihlásit    ${LOGIN_hlaska_5}


# Spravne vsechyn udaje a odhlaseni (Prihlaseni pres registracni btn)
#       @{psw}=    Split to lines  ${File} 
#       Login (Prihlaseni pres registracni btn)    ${USER_login_correct}         @{psw}            ${LOGIN_user_letter}         ${LOGIN_user_letter}
# Spravny mail, spatne heslo (Prihlaseni pres registracni btn)
#       Login (Prihlaseni pres registracni btn)   ${USER_login_correct}                      ${randomPassw}[0]             Přihlásit    ${LOGIN_hlaska_1}   
# Spravny mail, zadne heslo (Prihlaseni pres registracni btn)
#       Login (Prihlaseni pres registracni btn)   ${USER_login_correct}                      ${EMPTY}	                  Přihlásit    ${LOGIN_hlaska_2}
# Nesmyslny format mail, spatne heslo (Prihlaseni pres registracni btn)
#      Login (Prihlaseni pres registracni btn)   ${USER_login_unreal_bez_cz}                     ${randomPassw}[1]             Přihlásit    ${LOGIN_hlaska_3}
# Null mail, spatne heslo (Prihlaseni pres registracni btn)
#      Login (Prihlaseni pres registracni btn)    ${EMPTY}	                                ${randomPassw}[2]             Přihlásit    ${LOGIN_hlaska_4}
# Spatny mail, spatne heslo (Prihlaseni pres registracni btn)
#      Login (Prihlaseni pres registracni btn)    ${USER_login_unreal}                    ${randomPassw}[2]             Přihlásit    ${LOGIN_hlaska_5}




