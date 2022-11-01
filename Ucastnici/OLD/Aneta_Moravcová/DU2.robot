*** Settings ***

Library    OperatingSystem


*** Variables ***

${TEXT1}  OS Name
${TEXT2}  not recognized



*** Test Cases ***

První pozitivní test
    ${res} =           run     echo ${TEXT1}
    log                ${res}
    Should Contain     ${res}  ${TEXT1}

Druhý pozitivní test
    ${res} =            run     systeminfo
    log                 ${res}
    Should Contain      ${res}  ${TEXT1}

První negativní test
    ${res} =            run     ssteminfo
    log                 ${res}
    Should Contain      ${res}  ${TEXT2}

Druhý negativní test
    ${res} =            run     iconfig
    log                 ${res}
    Should Contain      ${res}  ${TEXT2}



*** Keywords ***

Odcitani
   [Arguments]    ${numberA}    ${numberB}
   ${res} =       Evaluate    ${numberA}-${numberB}
   [return]       ${res}

