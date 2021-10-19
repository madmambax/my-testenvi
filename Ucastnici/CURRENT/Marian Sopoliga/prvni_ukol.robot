*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivní
    ${RES} =            run     help
    log                 ${RES}
    Should Contain      ${RES}  A star (*) next to a name means that the command is disabled.



Druhý test negativní
    ${RES} =            run     help ahoj
    log                 ${RES}
    Should Contain      ${RES}  help: no help topics match `ahoj'.  Try `help help' or `man -k ahoj' or `info ahoj'.