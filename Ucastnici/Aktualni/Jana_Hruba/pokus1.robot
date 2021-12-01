*** Settings ***
Library  OperatingSystem


*** Test Cases ***

Prvni test
    ${output} =         Run                 help
    Log To Console      ${\n}${output}
    Should Contain      ${output}           For more information on a specific command, type HELP command-name