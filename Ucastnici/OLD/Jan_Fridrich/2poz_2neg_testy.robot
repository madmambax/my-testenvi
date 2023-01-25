*** Settings ***
Library  OperatingSystem

*** Test Cases ***
1.pozitivní test
    ${FirstTest}=   run     help CD

    log     ${FirstTest}

    Should Contain  ${FirstTest}    Displays the name of or changes the current directory.

2.pozitivní test
    ${SecondTest}=   run     help DATE

    log     ${SecondTest}

    Should Contain  ${SecondTest}     Displays or sets the date.

1.negativni test
    ${FirstTestNeg}=   run     help ls

    log     ${FirstTestNeg}

    Should Contain  ${FirstTestNeg}     This command is not supported by the help utility.  Try "ls /?".

2.negativni test
    ${SecondTestNeg}=   run     help checkout

    log     ${SecondTestNeg}

    Should Contain  ${SecondTestNeg}     This command is not supported by the help utility.  Try "checkout /?".
