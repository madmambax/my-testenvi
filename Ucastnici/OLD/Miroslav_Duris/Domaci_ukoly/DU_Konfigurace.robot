*** Variables ***
#Nastavení sleepů
# @{sleep}         ${sleep0.5}        ${sleep1}        ${sleep2}
# @{sleep}         0.5                1                2
# &{sleep}         "1"=${sleep0.5}    "2"=${sleep1}    "3"=${sleep2}
# &{sleep}         "1"=0.5            "2"=1            "3"=2
&{sleep}           "0.5"=0.5          "1"=1            "2"=2
${sleep0.5}        0.5
${sleep1}          1
${sleep2}          2

#Nastavení úrovně logování
# @{logLev}         ${logLevT}        ${logLevD}        ${logLevI}
# @{logLev}         trace             debug             info
# &{logLev}         "T"=${logLevT}    "D"=${logLevD}    "I"=${logLevI}
&{logLev}           "T"=trace         "D"=debug         "I"=info
# ${logLevT}        TRACE
# ${logLevD}        DEBUG
# ${logLevI}        INFO

#Nastavení Strict Mode
${strModeF}     False
${strModeT}     True