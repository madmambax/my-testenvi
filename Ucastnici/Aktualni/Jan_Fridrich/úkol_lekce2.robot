*** Settings ***
Library  OperatingSystem

***Variables***
#variables for first two positive tests

${COMMAND_FirstTestPos}         CD
${Text_FirstTestPos}            Displays the name of or changes the current directory.
${COMMAND_SecondTestPos}        DATE
${Text_SecondTestPos}           Displays or sets the date.

##variables for two negative tests

${COMMAND_FirstTestNeg}         ls
${Text_FirstTestNeg}            This command is not supported by the help utility.  Try "ls /?".
${COMMAND_SecondTestPNeg}       checkout
${Text_SecondTestPNeg}          This command is not supported by the help utility.  Try "checkout /?".

*** Test Cases ***
1.pozitivní test
    1.pozitivní test

2.pozitivní test
    ${SecondTest}=   run     help ${COMMAND_SecondTestPos}

    log     ${SecondTest}

    Should Contain  ${SecondTest}     ${Text_SecondTestPos}

1.negativni test
    ${FirstTestNeg}=   run     help ${COMMAND_FirstTestNeg}

    log     ${FirstTestNeg}

    Should Contain  ${FirstTestNeg}     ${Text_FirstTestNeg}

2.negativni test
    ${SecondTestNeg}=   run     help ${COMMAND_SecondTestPNeg}

    log     ${SecondTestNeg}

    Should Contain  ${SecondTestNeg}     ${Text_SecondTestPNeg}

*** Keywords ***
1.pozitivní test
    ${FirstTest}=   run     help ${COMMAND_FirstTestPos}

    log     ${FirstTest}

    Should Contain  ${FirstTest}    ${Text_FirstTestPos}