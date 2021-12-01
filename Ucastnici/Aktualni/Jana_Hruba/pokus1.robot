*** Settings ***
Library  OperatingSystem


*** Test Cases ***

Prvni test pozitívny
    ${output} =         Run                 help
    Log To Console      ${\n}${output}
    Should Contain      ${output}           For more information on a specific command, type HELP command-name

Druhý test negatívny
    ${output} =         Run                 help
    Log To Console      ${\n}${output}
    Should Contain      ${output}           For more informatioooon on a specific command, type HELP command-name