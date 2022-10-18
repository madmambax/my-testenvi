*** Variables ***
# Nastavení Set Browser Timeout
@{browser_timeout}    0.5    1    2

# Nastavení sleepů
# @{sleep}         ${sleep0.5}        ${sleep1}        ${sleep2}
# @{sleep}         0.5                1                2
# &{sleep}         "1"=${sleep0.5}    "2"=${sleep1}    "3"=${sleep2}
# &{sleep}         "1"=0.5            "2"=1            "3"=2
&{sleep}           "0.5"=0.5          "1"=1            "2"=2
${sleep0.5}        0.5
${sleep1}          1
${sleep2}          2

# Nastavení úrovně logování
# @{logLev}         trace             debug             info
&{logLev}           T=trace         D=debug         I=info

#Nastavení Strict Mode
${strModeF}     False
${strModeT}     True