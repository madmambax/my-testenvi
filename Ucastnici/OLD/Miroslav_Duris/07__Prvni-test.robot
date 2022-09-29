*** Settings ***
Library  OperatingSystem

*** Test Cases ***

Prvni_test
    ${output} =  Run  help
    Log To Console  ${\n}${output}
    Should Contain  ${output}  GNU bash, verze 5.0.17(1)-release (x86_64-pc-linux-gnu)
