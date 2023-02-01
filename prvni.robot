*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivní
    run     help


Prvni test negativní
    run     help hello

