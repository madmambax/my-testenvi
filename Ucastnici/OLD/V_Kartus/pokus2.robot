*** Variables ***
${GREET}    Hello
${NAME}     World!

*** Test Cases ***
Prvni test
    log              ${greet} ${name}
    Log To Console   ${greet} ${name}

#set variable uloží do promenne hodnotu
Druhy test
    ${cislo} =  Set Variable    10
    ${des} =  Set Variable    10.32
    ${str} =  Set Variable    ahoj
    Log To Console   ${cislo}
    Log To Console   ${des}
    Log To Console   ${str}

#evaluate spočítá a uloží do promenne hodnotu
Treti test
    ${p} =      Evaluate    20
    ${v} =      Evaluate    10 * 2
    ${v_p} =    Evaluate  ${v} + ${p}
    log to console  výsledek: ${v_p}

#seznam, @ /pozice polozek = [0,1,2]
Ctvrty test
    @{seznam} =  Create List  prvni  druhy  treti
    Log Many        @{seznam}
    Log             ${seznam}
#   Log To Console  @{seznam}  --nelze
    Log To Console  ${seznam}[1]

#slovnik, &
Paty test
    &{slovnik} =  Create Dictionary  login=karel heslo=Ad123789
    Log many        &{slovnik}
    Log             ${slovnik}

#ukazku *** Keywords ***
#Sesty test
#   Ukazka KS   praha  brno  ostrava

*** Keywords ***
    [Arguments]      ${parametr1}   ${parametr2}  ${parametr3}
    @{seznam} =      Create List    ${parametr1}   ${parametr2}   ${parametr3}
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[1]

