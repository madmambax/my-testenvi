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
Spravne vsechny udaje přihlášení (popup)
      ${File}=    Get File  ${PATH_login_psw}
      @{psw}=    Split to lines  ${File} 
      Log   @{psw}     #just debug
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
    Open Browser        ${URL}                              headless=true    
    New Page            ${URL}
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
    Open Browser        ${URL}                              headless=false    
    New Page            ${URL}
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


