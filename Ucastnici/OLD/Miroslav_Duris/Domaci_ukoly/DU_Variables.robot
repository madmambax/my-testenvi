"""
V klíč. slovech a test casech jsem použil - tam kde to šlo a dávalo smysl - proměnný ze seznamů
a ze slovníků (místo proměnných zapsaných jako skaláry).
U seznamů asi žádný problém nebyl, slovníky jsou citlivý na uvozovky (kolem klíče by měly být, kolem hodnoty né).
U slovníků bych mohl ještě zkusit syntaxi s dvojtečkou mezi klíčem a hodnotou.
"""

*** Variables ***
# Obecné
${poz}          PozitivníTest
${neg}          NegativníTest

# URLs
# @{url}          ${url3}  ${url5}
@{url}           http://testovani.kitner.cz/login_app/       http://testovani.kitner.cz/login_app/welcome.php
# &{url}          "LoginPage"=${url3}  "assert"=${url5}
# &{url}          "1"=http://testovani.kitner.cz/login_app/      "2"=http://testovani.kitner.cz/login_app/welcome.php
${url1}         http://testovani.kitner.cz/
${url2}         login_app/
${url3}         ${url1}${url2}
${url4}         welcome.php
${url5}         ${url3}${url4}

# Identifikátory (selektory)
# @{selector}         ${selector1}  ${selector2}  ${selector3}  ${selector4}  ${selector5}  ${selector6}    ${selector7}    ${selector8}    ${selector9}   ${selector10}
@{selector}          id=inputUsername    id=inputPassword    id=butt     id=logout   id=login_form      text=Login    text=novak    xpath=/html/body/div/form/div[1]/p[1]/b    css=body > div > form > div:nth-child(1) > p:nth-child(2) > b    text=odhlásit
# &{selector}              "1"=${selector1}     "2"=${selector2}        "3"=${selector3}     "4"=${selector4}    "5"=${selector5}       "6"=${selector6}   "7"=${selector7}  "8"=${selector8}    "9"=${selector9}    "10"=${selector10}
# &{selector}         "1"="id=inputUsername"  "2"="id=inputPassword"  "3"="id=butt"       "4"="id=logout"        "5"="id=login_form"  "6"="text=Login"    "7"="text=novak"    "8"="xpath=/html/body/div/form/div[1]/p[1]/b"    "9"="css=body > div > form > div:nth-child(1) > p:nth-child(2) > b"   "10"="text=odhlásit"
${selector1}         id=inputUsername
${selector2}         id=inputPassword
${selector3}         id=butt
${selector4}         id=logout
${selector5}         id=login_form
${selector6}         text=Login
${selector7}         text=novak
${selector8}         xpath=/html/body/div/form/div[1]/p[1]/b
${selector9}         css=body > div > form > div:nth-child(1) > p:nth-child(2) > b
${selector10}        text=odhlásit
# Loginy
# @{login}            ${login1}       ${login2}       ${login3}
@{login}            novak       admin        novakova
# &{login}          "1"=${login1}  "2"=${login2}  "3"=${login3}
# &{login}           "1"=novak  "2"=admin  "3"=novakova
${login1}         novak
${login2}         admin
${login3}         novakova

# Hesla
# @{password}         ${password1}        ${password2}        ${password3}
@{password}        tajnenovak      tajneadmin     tajnyadmin
# &{password}         "1"=${password1}    "2"=${password2}  "3"=${password3}
# &{password}         "1"=tajnenovak  "2"=tajneadmin  "3"=tajnyadmin
${password1}        tajnenovak
${password2}        tajneadmin
${password3}        tajnyadmin

# Texty
# @{text}         ${text1}        ${text2}
# @{text}        odhlásit          Kombinace jmena a hesla nesouhlasi!!!
# &{text}          "1"=${text1}        "2"=${text2}
&{text}         "1"=odhlásit      "2"=Kombinace jmena a hesla nesouhlasi!!!
${text1}        odhlásit
${text2}        Kombinace jmena a hesla nesouhlasi!!!

# Nastavení sleepů
# @{sleep}            ${sleep0.5}         ${sleep1}       ${sleep2}
# @{sleep}          0.5                 1                2
# &{sleep}            "1"=${sleep0.5}  "2"=${sleep1}  "3"=${sleep2}
# &{sleep}          "1"=0.5             "2"=1        "3"=2
&{sleep}          "0.5"=0.5           "1"=1        "2"=2
${sleep0.5}        0.5
${sleep1}          1
${sleep2}          2

# Nastavení úrovně logování
# @{logLev}           ${logLevT}           ${logLevD}      ${logLevI}
# @{logLev}             trace            debug           info
# &{logLev}           "T"=${logLevT}  "D"=${logLevD}  "I"=${logLevI}
&{logLev}         "T"=trace      "D"=debug     "I"=info
${logLevT}        TRACE
${logLevD}        DEBUG
${logLevI}        INFO

# Nastavení Strict Mode
${strModeF}     False
${strModeT}     True
