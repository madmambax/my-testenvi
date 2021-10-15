*** Settings ***
Library     OperatingSystem

*** Variables ***

${A}=             10
${B}=             5


*** Test Cases ***


Prvni test pozitivní
    ${knihovny_pip} =   Run     pip list
    Log                 ${knihovny_pip}
    Log To Console      ${knihovny_pip}
    Should Contain      ${knihovny_pip}  selenium


Druhy test negativni
    ${knihovny_pip} =   Run     pip show selenium
    Log                 ${knihovny_pip}
    Log To Console      ${knihovny_pip}
    Should Not Contain  ${knihovny_pip}  price

Treti test pozitivni
    ${c} =              Soucet  ${A}    ${B}
    Log Many            ${A}    ${B}    ${c}
    Log To Console      ${\n}Proměnná \${A} a \${B}: ${A} a ${B} ${\n}A jejch součet, tedy proměnná \${c}: ${c}
    Should Be True      ${c} == 15

Čtvrtý test negativní
    ${c} =              Soucet  ${A}    ${B}
    ${is string}        Evaluate        isinstance(${c},str)
    Log To Console      ${\n}Je výsledek typu řetězec? ${is string}

*** Keywords ***
 Soucet
   [Documentation]  Součet globální proměnné A a B
   [Arguments]      ${z}        ${y}
   ${x} =           Evaluate        ${y} + ${z}
   [Return]         ${x}

