*** Settings ***
Library     OperatingSystem


*** Variables ***
${a}  10
${n}  100
${g}  200
${p}  400

*** Test Cases ***

Prvni test násobení

        ${v} =                 Evaluate               ${a} * ${n} * ${p}
        log to console                                ${V}

Druhý test násobení

        ${v} =                 Evaluate               ${g} * ${p}
        log to console                                ${v}

