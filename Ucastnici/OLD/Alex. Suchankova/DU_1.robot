*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivní
    create file                 test.txt        1. Test vytvoření souboru
    file should exist           test.txt
    file should not be empty    test.txt
    ${res} =                    get file        test.txt
    log file                    test.txt
    should contain              ${res}          1. Test vytvoření souboru

Druhý test negativní
    remove file             test.txt
    file should not exist   test.txt

