*** Settings ***
Library     OperatingSystem

*** Variables ***
${Greet}    Hello
${Name}     Daniel

*** Test Cases ***

Prvni test
    @{seznam} =      Create List    prvni   druhy   treti
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[0]
    Log to Console            ${seznam}[1]
    Log to Console            ${seznam}[2]

*** Test Cases ***

Druhy test
    &{slov} =        Create Dictionary    login=karel   heslo=adasda3
    Log Many                  &{slov}
    Log                       ${slov}
