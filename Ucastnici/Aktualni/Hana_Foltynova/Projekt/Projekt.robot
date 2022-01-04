*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Library	    String
Resource    Data/TestData.robot
Resource    Config/TestConfig.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_po_sade
Test Setup      Pred_testem
Test Teardown   Uklid_po_testu
#Test Timeout    ${TIMEOUT_ROBOT_KW}      # Timeout pro všechny KS z RobotFW


*** Test Cases ***
Spravne vsechny udaje přihlášení (popup)
      ${File}=    Get File  ${PATH_login_psw}
      @{psw}=    Split to lines  ${File} 
      #Log   @{psw}     #just debug
      Login (popup)   ${USER_login_correct}                   @{psw}                        ${LOGIN_user_letter}       ${LOGIN_user_letter}
Spravny mail, spatne heslo (popup)
      Login (popup)   ${USER_login_correct}                   ${randomPassw}[0]             Přihlásit                  ${LOGIN_hlaska_1}   
Spravny mail, zadne heslo (popup)
      Login (popup)   ${USER_login_correct}                   ${EMPTY}	                    Přihlásit                  ${LOGIN_hlaska_2}
Nesmyslny format mail, spatne heslo (popup)
     Login (popup)   ${USER_login_unreal_bez_cz}              ${randomPassw}[1]             Přihlásit                  ${LOGIN_hlaska_3}
Null mail, spatne heslo (popup)
     Login (popup)    ${EMPTY}	                              ${randomPassw}[2]             Přihlásit                  ${LOGIN_hlaska_4}
Spatny mail, spatne heslo (popup)
     Login (popup)    ${USER_login_unreal}                    ${randomPassw}[2]             Přihlásit                  ${LOGIN_hlaska_5}


# Spravne vsechny udaje a odhlaseni (Prihlaseni pres registracni btn)
#       ${File}=    Get File  ${PATH_login_psw}
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



*** Keywords ***
Login (popup)
    [Arguments]         ${Arg_email}              ${Arg_heslo}               ${Arg_validationLogin}       ${Arg_validationHlaska}
    # Open Browser        ${URL}                              headless=true    
    # New Page            ${URL}
    Get Title           contains                            ${title_homePage}
    Click               ${SEL_IdHeaderLogin}
    Type Text           ${SEL_LoginFormMail}     ${Arg_email} 
    Type Text           ${SEL_LoginFormPsw}      ${Arg_heslo} 
    Click               ${SEL_btnSignIn}
    Get Text            body                                contains                    ${Arg_validationHlaska}
    Get Text            ${SEL_UserIcon}          ==                          ${Arg_validationLogin}
    ${log}=             Get Text                            ${SEL_UserIcon}
    Log                 ${log}
    Take Screenshot
    

Login (Prihlaseni pres registracni btn)
    [Arguments]         ${Arg_email}               ${Arg_heslo}               ${Arg_validationLogin}       ${Arg_validationHlaska}
    # Open Browser        ${URL}                              headless=false    
    # New Page            ${URL}
    Get Title           contains                            ${title_homePage}
    Click               ${SEL_IdHeaderLogin}
    Click               ${SEL_registrace}
    Click               ${SEL_registrace_prihlas} 
    Type Text           ${SEL_LoginFormMail}     ${Arg_email} 
    Type Text           ${SEL_LoginFormPsw}      ${Arg_heslo} 
    Click               ${SEL_btnSignIn}
    Get Text            body                                contains                    ${Arg_validationHlaska}
    Get Text            ${SEL_UserIcon}          ==                          ${Arg_validationLogin}
    ${log}=             Get Text                            ${SEL_UserIcon}
    Log                 ${log}
    Take Screenshot



Pred_sadou
    Log to console  ${\n}Testujeme ${URL}!!
    Log             ${\n}Testujeme ${URL}!!


Pred_testem
    ${b_timeput} =             Set Browser Timeout                 ${TIMEOUT_BROWSER}                 #20s je vhodné pro rohlik.cz
    Log                        ${b_timeput}
    Open Browser        ${URL}                                     headless=${HEADLESS_BROWSER}    #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    # je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                    ${URL}

Uklid_po_testu
    Log to console   ${\n}Uklid na konci každho testu.  #just debug
    Log              ${\n}Uklid na konci každho testu.  #just debug
    Close Browser


Uklid_po_sade
    Close Browser
