*** Variables ***
# Chybové hlášky

# Identifikátory (selektory)
# ${SEL_názevSelektoru}  -  u xpath a css je tov blbost..
# a míchat to s data-test a text mi taky nepřijde dobrý.
# @{SEL}                 ${SEL1}                   ${SEL2}                   ${SEL3}          ${SEL4}            ${SEL5}                ${SEL6}             ${SEL7}             ${SEL8}                                          ${SEL9}                                                                ${SEL10}
@{SEL}                   id=inputUsername          id=inputPassword          id=butt          id=logout          id=login_form          text=Login          text=novak          xpath=/html/body/div/form/div[1]/p[1]/b          css=body > div > form > div:nth-child(1) > p:nth-child(2) > b          text=odhlásit
# &{SEL}                 "1"=${SEL1}               "2"=${SEL2}               "3"=${SEL3}      "4"=${SEL4}        "5"=${SEL5}            "6"=${SEL6}         "7"=${SEL7}         "8"=${SEL8}                                      "9"=${SEL9}                                                            "10"=${SEL10}
# &{SEL}                 "1"="id=inputUsername"    "2"="id=inputPassword"    "3"="id=butt"    "4"="id=logout"    "5"="id=login_form"    "6"="text=Login"    "7"="text=novak"    "8"="xpath=/html/body/div/form/div[1]/p[1]/b"    "9"="css=body > div > form > div:nth-child(1) > p:nth-child(2) > b"    "10"="text=odhlásit"
${SEL_inputUsername}     id=inputUsername
${SEL_inputPassword}     id=inputPassword
${SEL_butt}              id=butt
${SEL_logout}            id=logout
${SEL_login_form}        id=login_form
${SEL6}                  text=Login
${SEL7}                  text=novak
${SEL8}                  xpath=/html/body/div/form/div[1]/p[1]/b
${SEL9}                  css=body > div > form > div:nth-child(1) > p:nth-child(2) > b
${SEL10}                 text=odhlásit



# Obecné
${poz}          PozitivníTest
${neg}          NegativníTest

# URLs
# @{url}            ${url3}  ${url5}
@{url}            http://testovani.kitner.cz/login_app/       http://testovani.kitner.cz/login_app/welcome.php
# &{url}            "LoginPage"=${url3}  "assert"=${url5}
# &{url}            "1"=http://testovani.kitner.cz/login_app/      "2"=http://testovani.kitner.cz/login_app/welcome.php
${url1}           http://testovani.kitner.cz/
${url2}           login_app/
${url3}           ${url1}${url2}
${url4}           welcome.php
${url5}           ${url3}${url4}
${API_url} 	      http://testovani.kitner.cz
${APP_url}        /login_app/userauth.php
${APP_API_url}    ${API_url}${APP_url}

# Loginy
# @{login}     ${login1}        ${login2}        ${login3}
@{login}     novak            admin            novakova
# &{login}     "1"=${login1}    "2"=${login2}    "3"=${login3}
# &{login}     "1"=novak        "2"=admin        "3"=novakova
${login1}    novak
${login2}    admin
${login3}    novakova

# Hesla
# @{password}         ${password1}        ${password2}        ${password3}
@{password}        tajnenovak      tajneadmin     tajnyadmin
# &{password}         "1"=${password1}    "2"=${password2}  "3"=${password3}
# &{password}         "1"=tajnenovak  "2"=tajneadmin  "3"=tajnyadmin
${password1}        tajnenovak
${password2}        tajneadmin
${password3}        tajnyadmin

# Texty
# @{text}    ${text1}        ${text2}                                      ${text3}
# @{text}    odhlásit        Kombinace jmena a hesla nesouhlasi!!!         correct
# &{text}    "1"=${text1}    "2"=${text2}                                  "3"=${text3}
&{text}      "1"=odhlásit    "2"=Kombinace jmena a hesla nesouhlasi!!!     "3"="correct"
${text1}     odhlásit
${text2}     Kombinace jmena a hesla nesouhlasi!!!
${text3}     correct

# Status Codes
&{status_code}    200=200    300=300    400=400    500=500