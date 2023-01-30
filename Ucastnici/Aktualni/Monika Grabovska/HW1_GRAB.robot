*** Settings ***
Library   OperatingSystem

*** Test Cases ***

Prvni pozitivni test

  ${result} =          run       dir C:\Windows
  Log                  ${result}

  Should Contain       ${result}     notepad.exe
Druhy pozitivni test

    ${result} =          Run           dir
    Log                  ${result}

    Should Contain       ${result}     Ucastnici


Prvni negativni test

      ${result} =          Run       dir nelo_dkdk_s
      Log To Console     ${result}

      Should Contain       ${result}     File Not Found


Druhy negativni test

        ${result} =          Run       dir Z:\Windows
        Log                  ${result}

        Should Contain       ${result}     File Not Found