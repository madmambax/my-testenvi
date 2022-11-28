*** Comments ***
testovano na macOS

*** Settings ***
Library     OperatingSystem

*** Variables ***
${ROBOT_FIRST_LINE}           A generic automation framework
${MAN_ERROR_FIRST_LINE}       No manual entry for

*** Keywords ***
VypisKontrolni
    [Arguments]       ${out}
    Log To Console    kontrolni text: ${out}${\n}

VypisVystupu
    [Arguments]       ${out}
    Log To Console    vystup: ${out}${\n}

Rekurze
    [Arguments]       ${maximum}  ${aktualni}
    IF  ${maximum} > ${aktualni}
        ${aktualni} =  Evaluate    ${aktualni}+1
        Rekurze    ${maximum}  ${aktualni}
    END

*** Test Cases ***

Test zda funguje rekurze
    Rekurze  32  0
    Log      ${\n}
    # fungovalo maximalne 32 zanoření

Pozitivni test #1
    ${output_text} =    run     robot --help | head -n 10
    VypisKontrolni      ${ROBOT_FIRST_LINE}
    VypisVystupu        ${output_text}
    Should Contain      ${output_text}  ${ROBOT_FIRST_LINE}

Pozitivni test #2
    ${rc} =         Run And Return Rc  true
    Log To Console  ${rc}
    Should Be Equal As Integers  ${rc}  0

Negativni test #1
    ${res} =        run     man 42
    Log             ${res}
    VypisKontrolni  ${MAN_ERROR_FIRST_LINE}
    Should Contain  ${res}  ${MAN_ERROR_FIRST_LINE}


Negativni test #2
    ${rc} =        Run And Return Rc  cat /Applications/Neexistujici_aplikace
    Should Not Be Equal As Integers  ${rc}  0
    Log             ${rc}

