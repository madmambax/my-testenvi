*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivni

    Create File                 C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt        Hello, world!
    File Should Exist           C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt

Druhy test pozitivni
    ${output} =        run      dir
    log             ${output}
    Should Contain  ${output}   Directory of

    File Should Not Exist       C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text1.txt

Treti test pozitivni
    ${output} =      Get File       C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt

    log              ${output}
    Should Contain   ${output}      Hello, world!

Ctvrty test pozitivni
    File Should Not Be Empty        C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt


Paty test negativni mozna
    Remove Files                C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt
    File Should Not Exist       C:\\ATesty\\jak_automatizovat_testy\\Ucastnici\\Aktualni\\Jana_Marková\\text.txt

Sesty test negativni
    ${res} =        run      dir x
    log             ${res}
    Should Contain  ${res}   File Not Found



