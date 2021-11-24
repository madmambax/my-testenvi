*** Settings ***
Library     OperatingSystem

*** Test Cases ***


Pozitivní test 1
     Remove Directory                     C:\\Users\\42077\\Test
     ${res} =                   run       md C:\\Users\\42077\\Test
     log                        ${res}
     Directory Should Exist               C:\\Users\\42077\\Test


Pozitivní test 2
     ${res} =        run      md/?
     log             ${res}
     Should Contain  ${res}   MKDIR [drive:]path

Negativní test 1
    Create Directory            C:\\Users\\42077\\Test
    ${res} =        run         md C:\\Users\\42077\\Test
    log             ${res}
    Should Contain  ${res}      A subdirectory or file C:\\Users\\42077\\Test already exists.

Negativní test 2
    ${res} =                    run      md C:\\Users\\42077\\:
    Directory Should Not Exist           C:\\Users\\42077\\:
    log                         ${res}






