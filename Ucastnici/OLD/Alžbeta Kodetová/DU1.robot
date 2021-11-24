*** Settings ***
Library     OperatingSystem


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
    ${a} =              Set Variable    10
    ${b} =              Set Variable    5
    ${c} =              Evaluate        ${a} + ${b}
    Log To Console      ${\n}Jakou má hodnot proměnná \${c}: ${c}
    Should Be True      ${c} == 15

Čtvrtý test negativní
    ${a} =              Set Variable    10
    ${b} =              Set Variable    5
    ${c} =              Evaluate        ${a} + ${b}
    ${is string}        Evaluate        isinstance(${c},str)
    Log To Console      ${\n}Je výsledek typu řetězec? ${is string}