*** Settings ***

Library     String
Library     OperatingSystem

*** Variables ***

${no_file}      neexistuje, zkus jiny
${empty}        File Not Found
${text1}         Ukazky
${text2}         Help

*** Test Cases ***

Prvni pozitivni test

  ${result} =          run          dir C:\Windows
  Log                                Adresar obsahuje: ${text2}
  Should Contain                    ${result}     notepad.exe

  Zopakuj prikaz                    dir C:\Windows
Druhy pozitivni test

    ${result} =          Run           dir
    Log                                Vypis obsahuje:${text1}
    Should Contain                      ${result}     Ucastnici

    Zopakuj prikaz                     dir
Treti pozitivni test
    ${result} =          Run           dir
    Log                                 ${result}
    Should Contain                      ${result}     ${text1}
    Zopakuj prikaz                      dir


Prvni negativni test

      ${result} =          Run       dir nelo_dkdk_s
      Log                            Disk ${no_file}
      Should Contain                 ${result}      ${text1}
      Zopakuj prikaz                 dir nelo_dkdk_s

Druhy negativni test

        ${result} =          Run       dir Z:\Windows
        Log                             Umisteni ${no_file}
        Should Contain                  ${result}     Syst‚m nem…§e nal‚zt uvedenou cestu.
        Zopakuj prikaz                  dir Z:\Windows

Treti negativni test

        ${result} =          Run       dir Z:\Windows
        Log                            ${result}
        Should Contain                 ${result}     ${empty}
        Zopakuj prikaz                 dir Z:\Windows

*** Keywords ***

Zopakuj prikaz

        [Arguments]                 ${prikaz}
        [Documentation]             Vypise do konzole instrukce
        Log to Console              ${\n} Zopakuj prikaz ${prikaz} a pokracuj




