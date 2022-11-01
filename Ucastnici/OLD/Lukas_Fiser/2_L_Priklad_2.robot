*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}    Hello
${NAME}     Daniel

*** Test Cases ***

Prvni test negativni
    @{seznam} =     Create List    prvni    druhy   treti
    Log Many          @{seznam}
    Log               ${seznam}
    Log To Console    @{seznam}
    # Seznam se nám do konzole nevypíše. Tato funkce u seznamu nefunguje. Vidět je to až, když si otevřeme log.

    &{slov} =        Create Dictionary    login=karel   heslo=adasda3
    Log Many                  &{slov}
    Log                       ${slov}